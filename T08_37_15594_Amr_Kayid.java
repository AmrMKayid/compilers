import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/***
 * Author: Amr Kayid
 * ID: 37-15594
 * Tut: T08
 * T08_37_15594_Amr_Kayid
 */

public class T08_37_15594_Amr_Kayid {
	public static void main(String[] args) {
		String input = "S,ScT,T;T,aSb,iaLb,e;L,SdL,S";
		CFG cfg = new CFG(input);
		System.out.println(cfg);
		String firstEncoding = cfg.First();
		String followEncoding = cfg.Follow();
		System.out.println("First: " + firstEncoding);
		System.out.println("Follow: " + followEncoding);
	}

	/***
	 * For this task you will implement the algorithms computing the functions First and Follow,
	 * introduced in Lecture 4 of CSEN1003, for the variables of a given context-free grammar.
	 */

	static class CFG {
		/**
		 * Recall that a CFG is a quadruple (V, Σ, R, S)
		 * where V and Σ are disjoint alphabets (respectively, containing variables and terminals),
		 * R ⊆ V × (V ∪ Σ)∗ is a set of rules,
		 * and S ∈ V is the start variable.
		 * >>> Input Example:
		 * "S,ScT,T;T,aSb,iaLb,e;L,SdL,S"
		 */

		public String start = "S";
		public Set<String> vars = new HashSet<>();
		public Set<String> terminals = new HashSet<>();
		public Map<String, ArrayList<String>> rules = new LinkedHashMap<>();

		public Map<String, Set<String>> first = new LinkedHashMap<>();
		public Map<String, Set<String>> follow = new LinkedHashMap<>();
		public Set<String> eps = new HashSet<>(Collections.emptyList());

		public CFG(String input) {
			input.chars().filter(c -> Character.isUpperCase(c)).forEach(v -> vars.add((char) v + ""));
			input.chars().filter(c -> Character.isLowerCase(c)).forEach(t -> terminals.add((char) t + ""));

			terminals.remove("e");

			String[] r = input.split(";");
			for (String rule : r) {
				String[] split = rule.split(",");
				rules.put(split[0], new ArrayList(Arrays.asList(Arrays.copyOfRange(split, 1, split.length))));
			}
			rules.entrySet().forEach(stringArrayListEntry -> {
				if (stringArrayListEntry.getValue().contains("e")) {
					stringArrayListEntry.getValue().add("");
					stringArrayListEntry.getValue().remove("e");
				}
			});


			ComputeFirstFollow(this);
		}

		public static void ComputeFirstFollow(CFG g) {
			Map<String, Set<String>> first = new LinkedHashMap<>();
			g.vars.forEach(v -> first.put(v, new HashSet<>(Collections.emptyList())));
			g.terminals.forEach(t -> first.put(t, new HashSet<>(Collections.singletonList(t))));

			Map<String, Set<String>> follow = new LinkedHashMap<>();
			g.vars.forEach(v -> follow.put(v, new HashSet<>(Collections.emptyList())));

			Set<String> EPSILON = new HashSet<>(Collections.emptyList());

			boolean updated;
			while (true) {
				updated = false;

				for (Map.Entry<String, ArrayList<String>> entry : g.rules.entrySet()) {
					String nt = entry.getKey();
					for (String expression : entry.getValue()) {

						// first
						for (char symbol : expression.toCharArray()) {
							updated |= union(first.get(nt), first.get(symbol + ""));
							if (!EPSILON.contains(symbol + ""))
								break;
						}
						updated |= union(EPSILON, new HashSet<>(Collections.singleton(nt)));

						// follow
						Set<String> aux = follow.get(nt);
						for (Character symbol : new StringBuilder(expression).reverse().toString().toCharArray()) {
							if (follow.containsKey(symbol + "")) {
								updated |= union(follow.get(symbol + ""), aux);
							}
							if (EPSILON.contains(symbol + "")) {
								aux = Stream.concat(aux.stream(), first.get(symbol + "").stream())
										.collect(Collectors.toSet());
							} else {
								aux = first.get(symbol + "");
							}
						}
					}
				}

				if (!updated) {
					g.first = first;
					g.follow = follow;
					g.eps = EPSILON;
					return;
				}
			}

		}

		public static boolean union(Set<String> first, Set<String> begins) {
			int n = first.size();
			first.addAll(begins);

			return first.size() != n;
		}

		public String First() {
			String output = "";
			eps.forEach(v -> {
				first.get(v).add("e");
			});
			return getString(output, first);
		}

		public String Follow() {
			String output = "";
			follow.get(start).add("$");
			rules.get(start).forEach(s -> {
				for (char symbol : s.toCharArray()) {
					if (vars.contains(symbol + ""))
						follow.get(symbol + "").add("$");
				}
			});
			return getString(output, follow);
		}

		private String getString(String output, Map<String, Set<String>> string) {
			output += start + "," + String.join("", string.get(start)) + ";";
			for (Map.Entry<String, Set<String>> entry : string.entrySet()) {
				String key = entry.getKey();
				if (vars.contains(key) && !key.equals(start)) {
					String value = String.join("", entry.getValue());
					if (value.contains("$")) {
						value = value.replace("$", "");
						value += "$";
					}
					output += key + "," + value + ";";
				}
			}
			return output.substring(0, output.length() - 1);
		}

		@Override
		public String toString() {
			return "CFG{" +
					"start='" + start + '\'' +
					", vars=" + vars +
					", terminals=" + terminals +
					", rules=" + rules +
					", first=" + first +
					", follow=" + follow +
					", eps=" + eps +
					'}';
		}
	}
}

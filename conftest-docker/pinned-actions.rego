package main

deny[msg] {
  jobs := input["jobs"][_]["steps"][_]["uses"]

  not re_match("@.*", jobs)

  msg := "Upstream workflows must have pinned version"
}

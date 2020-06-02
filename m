Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFFFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A60206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591098675;
	bh=DSWn4lB14p+KlKyDN1Wbi+NSPq8Ac1Dv66eUYLMsP28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bsJh+RAFJGUfBQQyenQAvOxF+pQkDQO8TEjHTWD5FALr8nIzMktF3kTXmxwzDd/2r
	 mx4Jq+OY/Aeri6sLA74pbYhqE8Tyyd0baPQc5j+bZyB7B586nHvH5NW48185NeHvqP
	 t7vaO5XuECktG3gBwnDiuwUtIgN4ZHEMzmKpkYmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBLvO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:51:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbgFBLvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:51:12 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-kAleCsonMMqW07-mLtHzVg-1; Tue, 02 Jun 2020 07:51:06 -0400
X-MC-Unique: kAleCsonMMqW07-mLtHzVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE0BB1800D42;
        Tue,  2 Jun 2020 11:51:04 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45CDD10013D7;
        Tue,  2 Jun 2020 11:51:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 02/13] perf tools: Add fake_pmu bool to parse_events interface
Date:   Tue,  2 Jun 2020 13:50:44 +0200
Message-Id: <20200602115055.1168446-3-jolsa@kernel.org>
In-Reply-To: <20200602115055.1168446-1-jolsa@kernel.org>
References: <20200602115055.1168446-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding fake_pmu bool argument parse_events interface to
parse events and use fake pmu event in case pmu event
is parsed.

This way it's possible to parse events from PMUs which
are not present in the system. It's available only for
testing purposes coming in following changes, so all
the current users set fake_pmu argument as false.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/arm/util/cs-etm.c            |  2 +-
 tools/perf/arch/powerpc/util/kvm-stat.c      |  2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/arch/x86/util/intel-bts.c         |  2 +-
 tools/perf/arch/x86/util/intel-pt.c          |  6 +++---
 tools/perf/builtin-stat.c                    |  8 ++++----
 tools/perf/builtin-trace.c                   |  4 ++--
 tools/perf/tests/backward-ring-buffer.c      |  3 ++-
 tools/perf/tests/code-reading.c              |  2 +-
 tools/perf/tests/event-times.c               |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c      |  4 ++--
 tools/perf/tests/hists_cumulate.c            |  2 +-
 tools/perf/tests/hists_filter.c              |  4 ++--
 tools/perf/tests/hists_link.c                |  4 ++--
 tools/perf/tests/hists_output.c              |  2 +-
 tools/perf/tests/keep-tracking.c             |  4 ++--
 tools/perf/tests/parse-events.c              |  2 +-
 tools/perf/tests/pmu-events.c                |  2 +-
 tools/perf/tests/switch-tracking.c           |  8 ++++----
 tools/perf/util/bpf-loader.c                 |  2 +-
 tools/perf/util/metricgroup.c                |  2 +-
 tools/perf/util/parse-events.c               | 15 ++++++++-------
 tools/perf/util/parse-events.h               |  2 +-
 tools/perf/util/perf_api_probe.c             |  2 +-
 tools/perf/util/record.c                     |  2 +-
 25 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index cea5e33d61d2..c99a6528f45c 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -415,7 +415,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (opts->full_auxtrace) {
 		struct evsel *tracking_evsel;
 
-		err = parse_events(evlist, "dummy:u", NULL);
+		err = parse_events(evlist, "dummy:u", NULL, false);
 		if (err)
 			goto out;
 
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index eed9e5a42935..396f6bff44db 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -114,7 +114,7 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
 	int ret;
 
 	bzero(&err, sizeof(err));
-	ret = parse_events(evlist, str, &err);
+	ret = parse_events(evlist, str, &err, false);
 	if (err.str)
 		parse_events_print_error(&err, "tracepoint");
 	return ret;
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 026d32ed078e..3d821e07119e 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -80,7 +80,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_events(evlist, "cycles:u", NULL));
+	CHECK__(parse_events(evlist, "cycles:u", NULL, false));
 
 	perf_evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index 0dc09b5809c1..2ac433fd542b 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -232,7 +232,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 		struct evsel *tracking_evsel;
 		int err;
 
-		err = parse_events(evlist, "dummy:u", NULL);
+		err = parse_events(evlist, "dummy:u", NULL, false);
 		if (err)
 			return err;
 
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 839ef52c1ac2..160fa9b135b4 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -419,7 +419,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
 	if (!perf_evlist__can_select_event(evlist, sched_switch))
 		return -EPERM;
 
-	err = parse_events(evlist, sched_switch, NULL);
+	err = parse_events(evlist, sched_switch, NULL, false);
 	if (err) {
 		pr_debug2("%s: failed to parse %s, error %d\n",
 			  __func__, sched_switch, err);
@@ -796,7 +796,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			if (!cpu_wide && perf_can_record_cpu_wide()) {
 				struct evsel *switch_evsel;
 
-				err = parse_events(evlist, "dummy:u", NULL);
+				err = parse_events(evlist, "dummy:u", NULL, false);
 				if (err)
 					return err;
 
@@ -854,7 +854,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	if (opts->full_auxtrace) {
 		struct evsel *tracking_evsel;
 
-		err = parse_events(evlist, "dummy:u", NULL);
+		err = parse_events(evlist, "dummy:u", NULL, false);
 		if (err)
 			return err;
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2b79aa161dd..8a0c470dd92b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1533,11 +1533,11 @@ static int add_default_attributes(void)
 		if (pmu_have_event("cpu", "cycles-ct") &&
 		    pmu_have_event("cpu", "el-start"))
 			err = parse_events(evsel_list, transaction_attrs,
-					   &errinfo);
+					   &errinfo, false);
 		else
 			err = parse_events(evsel_list,
 					   transaction_limited_attrs,
-					   &errinfo);
+					   &errinfo, false);
 		if (err) {
 			fprintf(stderr, "Cannot set up transaction events\n");
 			parse_events_print_error(&errinfo, transaction_attrs);
@@ -1566,7 +1566,7 @@ static int add_default_attributes(void)
 		    pmu_have_event("msr", "smi")) {
 			if (!force_metric_only)
 				stat_config.metric_only = true;
-			err = parse_events(evsel_list, smi_cost_attrs, &errinfo);
+			err = parse_events(evsel_list, smi_cost_attrs, &errinfo, false);
 		} else {
 			fprintf(stderr, "To measure SMI cost, it needs "
 				"msr/aperf/, msr/smi/ and cpu/cycles/ support\n");
@@ -1606,7 +1606,7 @@ static int add_default_attributes(void)
 		if (topdown_attrs[0] && str) {
 			if (warn)
 				arch_topdown_group_warn();
-			err = parse_events(evsel_list, str, &errinfo);
+			err = parse_events(evsel_list, str, &errinfo, false);
 			if (err) {
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4cbb64edc998..47585e785f7e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3044,7 +3044,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 	int ret;
 
 	bzero(&err, sizeof(err));
-	ret = parse_events(evlist, "probe:vfs_getname*", &err);
+	ret = parse_events(evlist, "probe:vfs_getname*", &err, false);
 	if (ret) {
 		free(err.str);
 		free(err.help);
@@ -4879,7 +4879,7 @@ int cmd_trace(int argc, const char **argv)
 		struct parse_events_error parse_err;
 
 		bzero(&parse_err, sizeof(parse_err));
-		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
+		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err, false);
 		if (err) {
 			parse_events_print_error(&parse_err, trace.perfconfig_events);
 			goto out;
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 15cea518f5ad..d08be4576e61 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -120,7 +120,8 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 	 * Set backward bit, ring buffer should be writing from end. Record
 	 * it in aux evlist
 	 */
-	err = parse_events(evlist, "syscalls:sys_enter_prctl/overwrite/", &parse_error);
+	err = parse_events(evlist, "syscalls:sys_enter_prctl/overwrite/",
+			   &parse_error, false);
 	if (err) {
 		pr_debug("Failed to parse tracepoint event, try use root\n");
 		ret = TEST_SKIP;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 6fe221d31f07..a87a0ffe3705 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -645,7 +645,7 @@ static int do_test_code_reading(bool try_kcore)
 
 		str = do_determine_event(excl_kernel);
 		pr_debug("Parsing event '%s'\n", str);
-		ret = parse_events(evlist, str, NULL);
+		ret = parse_events(evlist, str, NULL, false);
 		if (ret < 0) {
 			pr_debug("parse_events failed\n");
 			goto out_put;
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index db68894a6f40..15773d384747 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -174,7 +174,7 @@ static int test_times(int (attach)(struct evlist *),
 		goto out_err;
 	}
 
-	err = parse_events(evlist, "cpu-clock:u", NULL);
+	err = parse_events(evlist, "cpu-clock:u", NULL, false);
 	if (err) {
 		pr_debug("failed to parse event cpu-clock:u\n");
 		goto out_err;
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index f7f3e5b4c180..9154e068539e 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -25,7 +25,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
 				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
-				err = parse_events(evlist, name, NULL);
+				err = parse_events(evlist, name, NULL, false);
 				if (err)
 					ret = err;
 			}
@@ -72,7 +72,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
                 return -ENOMEM;
 
 	for (i = 0; i < nr_names; ++i) {
-		err = parse_events(evlist, names[i], NULL);
+		err = parse_events(evlist, names[i], NULL, false);
 		if (err) {
 			pr_debug("failed to parse event '%s', err %d\n",
 				 names[i], err);
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 3f2e1a581247..1ad9052cbdd5 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -706,7 +706,7 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_events(evlist, "cpu-clock", NULL, false);
 	if (err)
 		goto out;
 	err = TEST_FAIL;
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 123e07d35b55..49828b40bcad 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -111,10 +111,10 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_events(evlist, "cpu-clock", NULL, false);
 	if (err)
 		goto out;
-	err = parse_events(evlist, "task-clock", NULL);
+	err = parse_events(evlist, "task-clock", NULL, false);
 	if (err)
 		goto out;
 	err = TEST_FAIL;
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index a024d3f3a412..1760d0defdfe 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -276,10 +276,10 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 	if (evlist == NULL)
                 return -ENOMEM;
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_events(evlist, "cpu-clock", NULL, false);
 	if (err)
 		goto out;
-	err = parse_events(evlist, "task-clock", NULL);
+	err = parse_events(evlist, "task-clock", NULL, false);
 	if (err)
 		goto out;
 
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 8973f35df604..82773e977ba3 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -593,7 +593,7 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 
 	TEST_ASSERT_VAL("No memory", evlist);
 
-	err = parse_events(evlist, "cpu-clock", NULL);
+	err = parse_events(evlist, "cpu-clock", NULL, false);
 	if (err)
 		goto out;
 	err = TEST_FAIL;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 50a0c9fcde7d..d0334a2e1a8e 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -89,8 +89,8 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	CHECK__(parse_events(evlist, "dummy:u", NULL));
-	CHECK__(parse_events(evlist, "cycles:u", NULL));
+	CHECK__(parse_events(evlist, "dummy:u", NULL, false));
+	CHECK__(parse_events(evlist, "cycles:u", NULL, false));
 
 	perf_evlist__config(evlist, &opts, NULL);
 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 895188b63f96..0f6c6b246677 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1797,7 +1797,7 @@ static int test_event(struct evlist_test *e)
 	if (evlist == NULL)
 		return -ENOMEM;
 
-	ret = parse_events(evlist, e->name, &err);
+	ret = parse_events(evlist, e->name, &err, false);
 	if (ret) {
 		pr_debug("failed to parse event '%s', err %d, str '%s'\n",
 			 e->name, ret, err.str);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index ab64b4a4e284..894282be073f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -402,7 +402,7 @@ static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
 
 	evlist = evlist__new();
 	memset(&error, 0, sizeof(error));
-	ret = parse_events(evlist, id, &error);
+	ret = parse_events(evlist, id, &error, false);
 	if (ret && same_cpu) {
 		pr_warning("Parse event failed metric '%s' id '%s' expr '%s'\n",
 			pe->metric_name, id, pe->metric_expr);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index db5e1f70053a..2628de39d82d 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -362,7 +362,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
 	/* First event */
-	err = parse_events(evlist, "cpu-clock:u", NULL);
+	err = parse_events(evlist, "cpu-clock:u", NULL, false);
 	if (err) {
 		pr_debug("Failed to parse event dummy:u\n");
 		goto out_err;
@@ -371,7 +371,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	cpu_clocks_evsel = evlist__last(evlist);
 
 	/* Second event */
-	err = parse_events(evlist, "cycles:u", NULL);
+	err = parse_events(evlist, "cycles:u", NULL, false);
 	if (err) {
 		pr_debug("Failed to parse event cycles:u\n");
 		goto out_err;
@@ -386,7 +386,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out;
 	}
 
-	err = parse_events(evlist, sched_switch, NULL);
+	err = parse_events(evlist, sched_switch, NULL, false);
 	if (err) {
 		pr_debug("Failed to parse event %s\n", sched_switch);
 		goto out_err;
@@ -416,7 +416,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	evsel__set_sample_bit(cycles_evsel, TIME);
 
 	/* Fourth event */
-	err = parse_events(evlist, "dummy:u", NULL);
+	err = parse_events(evlist, "dummy:u", NULL, false);
 	if (err) {
 		pr_debug("Failed to parse event dummy:u\n");
 		goto out_err;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 2feb751516ab..98307b14def1 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1560,7 +1560,7 @@ struct evsel *bpf__setup_output_event(struct evlist *evlist, const char *name)
 		if (asprintf(&event_definition, "bpf-output/no-inherit=1,name=%s/", name) < 0)
 			return ERR_PTR(-ENOMEM);
 
-		err = parse_events(evlist, event_definition, NULL);
+		err = parse_events(evlist, event_definition, NULL, false);
 		free(event_definition);
 
 		if (err) {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9e21aa767e41..9a90afb4428c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -729,7 +729,7 @@ int metricgroup__parse_groups(const struct option *opt,
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
 	bzero(&parse_error, sizeof(parse_error));
-	ret = parse_events(perf_evlist, extra_events.buf, &parse_error);
+	ret = parse_events(perf_evlist, extra_events.buf, &parse_error, false);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
 		goto out;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d521b38fa677..ec146a6f057a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2097,14 +2097,15 @@ int parse_events_terms(struct list_head *terms, const char *str)
 }
 
 int parse_events(struct evlist *evlist, const char *str,
-		 struct parse_events_error *err)
+		 struct parse_events_error *err, bool fake_pmu)
 {
 	struct parse_events_state parse_state = {
-		.list   = LIST_HEAD_INIT(parse_state.list),
-		.idx    = evlist->core.nr_entries,
-		.error  = err,
-		.evlist = evlist,
-		.stoken = PE_START_EVENTS,
+		.list     = LIST_HEAD_INIT(parse_state.list),
+		.idx      = evlist->core.nr_entries,
+		.error    = err,
+		.evlist   = evlist,
+		.stoken   = PE_START_EVENTS,
+		.fake_pmu = fake_pmu,
 	};
 	int ret;
 
@@ -2232,7 +2233,7 @@ int parse_events_option(const struct option *opt, const char *str,
 	int ret;
 
 	bzero(&err, sizeof(err));
-	ret = parse_events(evlist, str, &err);
+	ret = parse_events(evlist, str, &err, false);
 
 	if (ret) {
 		parse_events_print_error(&err, str);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 9d6846bea6ab..1864b784a587 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -34,7 +34,7 @@ const char *event_type(int type);
 int parse_events_option(const struct option *opt, const char *str, int unset);
 int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
 int parse_events(struct evlist *evlist, const char *str,
-		 struct parse_events_error *error);
+		 struct parse_events_error *error, bool fake_pmu);
 int parse_events_terms(struct list_head *terms, const char *str);
 int parse_filter(const struct option *opt, const char *str, int unset);
 int exclude_perf(const struct option *opt, const char *arg, int unset);
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1337965673d7..7657cc57f93b 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -23,7 +23,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 	if (!evlist)
 		return -ENOMEM;
 
-	if (parse_events(evlist, str, NULL))
+	if (parse_events(evlist, str, NULL, false))
 		goto out_delete;
 
 	evsel = evlist__first(evlist);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index a4cc11592f6b..bae21b43ac08 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -210,7 +210,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 	if (!temp_evlist)
 		return false;
 
-	err = parse_events(temp_evlist, str, NULL);
+	err = parse_events(temp_evlist, str, NULL, false);
 	if (err)
 		goto out_delete;
 
-- 
2.25.4


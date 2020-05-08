Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34245C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5D0249A5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgEHNLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730395AbgEHNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF8C05BD09;
        Fri,  8 May 2020 06:05:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gT-0007KE-QD; Fri, 08 May 2020 15:04:57 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 600B81C0823;
        Fri,  8 May 2020 15:04:51 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__*filter*() to
 evsel__*filter*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309131.8414.8941459746727144145.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ad681adf1dfed687b350aac41771de323cd03b70
Gitweb:        https://git.kernel.org/tip/ad681adf1dfed687b350aac41771de323cd03b70
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 16:19:05 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__*filter*() to evsel__*filter*()

As those are not 'struct evsel' methods, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c     |  7 +++----
 tools/perf/util/auxtrace.c     |  6 +++---
 tools/perf/util/evlist.c       |  4 ++--
 tools/perf/util/evsel.c        | 15 +++++++--------
 tools/perf/util/evsel.h        |  7 +++----
 tools/perf/util/parse-events.c |  6 +++---
 6 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1411e27..12b770a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3164,10 +3164,9 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 	if (filter == NULL)
 		goto out_enomem;
 
-	if (!perf_evsel__append_tp_filter(trace->syscalls.events.sys_enter,
-					  filter)) {
+	if (!evsel__append_tp_filter(trace->syscalls.events.sys_enter, filter)) {
 		sys_exit = trace->syscalls.events.sys_exit;
-		err = perf_evsel__append_tp_filter(sys_exit, filter);
+		err = evsel__append_tp_filter(sys_exit, filter);
 	}
 
 	free(filter);
@@ -3801,7 +3800,7 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 	if (new_filter != evsel->filter) {
 		pr_debug("New filter for %s: %s\n", evsel->name, new_filter);
-		perf_evsel__set_filter(evsel, new_filter);
+		evsel__set_filter(evsel, new_filter);
 		free(new_filter);
 	}
 
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e12696f..c22ef2e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2522,7 +2522,7 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 			goto out_exit;
 		}
 
-		if (perf_evsel__append_addr_filter(evsel, new_filter)) {
+		if (evsel__append_addr_filter(evsel, new_filter)) {
 			err = -ENOMEM;
 			goto out_exit;
 		}
@@ -2540,7 +2540,7 @@ out_exit:
 	return err;
 }
 
-static int perf_evsel__nr_addr_filter(struct evsel *evsel)
+static int evsel__nr_addr_filter(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 	int nr_addr_filters = 0;
@@ -2561,7 +2561,7 @@ int auxtrace_parse_filters(struct evlist *evlist)
 
 	evlist__for_each_entry(evlist, evsel) {
 		filter = evsel->filter;
-		max_nr = perf_evsel__nr_addr_filter(evsel);
+		max_nr = evsel__nr_addr_filter(evsel);
 		if (!filter || !max_nr)
 			continue;
 		evsel->filter = NULL;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 58228a5..410cd83 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -995,7 +995,7 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 
-		err = perf_evsel__set_filter(evsel, filter);
+		err = evsel__set_filter(evsel, filter);
 		if (err)
 			break;
 	}
@@ -1015,7 +1015,7 @@ int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 
-		err = perf_evsel__append_tp_filter(evsel, filter);
+		err = evsel__append_tp_filter(evsel, filter);
 		if (err)
 			break;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f03500..4f27176 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1166,7 +1166,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
+int evsel__set_filter(struct evsel *evsel, const char *filter)
 {
 	char *new_filter = strdup(filter);
 
@@ -1179,13 +1179,12 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter)
 	return -1;
 }
 
-static int perf_evsel__append_filter(struct evsel *evsel,
-				     const char *fmt, const char *filter)
+static int evsel__append_filter(struct evsel *evsel, const char *fmt, const char *filter)
 {
 	char *new_filter;
 
 	if (evsel->filter == NULL)
-		return perf_evsel__set_filter(evsel, filter);
+		return evsel__set_filter(evsel, filter);
 
 	if (asprintf(&new_filter, fmt, evsel->filter, filter) > 0) {
 		free(evsel->filter);
@@ -1196,14 +1195,14 @@ static int perf_evsel__append_filter(struct evsel *evsel,
 	return -1;
 }
 
-int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter)
+int evsel__append_tp_filter(struct evsel *evsel, const char *filter)
 {
-	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
+	return evsel__append_filter(evsel, "(%s) && (%s)", filter);
 }
 
-int perf_evsel__append_addr_filter(struct evsel *evsel, const char *filter)
+int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 {
-	return perf_evsel__append_filter(evsel, "%s,%s", filter);
+	return evsel__append_filter(evsel, "%s,%s", filter);
 }
 
 /* Caller has to clear disabled after going through all CPUs. */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ecd3ea8..df64d89 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -225,10 +225,9 @@ void __evsel__reset_sample_bit(struct evsel *evsel, enum perf_event_sample_forma
 
 void evsel__set_sample_id(struct evsel *evsel, bool use_sample_identifier);
 
-int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
-int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
-int perf_evsel__append_addr_filter(struct evsel *evsel,
-				   const char *filter);
+int evsel__set_filter(struct evsel *evsel, const char *filter);
+int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
+int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
 int evsel__enable_cpu(struct evsel *evsel, int cpu);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2252f49..899ced4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2261,7 +2261,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 	}
 
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT) {
-		if (perf_evsel__append_tp_filter(evsel, str) < 0) {
+		if (evsel__append_tp_filter(evsel, str) < 0) {
 			fprintf(stderr,
 				"not enough memory to hold filter string\n");
 			return -1;
@@ -2286,7 +2286,7 @@ static int set_filter(struct evsel *evsel, const void *arg)
 		return -1;
 	}
 
-	if (perf_evsel__append_addr_filter(evsel, str) < 0) {
+	if (evsel__append_addr_filter(evsel, str) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;
@@ -2317,7 +2317,7 @@ static int add_exclude_perf_filter(struct evsel *evsel,
 
 	snprintf(new_filter, sizeof(new_filter), "common_pid != %d", getpid());
 
-	if (perf_evsel__append_tp_filter(evsel, new_filter) < 0) {
+	if (evsel__append_tp_filter(evsel, new_filter) < 0) {
 		fprintf(stderr,
 			"not enough memory to hold filter string\n");
 		return -1;

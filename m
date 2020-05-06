Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED912C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31A321582
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778783;
	bh=FPkHc/RvbgYFVh8ltYHfCOXdWwkd5APRVEjSvY33Nfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hh2WksVJD4Euf6uMRS9EOW+nBAEDHZRhcg9yPdI4FgjY2GM+f0pgtXlfMEB40SIlz
	 IAwbdOVcc/4dmEJ7SzJ6RY9i65ehDMtNtSjvN9NxsTtBhppzkp0MPPyD56lv9msJUG
	 omv44ioM0J1QNdRCe6VyE5ju4xNspQKXNvI8l2I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgEFP0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbgEFP0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8B821582;
        Wed,  6 May 2020 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778765;
        bh=FPkHc/RvbgYFVh8ltYHfCOXdWwkd5APRVEjSvY33Nfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X90UbzvGQifV9V52XnOi6cPIO/WHC5USjSM0/1h33F+tzqgQUly7f6XcbTsak8dad
         SaF6jsCaF1WC7syjJphbWuIBpMDifaFxtYxjIkqSKEMiU5g9GPbKwsShH0+dQ36sU9
         Edmmy8pGnWBirwzBslzx+cMHlP0sZvsjCCKv2rWw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 60/91] perf evsel: Rename perf_evsel__*filter*() to evsel__*filter*()
Date:   Wed,  6 May 2020 12:22:03 -0300
Message-Id: <20200506152234.21977-61-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 1411e2735855..12b770abb87a 100644
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
index e12696fe6f65..c22ef2e3e079 100644
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
@@ -2540,7 +2540,7 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
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
index 58228a54ecd7..410cd834c39a 100644
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
index 4f03500253e3..4f271764cbf2 100644
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
index ecd3ea89e12c..df64d89cd916 100644
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
index 2252f494ff9f..899ced466197 100644
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
-- 
2.21.1


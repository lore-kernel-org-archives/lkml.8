Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F84C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C43520A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778906;
	bh=8yK0ehk2FJ+EzHdPdAYIuPaSPfjMDsdrFSEZkgF6TTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVwU/g/Bo85C7vkwd0hiECyUlpAMXzo+m0TPB3g5duaJTzJaaFoJDnWSd5Z2FrV/V
	 o5rC1pifqX1O/Ty4EfDITz0CkSHHWZzFJp84rGbDmPEsdu7fP9jO+OnVeXalvzpYPh
	 grtBfktXpt9eSfBUu2oWROew6pfq2Qfg/3MDu910=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgEFP2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbgEFP0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA7D621655;
        Wed,  6 May 2020 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778802;
        bh=8yK0ehk2FJ+EzHdPdAYIuPaSPfjMDsdrFSEZkgF6TTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSHEaa5nrPu+fZyZyt5LBbu35Ms/ireQdXlyrnW8mzVq6odnF2nW5ZUmc+Vknz3Yj
         PHQ5mO623c5RRTEHsNv+nroSjG8e24vfAi67E+o1ojCurGv4IoglaayVYGVxQJlU06
         Av8YWv12ZI5fCvwLKcETfme7CaIE40Q/Fmv4Ro08=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 69/91] perf evsel: Rename *perf_evsel__read*() to *evsel__read()
Date:   Wed,  6 May 2020 12:22:12 -0300
Message-Id: <20200506152234.21977-70-acme@kernel.org>
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

As those are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c                  |  4 ++--
 tools/perf/tests/openat-syscall-all-cpus.c |  6 +++---
 tools/perf/tests/openat-syscall.c          |  6 +++---
 tools/perf/util/evsel.c                    | 17 +++++++----------
 tools/perf/util/evsel.h                    | 19 ++++++++-----------
 tools/perf/util/record.c                   |  5 ++---
 6 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6bc1336a0429..e3629ca69827 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -259,7 +259,7 @@ static int read_single_counter(struct evsel *counter, int cpu,
 		count->val = val;
 		return 0;
 	}
-	return perf_evsel__read_counter(counter, cpu, thread);
+	return evsel__read_counter(counter, cpu, thread);
 }
 
 /*
@@ -284,7 +284,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 
 		/*
 		 * The leader's group read loads data into its group members
-		 * (via perf_evsel__read_counter()) and sets their count->loaded.
+		 * (via evsel__read_counter()) and sets their count->loaded.
 		 */
 		if (!perf_counts__is_loaded(counter->counts, cpu, thread) &&
 		    read_single_counter(counter, cpu, thread, rs)) {
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 93c176523e38..900934be22d2 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -103,15 +103,15 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 		if (cpus->map[cpu] >= CPU_SETSIZE)
 			continue;
 
-		if (perf_evsel__read_on_cpu(evsel, cpu, 0) < 0) {
-			pr_debug("perf_evsel__read_on_cpu\n");
+		if (evsel__read_on_cpu(evsel, cpu, 0) < 0) {
+			pr_debug("evsel__read_on_cpu\n");
 			err = -1;
 			break;
 		}
 
 		expected = nr_openat_calls + cpu;
 		if (perf_counts(evsel->counts, cpu, 0)->val != expected) {
-			pr_debug("perf_evsel__read_on_cpu: expected to intercept %d calls on cpu %d, got %" PRIu64 "\n",
+			pr_debug("evsel__read_on_cpu: expected to intercept %d calls on cpu %d, got %" PRIu64 "\n",
 				 expected, cpus->map[cpu], perf_counts(evsel->counts, cpu, 0)->val);
 			err = -1;
 		}
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 8497a1fe9bac..db5d8bb8cd06 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -46,13 +46,13 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 		close(fd);
 	}
 
-	if (perf_evsel__read_on_cpu(evsel, 0, 0) < 0) {
-		pr_debug("perf_evsel__read_on_cpu\n");
+	if (evsel__read_on_cpu(evsel, 0, 0) < 0) {
+		pr_debug("evsel__read_on_cpu\n");
 		goto out_close_fd;
 	}
 
 	if (perf_counts(evsel->counts, 0, 0)->val != nr_openat_calls) {
-		pr_debug("perf_evsel__read_on_cpu: expected to intercept %d calls, got %" PRIu64 "\n",
+		pr_debug("evsel__read_on_cpu: expected to intercept %d calls, got %" PRIu64 "\n",
 			 nr_openat_calls, perf_counts(evsel->counts, 0, 0)->val);
 		goto out_close_fd;
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ded511c8def3..a11d1359ba81 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1317,8 +1317,7 @@ void perf_counts_values__scale(struct perf_counts_values *count,
 		*pscaled = scaled;
 }
 
-static int
-perf_evsel__read_one(struct evsel *evsel, int cpu, int thread)
+static int evsel__read_one(struct evsel *evsel, int cpu, int thread)
 {
 	struct perf_counts_values *count = perf_counts(evsel->counts, cpu, thread);
 
@@ -1378,8 +1377,7 @@ perf_evsel__process_group_data(struct evsel *leader,
 	return 0;
 }
 
-static int
-perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
+static int evsel__read_group(struct evsel *leader, int cpu, int thread)
 {
 	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->core.attr.read_format;
@@ -1409,18 +1407,17 @@ perf_evsel__read_group(struct evsel *leader, int cpu, int thread)
 	return perf_evsel__process_group_data(leader, cpu, thread, data);
 }
 
-int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread)
+int evsel__read_counter(struct evsel *evsel, int cpu, int thread)
 {
 	u64 read_format = evsel->core.attr.read_format;
 
 	if (read_format & PERF_FORMAT_GROUP)
-		return perf_evsel__read_group(evsel, cpu, thread);
-	else
-		return perf_evsel__read_one(evsel, cpu, thread);
+		return evsel__read_group(evsel, cpu, thread);
+
+	return evsel__read_one(evsel, cpu, thread);
 }
 
-int __perf_evsel__read_on_cpu(struct evsel *evsel,
-			      int cpu, int thread, bool scale)
+int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale)
 {
 	struct perf_counts_values count;
 	size_t nv = scale ? 3 : 1;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8d61109087a1..a87de95a66c8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -265,35 +265,32 @@ static inline bool evsel__match2(struct evsel *e1, struct evsel *e2)
 	       (e1->core.attr.config == e2->core.attr.config);
 }
 
-int perf_evsel__read_counter(struct evsel *evsel, int cpu, int thread);
+int evsel__read_counter(struct evsel *evsel, int cpu, int thread);
 
-int __perf_evsel__read_on_cpu(struct evsel *evsel,
-			      int cpu, int thread, bool scale);
+int __evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread, bool scale);
 
 /**
- * perf_evsel__read_on_cpu - Read out the results on a CPU and thread
+ * evsel__read_on_cpu - Read out the results on a CPU and thread
  *
  * @evsel - event selector to read value
  * @cpu - CPU of interest
  * @thread - thread of interest
  */
-static inline int perf_evsel__read_on_cpu(struct evsel *evsel,
-					  int cpu, int thread)
+static inline int evsel__read_on_cpu(struct evsel *evsel, int cpu, int thread)
 {
-	return __perf_evsel__read_on_cpu(evsel, cpu, thread, false);
+	return __evsel__read_on_cpu(evsel, cpu, thread, false);
 }
 
 /**
- * perf_evsel__read_on_cpu_scaled - Read out the results on a CPU and thread, scaled
+ * evsel__read_on_cpu_scaled - Read out the results on a CPU and thread, scaled
  *
  * @evsel - event selector to read value
  * @cpu - CPU of interest
  * @thread - thread of interest
  */
-static inline int perf_evsel__read_on_cpu_scaled(struct evsel *evsel,
-						 int cpu, int thread)
+static inline int evsel__read_on_cpu_scaled(struct evsel *evsel, int cpu, int thread)
 {
-	return __perf_evsel__read_on_cpu(evsel, cpu, thread, true);
+	return __evsel__read_on_cpu(evsel, cpu, thread, true);
 }
 
 int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index d297f4de253c..a4cc11592f6b 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -19,8 +19,7 @@
  * However, if the leader is an AUX area event, then assume the event to sample
  * is the next event.
  */
-static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
-					      struct evlist *evlist)
+static struct evsel *evsel__read_sampler(struct evsel *evsel, struct evlist *evlist)
 {
 	struct evsel *leader = evsel->leader;
 
@@ -43,7 +42,7 @@ static void evsel__config_leader_sampling(struct evsel *evsel, struct evlist *ev
 	if (!leader->sample_read)
 		return;
 
-	read_sampler = perf_evsel__read_sampler(evsel, evlist);
+	read_sampler = evsel__read_sampler(evsel, evlist);
 
 	if (evsel == read_sampler)
 		return;
-- 
2.21.1


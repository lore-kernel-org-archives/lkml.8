Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E849C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0838249C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgEHNLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729104AbgEHNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A423EC05BD0D;
        Fri,  8 May 2020 06:04:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gM-0007Ex-Dc; Fri, 08 May 2020 15:04:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 632D71C0822;
        Fri,  8 May 2020 15:04:47 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:47 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename *perf_evsel__read*() to *evsel__read()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308736.8414.2868578894503235021.tip-bot2@tip-bot2>
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

Commit-ID:     ea089692733a53ddbe8f4e46d06113c6ca723727
Gitweb:        https://git.kernel.org/tip/ea089692733a53ddbe8f4e46d06113c6ca723727
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 30 Apr 2020 11:00:53 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename *perf_evsel__read*() to *evsel__read()

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
index 6bc1336..e3629ca 100644
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
index 93c1765..900934b 100644
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
index 8497a1f..db5d8bb 100644
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
index ded511c..a11d135 100644
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
index 8d61109..a87de95 100644
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
index d297f4d..a4cc115 100644
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

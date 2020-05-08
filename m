Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D3AC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C018208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgEHNFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730419AbgEHNFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2DEC05BD0A;
        Fri,  8 May 2020 06:05:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gX-0007JG-3j; Fri, 08 May 2020 15:05:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 025B71C0822;
        Fri,  8 May 2020 15:04:51 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__open_per_*() to
 evsel__open_per_*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309091.8414.12468417379454912081.tip-bot2@tip-bot2>
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

Commit-ID:     aa8c406b0adb3043b935293826b3e4675204ed83
Gitweb:        https://git.kernel.org/tip/aa8c406b0adb3043b935293826b3e4675204ed83
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 16:21:03 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__open_per_*() to evsel__open_per_*()

As those are not 'struct evsel' methods, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/event-times.c    | 8 ++++----
 tools/perf/tests/openat-syscall.c | 2 +-
 tools/perf/util/evsel.c           | 7 ++-----
 tools/perf/util/evsel.h           | 7 ++-----
 tools/perf/util/stat.c            | 4 ++--
 5 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 1e8a9f5..db68894 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -72,7 +72,7 @@ static int attach__current_disabled(struct evlist *evlist)
 
 	evsel->core.attr.disabled = 1;
 
-	err = perf_evsel__open_per_thread(evsel, threads);
+	err = evsel__open_per_thread(evsel, threads);
 	if (err) {
 		pr_debug("Failed to open event cpu-clock:u\n");
 		return err;
@@ -96,7 +96,7 @@ static int attach__current_enabled(struct evlist *evlist)
 		return -1;
 	}
 
-	err = perf_evsel__open_per_thread(evsel, threads);
+	err = evsel__open_per_thread(evsel, threads);
 
 	perf_thread_map__put(threads);
 	return err == 0 ? TEST_OK : TEST_FAIL;
@@ -125,7 +125,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 
 	evsel->core.attr.disabled = 1;
 
-	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
+	err = evsel__open_per_cpu(evsel, cpus, -1);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -152,7 +152,7 @@ static int attach__cpu_enabled(struct evlist *evlist)
 		return -1;
 	}
 
-	err = perf_evsel__open_per_cpu(evsel, cpus, -1);
+	err = evsel__open_per_cpu(evsel, cpus, -1);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 5ebffae..8497a1f 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -34,7 +34,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 		goto out_thread_map_delete;
 	}
 
-	if (perf_evsel__open_per_thread(evsel, threads) < 0) {
+	if (evsel__open_per_thread(evsel, threads) < 0) {
 		pr_debug("failed to open counter: %s, "
 			 "tweak /proc/sys/kernel/perf_event_paranoid?\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f27176..bbd57e8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1863,9 +1863,7 @@ void evsel__close(struct evsel *evsel)
 	perf_evsel__free_id(&evsel->core);
 }
 
-int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus,
-			     int cpu)
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu)
 {
 	if (cpu == -1)
 		return evsel__open_cpu(evsel, cpus, NULL, 0,
@@ -1874,8 +1872,7 @@ int perf_evsel__open_per_cpu(struct evsel *evsel,
 	return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
 }
 
-int perf_evsel__open_per_thread(struct evsel *evsel,
-				struct perf_thread_map *threads)
+int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 {
 	return evsel__open(evsel, NULL, threads);
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index df64d89..e16a9b2 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -233,11 +233,8 @@ int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 int evsel__disable_cpu(struct evsel *evsel, int cpu);
 
-int perf_evsel__open_per_cpu(struct evsel *evsel,
-			     struct perf_cpu_map *cpus,
-			     int cpu);
-int perf_evsel__open_per_thread(struct evsel *evsel,
-				struct perf_thread_map *threads);
+int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
+int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
 void evsel__close(struct evsel *evsel);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index c27f01b..3520b74 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -521,7 +521,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	}
 
 	if (target__has_cpu(target) && !target__has_per_thread(target))
-		return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
+		return evsel__open_per_cpu(evsel, evsel__cpus(evsel), cpu);
 
-	return perf_evsel__open_per_thread(evsel, evsel->core.threads);
+	return evsel__open_per_thread(evsel, evsel->core.threads);
 }

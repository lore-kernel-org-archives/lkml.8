Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39591C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D3024999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgEHNF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730437AbgEHNFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20728C05BD0C;
        Fri,  8 May 2020 06:05:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2ga-0007TA-RQ; Fri, 08 May 2020 15:05:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B3011C0475;
        Fri,  8 May 2020 15:04:55 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:55 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__compute_deltas() to
 evsel__compute_deltas()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309545.8414.13143986984883922116.tip-bot2@tip-bot2>
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

Commit-ID:     12f5261dac90aea0fd5287b01d50397334cf303e
Gitweb:        https://git.kernel.org/tip/12f5261dac90aea0fd5287b01d50397334cf303e
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:47:38 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__compute_deltas() to evsel__compute_deltas()

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 +++---
 tools/perf/util/evsel.h | 4 ++--
 tools/perf/util/stat.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a571d3..db6d2a5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1283,8 +1283,8 @@ void evsel__delete(struct evsel *evsel)
 	free(evsel);
 }
 
-void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
-				struct perf_counts_values *count)
+void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
+			   struct perf_counts_values *count)
 {
 	struct perf_counts_values tmp;
 
@@ -1440,7 +1440,7 @@ int __perf_evsel__read_on_cpu(struct evsel *evsel,
 	if (readn(FD(evsel, cpu, thread), &count, nv * sizeof(u64)) <= 0)
 		return -errno;
 
-	perf_evsel__compute_deltas(evsel, cpu, thread, &count);
+	evsel__compute_deltas(evsel, cpu, thread, &count);
 	perf_counts_values__scale(&count, scale, NULL);
 	*perf_counts(evsel->counts, cpu, thread) = count;
 	return 0;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e2a0ebe..3201505 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -151,8 +151,8 @@ static inline int evsel__nr_cpus(struct evsel *evsel)
 void perf_counts_values__scale(struct perf_counts_values *count,
 			       bool scale, s8 *pscaled);
 
-void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
-				struct perf_counts_values *count);
+void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
+			   struct perf_counts_values *count);
 
 int perf_evsel__object_config(size_t object_size,
 			      int (*init)(struct evsel *evsel),
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index da3a206..4e6e770 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -302,7 +302,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	case AGGR_NODE:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
-			perf_evsel__compute_deltas(evsel, cpu, thread, count);
+			evsel__compute_deltas(evsel, cpu, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
 		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
 			perf_stat__update_shadow_stats(evsel, count->val,
@@ -384,7 +384,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 		return 0;
 
 	if (!counter->snapshot)
-		perf_evsel__compute_deltas(counter, -1, -1, aggr);
+		evsel__compute_deltas(counter, -1, -1, aggr);
 	perf_counts_values__scale(aggr, config->scale, &counter->counts->scaled);
 
 	for (i = 0; i < 3; i++)

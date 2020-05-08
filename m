Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC7FC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5883F24999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgEHNKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730112AbgEHNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:13 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FC2C05BD0B;
        Fri,  8 May 2020 06:05:13 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gg-0007Te-1X; Fri, 08 May 2020 15:05:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D12881C04D0;
        Fri,  8 May 2020 15:04:55 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:55 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__nr_cpus() to evsel__nr_cpus()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309579.8414.501622483910338341.tip-bot2@tip-bot2>
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

Commit-ID:     5eb88f0476aba76fd6aa48e34b328ff864e84651
Gitweb:        https://git.kernel.org/tip/5eb88f0476aba76fd6aa48e34b328ff864e84651
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:45:09 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__nr_cpus() to evsel__nr_cpus()

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c    |  2 +-
 tools/perf/util/evsel.h        |  2 +-
 tools/perf/util/stat-display.c | 10 +++++-----
 tools/perf/util/stat.c         |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3aadefd..907b5c9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1977,7 +1977,7 @@ static struct scripting_ops	*scripting_ops;
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = perf_evsel__nr_cpus(counter);
+	int ncpus = evsel__nr_cpus(counter);
 	int cpu, thread;
 	static int header_printed;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 7ff37c4..e2a0ebe 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -143,7 +143,7 @@ static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 	return perf_evsel__cpus(&evsel->core);
 }
 
-static inline int perf_evsel__nr_cpus(struct evsel *evsel)
+static inline int evsel__nr_cpus(struct evsel *evsel)
 {
 	return evsel__cpus(evsel)->nr;
 }
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 679aaa6..b0e5d85 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -333,7 +333,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_GLOBAL)
 		return 0;
 
-	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
+	for (i = 0; i < evsel__nr_cpus(evsel); i++) {
 		int cpu2 = evsel__cpus(evsel)->map[i];
 
 		if (config->aggr_get_id(config, evlist->core.cpus, cpu2) == id)
@@ -508,7 +508,7 @@ static void aggr_update_shadow(struct perf_stat_config *config,
 		id = config->aggr_map->map[s];
 		evlist__for_each_entry(evlist, counter) {
 			val = 0;
-			for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+			for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
 				s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
 				if (s2 != id)
 					continue;
@@ -599,7 +599,7 @@ static void aggr_cb(struct perf_stat_config *config,
 	struct aggr_data *ad = data;
 	int cpu, s2;
 
-	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
 		struct perf_counts_values *counts;
 
 		s2 = config->aggr_get_id(config, evsel__cpus(counter), cpu);
@@ -847,7 +847,7 @@ static void print_counter(struct perf_stat_config *config,
 	double uval;
 	int cpu;
 
-	for (cpu = 0; cpu < perf_evsel__nr_cpus(counter); cpu++) {
+	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
 		struct aggr_data ad = { .cpu = cpu };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
@@ -1148,7 +1148,7 @@ static void print_percore_thread(struct perf_stat_config *config,
 	int s, s2, id;
 	bool first = true;
 
-	for (int i = 0; i < perf_evsel__nr_cpus(counter); i++) {
+	for (int i = 0; i < evsel__nr_cpus(counter); i++) {
 		s2 = config->aggr_get_id(config, evsel__cpus(counter), i);
 		for (s = 0; s < config->aggr_map->nr; s++) {
 			id = config->aggr_map->map[s];
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 242476e..da3a206 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -173,7 +173,7 @@ static void perf_evsel__reset_prev_raw_counts(struct evsel *evsel)
 
 static int perf_evsel__alloc_stats(struct evsel *evsel, bool alloc_raw)
 {
-	int ncpus = perf_evsel__nr_cpus(evsel);
+	int ncpus = evsel__nr_cpus(evsel);
 	int nthreads = perf_thread_map__nr(evsel->core.threads);
 
 	if (perf_evsel__alloc_stat_priv(evsel) < 0 ||
@@ -334,7 +334,7 @@ static int process_counter_maps(struct perf_stat_config *config,
 				struct evsel *counter)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = perf_evsel__nr_cpus(counter);
+	int ncpus = evsel__nr_cpus(counter);
 	int cpu, thread;
 
 	if (counter->core.system_wide)

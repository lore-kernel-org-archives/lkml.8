Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324A9C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114EB21655
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778748;
	bh=5AE5Bg3QVbKZv4N/RIthfINSfrpcOVQvUx8hztJM7Ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4DS7N6yWJ3RCOHrbDjFEDewAnL1TQyGRdrhC3OqWvS6lE52jkwY0JNWC2y5sVTsY
	 SbBJ4QddMG6Kz1v/kX10l1X6x9TLnG748DEXa05+KdKasuF6FTPmdFNsPrZsBewVRC
	 QmEg4Skw81pp8wtwGN7so2UK4vF1v5Ijh/RRBuUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgEFPZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgEFPZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DAE20A8B;
        Wed,  6 May 2020 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778737;
        bh=5AE5Bg3QVbKZv4N/RIthfINSfrpcOVQvUx8hztJM7Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtIiPXLYyxq0QVdbAaMn1iM2r425lCYGUALLKGwrv9HzWfRKRfI2Q7De+JZ9gGG2g
         TnHXWqDwh/gmJHZ5NVmZdLK3cVDYAaiVA+xJSpWXtm5hxvvstobIicUeRdxV31YXus
         UlJyYHMPOX1C7mkwUjJ08iFvvF7xKLuxtuGqcYiY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 49/91] perf evsel: Rename perf_evsel__nr_cpus() to evsel__nr_cpus()
Date:   Wed,  6 May 2020 12:21:52 -0300
Message-Id: <20200506152234.21977-50-acme@kernel.org>
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
index 3aadefd2791e..907b5c9f6a4e 100644
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
index 7ff37c4cdf9f..e2a0ebe59365 100644
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
index 679aaa655824..b0e5d8505f57 100644
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
index 242476eb808c..da3a206e95f7 100644
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
-- 
2.21.1


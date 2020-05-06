Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68D121655
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778745;
	bh=ePKDKgbhGvaRz94k7JrHlCj1m/VKlgdBFdW6CE8NQDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+ORTtgidJqTIiO7Fgf0cPJHTQzqOOnXWUSwHcV0Bri6mN3NXOT2G1fM8vEKBFlhZ
	 wJJLgd4fvPJBZCtjvjugrKBRk9yBQAkJWRwZR1yEjbzzv8UQEgf7kvknGPzAj5CYv/
	 ETrNN87lqsopkS5SoGXKQDHowvv1IaZjbs3UGHl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEFPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgEFPZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E69321582;
        Wed,  6 May 2020 15:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778740;
        bh=ePKDKgbhGvaRz94k7JrHlCj1m/VKlgdBFdW6CE8NQDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHi/H/PyhOk3hevWgVt7dvPaUz5il377mQuCsy6bYbB8sHUgkUxeoA/B1bSvoYaen
         iID8otus6lEJ2R2/ESeuBT7esCiH63dWEZXL6mgN5PW4h6Q8CoimVpCjKjLX5B+Nz+
         u1LZuJ8Yvb9jetEXcCIoKQJNOI28RJ6qZD3OqsQU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 50/91] perf evsel: Rename perf_evsel__compute_deltas() to evsel__compute_deltas()
Date:   Wed,  6 May 2020 12:21:53 -0300
Message-Id: <20200506152234.21977-51-acme@kernel.org>
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
 tools/perf/util/evsel.c | 6 +++---
 tools/perf/util/evsel.h | 4 ++--
 tools/perf/util/stat.c  | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a571d322bb2..db6d2a5f9b3c 100644
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
index e2a0ebe59365..32015057429c 100644
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
index da3a206e95f7..4e6e770f39aa 100644
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
-- 
2.21.1


Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC44C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037A62076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140103;
	bh=JRWn5POUoFf5lHXcQFUHz6NdPjnWqPuLk76XsX8HO0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSMitOHIIWFSSdaW3uDrfpZ86yd7uAF5sHyhLPH9n0hi/UTbzgupa8Z9Kwf5Bwi86
	 BN/DE617tDFZj5mofPHFsd+feYWN1ugJHB4xQkH8Mdt/lBP5ji5FcTZvT7fKMuhjlg
	 Z8dt4kA3LjnhS+D9T//SS2BS5kigvYkVw3iF3hY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgCYMll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbgCYMlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:41:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A213F2078D;
        Wed, 25 Mar 2020 12:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140099;
        bh=JRWn5POUoFf5lHXcQFUHz6NdPjnWqPuLk76XsX8HO0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1W8LIhSOWYFcd5sxjSQiQoG+lqxz/JveYVy2OBgdSGv8HElYRnifZS0Y03dJz+x5
         lbu7W8UZphhOMtzYIQ3rwy3X0qGsX5mZE751X64Q0/tDoidi6LNyd1PVkrR0Lbqa2q
         Va/83A+DCdTz5opancPKr5FmwirWZHMHSrXniVbA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/24] perf parse-events: Fix 3 use after frees found with clang ASAN
Date:   Wed, 25 Mar 2020 09:41:01 -0300
Message-Id: <20200325124124.32648-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

Reproducible with a clang asan build and then running perf test in
particular 'Parse event definition strings'.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200314170356.62914-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c        | 1 +
 tools/perf/util/parse-events.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 816d930d774e..15ccd193483f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1287,6 +1287,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
+	zfree(&evsel->pmu_name);
 	perf_evsel__object.fini(evsel);
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index a7dc0b096974..10107747b361 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1449,7 +1449,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL,
 				    auto_merge_stats, NULL);
 		if (evsel) {
-			evsel->pmu_name = name;
+			evsel->pmu_name = name ? strdup(name) : NULL;
 			evsel->use_uncore_alias = use_uncore_alias;
 			return 0;
 		} else {
@@ -1497,7 +1497,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->snapshot = info.snapshot;
 		evsel->metric_expr = info.metric_expr;
 		evsel->metric_name = info.metric_name;
-		evsel->pmu_name = name;
+		evsel->pmu_name = name ? strdup(name) : NULL;
 		evsel->use_uncore_alias = use_uncore_alias;
 		evsel->percore = config_term_percore(&evsel->config_terms);
 	}
@@ -1547,7 +1547,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				if (!parse_events_add_pmu(parse_state, list,
 							  pmu->name, head,
 							  true, true)) {
-					pr_debug("%s -> %s/%s/\n", config,
+					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
 				}
-- 
2.21.1


Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAADC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FF820578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iu1VWtIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgCOCzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:55:36 -0400
Received: from mail-il1-f201.google.com ([209.85.166.201]:41426 "EHLO
        mail-il1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCOCzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:55:35 -0400
Received: by mail-il1-f201.google.com with SMTP id f19so10578232ill.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1ZdVkhi4YwlaXiH7itajZKX5fyP/5VMYm/74NCalIIY=;
        b=Iu1VWtIBGYXJgM9J72JljAOgVYIMymeBCOU3dyTKsRl9ZDQGsDTAYu2mdTh3tx2kx5
         D9NEEsSMenQOmlPXRhJOa/Hlip+dso58DEDr3mfN7D5XGRNYhzkb7pgOxzHntLm4WMqD
         /lYyTntEK+gQsQYP2OC+WXWAr+j3gVOZiNahR0FNP+kDM9CWWgkCEMlwi7RnvOCx9lhR
         k4YrO3WGSvx5Cs/bTY5mHsNw39nRvDJJ6cHy1ceEXo0g5Z+BtsjqLSar3TGOz0kOlgj0
         NIaGnnyT0HYRNvxoMtf/MFiFoZVMq/yGzSluQjj2NNibi/ESRHXGCjG1KKjvGvgnQnft
         AXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1ZdVkhi4YwlaXiH7itajZKX5fyP/5VMYm/74NCalIIY=;
        b=EEnF56gRuEZcEsj8c8w7wIYp/pUexISLs+X2g8XPBG1n7tG6goMxc/Brx4whrnMuJD
         eso+O4BpDzwUh4oV731wPmhWr7Bdr27ZNKF4RtENPEwcQ2PUNRguEE8/z+y8640GJwCB
         Cb/RKZ0QixI9jHe/wHNDVqBNTg/SaUnhdtOgqBStWzfE5SDqSWmqoBE7QTEEJ4awuQiC
         BmT56cplUw1K+WroZiPJCKVVeOSeMVGZRrfYSaghdPNuWGgcg09Se6/lNuaFBoh1cppH
         Qb7fcCA/y73eoHd+PcbX5GaB5L+3HBFo+OLHxr6PVpKhFDCNMZlSCRWeckb1LgkmxPCf
         dd4Q==
X-Gm-Message-State: ANhLgQ2X9pj4ee0U91k7Hn7lQ0Uayt3XjDt7o8glgSjNmN/sRa7ye5e6
        MxJmGC4ibWb1yhET63HNo/744N1SK3KL
X-Google-Smtp-Source: ADFU+vuh+zKYseXKDTzs/Le2MB9LsFsJL+EVCV+06hzN/dd6c9XBSXfECxWDOdU9NLHTEZmARZD/Mt6Xx5dE
X-Received: by 2002:a63:ec44:: with SMTP id r4mr18267799pgj.425.1584205441277;
 Sat, 14 Mar 2020 10:04:01 -0700 (PDT)
Date:   Sat, 14 Mar 2020 10:03:56 -0700
Message-Id: <20200314170356.62914-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2] perf parse-events: fix 3 use after frees
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reproducible with a clang asan build and then running perf test in
particular 'Parse event definition strings'.

v2 frees the evsel->pmu_name avoiding a memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
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
index a14995835d85..593b6b03785d 100644
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
2.25.1.481.gfbce0eb801-goog


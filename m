Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C294C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11177207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QpW/Eb4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHZE3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 00:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgHZE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:29:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EFBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:29:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x6so1207603ybp.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 21:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SFlBaRGOxuhPAwXvTJE/AiYZZaKxKu8ThTgPykAaza0=;
        b=QpW/Eb4eHFUKZn4fBIE0SHouRgUjsXVAIxqiWBEjlYUOT24wKF+6F+kjisef/j6YJq
         2KZ+cyGXn9FHWsqJZIi9U2i6q/j28YQLOFXT09Uayimgi27WNzM5/cmrOLDGFVGuWRkl
         qIbiePLZQFCNJdadMNfs2QympR8r3o4FMA1hFNeSpGv4Q+Xvb+Z4WJE7PC1Jtgrw6Jdx
         QNqj7iC59N0V/3bul866uuLz309Z1aSClTTDuB0u2MKeC+D/SfjCamYWE0LIuy+MIIc5
         Yrfp5SDQeMqupjmK7pbjDJuHRUPRIfvcZM96C61Q0eGLi7xdfWW3OS/gU5omkchbR08l
         Lu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SFlBaRGOxuhPAwXvTJE/AiYZZaKxKu8ThTgPykAaza0=;
        b=dKyh+COy4pAZtgjVJCXbCU1/8VnI38IL+s6VMA67UePeRia1/RkhsrYwJDQASZrrm1
         wk+J/v+Cbe0Q0Lj3XWU2x7orX4fr825+QsvdoII3FVsq7pS3sSPoUrHort0FaKbz7IWF
         J7oVTLsZZwkMyC6PvUYDnnxRara30l398qOOmrrWZW9w7hBwdTD86wgjOxnnugMNnP6t
         1MYmYH361u5yZyScjsFN9NzfDRd9O+hE1EvHu97Bpd/96NV1uzqdshvQ5YloIRwO/duR
         Ey+01O2hqGdOBhXi2PLj5UAUy82YuOBPnVb5Ps0sFjIWtfYesORbMoxOQ8awEXFTs55p
         IOOg==
X-Gm-Message-State: AOAM532KvkMU53tRoI/Dn6kg4D6hW9afmBj9AvFe1NmpC+u8b9G4XJ8g
        KLmo482tEQSW7uqPZjVYgxQeMBEw1xPW
X-Google-Smtp-Source: ABdhPJzKU93p74GVyVbbASrTciFsRryyNFhnkIk2vRUZumZEUmB8DcjKCs18TvyxfzPY1FJ1tmbZBlqUdj/r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:5755:: with SMTP id
 l82mr19858272ybb.175.1598416156455; Tue, 25 Aug 2020 21:29:16 -0700 (PDT)
Date:   Tue, 25 Aug 2020 21:29:10 -0700
In-Reply-To: <20200826042910.1902374-1-irogers@google.com>
Message-Id: <20200826042910.1902374-2-irogers@google.com>
Mime-Version: 1.0
References: <20200826042910.1902374-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 2/2] perf parse-events: Avoid an uninitialized read.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a fake_pmu the pmu_info isn't populated by perf_pmu__check_alias.
In this case, don't try to copy the uninitialized values to the evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9f7260e69113..3d7a48b488ed 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1533,19 +1533,23 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 	evsel = __add_event(list, &parse_state->idx, &attr, true,
 			    get_config_name(head_config), pmu,
 			    &config_terms, auto_merge_stats, NULL);
-	if (evsel) {
-		evsel->unit = info.unit;
-		evsel->scale = info.scale;
-		evsel->per_pkg = info.per_pkg;
-		evsel->snapshot = info.snapshot;
-		evsel->metric_expr = info.metric_expr;
-		evsel->metric_name = info.metric_name;
-		evsel->pmu_name = name ? strdup(name) : NULL;
-		evsel->use_uncore_alias = use_uncore_alias;
-		evsel->percore = config_term_percore(&evsel->config_terms);
-	}
-
-	return evsel ? 0 : -ENOMEM;
+	if (!evsel)
+		return -ENOMEM;
+
+	evsel->pmu_name = name ? strdup(name) : NULL;
+	evsel->use_uncore_alias = use_uncore_alias;
+	evsel->percore = config_term_percore(&evsel->config_terms);
+
+	if (parse_state->fake_pmu)
+		return 0;
+
+	evsel->unit = info.unit;
+	evsel->scale = info.scale;
+	evsel->per_pkg = info.per_pkg;
+	evsel->snapshot = info.snapshot;
+	evsel->metric_expr = info.metric_expr;
+	evsel->metric_name = info.metric_name;
+	return 0;
 }
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
-- 
2.28.0.297.g1956fa8f8d-goog


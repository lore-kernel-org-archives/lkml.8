Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D8C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8E72173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WeDM5+Rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgEARd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730228AbgEARdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:54 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5E8C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g23so11963639qto.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ew1Auf+JJ2L5arU3PyljE3NdvPut2GJPZ3Rkkz6XalQ=;
        b=WeDM5+RdZ7dH3DFo0aBUrEsPFP8vzWQmnppHm09r5q7WKGFqmVsPPlkdfxbAY5+lfS
         QpA6kgy9uJrgX0p2LFeFa1utE9TBPG7/TzrYVxwtvG68t5k/TGxQQFT/MQMu4lq/kL83
         41CHXE7QwfTf0ZtK7Iqy1TdPrQvBDCgTiOprfa84TzwRfJ0lsF2MmBZoGu8ecIKtG06f
         3OXtP7d3P/lWp17O1a+izLlcdqrV3Adjiw9Ci3kpvCq85p//p24BQYbSmKFInEBqv0s4
         uDaELLJGKZHki3Zbwg1+Gk1VImRqDMzI5jaKqyRKMDNSQw5O0Lsf1qOFQgSYFf2vmMMV
         fzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ew1Auf+JJ2L5arU3PyljE3NdvPut2GJPZ3Rkkz6XalQ=;
        b=fSRu301IPLcFW5u3vsexK1bP3nOAMvW2VmK8BvgXgfmtQjYErrnv5ozvbZgUstZuzY
         Ct2AHbcy8u6w8GPB/cp99x3i8N/vlTUChL+AhVwMuvj2TlEP+MtN/H13onEhc70qgwmb
         7esV8xCXoz+RgxXGUj6ysstVOBnIoqg7sKPtyXYQYWPLLHxyO26CGjtKQIAqTxgwHscV
         NtqXxsTzXMkBDznxV3U4zGYDde4oME6WbN9N4AMCA8lFywj3RZJCdaKoj4se312okptm
         iKmAqcrfGE9HMh/3NgR9L+LALjjiKSkv7vlfkYAIxW8fITfuTx9NvE0FGcAsHXprhIEF
         siug==
X-Gm-Message-State: AGi0Pubkmfvz0hKyKEOI2BvmwwOoG1HiCm4pFI5zVaqoTptb2rzz7dL+
        S6Gm/Lr2/fyzMAfaRsquovh3M+WoXN7h
X-Google-Smtp-Source: APiQypJ8g3agpEUPhmMkGqpqhKX/Y70GG5wtBz9VQ8W6aJEyZTlQtzqxF2qELoAx8Ym7r0sbKuXVJjVDVlq6
X-Received: by 2002:a0c:c2d4:: with SMTP id c20mr2012529qvi.246.1588354431922;
 Fri, 01 May 2020 10:33:51 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:29 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-9-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 08/12] perf metrics: fix parse errors in power8 metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mismatched parentheses.

Fixes: dd81eafacc52 (perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index bffb2d4a6420..fc4aa6c2ddc9 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
@@ -169,7 +169,7 @@
     },
     {
         "BriefDescription": "Cycles GCT empty where dispatch was held",
-        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL)",
+        "MetricExpr": "(PM_GCT_NOSLOT_DISP_HELD_MAP + PM_GCT_NOSLOT_DISP_HELD_SRQ + PM_GCT_NOSLOT_DISP_HELD_ISSQ + PM_GCT_NOSLOT_DISP_HELD_OTHER) / PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "gct_empty_disp_held_cpi"
     },
-- 
2.26.2.526.g744177e7f7-goog


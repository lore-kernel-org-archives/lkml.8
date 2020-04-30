Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFA8C83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8732082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pB97rEoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgD3HwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgD3HwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56856C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e17so429224ybr.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=z6RCPeLeg8GHtnCBmoAnY8PtzmquIskHIJdDgqEf49A=;
        b=pB97rEoGEMvDgAOVM3/SS3ANf63agdtNeb5H3GJEivupcaHtwa84F6Oy74dIsp4ePf
         wmwTkTA0EiFnua9fGo+DAVuD56Dtgtv4pghpR+iopvZyh9XhbDJLPHtC9sAsG/pctRTh
         Xd24mGZCW/Yf/hEcexzSJaz6iSz2uNcwjGto55S8JSPep/v5YOEfgm3uvRu5QdHNvdCp
         oOh6WzGiZy9pAlssduLSc0hCI7zKGK3i+nUxLFKlScTrrD9U72SqpT47B4XkwnR34l5v
         GRscBkXelc6MIemltGxIOtyrvWEIWy/lNuUSSZ8bMdPOIsX2sbgzA6rCIs50MKq4vgtI
         5gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z6RCPeLeg8GHtnCBmoAnY8PtzmquIskHIJdDgqEf49A=;
        b=cSc2xHAc7y24BfLRedPrBTyblO7DOXK7EsR0/cNTE68sGiQmk6jMGVpl4KbNZNUPcI
         wcbOTXgq9B0lpRHtdQdRe8Op92SwzOPz9GyHFspAhvMf6DpvLo3tpM25xnO3TnCD2S6M
         CjfZzlcsw2SzxewOOeusj1E6u9FEtaCxo0rdHkV1ccg4Kugno0MYgJuGX9N++IOOCxfk
         ++RPP9WundZ2idVxkTFKXTUmPAAfjhTjGehGWInJ5i+/OkB7nJvvY4N71Z4pPw7naTGO
         eeirL+a4zX+7b8zxvTY46OITy/c4J9prqTxZr+24YC10LW4zUCGcJDnTVhEiR7Un72J9
         +69A==
X-Gm-Message-State: AGi0Pub/QaASeo6LGK3yznHHvbXXlMtVwA+TyGBhzoAh+RBIdCNMqrG0
        1Hwt3GxD+lMUlkNTlEEWI6+5BLIoSA+0
X-Google-Smtp-Source: APiQypK7bpMCZN6E9Gv5XaZqDPdG7qZyjWGawvZEWiw7UNye3sXD70UfhtexPHRn/954n+rVMB4m4E6Ze4pO
X-Received: by 2002:a25:1a02:: with SMTP id a2mr3510465yba.168.1588233122566;
 Thu, 30 Apr 2020 00:52:02 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:40 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-9-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 08/12] perf metrics: fix parse errors in power8 metrics
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
2.26.2.303.gf8c07b1a785-goog


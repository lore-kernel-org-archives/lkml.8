Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CFAC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0188C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAbHg/+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD3Hv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgD3Hvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D89C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y7so6745924ybj.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KS3wSxmliboWi2mGLeXKN68yB7KYaubNspKgAZOFCn0=;
        b=gAbHg/+hXMvembBWevw2n1I1Ar+XyWkV2pup3syYAeV6s8fsm+QSJ/H1IBIlr/LLsz
         ZB/EhXfpeb0QLEsZLXs7FlC+8sjLjz90bGThQ2WJXb/GwftZ7XG1gkvod7hW5+fe6Nql
         Dxl7ePst9+Symlxtj3RmXpvA8PYCsU9GhBbz/ao5XEAlSK4HUUKSBkdP8T//39hcgcZV
         HWYLNDS2wcZIHmnogaTWrSO8H3aFP2z+PXCKdkwubyykLYVKltAzHMbzhjkUkvjbPrd9
         6NVrAOonwdbQp/2ctvSTxmZqB0CngKr6oe+JjdC89ABkbICuI9EF/ssqGOKAjOxrYRcW
         PDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KS3wSxmliboWi2mGLeXKN68yB7KYaubNspKgAZOFCn0=;
        b=Mq77IvUFzvglWY1Yc6w5d3xCvZW6AppOb7MgRmzR5kRcsxHfc/qKz3Z21MnHm4I3yP
         7uLaMusAKyDoNqd8Ym3LaE6w5fBu0TukMIPePWLhhwxbcZ2inOFL6axTuRpc3/CXRR4a
         qg5OwnC4nYaN/PvEJcRP8bRj5LIYd+w46hKfJGTMis6RPvIDZoMPIsH18CbXbe8EFT/Q
         NjDQpEu5gTjLjFMSc2Px/lvK0diczWE8PFv/oSb4PI81PY66zW8svEwqxKEclyZq3+kg
         3gsR8LNjo8OHJD241QTn40+Jl00WxCCIdlzEcLY/GhJpJZfewkX5A+xXztoPdIErhqak
         hA0g==
X-Gm-Message-State: AGi0PubSUKNfyYotxHzAKOENXXcDMRgAVpwpSZOoW99SYZhKUi6EIFoc
        aKWUvPzUDAeMSPE8A+ni0FJT8AEr3VU0
X-Google-Smtp-Source: APiQypJNb5QMzXJ2JcKrBZrSuc4XSsOfoe8+AZqWh3+5HF1UIUVVK7eGBFukKTWU8LVWNBt9peIW2cYO34Gu
X-Received: by 2002:a25:b951:: with SMTP id s17mr3747425ybm.205.1588233113140;
 Thu, 30 Apr 2020 00:51:53 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:35 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-4-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 03/12] perf metrics: fix parse errors in skylake metrics
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

Remove over escaping with \\.

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index b4f91137f40c..390bdab1be9d 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -328,13 +328,13 @@
     },
     {
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x35\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+        "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x36\\,umask\\=0x21\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
-- 
2.26.2.303.gf8c07b1a785-goog


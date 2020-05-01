Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C7CC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A892166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8q+677q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgEARdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729744AbgEARdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4540CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n205so13068102ybf.14
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A2CqCWbomYGlREhGlvIy2Wyy+nj5upT0ckyyzFHG6Ps=;
        b=P8q+677qDZBDApIFJ9xP1pt212opYiRpb/xiiLDNCxHCCSAm/ECxX2FcEfBmAEz92+
         KwqI4sNV7Y4m10RNAf3XBQ72cq1hKJkQZ3tvfOuOfLdpl1d6IVG2B9rX400cl9T/aqqQ
         /ccwEL22KoTTjuqoE7jCyNAHCOJYfOPBMACFmBimxfE2QrkTynC5YNEJys/CMBqR13wU
         xlUGn/RwKLLb96Hba4b5HUIiegC1saaFyiR3SJWH5UyFSOapQUHauz4V90LTt0H3BGRx
         sDziTukTaqYPM3w/qu00hcH+mnaImZQ2EllhsigKKwo9DFoDaRGG1z2S6RSElg5TjcGJ
         /Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A2CqCWbomYGlREhGlvIy2Wyy+nj5upT0ckyyzFHG6Ps=;
        b=mUQbVtwifqfeyxdwdD09Y8wmrnC1SvpmzIqSdiMYE31VFzLQPCa4Ze0gP0sGzU/kcD
         uV030q39jznWX7Ka9ESq0K9H8J9xRM4qjzbcqYG7D0n3Sb3eFoOMKE1gBhdqW5fvPQhL
         dwDWwdJ4jcvGOThK3ngUDz21M3iJBg7/nTLJ3zrMISaE1huWmlzREOIq9E6a5ZhHwtIV
         kRdFWUoX+YAKStAs8i8bx7bgg8IWosYEED8HHSlbADBnNbsYrUeZGsd/AQYdAufXjxXQ
         ELknkpkQyIfYyO5mCakkWyiNCFViUPf9qeEuNMyKjgApFZMzY7zyE8ueTkjm4ZfI5rfC
         3/zA==
X-Gm-Message-State: AGi0PuayORWCVs+r7VIr/Ux49YjM4e+37xcHSx8QozjtsH3xo15lvLIS
        oveFouM3CvSbx7GKs1UsPlbaT/lVglLo
X-Google-Smtp-Source: APiQypKh29qS30PvWHpIAM1ezYOQXOtgPKDNde1s1oZKn3AJsbjOAbwyVENAx84VXlIP5Lu/UvDYf0ttLUBs
X-Received: by 2002:a25:6604:: with SMTP id a4mr7467835ybc.409.1588354420337;
 Fri, 01 May 2020 10:33:40 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:23 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-3-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 02/12] perf metrics: fix parse errors in cascade lake metrics
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
Remove extraneous if 1 if 0 == 1 else 0 else 0.

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 7fde0d2943cd..d25eebce34c9 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -328,31 +328,31 @@
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
     {
         "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
-        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "MEM_PMM_Read_Latency"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Read_BW"
     },
     {
         "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
-        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
         "MetricGroup": "Memory_BW",
         "MetricName": "PMM_Write_BW"
     },
-- 
2.26.2.526.g744177e7f7-goog


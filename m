Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABEBC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539F32077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U52iwhE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDVWEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgDVWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DBC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w70so2930738pgw.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9wYxdKZj/jWS2uBsJWtPB4xs5KgCG01/7TEpkkXSh6Q=;
        b=U52iwhE2FsO6oDmV+K4utiK5UsTji/ILE/34E+a4KNnkplHlrSKMzFnvVAEB11gK9A
         h3TBj1ZIwrZx6tSLh+UXwzycFLM21/zpc4IXuix79OwZo+rNK3xNHQTQtzVnjLIpxFkt
         6saa7mASGfnhwnIiodneJmti3Wkoct5ibrsApyCdNAS17GLKhMAI7GfI7SFaGBnjx0Ff
         VJSebhs6qL2xgXTuQBwQhEShdIQwxXz68AqqPx8HOrVcHCJsKcK+98vArF5vC0mAj+ZE
         4+bvLdFtT71WlcYpA1L0Kl5iEl43ILjshUWWNEW/Y9INl2tJ6T+7CXuO+isVPogrfGCT
         a+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9wYxdKZj/jWS2uBsJWtPB4xs5KgCG01/7TEpkkXSh6Q=;
        b=ndd5hbZ0R6xrmaIeZpYLsDPRRUWjkppbMxUfUrOf7Vo3jeYCHg5JmlL54y4n+FLo5C
         pnqvqNwonZjZg8w7BuzKU0xvR64Jw+X/rC2svVFrGcGil7I/Yfxpi3TvlvxE9GrpLflt
         Cdchq4MCUrgRa/k5HGpzjFi/HzphuxFdIklvdU+5SiDTHnXgmFPKiiQk0ELOhSZUyQBI
         /ofRcTnMtSJ3hBFp7kn+63jVuBh5+cLxW9dCqYHSet2MuHvREw8sgfH2CSTLGWa+1AkR
         Ru3juNzdV+JkSkGugL57FQ+guBE9c+VUyksfRW8Fkt2CyVRhWjxXOwtSzOGXZFpZdTaW
         p9Xw==
X-Gm-Message-State: AGi0PuYK2sUmPmP8e0wiB+aoaupFJusXtJBArC/Qi0BgmhGX1NczC47y
        3YizgDwS/IxEJr4VrDmObjvduMcVemvO
X-Google-Smtp-Source: APiQypJfNH0AuQ5IvmxJ+AFoOOshkAs3Fzy5nWoL3/XOVPU/3gRD2Op3ne/q1GRBJ+PeK++8JkZc2+ySKyh+
X-Received: by 2002:a17:90a:2f64:: with SMTP id s91mr971942pjd.30.1587593078800;
 Wed, 22 Apr 2020 15:04:38 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:21 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-3-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 02/11] perf metrics: fix parse errors in cascade lake metrics
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
        linux-perf-users@vger.kernel.org
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
2.26.2.303.gf8c07b1a785-goog


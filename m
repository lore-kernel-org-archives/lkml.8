Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06B2C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8554A2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/PFZhhf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDVHsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgDVHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:18 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2996C03C1A7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id bc2so1320603plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xFdxuB5ylPzHM6fkfhgDwSZ4maHnp59tTnnEVkFTcBg=;
        b=j/PFZhhfulCJZAOWX+vVV/gR+c2H11IPNzxNcGeM0hRRZ0gLWpVBBAyynqclZQguCR
         59slB55fyVVANXI6U3xwwW7S1Kepum8UgsqfJnbko39eJUnA7xHjz4YBtcoVqeX6XdhO
         2kDxHW3cL5+h+DdlWcDOVNSwStgKJ/YBQOF63qyK92zVQCvthwpLyw8P3MnGGhFY3D5s
         ECLCvAAkUnFiOlsPlZvx61pyLrI+HFnt1DimXapGHRveF1md7pZhlaADWzES5wAX7gCN
         b9pYoCiRdi9T1VxooN410oP6emJ1FObwjDfQ3wqTQ5QBjq97qnTsRnEQ8cYH+Ju/WKkz
         XMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xFdxuB5ylPzHM6fkfhgDwSZ4maHnp59tTnnEVkFTcBg=;
        b=RHUlhOyPi6Mvgwqz7IwSv9+N5A/g0qoYYpWt8V1QQp+ZWZhFODSrjpwNYtuOy+eXY5
         lAHfbju+PaMEFFUdKDGwG4Qlwr29oCy75lDy9u+U3BMl66KBqIylwiiiPtTpoZ2nEYqa
         rL+UqmkmNCKlUbAKMr+K9x4Qn7bSzSlQaYKuLkMJKWf4hV0rIDEXNU5wVrCeelm2HOcz
         +Oy+kjGcGXzP/NgG5uDlGvmXLVE/2j+PpnnYsKhXS4Q7ucDDOyYvkVpwf9Ny/PqHkSdv
         0NM2I9KIljY37R9Wl8Dh/dxZfZmy9jaA/05VqL5tVI2Z3mxvXuQauXiMthF+uFMx5MWy
         D0Ww==
X-Gm-Message-State: AGi0PubCgA++n+dsXKFrrC8qqrcZ2EYuUmnGhU1QcleNdjE0tIpBGIL1
        ETou3gI8oparz+2Pxrt7umcUjRUgV2bU
X-Google-Smtp-Source: APiQypJjG4+7fxZJvs2OyFh8L/NQpfPT/oTPGbhxnDyqsTP5PDTB8UJXDCYnwOx2tXbnUork8vwxpZSYKMs0
X-Received: by 2002:a17:90a:19dc:: with SMTP id 28mr9425073pjj.184.1587541698173;
 Wed, 22 Apr 2020 00:48:18 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:03 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-3-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 2/8] perf metrics: fix parse errors in cascade lake metrics
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
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove over escaping with \\.
Remove extraneous if 1 if 0 == 1 else 0 else 0.

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


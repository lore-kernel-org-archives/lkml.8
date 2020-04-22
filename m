Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE4C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FF0217BA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKw4EM/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDVWEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgDVWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46CBC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x3so3043367plm.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KS3wSxmliboWi2mGLeXKN68yB7KYaubNspKgAZOFCn0=;
        b=BKw4EM/YL3EzKy5HH/pN8TyH5OQWiOX0aNEOQUGsom1MpGyz73syl8um5ltZ93nqtX
         qrCZVr9exN/5Cz0ShgfacRnZ+24johrYYOQM+DDSIPfmns+3T3DDlbOopGX0/nC50Mvv
         Le6c9koBxIriLrwab1HHtx/ynU0omWWpqgv80eyKjOJH6P8KepqFZbrgyG0PiCMY16fd
         65WHZXJALucrw+k04CkBVH4t6U3un35kGEkS63Gw8hhjFwNcCAuSBDCXFqsrFtc/ydUM
         verxqPOuYZYR6S6PSunhf5CWTNzijlTTUm2dSgFiXXsikVHe5T41Pj88AqFGtj0/DZDe
         c1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KS3wSxmliboWi2mGLeXKN68yB7KYaubNspKgAZOFCn0=;
        b=pw++o22hKzakMvYR5cEQGKzJ1M6jqO1tz7yBVSFffPj/1Up9W2b9EEfP9Voh1Vf+V8
         q6mv30GrdygPT+x6d/O6bxr9J25esVWB519Q6zczd5TLUDsagsmJ6QRWyYPMmKe9rqUE
         Gk74HDZN+AYk0AsToUUhcmBlXCfFs+YKAXS5sojtTQ9w/9w1tZI2JvAllKoBxl/Buyx6
         op8NDl4jp67gSMcrBC9FadzBMf/H0HxdUpjyTDnvRu7Pka/W9pMNzohwnLhavqwUBjf7
         Lq7ue67hx+oILXC3+Hfw2D88TVtAFiK2qE7Fc+s3b/OqHUd6e7dUqTNg/KQ4idEIJr1t
         UW2w==
X-Gm-Message-State: AGi0PubNbj/g5VmTdXb33UYijabGuVLrPGItN93/9sYwW4SDvW+6AQSf
        0ePoAXZRua9u99kR3Lsz+4gVSe6I4kLH
X-Google-Smtp-Source: APiQypKh9HzubCblwpK+lrpgCQGe+F8tdad8FnPm9N+X8nso/RC//XSu2IWIrgDttnr6wevjqF5vjeUdXGP0
X-Received: by 2002:a17:90a:32ea:: with SMTP id l97mr923677pjb.50.1587593081263;
 Wed, 22 Apr 2020 15:04:41 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:22 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-4-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 03/11] perf metrics: fix parse errors in skylake metrics
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


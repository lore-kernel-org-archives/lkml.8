Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786012084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpt+01Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDVWE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDVWE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69561C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c190so3362153pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oAqP7W1R/rWeRnCp5eohdMy0vZSSIvqsCqJsvvhhCbc=;
        b=dpt+01Dxp1Ig4ZuFFsq0LeyS2p4dzFBIeO+309FExsz0BizUT4EQm0nqqVHf4Y7jp8
         bmftMI/i0CUyCKZHt2qxdp3I3nhrtuOM/VJn//+ovkpLXCSSAYVLybrQiVdPZz4sPRKW
         wd5oK4kMzjHcUBEn3aydGBmqcKtuXPiM2aJ+O4C14Q4K0zWKGaq4mhRT5Q8+G5QxaX+F
         QuZv0ndceG6R7a0fEWpY6Zk73CCxN+nyo/L66vOckuV3bOaXbp8UZmd9D1hKgROviSsj
         yx/drAkLx90WT4OPJ61CkPq6Jz2HXfhaBz7ceGHdq7wZkSdr2q4y39YT/2g61sSTotIf
         dwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oAqP7W1R/rWeRnCp5eohdMy0vZSSIvqsCqJsvvhhCbc=;
        b=Gx5tkjXFvNCsG0+hrfmVaI33rZ2MZlBMe2I4HydN1FqNXuG/2IuMcHtT9otEvGs5SB
         b4wjItKJQaVoxEaHhrvC7oLACFioanq+UiqXlq19JB6llMjgUM8fDf64V0GMhuFgaBkW
         u4h3efO0VjVH0zcXjUEGPUYCNpXND9D0MpLylDQBcJJmNv9RYUvJ2E+cvK27ee6O0zfA
         jkIAXj1rxjLqi3urPVh7EwOQ6UG0qI32tjPqGHTuxnk6HnQ4apcI6Eanvg5yC4/L2rni
         YwNQTZrTrYZkGz1vbKCTIF1RkowFk+hdR61f4kh1ACBNuD7weO6XWkt9HWwYQlIFp4d6
         9eMg==
X-Gm-Message-State: AGi0Pua9/m6UxQirVaeSTncR6WKEXdUlVnKMxt3yQDhxuhwF1i6e4Q2e
        4OXAFh1c7N05bwdRHzLoK+UAFkpymrSP
X-Google-Smtp-Source: APiQypIQ7vI6a1YqSpcsaxKNBrRNaNwqASaQTfhAI2I8fELmqoZ/0fm1LrunajBzgkSUaN7zWC/OUeDANrIi
X-Received: by 2002:a17:90a:ee84:: with SMTP id i4mr891584pjz.71.1587593095931;
 Wed, 22 Apr 2020 15:04:55 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:28 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-10-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 09/11] perf metrics: fix parse errors in power9 metrics
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

Mismatched parentheses.

Fixes: 7f3cf5ac7743 (perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power9/metrics.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 811c2a8c1c9e..f427436f2c0a 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -362,7 +362,7 @@
     },
     {
         "BriefDescription": "Completion stall for other reasons",
-        "MetricExpr": "PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
+        "MetricExpr": "(PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
         "MetricGroup": "cpi_breakdown",
         "MetricName": "other_stall_cpi"
     },
-- 
2.26.2.303.gf8c07b1a785-goog


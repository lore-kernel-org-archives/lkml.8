Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE843C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6762173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAe2Wvyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgEARd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730274AbgEARdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:33:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF7C08E934
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:33:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w6so11866388qtt.21
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lii6SAG4KfbOzXrghsoca6pr8ezjGocIYdgnUdeujGY=;
        b=FAe2Wvyk1PKorR7K5XyAG/x9gHpd7/AbwrGjN+S/nqNr8AX4NX1o4DjTUhfks6h0Bp
         ZJY+a/WRC5ZgYmji/ZpMhLjGvdXoyv3gJVCt/fCxLGA3Vqrw/84Lzun2TFXmcXt17tHW
         cfxDzzVLHk7LxEv+9wjhLXii528+Q1h7axvRHe4+d2GtrVFPdwnoaifjKFHXspw3SVPg
         BJX4cvJapZOFCwrKeBUFcgyGlIvmlLFCDyHNfSYLXlKb5qtTyDujtOHoWJ+MvlYklQyL
         YHONBDudwcxbJAI58U9DqTgmGxLbCrDxyhvR9Sg5rfXQaT0QMeUADS83b7K0rneSg/5+
         BF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lii6SAG4KfbOzXrghsoca6pr8ezjGocIYdgnUdeujGY=;
        b=KVzfYvO0vh9CpPX3hySERJ8rXUJz9zDvvwCvU5YC6xbjzKHpuEmXVzkS/QwXZO7Zg8
         udH8CpWvEVaB+4c6FVhXTgXwHjulohAzsgl3Yl0r5pNNyap7FoF3HVJoTrpezE6/kzzR
         jBYGTixtrlVA48nwhvXPAu8x8PyvaOEUqL38hwKnDCHen+yzsdOirqz7utTWtqKEoFgw
         npvqRvgwKuXmfAO8qIrLUPiJnFm6q5V/uTDgo4NrjRzjNDdOjt4ksGmnN4cQgQu+7sju
         x6nZmb0J9nr+mdAsjpueFUBd3V4z33krbxxuMZioz6MmqRG8B1OC3m2m/Q1I1QPPJ+lu
         8iyg==
X-Gm-Message-State: AGi0Pua/fJE7m87oIL0FxEinf0afuffDeCk41AunKcV/w0HeOM+kywIZ
        u/wRO6XS11AiaiiG+zEGIOBTYdPcs8Ns
X-Google-Smtp-Source: APiQypJETVEMekWipPPMLFIikliBvEuRqo6Ettp5YLv7kVcPorH1HOpfbfoVS8CC5N6NcMlHdM0ps5xLGMuW
X-Received: by 2002:a0c:b5c4:: with SMTP id o4mr2616353qvf.229.1588354433816;
 Fri, 01 May 2020 10:33:53 -0700 (PDT)
Date:   Fri,  1 May 2020 10:33:30 -0700
In-Reply-To: <20200501173333.227162-1-irogers@google.com>
Message-Id: <20200501173333.227162-10-irogers@google.com>
Mime-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH v4 09/12] perf metrics: fix parse errors in power9 metrics
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

Fixes: 7f3cf5ac7743 (perf vendor events power9: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Reviewed-by: Paul A. Clarke <pc@us.ibm.com>
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
2.26.2.526.g744177e7f7-goog


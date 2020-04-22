Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A130C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220D32084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U78TwxqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDVWFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgDVWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:04:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A45C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id v4so3393252pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G2xrre78+ftU1oJoCW/exxUkKUD8kGPaWluZ1hoDbqU=;
        b=U78TwxqNsHI89Ogk7zPRBRxNrrZz7s6GoxqFdwDnh16Y8AyV1ozBFeJ9cNqawXYVqy
         HtyzesSibD4jes0LTTZq8QlvN2eEeqizvhPvApwefxRFSikoWndvs74ANf9DgfN5OcVh
         ZTZgglfpAmBQLRFpmjyVN3FgIMQVcwl+oZRAMEARbEjLL8x9rBLZtlPzbLmpjYZ/yIAz
         JnoXq9QcHkfHdwFpYMfOhSaxXRvZxDAU+siByyaZjCzyCjYsX9MFotuu+UpV5CiecgCG
         BpBzYNt2iCoqkTQZvb+8RigFr9SAIXn11UmDcrCBu8PhABd9I6pA1ycf8sAbCSLcUT48
         M+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G2xrre78+ftU1oJoCW/exxUkKUD8kGPaWluZ1hoDbqU=;
        b=PhijNW94tLIoO9/hPRDfNQ0tcLAXzOlPaUAJNoJyYNfBMcmEljyxrIKudQvbq1gdhJ
         +AUrOTWZ9V+1iDez7+4YgZUnGO/GHTJBQUia9OgR3FJ2PpGw7kJR8rmddkVt+kq/Dq+r
         OZsufM0VqSAPxCTjiWh9k4PmL5Zh7ICoj4euCAROtCLchnKnORyliTn6FokmXP+kIX1Q
         TXtwdQBk6VuWartw4jc4fyEY3RSosnRB8I/nwnkhk2/NfbihpAyp3WkKWuyEEbHaSwwE
         r1UUBtWDgyGJnlm7+zbkvUVPS/AMOZvV0noauw9P72ZXB+JT+SD1ki3UAIMMUiwIZc41
         jQ3w==
X-Gm-Message-State: AGi0PuZdJc5xGOU3zzjwEwZAjNMn2ldFAMqYDzHCRPgl2pxzAHjuc7D8
        XBEA6GaYvARyela2Q2qxgUf6ZwWDowy1
X-Google-Smtp-Source: APiQypJ+ojiFc3cdqxEICVUXBxwHbxliEw5QkVoAkgZBMTuy2F8/4YaPRqhR7LgprYZub+2dZ5bjNfypMoJh
X-Received: by 2002:a63:43c3:: with SMTP id q186mr1047417pga.411.1587593093688;
 Wed, 22 Apr 2020 15:04:53 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:04:27 -0700
In-Reply-To: <20200422220430.254014-1-irogers@google.com>
Message-Id: <20200422220430.254014-9-irogers@google.com>
Mime-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v2 08/11] perf metrics: fix parse errors in power8 metrics
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

Fixes: dd81eafacc52 (perf vendor events power8: Cpi_breakdown & estimated_dcache_miss_cpi metrics)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/powerpc/power8/metrics.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/metrics.json b/tools/perf/pmu-events/arch/powerpc/power8/metrics.json
index bffb2d4a6420..ad71486a38e3 100644
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
@@ -886,7 +886,7 @@
     },
     {
         "BriefDescription": "GCT slot utilization (11 to 14) as a % of cycles this thread had atleast 1 slot valid",
-        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC) * 100",
+        "MetricExpr": "PM_GCT_UTIL_11_14_ENTRIES / ( PM_RUN_CYC - PM_GCT_NOSLOT_CYC ) * 100",
         "MetricGroup": "general",
         "MetricName": "gct_util_11to14_slots_percent"
     },
-- 
2.26.2.303.gf8c07b1a785-goog


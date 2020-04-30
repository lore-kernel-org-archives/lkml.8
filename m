Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D46C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BE9214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cY8VRhZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD3HwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgD3HwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CABC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:05 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w9so5526355qvs.22
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cC6pmADD76UvC0Qb0TU0b8ZAV0fwBzkXxzIONSUqD6A=;
        b=cY8VRhZOlmGKblNNeVBGK0o7Fw5SK9sIWsbmmuZFE3bdbKvTQ+ccbbZl5Ci3quYUQ5
         8h2j6iU7nESek3M46IndmoGbrgwLl8lGfTHiBBRnrOqUE0CPyqwOkXb4CJy/v+0PdDif
         R7KcUJlr+XHKztwPLd55ioPoql3bCDS0Z2QHOeIw+pT2PevGo0MbtAzAM7qycXxLXmUj
         vGXkCR9cTCbPbHWqsakD7aTYFjg+/e9W8lspNnEYH5COuqC0DQmCZEXgKbrEM9Yr9v61
         43rqKG5kkY8S7UhNJ0THREBexD0TvaeYkSdBOJ61/8DW5zCmExKksY/j+EOFpkBbyLvP
         kOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cC6pmADD76UvC0Qb0TU0b8ZAV0fwBzkXxzIONSUqD6A=;
        b=a6kB/ZpQuYjq5t10oqgnHVMUe3pBRqsMHWOcZlqEFxrAIYN5aK9+MdYiiNUI7Rtyk3
         Z18x9GZRdpCOl0PSN1gVNUO9YtM7CllZ12i5K6S93HgERJRVHEAmnmuIpgCZ7dqMW5Mu
         +D2/6JrijrEqKyn+nawUJrKx/Ce/vibfhJaALpL5jx6a9ID/AidftHxd/9k5yguUC1pC
         JJoDGlcl6J8Znqg9dtDHk2h5y4oFelYCYHc7KPGN4JykTGE/zGQOUo5vP6abVxJq39Zv
         OKEjc2lkq/PTOlKxHRMInKs3c/FaHyNN+dueZnhvpRWrIKNCMtkUJXGURmNuYshENODC
         ekjw==
X-Gm-Message-State: AGi0PuZNeIxO0fUuxd9fuRgy9SX6mjU0esENOGg/SJNyIWwct29Vk+Cj
        OJJa5rp0oajWrCzUWu4C+ICvYj3oDoSV
X-Google-Smtp-Source: APiQypJZ0rCCu6YxuH8zJLue3bHMxOH91B4iGfS1jMvCtzqeKDwrUrA2vH6dnWJtwgtiSmVeImj+GXDtoK7e
X-Received: by 2002:a0c:ef12:: with SMTP id t18mr1759639qvr.9.1588233124346;
 Thu, 30 Apr 2020 00:52:04 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:41 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-10-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 09/12] perf metrics: fix parse errors in power9 metrics
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
2.26.2.303.gf8c07b1a785-goog


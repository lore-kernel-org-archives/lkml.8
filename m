Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28AD21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZiGj+4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHFDH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFDH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:07:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D71C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:07:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i92so4074413pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l1CgKljaVtAweEK4Ws4uaB+xUTC2A7B0JkOe6RNS3OA=;
        b=ZZiGj+4ip48sGehZTxTKDtBVlo1JkjVf7KPpIJ4RtMaFtcuBuprOio38JoHfrKvUU8
         P1RcXyluOWZfoGI2OBVFrFy+ZkgX7A0KqTm7gpM+ndY0Wsxn3zSxYzinL2XQNCwL6mlq
         0LLDs5tUBrx8bmFWy40Ko32oFcdvOfcHQOgyVevDEVRGpKI3ZEGrPqAHjtjrNmUbMoEQ
         5gdgKMlmSW34u+teNla5xRJnhSd4XrLlJRBWlkWHQYf1C+9395hgJSKR02IA94/nk7iu
         /diTEAb1f7GdN3BCJXtdFJVqrELJXFUpA5QpKHFCmD7V6lmktZJrdQTwlSnpS1etmHyk
         JaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l1CgKljaVtAweEK4Ws4uaB+xUTC2A7B0JkOe6RNS3OA=;
        b=bTxIYVOjd6goww+8ql09dQQ4qUJ1RHbVCu1ofOzPpwm4om1LKzv50dw+8X5UJnq/fq
         qDHDiXKMrlvb0Mvh7Fgpij7rU8U2aBrBg7rIgnjhRWVH+++vsbcQ2xN94CaGwuURNtDT
         5Pf1jYSgv9ePTr0qeg7NBDokl9qX/MiwQZXhFvp4ugdlDLMmrWdohqWKkGvttxuORsxP
         1zicFtFNZSan9WfvoC5tnz5GpnmZvHoX+6RhNPUiK+IbMv4aSe7HWzL62lTGBXvsLrNN
         SwHhdFPZakdnXFNPynvVcdgPe7c63CG8+nGNM7XBSeemsOHWXP0kQ5eq39h/XBkZafMq
         Rq6w==
X-Gm-Message-State: AOAM5305Vg6TIqDaUUADdu+lvTNwF7K+sXMOtMIFOih2/cK8h90gqDt0
        5prcQ+t2to8TB+pv69NhndNAKg==
X-Google-Smtp-Source: ABdhPJx0vcMZrlLjJh8TQn8Z43tm7NjQYNfFiaaitr0IAc+0t75y2yfkaW+5DvdrNXy1l5o6/+b6SQ==
X-Received: by 2002:a17:90a:3ac3:: with SMTP id b61mr5914669pjc.1.1596683276202;
        Wed, 05 Aug 2020 20:07:56 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id v128sm5665999pfc.14.2020.08.05.20.07.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:07:55 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 01/11] perf mem: Search event name with more flexible path
Date:   Thu,  6 Aug 2020 11:07:17 +0800
Message-Id: <20200806030727.30267-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf tool searches memory event name under the folder
'/sys/devices/cpu/events/', this leads to the limitation for selection
memory profiling event which must be under this folder.  Thus it's
impossible to use any other event as memory event which is not under
this specific folder, e.g. Arm SPE hardware event is not located in
'/sys/devices/cpu/events/' so it cannot be enabled for memory profiling.

This patch changes to search folder from '/sys/devices/cpu/events/' to
'/sys/devices', so it give flexibility to find events which can be used
for memory profiling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/mem-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ea0af0bc4314..35c8d175a9d2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -18,8 +18,8 @@ unsigned int perf_mem_events__loads_ldlat = 30;
 #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
 
 struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"mem-stores"),
+	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
+	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
 };
 #undef E
 
@@ -93,7 +93,7 @@ int perf_mem_events__init(void)
 		struct perf_mem_event *e = &perf_mem_events[j];
 		struct stat st;
 
-		scnprintf(path, PATH_MAX, "%s/devices/cpu/events/%s",
+		scnprintf(path, PATH_MAX, "%s/devices/%s",
 			  mnt, e->sysfs_name);
 
 		if (!stat(path, &st))
-- 
2.17.1


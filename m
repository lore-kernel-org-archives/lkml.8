Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78777C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F2C2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+ldFzuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIAIif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAIie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4659DC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:34 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so307102wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CwdDqKiv13j6gxEkvaxPCgHtAv5njMtVL6N5RbhQfi0=;
        b=I+ldFzuz7akDpEw/IprINLtKXcj9Eb+v1udgM4suKCzJEtBxzoUV6fOUhRnuu91xM2
         gBWzCON8+9+Otp1rYyQ8fkxLbuaHSzm3RqmoVXTdUo6QsUGWqipafznSnxLCcA2ba4Zp
         lpUFBt9ioBZN8iW9BXfPcRVHBrWZZjR34EZPbZ6rCUBeKHJRNZf9VcfIc+koeHBSA6pT
         8/1ZVEtuAal+CpKEW21MSXALr3PIppAzauhM7FssSrMjxKffiJSPiLMVI7NGiMWZisRH
         a/wkk17h/vJWb2t5LDDIrQcR9Z2FQJUxbx6EX8s/EtZJTfQVQrdOOlFZ7g3jga8G2y4G
         a3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CwdDqKiv13j6gxEkvaxPCgHtAv5njMtVL6N5RbhQfi0=;
        b=IuDn1agqisyz+dgwHSpXE4WKtZmaPeahCTz//vdtJRYotGgbex09q+vV3m1bNlEYbo
         GnDqyWlzkpMfKbStVLGFlCm87VqandkpZZeLGJaSFpdtVMGgpdMtPlgoRQq9+/0ixiY/
         yzjD5zRwRNBLLlLNbc29zwdAy3tFOLzOeOygKLCLfauUaYvx2dbunxQA/wGq6y9yLTf6
         xoJwNjkcXJEVnyilomngg9WfefAofMyhervr0fLnG/YjuGl5C1joqGcVLapkFnP2bUUq
         ibGBOOY6z0ezPD9EEDCI5dGHn1/KAJ1V1xprCgJg59tmDGEdLm9+vWKjC0cFfHUE7nrx
         TgGA==
X-Gm-Message-State: AOAM531q7koa7Y9LU1A23GZdfM3Wi7AqaY+xQWF3Lh8EXgy8nJIvzUzy
        UOfEDuoeZYsO1zwfvAY4uSc6IA==
X-Google-Smtp-Source: ABdhPJwcuuBPrF+TN4l2irgwT9uVGlH1kQckz0VR8evQB7BUKv1PzT0f58DHF9CXmExogUubS8lnbQ==
X-Received: by 2002:a1c:750c:: with SMTP id o12mr705641wmc.34.1598949512901;
        Tue, 01 Sep 2020 01:38:32 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:32 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 01/14] perf mem: Search event name with more flexible path
Date:   Tue,  1 Sep 2020 09:38:02 +0100
Message-Id: <20200901083815.13755-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
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
2.20.1


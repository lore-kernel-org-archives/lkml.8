Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF44C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC35520823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3Cj4Dhu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHFClY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFClE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F63AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so2009139pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KH8PtWnaxvnwwHFGyCimrZhOfK9VN6yVoALWm/4zs4g=;
        b=A3Cj4DhuQ087c+8Ma38CGOPQv2uEAMZ2s7ZZfq9h3zIVB5ajQZuMUn7sg40JGFkSmm
         z1h0wBzjwKDWN7ecvqtZxPsc6m4Wheed4LsqTQbuev2LHd2dPwpUtsbG7LcRfTxKnYW+
         sZiXtJLTE6QRPF2+BPshjXprw0OSLtYClyqTCXTrRra6hX5qO2rZpyF1G6suaZaksv1H
         giiukGkhnZbbmNhRTX0nLYd7tAynWj2keGTCRYqJAYbO1sO4hVnv8HksMUbUNt5xAoyC
         YZr2X3ZhS72JlxIpfkMqT05OSY+AONEwgpAze6v4Pcufc9UY93dORXkB1pFpXupG6vUY
         +KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KH8PtWnaxvnwwHFGyCimrZhOfK9VN6yVoALWm/4zs4g=;
        b=laPWVIAqXlxfUc4KsDh2yuqojvbdBQSIyqm5W+A67hIbg+8WBvtqeW60WIDyaun7Rz
         1lcLYF4f+tA0wtTyYhYsbRSczw8njM3nkoSAGMDBttAyBhg/+Y+PspaIrgp6Vl5JXKwf
         6Ql2XFn9uQ0XrnU2dxEoIZ/6gkHADTcwOGDHOX0jMMisB0/Q8ZtXa5Bb3sBvh57H/x2V
         EJHkDMLw/+XYncyHLu8JUUE6oQzZfwOwS7muRu4jHvzIfGz0kWuRBSH86mWc56G/9CCy
         Wj+Lm943XbNukVJnGCTh8HKrPwJ+AVA0xTDiHMaFgCgXIdj0ObQtfalB98jhQ3WY/G6N
         /cDQ==
X-Gm-Message-State: AOAM532/q4nZZ3VYzXPLsQ3m6TziM9LXgzFniM7EGRKkhbOuZ7/iwxv6
        JyTjw8ClFHcQP+aEc4lKkf2jPQ==
X-Google-Smtp-Source: ABdhPJy44706biEnhOhdruclfHbI5waOLSXwo2D4yPOgYCns2seOFu5MqW+vCXlehJScen6vbzBvRA==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr5949267pls.214.1596681663893;
        Wed, 05 Aug 2020 19:41:03 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id g129sm5280347pfb.33.2020.08.05.19.41.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 01/11] perf mem: Search event name with more flexible path
Date:   Thu,  6 Aug 2020 10:40:31 +0800
Message-Id: <20200806024041.27475-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf tool searches memory event name under the folder
'/sys/devices/cpu/events/', this leads to the limitation for selection
memory profiling event which must be under this folder.  Thus it's
impossible to use any other event as memory event which is not under
this specific, e.g. it cannot support Arm SPE hardware tracing for
memory profiling

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


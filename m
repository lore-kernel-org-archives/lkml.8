Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56D0206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GI2GAFmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgIAIjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIAIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:38 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89BC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so525500wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IGEV3Dj0zdTm4lmhSELRfe2JuQcrfwegpsmmDL1fTa8=;
        b=GI2GAFmtbTFP4ZAGaqgSkoAU4ZCPcfU20SlhK7FW7sj5XcZYu6Snoe2SmRMFvWwK57
         YhjsdZ+rGsjR6xHD/b4gSl/Q0CXeIeufzX6eY9Tq0tro7mleRcpCauFq5ShXbGHqHufH
         8fN1DsqduI9AQaCUJaICsp1twVeKao79bfllWOG11PSj6Z0q5I2Z3FtNYtN3UOhDmQEV
         uJeZGgX91Gtzh7Kd67sLiP24Nnj6slLbSL8YMeU9CgQnFSPfdMxzQ352+E6ZcsUkQVTx
         BpSMSZTTqrLLc6evU/jRVEfrRxT6AbHdZ0H9OD9X8Gsr7zVcYiEKp4LieKd9wXporyXA
         +OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IGEV3Dj0zdTm4lmhSELRfe2JuQcrfwegpsmmDL1fTa8=;
        b=c589TDBZBUFIHBfZsp5OALwnzAdwVE3LceUpV3osCQlHHtnQUMqzhYshBHAPwcmjB9
         9VbDEIBuPsMG8o+0VvjBulm9WdogqFrRlU05zGEflKzBlnxeuD0N/e+eAbaxZIfrEpat
         ukF5JAGUu0MTW2t23NJ8DuJK4umoih1k2fCgI4Pm5AcxIYA3b4k18TajATYwREeK06aZ
         CYJS+5zd+xlo90Q1u0q38iiP36FPJmomj4Xo5oil2AlOk2Al1fW5Ef74u1gKb+ikHW/X
         TkE6zD1htRzl78U/HQ0+bijro3mrYNKGV+4ADWrBP5El88I4MXVj/2pn6oxxSQ5icqCX
         dILw==
X-Gm-Message-State: AOAM5330vHG5Qe51YCGfWbQvJ52f/7KEg1DJahyFkpi0duJpjUwak6qD
        Bj8gpPx/MGsl8xMVOYGny4Dnzg==
X-Google-Smtp-Source: ABdhPJxybUjp8cHUS+ZIkgHyXsmi4fUsKMNukC75be0TqeXvw7GlIfZZdLLm0aiN6hunCuChMzlScA==
X-Received: by 2002:adf:b442:: with SMTP id v2mr687707wrd.213.1598949517037;
        Tue, 01 Sep 2020 01:38:37 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:36 -0700 (PDT)
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
Subject: [PATCH v2 04/14] perf mem: Only initialize memory event for recording
Date:   Tue,  1 Sep 2020 09:38:05 +0100
Message-Id: <20200901083815.13755-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's needless to initialize memory events for perf reporting, so only
initialize memory event for perf recording.  This change allows to parse
perf data on cross platforms, e.g. perf tool can output reports even the
machine doesn't enable any memory events.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9fd730019e45..b9432ee27754 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -78,6 +78,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	OPT_END()
 	};
 
+	if (perf_mem_events__init()) {
+		pr_err("failed: memory events not supported\n");
+		return -1;
+	}
+
 	argc = parse_options(argc, argv, options, record_mem_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
@@ -439,11 +444,6 @@ int cmd_mem(int argc, const char **argv)
 		NULL
 	};
 
-	if (perf_mem_events__init()) {
-		pr_err("failed: memory events not supported\n");
-		return -1;
-	}
-
 	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
-- 
2.20.1


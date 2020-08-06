Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51550C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8822CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPH07EkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHFDIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgHFDIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042D0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so5755919pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f4z8ELSFv5RMm4AHUiR4uM0G/VxLU19rLEUo8R7pEyk=;
        b=LPH07EkINu1dk8KOKsxkMwLN4RpFGdYN2ntlMtosFaovJuxz+yw2zcSXWCxCoCy/2e
         l9bDEKa3HBBdstS2x/iVjVt1eiTwBviwB8mv8Rvj6DQj1bV4HzEOIsQoUnwBkNHgqfXg
         nmvHZkPciogzI8hsSaqOJ9WoWilHzL8Bf7uxrcUQkJ7AniYd/wH3O6nn/FWWMqdmLKc6
         b6l6EiBC3Z/a1USlIPZkZ3dltWMfEOPUoHrI5tIugAoVbpBy2h6hIa2NOpiUMBCqDnO2
         /dPbFAEc0H7Xj5x16bgsG+XHc+mOZYYRI+xEknSxg70rNbMQC7Or/0xYbuXXt6oWbIYj
         77CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f4z8ELSFv5RMm4AHUiR4uM0G/VxLU19rLEUo8R7pEyk=;
        b=CwLT5e5nKguvVUtzzWlDr7IzCwr47vuxJRM/0w5YgW9IrbVnHPxCqGlsLQQdd36PZv
         VTZibnrpjOCwsqSvq7ymPg3e0gFlE4cP6bIEnNRCHEJhs1B+Tpp8xClopd8Vw8yRkQs9
         72tO0Zgf2ETDyWgN464zms/xQWCR7DnfG0MigqSmEMlqSaOnfHv6hMOErQN0kYg+prqT
         FVmXZ9X+u8v5kn5W+gFoDEFxQV7RcZmGoGhbGBrLXodoO2aE6bEabNQP1ieLH11OBm/X
         3iNmAJbH+FToYNG+czNFArTjq8d26kS+GtucHezYDD6jwIZUtzU2vBhp6knE9YOaf88X
         eliw==
X-Gm-Message-State: AOAM530tTet4iZCWtdNe+GRHCw+s58l5fvDeLNN2UV4qBMiHW0jw0fc2
        knPjrCKn8AsEIXsK8D5U+9irNw==
X-Google-Smtp-Source: ABdhPJwYieBmx/IbMYmwDB7fbuj84UbeuI74LOOvgioCL4GFN+UIe2N0x9kgzWmfqd11xWJhNv3LlA==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr6024924plk.192.1596683291511;
        Wed, 05 Aug 2020 20:08:11 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l63sm4690548pgl.24.2020.08.05.20.08.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:10 -0700 (PDT)
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
Subject: [PATCH RESEND v1 04/11] perf mem: Only initialize memory event for recording
Date:   Thu,  6 Aug 2020 11:07:20 +0800
Message-Id: <20200806030727.30267-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
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
index bd4229ca3685..a7204634893c 100644
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
 
@@ -436,11 +441,6 @@ int cmd_mem(int argc, const char **argv)
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
2.17.1


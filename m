Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE19207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTNIAuMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHSIsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHSIsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:48:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:48:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so10477464plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rx3HhZp0uE5X/bW9a/q8+qzsFbhTQfzF+43SkTUPg9s=;
        b=gTNIAuMQTY8Lvc5UP14BLPihF+M1nvXwR88UCt5QqSEiOCRMamMULGYW1Anh3T5tZn
         NWtqatFdWocT9No/CYkQfwfxN5pJn61WCIOkEecstyEQL76boB4LfF0qTtdS+/7HNzXO
         v8U8Iml3Xf5cTkD+H/Mjyv8vpINPaDwPqTvkGo0V3vbvufBaw6BD9vaDMRKXrrmnbscy
         LTstqgkbETC435s5Noy3jko49qHxDwUoVFNPOER/g0aIQBx236rx4XfNnAeLA2tpENLq
         kqVmWe+4YXsypN+LAqInM3uRG2e/e0WY2SJf1tN7tAAlfXzn0h0yUCIZQvmNyer5wfIj
         hptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rx3HhZp0uE5X/bW9a/q8+qzsFbhTQfzF+43SkTUPg9s=;
        b=nqQYnWpIqoxH7BAVkuLEPX4OFCDz06piSGFEYBwUHPhZYpqin5cR9xYY50QAEyzQIl
         C9Su2l1RfbqbXhsiz4lzMulphMSxItu9fGwgXRUGWMDMmxtAwkgda4JFtdBdYjK2wSUQ
         wIZh+gmJPWXWx4KYNWuqwVoXUdII8kCr6hrbKKDXOC8Q/UH91FSp7b7jP50f0d9VOooA
         EpvO1J7xGWH3kLAU9Xifi146eJxIpZkjr9lsaBjgxDV2AaIU7g8O3X9dVJ4JHiK87ucg
         unJaCTt2yhVzfJwCvF9PnmhzmHX6usLPNQpwMi2sJggiVZ5io9l66+0s+R7V0bgkxj2y
         FwCw==
X-Gm-Message-State: AOAM532ZozNtIIXYy3CiRIKv3UslHm8mfgyrifUONY5V8wO8ph0I2eDM
        0y/qtCJJKJvDnJT/bbcJ2el2LQ==
X-Google-Smtp-Source: ABdhPJymN378icNoISpPWEPx+twM+ttOqTAsgUY2Y3A9jKX584elnuebuLI7utTqJnZVJTNhFPaoQA==
X-Received: by 2002:a17:902:9349:: with SMTP id g9mr18292755plp.313.1597826901058;
        Wed, 19 Aug 2020 01:48:21 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l24sm24795414pff.20.2020.08.19.01.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 01:48:20 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Al Grant <al.grant@arm.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 1/2] perf cs-etm: Fix corrupt data after perf inject from
Date:   Wed, 19 Aug 2020 16:47:50 +0800
Message-Id: <20200819084751.17686-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Grant <al.grant@arm.com>

Commit 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
changed the format of branch stacks in perf samples. When samples use
this new format, a flag must be set in the corresponding event.
Synthesized branch stacks generated from CoreSight ETM trace were using
the new format, but not setting the event attribute, leading to
consumers seeing corrupt data. This patch fixes the issue by setting the
event attribute to indicate use of the new format.

Fixes: 42bbabed09ce ("perf tools: Add hw_idx in struct branch_stack")
Signed-off-by: Al Grant <al.grant@arm.com>
Reviewed-by: Andrea Brunato <andrea.brunato@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index c283223fb31f..a2a369e2fbb6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1344,8 +1344,15 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
 		attr.sample_type &= ~(u64)PERF_SAMPLE_ADDR;
 	}
 
-	if (etm->synth_opts.last_branch)
+	if (etm->synth_opts.last_branch) {
 		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		/*
+		 * We don't use the hardware index, but the sample generation
+		 * code uses the new format branch_stack with this field,
+		 * so the event attributes must indicate that it's present.
+		 */
+		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
 
 	if (etm->synth_opts.instructions) {
 		attr.config = PERF_COUNT_HW_INSTRUCTIONS;
-- 
2.17.1


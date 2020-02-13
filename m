Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE802C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9247222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNaASGbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgBMJn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:43:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38594 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMJn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:43:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id d6so2798744pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rnMtiz3/CgXO54DRdrz4I+ZEIJZQA5oMvmzvY1V4tLU=;
        b=nNaASGbpcyA/9zyOeTcUx5XdEA1ycNW6vpkrnXkZTTKm1eSCnIbLSlf8wPfhylP1ER
         PpL2Z6yYPtFDsdKU4kZAb9Y6/a8XnXo67psfg8ynOJp+DZtlXalspNE7GS3Km0v1Y1xm
         bXf/TSes3k/ym47UMQfyqWxijpaLzbjY7+BQSPwB7glfpF2H1OLVVtwSEPPB2RZYqxFi
         TesxiA27IILgVeKGPaUguw3Ygk4LlfdBh9piGIiLT5Hn6aMXFLoYff8K8YJgY6qo2ymb
         1MU7HGTIqvgfugVI73jt0znV64nWlVveIez4P1ptf0j8l1etvnbkRy6Ik+1w0lAJI4bI
         qWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rnMtiz3/CgXO54DRdrz4I+ZEIJZQA5oMvmzvY1V4tLU=;
        b=P05EgXDJMBK85Z40RE3TB6oguCvUYHv2C7VaVX2QmTryp2OseiSxoZJXMk+Ry6oJyQ
         /MmyqcBv7kpzR+Vx9/Gi4UrmQudOsngSRf7smCkICAi1RbCLdnHR3JzBObKirGbLVLtY
         mgevMMw5JatElBU27jYSnFLrI7v4KArJvGrxaQxOxcw818RsbpZKJSfFEshI42xab7AK
         O6qs87kNYiIsSrvkKLFqSQX1az3YVvv/Fkv4AzhrnHUNEfJ4J9i7MyL5OZ59zCNpSIph
         ik2k62pp7SALB0uOkFJKcEJ54mm3maid0UTIYrZ4i8Sg0KZPR8+TqXJ6GjJJM+Z666F1
         kMtA==
X-Gm-Message-State: APjAAAUft+TOBtGLx0GaJFH0f9bvfp/f0uvfyp2NiPx1Hj1QrKuuP4FH
        WBbL4O02hgumwfh6gMZcfeMi+w==
X-Google-Smtp-Source: APXvYqxYxedQckM5TgeRc/S2SpKyRfEZ1qP2Q7dKiYJa4K/q5fKHHR2QcJID9iGeHnn4omLEnVYg6w==
X-Received: by 2002:a63:9919:: with SMTP id d25mr16807304pge.22.1581587007240;
        Thu, 13 Feb 2020 01:43:27 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id 3sm2310277pfi.13.2020.02.13.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:43:26 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 5/5] perf cs-etm: Fix unsigned variable comparison to zero
Date:   Thu, 13 Feb 2020 17:42:04 +0800
Message-Id: <20200213094204.2568-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213094204.2568-1-leo.yan@linaro.org>
References: <20200213094204.2568-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'offset' in function cs_etm__sample() is u64 type, it's not
appropriate to check it with 'while (offset > 0)'; this patch changes to
'while (offset)'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aa4b6d060ebb..bba969d48076 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -962,7 +962,7 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
 	if (packet->isa == CS_ETM_ISA_T32) {
 		u64 addr = packet->start_addr;
 
-		while (offset > 0) {
+		while (offset) {
 			addr += cs_etm__t32_instr_size(etmq,
 						       trace_chan_id, addr);
 			offset--;
-- 
2.17.1


Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FE9218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkzyE0jY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgBMJnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:43:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40337 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMJnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:43:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so2128232plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OCgHNqEUlfiCJzRowkU7/269i7iDkpUPlf4f9JcwX54=;
        b=kkzyE0jY2khCQPlvgDr0BgfcRujUSFX5dZAjHWoqtnTf9tfmslHRD5+kx3P4lpHdWh
         9fwqsBbM3K+5y5HDae6Jy51sKEujHwtg2xm4CAMWS5IZ78Z45RuKrV1B1MRQ6FqoSItf
         mCfj5b+XGm1FILjyvmo3A27/eRmji2hPDkOwoodBTX3tmnLDNexmL9/pWVNrgXwtLYqr
         dBe19jEFJ0WLUb2lqOndNZ0wQ/xQvZl+SN0IeH64jFjzBy2vr6NIOb0ZCdkUskpylLCd
         4NYWTKYwc5SuOsDTmyviRsazg3r5n/mdpVz9ratijaWBvc8HdeXw4Ymbo2jMwCt1FSdC
         cJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OCgHNqEUlfiCJzRowkU7/269i7iDkpUPlf4f9JcwX54=;
        b=jXNncfGBZSaFF0gvOHTtJYcCXK0qv/WHJe/9bWUhq7DzhM1kzUav23ctmRg+ZsfgsU
         dBIikaEK0GildbiBEqT4+ksmwY/hzKZIAK0GIeC1tgNxEKXnGfmmg+FRKI2SAgPsiVCT
         lngCIU/5kjniWHVpjloUmoXeCjEhXGNeNlJWxQu+DPcPPxwCmRvr0+mlL44cMVPN/Nbc
         spYx2QT1u8+TqzSO7QFpK4pTEfJ2K6ek8dgyYDH43XTpOCTvOALJOXw3yfcM5XDEPwVN
         I7UOwMyGx96qSWbcN7NJzki1FxZgguKya59/qTqA6n0I850/mgBAUa6CoQABrqzwEXzd
         PS2Q==
X-Gm-Message-State: APjAAAW4+JYukFNWEWawT0Y0dcVehwtR8sjksV5X/O6tRG/d2e5TVXCL
        Gpjif/Eb9SOqIBXNBh+Q6+8U9A==
X-Google-Smtp-Source: APXvYqwCp1hlwy3D4RlHAsd+fjx0K1n5HsAJI0nZqpBGkJFX1H6FN1yb1EvqiP8lf9+tVSh7+VIt4w==
X-Received: by 2002:a17:902:bd88:: with SMTP id q8mr26284888pls.13.1581586997887;
        Thu, 13 Feb 2020 01:43:17 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id 3sm2310277pfi.13.2020.02.13.01.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 01:43:17 -0800 (PST)
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
Subject: [PATCH v4 4/5] perf cs-etm: Optimize copying last branches
Date:   Thu, 13 Feb 2020 17:42:03 +0800
Message-Id: <20200213094204.2568-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213094204.2568-1-leo.yan@linaro.org>
References: <20200213094204.2568-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an instruction range packet can generate multiple instruction
samples, these samples share the same last branches; it's not necessary
to copy the same last branches repeatedly for these samples within the
same packet.

This patch moves out the last branches copying from function
cs_etm__synth_instruction_sample(), and execute it prior to generating
instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/util/cs-etm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4b7d6c36ce3c..aa4b6d060ebb 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1151,10 +1151,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 
 	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
 
-	if (etm->synth_opts.last_branch) {
-		cs_etm__copy_last_branch_rb(etmq, tidq);
+	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
-	}
 
 	if (etm->synth_opts.inject) {
 		ret = cs_etm__inject_event(event, &sample,
@@ -1429,6 +1427,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		u64 offset = etm->instructions_sample_period - instrs_prev;
 		u64 addr;
 
+		/* Prepare last branches for instruction sample */
+		if (etm->synth_opts.last_branch)
+			cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		while (tidq->period_instructions >=
 				etm->instructions_sample_period) {
 			/*
@@ -1506,6 +1508,11 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	if (etmq->etm->synth_opts.last_branch &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		u64 addr;
+
+		/* Prepare last branches for instruction sample */
+		cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * Generate a last branch event for the branches left in the
 		 * circular buffer at the end of the trace.
@@ -1513,7 +1520,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		 * Use the address of the end of the last reported execution
 		 * range
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
@@ -1558,11 +1565,16 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 	 */
 	if (etmq->etm->synth_opts.last_branch &&
 	    tidq->prev_packet->sample_type == CS_ETM_RANGE) {
+		u64 addr;
+
+		/* Prepare last branches for instruction sample */
+		cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		/*
 		 * Use the address of the end of the last reported execution
 		 * range.
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
-- 
2.17.1


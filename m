Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FB8C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E4C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSN5fybM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgBSCTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:19:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38314 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:19:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so8884904plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8JY5jMUlCYWaE6NwiddTiun6+53F9fAjmLnJNKM4ks4=;
        b=oSN5fybMyY8jO1ur2M9Waav5BHCpghm10+gNMfvX3iPMYuCgKd6Zokwy7eY05UCl7Z
         BxFXeaGrPt/1osy904vjqYC6DIKxzXKFHgbJPE2FkmijWk+kMCj4tZaGCTiohtXYo1BE
         2g1xnGQZl9DpqHYeKZTUy2Vk6gMQgcSToVwzv1cnq21rPZcppDIV43KrPL88dhJgdfmo
         LrIxJNAD+mSBJjn0zzlJSqQy7MzIGM3pUiAaunDRLh4yILkzteOFF+tFoB0Xo/xm+c/D
         4HXYFG1e356D0qXptj0groSi2OkD23LdYK2TaHhvW0eo46Tnaso0rc3qhyBeXdP0VHF7
         uYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8JY5jMUlCYWaE6NwiddTiun6+53F9fAjmLnJNKM4ks4=;
        b=R0rkNnYHc5BJDIBGWih5Z4JPmj0oDhm5K32uUnm08nTCLcIVq28IM7HA8b9uImckgz
         hoFLT+I85rgtbHXVH61VcKJtnENzBFLmCEOmP9svvv/E8Eynq6TwASCODFSJjVr6+ihl
         0LhufbjrVQGLqkiyUXvuWN7ZxWx1d54ZST1wYSYUA1ewrQuAxjER6+QINW9AdI6mmKI4
         pj/nGoAAbYahBeI0FIqrXssVbQAyQTCjPjFJSPDEytu/xtuj+6e/FNkBFDvXpiF3DWRH
         bwpZbPEaRE13eB0UjCWlxX+v9Log8nTUErox67+LnzhQK89Tv9WbeaKWIPHGU6VMPZ58
         q+gQ==
X-Gm-Message-State: APjAAAWNEVdOUTZ567Xl6fgKPpkMCi0nlIl1IRIomS9Mgmb3qWb4kGG/
        dpVwLf2AmEHwN15nrcLi7/2f8Q==
X-Google-Smtp-Source: APXvYqxeQb5nu5YwhBkLDsrh7TuiaLfdBdP6z8ArH5UKKvWj3/CSGB+g+xD0YyF9NRX6V9Im+RT1uA==
X-Received: by 2002:a17:90a:8d86:: with SMTP id d6mr6263677pjo.119.1582078759193;
        Tue, 18 Feb 2020 18:19:19 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id q11sm322698pff.111.2020.02.18.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:19:18 -0800 (PST)
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
Subject: [PATCH v5 4/5] perf cs-etm: Optimize copying last branches
Date:   Wed, 19 Feb 2020 10:18:10 +0800
Message-Id: <20200219021811.20067-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219021811.20067-1-leo.yan@linaro.org>
References: <20200219021811.20067-1-leo.yan@linaro.org>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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


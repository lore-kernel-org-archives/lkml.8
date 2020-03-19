Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C45C43332
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A236C2137B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCSOLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:11:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgCSOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsn-00022q-EN; Thu, 19 Mar 2020 15:10:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14B551C22A3;
        Thu, 19 Mar 2020 15:10:44 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:43 -0000
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf cs-etm: Optimize copying last branches
Cc:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219021811.20067-5-leo.yan@linaro.org>
References: <20200219021811.20067-5-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <158462704380.28353.5443824245007794941.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     695378b567df1fe6631c6684fcc9eeb4257df70f
Gitweb:        https://git.kernel.org/tip/695378b567df1fe6631c6684fcc9eeb4257df70f
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Wed, 19 Feb 2020 10:18:10 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 11 Mar 2020 10:48:44 -03:00

perf cs-etm: Optimize copying last branches

If an instruction range packet can generate multiple instruction
samples, these samples share the same last branches; it's not necessary
to copy the same last branches repeatedly for these samples within the
same packet.

This patch moves out the last branches copying from function
cs_etm__synth_instruction_sample(), and execute it prior to generating
instruction samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lore.kernel.org/lkml/20200219021811.20067-5-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1ddcc67..87d9943 100644
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
@@ -1431,6 +1429,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		u64 offset = etm->instructions_sample_period - instrs_prev;
 		u64 addr;
 
+		/* Prepare last branches for instruction sample */
+		if (etm->synth_opts.last_branch)
+			cs_etm__copy_last_branch_rb(etmq, tidq);
+
 		while (tidq->period_instructions >=
 				etm->instructions_sample_period) {
 			/*
@@ -1508,6 +1510,11 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
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
@@ -1515,7 +1522,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 		 * Use the address of the end of the last reported execution
 		 * range
 		 */
-		u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
+		addr = cs_etm__last_executed_instr(tidq->prev_packet);
 
 		err = cs_etm__synth_instruction_sample(
 			etmq, tidq, addr,
@@ -1560,11 +1567,16 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
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

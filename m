Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125ECC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D050320767
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584480834;
	bh=hiEEWucSxZxjI7MT3kScKEk8sa1lujh7WLXD8EchpZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=plaHpmpAcW81tvH3zLYc6nRqergbDX0OG5yf3qMFsbuJYdZIfIBq7ekgWuYnEanOE
	 T1bfzYKl2E1YdTKZ0bFhxTCg4cmaE3BrdOQoQUP3TNBdDavTZPJdOJ1M+OSBEFbdur
	 9ZQ2zJHqgOT5hhS8a/laM/foZSSijhXLdwg3ktEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCQVdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCQVdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:33:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DE4220738;
        Tue, 17 Mar 2020 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584480830;
        bh=hiEEWucSxZxjI7MT3kScKEk8sa1lujh7WLXD8EchpZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBYocXCEwwqccsdzV3YH2rqg/ciDhtMBGv8UjHXp2CYlXewHsKX7k9Dv3X5q0bCdE
         y7BlBY/8qLPV1BoGJNq8Jj5Rs3KjmKrsZZnco6aS7is/6Czr9LF3OZj7IDJoz8/Swp
         eY7rJt5v2CGJxpjp3GtQrvdz9Co9EHEetCuzCabQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        coresight ml <coresight@lists.linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/23] perf cs-etm: Correct synthesizing instruction samples
Date:   Tue, 17 Mar 2020 18:32:47 -0300
Message-Id: <20200317213259.15494-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

When 'etm->instructions_sample_period' is less than
'tidq->period_instructions', the function cs_etm__sample() cannot handle
this case properly with its logic.

Let's see below flow as an example:

- If we set itrace option '--itrace=i4', then function cs_etm__sample()
  has variables with initialized values:

  tidq->period_instructions = 0
  etm->instructions_sample_period = 4

- When the first packet is coming:

  packet->instr_count = 10; the number of instructions executed in this
  packet is 10, thus update period_instructions as below:

  tidq->period_instructions = 0 + 10 = 10
  instrs_over = 10 - 4 = 6
  offset = 10 - 6 - 1 = 3
  tidq->period_instructions = instrs_over = 6

- When the second packet is coming:

  packet->instr_count = 10; in the second pass, assume 10 instructions
  in the trace sample again:

  tidq->period_instructions = 6 + 10 = 16
  instrs_over = 16 - 4 = 12
  offset = 10 - 12 - 1 = -3  -> the negative value
  tidq->period_instructions = instrs_over = 12

So after handle these two packets, there have below issues:

The first issue is that cs_etm__instr_addr() returns the address within
the current trace sample of the instruction related to offset, so the
offset is supposed to be always unsigned value.  But in fact, function
cs_etm__sample() might calculate a negative offset value (in handling
the second packet, the offset is -3) and pass to cs_etm__instr_addr()
with u64 type with a big positive integer.

The second issue is it only synthesizes 2 samples for sample period = 4.
In theory, every packet has 10 instructions so the two packets have
total 20 instructions, 20 instructions should generate 5 samples
(4 x 5 = 20).  This is because cs_etm__sample() only calls once
cs_etm__synth_instruction_sample() to generate instruction sample per
range packet.

This patch fixes the logic in function cs_etm__sample(); the basic
idea for handling coming packet is:

- To synthesize the first instruction sample, it combines the left
  instructions from the previous packet and the head of the new
  packet; then generate continuous samples with sample period;
- At the tail of the new packet, if it has the rest instructions,
  these instructions will be left for the sequential sample.

Suggested-by: Mike Leach <mike.leach@linaro.org>
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
Link: http://lore.kernel.org/lkml/20200219021811.20067-4-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 87 ++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2c4156c5ed09..1ddcc67e13dd 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1358,9 +1358,12 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	int ret;
 	u8 trace_chan_id = tidq->trace_chan_id;
-	u64 instrs_executed = tidq->packet->instr_count;
+	u64 instrs_prev;
 
-	tidq->period_instructions += instrs_executed;
+	/* Get instructions remainder from previous packet */
+	instrs_prev = tidq->period_instructions;
+
+	tidq->period_instructions += tidq->packet->instr_count;
 
 	/*
 	 * Record a branch when the last instruction in
@@ -1378,26 +1381,76 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		 * TODO: allow period to be defined in cycles and clock time
 		 */
 
-		/* Get number of instructions executed after the sample point */
-		u64 instrs_over = tidq->period_instructions -
-			etm->instructions_sample_period;
+		/*
+		 * Below diagram demonstrates the instruction samples
+		 * generation flows:
+		 *
+		 *    Instrs     Instrs       Instrs       Instrs
+		 *   Sample(n)  Sample(n+1)  Sample(n+2)  Sample(n+3)
+		 *    |            |            |            |
+		 *    V            V            V            V
+		 *   --------------------------------------------------
+		 *            ^                                  ^
+		 *            |                                  |
+		 *         Period                             Period
+		 *    instructions(Pi)                   instructions(Pi')
+		 *
+		 *            |                                  |
+		 *            \---------------- -----------------/
+		 *                             V
+		 *                 tidq->packet->instr_count
+		 *
+		 * Instrs Sample(n...) are the synthesised samples occurring
+		 * every etm->instructions_sample_period instructions - as
+		 * defined on the perf command line.  Sample(n) is being the
+		 * last sample before the current etm packet, n+1 to n+3
+		 * samples are generated from the current etm packet.
+		 *
+		 * tidq->packet->instr_count represents the number of
+		 * instructions in the current etm packet.
+		 *
+		 * Period instructions (Pi) contains the the number of
+		 * instructions executed after the sample point(n) from the
+		 * previous etm packet.  This will always be less than
+		 * etm->instructions_sample_period.
+		 *
+		 * When generate new samples, it combines with two parts
+		 * instructions, one is the tail of the old packet and another
+		 * is the head of the new coming packet, to generate
+		 * sample(n+1); sample(n+2) and sample(n+3) consume the
+		 * instructions with sample period.  After sample(n+3), the rest
+		 * instructions will be used by later packet and it is assigned
+		 * to tidq->period_instructions for next round calculation.
+		 */
 
 		/*
-		 * Calculate the address of the sampled instruction (-1 as
-		 * sample is reported as though instruction has just been
-		 * executed, but PC has not advanced to next instruction)
+		 * Get the initial offset into the current packet instructions;
+		 * entry conditions ensure that instrs_prev is less than
+		 * etm->instructions_sample_period.
 		 */
-		u64 offset = (instrs_executed - instrs_over - 1);
-		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
-					      tidq->packet, offset);
+		u64 offset = etm->instructions_sample_period - instrs_prev;
+		u64 addr;
 
-		ret = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr, etm->instructions_sample_period);
-		if (ret)
-			return ret;
+		while (tidq->period_instructions >=
+				etm->instructions_sample_period) {
+			/*
+			 * Calculate the address of the sampled instruction (-1
+			 * as sample is reported as though instruction has just
+			 * been executed, but PC has not advanced to next
+			 * instruction)
+			 */
+			addr = cs_etm__instr_addr(etmq, trace_chan_id,
+						  tidq->packet, offset - 1);
+			ret = cs_etm__synth_instruction_sample(
+				etmq, tidq, addr,
+				etm->instructions_sample_period);
+			if (ret)
+				return ret;
 
-		/* Carry remaining instructions into next sample period */
-		tidq->period_instructions = instrs_over;
+			offset += etm->instructions_sample_period;
+			tidq->period_instructions -=
+				etm->instructions_sample_period;
+		}
 	}
 
 	if (etm->sample_branches) {
-- 
2.21.1


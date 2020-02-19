Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A322C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3899A207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjQ11GtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBSCTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:19:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41011 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgBSCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:19:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so11668686pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8cKL3AaIl+QvmCfSxetleMkVTq/ERHhbraI9D0Gkm8M=;
        b=sjQ11GtGikQZXvFuhOhNnrhatmYa9vJWBy6Ij3jB5XMQQACzeWPZJHSEks3uCD6DyY
         LghQ/zcjcXYk+HifglaT6y4ll2Vxr0kNb8k7LZ8Wk/3G5wM0pBbwB3+JyNtEW3CBsi5E
         mdYKQh5SGy8MxJrMjhhlVYeo/3ndIMr9wYwVbRZlaeXUuU+x/WbMm59GwzYmt6T1fkfG
         D0Z5Gshc0SyZjAp06GNYC06Q703CoqqgioG1LxebO7B2uYRiiq6gAWmFcZkCFHu1U82d
         T/Bt88NGNqwsmLwF5eJfjzKXhjpW6afkE1DO11L49DZ+mnNoMExcFsmfu6y08DvXQ6zS
         IXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8cKL3AaIl+QvmCfSxetleMkVTq/ERHhbraI9D0Gkm8M=;
        b=VQM6Zmu4jY/5fo89VZdLSOnepjUSNlfaWAGcg9ql8xmJx7zCIVMKv5KmnDgyCbXFTR
         diS9ZUuOcseCJuq4bYGwQ2bbWiGdceRG8Nsken9WjMMntRDDoCucE5g6ly3pk6dB1C2B
         5ngh5y4ELDKx/Q3u18PU9BVDYULcFGfDtcD0JuazV5MqQkWyMuMXebpDTpW5RljH0N5j
         KMSYYxdqanlzsQBoCQ1kamFV1ZjDrOTOpNm5/izRXkwG2MqQa3CmlfqAMt6JQh6pXTqw
         EI7j8LhZy7zFj3faSK5hxcz/74t5mhCsyjnn3kcr1/UUyyhmp6/xopSUYYBo1FDTCa79
         3zBQ==
X-Gm-Message-State: APjAAAVrJjnw2LI5UMRp0c7mbfyeWyfHJjLoMMBDcY+g3Y82GYW+1Uoe
        XfnHcAXhs4TahR1CFbn5KmSAGg==
X-Google-Smtp-Source: APXvYqxzvmMhk5IEE05litktPeAw8dUrB4n7gLWMbRjUCl2tdzj6GQK+nhBfJaOLUaf/RyL5jJTbRQ==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr24572288pfn.62.1582078747904;
        Tue, 18 Feb 2020 18:19:07 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id q11sm322698pff.111.2020.02.18.18.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 18:19:07 -0800 (PST)
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
Subject: [PATCH v5 3/5] perf cs-etm: Correct synthesizing instruction samples
Date:   Wed, 19 Feb 2020 10:18:09 +0800
Message-Id: <20200219021811.20067-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219021811.20067-1-leo.yan@linaro.org>
References: <20200219021811.20067-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 87 ++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index b2f31390126a..4b7d6c36ce3c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1356,9 +1356,12 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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
@@ -1376,26 +1379,76 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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
2.17.1


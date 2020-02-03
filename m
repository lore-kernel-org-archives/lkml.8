Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F408C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E7C2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 01:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNaUZPNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgBCBw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 20:52:58 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:46778 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgBCBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 20:52:58 -0500
Received: by mail-pf1-f182.google.com with SMTP id k29so6682826pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 17:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqHe4kpzcWWGiBvCMvqthV/qb6mJrwUYZdST62vWU3I=;
        b=iNaUZPNFFVRxhU2mL7ouJ8gYcRrT170JXFwHyqq/VgpyFf1Y8ku3/HHef8ZJQ1O52a
         etBl8WUro89ePTq0dJs8pcE2tFR/aWxj+AiM7CZj3Asje+2qeZQK+uKDa+3VCqbNatgA
         LgkkPmT3xOf+eZ+NteTL0uAEUVP8g0GFzDe7Ybz3jpaPmKb3KDsd40BXRK+UIBh1NQDE
         T5YMMBg395kFIEJ0S0K97K0OTflND0ZKIn3gYCQkJuESqqT/YSzfQPuyzriQJxBLo18/
         Pa8v6IrN/T5VCovb8BjRo83GxZSMtszPWwlKMYsjm3CtBcY/pz6hWu9ThuoS05X0nyKL
         W1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqHe4kpzcWWGiBvCMvqthV/qb6mJrwUYZdST62vWU3I=;
        b=GdHYgqhprKYtlQvefcEeeplauuNxvX6xWbaX1Th54t0eBVpJQWAfhsMy4KBuzfxJro
         oOGTAgZbOgsGDUXtW1T1i06BF77UQMwvD0QFm9kiJVpOL0T4epL+TZR2FYz8+HdfZiCc
         75ZWom/WnZh8spd6n6CbJlONqjj8AoZ9xCiXNl0YcCNh8haGrMFvEw4ky9f8qP0NUxvZ
         gnVk8Dwdt0OZiZRuhi9Y4QJck7NVhqhaxguTakapTd1SQ48Xl6NkUoRYNRG+bOOA333e
         Z0M7QjhSzPGNVwSiSGdI6+FXr+Kg0tdLo5b19sUtdvwNL2PULLx4OGTikt47DBKzE2NP
         eyGA==
X-Gm-Message-State: APjAAAUXtv+k91TSLwWYW6NEZgN8+SfLI2eVb1oyXKmd/qiOK9Qp4f9m
        amkO9PfpTqmUF82W5DdqpbZDag==
X-Google-Smtp-Source: APXvYqy6j0qPFbolYtLl4Yd6xTiYUEgT1avC5QOuA77DBWjzRBvW0x8qjtEFwjyY0HwAwtTt7ia5pg==
X-Received: by 2002:a63:2309:: with SMTP id j9mr12530563pgj.54.1580694776169;
        Sun, 02 Feb 2020 17:52:56 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id y38sm17348308pgk.33.2020.02.02.17.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 17:52:55 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 3/5] perf cs-etm: Correct synthesizing instruction samples
Date:   Mon,  3 Feb 2020 09:52:01 +0800
Message-Id: <20200203015203.27882-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203015203.27882-1-leo.yan@linaro.org>
References: <20200203015203.27882-1-leo.yan@linaro.org>
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
idea is to divide into three parts for handling coming packet:

- The first part is for synthesizing the first instruction sample, it
  combines the instructions from the tail of previous packet and the
  instructions from the head of the new packet;
- The second part is to simply generate samples with sample period
  aligned;
- The third part is the tail of new packet, the rest instructions will
  be left for the sequential sample handling.

Suggested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 105 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3e28462609e7..c5a05f728eac 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1360,23 +1360,102 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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
+		 *                      instrs_executed
+		 *
+		 * Period instructions (Pi) contains the the number of
+		 * instructions executed after the sample point(n).  When a new
+		 * instruction packet is coming and generate for the next sample
+		 * (n+1), it combines with two parts instructions, one is the
+		 * tail of the old packet and another is the head of the new
+		 * coming packet.  So 'head' variable is used to cauclate the
+		 * instruction numbers in the new packet for sample(n+1).
+		 *
+		 * Sample(n+2) and sample(n+3) consume the instructions with
+		 * sample period, so directly generate samples based on the
+		 * sampe period.
+		 *
+		 * After sample(n+3), the rest instructions will be used by
+		 * later packet; so use 'instrs_over' to track the rest
+		 * instruction number and it is assigned to
+		 * 'tidq->period_instructions' for next round calculation.
+		 */
+		u64 head, offset = 0;
+		u64 addr;
 
 		/*
-		 * Calculate the address of the sampled instruction (-1 as
-		 * sample is reported as though instruction has just been
-		 * executed, but PC has not advanced to next instruction)
+		 * 'instrs_over' is the number of instructions executed after
+		 * sample points, initialise it to 'instrs_executed' and will
+		 * decrease it for consumed instructions in every synthesized
+		 * instruction sample.
 		 */
-		u64 offset = (instrs_executed - instrs_over - 1);
-		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
-					      tidq->packet, offset);
+		u64 instrs_over = instrs_executed;
 
-		ret = cs_etm__synth_instruction_sample(
-			etmq, tidq, addr, etm->instructions_sample_period);
-		if (ret)
-			return ret;
+		/*
+		 * 'head' is the instructions number of the head in the new
+		 * packet, it combines with the tail of previous packet to
+		 * generate a sample.  So 'head' uses the sample period to
+		 * decrease the instruction number introduced by the previous
+		 * packet.
+		 */
+		head = etm->instructions_sample_period -
+				  (tidq->period_instructions - instrs_executed);
+
+		if (head) {
+			offset = head;
+
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
+
+			instrs_over -= head;
+		}
+
+		while (instrs_over >= etm->instructions_sample_period) {
+			offset += etm->instructions_sample_period;
+
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
+
+			instrs_over -= etm->instructions_sample_period;
+		}
 
 		/* Carry remaining instructions into next sample period */
 		tidq->period_instructions = instrs_over;
-- 
2.17.1


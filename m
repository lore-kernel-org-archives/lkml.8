Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27147C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA18F20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdrGDqRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBEQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:09:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41435 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:09:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id l19so1939033qtq.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvMgtmCypa6dN2YRTNmRQCzXIANAtMCLKhGHOwYDoYY=;
        b=EdrGDqRyMunjHbYpc5wP887ggphFAl5426HJY9WayFNhFqCaCpknkK3F0SlcTYfGiI
         cgLKTtp1+9KAeJx00gF+Ef08HCs2IzX156DZAWGB++CbeHDxPfZWUauUZufYbiGLGekV
         83q5BfXwUOuuDj1rwng3JpCrZL/abv51l5TexSgSBcblOAD4C0Ru0U/FMHRXUz4ax3s2
         kyGjuJUJtFJxWT+T4BqKX+yVfMo3Rj2LrSWFQY7rxZ6CqY/kkvnp5kK51etPgzI9W3gh
         S5HYUmZjGUNZpPoGEyD6XvAkv7SpZOMK2pZI1JNHJeTRzSndGsjmu0lbdJZlxesgKGhg
         lhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvMgtmCypa6dN2YRTNmRQCzXIANAtMCLKhGHOwYDoYY=;
        b=ud3joqPJ0kWge0g+6fQC6fb1tK5k8MsYiuWHi0MhFA20vR+NkuqSEQ1O2WuZ431QUI
         rWgdLEuZX5VpibywurXMosQo1Q3469UPdxnG4C6xVVuVbZjOlGp6Jsw6RBSFuVGNlswr
         vJHe8tcmMO2/lOpq4Azhb0kI09hSA9J6doezCGWXFzOFzzI+75T/M/WQYHu71Ya+gtC3
         PZUTgK73L2J2ANwe4y+nzRROMFJ3lg0trAwBN9nyPtUu4fRkLA4VlN5OyXSlTWZOSxes
         0iwhb7bSpslKJk3h6Q+jysTPwYEvzRr4xsXG7H6KAFTYm/lZo+EGwPLoMQrJs1Y4SR+p
         lcNg==
X-Gm-Message-State: APjAAAU8lxtZbqjG0LH0R8TCB5Zy+e2O1ncJfh7V+n73FzVOGoFa9GbS
        88rxZg0WfFuldtnAic6puuWPRWmUjuHajLzn7rpsEw==
X-Google-Smtp-Source: APXvYqxVKtTV3F3WyzBJFJ8fLJYXNEpn4L0pyPcYZbS2t12iiyJHC1nVhn0ShSOXvJt3ABJnDADv3vEQuaHk0F8Vbmo=
X-Received: by 2002:ac8:718e:: with SMTP id w14mr33945370qto.266.1580918952671;
 Wed, 05 Feb 2020 08:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20200203015203.27882-1-leo.yan@linaro.org> <20200203015203.27882-4-leo.yan@linaro.org>
In-Reply-To: <20200203015203.27882-4-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 5 Feb 2020 16:09:01 +0000
Message-ID: <CAJ9a7Vgx+-8Etcak=NDJ1p1yQeexyqRDFFWPW=bW5ZHNLyeP6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf cs-etm: Correct synthesizing instruction samples
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

There are a couple of typos in the comments below, but I also believe
that the sample loop could be considerably simplified

On Mon, 3 Feb 2020 at 01:52, Leo Yan <leo.yan@linaro.org> wrote:
>
> When 'etm->instructions_sample_period' is less than
> 'tidq->period_instructions', the function cs_etm__sample() cannot handle
> this case properly with its logic.
>
> Let's see below flow as an example:
>
> - If we set itrace option '--itrace=i4', then function cs_etm__sample()
>   has variables with initialized values:
>
>   tidq->period_instructions = 0
>   etm->instructions_sample_period = 4
>
> - When the first packet is coming:
>
>   packet->instr_count = 10; the number of instructions executed in this
>   packet is 10, thus update period_instructions as below:
>
>   tidq->period_instructions = 0 + 10 = 10
>   instrs_over = 10 - 4 = 6
>   offset = 10 - 6 - 1 = 3
>   tidq->period_instructions = instrs_over = 6
>
> - When the second packet is coming:
>
>   packet->instr_count = 10; in the second pass, assume 10 instructions
>   in the trace sample again:
>
>   tidq->period_instructions = 6 + 10 = 16
>   instrs_over = 16 - 4 = 12
>   offset = 10 - 12 - 1 = -3  -> the negative value
>   tidq->period_instructions = instrs_over = 12
>
> So after handle these two packets, there have below issues:
>
> The first issue is that cs_etm__instr_addr() returns the address within
> the current trace sample of the instruction related to offset, so the
> offset is supposed to be always unsigned value.  But in fact, function
> cs_etm__sample() might calculate a negative offset value (in handling
> the second packet, the offset is -3) and pass to cs_etm__instr_addr()
> with u64 type with a big positive integer.
>
> The second issue is it only synthesizes 2 samples for sample period = 4.
> In theory, every packet has 10 instructions so the two packets have
> total 20 instructions, 20 instructions should generate 5 samples
> (4 x 5 = 20).  This is because cs_etm__sample() only calls once
> cs_etm__synth_instruction_sample() to generate instruction sample per
> range packet.
>
> This patch fixes the logic in function cs_etm__sample(); the basic
> idea is to divide into three parts for handling coming packet:
>
> - The first part is for synthesizing the first instruction sample, it
>   combines the instructions from the tail of previous packet and the
>   instructions from the head of the new packet;
> - The second part is to simply generate samples with sample period
>   aligned;
> - The third part is the tail of new packet, the rest instructions will
>   be left for the sequential sample handling.
>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 105 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 92 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 3e28462609e7..c5a05f728eac 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1360,23 +1360,102 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>                  * TODO: allow period to be defined in cycles and clock time
>                  */
>
> -               /* Get number of instructions executed after the sample point */
> -               u64 instrs_over = tidq->period_instructions -
> -                       etm->instructions_sample_period;
> +               /*
> +                * Below diagram demonstrates the instruction samples
> +                * generation flows:
> +                *
> +                *    Instrs     Instrs       Instrs       Instrs
> +                *   Sample(n)  Sample(n+1)  Sample(n+2)  Sample(n+3)
> +                *    |            |            |            |
> +                *    V            V            V            V
> +                *   --------------------------------------------------
> +                *            ^                                  ^
> +                *            |                                  |
> +                *         Period                             Period
> +                *    instructions(Pi)                   instructions(Pi')
> +                *
> +                *            |                                  |
> +                *            \---------------- -----------------/
> +                *                             V
> +                *                      instrs_executed
> +                *
> +                * Period instructions (Pi) contains the the number of
> +                * instructions executed after the sample point(n).  When a new
> +                * instruction packet is coming and generate for the next sample
> +                * (n+1), it combines with two parts instructions, one is the
> +                * tail of the old packet and another is the head of the new
> +                * coming packet.  So 'head' variable is used to cauclate the
typo : s/cauclate/calculate
> +                * instruction numbers in the new packet for sample(n+1).
> +                *
> +                * Sample(n+2) and sample(n+3) consume the instructions with
> +                * sample period, so directly generate samples based on the
> +                * sampe period.
> +                *
typo: s/sampe/sample
> +                * After sample(n+3), the rest instructions will be used by
> +                * later packet; so use 'instrs_over' to track the rest
> +                * instruction number and it is assigned to
> +                * 'tidq->period_instructions' for next round calculation.
> +                */
> +               u64 head, offset = 0;
> +               u64 addr;
>
>                 /*
> -                * Calculate the address of the sampled instruction (-1 as
> -                * sample is reported as though instruction has just been
> -                * executed, but PC has not advanced to next instruction)
> +                * 'instrs_over' is the number of instructions executed after
> +                * sample points, initialise it to 'instrs_executed' and will
> +                * decrease it for consumed instructions in every synthesized
> +                * instruction sample.
>                  */
> -               u64 offset = (instrs_executed - instrs_over - 1);
> -               u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -                                             tidq->packet, offset);
> +               u64 instrs_over = instrs_executed;
>
> -               ret = cs_etm__synth_instruction_sample(
> -                       etmq, tidq, addr, etm->instructions_sample_period);
> -               if (ret)
> -                       return ret;
> +               /*
> +                * 'head' is the instructions number of the head in the new
> +                * packet, it combines with the tail of previous packet to
> +                * generate a sample.  So 'head' uses the sample period to
> +                * decrease the instruction number introduced by the previous
> +                * packet.
> +                */
> +               head = etm->instructions_sample_period -
> +                                 (tidq->period_instructions - instrs_executed);
> +
> +               if (head) {
> +                       offset = head;
> +
> +                       /*
> +                        * Calculate the address of the sampled instruction (-1
> +                        * as sample is reported as though instruction has just
> +                        * been executed, but PC has not advanced to next
> +                        * instruction)
> +                        */
> +                       addr = cs_etm__instr_addr(etmq, trace_chan_id,
> +                                                 tidq->packet, offset - 1);
> +                       ret = cs_etm__synth_instruction_sample(
> +                               etmq, tidq, addr,
> +                               etm->instructions_sample_period);
> +                       if (ret)
> +                               return ret;
> +
> +                       instrs_over -= head;
> +               }
> +
> +               while (instrs_over >= etm->instructions_sample_period) {
> +                       offset += etm->instructions_sample_period;
> +
> +                       /*
> +                        * Calculate the address of the sampled instruction (-1
> +                        * as sample is reported as though instruction has just
> +                        * been executed, but PC has not advanced to next
> +                        * instruction)
> +                        */
> +                       addr = cs_etm__instr_addr(etmq, trace_chan_id,
> +                                                 tidq->packet, offset - 1);
> +                       ret = cs_etm__synth_instruction_sample(
> +                               etmq, tidq, addr,
> +                               etm->instructions_sample_period);
> +                       if (ret)
> +                               return ret;
> +
> +                       instrs_over -= etm->instructions_sample_period;
> +               }
>
>                 /* Carry remaining instructions into next sample period */
>                 tidq->period_instructions = instrs_over;
> --
> 2.17.1
>

I believe the following change would work and make for easier reading...

.... at the start of the function remove instrs_executed and replace ....
/* get instructions remainder from previous packet */
u64 instrs_prev = tidq->period_instructions;

/* set available instructions to previous packet remainder + the
current packet count  */
tidq->period_instructions += tidq->packet->instr_count;


.... within the if(etm->sample_instructions && ...) statement I would
be more explicit what the elements of the diagram are ....

/*
 * Below diagram demonstrates the instruction samples
 * generation flows:
 *
 *    Instrs     Instrs       Instrs       Instrs
 *   Sample(n)  Sample(n+1)  Sample(n+2)  Sample(n+3)
 *    |            |            |            |
 *    V            V            V            V
 *   --------------------------------------------------
 *            ^                                  ^
 *            |                                  |
 *         Period                             Period
 *    instructions(Pi)                   instructions(Pi')
 *
 *            |                                  |
 *            \---------------- -----------------/
 *                             V
 *                      tidq->packet->instr_count;
 *
 * Instrs Sample(n...) are the synthesised samples occuring every
etm->instructions_sample_period
 * instructions - as defined on the perf command line. Sample(n) being
the last sample before the
 * current etm packet, n+1 to n+3 samples generated from the current etm packet.
 *
 * tidq->packet->instr_count represents the number of instructions in
the current etm packet.
 *
 * Period instructions (Pi) contains the the number of instructions
executed after the sample point(n)
 * from the previous etm packet. This will always be less than
etm->instructions_sample_period.
 *

.... continue with explanation here ....


.... then we can simplify the loop code removing some of the temporary
variables ....

/* get the initial offset into the current packet instructions
   (entry conditions ensure that instrs_prev < etm->instructions_sample_period)
 */
u64 offset = etm->instructions_sample_period - instrs_prev;
u64 addr;

/* Prepare last branches for instruction sample */
if (etm->synth_opts.last_branch)
    cs_etm__copy_last_branch_rb(etmq, tidq);

while (tidq->period_instructions >= etm->instructions_sample_period) {

      /*
       * Calculate the address of the sampled instruction (-1
       * as sample is reported as though instruction has just
       * been executed, but PC has not advanced to next
       * instruction)
       */
    addr = cs_etm__instr_addr(etmq, trace_chan_id, tidq->packet, offset - 1);
    ret = cs_etm__synth_instruction_sample( etmq, tidq, addr,
                etm->instructions_sample_period);
    if (ret)
        return ret;

    offset += etm->instructions_sample_period;
    tidq->period_instructions -= etm->instructions_sample_period;
}

.....
I believe the above should work, but cannot claim to have tried it
out. What do you think?

Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

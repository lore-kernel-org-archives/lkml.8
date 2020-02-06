Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D8CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522F7206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VN66oejD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBFIYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:24:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46304 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:24:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so2375623pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gcu/MBD5y+k9GL2qLXcd5S94TlBigL82zSNhw+41Llk=;
        b=VN66oejD5fgAZQzVbEXrqzaYUucPCYjlpvNELrtDM/KSzAGiRv/AwJhpwjCB06E3kD
         oLSt/lp4LB762EDY6O8xFhzIEFr7cK6f1tos4uV11kzQUSgrBVbB5ONOD47g4P53LfUd
         8YCYY/iCtHSG7ZkIbSm3Pp8jmilgGg2LhBVqOl899vhhIbMdSSiM0fwL4ebnl9Wi9Mwp
         NLlByLuqaTEMEvDYbSxox4BhXjz7j8F5e30gE+1M/2OKySpgssHh+Aiai3VthGnDCxCE
         i5+1yj2Z0x7pKD/GnkUeknYJ8AuJHEQZnyKo0W98nMIvuhlHxUzgXS/rwbN9tPmnpolv
         wJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gcu/MBD5y+k9GL2qLXcd5S94TlBigL82zSNhw+41Llk=;
        b=JbVM3RSUuMGUMT/h5yZzshoaCSKL/oWcYXgDzhUBm7OXqu4e63Qg9osAGGs4SDoO3x
         ddQn2omBDk9vgLMbqa50JLa4iWGNTR33+DBC5JmwfoW7K0RJnIZI4E2Mof2nyRzVXU/3
         cy6Nb/O7j0Y61M8SuR5Zn78L5R6mB08NVC+W4pQsn697rUF61vWg0R61zCYB9AuX+gYw
         XqmFCZ586XXcBJgvbazt6wniEhRjXzvNRHR6Hn0cn1QP/jTpaV1W69LrHzAMYmgNlJ5z
         rVBv+HutTbKP9G7wmHV0piQX29J9aC74hlHsWST8CncQD6r1Nu9ub20bmjKb96eYRk5M
         5RMg==
X-Gm-Message-State: APjAAAX1zo8KLW0PjuzPwEpnH0rm6JCWxijSZ3yqxmhSNktI8BRBN4/s
        3t4xpeUmxbhLp1GP6UUK7HMzew==
X-Google-Smtp-Source: APXvYqw6w48vSVE7b0D1eb4Hp2oAIKvE7+Ltn2LDvENbjt++jAfqC0toL081vOsJteIwmkD0kJJuqg==
X-Received: by 2002:a62:78c1:: with SMTP id t184mr2478380pfc.222.1580977481254;
        Thu, 06 Feb 2020 00:24:41 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:32da])
        by smtp.gmail.com with ESMTPSA id n2sm2294912pfq.50.2020.02.06.00.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 00:24:40 -0800 (PST)
Date:   Thu, 6 Feb 2020 16:24:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
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
Subject: Re: [PATCH v3 3/5] perf cs-etm: Correct synthesizing instruction
 samples
Message-ID: <20200206081834.GB3807@leoy-ThinkPad-X240s>
References: <20200203015203.27882-1-leo.yan@linaro.org>
 <20200203015203.27882-4-leo.yan@linaro.org>
 <CAJ9a7Vgx+-8Etcak=NDJ1p1yQeexyqRDFFWPW=bW5ZHNLyeP6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vgx+-8Etcak=NDJ1p1yQeexyqRDFFWPW=bW5ZHNLyeP6A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 04:09:01PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> There are a couple of typos in the comments below, but I also believe
> that the sample loop could be considerably simplified
> 
> On Mon, 3 Feb 2020 at 01:52, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > When 'etm->instructions_sample_period' is less than
> > 'tidq->period_instructions', the function cs_etm__sample() cannot handle
> > this case properly with its logic.
> >
> > Let's see below flow as an example:
> >
> > - If we set itrace option '--itrace=i4', then function cs_etm__sample()
> >   has variables with initialized values:
> >
> >   tidq->period_instructions = 0
> >   etm->instructions_sample_period = 4
> >
> > - When the first packet is coming:
> >
> >   packet->instr_count = 10; the number of instructions executed in this
> >   packet is 10, thus update period_instructions as below:
> >
> >   tidq->period_instructions = 0 + 10 = 10
> >   instrs_over = 10 - 4 = 6
> >   offset = 10 - 6 - 1 = 3
> >   tidq->period_instructions = instrs_over = 6
> >
> > - When the second packet is coming:
> >
> >   packet->instr_count = 10; in the second pass, assume 10 instructions
> >   in the trace sample again:
> >
> >   tidq->period_instructions = 6 + 10 = 16
> >   instrs_over = 16 - 4 = 12
> >   offset = 10 - 12 - 1 = -3  -> the negative value
> >   tidq->period_instructions = instrs_over = 12
> >
> > So after handle these two packets, there have below issues:
> >
> > The first issue is that cs_etm__instr_addr() returns the address within
> > the current trace sample of the instruction related to offset, so the
> > offset is supposed to be always unsigned value.  But in fact, function
> > cs_etm__sample() might calculate a negative offset value (in handling
> > the second packet, the offset is -3) and pass to cs_etm__instr_addr()
> > with u64 type with a big positive integer.
> >
> > The second issue is it only synthesizes 2 samples for sample period = 4.
> > In theory, every packet has 10 instructions so the two packets have
> > total 20 instructions, 20 instructions should generate 5 samples
> > (4 x 5 = 20).  This is because cs_etm__sample() only calls once
> > cs_etm__synth_instruction_sample() to generate instruction sample per
> > range packet.
> >
> > This patch fixes the logic in function cs_etm__sample(); the basic
> > idea is to divide into three parts for handling coming packet:
> >
> > - The first part is for synthesizing the first instruction sample, it
> >   combines the instructions from the tail of previous packet and the
> >   instructions from the head of the new packet;
> > - The second part is to simply generate samples with sample period
> >   aligned;
> > - The third part is the tail of new packet, the rest instructions will
> >   be left for the sequential sample handling.
> >
> > Suggested-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 105 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 92 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 3e28462609e7..c5a05f728eac 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1360,23 +1360,102 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >                  * TODO: allow period to be defined in cycles and clock time
> >                  */
> >
> > -               /* Get number of instructions executed after the sample point */
> > -               u64 instrs_over = tidq->period_instructions -
> > -                       etm->instructions_sample_period;
> > +               /*
> > +                * Below diagram demonstrates the instruction samples
> > +                * generation flows:
> > +                *
> > +                *    Instrs     Instrs       Instrs       Instrs
> > +                *   Sample(n)  Sample(n+1)  Sample(n+2)  Sample(n+3)
> > +                *    |            |            |            |
> > +                *    V            V            V            V
> > +                *   --------------------------------------------------
> > +                *            ^                                  ^
> > +                *            |                                  |
> > +                *         Period                             Period
> > +                *    instructions(Pi)                   instructions(Pi')
> > +                *
> > +                *            |                                  |
> > +                *            \---------------- -----------------/
> > +                *                             V
> > +                *                      instrs_executed
> > +                *
> > +                * Period instructions (Pi) contains the the number of
> > +                * instructions executed after the sample point(n).  When a new
> > +                * instruction packet is coming and generate for the next sample
> > +                * (n+1), it combines with two parts instructions, one is the
> > +                * tail of the old packet and another is the head of the new
> > +                * coming packet.  So 'head' variable is used to cauclate the
> typo : s/cauclate/calculate

Used checkpatch.pl but didn't see any complaints for this.

Thanks for pointing out and will fix it.

> > +                * instruction numbers in the new packet for sample(n+1).
> > +                *
> > +                * Sample(n+2) and sample(n+3) consume the instructions with
> > +                * sample period, so directly generate samples based on the
> > +                * sampe period.
> > +                *
> typo: s/sampe/sample

Will fix.

> > +                * After sample(n+3), the rest instructions will be used by
> > +                * later packet; so use 'instrs_over' to track the rest
> > +                * instruction number and it is assigned to
> > +                * 'tidq->period_instructions' for next round calculation.
> > +                */
> > +               u64 head, offset = 0;
> > +               u64 addr;
> >
> >                 /*
> > -                * Calculate the address of the sampled instruction (-1 as
> > -                * sample is reported as though instruction has just been
> > -                * executed, but PC has not advanced to next instruction)
> > +                * 'instrs_over' is the number of instructions executed after
> > +                * sample points, initialise it to 'instrs_executed' and will
> > +                * decrease it for consumed instructions in every synthesized
> > +                * instruction sample.
> >                  */
> > -               u64 offset = (instrs_executed - instrs_over - 1);
> > -               u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > -                                             tidq->packet, offset);
> > +               u64 instrs_over = instrs_executed;
> >
> > -               ret = cs_etm__synth_instruction_sample(
> > -                       etmq, tidq, addr, etm->instructions_sample_period);
> > -               if (ret)
> > -                       return ret;
> > +               /*
> > +                * 'head' is the instructions number of the head in the new
> > +                * packet, it combines with the tail of previous packet to
> > +                * generate a sample.  So 'head' uses the sample period to
> > +                * decrease the instruction number introduced by the previous
> > +                * packet.
> > +                */
> > +               head = etm->instructions_sample_period -
> > +                                 (tidq->period_instructions - instrs_executed);
> > +
> > +               if (head) {
> > +                       offset = head;
> > +
> > +                       /*
> > +                        * Calculate the address of the sampled instruction (-1
> > +                        * as sample is reported as though instruction has just
> > +                        * been executed, but PC has not advanced to next
> > +                        * instruction)
> > +                        */
> > +                       addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > +                                                 tidq->packet, offset - 1);
> > +                       ret = cs_etm__synth_instruction_sample(
> > +                               etmq, tidq, addr,
> > +                               etm->instructions_sample_period);
> > +                       if (ret)
> > +                               return ret;
> > +
> > +                       instrs_over -= head;
> > +               }
> > +
> > +               while (instrs_over >= etm->instructions_sample_period) {
> > +                       offset += etm->instructions_sample_period;
> > +
> > +                       /*
> > +                        * Calculate the address of the sampled instruction (-1
> > +                        * as sample is reported as though instruction has just
> > +                        * been executed, but PC has not advanced to next
> > +                        * instruction)
> > +                        */
> > +                       addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > +                                                 tidq->packet, offset - 1);
> > +                       ret = cs_etm__synth_instruction_sample(
> > +                               etmq, tidq, addr,
> > +                               etm->instructions_sample_period);
> > +                       if (ret)
> > +                               return ret;
> > +
> > +                       instrs_over -= etm->instructions_sample_period;
> > +               }
> >
> >                 /* Carry remaining instructions into next sample period */
> >                 tidq->period_instructions = instrs_over;
> > --
> > 2.17.1
> >
> 
> I believe the following change would work and make for easier reading...
> 
> .... at the start of the function remove instrs_executed and replace ....
> /* get instructions remainder from previous packet */
> u64 instrs_prev = tidq->period_instructions;
> 
> /* set available instructions to previous packet remainder + the
> current packet count  */
> tidq->period_instructions += tidq->packet->instr_count;
> 
> 
> .... within the if(etm->sample_instructions && ...) statement I would
> be more explicit what the elements of the diagram are ....
> 
> /*
>  * Below diagram demonstrates the instruction samples
>  * generation flows:
>  *
>  *    Instrs     Instrs       Instrs       Instrs
>  *   Sample(n)  Sample(n+1)  Sample(n+2)  Sample(n+3)
>  *    |            |            |            |
>  *    V            V            V            V
>  *   --------------------------------------------------
>  *            ^                                  ^
>  *            |                                  |
>  *         Period                             Period
>  *    instructions(Pi)                   instructions(Pi')
>  *
>  *            |                                  |
>  *            \---------------- -----------------/
>  *                             V
>  *                      tidq->packet->instr_count;
>  *
>  * Instrs Sample(n...) are the synthesised samples occuring every
> etm->instructions_sample_period
>  * instructions - as defined on the perf command line. Sample(n) being
> the last sample before the
>  * current etm packet, n+1 to n+3 samples generated from the current etm packet.
>  *
>  * tidq->packet->instr_count represents the number of instructions in
> the current etm packet.
>  *
>  * Period instructions (Pi) contains the the number of instructions
> executed after the sample point(n)
>  * from the previous etm packet. This will always be less than
> etm->instructions_sample_period.
>  *
> 
> .... continue with explanation here ....
> 
> 
> .... then we can simplify the loop code removing some of the temporary
> variables ....
> 
> /* get the initial offset into the current packet instructions
>    (entry conditions ensure that instrs_prev < etm->instructions_sample_period)
>  */
> u64 offset = etm->instructions_sample_period - instrs_prev;
> u64 addr;
> 
> /* Prepare last branches for instruction sample */
> if (etm->synth_opts.last_branch)
>     cs_etm__copy_last_branch_rb(etmq, tidq);
> 
> while (tidq->period_instructions >= etm->instructions_sample_period) {
> 
>       /*
>        * Calculate the address of the sampled instruction (-1
>        * as sample is reported as though instruction has just
>        * been executed, but PC has not advanced to next
>        * instruction)
>        */
>     addr = cs_etm__instr_addr(etmq, trace_chan_id, tidq->packet, offset - 1);
>     ret = cs_etm__synth_instruction_sample( etmq, tidq, addr,
>                 etm->instructions_sample_period);
>     if (ret)
>         return ret;
> 
>     offset += etm->instructions_sample_period;
>     tidq->period_instructions -= etm->instructions_sample_period;
> }
> 
> .....
> I believe the above should work, but cannot claim to have tried it
> out. What do you think?

Agree.  To be honest, I considered to use your suggested way, but I
worried about the boundary conditions for 'offset', so went back to
use explict method with two code segments (head and sequential samples).

After review the suggested code, I don't find any issue.  Will refine
code as this way and give testing for it.

Very appreciate the suggestions :)

Leo

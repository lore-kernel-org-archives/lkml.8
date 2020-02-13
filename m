Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871DCC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C621734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x4J7hsec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgBMNhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:37:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40192 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgBMNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:37:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so4354150qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkj4moyX3ExA3JZnxZnOdbwj7xLgfeduTVXJftss0No=;
        b=x4J7hsecZfskbx0MFkIaB+6D6tiFH482/wL2zMh8ETKzSXF1k3y6G43jc62Ex+EdMX
         0AaYUJ396uMAwEkihImcXRqU3RG1LmfW6JuZlN7AkSULnOw+0kpbHoeF0fcsxzdSui5M
         AZ3MW6H424BuVxAMVWMrhZh5rFpqghNFQbA/cXXy8MwAqtAyIxzlXLHO7iVnj3ADbQjr
         1bp8I/1leZb3WLPl5jrZ5ig8WUbvVti741NfMoGq7kdx1Eap2Smq4u8OOru6eqNXFEQJ
         d5S7RED7ykupKEdUuCqObzw2e4PJFmBSqR4kkpEc8u2u6jpvM1uERKv9AVV7zM3DNGGm
         fWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkj4moyX3ExA3JZnxZnOdbwj7xLgfeduTVXJftss0No=;
        b=Ae2Sh9qXc7ccZUTKIFgzu4QkFydckBviBF6D/4yBMp4VQGvJAhdyVNHb4EYYaIMLm0
         7TC9uYADJJBsHHUY5J4kMWqrtl14Uber4SL16jUi9a+9inpkjX72jzvOnZNcutGjn03H
         ypb5mDl9z1MikUGqHRhfFJeT8z1P97Ok+ZE3qxeIOrU+T3OuXPFbdvQxVDu0zHLIGDDK
         +a8zaUuNvPN5aS3tC9I/nDRWviSM1N63TIY4FjQhOtsTIbuZ10jN3ONFoW/E8Qab+We7
         f82iDRlWlRh/mxfEq/UpolwUS2LKdQ22kiZpvQbtBmQyo62QvaYElMXgpIO2Z+8wNP2E
         LAGw==
X-Gm-Message-State: APjAAAXszJSfjX9ESRkngY4touqCPNIB6sJaZz+U6SmtYLfKVqPmGEyh
        S5eghfjHTccLUwKwIpo+MdyuLTDNXz7zvsUFMdpa3A==
X-Google-Smtp-Source: APXvYqwCUnjFCT76RhU5vaFtih2+z6CRDR+ymGIdkVC44d+hjMqG3DfOSq34nv5WP7zKlsR1W1MZeWPi6NsKXxUBnCQ=
X-Received: by 2002:aed:3786:: with SMTP id j6mr24680000qtb.62.1581601035887;
 Thu, 13 Feb 2020 05:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20200213094204.2568-1-leo.yan@linaro.org> <20200213094204.2568-4-leo.yan@linaro.org>
In-Reply-To: <20200213094204.2568-4-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 13 Feb 2020 13:37:05 +0000
Message-ID: <CAJ9a7ViMH6XpSVFMewnxApcy8kvQp-5jAQuXoZvEBuYYaTQ0RA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] perf cs-etm: Correct synthesizing instruction samples
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed by: Mike Leach <mike.leach@linaro.org>

On Thu, 13 Feb 2020 at 09:43, Leo Yan <leo.yan@linaro.org> wrote:
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
> idea for handling coming packet is:
>
> - To synthesize the first instruction sample, it combines the left
>   instructions from the previous packet and the head of the new
>   packet; then generate continuous samples with sample period;
> - At the tail of the new packet, if it has the rest instructions,
>   these instructions will be left for the sequential sample.
>
> Suggested-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 87 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 17 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b2f31390126a..4b7d6c36ce3c 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1356,9 +1356,12 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>         struct cs_etm_auxtrace *etm = etmq->etm;
>         int ret;
>         u8 trace_chan_id = tidq->trace_chan_id;
> -       u64 instrs_executed = tidq->packet->instr_count;
> +       u64 instrs_prev;
>
> -       tidq->period_instructions += instrs_executed;
> +       /* Get instructions remainder from previous packet */
> +       instrs_prev = tidq->period_instructions;
> +
> +       tidq->period_instructions += tidq->packet->instr_count;
>
>         /*
>          * Record a branch when the last instruction in
> @@ -1376,26 +1379,76 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
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
> +                *                 tidq->packet->instr_count
> +                *
> +                * Instrs Sample(n...) are the synthesised samples occurring
> +                * every etm->instructions_sample_period instructions - as
> +                * defined on the perf command line.  Sample(n) is being the
> +                * last sample before the current etm packet, n+1 to n+3
> +                * samples are generated from the current etm packet.
> +                *
> +                * tidq->packet->instr_count represents the number of
> +                * instructions in the current etm packet.
> +                *
> +                * Period instructions (Pi) contains the the number of
> +                * instructions executed after the sample point(n) from the
> +                * previous etm packet.  This will always be less than
> +                * etm->instructions_sample_period.
> +                *
> +                * When generate new samples, it combines with two parts
> +                * instructions, one is the tail of the old packet and another
> +                * is the head of the new coming packet, to generate
> +                * sample(n+1); sample(n+2) and sample(n+3) consume the
> +                * instructions with sample period.  After sample(n+3), the rest
> +                * instructions will be used by later packet and it is assigned
> +                * to tidq->period_instructions for next round calculation.
> +                */
>
>                 /*
> -                * Calculate the address of the sampled instruction (-1 as
> -                * sample is reported as though instruction has just been
> -                * executed, but PC has not advanced to next instruction)
> +                * Get the initial offset into the current packet instructions;
> +                * entry conditions ensure that instrs_prev is less than
> +                * etm->instructions_sample_period.
>                  */
> -               u64 offset = (instrs_executed - instrs_over - 1);
> -               u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -                                             tidq->packet, offset);
> +               u64 offset = etm->instructions_sample_period - instrs_prev;
> +               u64 addr;
>
> -               ret = cs_etm__synth_instruction_sample(
> -                       etmq, tidq, addr, etm->instructions_sample_period);
> -               if (ret)
> -                       return ret;
> +               while (tidq->period_instructions >=
> +                               etm->instructions_sample_period) {
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
>
> -               /* Carry remaining instructions into next sample period */
> -               tidq->period_instructions = instrs_over;
> +                       offset += etm->instructions_sample_period;
> +                       tidq->period_instructions -=
> +                               etm->instructions_sample_period;
> +               }
>         }
>
>         if (etm->sample_branches) {
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

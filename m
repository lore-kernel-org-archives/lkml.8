Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25613C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E536A217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDoVu9ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBFLsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:48:07 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40186 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgBFLsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:48:06 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so5186828qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/u8lvgk0NC69lCwcmVZfuM0logUMbV9/5K5IshgRyII=;
        b=DDoVu9ahZ+Ap+93u8MAGwzuX2sk5Fyh9mTYGH24hkEoBupe8V1s8r1tyc3HymNXU2x
         goOv+bWqcswbeO80n2CVXvsC3zImb4a5rL/rh+b/xvlqXLdj4UHGN0YVgr6h6WVWuKHD
         92Bomcob7JYlvlI0fz6cahfSwAMWrSubdV6UBXpuKPFm5+QYhijBppU/Jwzm9LiTYx7e
         EomJLK7n5LSqxmVOxWIaPgQ+PxPEcEm5Vd5Ijgb1CKxmuJaUWysw81Ipuia7cAQW4uRf
         AdyjlFAzpOiOf7Rt+671CiLauqwcpVdSdgURzRYWCaJD39UwsLUZ6qd1rufp7QRvqyPL
         C4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/u8lvgk0NC69lCwcmVZfuM0logUMbV9/5K5IshgRyII=;
        b=HV8RxXs0jDUMOAJN7NM/3V2m0dTVY54zj/geeHKYkYj4vPql3L7cVyGk0jgQu2uxjO
         zuRFW6xvRzTgTR1dZCEPILrEgJrg7hHfBg1ZjCsUiRqRfmmzrSteXPuqbhMGjtJD3EyV
         KaUOFG3mbDt4RAesRruoTEGUENH8adewzLBRlmmSMY3FsMRT8CPCVsZorJE8Kj2SK0Ew
         f+hDnI4uSc6asENgGn8Fo50TLPPdF8LKeFiIXXrI5sWSV9Eh8krNTvhDW4pi0pWgDuyT
         GMemLcFWQQ3g0Es5wdu6UrBpnWMtAC4bqflNlZrrTV++VWQGxfWs7F2BZ29cfxqRdIBo
         zo6g==
X-Gm-Message-State: APjAAAXcmHVnuZd+kO/owYDFWklm+MRZgavviTqTb589ESf9bQmlHrQZ
        0+SbmmYhhjC047PNTUiVJsgOA0SokLpKP6qoRSQPhw==
X-Google-Smtp-Source: APXvYqzYYH+tW5YrglZD3ssrPMzlN82itd1CZ/QvnglBZm1r41ASPrFGsYEMpm4ullIwMLaJv6uPYWuFCaSzUvvy43I=
X-Received: by 2002:a37:9c8a:: with SMTP id f132mr2057012qke.432.1580989685049;
 Thu, 06 Feb 2020 03:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20200203015203.27882-1-leo.yan@linaro.org> <20200203015203.27882-5-leo.yan@linaro.org>
In-Reply-To: <20200203015203.27882-5-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Feb 2020 11:47:54 +0000
Message-ID: <CAJ9a7VipUiYZYVkOA-rEakmOhRJp0EhKzoZMFQO0QZmfKhvScg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] perf cs-etm: Optimize copying last branches
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

Reviewed by: Mike Leach <mike.leach@linaro.org>

On Mon, 3 Feb 2020 at 01:53, Leo Yan <leo.yan@linaro.org> wrote:
>
> If an instruction range packet can generate multiple instruction
> samples, these samples share the same last branches; it's not necessary
> to copy the same last branches repeatedly for these samples within the
> same packet.
>
> This patch moves out the last branches copying from function
> cs_etm__synth_instruction_sample(), and execute it prior to generating
> instruction samples.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index c5a05f728eac..dbddf1eec2be 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1134,10 +1134,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>
>         cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
>
> -       if (etm->synth_opts.last_branch) {
> -               cs_etm__copy_last_branch_rb(etmq, tidq);
> +       if (etm->synth_opts.last_branch)
>                 sample.branch_stack = tidq->last_branch;
> -       }
>
>         if (etm->synth_opts.inject) {
>                 ret = cs_etm__inject_event(event, &sample,
> @@ -1407,6 +1405,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>                  */
>                 u64 instrs_over = instrs_executed;
>
> +               /* Prepare last branches for instruction sample */
> +               if (etm->synth_opts.last_branch)
> +                       cs_etm__copy_last_branch_rb(etmq, tidq);
> +
>                 /*
>                  * 'head' is the instructions number of the head in the new
>                  * packet, it combines with the tail of previous packet to
> @@ -1526,6 +1528,11 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>
>         if (etmq->etm->synth_opts.last_branch &&
>             tidq->prev_packet->sample_type == CS_ETM_RANGE) {
> +               u64 addr;
> +
> +               /* Prepare last branches for instruction sample */
> +               cs_etm__copy_last_branch_rb(etmq, tidq);
> +
>                 /*
>                  * Generate a last branch event for the branches left in the
>                  * circular buffer at the end of the trace.
> @@ -1533,7 +1540,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>                  * Use the address of the end of the last reported execution
>                  * range
>                  */
> -               u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
> +               addr = cs_etm__last_executed_instr(tidq->prev_packet);
>
>                 err = cs_etm__synth_instruction_sample(
>                         etmq, tidq, addr,
> @@ -1587,11 +1594,16 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
>          */
>         if (etmq->etm->synth_opts.last_branch &&
>             tidq->prev_packet->sample_type == CS_ETM_RANGE) {
> +               u64 addr;
> +
> +               /* Prepare last branches for instruction sample */
> +               cs_etm__copy_last_branch_rb(etmq, tidq);
> +
>                 /*
>                  * Use the address of the end of the last reported execution
>                  * range.
>                  */
> -               u64 addr = cs_etm__last_executed_instr(tidq->prev_packet);
> +               addr = cs_etm__last_executed_instr(tidq->prev_packet);
>
>                 err = cs_etm__synth_instruction_sample(
>                         etmq, tidq, addr,
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A99C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E55621775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtnOfDrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBFPCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:02:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39976 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgBFPCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:02:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so4682799qto.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWEWiuJtZyx2zIqvzpl4qhmoi+sTlz6jFzFqkOV/q7g=;
        b=RtnOfDrp8CNGIanlmOJMlF5BwBJnCwI18OyxuawvJWAmhNv/yTyB2NbWNuiRKiFPHI
         KBSLGqotRdctDJ5uJgw9GS3jZ8U8mhBU3IjIE9YE+oUcq4PFc7oMbOViXVFdrLAD4e8S
         OFk+C8GklRT70wipxB0zCpy/uCkUch7IEU3gqWPfjCOrZFU/gqTEYrRhzEV3tlMcjNAv
         0xKWqIMVIFMWrRFz9eitUIaO/XpINuj0LbAECRL4FA9a0TcrgUKHWAG7WX+mh2Hg76f3
         9t9Jlgh6NY9AmKVV6qrmaPB7cRe/7KOZlVkaqLAKE+1jEU7FQ6RM6uICy7xZh2u5i3HZ
         xyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWEWiuJtZyx2zIqvzpl4qhmoi+sTlz6jFzFqkOV/q7g=;
        b=SyJqOJcq7LAIhLVeK8BP0IEppvHdc1IpKIJLfe+DXNBrIKBz58qLO0rCfYEOGMVah4
         AlKYxV7q5If1AXbSDqC3bUjZy9ieWKMPIoyx6vgfWwnSEsIamDpfHSqkGcsKxNuV7nJa
         fJjh6UTVAqA1F5IS63KTPIR/kUQwCP6AE9AE/2dCwxAam9cklvAjdWW6VFYgXheD4O+N
         Gxvb2Cf4yp4HtY3LRxJP3DGvYn86obiqgehPrCp47zEKu9AK13Gna+awjNs5Yt95iepP
         1D6hqmKHMFOZzn5HIknnX3tVUT5fP1sHctsqrs9T38xTa8n447PWTZxIH7afe3ZyPajf
         PbWQ==
X-Gm-Message-State: APjAAAWY4n//LRXq3xoaGRFxVuIEUhXzbAvEWMhKZz4VIMjvdP1/vMjn
        LxO0wFeJqsUZy5cELyvRjUw5icjNl++gW6YEeioyTw==
X-Google-Smtp-Source: APXvYqwfQE/m1Tuzs26Cj0rJ2ZoZwY+kuHzZ25uJ45GlK2PWON99KVRzapB+ShkXZz0XrwaNR3iTCKR0WSHfTHkhoPg=
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr3081302qtu.2.1581001323308;
 Thu, 06 Feb 2020 07:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20200203020716.31832-1-leo.yan@linaro.org> <20200203020716.31832-6-leo.yan@linaro.org>
In-Reply-To: <20200203020716.31832-6-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 6 Feb 2020 15:01:52 +0000
Message-ID: <CAJ9a7VieWK5M7JOz0LXtKKdkSBbyRRpcXTsXr46S=gfYyaBEMw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] perf cs-etm: Synchronize instruction sample with
 the thread stack
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

On Mon, 3 Feb 2020 at 02:08, Leo Yan <leo.yan@linaro.org> wrote:
>
> The synthesized flow use 'tidq->packet' for instruction samples; on the
> other hand, 'tidp->prev_packet' is used to generate the thread stack and
> the branch samples, this results in the instruction samples using one
> packet ahead than thread stack and branch samples ('tidp->prev_packet'
> vs 'tidq->packet').
>
> This leads to an instruction's callchain error as shows in below
> example:
>
>   main  1579        100      instructions:
>         ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
>         ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
>         ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
>         ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
>         ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
>         ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
>         ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
>
> In the callchain log, for the two continuous lines the up line contains
> one child function info and the followed line contains the caller
> function info, and so forth.  So the first two lines are:
>
>   perf_event_update_userpage+0x4c  => the sampled instruction
>   perf_event_update_userpage+0x48  => the parent function's calling
>
> The child function and parent function both are the same function
> perf_event_update_userpage(), but this isn't a recursive function, thus
> the sequence for perf_event_update_userpage() calling itself shouldn't
> never happen.  This callchain error is caused by the instruction sample
> using an ahead packet than the thread stack, the thread stack is deferred
> to process the new packet and misses to pop stack if it is just a return
> packet.
>
> To fix this issue, we can simply change to use 'tidq->prev_packet' to
> generate the instruction samples, this allows the thread stack to push
> and pop synchronously with instruction sample.  Finally, the callchain
> can be displayed correctly as below:
>
>   main  1579        100      instructions:
>         ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
>         ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
>         ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
>         ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
>         ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
>         ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8f805657658d..410e40ce19f2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1414,7 +1414,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>         struct cs_etm_packet *tmp;
>         int ret;
>         u8 trace_chan_id = tidq->trace_chan_id;
> -       u64 instrs_executed = tidq->packet->instr_count;
> +       u64 instrs_executed = tidq->prev_packet->instr_count;
>
>         tidq->period_instructions += instrs_executed;
>
> @@ -1505,7 +1505,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>                          * instruction)
>                          */
>                         addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -                                                 tidq->packet, offset - 1);
> +                                                 tidq->prev_packet,
> +                                                 offset - 1);
>                         ret = cs_etm__synth_instruction_sample(
>                                 etmq, tidq, addr,
>                                 etm->instructions_sample_period);
> @@ -1525,7 +1526,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>                          * instruction)
>                          */
>                         addr = cs_etm__instr_addr(etmq, trace_chan_id,
> -                                                 tidq->packet, offset - 1);
> +                                                 tidq->prev_packet,
> +                                                 offset - 1);
>                         ret = cs_etm__synth_instruction_sample(
>                                 etmq, tidq, addr,
>                                 etm->instructions_sample_period);
> --
> 2.17.1
>
I am really not convinced that this is a correct solution.

Consider a set of trace range packet inputs:
current: 0x3000-0x3050
prev:  0x2000-0x2100
prev-1: 0x1020-0x1080

Before your modification.....
cs_etm__sample()  processes the current packet....

On entry, the branch stack will contain:0x1080=>0x2000;

We add to this from the current packet to get: 0x1080=>0x2000; 0x2100=>0x3000;

This is then copied by cs_etm__copy_last_branch_rb()

We find the instruction sample address in the range 0x3000 to 0x3050,
e.g. 0x3010.
cs_etm__synth_instruction_sample() will then generate a sample with values

sample.ip = 0x3010
sample.branch_stack = 0x1080=>0x2000; 0x2100=>0x3000;

to be passed to the perf session / injected as required.
This sample has the correct branch context for the sampled address -
i.e. how the code arrived @0x3010

After the modification.....
The branch stack will be the same, but the sample address will be from
the range 0x2000-0x2010, e.g. 0x2008 to give a sample in
cs_etm__synth_instruction_sample() of
sample.ip = 0x2008
sample.branch_stack = 0x1080=>0x2000; 0x2100=>0x3000;

This really does not make much sense  - the branch stack no longer
relates to the sample.ip.

Further - cs_etm__synth_instruction_sample() calls cs_etm__copy_insn()
using the _current_ packet and sample.ip. This is a clear mismatch.

I don't know what is causing the apparent error in the callchain, but
given that the previous features added in this set, work without this
alteration, I feel there must be another solution.

Regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

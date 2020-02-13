Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88825C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4984D2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeZ67KaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgBMPBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:01:11 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42702 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMPBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:01:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id r5so4551061qtt.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OR3oOx+mGh+DIZ4suhyE7x7FqGwsyDSmBViZLPUhWVs=;
        b=oeZ67KaIj037HudvxKnfHXDnyVRuN91j89zw5cx1ZgKARMNI4xNdkP75morDsAWLVV
         3NLd1RKOtMtQwxr6jyhU0O439UxkbvqB6cy9y4yqjqHYL2HzrpEnn91iiukzDKiRLATe
         F4MauVXJ8fcfhoj9qLPFz/pBKW88EzSOG2jwGFxFFYX6Jf11vvmkhOXC0VvrqtoMcYGL
         e8Xt7Mia1xpIdYQYLmBuN2hQ9oQzzhLuKKEh6IoKb95z78NSi2GSYZrpoeJxB8GdVABM
         128Csj7f60k/0uTsUd5IZj1W9UfwnbEuDYJ9lZMGTpIdo8+Wrz5EP/3Khv1y8l2UZnSO
         SSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OR3oOx+mGh+DIZ4suhyE7x7FqGwsyDSmBViZLPUhWVs=;
        b=VjjgF+JXOkE4p6vD/VmOdxqbLLFLRN7a6YQRyTeEa4ygfZ/v3hVGVuaC6wqRwJncI6
         fZx7gApy9I5nsfO6E/J/UaXQ9iAlhS7xMdxA/t9Oz/tOcn2zRLWjPnRzsF3xWf60GLA9
         fOmVIytqs/6c+XvtOEtiH3X1bDKYqGyVQ7KaKjEwbJOWs4BVIUe3SWsDu4qreSDHc8yi
         DmexvB5ARoPbJU7Q+kfrREGEoANaaynN/TzqAlogz7BKsiTWM+a3bF7XX4vZiohS60Vu
         heIPCyJ8vcG3cHdaN/pkYgzmadR21KFreWvoP2ophbpZKRWdmN6gZUqmeEoxb6xTrXbb
         tI4A==
X-Gm-Message-State: APjAAAXb2aemmp8XQaPSjFGOyJEB1crhboKQH3zoE9g0Cut4kQBzHiCg
        ylWE+YBcw55xmHgaL7x8Y3J76xUgK5vyUGWyKymlsw==
X-Google-Smtp-Source: APXvYqyVB3PPCs2XkmFZ1ygEBo1+q3TAMC7oQbgAgph0Hg/gyNR+AN+JE/JTXchGBWA+OLDPwyfop6CRqJ4FeIuJLLE=
X-Received: by 2002:aed:3b14:: with SMTP id p20mr24593927qte.176.1581606069245;
 Thu, 13 Feb 2020 07:01:09 -0800 (PST)
MIME-Version: 1.0
References: <20200203020716.31832-1-leo.yan@linaro.org> <20200203020716.31832-6-leo.yan@linaro.org>
 <CAJ9a7VieWK5M7JOz0LXtKKdkSBbyRRpcXTsXr46S=gfYyaBEMw@mail.gmail.com> <20200213090827.GA21618@leoy-ThinkPad-X240s>
In-Reply-To: <20200213090827.GA21618@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 13 Feb 2020 15:00:57 +0000
Message-ID: <CAJ9a7VjB9XVcJKjOGntYmAW9dTV9oi_=S7Ae=1QOh5DoRzQ92g@mail.gmail.com>
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

On Thu, 13 Feb 2020 at 09:08, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Thu, Feb 06, 2020 at 03:01:52PM +0000, Mike Leach wrote:
> > Hi Leo,
> >
> > On Mon, 3 Feb 2020 at 02:08, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > The synthesized flow use 'tidq->packet' for instruction samples; on the
> > > other hand, 'tidp->prev_packet' is used to generate the thread stack and
> > > the branch samples, this results in the instruction samples using one
> > > packet ahead than thread stack and branch samples ('tidp->prev_packet'
> > > vs 'tidq->packet').
> > >
> > > This leads to an instruction's callchain error as shows in below
> > > example:
> > >
> > >   main  1579        100      instructions:
> > >         ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> > >         ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
> > >         ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> > >         ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> > >         ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> > >         ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> > >         ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> > >
> > > In the callchain log, for the two continuous lines the up line contains
> > > one child function info and the followed line contains the caller
> > > function info, and so forth.  So the first two lines are:
> > >
> > >   perf_event_update_userpage+0x4c  => the sampled instruction
> > >   perf_event_update_userpage+0x48  => the parent function's calling
> > >
> > > The child function and parent function both are the same function
> > > perf_event_update_userpage(), but this isn't a recursive function, thus
> > > the sequence for perf_event_update_userpage() calling itself shouldn't
> > > never happen.  This callchain error is caused by the instruction sample
> > > using an ahead packet than the thread stack, the thread stack is deferred
> > > to process the new packet and misses to pop stack if it is just a return
> > > packet.
> > >
> > > To fix this issue, we can simply change to use 'tidq->prev_packet' to
> > > generate the instruction samples, this allows the thread stack to push
> > > and pop synchronously with instruction sample.  Finally, the callchain
> > > can be displayed correctly as below:
> > >
> > >   main  1579        100      instructions:
> > >         ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> > >         ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> > >         ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> > >         ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> > >         ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> > >         ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index 8f805657658d..410e40ce19f2 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -1414,7 +1414,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> > >         struct cs_etm_packet *tmp;
> > >         int ret;
> > >         u8 trace_chan_id = tidq->trace_chan_id;
> > > -       u64 instrs_executed = tidq->packet->instr_count;
> > > +       u64 instrs_executed = tidq->prev_packet->instr_count;
> > >
> > >         tidq->period_instructions += instrs_executed;
> > >
> > > @@ -1505,7 +1505,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> > >                          * instruction)
> > >                          */
> > >                         addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > > -                                                 tidq->packet, offset - 1);
> > > +                                                 tidq->prev_packet,
> > > +                                                 offset - 1);
> > >                         ret = cs_etm__synth_instruction_sample(
> > >                                 etmq, tidq, addr,
> > >                                 etm->instructions_sample_period);
> > > @@ -1525,7 +1526,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> > >                          * instruction)
> > >                          */
> > >                         addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > > -                                                 tidq->packet, offset - 1);
> > > +                                                 tidq->prev_packet,
> > > +                                                 offset - 1);
> > >                         ret = cs_etm__synth_instruction_sample(
> > >                                 etmq, tidq, addr,
> > >                                 etm->instructions_sample_period);
> > > --
> > > 2.17.1
> > >
> > I am really not convinced that this is a correct solution.
> >
> > Consider a set of trace range packet inputs:
> > current: 0x3000-0x3050
> > prev:  0x2000-0x2100
> > prev-1: 0x1020-0x1080
> >
> > Before your modification.....
> > cs_etm__sample()  processes the current packet....
> >
> > On entry, the branch stack will contain:0x1080=>0x2000;
> >
> > We add to this from the current packet to get: 0x1080=>0x2000; 0x2100=>0x3000;
> >
> > This is then copied by cs_etm__copy_last_branch_rb()
> >
> > We find the instruction sample address in the range 0x3000 to 0x3050,
> > e.g. 0x3010.
> > cs_etm__synth_instruction_sample() will then generate a sample with values
> >
> > sample.ip = 0x3010
> > sample.branch_stack = 0x1080=>0x2000; 0x2100=>0x3000;
> >
> > to be passed to the perf session / injected as required.
> > This sample has the correct branch context for the sampled address -
> > i.e. how the code arrived @0x3010
> >
> > After the modification.....
> > The branch stack will be the same, but the sample address will be from
> > the range 0x2000-0x2010, e.g. 0x2008 to give a sample in
> > cs_etm__synth_instruction_sample() of
> > sample.ip = 0x2008
> > sample.branch_stack = 0x1080=>0x2000; 0x2100=>0x3000;
> >
> > This really does not make much sense  - the branch stack no longer
> > relates to the sample.ip.
> >
> > Further - cs_etm__synth_instruction_sample() calls cs_etm__copy_insn()
> > using the _current_ packet and sample.ip. This is a clear mismatch.
> >
> > I don't know what is causing the apparent error in the callchain, but
> > given that the previous features added in this set, work without this
> > alteration, I feel there must be another solution.
>
> Good catch!  Thanks a lot for very detailed analysis.
>
> I root caused this issue is relevant with the sequence between two
> functions thread_stack__event() and thread_stack__sample().
>
> In this series, thread_stack__sample() is prior to thread_stack__event(),
> thus the thread stack event cannot be handled before thread stack
> generation.
>
> If move the function thread_stack__event() up and place it before
> instruction sample synthesizing; thread_stack__event() can be invoked
> prior to thread_stack__sample(), then I can see the thread stack can
> be popped properly and the issue can be fixed.  Simply to say, patch
> 0002 should change the code as below:
>
>          /*
>           * Record a branch when the last instruction in
>           * PREV_PACKET is a branch.
>           */
>          if (etm->synth_opts.last_branch &&
>              tidq->prev_packet->sample_type == CS_ETM_RANGE &&
>              tidq->prev_packet->last_instr_taken_branch)
>                  cs_etm__update_last_branch_rb(etmq, tidq);
>
>          /*
>           * The stack event must be processed prior to synthesizing
>           * instruction sample; this can ensure the instruction samples
>           * to generate correct thread stack.
>           */
>          if (tidq->prev_packet->last_instr_taken_branch)
>                  cs_etm__add_stack_event(etmq, tidq);
>
>          if (etm->sample_instructions &&
>              tidq->period_instructions >= etm->instructions_sample_period) {
>
>                 cs_etm__synth_instruction_sample();
>                     `-> thread_stack__sample();
>
>          }
>
> Does this make sense for you?
>
This looks good.

Regards

Mike



> Thanks,
> Leo Yan



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19783C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C1820848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1oIXlIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgBMJIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:08:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39777 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbgBMJIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:08:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so2094758plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y3s6gaPNv6gh+GkzKyY3UtAQAchaJB9LiAGyIZUo9HA=;
        b=L1oIXlIZNksy4ObWQD8J12F1MQ4PdH6+bQ3sKhZweOunw9sTHubLYqqrpljDD0iay9
         rO28jJD2pd2ck5nR2h63jFFnCPhIbDQ2+YXmsPdzwg5H2sxdFsKHSS+vmUr/qeKYy8X9
         QeGViJCBpNnk+J7GXhdgxiK7rNHytD06p8ZKQL4qcbRxq2UbGrZtx0XqRfk6q/IaLXiQ
         O3DsSgcOSW7OjJTEjWZS9WhCojf3W4MNiH51gyaoHTU49TI4HOJCZElvQdLUcUQWqQwQ
         rNwX3macnKNHJy3dlq381tAJEBp+jm/58bN9iY3dLnGvRnMpOI+JicQOfnvL5WKzOkUz
         yPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y3s6gaPNv6gh+GkzKyY3UtAQAchaJB9LiAGyIZUo9HA=;
        b=URQ/L1HHlzcwmXOMGDqhQjWMMKLZQs1AmNrYs/t4m5lA/xq803DYEfjB1CKU/liz+Z
         iuxBZbIkYkEC5I68DdPYVFjbas88IBqUPU37dz7PD3SRmiH/cfZxhWWvoPuA+qyWZh2k
         FyyOZNsjjwEIEZR+RKoIupYtbJY4me6SEwGY/bO4PXWtXCre/ugqKzimWUQGMPjMHZRJ
         ptqz/+iIgYho1w+Na4zLhqcjuqsW4u8yPbayZhMdt0llRKbiZt249UUHIVhX5VfA0mzI
         e7sQ9W2Jy7jauk4f81a+R6jFHPg94exd2rCGRCwFFFG3LPUBrKIRrLq9S22QqbC5HD4Z
         Tzgg==
X-Gm-Message-State: APjAAAXqPW8f7lPsgLOjGz5WrbjefdiZWzhrYtw8Mtvt2VIiTrTp4XVl
        agUYSfIW8Y4dVZk+ITD1PWAFGw==
X-Google-Smtp-Source: APXvYqwC4cm2/Bv7q5TSW/LRjI3f5vN1nqt2IbQv4GmbN5CWol55Z3dzaevCUFysDYHWIieLv7C9kw==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr27247972plk.32.1581584922048;
        Thu, 13 Feb 2020 01:08:42 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:ee42])
        by smtp.gmail.com with ESMTPSA id 13sm1970773pgo.13.2020.02.13.01.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 01:08:41 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:08:27 +0800
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
Subject: Re: [PATCH v4 5/5] perf cs-etm: Synchronize instruction sample with
 the thread stack
Message-ID: <20200213090827.GA21618@leoy-ThinkPad-X240s>
References: <20200203020716.31832-1-leo.yan@linaro.org>
 <20200203020716.31832-6-leo.yan@linaro.org>
 <CAJ9a7VieWK5M7JOz0LXtKKdkSBbyRRpcXTsXr46S=gfYyaBEMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VieWK5M7JOz0LXtKKdkSBbyRRpcXTsXr46S=gfYyaBEMw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Feb 06, 2020 at 03:01:52PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> On Mon, 3 Feb 2020 at 02:08, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > The synthesized flow use 'tidq->packet' for instruction samples; on the
> > other hand, 'tidp->prev_packet' is used to generate the thread stack and
> > the branch samples, this results in the instruction samples using one
> > packet ahead than thread stack and branch samples ('tidp->prev_packet'
> > vs 'tidq->packet').
> >
> > This leads to an instruction's callchain error as shows in below
> > example:
> >
> >   main  1579        100      instructions:
> >         ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> >         ffff000010214850 perf_event_update_userpage+0x48 ([kernel.kallsyms])
> >         ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> >         ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> >         ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> >         ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> >         ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> >
> > In the callchain log, for the two continuous lines the up line contains
> > one child function info and the followed line contains the caller
> > function info, and so forth.  So the first two lines are:
> >
> >   perf_event_update_userpage+0x4c  => the sampled instruction
> >   perf_event_update_userpage+0x48  => the parent function's calling
> >
> > The child function and parent function both are the same function
> > perf_event_update_userpage(), but this isn't a recursive function, thus
> > the sequence for perf_event_update_userpage() calling itself shouldn't
> > never happen.  This callchain error is caused by the instruction sample
> > using an ahead packet than the thread stack, the thread stack is deferred
> > to process the new packet and misses to pop stack if it is just a return
> > packet.
> >
> > To fix this issue, we can simply change to use 'tidq->prev_packet' to
> > generate the instruction samples, this allows the thread stack to push
> > and pop synchronously with instruction sample.  Finally, the callchain
> > can be displayed correctly as below:
> >
> >   main  1579        100      instructions:
> >         ffff000010214854 perf_event_update_userpage+0x4c ([kernel.kallsyms])
> >         ffff000010219360 perf_swevent_add+0x88 ([kernel.kallsyms])
> >         ffff0000102135f4 event_sched_in.isra.57+0xbc ([kernel.kallsyms])
> >         ffff0000102137a0 group_sched_in+0x60 ([kernel.kallsyms])
> >         ffff000010213b84 flexible_sched_in+0xfc ([kernel.kallsyms])
> >         ffff00001020c0b4 visit_groups_merge+0x12c ([kernel.kallsyms])
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 8f805657658d..410e40ce19f2 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1414,7 +1414,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >         struct cs_etm_packet *tmp;
> >         int ret;
> >         u8 trace_chan_id = tidq->trace_chan_id;
> > -       u64 instrs_executed = tidq->packet->instr_count;
> > +       u64 instrs_executed = tidq->prev_packet->instr_count;
> >
> >         tidq->period_instructions += instrs_executed;
> >
> > @@ -1505,7 +1505,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >                          * instruction)
> >                          */
> >                         addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > -                                                 tidq->packet, offset - 1);
> > +                                                 tidq->prev_packet,
> > +                                                 offset - 1);
> >                         ret = cs_etm__synth_instruction_sample(
> >                                 etmq, tidq, addr,
> >                                 etm->instructions_sample_period);
> > @@ -1525,7 +1526,8 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >                          * instruction)
> >                          */
> >                         addr = cs_etm__instr_addr(etmq, trace_chan_id,
> > -                                                 tidq->packet, offset - 1);
> > +                                                 tidq->prev_packet,
> > +                                                 offset - 1);
> >                         ret = cs_etm__synth_instruction_sample(
> >                                 etmq, tidq, addr,
> >                                 etm->instructions_sample_period);
> > --
> > 2.17.1
> >
> I am really not convinced that this is a correct solution.
> 
> Consider a set of trace range packet inputs:
> current: 0x3000-0x3050
> prev:  0x2000-0x2100
> prev-1: 0x1020-0x1080
> 
> Before your modification.....
> cs_etm__sample()  processes the current packet....
> 
> On entry, the branch stack will contain:0x1080=>0x2000;
> 
> We add to this from the current packet to get: 0x1080=>0x2000; 0x2100=>0x3000;
> 
> This is then copied by cs_etm__copy_last_branch_rb()
> 
> We find the instruction sample address in the range 0x3000 to 0x3050,
> e.g. 0x3010.
> cs_etm__synth_instruction_sample() will then generate a sample with values
> 
> sample.ip = 0x3010
> sample.branch_stack = 0x1080=>0x2000; 0x2100=>0x3000;
> 
> to be passed to the perf session / injected as required.
> This sample has the correct branch context for the sampled address -
> i.e. how the code arrived @0x3010
> 
> After the modification.....
> The branch stack will be the same, but the sample address will be from
> the range 0x2000-0x2010, e.g. 0x2008 to give a sample in
> cs_etm__synth_instruction_sample() of
> sample.ip = 0x2008
> sample.branch_stack = 0x1080=>0x2000; 0x2100=>0x3000;
> 
> This really does not make much sense  - the branch stack no longer
> relates to the sample.ip.
> 
> Further - cs_etm__synth_instruction_sample() calls cs_etm__copy_insn()
> using the _current_ packet and sample.ip. This is a clear mismatch.
> 
> I don't know what is causing the apparent error in the callchain, but
> given that the previous features added in this set, work without this
> alteration, I feel there must be another solution.

Good catch!  Thanks a lot for very detailed analysis.

I root caused this issue is relevant with the sequence between two
functions thread_stack__event() and thread_stack__sample().

In this series, thread_stack__sample() is prior to thread_stack__event(),
thus the thread stack event cannot be handled before thread stack
generation.

If move the function thread_stack__event() up and place it before
instruction sample synthesizing; thread_stack__event() can be invoked
prior to thread_stack__sample(), then I can see the thread stack can
be popped properly and the issue can be fixed.  Simply to say, patch
0002 should change the code as below:

         /*
          * Record a branch when the last instruction in
          * PREV_PACKET is a branch.
          */
         if (etm->synth_opts.last_branch &&                                 
             tidq->prev_packet->sample_type == CS_ETM_RANGE &&              
             tidq->prev_packet->last_instr_taken_branch)                    
                 cs_etm__update_last_branch_rb(etmq, tidq);                 
                                                                            
         /*                                                                 
          * The stack event must be processed prior to synthesizing         
          * instruction sample; this can ensure the instruction samples     
          * to generate correct thread stack.                               
          */                                                                
         if (tidq->prev_packet->last_instr_taken_branch)                    
                 cs_etm__add_stack_event(etmq, tidq);                       
                                                                            
         if (etm->sample_instructions &&                                    
             tidq->period_instructions >= etm->instructions_sample_period) {

                cs_etm__synth_instruction_sample();
                    `-> thread_stack__sample();

         }

Does this make sense for you?

Thanks,
Leo Yan

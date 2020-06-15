Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EF7207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKg8Ih5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgFOPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:05:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730836AbgFOPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592233537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrRZUT2c5LyqA3x8SQlR9j4fYYTkMxBlAJHHc8RFzP8=;
        b=PKg8Ih5/WA09wFzvOFMSLbQDHDJP/Vxt0LfkVcH9/OZD5owz6E8B4YG8ByYX7o8lkhLByN
        nN4ipSsJWm2qK8s+07KudLCM08tFh/7pWYn/VNsLYbkb42wZcKvq5jcwTzEmDmWVd7gSGS
        RCQ2f6LqIgg60LKJSCNWOfFQl7bvdjI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-m6fInJqQOY-Ga1SQyC-nuA-1; Mon, 15 Jun 2020 11:05:30 -0400
X-MC-Unique: m6fInJqQOY-Ga1SQyC-nuA-1
Received: by mail-wm1-f69.google.com with SMTP id b63so88862wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mrRZUT2c5LyqA3x8SQlR9j4fYYTkMxBlAJHHc8RFzP8=;
        b=hoVTxtLBVql6fLGKjXvILT13LKdlbF8MVuY1uZeoQAKExk7z2Aab22rSy9ZtjDQvgI
         sQxJ1Z/NHyEu7SVjyt/C1ijtSR9h3sGEBjx0bDwUOBcLrZVKLhyyO1u1qO9vXTCGxzRS
         Dd/BQewis8SKSHNisYSN0FXC3lKkZm4S+4dY9I54wNE8D+OxCLRmS/Z59ru0ykjYnyrn
         EzvbrRgNlGx1yHxxaVVNC0xd84trLvwVIJtDP0QwnQKA9Icr28T5Jl6xk6emVdv2rWgO
         yYdaMbG3WoMmqdMUYCQErNhlS+3vWyXF+kzItrTFwlmsxma1fNdlPu8BQ5P/fS/9y14S
         VxQw==
X-Gm-Message-State: AOAM530vBs2aPBoQ6ZtRihT2jQ1ZZ7U8mN8twpeIak+ShCvIT37My7+m
        B3+vyPe+RLJ6vvnsjhqmrFGGwhUg1AzUJimbFfbn6xgmbDH3tLv6KyUf7c/CpCxXWL8yOnntEFC
        9VTZgMLl7q21qGaogzzvsxa6m
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr14176064wms.40.1592233528782;
        Mon, 15 Jun 2020 08:05:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE0nuEPIGN05gfMtmQ5IY9voNFe//QuxbPrY292RZj8AxdR/2U2gGiXDbgZmDMfdbE8kiBgg==
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr14176018wms.40.1592233528313;
        Mon, 15 Jun 2020 08:05:28 -0700 (PDT)
Received: from localhost.localdomain ([151.29.176.125])
        by smtp.gmail.com with ESMTPSA id k16sm25448761wrp.66.2020.06.15.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:05:27 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:05:25 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200615150525.GA435888@localhost.localdomain>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521170020.GQ10078@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/20 19:00, Juri Lelli wrote:
> On 21/05/20 02:44, Frederic Weisbecker wrote:
> > On Wed, May 20, 2020 at 08:47:10PM +0200, Juri Lelli wrote:
> > > On 20/05/20 19:02, Frederic Weisbecker wrote:
> > > > On Wed, May 20, 2020 at 06:49:25PM +0200, Juri Lelli wrote:
> > > > > On 20/05/20 18:24, Frederic Weisbecker wrote:
> > > > > 
> > > > > Hummm, so I enabled 'timer:*', anything else you think I should be
> > > > > looking at?
> > > > 
> > > > Are you sure you also enabled timer_expire_entry?
> > > > Because:
> > > 
> > > I run with
> > > 
> > > trace-cmd record -e sched_switch -e sched_wakeup -e sched_migrate_task \
> > > -e 'timer:*' -e 'irq_vectors:*' -e 'irq:softirq*' \
> > > -e 'irq:irq_handler*' taskset --cpu-list 4-35 ./sysjitter/sysjitter \
> > > --runtime 10 200
> > > 
> > > And
> > > 
> > > $ grep ' timer_expire_entry:' trace.txt | wc -l
> > > 1173
> > > 
> > > seems to confirm that the event was indeed enabled, e.g.
> > > 
> > > ksoftirqd/11-100   [011]   159.270023: timer_expire_entry:   timer=0xffff9807df8a5a60 function=delayed_work_timer_fn now=4294826418 baseclk=4294825984
> > 
> > That's interesting! I'll see if I can reproduce that with threaded irqs. If not we'll
> > have to investigate on your machine. We really don't want to trigger timer softirqs
> > when it's not necessary.
> > 
> 
> So, I managed to get a bit more info on this, please check the following
> (which I edited a bit to hopefully make it clearer and apologies for
> long lines, but I believe trimming them would mess things up)
> 
> ---
> ksoftirqd/3-26    [003]    99.942485: timer_expire_entry:   timer=0xffffffffa55a9d20 function=clocksource_watchdog now=4294759328 baseclk=4294759328
> ksoftirqd/3-26    [003]    99.942489: timer_start:          timer=0xffffffffa55a9d20 function=clocksource_watchdog expires=4294759822 [timeout=494] cpu=4 idx=114 flags=D|P|I
> ksoftirqd/3-26    [003]    99.942491: timer_expire_exit:    timer=0xffffffffa55a9d20
>   sysjitter-2377  [004]    99.942491: call_function_single_entry: vector=251
>   sysjitter-2377  [004]    99.942492: call_function_single_exit: vector=251
> ksoftirqd/3-26    [003]    99.942493: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/3-26    [003]    99.942494: softirq_entry:        vec=7 [action=SCHED]
>   sysjitter-2377  [004]    99.942494: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92630457385 softexpires=92630457385
> ---
> 
> So, my understanding is that clock gets reactivated on CPU 4 to run
> clocksource watchdog (indeed if I use tsc=nowatchdog this above doesn't
> happen, but the potential issue is still there I guess).
> 
> ---
>   sysjitter-2377  [004]   100.438455: local_timer_entry:    vector=236
>   sysjitter-2377  [004]   100.438456: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.438458: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92630461337 function=tick_sched_timer/0x0
>   sysjitter-2377  [004]   100.438460: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => update_process_times (ffffffffa3768f9d)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
>   sysjitter-2377  [004]   100.438461: softirq_raise:        vec=1 [action=TIMER]
>   sysjitter-2377  [004]   100.438464: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => trigger_load_balance (ffffffffa371cb9c)
> => update_process_times (ffffffffa3768fc7)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
>   sysjitter-2377  [004]   100.438465: softirq_raise:        vec=7 [action=SCHED]
> ---
> 
> Tick fires, the two softirq_raise (which you wondered about) seems to
> come from
> 
>  1. update_process_times::run_local_timers (TIMER_SOFTIRQ)
>  2. update_process_times::scheduler_tick::trigger_load_balance (SCHED_SOFTIRQ)
> 
> ---
>   sysjitter-2377  [004]   100.438468: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.438470: local_timer_exit:     vector=236
>   sysjitter-2377  [004]   100.438473: sched_wakeup:         ksoftirqd/4:31 [120] success=1 CPU:004
>   sysjitter-2377  [004]   100.438474: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.438476: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92630512937 softexpires=92630512937
>   sysjitter-2377  [004]   100.438484: irq_work_entry:       vector=246
>   sysjitter-2377  [004]   100.438491: irq_work_exit:        vector=246
>   sysjitter-2377  [004]   100.438492: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.438495: sched_switch:         sysjitter:2377 [120] R ==> ksoftirqd/4:31 [120]
> ksoftirqd/4-31    [004]   100.438497: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/4-31    [004]   100.438499: timer_cancel:         timer=0xffffffffa55a9d20
> ksoftirqd/4-31    [004]   100.438501: timer_expire_entry:   timer=0xffffffffa55a9d20 function=clocksource_watchdog now=4294759824 baseclk=4294759824
> ksoftirqd/4-31    [004]   100.438504: timer_start:          timer=0xffffffffa55a9d20 function=clocksource_watchdog expires=4294760322 [timeout=498] cpu=5 idx=113 flags=D|P|I
> ---
> 
> Queueing clocksource watchdog on CPU5.
> 
> ---
> ksoftirqd/4-31    [004]   100.438506: timer_expire_exit:    timer=0xffffffffa55a9d20
> ksoftirqd/4-31    [004]   100.438507: local_timer_entry:    vector=236
> ---
> 
> Back to back timer?
> 
> ---
> ksoftirqd/4-31    [004]   100.438509: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
> ksoftirqd/4-31    [004]   100.438511: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92630515022 function=tick_sched_timer/0x0
> ksoftirqd/4-31    [004]   100.438515: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => rcu_sched_clock_irq (ffffffffa375af4a)
> => update_process_times (ffffffffa3768fa4)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
> => filter_pred_32 (ffffffffa37f3357)
> => filter_match_preds (ffffffffa37f3510)
> => trace_event_buffer_commit (ffffffffa37dc7eb)
> => trace_event_raw_event_softirq (ffffffffa36dab77)
> => __do_softirq (ffffffffa420025a)
> => run_ksoftirqd (ffffffffa36dadc6)
> => smpboot_thread_fn (ffffffffa36ffdb8)
> => kthread (ffffffffa36f9fb7)
> => ret_from_fork (ffffffffa4000215)
> ksoftirqd/4-31    [004]   100.438516: softirq_raise:        vec=9 [action=RCU]
> ksoftirqd/4-31    [004]   100.438520: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => trigger_load_balance (ffffffffa371cb9c)
> => update_process_times (ffffffffa3768fc7)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
> => filter_pred_32 (ffffffffa37f3357)
> => filter_match_preds (ffffffffa37f3510)
> => trace_event_buffer_commit (ffffffffa37dc7eb)
> => trace_event_raw_event_softirq (ffffffffa36dab77)
> => __do_softirq (ffffffffa420025a)
> => run_ksoftirqd (ffffffffa36dadc6)
> => smpboot_thread_fn (ffffffffa36ffdb8)
> => kthread (ffffffffa36f9fb7)
> => ret_from_fork (ffffffffa4000215)
> ksoftirqd/4-31    [004]   100.438520: softirq_raise:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438521: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
> ksoftirqd/4-31    [004]   100.438523: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92631512937 softexpires=92631512937
> ksoftirqd/4-31    [004]   100.438525: local_timer_exit:     vector=236
> ksoftirqd/4-31    [004]   100.438527: tick_stop:            success=0 dependency=SCHED
> ---
> 
> At this point (I think) ksoftirqd is already going to sleep, so only
> sysjitter will be eventually executing on CPU4, but tick_stop check
> still sees nr_running == 2.
> 
> ---
> ksoftirqd/4-31    [004]   100.438530: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/4-31    [004]   100.438531: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438533: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438534: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438535: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.438536: softirq_entry:        vec=9 [action=RCU]
> ksoftirqd/4-31    [004]   100.438537: softirq_exit:         vec=9 [action=RCU]
> ksoftirqd/4-31    [004]   100.438540: sched_switch:         ksoftirqd/4:31 [120] S ==> sysjitter:2377 [120]
> ---
> 
> And tick again fires below.
> 
> ---
>   sysjitter-2377  [004]   100.439509: local_timer_entry:    vector=236
>   sysjitter-2377  [004]   100.439511: hrtimer_cancel:       hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.439512: hrtimer_expire_entry: hrtimer=0xffff92e9df91fd20 now=92631515408 function=tick_sched_timer/0x0
>   sysjitter-2377  [004]   100.439514: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => update_process_times (ffffffffa3768f9d)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
> sysjitter-2377  [004]   100.439515: softirq_raise:        vec=1 [action=TIMER]
> sysjitter-2377  [004]   100.439517: kernel_stack:         <stack trace>
> => __ftrace_trace_stack (ffffffffa37da921)
> => __raise_softirq_irqoff (ffffffffa36daf50)
> => raise_softirq (ffffffffa36db0fe)
> => trigger_load_balance (ffffffffa371cb9c)
> => update_process_times (ffffffffa3768fc7)
> => tick_sched_handle (ffffffffa377aaa2)
> => tick_sched_timer (ffffffffa377ad53)
> => __hrtimer_run_queues (ffffffffa3769cf0)
> => hrtimer_interrupt (ffffffffa376a58a)
> => smp_apic_timer_interrupt (ffffffffa40028f8)
> => apic_timer_interrupt (ffffffffa4001b7f)
>   sysjitter-2377  [004]   100.439518: softirq_raise:        vec=7 [action=SCHED]
>   sysjitter-2377  [004]   100.439520: hrtimer_expire_exit:  hrtimer=0xffff92e9df91fd20
>   sysjitter-2377  [004]   100.439521: hrtimer_start:        hrtimer=0xffff92e9df91fd20 function=tick_sched_timer/0x0 expires=92632512937 softexpires=92632512937
>   sysjitter-2377  [004]   100.439522: local_timer_exit:     vector=236
>   sysjitter-2377  [004]   100.439525: sched_wakeup:         ksoftirqd/4:31 [120] success=1 CPU:004
>   sysjitter-2377  [004]   100.439527: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.439529: irq_work_entry:       vector=246
>   sysjitter-2377  [004]   100.439531: irq_work_exit:        vector=246
>   sysjitter-2377  [004]   100.439532: tick_stop:            success=0 dependency=SCHED
>   sysjitter-2377  [004]   100.439534: sched_switch:         sysjitter:2377 [120] R ==> ksoftirqd/4:31 [120]
> ksoftirqd/4-31    [004]   100.439536: softirq_entry:        vec=1 [action=TIMER]
> ksoftirqd/4-31    [004]   100.439537: softirq_exit:         vec=1 [action=TIMER]
> ksoftirqd/4-31    [004]   100.439538: softirq_entry:        vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.439540: softirq_exit:         vec=7 [action=SCHED]
> ksoftirqd/4-31    [004]   100.439541: sched_switch:         ksoftirqd/4:31 [120] S ==> sysjitter:2377 [120]
> ---
> 
> History seems to repeat itself until ~2s later (this is one of the
> pathological runs) when an ipi fires on CPU4 and SCHED dependecy is seen
> as cleared (as only sysjitter thread was is running at that point).
> 
> Does this make sense and help in any way? Suggestions for debugging this
> further? :-)

Gentle ping about this issue.

Thanks,

Juri


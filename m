Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7AEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0F520709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEknDZG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgETQtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:49:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgETQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589993373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MsqhP6SZXOzZvIuEOGmEOCrH/A0ZeYEUVdNdIBesAIU=;
        b=FEknDZG2UdENLszAwpnBx7mHncueDISzI1K/UPK87BzEHidkQACBYFKdYdJHgYK4vOPa55
        BQdY891S7ql8AucWtceqyl8zSPrdPEkX5DMHDAc0M3+rPRbLDrIoRjRNVQYMtZjzhXmgDa
        y7aBrzz/y6hNk+8mKm+iDC1WSkD+FHs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-sPkZl-YhOvulKMAHd8tD5g-1; Wed, 20 May 2020 12:49:31 -0400
X-MC-Unique: sPkZl-YhOvulKMAHd8tD5g-1
Received: by mail-wr1-f70.google.com with SMTP id r14so1639494wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MsqhP6SZXOzZvIuEOGmEOCrH/A0ZeYEUVdNdIBesAIU=;
        b=ApoSTuFhgwRa8NpeA3JaB3qYFUUKip1yZoHrCw+w0Xx5C7Urt4D8ILA32fZwTmEuCw
         O2YBUvwLyj03+6NgK7WSTaUeT2pqHndZMFCHGUg+l4Wo8OAPnlE9C02kMY4VMXVKsvzb
         2Xz48k+r4TWJ4+ZadsXUPxyZCL6+Podg127BAh/Tkw5dtk8uNwSPzJQI76L0iujIIFJJ
         StiSi7NBI5z0gxs3EDEZbr6Ltg+aENYHSJHsZvUN46BTaptOql2nVSSe24yDl6fpkssC
         YF/a/0uTjL22CSdipIVkm+0tKipXQsdui/l6/ye2aApY9Sf5xOy5wKmyHlLH6qqnseXL
         6hgw==
X-Gm-Message-State: AOAM5319OZmxeGR5w9xySOexG3V1gKUTuhlHXAe26L1qLOsPaOgSer04
        uCXfIkyzar6Y6dEWwtuVlJV0OKt1Ti2Q0le9ICr0KF8x6MRJOY8VHUAu0Rl3fv7NT7Q371k/ZdW
        dJeLKGPeQS41NbT7CiEHtwWIp
X-Received: by 2002:a5d:694c:: with SMTP id r12mr4836225wrw.200.1589993370379;
        Wed, 20 May 2020 09:49:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNFGqgaCFwo4vNOn62Kyg9O8dOKjv25ptL1GdS46OUdKQdI+DBYCAniYCGH01NqDWNSHt4gQ==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr4836204wrw.200.1589993370026;
        Wed, 20 May 2020 09:49:30 -0700 (PDT)
Received: from localhost.localdomain ([151.68.137.74])
        by smtp.gmail.com with ESMTPSA id i21sm3619397wml.5.2020.05.20.09.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:49:29 -0700 (PDT)
Date:   Wed, 20 May 2020 18:49:25 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200520164925.GM10078@localhost.localdomain>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520162400.GA8800@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 18:24, Frederic Weisbecker wrote:
> Hi Juri,
> 
> On Wed, May 20, 2020 at 04:04:02PM +0200, Juri Lelli wrote:
> > After tasks enter or leave a runqueue (wakeup/block) SCHED full_nohz
> > dependency is checked (via sched_update_tick_dependency()). In case tick
> > can be stopped on a CPU (see sched_can_stop_tick() for details), SCHED
> > dependency for such CPU is cleared. However, this new information is not
> > used right away to actually stop the tick.
> > 
> > In CONFIG_PREEMPT systems booted with threadirqs option, sched clock
> > tick is serviced by an actual task (ksoftirqd corresponding to the CPU
> > where tick timer fired).
> 
> I must confess I haven't tested threaded IRQs but I was
> pretty sure that the timer tick is always serviced on hardirq.
> 
> Now the timer list callbacks are executed on softirqs. So if the
> tick itself, executed on hardirq, sees pending timers, it raise
> the softirq which wakes up ksoftirqd on forced irq thread mode
> while calling irq_exit(). Then tick_nohz_irq_exit() sees ksoftirqd
> and the current task on the runqueue, which together can indeed prevent
> from turning off the tick. But then the root cause is pending timer
> list callbacks.
> 
> > So, in case a CPU was running a single task,
> > servicing the timer involves exiting full nozh mode. Problem at this
> > point is that we might lose chances to enter back into full nozh mode,
> > since info about ksoftirqd thread going back to sleep is not used (as
> > mentioned above).
> 
> It should enter into nohz_full mode in the next tick, which is usually
> a reasonable delay. If you need guarantee that the tick is stopped before
> resuming userspace, you need a stronger machinery such as the task isolation
> patchset.
> 
> Let's have a look at the trace below:
> 
> > ksoftirqd/19-125   [019]   170.700754: softirq_entry:        vec=1 [action=TIMER]
> > ksoftirqd/19-125   [019]   170.700755: softirq_exit:         vec=1 [action=TIMER]
> > ksoftirqd/19-125   [019]   170.700756: softirq_entry:        vec=7 [action=SCHED]
> > ksoftirqd/19-125   [019]   170.700757: softirq_exit:         vec=7 [action=SCHED]
> > ksoftirqd/19-125   [019]   170.700759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
> >    sysjitter-2459  [019]   170.701740: local_timer_entry:    vector=236
> >    sysjitter-2459  [019]   170.701742: softirq_raise:        vec=1 [action=TIMER]
> 
> See here the tick sees pending timer callbacks so it raises the timer softirq.
> 
> >    sysjitter-2459  [019]   170.701743: softirq_raise:        vec=7 [action=SCHED]
> 
> Oh and the scheduler tick activates the scheduler softirq as well.
> 
> >    sysjitter-2459  [019]   170.701744: local_timer_exit:     vector=236
> >    sysjitter-2459  [019]   170.701747: sched_wakeup:         ksoftirqd/19:125 [120] success=1 CPU:019
> >    sysjitter-2459  [019]   170.701748: tick_stop:            success=0 dependency=SCHED
> >    sysjitter-2459  [019]   170.701749: irq_work_entry:       vector=246
> >    sysjitter-2459  [019]   170.701750: irq_work_exit:        vector=246
> >    sysjitter-2459  [019]   170.701751: tick_stop:            success=0 dependency=SCHED
> >    sysjitter-2459  [019]   170.701753: sched_switch:         sysjitter:2459 [120] R ==> ksoftirqd/19:125 [120]
> > ksoftirqd/19-125   [019]   170.701754: softirq_entry:        vec=1 [action=TIMER]
> > ksoftirqd/19-125   [019]   170.701756: softirq_exit:         vec=1 [action=TIMER]
> > ksoftirqd/19-125   [019]   170.701756: softirq_entry:        vec=7 [action=SCHED]
> > ksoftirqd/19-125   [019]   170.701758: softirq_exit:         vec=7 [action=SCHED]
> > ksoftirqd/19-125   [019]   170.701759: sched_switch:         ksoftirqd/19:125 [120] S ==> sysjitter:2459 [120]
> >    sysjitter-2459  [019]   170.702740: local_timer_entry:    vector=236
> >    sysjitter-2459  [019]   170.702742: softirq_raise:        vec=1 [action=TIMER]
> 
> A new tick but we still have pending timer callback so we'll need to wakeup ksoftirqd
> again.
> 
> I think you should trace timers and check which one is concerned here.

Hummm, so I enabled 'timer:*', anything else you think I should be
looking at?

...
ksoftirqd/13-117   [013]   148.265945: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/13-117   [013]   148.265947: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/13-117   [013]   148.265948: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/13-117   [013]   148.265950: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/13-117   [013]   148.265952: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
   sysjitter-2536  [013]   148.266912: local_timer_entry:    vector=236
   sysjitter-2536  [013]   148.266914: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
   sysjitter-2536  [013]   148.266916: hrtimer_expire_entry: hrtimer=0xffff9807df91bee0 now=148249107837 function=tick_sched_timer/0x0
   sysjitter-2536  [013]   148.266918: softirq_raise:        vec=1 [action=TIMER]
   sysjitter-2536  [013]   148.266920: softirq_raise:        vec=7 [action=SCHED]
   sysjitter-2536  [013]   148.266922: hrtimer_expire_exit:  hrtimer=0xffff9807df91bee0
   sysjitter-2536  [013]   148.266924: hrtimer_start:        hrtimer=0xffff9807df91bee0 function=tick_sched_timer/0x0 expires=148250105422 softexpires=148250105422
   sysjitter-2536  [013]   148.266926: local_timer_exit:     vector=236
   sysjitter-2536  [013]   148.266930: sched_wakeup:         ksoftirqd/13:117 [120] success=1 CPU:013
   sysjitter-2536  [013]   148.266932: tick_stop:            success=0 dependency=SCHED
   sysjitter-2536  [013]   148.266934: irq_work_entry:       vector=246
   sysjitter-2536  [013]   148.266936: irq_work_exit:        vector=246
   sysjitter-2536  [013]   148.266937: tick_stop:            success=0 dependency=SCHED
   sysjitter-2536  [013]   148.266940: sched_switch:         sysjitter:2536 [120] R ==> ksoftirqd/13:117 [120]
ksoftirqd/13-117   [013]   148.266943: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/13-117   [013]   148.266946: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/13-117   [013]   148.266946: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/13-117   [013]   148.266948: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/13-117   [013]   148.266950: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
   sysjitter-2536  [013]   148.267912: local_timer_entry:    vector=236
   sysjitter-2536  [013]   148.267914: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
   sysjitter-2536  [013]   148.267916: hrtimer_expire_entry: hrtimer=0xffff9807df91bee0 now=148250107750 function=tick_sched_timer/0x0
   sysjitter-2536  [013]   148.267918: softirq_raise:        vec=1 [action=TIMER]
   sysjitter-2536  [013]   148.267920: softirq_raise:        vec=7 [action=SCHED]
   sysjitter-2536  [013]   148.267922: hrtimer_expire_exit:  hrtimer=0xffff9807df91bee0
   sysjitter-2536  [013]   148.267924: hrtimer_start:        hrtimer=0xffff9807df91bee0 function=tick_sched_timer/0x0 expires=148251105422 softexpires=148251105422
   sysjitter-2536  [013]   148.267926: local_timer_exit:     vector=236
   sysjitter-2536  [013]   148.267929: sched_wakeup:         ksoftirqd/13:117 [120] success=1 CPU:013
   sysjitter-2536  [013]   148.267931: tick_stop:            success=0 dependency=SCHED
   sysjitter-2536  [013]   148.267934: irq_work_entry:       vector=246
   sysjitter-2536  [013]   148.267936: irq_work_exit:        vector=246
   sysjitter-2536  [013]   148.267937: tick_stop:            success=0 dependency=SCHED
   sysjitter-2536  [013]   148.267940: sched_switch:         sysjitter:2536 [120] R ==> ksoftirqd/13:117 [120]
ksoftirqd/13-117   [013]   148.267943: softirq_entry:        vec=1 [action=TIMER]
ksoftirqd/13-117   [013]   148.267945: softirq_exit:         vec=1 [action=TIMER]
ksoftirqd/13-117   [013]   148.267946: softirq_entry:        vec=7 [action=SCHED]
ksoftirqd/13-117   [013]   148.267947: softirq_exit:         vec=7 [action=SCHED]
ksoftirqd/13-117   [013]   148.267949: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
   sysjitter-2536  [013]   148.268865: call_function_single_entry: vector=251
   sysjitter-2536  [013]   148.268867: call_function_single_exit: vector=251
   sysjitter-2536  [013]   148.268870: tick_stop:            success=1 dependency=NONE
   sysjitter-2536  [013]   148.268872: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
   sysjitter-2536  [013]   148.268876: call_function_single_entry: vector=251
   sysjitter-2536  [013]   148.268878: call_function_single_exit: vector=251
...

it looks like tick sched timer is kept armed until tick_stop
succedes (because of the check performed after _single_exit)?

Thanks for your quick reply!


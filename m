Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584B9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CEB2250E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lCn9Mecq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgGTDyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGTDyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:54:02 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E84C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:54:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a32so12004952qtb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1u53c2F+veno3CGunFwdcO+tqxJwq9yQaGLu7xcFrPw=;
        b=lCn9MecqKLH0aBUp1HeYdTzb2uHoRNWigJVVPjRVUHLgJ+8zbh1ts3tAs6W18HQuLa
         k7mIenZ1M46bCFLadYhwwSt9vUORW78dzM3Wjr0ltd9r6Xbq49RbQaDZpXEdZ1Bj0VIM
         vlBgzHsXKUVolLSZ/3xwgJQC3ifqRAPV8/30E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1u53c2F+veno3CGunFwdcO+tqxJwq9yQaGLu7xcFrPw=;
        b=i5QYot5atz6CodAgw0J4Vwsk/aQCJ7mdV7vPjFMcE7Xca6O168Uy7Yy4cWR5BJdcyv
         ZfE2hYewe7mzTdncYEw5QY7v0D8D2G0SJiViscu1jE9zfQjiOm17YSMCe0qixbAx3uzY
         IEHrTsMI6VWc1n+uACEjQxIjMre2GIoVPYyaYX/J96v+sL+cP91smADj+IB1/8SH6rkd
         WAMG0eNVfGzQN9EMJfUOCblkeihKsyl0qm8NDOXW365IK43R2S8E27R/7w2+b5MZJFwV
         s+UYamF+nVaWyzl3cuqzIYxa8YGmYmbnzzE+oBP+62i7VMvyKBPj1WFIcqxe28Xc48yA
         ORKA==
X-Gm-Message-State: AOAM533xfFr+cE9zOwBvpyyYTWO4soU/HKOJWJhD0yEAxuTgAkvgFeND
        pOGBoZ08StHO7ufgnKRcuIdirg==
X-Google-Smtp-Source: ABdhPJwDHLSH2y/AbtzDgt0oZGGlu+ay0EjVNCPBEg8+27FSL0CTH4IT/h9DQ3Wv+nyDzxuKgsjX6g==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr22366570qtv.36.1595217240670;
        Sun, 19 Jul 2020 20:54:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t5sm17237283qkh.46.2020.07.19.20.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 20:53:59 -0700 (PDT)
Date:   Sun, 19 Jul 2020 23:53:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
Message-ID: <20200720035359.GA4187092@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <871rl9r9xr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rl9r9xr.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 01:36:16AM +0200, Thomas Gleixner wrote:
> Vineeth, Joel!

Hi Thomas,

> Vineeth Remanan Pillai <vpillai@digitalocean.com> writes:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> >
> > Lastly, we also check in the schedule loop if we are about to schedule
> > an untrusted process while the core is in such a state. This is possible
> > if a trusted thread enters the scheduler by way of yielding CPU. This
> > would involve no transitions through the irq_exit() point to do any
> > waiting, so we have to explicitly do the waiting there.
> 
> Lot's of 'we' and 'this patch' in this changelog. Care to read
> Documentation/process/submitting-patches.rst ?

Sure, will fix it.

[..] 
> is the usual kernel coding style.
> > +		static_branch_disable(&sched_core_irq_pause);
> > +
> > +	return 1;
> > +}
> > +__setup("sched_core_irq_pause=", set_sched_core_irq_pause);
> > +#endif
> > +
> >  asmlinkage __visible void __softirq_entry __do_softirq(void)
> >  {
> >  	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> > @@ -273,6 +291,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >  	/* Reset the pending bitmask before enabling irqs */
> >  	set_softirq_pending(0);
> >  
> > +#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
> > +	/*
> > +	 * Core scheduling mitigations require entry into softirq to send stall
> > +	 * IPIs to sibling hyperthreads if needed (ex, sibling is running
> > +	 * untrusted task). If we are here from irq_exit(), no IPIs are sent.
> > +	 */
> > +	if (static_branch_likely(&sched_core_irq_pause))
> > +		sched_core_irq_enter();
> 
> So you already have a #ifdef CONFIG_SCHED_CORE_IRQ_PAUSE section
> above. Why on earth can't you just provide helper functions and stubs
> for the CONFIG_SCHED_CORE_IRQ_PAUSE=n case there instead of sprinkling
> #ifdeffery all over the place?

These ifdeffery and checkpatch / command line parameter issues were added by
Vineeth before he sent out my patch. I'll let him comment on these, agreed
they all need fixing!

> > +#endif
> > +
> >  	local_irq_enable();
> 
> How is __do_softirq() relevant at all?
> 
> __do_softirq() is called from:
> 
>    1) the tail of interrupt handling
>    2) the tail of local_bh_enable()
>    3) the ksoftirq thread
> 
> None of this is relevant for what you are trying to do:
> 
>  #1: Iscovered by the interrupt handling code simply because this nests
>      into the interrupt handling.
> 
>  #2: local_bh_enable() only ends up there when invoked from thread
>      context.
> 
>      This would only make sense if one sibling is in the kernel and the
>      other in user space or guest mode. Isn't that forbidden by core
>      scheduling in the first place?

One sibling being in the kernel, while the other sibling is in userspace is
not yet forbidden by core-scheduling. We need to add support for that.

I think after reading your email and thinking about this last few days, we
can make it work by sending IPIs on both syscall and IRQ entries.

>  #3: See #2
> 
> But what's worse is that this is called from an interrupt disabled
> region. So you brilliantly created a trivial source of livelocks.
> stomp_machine() being the most obvious candidate. But it's easy enough
> to come up with more subtle ones.
> 
> The point is that you want to bring out the sibling thread from user
> space or guest mode when the other HT thread:
> 
>   A) invokes a syscall or traps into the hypervisor which is
>      semantically equivalent (not code wise).
> 
>   B) handles an interrupt/exception
> 
> So #A covers #2 and #3 above and #B covers #1 above.

Right. #A) was never implemented. But now I'm going to do it!

> But you have the same livelock problem with doing this core wait thingy
> within any interrupt disabled region.

Right, which we fixed by moving the waiting code to
prepare_exit_to_usermode() in the other test patch I sent to fix Aubrey's
deadlock, but as you suggested I will make it work with the new generic entry
code.

> What you really want to do is on syscall and interrupt/exception entry:
> 
>    if (other_sibling_in_user_or_guest())
>    	send_IPI();

Ok.

> Of course it's conveniant to piggy pack that onto the reschedule IPI,
> but that sucks. What you want is a dedicated IPI which does:
> 
> magic_ipi()
> 	set_thread_flag(TIF_CORE_SCHED_EXIT);

I tried IPIs before and ran into a few issues mostly related to CSD locking
if I remember, I will try again.

> And on the exit side you want to look at the entry code generalisation I
> just posted:
> 
>   https://lore.kernel.org/r/20200716182208.180916541@linutronix.de

Thank you, I went over this code and it makes sense we work based on that.

> Add TIF_CORE_SCHED_EXIT to EXIT_TO_USER_MODE_WORK and to
> EXIT_TO_GUEST_MODE_WORK and handle it in exit_to_guest_mode_work() and
> exit_to_user_mode_loop() with interrupts enabled.
> 

There's already state to determine if waiting is needed or not, we have
counters that determine if any sibling HT in the core is handling an IRQ or
not, and if so I wait before exiting to user mode. The outer-most IRQ entry
is being tracked so we don't send IPIs on every entry.

But I got an idea from your email. Whenever a 'tagged' task becomes current,
I can set a TIF flag marking that it is a tagged task and needs special
handling when exiting to user mode (or guest). Then on exiting to usermode
(or guest), I can check if any waiting is needed and wait there in the
interrupt enabled regions you are suggesting. This should simplify the code
since currently we have that complex if expression to determine if the task
is "special".

> Trying to do this in fully interrupt disabled context is just a recipe
> for disaster.
> 
> The entry case condition wants to have a TIF bit as well, i.e.
> 
>     if (thread_test_bit(TIF_CORE_SCHED_REQUIRED) {
>           sched_ipi_dance() {
>              if (other_sibling_in_user_or_guest())
>                 send_IPI();
>           }
>     }

I did not understand this bit. Could you explain more about it? Are you
talking about the IPIs sent from the schedule() loop in this series?

> I know you hate this, but we are not going to add tons of unholy hackery
> to make this "work" by some definition of work.
> 
> The only way to make this work without making a complete mess and
> killing performance is to do this on a best effort basis. It really does
> not matter whether the result of the orchestration is perfect or
> not. What matters is that you destroy any predictability. If the
> orchestration terminates early occasionally then the resulting damage is
> a purely academic exercise.
> 
> Making it work reliably without hard to debug livelocks and other
> horrors is not so academic.
> 
> So please stop overengineering this and just take the pragmatic approach
> of making it mostly correct. That will prevent 99.999% of realistic
> attacks.

Agreed. Actually that's what I was aiming for. Even the IPIs are sent only
if needed. I did a lot of benchmarking and did not see a performance hit.

> It might not prevent the carefully orchestrated academic paper attack
> which utilizes the 0.001% failure rate by artificially enforcing a
> scenario which cannot be enforced in a real world environment.
> 

Got it.

thanks,

 - Joel


Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B30CC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799972064B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VP/1kikV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U37cTf9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbgIAPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:55:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgIAPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:54:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598975694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJrnfXL9MJK0GqyAyjy1syYpwoWFrgSGPnpgO+wpOec=;
        b=VP/1kikV/8AKFtPilaT6pNf7MEgvtwKLV4WZ3o9koMZxJlNXMC4G38iM1HlgY05pNSYSO4
        BBk7CRWh4t1wVUF+ydqjmj/4hNdurSbRnLUqUBMlH/9bOBRlptiOSJD0pr2PNLnEgCFtWV
        WcE0l46+n9tetkUbzTzb5srEkvicZJXQgAIhfLm7XIp0CT7XSXF7nbrj74gZNntEHppC7H
        UiCXJPyjV2vCDH/n64QHDw448CLycFhtekSTv0nPn67EDS0zpA7afj8Ku5YnlgKfuotMYi
        VWJPaby68M1mi3I9FmoNcWUssn/cuRU0wyhJO4WJ01qiWNx7kU8TjyTYjONNfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598975694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iJrnfXL9MJK0GqyAyjy1syYpwoWFrgSGPnpgO+wpOec=;
        b=U37cTf9MQaxLi/ZTn73BHybc2CCmY78dGxrL72cv1NXuqLBID1vA6YEMNiY9S+ChnnFePf
        a/AxOZOAkK8xDZDg==
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
        mingo@kernel.org, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide protection of kernel-mode
In-Reply-To: <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com> <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
Date:   Tue, 01 Sep 2020 17:54:53 +0200
Message-ID: <87y2lth4qa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28 2020 at 15:51, Julien Desfossez wrote:
> @@ -112,59 +113,84 @@ static __always_inline void exit_to_user_mode(void)
>  /* Workaround to allow gradual conversion of architecture code */
>  void __weak arch_do_signal(struct pt_regs *regs) { }
>  
> -static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> -					    unsigned long ti_work)

Can the rework of that code please be split out into a seperate patch
and then adding that unsafe muck on top?

> +static inline bool exit_to_user_mode_work_pending(unsigned long ti_work)
>  {
> -	/*
> -	 * Before returning to user space ensure that all pending work
> -	 * items have been completed.
> -	 */
> -	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> +	return (ti_work & EXIT_TO_USER_MODE_WORK);
> +}
>  
> -		local_irq_enable_exit_to_user(ti_work);
> +static inline void exit_to_user_mode_work(struct pt_regs *regs,
> +					  unsigned long ti_work)
> +{
>  
> -		if (ti_work & _TIF_NEED_RESCHED)
> -			schedule();
> +	local_irq_enable_exit_to_user(ti_work);
>  
> -		if (ti_work & _TIF_UPROBE)
> -			uprobe_notify_resume(regs);
> +	if (ti_work & _TIF_NEED_RESCHED)
> +		schedule();
>  
> -		if (ti_work & _TIF_PATCH_PENDING)
> -			klp_update_patch_state(current);
> +	if (ti_work & _TIF_UPROBE)
> +		uprobe_notify_resume(regs);
>  
> -		if (ti_work & _TIF_SIGPENDING)
> -			arch_do_signal(regs);
> +	if (ti_work & _TIF_PATCH_PENDING)
> +		klp_update_patch_state(current);
>  
> -		if (ti_work & _TIF_NOTIFY_RESUME) {
> -			clear_thread_flag(TIF_NOTIFY_RESUME);
> -			tracehook_notify_resume(regs);
> -			rseq_handle_notify_resume(NULL, regs);
> -		}
> +	if (ti_work & _TIF_SIGPENDING)
> +		arch_do_signal(regs);
> +
> +	if (ti_work & _TIF_NOTIFY_RESUME) {
> +		clear_thread_flag(TIF_NOTIFY_RESUME);
> +		tracehook_notify_resume(regs);
> +		rseq_handle_notify_resume(NULL, regs);
> +	}
> +
> +	/* Architecture specific TIF work */
> +	arch_exit_to_user_mode_work(regs, ti_work);
> +
> +	local_irq_disable_exit_to_user();
> +}
>  
> -		/* Architecture specific TIF work */
> -		arch_exit_to_user_mode_work(regs, ti_work);
> +static unsigned long exit_to_user_mode_loop(struct pt_regs *regs)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	/*
> +	 * Before returning to user space ensure that all pending work
> +	 * items have been completed.
> +	 */
> +	while (1) {
> +		/* Both interrupts and preemption could be enabled here. */

   What? Preemption is enabled here, but interrupts are disabled.

> +		if (exit_to_user_mode_work_pending(ti_work))
> +		    exit_to_user_mode_work(regs, ti_work);
> +
> +		/* Interrupts may be reenabled with preemption disabled. */
> +		sched_core_unsafe_exit_wait(EXIT_TO_USER_MODE_WORK);
> +
>  		/*
> -		 * Disable interrupts and reevaluate the work flags as they
> -		 * might have changed while interrupts and preemption was
> -		 * enabled above.
> +		 * Reevaluate the work flags as they might have changed
> +		 * while interrupts and preemption were enabled.

What enables preemption and interrupts? Can you pretty please write
comments which explain what's going on.

>  		 */
> -		local_irq_disable_exit_to_user();
>  		ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +		/*
> +		 * We may be switching out to another task in kernel mode. That
> +		 * process is responsible for exiting the "unsafe" kernel mode
> +		 * when it returns to user or guest.
> +		 */
> +		if (exit_to_user_mode_work_pending(ti_work))
> +			sched_core_unsafe_enter();
> +		else
> +			break;
>  	}
>  
> -	/* Return the latest work state for arch_exit_to_user_mode() */
> -	return ti_work;
> +    return ti_work;
>  }
>  
>  static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
> -	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	unsigned long ti_work;
>  
>  	lockdep_assert_irqs_disabled();
>  
> -	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> -		ti_work = exit_to_user_mode_loop(regs, ti_work);
> +	ti_work = exit_to_user_mode_loop(regs);

Why has the above loop to be invoked unconditionally even when that core
scheduling muck is disabled? Just to make all return to user paths more
expensive unconditionally, right?

Thanks,

        tglx



Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149E920767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FEXgjYT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgIAQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbgIAQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:50:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5EC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 09:50:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 92so1414662qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=chEGCZUOt97KkdHP3DW+yiEtTKWTEG6ML07RM1FCyDs=;
        b=FEXgjYT7tsP+06IQ7HmH9tCU/R6h5hEUFnE/kIzqrzRC2i49dGKAudBNiMD9N34tCk
         a7t3Xizurxz6ILgeedu/VT4AZvShD980ojBh7A9/Ix1qvs/21SFdROKoPqcJQ9FkQ/Pi
         t/kMKWrVXVDzeYLI7Bs5Zz4I8xMK05dkHSq+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=chEGCZUOt97KkdHP3DW+yiEtTKWTEG6ML07RM1FCyDs=;
        b=JHu6m837NEUHbS67NFyskm5BcD+0xg8rg37u3qKukFsUHEaCj+Idd9Wpdwj+pzCZsX
         SjZcac1XWfm0ArxnnsQaSxvHh4aXUSOzh1/0jc7bSxdOVKK33KLuxLvcqu8GeG3sBku4
         9WUU69RXns3QqtrzU8uFweNSn+lBBz1F5ZaPCnRX5nh2C67SIPiywjDFCqdEyv3y40Ja
         SmZZHy3VhmcxNWT5hsUlhu99+9gK3bHe35ho3+F55X6yah3/HkYgLq+acBOa2ZKVsmjS
         Llr4D42RokW3NmkK/7EUXIPINF4CtrQwdTXfvmPBSyjUIkkknaV06xFbSS3Z7ZzMPPzw
         1fQg==
X-Gm-Message-State: AOAM532iAwmKws4dsol+Uwu72z7uqvVezDRNB/xEKVBGRwoudrHWCjR8
        5M1JvkRtF7ENZs2EsJdTwpUBjw==
X-Google-Smtp-Source: ABdhPJyNxue3iyua15LpiovcMbDbMhJuwSyaGI8SYGE04xDNlr7ZjQ1ROd+lJobSBEX3pn8TKAadPA==
X-Received: by 2002:ac8:5b09:: with SMTP id m9mr2784001qtw.12.1598979053770;
        Tue, 01 Sep 2020 09:50:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id j6sm1986952qtn.97.2020.09.01.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 09:50:53 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:50:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
Message-ID: <20200901165052.GA1662854@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2lth4qa.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:54:53PM +0200, Thomas Gleixner wrote:
> On Fri, Aug 28 2020 at 15:51, Julien Desfossez wrote:
> > @@ -112,59 +113,84 @@ static __always_inline void exit_to_user_mode(void)
> >  /* Workaround to allow gradual conversion of architecture code */
> >  void __weak arch_do_signal(struct pt_regs *regs) { }
> >  
> > -static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> > -					    unsigned long ti_work)
> 
> Can the rework of that code please be split out into a seperate patch
> and then adding that unsafe muck on top?

Yeah, good idea. Will do.

> > +static inline bool exit_to_user_mode_work_pending(unsigned long ti_work)
> >  {
> > -	/*
> > -	 * Before returning to user space ensure that all pending work
> > -	 * items have been completed.
> > -	 */
> > -	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> > +	return (ti_work & EXIT_TO_USER_MODE_WORK);
> > +}
> >  
> > -		local_irq_enable_exit_to_user(ti_work);
> > +static inline void exit_to_user_mode_work(struct pt_regs *regs,
> > +					  unsigned long ti_work)
> > +{
> >  
> > -		if (ti_work & _TIF_NEED_RESCHED)
> > -			schedule();
> > +	local_irq_enable_exit_to_user(ti_work);
> >  
> > -		if (ti_work & _TIF_UPROBE)
> > -			uprobe_notify_resume(regs);
> > +	if (ti_work & _TIF_NEED_RESCHED)
> > +		schedule();
> >  
> > -		if (ti_work & _TIF_PATCH_PENDING)
> > -			klp_update_patch_state(current);
> > +	if (ti_work & _TIF_UPROBE)
> > +		uprobe_notify_resume(regs);
> >  
> > -		if (ti_work & _TIF_SIGPENDING)
> > -			arch_do_signal(regs);
> > +	if (ti_work & _TIF_PATCH_PENDING)
> > +		klp_update_patch_state(current);
> >  
> > -		if (ti_work & _TIF_NOTIFY_RESUME) {
> > -			clear_thread_flag(TIF_NOTIFY_RESUME);
> > -			tracehook_notify_resume(regs);
> > -			rseq_handle_notify_resume(NULL, regs);
> > -		}
> > +	if (ti_work & _TIF_SIGPENDING)
> > +		arch_do_signal(regs);
> > +
> > +	if (ti_work & _TIF_NOTIFY_RESUME) {
> > +		clear_thread_flag(TIF_NOTIFY_RESUME);
> > +		tracehook_notify_resume(regs);
> > +		rseq_handle_notify_resume(NULL, regs);
> > +	}
> > +
> > +	/* Architecture specific TIF work */
> > +	arch_exit_to_user_mode_work(regs, ti_work);
> > +
> > +	local_irq_disable_exit_to_user();
> > +}
> >  
> > -		/* Architecture specific TIF work */
> > -		arch_exit_to_user_mode_work(regs, ti_work);
> > +static unsigned long exit_to_user_mode_loop(struct pt_regs *regs)
> > +{
> > +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > +
> > +	/*
> > +	 * Before returning to user space ensure that all pending work
> > +	 * items have been completed.
> > +	 */
> > +	while (1) {
> > +		/* Both interrupts and preemption could be enabled here. */
> 
>    What? Preemption is enabled here, but interrupts are disabled.

Sorry, I meant about what happens within exit_to_user_mode_work(). That's
what the comment was for. I agree I will do better with the comment next
time.

> > +		if (exit_to_user_mode_work_pending(ti_work))
> > +		    exit_to_user_mode_work(regs, ti_work);
> > +
> > +		/* Interrupts may be reenabled with preemption disabled. */
> > +		sched_core_unsafe_exit_wait(EXIT_TO_USER_MODE_WORK);
> > +
> >  		/*
> > -		 * Disable interrupts and reevaluate the work flags as they
> > -		 * might have changed while interrupts and preemption was
> > -		 * enabled above.
> > +		 * Reevaluate the work flags as they might have changed
> > +		 * while interrupts and preemption were enabled.
> 
> What enables preemption and interrupts? Can you pretty please write
> comments which explain what's going on.

Yes, sorry. So, sched_core_unsafe_exit_wait() will spin with IRQs enabled and
preemption disabled. I did it this way to get past stop_machine() issues
where you were unhappy with us spinning in IRQ disabled region.

> >  		 */
> > -		local_irq_disable_exit_to_user();
> >  		ti_work = READ_ONCE(current_thread_info()->flags);
> > +
> > +		/*
> > +		 * We may be switching out to another task in kernel mode. That
> > +		 * process is responsible for exiting the "unsafe" kernel mode
> > +		 * when it returns to user or guest.
> > +		 */
> > +		if (exit_to_user_mode_work_pending(ti_work))
> > +			sched_core_unsafe_enter();
> > +		else
> > +			break;
> >  	}
> >  
> > -	/* Return the latest work state for arch_exit_to_user_mode() */
> > -	return ti_work;
> > +    return ti_work;
> >  }
> >  
> >  static void exit_to_user_mode_prepare(struct pt_regs *regs)
> >  {
> > -	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> > +	unsigned long ti_work;
> >  
> >  	lockdep_assert_irqs_disabled();
> >  
> > -	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> > -		ti_work = exit_to_user_mode_loop(regs, ti_work);
> > +	ti_work = exit_to_user_mode_loop(regs);
> 
> Why has the above loop to be invoked unconditionally even when that core
> scheduling muck is disabled? Just to make all return to user paths more
> expensive unconditionally, right?

If you see the above loop, we are calling exit_to_user_mode_work()
conditionally by calling exit_to_user_mode_work_pending() which does the same
thing.

So we are still conditionally doing the usual exit_to_user_mode work, its
just that now we have to unconditionally invoke the 'loop' anyway. The reason
for that is, the loop can switch into another thread, so we have to do
unsafe_exit() for the old thread, and unsafe_enter() for the new one while
handling the tif work properly. We could get migrated to another CPU in this
loop itself, AFAICS. So the unsafe_enter() / unsafe_exit() calls could also
happen on different CPUs.

I will rework it by splitting, and adding more elaborate comments, etc.
Thanks,

 - Joel



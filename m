Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E615FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C8C20707
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yNxjKgqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgIBB3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIBB3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:29:07 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59AC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 18:29:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cy2so1512948qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 18:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dofAS3+wme1JTotBOa0NGwRluSMYwUf5DMOf0CHM5SA=;
        b=yNxjKgqQlgSxq504xz0TRdWoZiHnn+JILuRcg+Y1NS3EfRAfloGe7JXRqAq9yOfVd/
         2Jp/vnv5rXyaJyvXroNcpGjZfTbQnk8MecT0tXN2bvsE6kmwasE6bvB6FEEI7hgctdSh
         +jVSeh3JHF/S5QzSjBlD1IZ4o0Otuf2cO5am0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dofAS3+wme1JTotBOa0NGwRluSMYwUf5DMOf0CHM5SA=;
        b=B34qvOL4osDZbqklO2Hqd4lNL1PSbPfcHwR/YKXwxUf29gR286HscuPX4Oyp3OhTQP
         AE7/zCpNojbz3PIDjzdKqlgGV0eeuJhHfRs/t06avbYXslYGfCzcEx08zkAd+Kht19yr
         1M0Ujsum3HhqM/GYaVIfhDzkcBBi+6zh1Ii1R9dV0dR7nDohkKzXq200vBJCfmjR6GAw
         KcKy+fnivUWZFjK/EMHrQLI9eu+c2cRUm778jJblPO4mYdCChVvIOM4NYEMWKgkUCWx5
         WexWtNCrzVVDBvMSPaFXSmCAoxEqMwjPdSnI6+qZ3Q87EqVeoyIHeBHKoyjhzjnN43vV
         6Npw==
X-Gm-Message-State: AOAM533wPb7477SFFzAaRLJjFfW44HA5ftPFX/77lXK1n1OSUz7dfUDm
        7QeNU3ZYzqxhFIVOVPIDgz0cgQ==
X-Google-Smtp-Source: ABdhPJwdvUVTrCsR+QTdy9zpmRcYK9/likb3QLdlA1sM42G34+NccYk8ZQOKA1RgmPOt/8ojrj3NHQ==
X-Received: by 2002:a05:6214:1452:: with SMTP id b18mr4900314qvy.5.1599010146189;
        Tue, 01 Sep 2020 18:29:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id m196sm3632080qke.87.2020.09.01.18.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 18:29:05 -0700 (PDT)
Date:   Tue, 1 Sep 2020 21:29:05 -0400
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
Message-ID: <20200902012905.GB1703315@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de>
 <20200901165052.GA1662854@google.com>
 <875z8xl0zh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z8xl0zh.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Sep 01, 2020 at 10:02:10PM +0200, Thomas Gleixner wrote:
[..] 
> > The reason for that is, the loop can switch into another thread, so we
> > have to do unsafe_exit() for the old thread, and unsafe_enter() for
> > the new one while handling the tif work properly. We could get
> > migrated to another CPU in this loop itself, AFAICS. So the
> > unsafe_enter() / unsafe_exit() calls could also happen on different
> > CPUs.
> 
> That's fine. It still does not justify to make everything slower even if
> that 'pretend that HT is secure' thing is disabled.
> 
> Something like the below should be sufficient to do what you want
> while restricting the wreckage to the 'pretend ht is secure' case.
> 
> The generated code for the CONFIG_PRETENT_HT_SECURE=n case is the same

When you say 'pretend', did you mean 'make' ? The point of this patch is to
protect the kernel from the other hyperthread thus making HT secure for the
kernel contexts and not merely pretending.

> as without the patch. With CONFIG_PRETENT_HT_SECURE=y the impact is
> exactly two NOP-ed out jumps if the muck is not enabled on the command
> line which should be the default behaviour.

I see where you're coming from, I'll try to rework it to be less intrusive
when core-scheduling is disabled. Some more comments below:

> Thanks,
> 
>         tglx
> 
> ---
> --- /dev/null
> +++ b/include/linux/pretend_ht_secure.h
> @@ -0,0 +1,21 @@
> +#ifndef _LINUX_PRETEND_HT_SECURE_H
> +#define _LINUX_PRETEND_HT_SECURE_H
> +
> +#ifdef CONFIG_PRETEND_HT_SECURE
> +static inline void enter_from_user_ht_sucks(void)
> +{
> +	if (static_branch_unlikely(&pretend_ht_secure_key))
> +		enter_from_user_pretend_ht_is_secure();
> +}
> +
> +static inline void exit_to_user_ht_sucks(void)
> +{
> +	if (static_branch_unlikely(&pretend_ht_secure_key))
> +		exit_to_user_pretend_ht_is_secure();

We already have similar config and static keys for the core-scheduling
feature itself. Can we just make it depend on that?

Or, are you saying users may want 'core scheduling' enabled but may want to
leave out the kernel protection?

> +}
> +#else
> +static inline void enter_from_user_ht_sucks(void) { }
> +static inline void exit_to_user_ht_sucks(void) { }
> +#endif
> +
> +#endif
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -17,6 +17,7 @@
>   * 1) Tell lockdep that interrupts are disabled
>   * 2) Invoke context tracking if enabled to reactivate RCU
>   * 3) Trace interrupts off state
> + * 4) Pretend that HT is secure
>   */
>  static __always_inline void enter_from_user_mode(struct pt_regs *regs)
>  {
> @@ -28,6 +29,7 @@ static __always_inline void enter_from_u
>  
>  	instrumentation_begin();
>  	trace_hardirqs_off_finish();
> +	enter_from_user_ht_sucks();
>  	instrumentation_end();
>  }
>  
> @@ -111,6 +113,12 @@ static __always_inline void exit_to_user
>  /* Workaround to allow gradual conversion of architecture code */
>  void __weak arch_do_signal(struct pt_regs *regs) { }
>  
> +static inline unsigned long exit_to_user_get_work(void)
> +{
> +	exit_to_user_ht_sucks();

Ok, one issue with your patch is it does not take care of the waiting logic.
sched_core_unsafe_exit_wait() needs to be called *after* all of the
exit_to_user_mode_work is processed. This is because
sched_core_unsafe_exit_wait() also checks for any new exit-to-usermode-work
that popped up while it is spinning and breaks out of its spin-till-safe loop
early. This is key to solving the stop-machine issue. If the stopper needs to
run, then the need-resched flag will be set and we break out of the spin and
redo the whole exit_to_user_mode_loop() as it should.

I agree with the need to make the ASM suck less if the feature is turned off
though, and I can try to cook something along those lines. Thanks for the idea!

thanks,

 - Joel


> +	return READ_ONCE(current_thread_info()->flags);
> +}
> +
>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  					    unsigned long ti_work)
>  {
> @@ -149,7 +157,7 @@ static unsigned long exit_to_user_mode_l
>  		 * enabled above.
>  		 */
>  		local_irq_disable_exit_to_user();
> -		ti_work = READ_ONCE(current_thread_info()->flags);
> +		ti_work = exit_to_user_get_work();
>  	}
>  
>  	/* Return the latest work state for arch_exit_to_user_mode() */
> @@ -158,7 +166,7 @@ static unsigned long exit_to_user_mode_l
>  
>  static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
> -	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	unsigned long ti_work = exit_to_user_get_work();
>  
>  	lockdep_assert_irqs_disabled();
>  

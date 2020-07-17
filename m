Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C38CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35DE20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cf7JUjDq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzRanXRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGQXgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:36:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:36:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595028977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfHKGpqOBayCOoV1oNFylYiwey92PDwx5rh88ysK6Os=;
        b=cf7JUjDqhA5CmSH/5mtJk9xbEwH1uscV4/7qsKs7I7H04QHQLm5peB+eas1WyFYP/pawgA
        rj6EbRSH9Mn1tyLGCJS5wK6yycykOuZinAzGUcwHsxD5MsM1Fc3nsbsulMlrTilq6763af
        1jb+MNgAr4+uTrDlFExHD/FWhONUXVYgKtJBBWFGvN3IKyUEWxg7qTGvDyg9oFF9OrBBpi
        NJmLbcyTVrcsrzMBb+c7ZO7ZkBCgkr7eG9WQ3oWQAR0AfNKjEwdXf03VFuDY7Vvf1UpmYX
        5+hm3FFKTOMVQLZkgteLokiosll165I8Ny0W8i1iuzcovhcPwHvDg9aW2NvsSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595028977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfHKGpqOBayCOoV1oNFylYiwey92PDwx5rh88ysK6Os=;
        b=xzRanXRrzpWhcmift8cNMphewnQjGyy4oyExdaBK8EdpL/ZhwJKnd7Ribi4NTRXhg0nydu
        0ce3ooa3CJmnZ2Dw==
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        pjt@google.com, torvalds@linux-foundation.org
Cc:     "Joel Fernandes \(Google\)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vineeth Pillai <vpillai@digitalocean.com>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of IRQ and softirq
In-Reply-To: <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com> <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
Date:   Sat, 18 Jul 2020 01:36:16 +0200
Message-ID: <871rl9r9xr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vineeth, Joel!

Vineeth Remanan Pillai <vpillai@digitalocean.com> writes:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>
> Lastly, we also check in the schedule loop if we are about to schedule
> an untrusted process while the core is in such a state. This is possible
> if a trusted thread enters the scheduler by way of yielding CPU. This
> would involve no transitions through the irq_exit() point to do any
> waiting, so we have to explicitly do the waiting there.

Lot's of 'we' and 'this patch' in this changelog. Care to read
Documentation/process/submitting-patches.rst ?

> Every attempt is made to prevent a busy-wait unnecessarily, and in
> testing on real-world ChromeOS usecases, it has not shown a performance
> drop. In ChromeOS, with this and the rest of the core scheduling
> patchset, we see around a 300% improvement in key press latencies into
> Google docs when Camera streaming is running simulatenously (90th
> percentile latency of ~150ms drops to ~50ms).
>
> This fetaure is controlled by the build time config option
> CONFIG_SCHED_CORE_IRQ_PAUSE and is enabled by default. There is also a
> kernel boot parameter 'sched_core_irq_pause' to enable/disable the
> feature at boot time. Default is enabled at boot time.

Enabled by default? At least that wants to depend on the enablement of
core scheduling at boot time.

>  
> +#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
> +DEFINE_STATIC_KEY_TRUE(sched_core_irq_pause);
> +static int __init set_sched_core_irq_pause(char *str)

Gah. newlines are overrated, right? Glueing variable declarations and
function declarations next to each other is unreadable.

> +{
> +	unsigned long val = 0;
> +	if (!str)

Missing newline between declaration and code. checkpatch.pl has told you
so.

> +		return 0;
> +
> +	val = simple_strtoul(str, &str, 0);

Huch? Why are you using simple_strtoul() for parsing a boolean and
what's the point of setting the **end argument to &str?

> +
> +	if (val == 0)

  	if (!val)

is the usual kernel coding style.

> +		static_branch_disable(&sched_core_irq_pause);
> +
> +	return 1;
> +}
> +__setup("sched_core_irq_pause=", set_sched_core_irq_pause);
> +#endif
> +
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
>  	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> @@ -273,6 +291,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	/* Reset the pending bitmask before enabling irqs */
>  	set_softirq_pending(0);
>  
> +#ifdef CONFIG_SCHED_CORE_IRQ_PAUSE
> +	/*
> +	 * Core scheduling mitigations require entry into softirq to send stall
> +	 * IPIs to sibling hyperthreads if needed (ex, sibling is running
> +	 * untrusted task). If we are here from irq_exit(), no IPIs are sent.
> +	 */
> +	if (static_branch_likely(&sched_core_irq_pause))
> +		sched_core_irq_enter();

So you already have a #ifdef CONFIG_SCHED_CORE_IRQ_PAUSE section
above. Why on earth can't you just provide helper functions and stubs
for the CONFIG_SCHED_CORE_IRQ_PAUSE=n case there instead of sprinkling
#ifdeffery all over the place?

> +#endif
> +
>  	local_irq_enable();

How is __do_softirq() relevant at all?

__do_softirq() is called from:

   1) the tail of interrupt handling
   2) the tail of local_bh_enable()
   3) the ksoftirq thread

None of this is relevant for what you are trying to do:

 #1: Iscovered by the interrupt handling code simply because this nests
     into the interrupt handling.

 #2: local_bh_enable() only ends up there when invoked from thread
     context.

     This would only make sense if one sibling is in the kernel and the
     other in user space or guest mode. Isn't that forbidden by core
     scheduling in the first place?

 #3: See #2

But what's worse is that this is called from an interrupt disabled
region. So you brilliantly created a trivial source of livelocks.
stomp_machine() being the most obvious candidate. But it's easy enough
to come up with more subtle ones.

The point is that you want to bring out the sibling thread from user
space or guest mode when the other HT thread:

  A) invokes a syscall or traps into the hypervisor which is
     semantically equivalent (not code wise).

  B) handles an interrupt/exception

So #A covers #2 and #3 above and #B covers #1 above.

But you have the same livelock problem with doing this core wait thingy
within any interrupt disabled region.

What you really want to do is on syscall and interrupt/exception entry:

   if (other_sibling_in_user_or_guest())
   	send_IPI();

Of course it's conveniant to piggy pack that onto the reschedule IPI,
but that sucks. What you want is a dedicated IPI which does:

magic_ipi()
	set_thread_flag(TIF_CORE_SCHED_EXIT);

And on the exit side you want to look at the entry code generalisation I
just posted:

  https://lore.kernel.org/r/20200716182208.180916541@linutronix.de

Add TIF_CORE_SCHED_EXIT to EXIT_TO_USER_MODE_WORK and to
EXIT_TO_GUEST_MODE_WORK and handle it in exit_to_guest_mode_work() and
exit_to_user_mode_loop() with interrupts enabled.

Trying to do this in fully interrupt disabled context is just a recipe
for disaster.

The entry case condition wants to have a TIF bit as well, i.e.

    if (thread_test_bit(TIF_CORE_SCHED_REQUIRED) {
          sched_ipi_dance() {
             if (other_sibling_in_user_or_guest())
                send_IPI();
          }
    }

I know you hate this, but we are not going to add tons of unholy hackery
to make this "work" by some definition of work.

The only way to make this work without making a complete mess and
killing performance is to do this on a best effort basis. It really does
not matter whether the result of the orchestration is perfect or
not. What matters is that you destroy any predictability. If the
orchestration terminates early occasionally then the resulting damage is
a purely academic exercise.

Making it work reliably without hard to debug livelocks and other
horrors is not so academic.

So please stop overengineering this and just take the pragmatic approach
of making it mostly correct. That will prevent 99.999% of realistic
attacks.

It might not prevent the carefully orchestrated academic paper attack
which utilizes the 0.001% failure rate by artificially enforcing a
scenario which cannot be enforced in a real world environment.

Thanks,

        tglx







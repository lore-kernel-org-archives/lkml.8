Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728BEC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F7D24758
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196651;
	bh=JF0ccaR7qzma6RZnVGAc0QY3jNY3PjqO4TYu3jZ7p04=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=QjhVUVKp6V6rTR0btkhGfjUN9fJnbTwYIV3T1VHYFZlZBwdDPiv+Wt7TarF8BvXhC
	 Ijz7NrWWcc9aQ48GW90c8Z09NGdN9JNVBG6fRnTrCHxUhg5vzCXMwxNDkS9cAXJS46
	 wviFI7Cx4zjbKRP3uzdCebmWEwvKeW2vTKyeAebg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394080AbgAPRoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388744AbgAPRnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9268B2474E;
        Thu, 16 Jan 2020 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196625;
        bh=JF0ccaR7qzma6RZnVGAc0QY3jNY3PjqO4TYu3jZ7p04=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zQnA9E92vc7DPGCkFsxiZ+rKqrIhHx4ZP5aa/0xDqCll//Ryr6P2X8FnsmYHsb1mT
         fCPh35oc0NLpfw0YceFHulh/5Hf6cPS5imsVQPgZrjNY3S9XcxIEGEnJoIciKTgUcD
         gAbvv/jdRIJ7a6NiuNcKh+GeBrf6RCgIMM/cdd1c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 15F6E35227B9; Thu, 16 Jan 2020 09:43:44 -0800 (PST)
Date:   Thu, 16 Jan 2020 09:43:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH -rcu v2] kcsan: Make KCSAN compatible with lockdep
Message-ID: <20200116174344.GV2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200115162512.70807-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115162512.70807-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 05:25:12PM +0100, Marco Elver wrote:
> We must avoid any recursion into lockdep if KCSAN is enabled on
> utilities used by lockdep. One manifestation of this is corrupting
> lockdep's IRQ trace state (if TRACE_IRQFLAGS). Fix this by:
> 
> 1. Using raw_local_irq{save,restore} in kcsan_setup_watchpoint().
> 2. Disabling lockdep in kcsan_report().
> 
> Tested with:
> 
>   CONFIG_LOCKDEP=y
>   CONFIG_DEBUG_LOCKDEP=y
>   CONFIG_TRACE_IRQFLAGS=y
> 
> Where previously, the following warning (and variants with different
> stack traces) was consistently generated, with the fix introduced in
> this patch, the warning cannot be reproduced.

I added Vlad's ack and Qian's Tested-by and queued this.  Thank you all!

							Thanx, Paul

>     WARNING: CPU: 0 PID: 2 at kernel/locking/lockdep.c:4406 check_flags.part.0+0x101/0x220
>     Modules linked in:
>     CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.5.0-rc1+ #11
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>     RIP: 0010:check_flags.part.0+0x101/0x220
>     <snip>
>     Call Trace:
>      lock_is_held_type+0x69/0x150
>      freezer_fork+0x20b/0x370
>      cgroup_post_fork+0x2c9/0x5c0
>      copy_process+0x2675/0x3b40
>      _do_fork+0xbe/0xa30
>      ? _raw_spin_unlock_irqrestore+0x40/0x50
>      ? match_held_lock+0x56/0x250
>      ? kthread_park+0xf0/0xf0
>      kernel_thread+0xa6/0xd0
>      ? kthread_park+0xf0/0xf0
>      kthreadd+0x321/0x3d0
>      ? kthread_create_on_cpu+0x130/0x130
>      ret_from_fork+0x3a/0x50
>     irq event stamp: 64
>     hardirqs last  enabled at (63): [<ffffffff9a7995d0>] _raw_spin_unlock_irqrestore+0x40/0x50
>     hardirqs last disabled at (64): [<ffffffff992a96d2>] kcsan_setup_watchpoint+0x92/0x460
>     softirqs last  enabled at (32): [<ffffffff990489b8>] fpu__copy+0xe8/0x470
>     softirqs last disabled at (30): [<ffffffff99048939>] fpu__copy+0x69/0x470
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Update comments.
> ---
>  kernel/kcsan/core.c     |  6 ++++--
>  kernel/kcsan/report.c   | 11 +++++++++++
>  kernel/locking/Makefile |  3 +++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 87bf857c8893..64b30f7716a1 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -336,8 +336,10 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  	 *      CPU-local data accesses), it makes more sense (from a data race
>  	 *      detection point of view) to simply disable preemptions to ensure
>  	 *      as many tasks as possible run on other CPUs.
> +	 *
> +	 * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
>  	 */
> -	local_irq_save(irq_flags);
> +	raw_local_irq_save(irq_flags);
>  
>  	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
>  	if (watchpoint == NULL) {
> @@ -429,7 +431,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  
>  	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
>  out_unlock:
> -	local_irq_restore(irq_flags);
> +	raw_local_irq_restore(irq_flags);
>  out:
>  	user_access_restore(ua_flags);
>  }
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index b5b4feea49de..33bdf8b229b5 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -2,6 +2,7 @@
>  
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
> +#include <linux/lockdep.h>
>  #include <linux/preempt.h>
>  #include <linux/printk.h>
>  #include <linux/sched.h>
> @@ -410,6 +411,14 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
>  {
>  	unsigned long flags = 0;
>  
> +	/*
> +	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
> +	 * we do not turn off lockdep here; this could happen due to recursion
> +	 * into lockdep via KCSAN if we detect a data race in utilities used by
> +	 * lockdep.
> +	 */
> +	lockdep_off();
> +
>  	kcsan_disable_current();
>  	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
>  		if (print_report(ptr, size, access_type, value_change, cpu_id, type) && panic_on_warn)
> @@ -418,4 +427,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
>  		release_report(&flags, type);
>  	}
>  	kcsan_enable_current();
> +
> +	lockdep_on();
>  }
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index 45452facff3b..6d11cfb9b41f 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -5,6 +5,9 @@ KCOV_INSTRUMENT		:= n
>  
>  obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
>  
> +# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
> +KCSAN_SANITIZE_lockdep.o := n
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 

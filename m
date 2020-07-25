Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D42C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70960206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595688986;
	bh=DYp4eNJHayDAjwHno2Beh+uwOX5ndVNNXxWuyTyRQGI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=IqR0TfWJFhq6G5tPgVY8rkVdJJzxYmGBj662o6AGf9k7g89U29+Yf7Szq1TTqZ1mb
	 c+0jhP6fEIB8c+vIodPM6dpolp96SjlPxhH3ZA+UTJQdz4fZpwjzMoxLOD0LyQXZ0P
	 Ew0sEn/Flu2VeqDZHAsDXs+NCWQ4G0oyqv4VR8rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgGYO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 10:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgGYO4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 10:56:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E047D20674;
        Sat, 25 Jul 2020 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595688983;
        bh=DYp4eNJHayDAjwHno2Beh+uwOX5ndVNNXxWuyTyRQGI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TDzsALthOgxOlShoTpDwGqzrlGfZPdHoJURXWPhLOOy27OBEGVOQlw5mpEPWxz4aG
         df0I43d3SBY2PSMzzvO1dftrFouHjB91KZa4xnIHTk+bhcsh6SFAlG0p2yFLsBL418
         czVlTun+2BDltjQtoQpqHjNadF6CAPJIejyOIP90=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C8AE93522767; Sat, 25 Jul 2020 07:56:23 -0700 (PDT)
Date:   Sat, 25 Jul 2020 07:56:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200725145623.GZ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220213317.GA35033@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:33:17PM +0100, Marco Elver wrote:
> On Thu, 20 Feb 2020, Paul E. McKenney wrote:

I am clearly not keeping up...  :-/

> > On Thu, Feb 20, 2020 at 03:15:51PM +0100, Marco Elver wrote:
> > > Add option to allow interrupts while a watchpoint is set up. This can be
> > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > parameter 'kcsan.interrupt_watcher=1'.
> > > 
> > > Note that, currently not all safe per-CPU access primitives and patterns
> > > are accounted for, which could result in false positives. For example,
> > > asm-generic/percpu.h uses plain operations, which by default are
> > > instrumented. On interrupts and subsequent accesses to the same
> > > variable, KCSAN would currently report a data race with this option.
> > > 
> > > Therefore, this option should currently remain disabled by default, but
> > > may be enabled for specific test scenarios.
> > > 
> > > Signed-off-by: Marco Elver <elver@google.com>
> > 
> > Queued for review and testing, thank you!
> > 
> > > ---
> > > 
> > > As an example, the first data race that this found:
> > > 
> > > write to 0xffff88806b3324b8 of 4 bytes by interrupt on cpu 0:
> > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]
> > >  __rcu_read_lock+0x3c/0x50 kernel/rcu/tree_plugin.h:373
> > >  rcu_read_lock include/linux/rcupdate.h:599 [inline]
> > >  cpuacct_charge+0x36/0x80 kernel/sched/cpuacct.c:347
> > >  cgroup_account_cputime include/linux/cgroup.h:773 [inline]
> > >  update_curr+0xe2/0x1d0 kernel/sched/fair.c:860
> > >  enqueue_entity+0x130/0x5d0 kernel/sched/fair.c:4005
> > >  enqueue_task_fair+0xb0/0x420 kernel/sched/fair.c:5260
> > >  enqueue_task kernel/sched/core.c:1302 [inline]
> > >  activate_task+0x6d/0x110 kernel/sched/core.c:1324
> > >  ttwu_do_activate.isra.0+0x40/0x60 kernel/sched/core.c:2266
> > >  ttwu_queue kernel/sched/core.c:2411 [inline]
> > >  try_to_wake_up+0x3be/0x6c0 kernel/sched/core.c:2645
> > >  wake_up_process+0x10/0x20 kernel/sched/core.c:2669
> > >  hrtimer_wakeup+0x4c/0x60 kernel/time/hrtimer.c:1769
> > >  __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
> > >  __hrtimer_run_queues+0x274/0x5f0 kernel/time/hrtimer.c:1579
> > >  hrtimer_interrupt+0x22d/0x490 kernel/time/hrtimer.c:1641
> > >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1119 [inline]
> > >  smp_apic_timer_interrupt+0xdc/0x280 arch/x86/kernel/apic/apic.c:1144
> > >  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> > >  delay_tsc+0x38/0xc0 arch/x86/lib/delay.c:68                   <--- interrupt while delayed
> > >  __delay arch/x86/lib/delay.c:161 [inline]
> > >  __const_udelay+0x33/0x40 arch/x86/lib/delay.c:175
> > >  __udelay+0x10/0x20 arch/x86/lib/delay.c:181
> > >  kcsan_setup_watchpoint+0x17f/0x400 kernel/kcsan/core.c:428
> > >  check_access kernel/kcsan/core.c:550 [inline]
> > >  __tsan_read4+0xc6/0x100 kernel/kcsan/core.c:685               <--- Enter KCSAN runtime
> > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  <---+
> > >  __rcu_read_lock+0x2a/0x50 kernel/rcu/tree_plugin.h:373            |
> > >  rcu_read_lock include/linux/rcupdate.h:599 [inline]               |
> > >  lock_page_memcg+0x31/0x110 mm/memcontrol.c:1972                   |
> > >                                                                    |
> > > read to 0xffff88806b3324b8 of 4 bytes by task 6131 on cpu 0:       |
> > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  ----+
> > >  __rcu_read_lock+0x2a/0x50 kernel/rcu/tree_plugin.h:373
> > >  rcu_read_lock include/linux/rcupdate.h:599 [inline]
> > >  lock_page_memcg+0x31/0x110 mm/memcontrol.c:1972
> > > 
> > > The writer is doing 'current->rcu_read_lock_nesting++'. The read is as
> > > vulnerable to compiler optimizations and would therefore conclude this
> > > is a valid data race.
> > 
> > Heh!  That one is a fun one!  It is on a very hot fastpath.  READ_ONCE()
> > and WRITE_ONCE() are likely to be measurable at the system level.
> > 
> > Thoughts on other options?
> 
> Would this be a use-case for local_t? Don't think this_cpu ops work
> here.
> 
> See below idea. This would avoid the data race (KCSAN stopped
> complaining) and seems to generate reasonable code.
> 
> Version before:
> 
>  <__rcu_read_lock>:
>      130	mov    %gs:0x0,%rax
>      137
>      139	addl   $0x1,0x370(%rax)
>      140	retq   
>      141	data16 nopw %cs:0x0(%rax,%rax,1)
>      148
>      14c	nopl   0x0(%rax)
> 
> Version after:
> 
>  <__rcu_read_lock>:
>      130	mov    %gs:0x0,%rax
>      137
>      139	incq   0x370(%rax)
>      140	retq   
>      141	data16 nopw %cs:0x0(%rax,%rax,1)
>      148
>      14c	nopl   0x0(%rax)
> 
> I haven't checked the other places where it is used, though.
> (Can send it as a patch if you think this might work.)
> 
> Thanks,
> -- Marco
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 2678a37c31696..3d8586ee7ae64 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -50,7 +50,7 @@ void __rcu_read_unlock(void);
>   * nesting depth, but makes sense only if CONFIG_PREEMPT_RCU -- in other
>   * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
>   */
> -#define rcu_preempt_depth() (current->rcu_read_lock_nesting)
> +#define rcu_preempt_depth() local_read(&current->rcu_read_lock_nesting)
>  
>  #else /* #ifdef CONFIG_PREEMPT_RCU */
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 0918904c939d2..70d7e3257feed 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -10,6 +10,7 @@
>  #include <uapi/linux/sched.h>
>  
>  #include <asm/current.h>
> +#include <asm/local.h>
>  
>  #include <linux/pid.h>
>  #include <linux/sem.h>
> @@ -708,7 +709,7 @@ struct task_struct {
>  	cpumask_t			cpus_mask;
>  
>  #ifdef CONFIG_PREEMPT_RCU
> -	int				rcu_read_lock_nesting;
> +	local_t				rcu_read_lock_nesting;
>  	union rcu_special		rcu_read_unlock_special;
>  	struct list_head		rcu_node_entry;
>  	struct rcu_node			*rcu_blocked_node;
> diff --git a/init/init_task.c b/init/init_task.c
> index 096191d177d5c..941777fce11e5 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -130,7 +130,7 @@ struct task_struct init_task
>  	.perf_event_list = LIST_HEAD_INIT(init_task.perf_event_list),
>  #endif
>  #ifdef CONFIG_PREEMPT_RCU
> -	.rcu_read_lock_nesting = 0,
> +	.rcu_read_lock_nesting = LOCAL_INIT(0),
>  	.rcu_read_unlock_special.s = 0,
>  	.rcu_node_entry = LIST_HEAD_INIT(init_task.rcu_node_entry),
>  	.rcu_blocked_node = NULL,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 60a1295f43843..43af326081b06 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1669,7 +1669,7 @@ init_task_pid(struct task_struct *task, enum pid_type type, struct pid *pid)
>  static inline void rcu_copy_process(struct task_struct *p)
>  {
>  #ifdef CONFIG_PREEMPT_RCU
> -	p->rcu_read_lock_nesting = 0;
> +	local_set(&p->rcu_read_lock_nesting, 0);
>  	p->rcu_read_unlock_special.s = 0;
>  	p->rcu_blocked_node = NULL;
>  	INIT_LIST_HEAD(&p->rcu_node_entry);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c6ea81cd41890..e0595abd50c0f 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -350,17 +350,17 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
>  
>  static void rcu_preempt_read_enter(void)
>  {
> -	current->rcu_read_lock_nesting++;
> +	local_inc(&current->rcu_read_lock_nesting);
>  }
>  
>  static void rcu_preempt_read_exit(void)
>  {
> -	current->rcu_read_lock_nesting--;
> +	local_dec(&current->rcu_read_lock_nesting);
>  }
>  
>  static void rcu_preempt_depth_set(int val)
>  {
> -	current->rcu_read_lock_nesting = val;
> +	local_set(&current->rcu_read_lock_nesting, val);

I agree that this removes the data races, and that the code for x86 is
quite nice, but aren't rcu_read_lock() and rcu_read_unlock() going to
have heavyweight atomic operations on many CPUs?

Maybe I am stuck with arch-specific code in rcu_read_lock() and
rcu_preempt_read_exit().  I suppose worse things could happen.

							Thanx, Paul

Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63A52206F5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592016890;
	bh=jUlQZpYpsscl9TZb9hCBCUse56kQ/sYmb71vlw99LJc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HdaVdt6K+bKqQjGnxQA8CoT4gXGzZBqN9VFmiZxRo0KgCjSYZ6XzF0sRBfo0gacJM
	 +fuOBwaBhgUhuejZbYmZHxduUIjDXOc7mFV0KzKtdK3J+QeaTyzVJssCdlKdRbdWa1
	 gX4gXGGH3KdlgGgqYa/7plnzxgewtSPYxMStJmF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFMCsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 22:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgFMCsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 22:48:31 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87EA206A4;
        Sat, 13 Jun 2020 02:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592016509;
        bh=jUlQZpYpsscl9TZb9hCBCUse56kQ/sYmb71vlw99LJc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BthQGZVhOQ62uMgdePehaEUcYEzxWTDyHUKp86a1QesP6sfrm84QaoQaqDuPBS0Ct
         iT6Uprv3yd9eKY/JhWKgmeGYIvtR9uB+slcMTDwscukScxIM/As72D0CAHwq6X5mEm
         TVLYxjIHeOwytXvIgpuG/1AHTeNf8YSyiUZqnArQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CA93D3522778; Fri, 12 Jun 2020 19:48:29 -0700 (PDT)
Date:   Fri, 12 Jun 2020 19:48:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200613024829.GA12958@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605131451.GE2750@hirez.programming.kicks-ass.net>
 <20200605141607.GB4455@paulmck-ThinkPad-P72>
 <20200605184159.GA4062@paulmck-ThinkPad-P72>
 <20200606005126.GA21507@paulmck-ThinkPad-P72>
 <20200606172942.GA30594@paulmck-ThinkPad-P72>
 <20200607185732.GA18906@paulmck-ThinkPad-P72>
 <20200609154016.GA17196@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609154016.GA17196@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 08:40:16AM -0700, Paul E. McKenney wrote:
> On Sun, Jun 07, 2020 at 11:57:32AM -0700, Paul E. McKenney wrote:
> > On Sat, Jun 06, 2020 at 10:29:42AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jun 05, 2020 at 05:51:26PM -0700, Paul E. McKenney wrote:
> > > > On Fri, Jun 05, 2020 at 11:41:59AM -0700, Paul E. McKenney wrote:
> > > > > On Fri, Jun 05, 2020 at 07:16:07AM -0700, Paul E. McKenney wrote:
> > > > > 
> > > > > And in case it is helpful, here is the output of "git bisect view",
> > > > > which lists rather more commits than "git bisect run" claims, but there
> > > > > are only a few scheduler commits below.  I don't see anything that
> > > > > I can prove can cause this problem, but there are some that are at
> > > > > least related to this code path.
> > > > > 
> > > > > Is there anything that is actually relevant?
> > > > 
> > > > And the run with the WARN and tracing did hit two failures, and the
> > > > corresponding console logs are in the attached tarball.  Both of them
> > > > triggered a warning as well as the failure.
> > > 
> > > And the current state of the bisection, for whatever it is worth.
> > 
> > The bisection finished, finally!
> > 
> > 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> > 
> > I don't see anything immediately obvious, but then again, I do not
> > claim to understand this code.  If you have additional diagnostics,
> > please let me know.
> 
> But lockdep just might have spotted something useful.
> This was running the rcutorture SRCU-P scenario on
> mainline commit abfbb29297c2 ("Merge tag 'rproc-v5.8' of
> git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc").
> Unlike TREE03, SRCU-P enables lockdep.
> 
> This splat features a couple of lockdep_assert_held() splats just before
> the mysterious NULL pointer dereference.

And an update based on your patch (https://paste.debian.net/1151802/)
against 44ebe016df3a ("Merge branch 'proc-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace").

Without your patch, 28 hours of rcutorture scenario TREE03 gets three NULL
pointer dereferences.  With it, there are no NULL pointer dereferences,
but I did see one of these:  https://paste.debian.net/1151842.
(Also shown below.)

Related or not, who knows?  More as I learn more.

There is only a 5% chance of the result with your patch being a
false negative, so looking positive.

						Thanx, Paul

------------------------------------------------------------------------

[ 1669.614123] rcu: INFO: rcu_preempt self-detected stall on CPU
[ 1669.615634] rcu:     13-...!: (20999 ticks this GP) idle=fda/1/0x4000000000000002 softirq=234177/234177 fqs=0
[ 1669.618350]  (t=21004 jiffies g=874585 q=4817)
[ 1669.619395] rcu: rcu_preempt kthread starved for 21005 jiffies! g874585 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[ 1669.621920] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[ 1669.624060] rcu: RCU grace-period kthread stack dump:
[ 1669.625393] rcu_preempt     I15056    11      2 0x00004000
[ 1669.626899] Call Trace:
[ 1669.627697]  __schedule+0x25d/0x5d0
[ 1669.628475]  ? _raw_spin_lock_irqsave+0x12/0x40
[ 1669.629620]  schedule+0x37/0xe0
[ 1669.630404]  schedule_timeout+0x109/0x210
[ 1669.631145]  ? trace_raw_output_hrtimer_start+0x70/0x70
[ 1669.632069]  rcu_gp_kthread+0x8e1/0x1260
[ 1669.632995]  ? call_rcu+0x2d0/0x2d0
[ 1669.633881]  kthread+0x138/0x160
[ 1669.634558]  ? kthread_create_on_node+0x60/0x60
[ 1669.635536]  ret_from_fork+0x22/0x30
[ 1669.636307] NMI backtrace for cpu 13
[ 1669.637257] CPU: 13 PID: 93 Comm: migration/13 Not tainted 5.7.0+ #18
[ 1669.638624] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 1669.640360] Call Trace:
[ 1669.640913]  <IRQ>
[ 1669.641371]  dump_stack+0x57/0x70
[ 1669.642090]  nmi_cpu_backtrace.cold.6+0x13/0x51
[ 1669.643066]  ? lapic_can_unplug_cpu.cold.30+0x3e/0x3e
[ 1669.644298]  nmi_trigger_cpumask_backtrace+0xc4/0xcd
[ 1669.645197]  rcu_dump_cpu_stacks+0x96/0xc2
[ 1669.645884]  rcu_sched_clock_irq.cold.86+0x118/0x506
[ 1669.646955]  ? perf_event_task_tick+0x5f/0x280
[ 1669.648053]  ? sched_clock+0x5/0x10
[ 1669.648788]  ? cpuacct_account_field+0x14/0x70
[ 1669.649961]  ? tick_switch_to_oneshot.cold.2+0x74/0x74
[ 1669.651599]  update_process_times+0x1f/0x50
[ 1669.652862]  tick_sched_timer+0x55/0x170
[ 1669.653685]  __hrtimer_run_queues+0xfb/0x2c0
[ 1669.654669]  hrtimer_interrupt+0x105/0x220
[ 1669.655696]  smp_apic_timer_interrupt+0x7f/0x190
[ 1669.656700]  apic_timer_interrupt+0xf/0x20
[ 1669.657384]  </IRQ>
[ 1669.657831] RIP: 0010:stop_machine_yield+0x2/0x10
[ 1669.658554] Code: 0c 25 28 00 00 00 75 10 48 8d 65 f0 5b 41 5c 5d c3 b8 fe ff ff ff eb e0 e8 ab c0 f4 ff 90 66 2e 0f 1f 84 00 00 00 00 00 f3 90 <c3> 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 41 57 41 56 41 55 41 54
[ 1669.662249] RSP: 0000:ffffa7860039fe60 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[ 1669.664172] RAX: 0000000080000000 RBX: ffffa786006e3d10 RCX: 0000000000000001
[ 1669.665782] RDX: 0000000000000000 RSI: 0000000000000282 RDI: ffffffffa520b0c8
[ 1669.668058] RBP: ffffa786006e3d34 R08: 0000000000000298 R09: 0000000000008ebc
[ 1669.669637] R10: 0000000000000001 R11: 0000000000261000 R12: 0000000000000001
[ 1669.671023] R13: ffffffffa520b0c8 R14: 0000000000000000 R15: 0000000000000001
[ 1669.672136]  multi_cpu_stop+0x8d/0xe0
[ 1669.672705]  ? stop_machine_yield+0x10/0x10
[ 1669.673595]  cpu_stopper_thread+0x6d/0x100
[ 1669.674427]  ? sort_range+0x20/0x20
[ 1669.675164]  smpboot_thread_fn+0x193/0x230
[ 1669.676033]  kthread+0x138/0x160
[ 1669.676732]  ? kthread_create_on_node+0x60/0x60
[ 1669.678102]  ret_from_fork+0x22/0x30
[ 1669.679213] Sending NMI from CPU 13 to CPUs 14:
[ 1669.680542] NMI backtrace for cpu 14
[ 1669.680543] CPU: 14 PID: 100 Comm: migration/14 Not tainted 5.7.0+ #18
[ 1669.680543] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[ 1669.680544] RIP: 0010:rcu_momentary_dyntick_idle+0x2c/0x40
[ 1669.680545] Code: c7 c3 80 9f 02 00 65 c6 05 7c df d4 5b 00 e8 bb 31 31 00 89 c0 48 03 1c c5 e0 b6 4d a5 b8 04 00 00 00 f0 0f c1 83 d8 00 00 00 <a8> 02 74 0c 5b 65 48 8b 3c 25 00 7d 01 00 eb a4 0f 0b eb f0 41 55
[ 1669.680546] RSP: 0000:ffffa786003dbe58 EFLAGS: 00000282
[ 1669.680546] RAX: 00000000b2bed872 RBX: ffff97111f5a9f80 RCX: 0000000000000001
[ 1669.680547] RDX: 0000000000000000 RSI: 0000000000000282 RDI: ffffffffa520b0c8
[ 1669.680547] RBP: ffffa786006e3d34 R08: 000000000000029f R09: 0000000000003057
[ 1669.680547] R10: 0000000000000001 R11: 00000000000ce400 R12: 0000000000000001
[ 1669.680548] R13: ffffffffa520b0c8 R14: 0000000000000000 R15: 0000000000000001
[ 1669.680548] FS:  0000000000000000(0000) GS:ffff97111f580000(0000) knlGS:0000000000000000
[ 1669.680548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1669.680548] CR2: 00000000ffffffff CR3: 000000000540a000 CR4: 00000000000006e0
[ 1669.680549] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1669.680549] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1669.680549] Call Trace:
[ 1669.680549]  multi_cpu_stop+0x9b/0xe0
[ 1669.680550]  ? stop_machine_yield+0x10/0x10
[ 1669.680550]  cpu_stopper_thread+0x6d/0x100
[ 1669.680550]  ? sort_range+0x20/0x20
[ 1669.680550]  smpboot_thread_fn+0x193/0x230
[ 1669.680551]  kthread+0x138/0x160
[ 1669.680551]  ? kthread_create_on_node+0x60/0x60
[ 1669.680551]  ret_from_fork+0x22/0x30

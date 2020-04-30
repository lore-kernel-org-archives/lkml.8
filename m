Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9262BC83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3E22083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588216961;
	bh=virPmzvXX4qMlJY4jx2ixODYSr6U1AJ0Nuks10zQFIQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vcx+O3JGvBjlOzE6uHXa1J2uAfRvUdQuqehwSUsvf6xs34N2ZfpFe46MDwp4qCCcg
	 0nQ9loi0iUFT6xnzRJf5MDQnUtuEISWKlShFFsSvG2z/J9j8aFr83jzegxqq1tQx63
	 +WcBgA4jl7blQ2RedFs2ID9DT2rCzZO+di4z43j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD3DWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3DWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:22:40 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93422082E;
        Thu, 30 Apr 2020 03:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588216958;
        bh=virPmzvXX4qMlJY4jx2ixODYSr6U1AJ0Nuks10zQFIQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=yMPj98On2QdeBq9rmWN7lVXahV8pFIttLCMVO2pB2vdNLWYRw/4uwU+oOjwMnPAAJ
         SxVZpAC9wpUKp0CB/vvwmbPLMwKBNmiGic/U2o97XqAht0DD1mNENesQTFfyFbyWwV
         WfKmxPWy2qjvp7to98qvkKnHfyqkbE5UC/UqL3f4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8ED7C352269B; Wed, 29 Apr 2020 20:22:38 -0700 (PDT)
Date:   Wed, 29 Apr 2020 20:22:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: rcu_barrier() + membarrier() + scheduler deadlock?
Message-ID: <20200430032238.GP7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <F64C791A-0EA7-458E-82C0-B98A1032066C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F64C791A-0EA7-458E-82C0-B98A1032066C@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:00:58PM -0400, Qian Cai wrote:
> Doing some fuzzers on many CPUs triggers a deadlock really quickly.  I can see that there were several tasks had been stuck for a while,
> 
> CPUA:
> slab_caches_to_rcu_destroy_workfn()
> rcu_barrier()
> wait_for_completion()
> 
> CPUB:
> sched_setaffinity()
> __set_cpus_allowed_ptr()
> stop_one_cpu()
> 
> CPUC:
> __x64_sys_membarrier
> synchronize_rcu()
> __wait_rcu_gp()
> wait_for_completion()
> 
> Lockdep did not flag anything useful at all. Any clue?

CPUA and CPUC are most likely both waiting for a grace period to complete.

CPUA will be blocking CPU hotplug (get_online_cpus()) in case that
matters.  I am not seeing any obvious wait for an RCU grace period
in CPUB.

But which task's affinity is being set?  That of the grace-period kthread?
If not, are there rcuo kthreads present?  Either way, preventing any of
RCU's kthreads from running could block potentially both CPUA and CPUC.
Though in the case of the grace-period kthread, I would expect to see
an RCU CPU stall warning.

Could you please share your .config?

							Thanx, Paul

> [52885.040113][T150406] futex_wake_op: trinity-c9 tries to shift op by -1189; fix this program
> [52890.366916][T150196] futex_wake_op: trinity-c3 tries to shift op by -1; fix this program
> [52896.369779][T151054] futex_wake_op: trinity-c23 tries to shift op by 710; fix this program
> [52901.770688][  T310] INFO: task kworker/36:2:142207 blocked for more than 122 seconds.
> [52901.811471][  T310]       Tainted: G             L    5.7.0-rc3-next-20200429 #2
> [52901.849148][  T310] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [52901.889803][  T310] kworker/36:2    D29104 142207      2 0x90004000
> [52901.919461][  T310] Workqueue: events slab_caches_to_rcu_destroy_workfn
> [52901.950935][  T310] Call Trace:
> [52901.965369][  T310]  __schedule+0x77e/0x1070
> [52901.986211][  T310]  ? __sched_text_start+0x8/0x8
> [52902.008267][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52902.031764][  T310]  schedule+0x95/0x160
> [52902.050729][  T310]  schedule_timeout+0x47c/0x6a0
> [52902.072897][  T310]  ? print_irqtrace_events+0x110/0x110
> [52902.098316][  T310]  ? usleep_range+0x100/0x100
> [52902.119664][  T310]  ? mark_held_locks+0x86/0xb0
> [52902.141397][  T310]  ? _raw_spin_unlock_irq+0x27/0x40
> [52902.165326][  T310]  ? _raw_spin_unlock_irq+0x27/0x40
> [52902.189622][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52902.213641][  T310]  ? wait_for_completion+0x116/0x1a0
> [52902.238757][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52902.261648][  T310]  wait_for_completion+0x11e/0x1a0
> [52902.285516][  T310]  ? wait_for_completion_interruptible+0x220/0x220
> [52902.316342][  T310]  ? rcu_read_lock_held+0xc0/0xc0
> [52902.340298][  T310]  rcu_barrier+0x2c5/0x440
> [52902.361736][  T310]  slab_caches_to_rcu_destroy_workfn+0x95/0xe0
> [52902.391109][  T310]  process_one_work+0x57e/0xb90
> [52902.413244][  T310]  ? pwq_dec_nr_in_flight+0x170/0x170
> [52902.437957][  T310]  ? worker_thread+0x14b/0x5b0
> [52902.460357][  T310]  worker_thread+0x63/0x5b0
> [52902.481267][  T310]  ? process_one_work+0xb90/0xb90
> [52902.504818][  T310]  kthread+0x1f7/0x220
> [52902.523542][  T310]  ? kthread_create_worker_on_cpu+0xc0/0xc0
> [52902.550801][  T310]  ret_from_fork+0x3a/0x50
> [52902.560427][T151328] futex_wake_op: trinity-c10 tries to shift op by -1; fix this program
> [52902.571250][  T310] INFO: task trinity-c18:145344 can't die for more than 123 seconds.
> [52902.648554][  T310] trinity-c18     R  running task    26944 145344  74932 0x10004004
> [52902.700179][  T310] Call Trace:
> [52902.715039][  T310]  __schedule+0x77e/0x1070
> [52902.735531][  T310]  ? __sched_text_start+0x8/0x8
> [52902.757922][  T310]  ? do_syscall_64+0x28d/0xaf0
> [52902.779731][  T310]  ? do_syscall_64+0x28d/0xaf0
> [52902.802215][  T310]  schedule+0x95/0x160
> [52902.821375][  T310]  do_syscall_64+0x23e/0xaf0
> [52902.843517][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52902.871003][  T310]  ? ftrace_syscall_enter+0x4b0/0x4b0
> [52902.896034][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52902.922153][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52902.950409][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52902.976721][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52903.002409][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52903.030018][  T310] RIP: 0033:0x7fa3d9cd670d
> [52903.050021][  T310] Code: Bad RIP value.
> [52903.068733][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000cb
> [52903.107680][  T310] RAX: 0000000000000000 RBX: 00000000000000cb RCX: 00007fa3d9cd670d
> [52903.144861][  T310] RDX: 00007fa3d7c38000 RSI: 0000000000000004 RDI: 0000000000000000
> [52903.182189][  T310] RBP: 00000000000000cb R08: 000000000000ca23 R09: 00000000000000b3
> [52903.219290][  T310] R10: 000000002ab3d706 R11: 0000000000000246 R12: 0000000000000002
> [52903.256653][  T310] R13: 00007fa3d8608058 R14: 00007fa3d9b956c0 R15: 00007fa3d8608000
> [52903.294988][  T310] INFO: task trinity-c24:146199 can't die for more than 124 seconds.
> [52903.333911][  T310] trinity-c24     R  running task    26944 146199  74932 0x10000004
> [52903.377051][  T310] Call Trace:
> [52903.393139][  T310]  __schedule+0x77e/0x1070
> [52903.413685][  T310]  ? __sched_text_start+0x8/0x8
> [52903.435602][  T310]  ? check_flags.part.28+0x86/0x220
> [52903.459452][  T310]  preempt_schedule_common+0x16/0x50
> [52903.483985][  T310]  _cond_resched+0x22/0x30
> [52903.504130][  T310]  stop_one_cpu+0xd7/0x140
> [52903.524695][  T310]  ? stop_cpus.constprop.3+0x130/0x130
> [52903.550266][  T310]  ? task_rq_unlock+0x6e/0x80
> [52903.572005][  T310]  ? sched_ttwu_pending+0x1b0/0x1b0
> [52903.595973][  T310]  ? lock_downgrade+0x3e0/0x3e0
> [52903.618468][  T310]  ? mark_held_locks+0x34/0xb0
> [52903.640239][  T310]  ? task_rq_unlock+0x6e/0x80
> [52903.662057][  T310]  __set_cpus_allowed_ptr+0x382/0x3a0
> [52903.686744][  T310]  ? move_queued_task+0x3c0/0x3c0
> [52903.709784][  T310]  ? cpuset_cpus_allowed+0x10b/0x200
> [52903.734212][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52903.757482][  T310]  ? __bitmap_and+0xd8/0x100
> [52903.779002][  T310]  sched_setaffinity+0x476/0x660
> [52903.802046][  T310]  ? __x64_sys_sched_getattr+0x3e0/0x3e0
> [52903.827730][  T310]  ? __kasan_check_write+0x14/0x20
> [52903.851859][  T310]  __x64_sys_sched_setaffinity+0x118/0x180
> [52903.881315][  T310]  ? sched_setaffinity+0x660/0x660
> [52903.906012][  T310]  ? do_syscall_64+0x79/0xaf0
> [52903.927530][  T310]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [52903.951683][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52903.976607][  T310]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52904.004024][  T310]  do_syscall_64+0xcc/0xaf0
> [52904.023909][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52904.047409][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52904.072656][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52904.099856][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52904.125615][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52904.167434][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52904.193732][  T310] RIP: 0033:0x7fa3d9cd670d
> [52904.213368][  T310] Code: Bad RIP value.
> [52904.231318][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000cb
> [52904.269002][  T310] RAX: ffffffffffffffda RBX: 00000000000000cb RCX: 00007fa3d9cd670d
> [52904.344529][  T310] RDX: 00007fa3d803c000 RSI: 0000000000000200 RDI: 0000000000000000
> [52904.382761][  T310] RBP: 00000000000000cb R08: 0001802261008040 R09: 00000000000000ba
> [52904.422223][  T310] R10: 00000000000000a8 R11: 0000000000000246 R12: 0000000000000002
> [52904.458152][  T310] R13: 00007fa3d85de058 R14: 00007fa3d9b956c0 R15: 00007fa3d85de000
> [52904.494711][  T310] INFO: task trinity-c6:146436 can't die for more than 125 seconds.
> [52904.530683][  T310] trinity-c6      R  running task    27328 146436  74932 0x10000004
> [52904.567167][  T310] Call Trace:
> [52904.582145][  T310]  __schedule+0x77e/0x1070
> [52904.601969][  T310]  ? __sched_text_start+0x8/0x8
> [52904.623515][  T310]  ? check_flags.part.28+0x86/0x220
> [52904.647020][  T310]  preempt_schedule_common+0x16/0x50
> [52904.671405][  T310]  _cond_resched+0x22/0x30
> [52904.690871][  T310]  stop_one_cpu+0xd7/0x140
> [52904.710359][  T310]  ? stop_cpus.constprop.3+0x130/0x130
> [52904.734818][  T310]  ? task_rq_unlock+0x6e/0x80
> [52904.755537][  T310]  ? sched_ttwu_pending+0x1b0/0x1b0
> [52904.778632][  T310]  ? lock_downgrade+0x3e0/0x3e0
> [52904.800232][  T310]  ? mark_held_locks+0x34/0xb0
> [52904.821408][  T310]  ? task_rq_unlock+0x6e/0x80
> [52904.842299][  T310]  __set_cpus_allowed_ptr+0x382/0x3a0
> [52904.866634][  T310]  ? move_queued_task+0x3c0/0x3c0
> [52904.890341][  T310]  ? cpuset_cpus_allowed+0x10b/0x200
> [52904.916217][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52904.939059][  T310]  ? __bitmap_and+0xd8/0x100
> [52904.959333][  T310]  sched_setaffinity+0x476/0x660
> [52904.981422][  T310]  ? __x64_sys_sched_getattr+0x3e0/0x3e0
> [52905.006183][  T310]  ? copy_user_generic_unrolled+0x9e/0xc0
> [52905.031792][  T310]  __x64_sys_sched_setaffinity+0x118/0x180
> [52905.057598][  T310]  ? sched_setaffinity+0x660/0x660
> [52905.080302][  T310]  ? do_syscall_64+0x79/0xaf0
> [52905.101464][  T310]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [52905.126828][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52905.150334][  T310]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52905.177570][  T310]  do_syscall_64+0xcc/0xaf0
> [52905.197688][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52905.221392][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52905.246586][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52905.273733][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52905.300142][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52905.324980][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52905.351394][  T310] RIP: 0033:0x7fa3d9cd670d
> [52905.371850][  T310] Code: Bad RIP value.
> [52905.390680][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000cb
> [52905.432007][  T310] RAX: ffffffffffffffda RBX: 00000000000000cb RCX: 00007fa3d9cd670d
> [52905.470212][  T310] RDX: 00007fa3d7e3c000 RSI: 0000000000000004 RDI: 0000000000000000
> [52905.507836][  T310] RBP: 00000000000000cb R08: 00000000fffffff9 R09: ffffffffffff896f
> [52905.545501][  T310] R10: 000000000000fff7 R11: 0000000000000246 R12: 0000000000000002
> [52905.581885][  T310] R13: 00007fa3d865c058 R14: 00007fa3d9b956c0 R15: 00007fa3d865c000
> [52905.620176][  T310] INFO: task trinity-c38:147003 can't die for more than 126 seconds.
> [52905.656622][  T310] trinity-c38     R  running task    27880 147003  74932 0x10000004
> [52905.692374][  T310] Call Trace:
> [52905.706772][  T310]  __schedule+0x77e/0x1070
> [52905.726246][  T310]  ? __sched_text_start+0x8/0x8
> [52905.747783][  T310]  ? check_flags.part.28+0x86/0x220
> [52905.770984][  T310]  preempt_schedule_common+0x16/0x50
> [52905.794507][  T310]  _cond_resched+0x22/0x30
> [52905.814101][  T310]  stop_one_cpu+0xd7/0x140
> [52905.833704][  T310]  ? stop_cpus.constprop.3+0x130/0x130
> [52905.858045][  T310]  ? task_rq_unlock+0x6e/0x80
> [52905.879452][  T310]  ? sched_ttwu_pending+0x1b0/0x1b0
> [52905.903104][  T310]  ? lock_downgrade+0x3e0/0x3e0
> [52905.927387][  T310]  ? mark_held_locks+0x34/0xb0
> [52905.949981][  T310]  ? task_rq_unlock+0x6e/0x80
> [52905.970691][  T310]  __set_cpus_allowed_ptr+0x382/0x3a0
> [52905.994868][  T310]  ? move_queued_task+0x3c0/0x3c0
> [52906.017315][  T310]  ? cpuset_cpus_allowed+0x10b/0x200
> [52906.040870][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52906.063266][  T310]  ? __bitmap_and+0xd8/0x100
> [52906.083575][  T310]  sched_setaffinity+0x476/0x660
> [52906.105559][  T310]  ? __x64_sys_sched_getattr+0x3e0/0x3e0
> [52906.130620][  T310]  ? __kasan_check_write+0x14/0x20
> [52906.153322][  T310]  __x64_sys_sched_setaffinity+0x118/0x180
> [52906.179289][  T310]  ? sched_setaffinity+0x660/0x660
> [52906.202438][  T310]  ? do_syscall_64+0x79/0xaf0
> [52906.223078][  T310]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [52906.246181][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52906.269667][  T310]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52906.296537][  T310]  do_syscall_64+0xcc/0xaf0
> [52906.316130][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52906.339641][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52906.364738][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52906.391937][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52906.419260][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52906.446669][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52906.473222][  T310] RIP: 0033:0x7fa3d9cd670d
> [52906.493314][  T310] Code: Bad RIP value.
> [52906.511339][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000cb
> [52906.549312][  T310] RAX: ffffffffffffffda RBX: 00000000000000cb RCX: 00007fa3d9cd670d
> [52906.585138][  T310] RDX: 00007fa3d7c3c000 RSI: 0000000000000008 RDI: 0000000000000000
> [52906.620955][  T310] RBP: 00000000000000cb R08: fffffffffffffff8 R09: fffffffffffffffc
> [52906.657616][  T310] R10: 0000000000000200 R11: 0000000000000246 R12: 0000000000000002
> [52906.694196][  T310] R13: 00007fa3d857c058 R14: 00007fa3d9b956c0 R15: 00007fa3d857c000
> [52906.730152][  T310] INFO: task trinity-c2:147285 can't die for more than 127 seconds.
> [52906.766086][  T310] trinity-c2      R  running task    27896 147285  74932 0x10000004
> [52906.801993][  T310] Call Trace:
> [52906.816338][  T310]  __schedule+0x77e/0x1070
> [52906.836024][  T310]  ? __sched_text_start+0x8/0x8
> [52906.857547][  T310]  ? up_write+0xe9/0x290
> [52906.876797][  T310]  schedule+0x95/0x160
> [52906.915571][  T310]  schedule_timeout+0x47c/0x6a0
> [52906.939198][  T310]  ? usleep_range+0x100/0x100
> [52906.961983][  T310]  ? lock_downgrade+0x3e0/0x3e0
> [52906.983597][  T310]  ? mark_held_locks+0x34/0xb0
> [52907.005053][  T310]  ? _raw_spin_unlock_irq+0x27/0x40
> [52907.028158][  T310]  ? _raw_spin_unlock_irq+0x27/0x40
> [52907.051323][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52907.074918][  T310]  ? wait_for_completion+0x116/0x1a0
> [52907.098366][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52907.120794][  T310]  wait_for_completion+0x11e/0x1a0
> [52907.143566][  T310]  ? wait_for_completion_interruptible+0x220/0x220
> [52907.172861][  T310]  __wait_rcu_gp+0x1ad/0x1e0
> [52907.193176][  T310]  synchronize_rcu+0x128/0x1a0
> [52907.214557][  T310]  ? synchronize_rcu_expedited+0x5e0/0x5e0
> [52907.240532][  T310]  ? match_held_lock+0x20/0x270
> [52907.262106][  T310]  ? invoke_rcu_core+0xf0/0xf0
> [52907.282779][  T310]  ? check_chain_key+0x1df/0x2e0
> [52907.304629][  T310]  ? find_held_lock+0xca/0xf0
> [52907.325381][  T310]  ? __kasan_check_read+0x11/0x20
> [52907.347666][  T310]  __x64_sys_membarrier+0x205/0x62e
> [52907.370924][  T310]  ? membarrier_exec_mmap+0x50/0x50
> [52907.394034][  T310]  ? do_syscall_64+0x79/0xaf0
> [52907.414823][  T310]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [52907.440213][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52907.466322][  T310]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52907.494190][  T310]  do_syscall_64+0xcc/0xaf0
> [52907.514834][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52907.539609][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52907.564670][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52907.593100][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52907.619749][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52907.645538][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52907.673066][  T310] RIP: 0033:0x7fa3d9cd670d
> [52907.693218][  T310] Code: Bad RIP value.
> [52907.711803][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000144
> [52907.750495][  T310] RAX: ffffffffffffffda RBX: 0000000000000144 RCX: 00007fa3d9cd670d
> [52907.786490][  T310] RDX: 0000000000000080 RSI: 0000000000000000 RDI: 0000000000000001
> [52907.822363][  T310] RBP: 0000000000000144 R08: 00000000eeeeeeee R09: 0000000000003418
> [52907.858106][  T310] R10: 0000000000004ff8 R11: 0000000000000246 R12: 0000000000000002
> [52907.894476][  T310] R13: 00007fa3d8678058 R14: 00007fa3d9b956c0 R15: 00007fa3d8678000
> [52907.930457][  T310] INFO: task trinity-c27:149010 can't die for more than 129 seconds.
> [52907.971719][  T310] trinity-c27     R  running task    26944 149010  74932 0x10000004
> [52908.008456][  T310] Call Trace:
> [52908.022892][  T310]  __schedule+0x77e/0x1070
> [52908.042479][  T310]  ? __sched_text_start+0x8/0x8
> [52908.063993][  T310]  ? check_flags.part.28+0x86/0x220
> [52908.087103][  T310]  preempt_schedule_common+0x16/0x50
> [52908.110659][  T310]  _cond_resched+0x22/0x30
> [52908.130167][  T310]  stop_one_cpu+0xd7/0x140
> [52908.149705][  T310]  ? stop_cpus.constprop.3+0x130/0x130
> [52908.174087][  T310]  ? task_rq_unlock+0x6e/0x80
> [52908.194356][  T310]  ? sched_ttwu_pending+0x1b0/0x1b0
> [52908.217715][  T310]  ? lock_downgrade+0x3e0/0x3e0
> [52908.239236][  T310]  ? mark_held_locks+0x34/0xb0
> [52908.260471][  T310]  ? task_rq_unlock+0x6e/0x80
> [52908.281298][  T310]  __set_cpus_allowed_ptr+0x382/0x3a0
> [52908.305375][  T310]  ? move_queued_task+0x3c0/0x3c0
> [52908.327364][  T310]  ? cpuset_cpus_allowed+0x10b/0x200
> [52908.350892][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52908.373276][  T310]  ? __bitmap_and+0xd8/0x100
> [52908.393650][  T310]  sched_setaffinity+0x476/0x660
> [52908.397305][T151560] futex_wake_op: trinity-c39 tries to shift op by -852; fix this program
> [52908.415599][  T310]  ? __x64_sys_sched_getattr+0x3e0/0x3e0
> [52908.455822][T151560] futex_wake_op: trinity-c39 tries to shift op by -852; fix this program
> [52908.483899][  T310]  ? __kasan_check_write+0x14/0x20
> [52908.483908][  T310]  __x64_sys_sched_setaffinity+0x118/0x180
> [52908.483916][  T310]  ? sched_setaffinity+0x660/0x660
> [52908.483925][  T310]  ? do_syscall_64+0x79/0xaf0
> [52908.483934][  T310]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [52908.640521][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52908.664068][  T310]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52908.692710][  T310]  do_syscall_64+0xcc/0xaf0
> [52908.712603][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52908.736117][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52908.762313][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52908.789929][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52908.815487][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52908.840248][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52908.867098][  T310] RIP: 0033:0x7fa3d9cd670d
> [52908.886542][  T310] Code: Bad RIP value.
> [52908.904432][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000cb
> [52908.942172][  T310] RAX: ffffffffffffffda RBX: 00000000000000cb RCX: 00007fa3d9cd670d
> [52908.981963][  T310] RDX: 00007fa3d843c000 RSI: 0000000000000004 RDI: 0000000000000000
> [52909.020646][  T310] RBP: 00000000000000cb R08: 00000000ffffffff R09: fffffffffffffffa
> [52909.057043][  T310] R10: 000000000000001b R11: 0000000000000246 R12: 0000000000000002
> [52909.093664][  T310] R13: 00007fa3d85c9058 R14: 00007fa3d9b956c0 R15: 00007fa3d85c9000
> [52909.129758][  T310] INFO: task trinity-c20:149065 can't die for more than 130 seconds.
> [52909.166089][  T310] trinity-c20     R  running task    27712 149065  74932 0x10000004
> [52909.202031][  T310] Call Trace:
> [52909.216658][  T310]  __schedule+0x77e/0x1070
> [52909.236187][  T310]  ? __sched_text_start+0x8/0x8
> [52909.257916][  T310]  ? check_flags.part.28+0x86/0x220
> [52909.281061][  T310]  preempt_schedule_common+0x16/0x50
> [52909.304664][  T310]  _cond_resched+0x22/0x30
> [52909.324257][  T310]  stop_one_cpu+0xd7/0x140
> [52909.343842][  T310]  ? stop_cpus.constprop.3+0x130/0x130
> [52909.369442][  T310]  ? task_rq_unlock+0x6e/0x80
> [52909.390672][  T310]  ? sched_ttwu_pending+0x1b0/0x1b0
> [52909.413672][  T310]  ? lock_downgrade+0x3e0/0x3e0
> [52909.435178][  T310]  ? mark_held_locks+0x34/0xb0
> [52909.456323][  T310]  ? task_rq_unlock+0x6e/0x80
> [52909.478561][  T310]  __set_cpus_allowed_ptr+0x382/0x3a0
> [52909.505164][  T310]  ? move_queued_task+0x3c0/0x3c0
> [52909.529450][  T310]  ? cpuset_cpus_allowed+0x10b/0x200
> [52909.553226][  T310]  ? trace_hardirqs_on+0x3a/0x160
> [52909.575565][  T310]  ? __bitmap_and+0xd8/0x100
> [52909.596065][  T310]  sched_setaffinity+0x476/0x660
> [52909.617927][  T310]  ? __x64_sys_sched_getattr+0x3e0/0x3e0
> [52909.643034][  T310]  ? copy_user_generic_unrolled+0x86/0xc0
> [52909.669320][  T310]  __x64_sys_sched_setaffinity+0x118/0x180
> [52909.696241][  T310]  ? sched_setaffinity+0x660/0x660
> [52909.719315][  T310]  ? do_syscall_64+0x79/0xaf0
> [52909.740952][  T310]  ? rcu_read_lock_bh_held+0xc0/0xc0
> [52909.765524][  T310]  ? lockdep_hardirqs_on+0x1b0/0x2c0
> [52909.790368][  T310]  ? entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52909.818929][  T310]  do_syscall_64+0xcc/0xaf0
> [52909.839558][  T310]  ? perf_call_bpf_enter+0x1a0/0x1a0
> [52909.863846][  T310]  ? syscall_return_slowpath+0x580/0x580
> [52909.889545][  T310]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
> [52909.916624][  T310]  ? trace_hardirqs_off_caller+0x3a/0x150
> [52909.942269][  T310]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [52909.966872][  T310]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [52909.995175][  T310] RIP: 0033:0x7fa3d9cd670d
> [52910.017390][  T310] Code: Bad RIP value.
> [52910.035569][  T310] RSP: 002b:00007fff1d6588c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000cb
> [52910.073407][  T310] RAX: ffffffffffffffda RBX: 00000000000000cb RCX: 00007fa3d9cd670d
> [52910.109426][  T310] RDX: 00007fa3d7c37000 RSI: 00000000000000a2 RDI: 0000000000000000
> [52910.145197][  T310] RBP: 00000000000000cb R08: ffffffdffdefffff R09: 000000008084b740
> [52910.181004][  T310] R10: 0000000000000080 R11: 0000000000000246 R12: 0000000000000002
> [52910.217004][  T310] R13: 00007fa3d85fa058 R14: 00007fa3d9b956c0 R15: 00007fa3d85fa000
> [52910.254432][  T310] 
> [52910.254432][  T310] Showing all locks held in the system:
> [52910.289717][  T310] 1 lock held by ksoftirqd/16/94:
> [52910.312041][  T310]  #0: ffff88985fa453d8 (&rq->lock){-.-.}-{2:2}, at: newidle_balance+0x88d/0x9c0
> [52910.353309][  T310] 1 lock held by khungtaskd/310:
> [52910.375374][  T310]  #0: ffffffffb3bcacc0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.30+0x0/0x30
> [52910.422536][  T310] 3 locks held by kworker/u96:1/60424:
> [52910.446875][  T310]  #0: ffff88984fef1538 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52910.493637][  T310]  #1: ffffc900240ffe00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52910.542269][  T310]  #2: ffffffffb409cf30 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xa9/0x5c0
> [52910.583972][  T310] 2 locks held by runc/74923:
> [52910.604801][  T310]  #0: ffff88842f510898 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x32/0x40
> [52910.647284][  T310]  #1: ffffc900064bb2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x187/0xe20
> [52910.692274][  T310] 8 locks held by runc/74924:
> [52910.713003][  T310]  #0: ffff888842e453d8 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x227/0x1070
> [52910.752393][  T310]  #1: ffffffffb3bcacc0 (rcu_read_lock){....}-{1:2}, at: perf_iterate_sb+0x0/0x500
> [52910.794272][  T310]  #2: ffff88842f510ae8 (&o_tty->termios_rwsem/1){++++}-{3:3}, at: n_tty_write+0x126/0x7c0
> [52910.839386][  T310]  #3: ffff88842f510d30 (&tty->write_wait){-.-.}-{2:2}, at: remove_wait_queue+0x29/0xc0
> [52910.885384][  T310]  #4: ffff888429bb0558 (&port->lock#2){-.-.}-{2:2}, at: pty_write+0x82/0xf0
> [52910.924906][  T310]  #5: ffffffffb3bcacc0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0x8b/0xa40
> [52910.965808][  T310]  #6: ffff88820f19c418 (&pool->lock/1){-.-.}-{2:2}, at: __queue_work+0x154/0xa40
> [52911.008506][  T310]  #7: ffff888349990828 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0xfb0
> [52911.054482][  T310] 2 locks held by kworker/26:2/87166:
> [52911.078400][  T310]  #0: ffff888207838338 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.124769][  T310]  #1: ffffc900203ffe00 ((work_completion)(&ctx->exit_work)){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.175647][  T310] 2 locks held by kworker/13:2/110105:
> [52911.199910][  T310]  #0: ffff888207838338 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.246366][  T310]  #1: ffffc90031bffe00 (free_ipc_work){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.289451][  T310] 2 locks held by kworker/24:0/140617:
> [52911.313772][  T310]  #0: ffff888207018938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.360933][  T310]  #1: ffffc90021a6fe00 ((work_completion)(&rew.rew_work)){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.411991][  T310] 3 locks held by kworker/36:2/142207:
> [52911.437085][  T310]  #0: ffff888207838338 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.483296][  T310]  #1: ffffc9002420fe00 (slab_caches_to_rcu_destroy_work){+.+.}-{0:0}, at: process_one_work+0x45c/0xb90
> [52911.537354][  T310]  #2: ffffffffb3bd9128 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x440
> [52911.585581][  T310] 1 lock held by trinity-c11/151262:
> [52911.609175][  T310]  #0: ffff889660160248 (&sb->s_type->i_mutex_key#8){+.+.}-{3:3}, at: __sock_release+0x54/0x120
> [52911.655737][  T310] 1 lock held by trinity-c35/151367:
> [52911.680063][  T310]  #0: ffffffffb3bd9220 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4cc/0x5e0
> [52911.768193][  T310] 2 locks held by trinity-c30/151624:
> [52911.792141][  T310] 1 lock held by trinity-c33/151643:
> [52911.815251][  T310]  #0: ffffffffb3bd9220 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x4cc/0x5e0
> [52911.863988][  T310] 1 lock held by trinity-c19/151731:
> [52911.889078][  T310] 
> [52911.899680][  T310] =============================================

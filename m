Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71300C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF1720656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588252503;
	bh=0ICX5fl8ldrwML7QXZmbRmDvZ0odczt0hieZ6hOfMqg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=L8vgjsPUbTItIcvvBxTq8yEdTMAvRrFsBwgsBorECe1/3+u6A46EiXyRn1oet0bOX
	 N+JMLsn8n2nLiUEdegpHzh38I0bnhwhOVHdRM1l1EC4DeXlWaqOiQ3Aj6A6XJiWtQa
	 k0CzXeQ7Vyq4NxSwdTz3vogzd1kPhn50iaNgbP7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgD3NPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgD3NPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:15:01 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF3B020656;
        Thu, 30 Apr 2020 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588252500;
        bh=0ICX5fl8ldrwML7QXZmbRmDvZ0odczt0hieZ6hOfMqg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Dla6krfCcmMXIopjINPVjur7Il8kpUhgR5k57ZFaSClQBArDID/BJb5dYIwzciqPz
         tQC2+/gJ7HPW2R2rLn1RVBBJ065xEiDLsxUQH5XrzVkQ4of4vIxkjmbgb8pOvGar8j
         rOhgfy5cendSoGa0oLkOmSEJrFieQOEl2z4X6gxc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 83DA43520641; Thu, 30 Apr 2020 06:15:00 -0700 (PDT)
Date:   Thu, 30 Apr 2020 06:15:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: rcu_barrier() + membarrier() + scheduler deadlock?
Message-ID: <20200430131500.GQ7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <F64C791A-0EA7-458E-82C0-B98A1032066C@lca.pw>
 <20200430032238.GP7560@paulmck-ThinkPad-P72>
 <1591D10D-9125-4876-8769-85CAA563A435@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1591D10D-9125-4876-8769-85CAA563A435@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:39:48PM -0400, Qian Cai wrote:
> 
> 
> > On Apr 29, 2020, at 11:22 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Wed, Apr 29, 2020 at 11:00:58PM -0400, Qian Cai wrote:
> >> Doing some fuzzers on many CPUs triggers a deadlock really quickly.  I can see that there were several tasks had been stuck for a while,
> >> 
> >> CPUA:
> >> slab_caches_to_rcu_destroy_workfn()
> >> rcu_barrier()
> >> wait_for_completion()
> >> 
> >> CPUB:
> >> sched_setaffinity()
> >> __set_cpus_allowed_ptr()
> >> stop_one_cpu()
> >> 
> >> CPUC:
> >> __x64_sys_membarrier
> >> synchronize_rcu()
> >> __wait_rcu_gp()
> >> wait_for_completion()
> >> 
> >> Lockdep did not flag anything useful at all. Any clue?
> > 
> > CPUA and CPUC are most likely both waiting for a grace period to complete.
> > 
> > CPUA will be blocking CPU hotplug (get_online_cpus()) in case that
> > matters.  I am not seeing any obvious wait for an RCU grace period
> > in CPUB.
> > 
> > But which task's affinity is being set?  That of the grace-period kthread?
> 
> I am not sure. One of task's sched_setaffinity() can’t die, so here is the log from that task.
> 
> # grep setaffinity rootfs/tmp/trinity-child20.log 
> [child20:131] [313] sched_setaffinity(pid=0, len=0x13939393, user_mask_ptr=0x7fa3d7c37000) = -1 (Bad address)
> [child20:131] [574] sched_setaffinity(pid=196, len=0xf000, user_mask_ptr=0x8) = -1 (Bad address)
> [child20:131] [589] sched_setaffinity(pid=0, len=100, user_mask_ptr=0x1) = -1 (Bad address)
> [child20:131] [615] sched_setaffinity(pid=0, len=1, user_mask_ptr=0x8) = -1 (Bad address)
> [child20:589] [17] sched_setaffinity(pid=0, len=8, user_mask_ptr=0x7fa3d7c39000) = -1 (Invalid argument)
> [child20:589] [346] sched_setaffinity(pid=0, len=167, user_mask_ptr=0x1) = -1 (Bad address)
> [child20:926] [44] sched_setaffinity(pid=0, len=4096, user_mask_ptr=0x7fa3d7c3c000) = -1 (Invalid argument)
> [child20:926] [124] sched_setaffinity(pid=0, len=1, user_mask_ptr=0x7fa3d7c38000) = 0
> [child20:1007] [217] sched_setaffinity(pid=0, len=4096, user_mask_ptr=0x7fa3d7c38000) = 0
> [child20:1007] [235] sched_setaffinity(pid=0, len=8, user_mask_ptr=0x0) = -1 (Bad address)
> [child20:1122] [63] sched_setaffinity(pid=0, len=777, user_mask_ptr=0x4) = -1 (Bad address)
> [child20:1122] [509] sched_setaffinity(pid=0, len=4096, user_mask_ptr=0x7fa3d803c000) = 0
> [child20:1122] [902] sched_setaffinity(pid=1750, len=1, user_mask_ptr=0x8) = -1 (Bad address)
> [child20:1824] [57] sched_setaffinity(pid=1723, len=0x1fa56, user_mask_ptr=0x1) = -1 (Bad address)
> [child20:1853] [92] sched_setaffinity(pid=1741, len=4096, user_mask_ptr=0x7fa3d843c000) = 0
> [child20:2058] [114] sched_setaffinity(pid=2019, len=23, user_mask_ptr=0x8) = -1 (Bad address)

Not sure what to make of this.  Some succeeded, others had various
error conditions.  Though I would expect the PID of RCU's kthreads to
be smaller than shown, but it does depend on the hardware and software
configuration.

> > If not, are there rcuo kthreads present?  Either way, preventing any of
> 
> I did not catch that. I might just be that workqueue was unable to handle fuzzers loads on many CPUs. I had another 32-CPU server stuck in flush_work(). Not sure if it is related.

Your .config hss CONFIG_PREEMPT_NONE=y and CONFIG_NO_HZ_IDLE=y, and
there is no RCU callback offloading, so there should not have been any
rcuo kthreads.

But yes, too much overload might break things.

> > RCU's kthreads from running could block potentially both CPUA and CPUC.
> > Though in the case of the grace-period kthread, I would expect to see
> > an RCU CPU stall warning.
> > 
> > Could you please share your .config?
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> [53294.651754][T149877] futex_wake_op: trinity-c25 tries to shift op by -17; fix this program
> [53323.947396][T150988] futex_wake_op: trinity-c6 tries to shift op by -5; fix this program
> [53458.295837][  T215] INFO: task kworker/u64:0:8 blocked for more than 122 seconds.
> [53458.304063][  T215]       Tainted: G           O L    5.7.0-rc3-next-20200429 #1
> [53458.311568][  T215] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [53458.320190][  T215] kworker/u64:0   D10584     8      2 0x90004000
> [53458.326668][  T215] Workqueue: netns cleanup_net
> [53458.331330][  T215] Call Trace:
> [53458.334510][  T215]  __schedule+0x47b/0xa50
> [53458.338765][  T215]  ? wait_for_completion+0x80/0x120
> [53458.343920][  T215]  schedule+0x59/0xd0
> [53458.348013][  T215]  schedule_timeout+0x10a/0x150
> [53458.352762][  T215]  ? wait_for_completion+0x80/0x120
> [53458.357881][  T215]  ? _raw_spin_unlock_irq+0x30/0x40
> [53458.362997][  T215]  ? trace_hardirqs_on+0x22/0x100
> [53458.367948][  T215]  ? wait_for_completion+0x80/0x120
> [53458.373195][  T215]  wait_for_completion+0xb4/0x120
> [53458.378149][  T215]  __flush_work+0x3ff/0x6e0
> [53458.382586][  T215]  ? init_pwq+0x210/0x210
> [53458.386840][  T215]  flush_work+0x20/0x30
> [53458.390891][  T215]  rollback_registered_many+0x3d6/0x950
> [53458.396438][  T215]  ? mark_held_locks+0x4e/0x80
> [53458.401339][  T215]  unregister_netdevice_many+0x5d/0x200
> [53458.406816][  T215]  default_device_exit_batch+0x213/0x240
> [53458.412348][  T215]  ? do_wait_intr_irq+0xe0/0xe0
> [53458.417225][  T215]  ? dev_change_net_namespace+0x6d0/0x6d0
> [53458.423000][  T215]  ops_exit_list+0xa2/0xc0
> [53458.427367][  T215]  cleanup_net+0x3d0/0x600
> [53458.431778][  T215]  process_one_work+0x560/0xba0
> [53458.436629][  T215]  worker_thread+0x80/0x5f0
> [53458.441078][  T215]  ? process_scheduled_works+0x90/0x90
> [53458.446485][  T215]  kthread+0x1de/0x200
> [53458.450600][  T215]  ? kthread_unpark+0xd0/0xd0
> [53458.455227][  T215]  ret_from_fork+0x27/0x50
> [53458.460332][  T215] INFO: task trinity-c17:150651 blocked for more than 123 seconds.
> [53458.468180][  T215]       Tainted: G           O L    5.7.0-rc3-next-20200429 #1
> [53458.475924][  T215] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [53458.484511][  T215] trinity-c17     D12312 150651  93301 0x10000004
> [53458.490862][  T215] Call Trace:
> [53458.494039][  T215]  __schedule+0x47b/0xa50
> [53458.498452][  T215]  schedule+0x59/0xd0
> [53458.502376][  T215]  schedule_preempt_disabled+0x15/0x20
> [53458.507809][  T215]  __mutex_lock+0x6f2/0xbf0
> [53458.512296][  T215]  ? rtnl_lock+0x20/0x30
> [53458.516484][  T215]  mutex_lock_nested+0x31/0x40
> [53458.521157][  T215]  ? mutex_lock_nested+0x31/0x40
> [53458.526195][  T215]  rtnl_lock+0x20/0x30
> [53458.530251][  T215]  do_ip_setsockopt.isra.12+0xec/0x1b90
> [53458.535875][  T215]  ? find_held_lock+0x35/0xa0
> [53458.540603][  T215]  ? rb_insert_color+0x10f/0x390
> [53458.545436][  T215]  ? lock_acquire+0xcd/0x450
> [53458.550126][  T215]  ? find_held_lock+0x35/0xa0
> [53458.554717][  T215]  ? __cgroup_bpf_prog_array_is_empty+0x121/0x230
> [53458.561127][  T215]  ip_setsockopt+0x3e/0x90
> [53458.565511][  T215]  udp_setsockopt+0x49/0x80
> [53458.570059][  T215]  sock_common_setsockopt+0x6d/0x90
> [53458.575303][  T215]  __sys_setsockopt+0x194/0x2e0
> [53458.580128][  T215]  __x64_sys_setsockopt+0x70/0x90
> [53458.585066][  T215]  do_syscall_64+0x91/0xb10
> [53458.589504][  T215]  ? perf_call_bpf_enter+0x120/0x120
> [53458.594741][  T215]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [53458.600467][  T215]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [53458.606296][  T215] RIP: 0033:0x7f2cbe1b270d
> [53458.610611][  T215] Code: Bad RIP value.
> [53458.614570][  T215] RSP: 002b:00007ffe6a4b18d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> [53458.623094][  T215] RAX: ffffffffffffffda RBX: 0000000000000036 RCX: 00007f2cbe1b270d
> [53458.631024][  T215] RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000060
> [53458.638954][  T215] RBP: 0000000000000036 R08: 0000000000000088 R09: 00000000000000f0
> [53458.647044][  T215] R10: 00000000025557f0 R11: 0000000000000246 R12: 0000000000000002
> [53458.654960][  T215] R13: 00007f2cbcaeb058 R14: 00007f2cbe0716c0 R15: 00007f2cbcaeb000
> [53458.662899][  T215] INFO: task trinity-c10:150896 blocked for more than 123 seconds.
> [53458.670757][  T215]       Tainted: G           O L    5.7.0-rc3-next-20200429 #1
> [53458.678380][  T215] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [53458.687007][  T215] trinity-c10     D11512 150896  93301 0x10000004
> [53458.693334][  T215] Call Trace:
> [53458.696545][  T215]  __schedule+0x47b/0xa50
> [53458.700944][  T215]  schedule+0x59/0xd0
> [53458.704817][  T215]  schedule_preempt_disabled+0x15/0x20
> [53458.710246][  T215]  __mutex_lock+0x6f2/0xbf0
> [53458.714686][  T215]  ? rtnl_lock+0x20/0x30
> [53458.718851][  T215]  mutex_lock_nested+0x31/0x40
> [53458.723649][  T215]  ? mutex_lock_nested+0x31/0x40
> [53458.728556][  T215]  rtnl_lock+0x20/0x30
> [53458.732520][  T215]  do_ip_setsockopt.isra.12+0xec/0x1b90
> [53458.737998][  T215]  ? find_held_lock+0x35/0xa0
> [53458.742646][  T215]  ? rb_insert_color+0x10f/0x390
> [53458.747672][  T215]  ? lock_acquire+0xcd/0x450
> [53458.752236][  T215]  ? find_held_lock+0x35/0xa0
> [53458.756847][  T215]  ? __cgroup_bpf_prog_array_is_empty+0x121/0x230
> [53458.763169][  T215]  ip_setsockopt+0x3e/0x90
> [53458.767509][  T215]  udp_setsockopt+0x49/0x80
> [53458.772061][  T215]  sock_common_setsockopt+0x6d/0x90
> [53458.777192][  T215]  __sys_setsockopt+0x194/0x2e0
> [53458.781976][  T215]  __x64_sys_setsockopt+0x70/0x90
> [53458.786994][  T215]  do_syscall_64+0x91/0xb10
> [53458.791460][  T215]  ? perf_call_bpf_enter+0x120/0x120
> [53458.797008][  T215]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [53458.802523][  T215]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> [53458.808368][  T215] RIP: 0033:0x7f2cbe1b270d
> [53458.812678][  T215] Code: Bad RIP value.
> [53458.816669][  T215] RSP: 002b:00007ffe6a4b18d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> [53458.825143][  T215] RAX: ffffffffffffffda RBX: 0000000000000036 RCX: 00007f2cbe1b270d
> [53458.833070][  T215] RDX: 000000000000002c RSI: 0000000000000000 RDI: 000000000000005c
> [53458.840997][  T215] RBP: 0000000000000036 R08: 0000000000000108 R09: 00000000b5b5b5b5
> [53458.849155][  T215] R10: 000000000255b5a0 R11: 0000000000000246 R12: 0000000000000002
> [53458.857072][  T215] R13: 00007f2cbcb1c058 R14: 00007f2cbe0716c0 R15: 00007f2cbcb1c000
> [53458.865076][  T215] 
> [53458.865076][  T215] Showing all locks held in the system:
> [53458.872936][  T215] 5 locks held by kworker/u64:0/8:
> [53458.878066][  T215]  #0: ffff95b4734e4538 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x454/0xba0
> [53458.888191][  T215]  #1: ffffa459431abe18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x454/0xba0
> [53458.898177][  T215]  #2: ffffffff955917b0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x6d/0x600
> [53458.907469][  T215]  #3: ffffffff955975a8 (rtnl_mutexl_mutex){+.+.}-{3:3}, at: rtnl_lock_killable+0x21/0x30
> [53459.304598][  T215] 1 lock held by trinity-c17/150651:
> [53459.309827][  T215]  #0: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x20/0x30
> [53459.318343][  T215] 2 locks held by trinity-c11/150712:
> [53459.323744][  T215]  #0: ffffffff955917b0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x15c/0x26e
> [53459.333092][  T215]  #1: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock_killable+0x21/0x30
> [53459.342364][  T215] 2 locks held by trinity-c7/150739:
> [53459.347768][  T215]  #0: ffffffff955917b0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x15c/0x26e
> [53459.357179][  T215]  #1: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock_killable+0x21/0x30
> [53459.366479][  T215] 2 locks held by trinity-c15/150758:
> [53459.372006][  T215]  #0: ffffffff955917b0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x15c/0x26e
> [53459.381398][  T215]  #1: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock_killable+0x21/0x30

If you have lots of threads doing networking configuration changes,
then contention on RTNL (as evidenced above) is expected behavior.

							Thanx, Paul

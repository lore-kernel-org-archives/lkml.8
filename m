Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF95C83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0EE20733
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jjU+dmt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3Djv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726309AbgD3Djv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:39:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38DC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:39:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 71so3862208qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=upQm17BtZejSz3YogHm9Y8a3wkhQDe3x92tw35R0otc=;
        b=jjU+dmt6gJZWwETzSkLlV319xITArWV+H2vXwf4J+TRtPIBeo7JdVEn5tJUrY8/NvQ
         LnI3Gvo1dWkBP90Le6dJ9VzIm63J8VjcvRcrSvcw9mBMyiYAgAwRbpdV94TUQKflrc3I
         pRox8AR/QxEZdIINSKFlC/24U1qlZyStzkDxj8hY2FOsx+gCAHUT+0sfOfRYLhOOWJg9
         4ebA0FVzfSFFRHsGVhEuzqK7MKyxgES6V6Dtl6iyqflR+/Ty0X1D8VwK3ij2eRS4i1bq
         0a0S8rwiw2dSX++qLugjelWhm6sdGHop5fhgzPvQDCW6QyQnay3IIkkKDNrkZdGjf8Gj
         C+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=upQm17BtZejSz3YogHm9Y8a3wkhQDe3x92tw35R0otc=;
        b=XhmGuBDk/AODiv6gADApy9puD/EXXqfylrEPD/QcJulaCKYoYeqTIQgHbrp3TOb8fb
         hNqnil/uMcKmdwlwfPDm3PYkQD1ZCBQJAGtIdCpIabaZW7B0wxWYDYgXUyt0yh/vHlVJ
         5OHgFPKjGrocEtBAFF6G2owWFfO1CugfVlhYU4/o5QcqtJt6Y3CW0rcMGakqkRdwO0BJ
         A/KdSJhk2X3FnVDvdwJNQ2Xd4u+xdYIO9HGIBG3BwpS64jEO2rJfbml7nIJMGATQZuxZ
         42u2h+FfViJ1T/YF2b2jI/yf9C7QuGNlB81pxLxZmruWtfcSrsdUseTpc00eLGNjJIEd
         cItw==
X-Gm-Message-State: AGi0PubAKPh90G3UR0S49NqD6J+HGP/pqhThWNAZKxo0MD1hh1QHPHpr
        LDfdY3LD97OJlgPQIBUHeO7YkQ==
X-Google-Smtp-Source: APiQypJqwZcjZYEY/x8vW8OSuNfTBIF92akmmSCM+XPc8bYsFnKxvrFmFxvqbjBxCfbBy74XZFjS7Q==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr1682955qto.230.1588217989688;
        Wed, 29 Apr 2020 20:39:49 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s50sm1163384qtj.1.2020.04.29.20.39.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 20:39:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: rcu_barrier() + membarrier() + scheduler deadlock?
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200430032238.GP7560@paulmck-ThinkPad-P72>
Date:   Wed, 29 Apr 2020 23:39:48 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1591D10D-9125-4876-8769-85CAA563A435@lca.pw>
References: <F64C791A-0EA7-458E-82C0-B98A1032066C@lca.pw>
 <20200430032238.GP7560@paulmck-ThinkPad-P72>
To:     "paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 29, 2020, at 11:22 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Wed, Apr 29, 2020 at 11:00:58PM -0400, Qian Cai wrote:
>> Doing some fuzzers on many CPUs triggers a deadlock really quickly.  =
I can see that there were several tasks had been stuck for a while,
>>=20
>> CPUA:
>> slab_caches_to_rcu_destroy_workfn()
>> rcu_barrier()
>> wait_for_completion()
>>=20
>> CPUB:
>> sched_setaffinity()
>> __set_cpus_allowed_ptr()
>> stop_one_cpu()
>>=20
>> CPUC:
>> __x64_sys_membarrier
>> synchronize_rcu()
>> __wait_rcu_gp()
>> wait_for_completion()
>>=20
>> Lockdep did not flag anything useful at all. Any clue?
>=20
> CPUA and CPUC are most likely both waiting for a grace period to =
complete.
>=20
> CPUA will be blocking CPU hotplug (get_online_cpus()) in case that
> matters.  I am not seeing any obvious wait for an RCU grace period
> in CPUB.
>=20
> But which task's affinity is being set?  That of the grace-period =
kthread?

I am not sure. One of task's sched_setaffinity() can=E2=80=99t die, so =
here is the log from that task.

# grep setaffinity rootfs/tmp/trinity-child20.log=20
[child20:131] [313] sched_setaffinity(pid=3D0, len=3D0x13939393, =
user_mask_ptr=3D0x7fa3d7c37000) =3D -1 (Bad address)
[child20:131] [574] sched_setaffinity(pid=3D196, len=3D0xf000, =
user_mask_ptr=3D0x8) =3D -1 (Bad address)
[child20:131] [589] sched_setaffinity(pid=3D0, len=3D100, =
user_mask_ptr=3D0x1) =3D -1 (Bad address)
[child20:131] [615] sched_setaffinity(pid=3D0, len=3D1, =
user_mask_ptr=3D0x8) =3D -1 (Bad address)
[child20:589] [17] sched_setaffinity(pid=3D0, len=3D8, =
user_mask_ptr=3D0x7fa3d7c39000) =3D -1 (Invalid argument)
[child20:589] [346] sched_setaffinity(pid=3D0, len=3D167, =
user_mask_ptr=3D0x1) =3D -1 (Bad address)
[child20:926] [44] sched_setaffinity(pid=3D0, len=3D4096, =
user_mask_ptr=3D0x7fa3d7c3c000) =3D -1 (Invalid argument)
[child20:926] [124] sched_setaffinity(pid=3D0, len=3D1, =
user_mask_ptr=3D0x7fa3d7c38000) =3D 0
[child20:1007] [217] sched_setaffinity(pid=3D0, len=3D4096, =
user_mask_ptr=3D0x7fa3d7c38000) =3D 0
[child20:1007] [235] sched_setaffinity(pid=3D0, len=3D8, =
user_mask_ptr=3D0x0) =3D -1 (Bad address)
[child20:1122] [63] sched_setaffinity(pid=3D0, len=3D777, =
user_mask_ptr=3D0x4) =3D -1 (Bad address)
[child20:1122] [509] sched_setaffinity(pid=3D0, len=3D4096, =
user_mask_ptr=3D0x7fa3d803c000) =3D 0
[child20:1122] [902] sched_setaffinity(pid=3D1750, len=3D1, =
user_mask_ptr=3D0x8) =3D -1 (Bad address)
[child20:1824] [57] sched_setaffinity(pid=3D1723, len=3D0x1fa56, =
user_mask_ptr=3D0x1) =3D -1 (Bad address)
[child20:1853] [92] sched_setaffinity(pid=3D1741, len=3D4096, =
user_mask_ptr=3D0x7fa3d843c000) =3D 0
[child20:2058] [114] sched_setaffinity(pid=3D2019, len=3D23, =
user_mask_ptr=3D0x8) =3D -1 (Bad address)

> If not, are there rcuo kthreads present?  Either way, preventing any =
of

I did not catch that. I might just be that workqueue was unable to =
handle fuzzers loads on many CPUs. I had another 32-CPU server stuck in =
flush_work(). Not sure if it is related.

> RCU's kthreads from running could block potentially both CPUA and =
CPUC.
> Though in the case of the grace-period kthread, I would expect to see
> an RCU CPU stall warning.
>=20
> Could you please share your .config?

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

[53294.651754][T149877] futex_wake_op: trinity-c25 tries to shift op by =
-17; fix this program
[53323.947396][T150988] futex_wake_op: trinity-c6 tries to shift op by =
-5; fix this program
[53458.295837][  T215] INFO: task kworker/u64:0:8 blocked for more than =
122 seconds.
[53458.304063][  T215]       Tainted: G           O L    =
5.7.0-rc3-next-20200429 #1
[53458.311568][  T215] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[53458.320190][  T215] kworker/u64:0   D10584     8      2 0x90004000
[53458.326668][  T215] Workqueue: netns cleanup_net
[53458.331330][  T215] Call Trace:
[53458.334510][  T215]  __schedule+0x47b/0xa50
[53458.338765][  T215]  ? wait_for_completion+0x80/0x120
[53458.343920][  T215]  schedule+0x59/0xd0
[53458.348013][  T215]  schedule_timeout+0x10a/0x150
[53458.352762][  T215]  ? wait_for_completion+0x80/0x120
[53458.357881][  T215]  ? _raw_spin_unlock_irq+0x30/0x40
[53458.362997][  T215]  ? trace_hardirqs_on+0x22/0x100
[53458.367948][  T215]  ? wait_for_completion+0x80/0x120
[53458.373195][  T215]  wait_for_completion+0xb4/0x120
[53458.378149][  T215]  __flush_work+0x3ff/0x6e0
[53458.382586][  T215]  ? init_pwq+0x210/0x210
[53458.386840][  T215]  flush_work+0x20/0x30
[53458.390891][  T215]  rollback_registered_many+0x3d6/0x950
[53458.396438][  T215]  ? mark_held_locks+0x4e/0x80
[53458.401339][  T215]  unregister_netdevice_many+0x5d/0x200
[53458.406816][  T215]  default_device_exit_batch+0x213/0x240
[53458.412348][  T215]  ? do_wait_intr_irq+0xe0/0xe0
[53458.417225][  T215]  ? dev_change_net_namespace+0x6d0/0x6d0
[53458.423000][  T215]  ops_exit_list+0xa2/0xc0
[53458.427367][  T215]  cleanup_net+0x3d0/0x600
[53458.431778][  T215]  process_one_work+0x560/0xba0
[53458.436629][  T215]  worker_thread+0x80/0x5f0
[53458.441078][  T215]  ? process_scheduled_works+0x90/0x90
[53458.446485][  T215]  kthread+0x1de/0x200
[53458.450600][  T215]  ? kthread_unpark+0xd0/0xd0
[53458.455227][  T215]  ret_from_fork+0x27/0x50
[53458.460332][  T215] INFO: task trinity-c17:150651 blocked for more =
than 123 seconds.
[53458.468180][  T215]       Tainted: G           O L    =
5.7.0-rc3-next-20200429 #1
[53458.475924][  T215] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[53458.484511][  T215] trinity-c17     D12312 150651  93301 0x10000004
[53458.490862][  T215] Call Trace:
[53458.494039][  T215]  __schedule+0x47b/0xa50
[53458.498452][  T215]  schedule+0x59/0xd0
[53458.502376][  T215]  schedule_preempt_disabled+0x15/0x20
[53458.507809][  T215]  __mutex_lock+0x6f2/0xbf0
[53458.512296][  T215]  ? rtnl_lock+0x20/0x30
[53458.516484][  T215]  mutex_lock_nested+0x31/0x40
[53458.521157][  T215]  ? mutex_lock_nested+0x31/0x40
[53458.526195][  T215]  rtnl_lock+0x20/0x30
[53458.530251][  T215]  do_ip_setsockopt.isra.12+0xec/0x1b90
[53458.535875][  T215]  ? find_held_lock+0x35/0xa0
[53458.540603][  T215]  ? rb_insert_color+0x10f/0x390
[53458.545436][  T215]  ? lock_acquire+0xcd/0x450
[53458.550126][  T215]  ? find_held_lock+0x35/0xa0
[53458.554717][  T215]  ? __cgroup_bpf_prog_array_is_empty+0x121/0x230
[53458.561127][  T215]  ip_setsockopt+0x3e/0x90
[53458.565511][  T215]  udp_setsockopt+0x49/0x80
[53458.570059][  T215]  sock_common_setsockopt+0x6d/0x90
[53458.575303][  T215]  __sys_setsockopt+0x194/0x2e0
[53458.580128][  T215]  __x64_sys_setsockopt+0x70/0x90
[53458.585066][  T215]  do_syscall_64+0x91/0xb10
[53458.589504][  T215]  ? perf_call_bpf_enter+0x120/0x120
[53458.594741][  T215]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[53458.600467][  T215]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[53458.606296][  T215] RIP: 0033:0x7f2cbe1b270d
[53458.610611][  T215] Code: Bad RIP value.
[53458.614570][  T215] RSP: 002b:00007ffe6a4b18d8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000036
[53458.623094][  T215] RAX: ffffffffffffffda RBX: 0000000000000036 RCX: =
00007f2cbe1b270d
[53458.631024][  T215] RDX: 000000000000002a RSI: 0000000000000000 RDI: =
0000000000000060
[53458.638954][  T215] RBP: 0000000000000036 R08: 0000000000000088 R09: =
00000000000000f0
[53458.647044][  T215] R10: 00000000025557f0 R11: 0000000000000246 R12: =
0000000000000002
[53458.654960][  T215] R13: 00007f2cbcaeb058 R14: 00007f2cbe0716c0 R15: =
00007f2cbcaeb000
[53458.662899][  T215] INFO: task trinity-c10:150896 blocked for more =
than 123 seconds.
[53458.670757][  T215]       Tainted: G           O L    =
5.7.0-rc3-next-20200429 #1
[53458.678380][  T215] "echo 0 > =
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[53458.687007][  T215] trinity-c10     D11512 150896  93301 0x10000004
[53458.693334][  T215] Call Trace:
[53458.696545][  T215]  __schedule+0x47b/0xa50
[53458.700944][  T215]  schedule+0x59/0xd0
[53458.704817][  T215]  schedule_preempt_disabled+0x15/0x20
[53458.710246][  T215]  __mutex_lock+0x6f2/0xbf0
[53458.714686][  T215]  ? rtnl_lock+0x20/0x30
[53458.718851][  T215]  mutex_lock_nested+0x31/0x40
[53458.723649][  T215]  ? mutex_lock_nested+0x31/0x40
[53458.728556][  T215]  rtnl_lock+0x20/0x30
[53458.732520][  T215]  do_ip_setsockopt.isra.12+0xec/0x1b90
[53458.737998][  T215]  ? find_held_lock+0x35/0xa0
[53458.742646][  T215]  ? rb_insert_color+0x10f/0x390
[53458.747672][  T215]  ? lock_acquire+0xcd/0x450
[53458.752236][  T215]  ? find_held_lock+0x35/0xa0
[53458.756847][  T215]  ? __cgroup_bpf_prog_array_is_empty+0x121/0x230
[53458.763169][  T215]  ip_setsockopt+0x3e/0x90
[53458.767509][  T215]  udp_setsockopt+0x49/0x80
[53458.772061][  T215]  sock_common_setsockopt+0x6d/0x90
[53458.777192][  T215]  __sys_setsockopt+0x194/0x2e0
[53458.781976][  T215]  __x64_sys_setsockopt+0x70/0x90
[53458.786994][  T215]  do_syscall_64+0x91/0xb10
[53458.791460][  T215]  ? perf_call_bpf_enter+0x120/0x120
[53458.797008][  T215]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[53458.802523][  T215]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[53458.808368][  T215] RIP: 0033:0x7f2cbe1b270d
[53458.812678][  T215] Code: Bad RIP value.
[53458.816669][  T215] RSP: 002b:00007ffe6a4b18d8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000036
[53458.825143][  T215] RAX: ffffffffffffffda RBX: 0000000000000036 RCX: =
00007f2cbe1b270d
[53458.833070][  T215] RDX: 000000000000002c RSI: 0000000000000000 RDI: =
000000000000005c
[53458.840997][  T215] RBP: 0000000000000036 R08: 0000000000000108 R09: =
00000000b5b5b5b5
[53458.849155][  T215] R10: 000000000255b5a0 R11: 0000000000000246 R12: =
0000000000000002
[53458.857072][  T215] R13: 00007f2cbcb1c058 R14: 00007f2cbe0716c0 R15: =
00007f2cbcb1c000
[53458.865076][  T215]=20
[53458.865076][  T215] Showing all locks held in the system:
[53458.872936][  T215] 5 locks held by kworker/u64:0/8:
[53458.878066][  T215]  #0: ffff95b4734e4538 =
((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x454/0xba0
[53458.888191][  T215]  #1: ffffa459431abe18 =
(net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x454/0xba0
[53458.898177][  T215]  #2: ffffffff955917b0 =
(pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x6d/0x600
[53458.907469][  T215]  #3: ffffffff955975a8 =
(rtnl_mutexl_mutex){+.+.}-{3:3}, at: rtnl_lock_killable+0x21/0x30
[53459.304598][  T215] 1 lock held by trinity-c17/150651:
[53459.309827][  T215]  #0: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, =
at: rtnl_lock+0x20/0x30
[53459.318343][  T215] 2 locks held by trinity-c11/150712:
[53459.323744][  T215]  #0: ffffffff955917b0 =
(pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x15c/0x26e
[53459.333092][  T215]  #1: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, =
at: rtnl_lock_killable+0x21/0x30
[53459.342364][  T215] 2 locks held by trinity-c7/150739:
[53459.347768][  T215]  #0: ffffffff955917b0 =
(pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x15c/0x26e
[53459.357179][  T215]  #1: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, =
at: rtnl_lock_killable+0x21/0x30
[53459.366479][  T215] 2 locks held by trinity-c15/150758:
[53459.372006][  T215]  #0: ffffffff955917b0 =
(pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x15c/0x26e
[53459.381398][  T215]  #1: ffffffff955975a8 (rtnl_mutex){+.+.}-{3:3}, =
at: rtnl_lock_killable+0x21/0x30=

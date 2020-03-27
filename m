Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D15C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3B1206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 07:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgC0Hnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 03:43:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:19872 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgC0Hnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 03:43:52 -0400
IronPort-SDR: SLkwoA5WraIx114HRzPAlrDPn4eGLeEXqSYVYSldsh/X7S0B4SSz9N7HBSYIU2Trwjv3ezQI8h
 sFxFClLssRbA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 00:43:39 -0700
IronPort-SDR: QDqpqd3+7qDDLc9rUPFVgNqnvzncaDPe1/cd9kBD1xvKZGiBSxDElBp16ZwBi1UrCkty/3zttv
 oS8CaBmFB2Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="xz'?gz'50?scan'50,208,50";a="447320837"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 00:43:26 -0700
Date:   Fri, 27 Mar 2020 15:43:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>
Subject: 6d25be5782 ("sched/core, workqueues: Distangle worker .."): [
   52.816697] WARNING: CPU: 0 PID: 14 at kernel/workqueue.c:882
 wq_worker_sleeping
Message-ID: <20200327074308.GY11705@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eRJUXWYUKFXpoo3g"
Content-Disposition: inline
User-Agent: Heirloom mailx 12.5 6/20/10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eRJUXWYUKFXpoo3g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit 6d25be5782e482eb93e3de0c94d0a517879377d0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed Mar 13 17:55:48 2019 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Tue Apr 16 16:55:15 2019 +0200

    sched/core, workqueues: Distangle worker accounting from rq lock
    
    The worker accounting for CPU bound workers is plugged into the core
    scheduler code and the wakeup code. This is not a hard requirement and
    can be avoided by keeping track of the state in the workqueue code
    itself.
    
    Keep track of the sleeping state in the worker itself and call the
    notifier before entering the core scheduler. There might be false
    positives when the task is woken between that call and actually
    scheduling, but that's not really different from scheduling and being
    woken immediately after switching away. When nr_running is updated when
    the task is retunrning from schedule() then it is later compared when it
    is done from ttwu().
    
    [ bigeasy: preempt_disable() around wq_worker_sleeping() by Daniel Bristot de Oliveira ]
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Acked-by: Tejun Heo <tj@kernel.org>
    Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
    Cc: Lai Jiangshan <jiangshanlai@gmail.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/ad2b29b5715f970bffc1a7026cabd6ff0b24076a.1532952814.git.bristot@redhat.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

e2abb39811  sched/fair: Remove unneeded prototype of capacity_of()
6d25be5782  sched/core, workqueues: Distangle worker accounting from rq lock
9efcc4a129  afs: Fix unpinned address list during probing
+--------------------------------------------------------------------------------+------------+------------+------------+
|                                                                                | e2abb39811 | 6d25be5782 | 9efcc4a129 |
+--------------------------------------------------------------------------------+------------+------------+------------+
| boot_successes                                                                 | 997        | 806        | 27         |
| boot_failures                                                                  | 112        | 104        | 9          |
| WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fwd_prog                       | 61         | 52         | 2          |
| RIP:rcu_torture_fwd_prog                                                       | 63         | 57         | 2          |
| BUG:workqueue_lockup-pool                                                      | 12         | 16         | 1          |
| BUG:kernel_hang_in_early-boot_stage,last_printk:early_console_in_setup_code    | 14         | 13         | 6          |
| BUG:kernel_timeout_in_early-boot_stage,last_printk:early_console_in_setup_code | 5          |            |            |
| Initiating_system_reboot                                                       | 1          |            |            |
| BUG:spinlock_recursion_on_CPU                                                  | 10         | 6          |            |
| RIP:rcu_torture_one_read                                                       | 2          |            |            |
| INFO:rcu_preempt_self-detected_stall_on_CPU                                    | 1          | 3          |            |
| RIP:iov_iter_copy_from_user_atomic                                             | 1          | 3          |            |
| BUG:kernel_hang_in_boot_stage                                                  | 2          |            |            |
| RIP:__schedule                                                                 | 4          | 2          |            |
| BUG:kernel_hang_in_test_stage                                                  | 2          |            |            |
| RIP:rcutorture_seq_diff                                                        | 3          |            |            |
| BUG:spinlock_wrong_owner_on_CPU                                                | 1          |            |            |
| BUG:workqueue_leaked_lock_or_atomic:rcu_torture_sta                            | 1          |            |            |
| BUG:sleeping_function_called_from_invalid_context_at_kernel/workqueue.c        | 1          |            |            |
| WARNING:at_kernel/workqueue.c:#worker_set_flags                                | 1          |            |            |
| RIP:worker_set_flags                                                           | 1          |            |            |
| BUG:scheduling_while_atomic                                                    | 1          |            |            |
| BUG:unable_to_handle_kernel                                                    | 2          | 1          |            |
| Oops:#[##]                                                                     | 2          | 1          |            |
| Kernel_panic-not_syncing:Fatal_exception                                       | 6          | 1          |            |
| kernel_BUG_at_lib/list_debug.c                                                 | 4          |            |            |
| invalid_opcode:#[##]                                                           | 4          |            |            |
| RIP:__list_add_valid                                                           | 4          |            |            |
| RIP:__rb_erase_color                                                           | 1          |            |            |
| INFO:rcu_preempt_detected_stalls_on_CPUs/tasks                                 | 1          | 7          |            |
| RIP:rcu_read_delay                                                             | 1          | 1          |            |
| RIP:kvm_async_pf_task_wait                                                     | 1          |            |            |
| RIP:d_walk                                                                     | 1          |            |            |
| WARNING:at_kernel/workqueue.c:#wq_worker_sleeping                              | 0          | 8          | 1          |
| RIP:wq_worker_sleeping                                                         | 0          | 8          | 1          |
| RIP:kthread_data                                                               | 0          | 2          |            |
| RIP:to_kthread                                                                 | 0          | 1          |            |
| RIP:wq_worker_running                                                          | 0          | 5          | 1          |
| WARNING:at_kernel/workqueue.c:#worker_enter_idle                               | 0          | 3          | 1          |
| RIP:worker_enter_idle                                                          | 0          | 3          | 1          |
| BUG:kernel_timeout_in_boot_stage                                               | 0          | 1          |            |
| BUG:soft_lockup-CPU##stuck_for#s![rcu_torture_fak:#]                           | 0          | 1          |            |
| RIP:preempt_count_equals                                                       | 0          | 2          |            |
| Kernel_panic-not_syncing:softlockup:hung_tasks                                 | 0          | 2          |            |
| BUG:soft_lockup-CPU##stuck_for#s![rcu_torture_rea:#]                           | 0          | 1          |            |
| RIP:ftrace_stub                                                                | 0          | 1          |            |
| RIP:ftrace_likely_update                                                       | 0          | 3          |            |
| RIP:simple_write_end                                                           | 0          | 1          |            |
| RIP:delay_tsc                                                                  | 0          | 2          |            |
| RIP:check_preemption_disabled                                                  | 0          | 1          |            |
+--------------------------------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    5.924439] igt_debug 0x0000000000000200-0x0000000000000600: 1024: used
[    5.924883] igt_debug 0x0000000000000600-0x0000000000000a00: 1024: free
[    5.925327] igt_debug 0x0000000000000a00-0x0000000000000e00: 1024: used
[    5.925806] igt_debug 0x0000000000000e00-0x0000000000001000: 512: free
[    5.926286] igt_debug total: 4096, used 2048 free 2048
[   52.816697] WARNING: CPU: 0 PID: 14 at kernel/workqueue.c:882 wq_worker_sleeping+0x72/0x136
[   52.821963] Modules linked in:
[   52.821963] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 5.1.0-rc3-00024-g6d25be5782e48 #1
[   52.821963] Workqueue: rcu_gp wait_rcu_exp_gp
[   52.821963] RIP: 0010:wq_worker_sleeping+0x72/0x136
[   52.821963] Code: 48 8b 58 40 45 85 ed 41 0f 95 c6 31 c9 31 d2 44 89 f6 e8 c5 3f 0d 00 48 ff 05 71 aa 59 03 45 85 ed 74 17 48 ff 05 6d aa 59 03 <0f> 0b 48 ff 05 6c aa 59 03 48 ff 05 6d aa 59 03 31 c9 31 d2 44 89
[   52.821963] RSP: 0000:ffffa66380073b78 EFLAGS: 00010202
[   52.821963] RAX: ffff97fe37b08de0 RBX: ffffffff9c2ae960 RCX: 0000000000000000
[   52.821963] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff9cd4e028
[   52.821963] RBP: ffffa66380073b98 R08: 0000000000000000 R09: 0000000000000000
[   52.821963] R10: ffffa66380073c90 R11: 0000000000000000 R12: ffff97fe37b08de0
[   52.821963] R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000005000
[   52.821963] FS:  0000000000000000(0000) GS:ffffffff9c250000(0000) knlGS:0000000000000000
[   52.821963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   52.821963] CR2: 0000000000005000 CR3: 00000001b741a000 CR4: 00000000000006b0
[   52.821963] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   52.821963] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   52.821963] Call Trace:
[   52.821963]  schedule+0x7a/0x1c0
[   52.821963]  kvm_async_pf_task_wait+0x253/0x300
[   52.821963]  do_async_page_fault+0xbf/0x141
[   52.821963]  ? kvm_async_pf_task_wait+0x5/0x300
[   52.821963]  ? do_async_page_fault+0xbf/0x141
[   52.821963]  async_page_fault+0x1e/0x30
[   52.821963] RIP: 0010:to_kthread+0x0/0x81
[   52.821963] Code: 03 48 ff 05 44 b0 59 03 89 de 31 c9 31 d2 48 c7 c7 a8 ea d4 9c e8 9f ec 0c 00 48 ff 05 33 b0 59 03 5b 41 5c 41 5d 41 5e 5d c3 <55> 48 ff 05 a2 a8 59 03 48 89 e5 41 55 41 54 53 45 31 ed 49 89 fc
[   52.821963] RSP: 0000:ffffa66380073d68 EFLAGS: 00010206
[   52.821963] RAX: 0000000000000000 RBX: ffff97fe37b52000 RCX: 0000000000000000
[   52.821963] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff97fe37b52000
[   52.821963] RBP: ffffa66380073d70 R08: 0000000000000000 R09: ffffffff9c2c0a18
[   52.821963] R10: ffff97fe37b52060 R11: 0000000000000000 R12: 0000000000000000
[   52.821963] R13: ffffffff9cd51418 R14: 0000000000002710 R15: 0000000000000000
[   52.821963]  ? kthread_data+0x15/0x22
[   52.821963]  wq_worker_running+0x15/0x53
[   52.821963]  schedule+0x1ab/0x1c0
[   52.821963]  schedule_timeout+0xd6/0x10a
[   52.821963]  ? init_timer_key+0x41/0x41
[   52.821963]  rcu_exp_sel_wait_wake+0x58c/0xae2
[   52.821963]  wait_rcu_exp_gp+0x19/0x22
[   52.821963]  process_one_work+0x387/0x5eb
[   52.821963]  ? worker_thread+0x4d2/0x5e3
[   52.821963]  worker_thread+0x401/0x5e3
[   52.821963]  ? rescuer_thread+0x492/0x492
[   52.821963]  kthread+0x19b/0x1aa
[   52.821963]  ? kthread_flush_work+0x175/0x175
[   52.821963]  ret_from_fork+0x3a/0x50
[   52.821963] random: get_random_bytes called from init_oops_id+0x2d/0x4c with crng_init=0
[   52.821963] ---[ end trace 0be0a8f9c0f268e1 ]---
[   64.886064] rcu-torture: rtc: (____ptrval____) ver: 324 tfle: 0 rta: 324 rtaf: 0 rtf: 315 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 101 barrier: 0/0:0

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v5.2 v5.1 --
git bisect  bad 2c1212de6f9794a7becba5f219fa6ce8a8222c90  # 23:32  B    104     1    6 273  Merge tag 'spdx-5.2-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
git bisect  bad 06cbd26d312edfe4a83ff541c23f8f866265eb24  # 00:18  B     26     1    0   0  Merge tag 'nfs-for-5.2-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
git bisect  bad 9f2e3a53f7ec9ef55e9d01bc29a6285d291c151e  # 05:24  B    269     1   20  20  Merge tag 'for-5.2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect  bad ba3934de557a2074b89d67e29e5ce119f042d057  # 08:23  B    131     1   11  11  Merge branch 'x86-platform-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 90489a72fba9529c85e051067ecb41183b8e982e  # 16:37  G    900     0   74  74  Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 82ac4043cac5d75d8cda79bc8a095f8306f35c75  # 17:45  B    245     1   22  22  Merge branch 'x86-cache-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad a0e928ed7c603a47dca8643e58db224a799ff2c5  # 21:01  B    315     1   22  22  Merge branch 'timers-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad e00d4135751bfe786a9e26b5560b185ce3f9f963  # 23:36  B    193     1   16  16  Merge branch 'sched-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad bee9853932e90ce94bce4276ec6b7b06bc48070b  # 02:33  B    262     1   24  24  sched/core: Fix typo in comment
git bisect good d8743230c9f4e92f370ecd2a90c680ddcede6ae5  # 08:53  G    902     0   97  97  sched/topology: Fix build_sched_groups() comment
git bisect  bad 6d25be5782e482eb93e3de0c94d0a517879377d0  # 10:00  B     62     1   12  12  sched/core, workqueues: Distangle worker accounting from rq lock
git bisect good e2abb398115e9c33f3d1e25bf6d1d08badc58b13  # 23:19  G    900     0   89  89  sched/fair: Remove unneeded prototype of capacity_of()
# first bad commit: [6d25be5782e482eb93e3de0c94d0a517879377d0] sched/core, workqueues: Distangle worker accounting from rq lock
git bisect good e2abb398115e9c33f3d1e25bf6d1d08badc58b13  # 02:02  G   1000     0   21 110  sched/fair: Remove unneeded prototype of capacity_of()
# extra tests with debug options
git bisect good 6d25be5782e482eb93e3de0c94d0a517879377d0  # 09:37  G    900     0  147 147  sched/core, workqueues: Distangle worker accounting from rq lock
# extra tests on head commit of linus/master
git bisect  bad 9efcc4a129363187c9bf15338692f107c5c9b6f0  # 10:25  B     30     1    7   7  afs: Fix unpinned address list during probing
# bad: [9efcc4a129363187c9bf15338692f107c5c9b6f0] afs: Fix unpinned address list during probing
# extra tests on linus/master
# duplicated: [9efcc4a129363187c9bf15338692f107c5c9b6f0] afs: Fix unpinned address list during probing
# extra tests on linux-next/master
# 119: [89295c59c1f063b533d071ca49d0fa0c0783ca6f] Add linux-next specific files for 20200326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

--eRJUXWYUKFXpoo3g
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-13:20200326101641:x86_64-randconfig-f001-20200301:5.1.0-rc3-00024-g6d25be5782e48:1.gz"
Content-Transfer-Encoding: base64

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
PPgvtVZUMs9ZAQA=

--eRJUXWYUKFXpoo3g
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg-quantal-vm-quantal-10:20200326113507:x86_64-randconfig-f001-20200301:5.1.0-rc3-00023-ge2abb398115e9c:1.gz"
Content-Transfer-Encoding: base64

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

--eRJUXWYUKFXpoo3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reproduce-quantal-vm-quantal-13:20200326101641:x86_64-randconfig-f001-20200301:5.1.0-rc3-00024-g6d25be5782e48:1"

#!/bin/bash

kernel=$1
initrd=quantal-x86_64-trinity.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/quantal/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-initrd $initrd
	-m 8192
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	rcuperf.shutdown=0
	watchdog_thresh=60
)

"${kvm[@]}" -append "${append[*]}"

--eRJUXWYUKFXpoo3g
Content-Type: application/x-xz
Content-Disposition: attachment; filename="3285ffc82e1fb00caabde46c6bed6cb262b4d498:gcc-7:x86_64-randconfig-f001-20200301:WARNING:at_kernel_workqueue.c:_wq_worker_sleeping.xz"
Content-Transfer-Encoding: base64

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
7KAgqbHEZ/sCAAAAAARZWg==

--eRJUXWYUKFXpoo3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.1.0-rc3-00024-g6d25be5782e48"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.1.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_CONTEXT_TRACKING=y
CONFIG_CONTEXT_TRACKING_FORCE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
# CONFIG_EVENTFD is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
# CONFIG_XEN_PVHVM is not set
CONFIG_XEN_SAVE_RESTORE=y
CONFIG_XEN_DEBUG_FS=y
CONFIG_KVM_GUEST=y
CONFIG_PVH=y
CONFIG_KVM_DEBUG_FS=y
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
CONFIG_JAILHOUSE_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
# CONFIG_CPU_SUP_INTEL is not set
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
CONFIG_HPET_TIMER=y
# CONFIG_DMI is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_X86_VSYSCALL_EMULATION=y
# CONFIG_I8K is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
# CONFIG_MTRR is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_VERIFY_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_DPM_WATCHDOG=y
CONFIG_DPM_WATCHDOG_TIMEOUT=120
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
# CONFIG_SFI is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_CPUFREQ_DT is not set
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
# CONFIG_X86_SYSFB is not set

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_4_7=y
CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
# CONFIG_COREDUMP is not set

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_CLEANCACHE=y
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
CONFIG_CMA_DEBUG=y
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_INTERFACE is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_TUNNEL=y
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_ADVANCED is not set

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_LABELS is not set
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_IRC=m
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CT_NETLINK=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_NEEDED=y
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
# CONFIG_NF_TABLES is not set
CONFIG_NETFILTER_XTABLES=m

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_NAT=m
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
# CONFIG_NETFILTER_XT_TARGET_REDIRECT is not set
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_IP_SET is not set
# CONFIG_IP_VS is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
# CONFIG_NF_SOCKET_IPV4 is not set
# CONFIG_NF_TPROXY_IPV4 is not set
# CONFIG_NF_DUP_IPV4 is not set
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
# CONFIG_IP_NF_TARGET_MASQUERADE is not set
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_RAW is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_NF_SOCKET_IPV6 is not set
# CONFIG_NF_TPROXY_IPV6 is not set
# CONFIG_NF_DUP_IPV6 is not set
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_MANGLE=m
# CONFIG_IP6_NF_RAW is not set
CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_BRIDGE_NF_EBTABLES is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
CONFIG_X25=y
CONFIG_LAPB=y
CONFIG_PHONET=y
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
# CONFIG_BATMAN_ADV_DEBUGFS is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_TRACING=y
# CONFIG_OPENVSWITCH is not set
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
# CONFIG_MPLS is not set
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_CGROUP_NET_PRIO=y
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_BPF_STREAM_PARSER=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
# CONFIG_MKISS is not set
# CONFIG_6PACK is not set
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
CONFIG_BAYCOM_SER_HDX=y
CONFIG_BAYCOM_PAR=y
# CONFIG_YAM is not set
CONFIG_CAN=y
CONFIG_CAN_RAW=y
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=y

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
CONFIG_CAN_VXCAN=y
# CONFIG_CAN_SLCAN is not set
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_BT=y
# CONFIG_BT_BREDR is not set
CONFIG_BT_LE=y
CONFIG_BT_LEDS=y
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTSDIO is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_BT_MRVL=y
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_CERTIFICATION_ONUS=y
# CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set
# CONFIG_CFG80211_REG_CELLULAR_HINTS is not set
# CONFIG_CFG80211_REG_RELAX_NO_IR is not set
CONFIG_CFG80211_DEFAULT_PS=y
CONFIG_CFG80211_DEBUGFS=y
# CONFIG_CFG80211_CRDA_SUPPORT is not set
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
# CONFIG_MAC80211_LEDS is not set
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_WIMAX=y
CONFIG_WIMAX_DEBUG_LEVEL=8
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=y
CONFIG_NFC_DIGITAL=y
CONFIG_NFC_NCI=y
CONFIG_NFC_NCI_SPI=y
# CONFIG_NFC_NCI_UART is not set
CONFIG_NFC_HCI=y
CONFIG_NFC_SHDLC=y

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=y
CONFIG_NFC_MEI_PHY=y
# CONFIG_NFC_SIM is not set
# CONFIG_NFC_FDP is not set
CONFIG_NFC_PN544=y
CONFIG_NFC_PN544_I2C=y
# CONFIG_NFC_PN544_MEI is not set
CONFIG_NFC_PN533=y
CONFIG_NFC_PN533_I2C=y
CONFIG_NFC_MICROREAD=y
CONFIG_NFC_MICROREAD_I2C=y
CONFIG_NFC_MICROREAD_MEI=y
CONFIG_NFC_ST21NFCA=y
CONFIG_NFC_ST21NFCA_I2C=y
CONFIG_NFC_ST_NCI=y
CONFIG_NFC_ST_NCI_I2C=y
CONFIG_NFC_ST_NCI_SPI=y
CONFIG_NFC_NXP_NCI=y
CONFIG_NFC_NXP_NCI_I2C=y
CONFIG_NFC_S3FWRN5=y
CONFIG_NFC_S3FWRN5_I2C=y
CONFIG_NFC_ST95HF=y
CONFIG_PSAMPLE=y
CONFIG_NET_IFE=y
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
# CONFIG_NET_DEVLINK is not set
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=y
# CONFIG_HOTPLUG_PCI_CPCI_GENERIC is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_EP is not set
CONFIG_PCI_FTPCI100=y
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=y
CONFIG_PCIE_DW_HOST=y
CONFIG_PCIE_DW_PLAT=y
CONFIG_PCIE_DW_PLAT_HOST=y
# CONFIG_PCIE_DW_PLAT_EP is not set
# CONFIG_PCI_MESON is not set

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=y
CONFIG_YENTA_O2=y
# CONFIG_YENTA_RICOH is not set
CONFIG_YENTA_TI=y
# CONFIG_YENTA_ENE_TUNE is not set
# CONFIG_YENTA_TOSHIBA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# Partition parsers
#
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set

#
# User Modules And Translation Layers
#
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=y

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_AMD76XROM=y
# CONFIG_MTD_ICHXROM is not set
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
CONFIG_MTD_PCI=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_DATAFLASH=y
CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
# CONFIG_MTD_DATAFLASH_OTP is not set
CONFIG_MTD_MCHP23K256=y
CONFIG_MTD_SST25L=y
CONFIG_MTD_SLRAM=y
CONFIG_MTD_PHRAM=y
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
# CONFIG_MTD_NAND is not set
CONFIG_MTD_SPI_NAND=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=y
# CONFIG_XEN_BLKDEV_BACKEND is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
# CONFIG_AD525X_DPOT is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=y
# CONFIG_SGI_IOC4 is not set
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_USB_SWITCH_FSA9480 is not set
CONFIG_LATTICE_ECP3_CONFIG=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
CONFIG_EEPROM_LEGACY=y
CONFIG_EEPROM_MAX6875=y
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_93XX46=y
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=y
CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_INTEL_MEI_HDCP=y
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
CONFIG_SCIF=y

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#
# CONFIG_MIC_COSM is not set

#
# VOP Driver
#
# CONFIG_VOP is not set
CONFIG_GENWQE=y
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=0
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=y
# CONFIG_HABANA_AI is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
# CONFIG_SCSI is not set
# CONFIG_ATA is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
CONFIG_FIREWIRE_NOSY=y
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH_REG_DYNAMIC_USER_REG_HINTS is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH6KL is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT7603E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
CONFIG_RTL_CARDS=y
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_VIRT_WIFI is not set

#
# WiMAX Wireless Broadband devices
#

#
# Enable USB support to see WiMAX USB drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_XEN_NETDEV_BACKEND is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ADC=y
CONFIG_KEYBOARD_ADP5520=y
CONFIG_KEYBOARD_ADP5588=y
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
CONFIG_KEYBOARD_GPIO=y
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
# CONFIG_KEYBOARD_MCS is not set
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_KEYBOARD_OPENCORES=y
CONFIG_KEYBOARD_SAMSUNG=y
CONFIG_KEYBOARD_STOWAWAY=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_STMPE=y
CONFIG_KEYBOARD_OMAP4=y
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
CONFIG_KEYBOARD_XTKBD=y
CONFIG_KEYBOARD_CAP11XX=y
CONFIG_KEYBOARD_BCM=y
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
# CONFIG_MOUSE_PS2_BYD is not set
# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
# CONFIG_MOUSE_ELAN_I2C_I2C is not set
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_MOUSE_GPIO=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
CONFIG_JOYSTICK_GUILLEMOT=y
CONFIG_JOYSTICK_INTERACT=y
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_232 is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=y
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
CONFIG_JOYSTICK_GAMECON=y
CONFIG_JOYSTICK_TURBOGRAFX=y
# CONFIG_JOYSTICK_AS5011 is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_JOYSTICK_XPAD is not set
CONFIG_JOYSTICK_WALKERA0701=y
# CONFIG_JOYSTICK_PSXPAD_SPI is not set
# CONFIG_JOYSTICK_PXRC is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SPI=y
# CONFIG_RMI4_SMB is not set
# CONFIG_RMI4_F03 is not set
CONFIG_RMI4_2D_SENSOR=y
# CONFIG_RMI4_F11 is not set
CONFIG_RMI4_F12=y
# CONFIG_RMI4_F30 is not set
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
CONFIG_GAMEPORT_L4=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_GAMEPORT_FM801=y

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_VIRTIO_CONSOLE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set
# CONFIG_DEVPORT is not set
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=y
# CONFIG_RANDOM_TRUST_CPU is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_GPMUX is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
# CONFIG_I2C_ALI1563 is not set
CONFIG_I2C_ALI15X3=y
CONFIG_I2C_AMD756=y
CONFIG_I2C_AMD756_S4882=y
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=y
CONFIG_I2C_ISMT=y
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PCI=y
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_TAOS_EVM is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=y
CONFIG_I2C_FSI=y
# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_PCI=y
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
CONFIG_SPI_ROCKCHIP=y
CONFIG_SPI_SC18IS602=y
# CONFIG_SPI_SIFIVE is not set
CONFIG_SPI_MXIC=y
# CONFIG_SPI_XCOMM is not set
CONFIG_SPI_XILINX=y
CONFIG_SPI_ZYNQMP_GQSPI=y

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
CONFIG_PINCTRL_AMD=y
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
# CONFIG_PINCTRL_PALMAS is not set
CONFIG_PINCTRL_OCELOT=y
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
CONFIG_PINCTRL_MADERA=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=y
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=y
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=y
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_HLWD=y
CONFIG_GPIO_ICH=y
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=y

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_ADNP=y
CONFIG_GPIO_GW_PLD=y
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
# CONFIG_GPIO_MAX732X_IRQ is not set
# CONFIG_GPIO_PCA953X is not set
CONFIG_GPIO_PCF857X=y
CONFIG_GPIO_TPIC2810=y

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_ARIZONA=y
CONFIG_GPIO_BD9571MWV=y
CONFIG_GPIO_DA9052=y
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_JANZ_TTL=y
CONFIG_GPIO_KEMPLD=y
# CONFIG_GPIO_LP873X is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_PALMAS=y
CONFIG_GPIO_STMPE=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_WM831X=y
# CONFIG_GPIO_WM8350 is not set
CONFIG_GPIO_WM8994=y

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_ML_IOH is not set
CONFIG_GPIO_PCI_IDIO_16=y
# CONFIG_GPIO_PCIE_IDIO_24 is not set
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=y
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
CONFIG_GPIO_XRA1403=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=y
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
CONFIG_W1_SLAVE_DS2405=y
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2431=y
# CONFIG_W1_SLAVE_DS2433 is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
CONFIG_POWER_AVS=y
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=y
CONFIG_BATTERY_BQ27XXX=y
# CONFIG_BATTERY_BQ27XXX_I2C is not set
CONFIG_BATTERY_BQ27XXX_HDQ=y
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
# CONFIG_CHARGER_AXP20X is not set
# CONFIG_BATTERY_AXP20X is not set
CONFIG_AXP20X_POWER=y
CONFIG_AXP288_FUEL_GAUGE=y
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=y
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_MAX14577=y
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_CHARGER_RT9455=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7314=y
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
CONFIG_SENSORS_ADT7410=y
CONFIG_SENSORS_ADT7411=y
CONFIG_SENSORS_ADT7462=y
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
CONFIG_SENSORS_DA9052_ADC=y
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
CONFIG_SENSORS_FTSTEUTATES=y
CONFIG_SENSORS_GL518SM=y
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
CONFIG_SENSORS_GPIO_FAN=y
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
CONFIG_SENSORS_LTC4222=y
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=y
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=y
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31722 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
CONFIG_SENSORS_MLXREG_FAN=y
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_ADCXX=y
CONFIG_SENSORS_LM63=y
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
CONFIG_SENSORS_LM77=y
# CONFIG_SENSORS_LM78 is not set
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
CONFIG_SENSORS_LM95234=y
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=y
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
# CONFIG_SENSORS_OCC_P8_I2C is not set
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
# CONFIG_SENSORS_IR35221 is not set
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=y
# CONFIG_SENSORS_MAX20751 is not set
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
CONFIG_SENSORS_MAX8688=y
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=y
CONFIG_SENSORS_UCD9200=y
# CONFIG_SENSORS_ZL6100 is not set
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
# CONFIG_SENSORS_EMC6W201 is not set
CONFIG_SENSORS_SMSC47M1=y
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=y
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=y
CONFIG_SENSORS_VT1211=y
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
# CONFIG_SENSORS_WM831X is not set
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CLOCK_THERMAL=y
CONFIG_DEVFREQ_THERMAL=y
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
CONFIG_INTEL_PCH_THERMAL=y
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
CONFIG_MENZ069_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=y
CONFIG_WM8350_WATCHDOG=y
CONFIG_XILINX_WATCHDOG=y
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_MLX_WDT=y
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_RN5T618_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=y
CONFIG_ALIM7101_WDT=y
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
CONFIG_SC1200_WDT=y
CONFIG_PC87413_WDT=y
CONFIG_NV_TCO=y
CONFIG_60XX_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_INTEL_MEI_WDT=y
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=y

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=y
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC is not set
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=y
# CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=y
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
# CONFIG_MFD_CROS_EC is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_MADERA_SPI is not set
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
# CONFIG_MFD_CS47L90 is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_SPI=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
# CONFIG_MFD_MENF21BMC is not set
CONFIG_EZX_PCAP=y
# CONFIG_MFD_CPCAP is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
CONFIG_MFD_RN5T618=y
# CONFIG_MFD_SEC_CORE is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SMSC=y
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
CONFIG_MFD_STMPE=y

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=y
CONFIG_STMPE_SPI=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
CONFIG_MFD_TPS80031=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_LOCHNAGAR is not set
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
CONFIG_MFD_CS47L24=y
# CONFIG_MFD_WM5102 is not set
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_STPMIC1=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
CONFIG_REGULATOR_88PM800=y
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
# CONFIG_REGULATOR_AB3100 is not set
# CONFIG_REGULATOR_ARIZONA_LDO1 is not set
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
# CONFIG_REGULATOR_AS3711 is not set
CONFIG_REGULATOR_AS3722=y
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_BD9571MWV=y
# CONFIG_REGULATOR_DA903X is not set
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP873X is not set
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LTC3589=y
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8925=y
CONFIG_REGULATOR_MAX8952=y
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MC13XXX_CORE=y
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=y
# CONFIG_REGULATOR_MCP16502 is not set
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PCAP=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
# CONFIG_REGULATOR_PV88090 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_RN5T618=y
# CONFIG_REGULATOR_STPMIC1 is not set
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
# CONFIG_REGULATOR_TPS65023 is not set
CONFIG_REGULATOR_TPS6507X=y
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_TPS6524X=y
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS80031=y
CONFIG_REGULATOR_VCTRL=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_WM8400=y
# CONFIG_REGULATOR_WM8994 is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=m
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
# CONFIG_IR_RC5_DECODER is not set
# CONFIG_IR_RC6_DECODER is not set
CONFIG_IR_JVC_DECODER=m
# CONFIG_IR_SONY_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_XMP_DECODER=m
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_RCMM_DECODER=m
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_SPI is not set
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_WINBOND_CIR is not set
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_GPIO_CIR=m
# CONFIG_IR_GPIO_TX is not set
# CONFIG_IR_PWM_TX is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=y

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
# CONFIG_MEDIA_CEC_SUPPORT is not set
# CONFIG_MEDIA_CONTROLLER is not set
CONFIG_VIDEO_DEV=y
CONFIG_VIDEO_V4L2=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FWNODE=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=y
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=y
CONFIG_DVB_MAX_ADAPTERS=16
# CONFIG_DVB_DYNAMIC_MINORS is not set
CONFIG_DVB_DEMUX_SECTION_LOSS_LOG=y
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_IVTV is not set
CONFIG_VIDEO_HEXIUM_GEMINI=y
CONFIG_VIDEO_HEXIUM_ORION=y
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
# CONFIG_VIDEO_CX23885 is not set
CONFIG_VIDEO_CX25821=y
# CONFIG_VIDEO_CX25821_ALSA is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
# CONFIG_VIDEO_CX88_ENABLE_VP3054 is not set
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
# CONFIG_DVB_BT8XX is not set
CONFIG_VIDEO_SAA7134=y
CONFIG_VIDEO_SAA7134_ALSA=y
CONFIG_VIDEO_SAA7134_DVB=y
# CONFIG_VIDEO_SAA7164 is not set

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110=y
CONFIG_DVB_AV7110_OSD=y
# CONFIG_DVB_BUDGET_CORE is not set
CONFIG_DVB_B2C2_FLEXCOP_PCI=y
CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG=y
# CONFIG_DVB_PLUTO2 is not set
CONFIG_DVB_DM1105=m
# CONFIG_DVB_PT1 is not set
CONFIG_DVB_PT3=y
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
# CONFIG_DVB_NGENE is not set
CONFIG_DVB_DDBRIDGE=y
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_SMIPCIE=m
CONFIG_DVB_NETUP_UNIDVB=y
CONFIG_DVB_PLATFORM_DRIVERS=y
CONFIG_SDR_PLATFORM_DRIVERS=y

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
CONFIG_RADIO_SI470X=y
# CONFIG_I2C_SI470X is not set
CONFIG_RADIO_SI4713=y
# CONFIG_PLATFORM_SI4713 is not set
CONFIG_I2C_SI4713=y
CONFIG_RADIO_SI476X=y
CONFIG_RADIO_MAXIRADIO=y
# CONFIG_RADIO_TEA5764 is not set
CONFIG_RADIO_SAA7706H=y
CONFIG_RADIO_TEF6862=y
CONFIG_RADIO_WL1273=y

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEOBUF2_DVB=y
CONFIG_DVB_B2C2_FLEXCOP=y
CONFIG_DVB_B2C2_FLEXCOP_DEBUG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_SMS_SIANO_MDTV=m
# CONFIG_SMS_SIANO_RC is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_MEDIA_ATTACH=y
# CONFIG_VIDEO_IR_I2C is not set

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TEA6415C=y
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
CONFIG_VIDEO_VP27SMPX=y
CONFIG_VIDEO_SONY_BTF_MPX=y

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=y
CONFIG_VIDEO_BT819=y
# CONFIG_VIDEO_BT856 is not set
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
CONFIG_VIDEO_ML86V7667=y
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_TVP5150=y
CONFIG_VIDEO_TVP7002=y
CONFIG_VIDEO_TW2804=y
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
# CONFIG_VIDEO_CX25840 is not set

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
CONFIG_VIDEO_AK881X=y
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_MT9M111 is not set

#
# Flash devices
#

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=y

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set

#
# SPI helper chips
#

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=y
CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_SIMPLE is not set
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT20XX=y
CONFIG_MEDIA_TUNER_MT2060=y
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
CONFIG_MEDIA_TUNER_QT1010=y
CONFIG_MEDIA_TUNER_XC2028=y
CONFIG_MEDIA_TUNER_XC5000=y
CONFIG_MEDIA_TUNER_XC4000=y
CONFIG_MEDIA_TUNER_MXL5005S=y
# CONFIG_MEDIA_TUNER_MXL5007T is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=y
CONFIG_MEDIA_TUNER_E4000=y
CONFIG_MEDIA_TUNER_FC2580=y
CONFIG_MEDIA_TUNER_M88RS6000T=y
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=y
CONFIG_MEDIA_TUNER_QM1D1C0042=y
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
# CONFIG_DVB_STB0899 is not set
# CONFIG_DVB_STB6100 is not set
CONFIG_DVB_STV090x=y
CONFIG_DVB_STV0910=y
CONFIG_DVB_STV6110x=y
# CONFIG_DVB_STV6111 is not set
CONFIG_DVB_MXL5XX=y
CONFIG_DVB_M88DS3103=y

#
# Multistandard (cable + terrestrial) frontends
#
# CONFIG_DVB_DRXK is not set
CONFIG_DVB_TDA18271C2DD=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_MN88472=y
# CONFIG_DVB_MN88473 is not set

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=y
CONFIG_DVB_CX24123=y
CONFIG_DVB_MT312=y
CONFIG_DVB_ZL10036=y
CONFIG_DVB_ZL10039=y
CONFIG_DVB_S5H1420=y
CONFIG_DVB_STV0288=y
# CONFIG_DVB_STB6000 is not set
# CONFIG_DVB_STV0299 is not set
CONFIG_DVB_STV6110=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_TDA8083=y
# CONFIG_DVB_TDA10086 is not set
CONFIG_DVB_TDA8261=y
# CONFIG_DVB_VES1X93 is not set
CONFIG_DVB_TUNER_ITD1000=y
CONFIG_DVB_TUNER_CX24113=y
CONFIG_DVB_TDA826X=y
# CONFIG_DVB_TUA6100 is not set
CONFIG_DVB_CX24116=y
# CONFIG_DVB_CX24117 is not set
CONFIG_DVB_CX24120=y
# CONFIG_DVB_SI21XX is not set
# CONFIG_DVB_TS2020 is not set
CONFIG_DVB_DS3000=y
# CONFIG_DVB_MB86A16 is not set
# CONFIG_DVB_TDA10071 is not set

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=y
CONFIG_DVB_SP887X=y
CONFIG_DVB_CX22700=y
# CONFIG_DVB_CX22702 is not set
# CONFIG_DVB_S5H1432 is not set
# CONFIG_DVB_DRXD is not set
# CONFIG_DVB_L64781 is not set
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_NXT6000=y
CONFIG_DVB_MT352=y
# CONFIG_DVB_ZL10353 is not set
CONFIG_DVB_DIB3000MB=y
# CONFIG_DVB_DIB3000MC is not set
CONFIG_DVB_DIB7000M=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_DIB9000=y
CONFIG_DVB_TDA10048=y
# CONFIG_DVB_AF9013 is not set
CONFIG_DVB_EC100=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_CXD2820R=y
# CONFIG_DVB_CXD2841ER is not set
CONFIG_DVB_RTL2830=y
# CONFIG_DVB_RTL2832 is not set
CONFIG_DVB_SI2168=y
CONFIG_DVB_ZD1301_DEMOD=y
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
# CONFIG_DVB_VES1820 is not set
CONFIG_DVB_TDA10021=y
# CONFIG_DVB_TDA10023 is not set
CONFIG_DVB_STV0297=y

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
# CONFIG_DVB_NXT200X is not set
CONFIG_DVB_OR51211=y
CONFIG_DVB_OR51132=y
# CONFIG_DVB_BCM3510 is not set
# CONFIG_DVB_LGDT330X is not set
# CONFIG_DVB_LGDT3305 is not set
# CONFIG_DVB_LGDT3306A is not set
CONFIG_DVB_LG2160=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_AU8522=y
CONFIG_DVB_AU8522_DTV=y
# CONFIG_DVB_AU8522_V4L is not set
CONFIG_DVB_S5H1411=y

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=y
CONFIG_DVB_DIB8000=y
# CONFIG_DVB_MB86A20S is not set

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=y
CONFIG_DVB_MN88443X=y

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_TUNER_DIB0090=y

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=y
CONFIG_DVB_LNBH25=y
CONFIG_DVB_LNBH29=y
CONFIG_DVB_LNBP21=y
CONFIG_DVB_LNBP22=y
# CONFIG_DVB_ISL6405 is not set
CONFIG_DVB_ISL6421=y
# CONFIG_DVB_ISL6423 is not set
CONFIG_DVB_A8293=y
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=y
# CONFIG_DVB_ATBM8830 is not set
CONFIG_DVB_TDA665x=y
# CONFIG_DVB_IX2505V is not set
CONFIG_DVB_M88RS2000=y
CONFIG_DVB_AF9033=y
CONFIG_DVB_HORUS3A=y
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=y
CONFIG_DVB_SP2=y

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=y

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
# CONFIG_VGA_ARB is not set
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_VM=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
CONFIG_DRM_I2C_NXP_TDA998X=y
CONFIG_DRM_I2C_NXP_TDA9950=y

#
# ARM devices
#
CONFIG_DRM_KOMEDA=y
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_ALPHA_SUPPORT=y
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
CONFIG_DRM_I915_USERPTR=y
# CONFIG_DRM_I915_GVT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
CONFIG_DRM_I915_DEBUG=y
CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS=y
CONFIG_DRM_I915_SW_FENCE_CHECK_DAG=y
# CONFIG_DRM_I915_DEBUG_GUC is not set
CONFIG_DRM_I915_SELFTEST=y
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
CONFIG_DRM_I915_DEBUG_RUNTIME_PM=y
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
CONFIG_DRM_GMA500=y
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_LVDS=y
CONFIG_DRM_QXL=y
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=y
# CONFIG_DRM_PANEL_LVDS is not set
CONFIG_DRM_PANEL_SIMPLE=y
CONFIG_DRM_PANEL_ILITEK_IL9322=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
CONFIG_DRM_PANEL_SAMSUNG_LD9040=y
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=y
# CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=y
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
CONFIG_DRM_PANEL_SITRONIX_ST7701=y
CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
CONFIG_DRM_PANEL_TPO_TPG110=y
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# CONFIG_DRM_CDNS_DSI is not set
CONFIG_DRM_DUMB_VGA_DAC=y
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
CONFIG_DRM_SIL_SII8620=m
CONFIG_DRM_SII902X=y
# CONFIG_DRM_SII9234 is not set
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358764=y
# CONFIG_DRM_TOSHIBA_TC358767 is not set
CONFIG_DRM_TI_TFP410=y
CONFIG_DRM_TI_SN65DSI86=y
# CONFIG_DRM_I2C_ADV7511 is not set
CONFIG_DRM_DW_HDMI=y
CONFIG_DRM_DW_HDMI_AHB_AUDIO=y
CONFIG_DRM_DW_HDMI_I2S_AUDIO=y
# CONFIG_DRM_DW_HDMI_CEC is not set
CONFIG_DRM_ETNAVIV=y
# CONFIG_DRM_ETNAVIV_THERMAL is not set
CONFIG_DRM_ARCPGU=y
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_MXSFB is not set
# CONFIG_DRM_TINYDRM is not set
CONFIG_DRM_XEN=y
# CONFIG_DRM_XEN_FRONTEND is not set
CONFIG_DRM_LEGACY=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
CONFIG_DRM_VIA=y
CONFIG_DRM_SAVAGE=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
CONFIG_FB_PM2=y
# CONFIG_FB_PM2_FIFO_DISCONNECT is not set
CONFIG_FB_CYBER2000=y
# CONFIG_FB_CYBER2000_DDC is not set
CONFIG_FB_ARC=y
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
# CONFIG_FB_EFI is not set
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
# CONFIG_FB_NVIDIA_I2C is not set
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
# CONFIG_FB_RIVA_DEBUG is not set
# CONFIG_FB_RIVA_BACKLIGHT is not set
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_ATY_GENERIC_LCD=y
CONFIG_FB_ATY_GX=y
# CONFIG_FB_ATY_BACKLIGHT is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
CONFIG_FB_SAVAGE_I2C=y
# CONFIG_FB_SAVAGE_ACCEL is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
CONFIG_FB_VT8623=y
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
CONFIG_FB_PM3=y
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_SM501=y
CONFIG_FB_IBM_GXT4500=y
CONFIG_FB_VIRTUAL=y
# CONFIG_XEN_FBDEV_FRONTEND is not set
CONFIG_FB_METRONOME=y
CONFIG_FB_MB862XX=y
CONFIG_FB_MB862XX_PCI_GDC=y
CONFIG_FB_MB862XX_I2C=y
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=y
CONFIG_FB_SM712=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_PWM=y
CONFIG_BACKLIGHT_DA903X=y
# CONFIG_BACKLIGHT_DA9052 is not set
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
# CONFIG_BACKLIGHT_PM8941_WLED is not set
CONFIG_BACKLIGHT_SAHARA=y
# CONFIG_BACKLIGHT_WM831X is not set
CONFIG_BACKLIGHT_ADP5520=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
CONFIG_BACKLIGHT_LM3630A=y
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_AS3711 is not set
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=y
CONFIG_BACKLIGHT_BD6107=y
CONFIG_BACKLIGHT_ARCXCNN=y
CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y
# CONFIG_LOGO is not set
CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_PCM_ELD=y
CONFIG_SND_PCM_IEC958=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
# CONFIG_SND_PCM_XRUN_DEBUG is not set
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
# CONFIG_SND_SEQUENCER_OSS is not set
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
CONFIG_SND_VIRMIDI=y
CONFIG_SND_MTPAV=y
CONFIG_SND_MTS64=y
CONFIG_SND_SERIAL_U16550=y
CONFIG_SND_MPU401=y
CONFIG_SND_PORTMAN2X4=y
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_SPI=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_SOC_AMD_ACP3x=y
# CONFIG_SND_ATMEL_SOC is not set
CONFIG_SND_DESIGNWARE_I2S=y
# CONFIG_SND_DESIGNWARE_PCM is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=y
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_SSI=y
CONFIG_SND_SOC_FSL_SPDIF=y
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_I2S_HI6210_I2S=y
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=y
# CONFIG_SND_SOC_IMG_I2S_OUT is not set
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
# CONFIG_SND_SOC_IMG_SPDIF_IN is not set
CONFIG_SND_SOC_IMG_SPDIF_OUT=y
# CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC is not set
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set

#
# STMicroelectronics STM32 SOC audio support
#
CONFIG_SND_SOC_XILINX_I2S=y
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=y
CONFIG_SND_SOC_XILINX_SPDIF=y
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=y
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_AK4104=y
CONFIG_SND_SOC_AK4118=y
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4554=y
CONFIG_SND_SOC_AK4613=y
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
CONFIG_SND_SOC_BD28623=y
CONFIG_SND_SOC_BT_SCO=y
CONFIG_SND_SOC_CS35L32=y
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
CONFIG_SND_SOC_CS42L42=y
CONFIG_SND_SOC_CS42L51=y
CONFIG_SND_SOC_CS42L51_I2C=y
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=y
CONFIG_SND_SOC_CS42L73=y
CONFIG_SND_SOC_CS4265=y
# CONFIG_SND_SOC_CS4270 is not set
CONFIG_SND_SOC_CS4271=y
CONFIG_SND_SOC_CS4271_I2C=y
CONFIG_SND_SOC_CS4271_SPI=y
CONFIG_SND_SOC_CS42XX8=y
CONFIG_SND_SOC_CS42XX8_I2C=y
CONFIG_SND_SOC_CS43130=y
CONFIG_SND_SOC_CS4341=y
CONFIG_SND_SOC_CS4349=y
# CONFIG_SND_SOC_CS53L30 is not set
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_HDMI_CODEC=y
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_INNO_RK3036=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98504=y
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX9860=y
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=y
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
# CONFIG_SND_SOC_PCM186X_SPI is not set
CONFIG_SND_SOC_PCM3060=y
CONFIG_SND_SOC_PCM3060_I2C=y
CONFIG_SND_SOC_PCM3060_SPI=y
CONFIG_SND_SOC_PCM3168A=y
CONFIG_SND_SOC_PCM3168A_I2C=y
CONFIG_SND_SOC_PCM3168A_SPI=y
CONFIG_SND_SOC_PCM512x=y
CONFIG_SND_SOC_PCM512x_I2C=y
CONFIG_SND_SOC_PCM512x_SPI=y
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_SGTL5000=y
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=y
CONFIG_SND_SOC_SPDIF=y
CONFIG_SND_SOC_SSM2305=y
CONFIG_SND_SOC_SSM2602=y
CONFIG_SND_SOC_SSM2602_SPI=y
CONFIG_SND_SOC_SSM2602_I2C=y
# CONFIG_SND_SOC_SSM4567 is not set
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
CONFIG_SND_SOC_TLV320AIC31XX=y
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=y
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WM8510=y
# CONFIG_SND_SOC_WM8523 is not set
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
CONFIG_SND_SOC_WM8711=y
CONFIG_SND_SOC_WM8728=y
CONFIG_SND_SOC_WM8731=y
CONFIG_SND_SOC_WM8737=y
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=y
# CONFIG_SND_SOC_WM8770 is not set
CONFIG_SND_SOC_WM8776=y
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
CONFIG_SND_SOC_WM8804_I2C=y
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
CONFIG_SND_SOC_WM8904=y
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_ZX_AUD96P22=y
CONFIG_SND_SOC_MAX9759=y
CONFIG_SND_SOC_MT6351=y
CONFIG_SND_SOC_MT6358=y
CONFIG_SND_SOC_NAU8540=y
# CONFIG_SND_SOC_NAU8810 is not set
CONFIG_SND_SOC_NAU8822=y
CONFIG_SND_SOC_NAU8824=y
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SIMPLE_CARD_UTILS=y
# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_AUDIO_GRAPH_CARD=y
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=y
CONFIG_SND_XEN_FRONTEND=y

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=y
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
# CONFIG_HID_APPLE is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_CHERRY is not set
CONFIG_HID_CHICONY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_PRODIKEYS=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_DJ is not set
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
CONFIG_LOGIRUMBLEPAD2_FF=y
# CONFIG_LOGIG940_FF is not set
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SAMSUNG=y
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=y
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=y
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
CONFIG_HID_THRUSTMASTER=y
CONFIG_THRUSTMASTER_FF=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
CONFIG_PWRSEQ_EMMC=y
CONFIG_PWRSEQ_SIMPLE=y
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
CONFIG_MMC_DEBUG=y
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_SPI=y
# CONFIG_MMC_CB710 is not set
CONFIG_MMC_VIA_SDMMC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_AS3645A=y
CONFIG_LEDS_BCM6328=y
CONFIG_LEDS_BCM6358=y
# CONFIG_LEDS_CR0014114 is not set
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_LM3601X is not set
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_PCA9532=y
# CONFIG_LEDS_PCA9532_GPIO is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=y
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA955X_GPIO is not set
CONFIG_LEDS_PCA963X=y
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_ADP5520=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_KTD2692=y
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=y
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
# CONFIG_RTC_DRV_AS3722 is not set
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_RS5C372=y
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
CONFIG_RTC_DRV_ISL12026=y
# CONFIG_RTC_DRV_X1205 is not set
CONFIG_RTC_DRV_PCF8523=y
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
CONFIG_RTC_DRV_M41T80=y
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_PALMAS=y
CONFIG_RTC_DRV_TPS6586X=y
CONFIG_RTC_DRV_TPS80031=y
CONFIG_RTC_DRV_S35390A=y
CONFIG_RTC_DRV_FM3130=y
CONFIG_RTC_DRV_RX8010=y
CONFIG_RTC_DRV_RX8581=y
# CONFIG_RTC_DRV_RX8025 is not set
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3028 is not set
CONFIG_RTC_DRV_RV8803=y
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=y
# CONFIG_RTC_DRV_M41T94 is not set
CONFIG_RTC_DRV_DS1302=y
CONFIG_RTC_DRV_DS1305=y
CONFIG_RTC_DRV_DS1343=y
CONFIG_RTC_DRV_DS1347=y
CONFIG_RTC_DRV_DS1390=y
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=y
CONFIG_RTC_DRV_RX6110=y
CONFIG_RTC_DRV_RS5C348=y
CONFIG_RTC_DRV_MAX6902=y
CONFIG_RTC_DRV_PCF2123=y
CONFIG_RTC_DRV_MCP795=y
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=y
CONFIG_RTC_DRV_DS3232_HWMON=y
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
# CONFIG_RTC_DRV_DS1553 is not set
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
CONFIG_RTC_DRV_DS1689=y
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9052=y
# CONFIG_RTC_DRV_DA9055 is not set
# CONFIG_RTC_DRV_DA9063 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_AB3100=y
CONFIG_RTC_DRV_ZYNQMP=y

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_PCAP=y
# CONFIG_RTC_DRV_MC13XXX is not set
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_MT6397=y
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
# CONFIG_IMG_ASCII_LCD is not set
CONFIG_HT16K33=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
CONFIG_CHARLCD_BL_ON=y
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
CONFIG_CHARLCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
# CONFIG_UIO_PCI_GENERIC is not set
CONFIG_UIO_NETX=y
CONFIG_UIO_PRUSS=y
CONFIG_UIO_MF624=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_BALLOON is not set
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=y
CONFIG_XEN_BACKEND=y
# CONFIG_XENFS is not set
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
CONFIG_XEN_GRANT_DEV_ALLOC=y
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_TMEM=m
CONFIG_XEN_PCIDEV_BACKEND=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_FRONT_PGDIR_SHBUF=y
CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8822BE is not set
# CONFIG_VT6655 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set

#
# Analog to digital converters
#
CONFIG_AD7780=y
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CARVEOUT_HEAP is not set
# CONFIG_ION_CHUNK_HEAP is not set
# CONFIG_ION_CMA_HEAP is not set
# CONFIG_STAGING_BOARD is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
CONFIG_GREYBUS=y
# CONFIG_GREYBUS_AUDIO is not set
# CONFIG_GREYBUS_BOOTROM is not set
# CONFIG_GREYBUS_FIRMWARE is not set
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
# CONFIG_GREYBUS_LOG is not set
# CONFIG_GREYBUS_LOOPBACK is not set
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# CONFIG_XIL_AXIS_FIFO is not set
# CONFIG_EROFS_FS is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACER_WIRELESS is not set
# CONFIG_ACERHDF is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_DCDBAS=y
# CONFIG_DELL_SMBIOS is not set
# CONFIG_DELL_SMO8800 is not set
CONFIG_DELL_RBU=y
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_HP_WIRELESS is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_THINKPAD_ACPI is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_EEEPC_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_ACPI_WMI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
CONFIG_IBM_RTL=y
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_MLX_PLATFORM is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_INTEL_ATOMISP2_PM=y
CONFIG_PCENGINES_APU2=y
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
# CONFIG_MLXREG_IO is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=y
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_SI570 is not set
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
# CONFIG_COMMON_CLK_PALMAS is not set
CONFIG_COMMON_CLK_PWM=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_DEBUGFS=y
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_VIRTIO=y
# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# NXP/Freescale QorIQ SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_ARIZONA is not set
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_PALMAS=y
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16209=y
CONFIG_ADXL345=y
# CONFIG_ADXL345_I2C is not set
CONFIG_ADXL345_SPI=y
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA220=y
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=y
# CONFIG_DA311 is not set
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
CONFIG_DMARD10=y
# CONFIG_IIO_CROS_EC_ACCEL_LEGACY is not set
CONFIG_KXSD9=y
CONFIG_KXSD9_SPI=y
# CONFIG_KXSD9_I2C is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
# CONFIG_MMA9551 is not set
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_STK8312=y
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7124=y
CONFIG_AD7266=y
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
CONFIG_AD7476=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
# CONFIG_AD7606_IFACE_SPI is not set
CONFIG_AD7766=y
# CONFIG_AD7768_1 is not set
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
CONFIG_CC10001_ADC=y
CONFIG_ENVELOPE_DETECTOR=y
CONFIG_HI8435=y
CONFIG_HX711=y
CONFIG_INA2XX_ADC=y
CONFIG_LTC2471=y
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1027=y
# CONFIG_MAX11100 is not set
CONFIG_MAX1118=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP320X is not set
CONFIG_MCP3422=y
# CONFIG_MCP3911 is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_PALMAS_GPADC=y
CONFIG_SD_ADC_MODULATOR=y
# CONFIG_STMPE_ADC is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_ADS124S08=y
CONFIG_TI_AM335X_ADC=y
CONFIG_TI_TLC4541=y
CONFIG_VF610_ADC=y

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y

#
# Amplifiers
#
CONFIG_AD8366=y

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
# CONFIG_IAQCORE is not set
CONFIG_SPS30=y
CONFIG_VZ89X=y

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Counters
#

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=y
CONFIG_AD5380=y
# CONFIG_AD5421 is not set
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
# CONFIG_AD5592R is not set
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
CONFIG_LTC1660=y
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=y
CONFIG_AD5758=y
CONFIG_AD5761=y
CONFIG_AD5764=y
CONFIG_AD5791=y
CONFIG_AD7303=y
CONFIG_CIO_DAC=y
CONFIG_AD8801=y
CONFIG_DPOT_DAC=y
CONFIG_DS4424=y
CONFIG_M62332=y
CONFIG_MAX517=y
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=y
CONFIG_TI_DAC082S085=y
# CONFIG_TI_DAC5571 is not set
CONFIG_TI_DAC7311=y
CONFIG_TI_DAC7612=y
CONFIG_VF610_DAC=y

#
# IIO dummy driver
#
CONFIG_IIO_SIMPLE_DUMMY=y
# CONFIG_IIO_SIMPLE_DUMMY_EVENTS is not set
# CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
CONFIG_AFE4404=y
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16480=y
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
CONFIG_BMI160_SPI=y
CONFIG_KMX61=y
CONFIG_INV_MPU6050_IIO=y
# CONFIG_INV_MPU6050_I2C is not set
CONFIG_INV_MPU6050_SPI=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
# CONFIG_AL3320A is not set
CONFIG_APDS9300=y
CONFIG_APDS9960=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
CONFIG_CM3323=y
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
CONFIG_GP2AP020A00F=y
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=y
CONFIG_ISL29125=y
# CONFIG_JSA1212 is not set
CONFIG_RPR0521=y
CONFIG_LTR501=y
# CONFIG_LV0104CS is not set
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
# CONFIG_SI1133 is not set
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
CONFIG_TCS3472=y
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=y

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
# CONFIG_BMC150_MAGN_I2C is not set
CONFIG_BMC150_MAGN_SPI=y
CONFIG_MAG3110=y
# CONFIG_MMC35240 is not set
CONFIG_IIO_ST_MAGN_3AXIS=y
CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
# CONFIG_SENSORS_HMC5843_SPI is not set
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y

#
# Multiplexers
#
CONFIG_IIO_MUX=y

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_SYSFS_TRIGGER=y

#
# Digital potentiometers
#
CONFIG_AD5272=y
# CONFIG_DS1803 is not set
CONFIG_MAX5481=y
CONFIG_MAX5487=y
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=y
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set

#
# Digital potentiostats
#
CONFIG_LMP91000=y

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_IIO_ST_PRESS_SPI=y
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=y
CONFIG_SRF04=y
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
CONFIG_VL53L0X_I2C=y

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
CONFIG_AD2S1200=y

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
CONFIG_NTB=y
CONFIG_NTB_AMD=y
CONFIG_NTB_IDT=y
CONFIG_NTB_INTEL=y
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
CONFIG_NTB_TRANSPORT=y
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
# CONFIG_PWM_FSL_FTM is not set
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_STMPE=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_MADERA_IRQ=y
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_BCM_KONA_USB2_PHY=y
# CONFIG_PHY_CADENCE_DP is not set
# CONFIG_PHY_CADENCE_DPHY is not set
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_MAPPHONE_MDM6600 is not set
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL=y
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
CONFIG_MCB_PCI=y
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=y
CONFIG_INTEL_TH_DEBUG=y
CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
# CONFIG_FPGA_MGR_ALTERA_PS_SPI is not set
CONFIG_FPGA_MGR_ALTERA_CVP=y
# CONFIG_FPGA_MGR_XILINX_SPI is not set
CONFIG_FPGA_MGR_ICE40_SPI=y
# CONFIG_FPGA_MGR_MACHXO2_SPI is not set
CONFIG_FPGA_BRIDGE=y
# CONFIG_ALTERA_FREEZE_BRIDGE is not set
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_FME is not set
# CONFIG_FPGA_DFL_AFU is not set
CONFIG_FPGA_DFL_PCI=y
CONFIG_FSI=y
# CONFIG_FSI_NEW_DEV_NODE is not set
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
# CONFIG_FSI_SCOM is not set
# CONFIG_FSI_SBEFIFO is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
# CONFIG_MUX_ADG792A is not set
CONFIG_MUX_ADGS1408=y
CONFIG_MUX_GPIO=y
CONFIG_MUX_MMIO=y
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
# CONFIG_CACHEFILES is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=m
CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
CONFIG_ECRYPT_FS=y
# CONFIG_ECRYPT_FS_MESSAGING is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_UBIFS_FS=y
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=y
CONFIG_UBIFS_FS_ZLIB=y
# CONFIG_UBIFS_ATIME_SUPPORT is not set
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
CONFIG_UBIFS_FS_AUTHENTICATION=y
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=y
# CONFIG_ROMFS_BACKED_BY_BLOCK is not set
CONFIG_ROMFS_BACKED_BY_MTD=y
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_MTD=y
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4hc"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_FTRACE=y
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"
CONFIG_XOR_BLOCKS=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_AEGIS128=y
# CONFIG_CRYPTO_AEGIS128L is not set
# CONFIG_CRYPTO_AEGIS256 is not set
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
# CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2 is not set
# CONFIG_CRYPTO_AEGIS256_AESNI_SSE2 is not set
# CONFIG_CRYPTO_MORUS640 is not set
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280 is not set
# CONFIG_CRYPTO_MORUS1280_SSE2 is not set
# CONFIG_CRYPTO_MORUS1280_AVX2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=y
# CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=y
# CONFIG_CRYPTO_KHAZAD is not set
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
CONFIG_SYSTEM_EXTRA_CERTIFICATE=y
CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE=4096
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_BITREVERSE=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_PRIME_NUMBERS=y
CONFIG_STRING_SELFTEST=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
# CONFIG_DEBUG_OBJECTS_FREE is not set
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
CONFIG_DEBUG_OBJECTS_WORK=y
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_VMACACHE=y
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
# CONFIG_RCU_PERF_TEST is not set
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
CONFIG_RCU_EQS_DEBUG=y
CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_PREEMPTIRQ_EVENTS=y
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
# CONFIG_DYNAMIC_FTRACE is not set
CONFIG_FUNCTION_PROFILER=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
CONFIG_TRACING_EVENTS_GPIO=y
# CONFIG_GCOV_PROFILE_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
CONFIG_MEMTEST=y
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_X86_PTDUMP_CORE=y
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=y
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
# CONFIG_UNWINDER_ORC is not set
CONFIG_UNWINDER_FRAME_POINTER=y

--eRJUXWYUKFXpoo3g--

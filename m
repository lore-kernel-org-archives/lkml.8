Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DE2C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE402072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCWPR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:17:29 -0400
Received: from foss.arm.com ([217.140.110.172]:50962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCWPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:17:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 365731FB;
        Mon, 23 Mar 2020 08:17:28 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A11E03F7C3;
        Mon, 23 Mar 2020 08:17:27 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:17:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: lockdep warning in sys_swapon
Message-ID: <20200323151725.gayvs5g6h5adwqkd@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I hit the following 2 warnings when running with LOCKDEP=y on arm64 platform
(juno-r2), running on v5.6-rc6

The 1st one is when I execute `swapon -a`. The 2nd one happens at boot. I have
/dev/sda2 as my swap in /etc/fstab

Note that I either hit 1 OR 2, but didn't hit both warnings at the same time,
yet at least.

/dev/sda2 is a usb flash drive, in case it matters somehow.


### WARNING 1 ###

# swapon -a
[ 1682.788988]
[ 1682.790503] =====================================
[ 1682.795226] WARNING: bad unlock balance detected!
[ 1682.799951] 5.6.0-rc6 #533 Not tainted
[ 1682.803714] -------------------------------------
[ 1682.808437] swapon/437 is trying to release lock (&sb->s_type->i_mutex_key) at:
[ 1682.815797] [<ffff80001030c07c>] __arm64_sys_swapon+0x3fc/0x1140
[ 1682.821828] but there are no more locks to release!
[ 1682.826724]
[ 1682.826724] other info that might help us debug this:
[ 1682.833280] no locks held by swapon/437.
[ 1682.837216]
[ 1682.837216] stack backtrace:
[ 1682.841596] CPU: 4 PID: 437 Comm: swapon Not tainted 5.6.0-rc6 #533
[ 1682.847889] Hardware name: ARM Juno development board (r2) (DT)
[ 1682.853834] Call trace:
[ 1682.856293]  dump_backtrace+0x0/0x1a8
[ 1682.859971]  show_stack+0x24/0x30
[ 1682.863302]  dump_stack+0xe8/0x150
[ 1682.866722]  print_unlock_imbalance_bug+0xe4/0xe8
[ 1682.871447]  lock_release+0x274/0x350
[ 1682.875128]  up_write+0x30/0x190
[ 1682.878371]  __arm64_sys_swapon+0x3fc/0x1140
[ 1682.882662]  el0_svc_common.constprop.2+0x7c/0x178
[ 1682.887475]  do_el0_svc+0x34/0xa0
[ 1682.890805]  el0_sync_handler+0x114/0x1d0
[ 1682.894832]  el0_sync+0x140/0x180
[ 1682.898233] ------------[ cut here ]------------
[ 1682.902936] DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff000971018270, owner = 0x0, curr 0xffff0009752fc680, list empty
[ 1682.921045] WARNING: CPU: 4 PID: 437 at kernel/locking/rwsem.c:1459 up_write+0x134/0x190
[ 1682.929203] Modules linked in:
[ 1682.932288] CPU: 4 PID: 437 Comm: swapon Not tainted 5.6.0-rc6 #533
[ 1682.938604] Hardware name: ARM Juno development board (r2) (DT)
[ 1682.944574] pstate: 60000005 (nZCv daif -PAN -UAO)
[ 1682.949407] pc : up_write+0x134/0x190
[ 1682.953102] lr : up_write+0x134/0x190
[ 1682.956793] sp : ffff800018e1bd30
[ 1682.960135] x29: ffff800018e1bd30 x28: ffff000970fb4000
[ 1682.965494] x27: ffff0009750bd000 x26: 00000000fffffff0
[ 1682.970852] x25: 0000000000000000 x24: fffffffffffffff0
[ 1682.976211] x23: ffff000971439200 x22: ffff80001323d000
[ 1682.981569] x21: ffff800013241000 x20: ffff80001030c07c
[ 1682.986927] x19: ffff000971018270 x18: ffffffffffffffff
[ 1682.992285] x17: 0000000000000000 x16: 0000000000000000
[ 1682.997643] x15: ffff80001323da88 x14: 0720072007200720
[ 1683.003002] x13: 0720072007200720 x12: 0720072007200720
[ 1683.008360] x11: 0720072007200720 x10: 0000000000000000
[ 1683.013718] x9 : ffff80001323da88 x8 : ffff800013267808
[ 1683.019076] x7 : ffff80001019f77c x6 : ffff800018e1b9f0
[ 1683.024434] x5 : 0000000000000001 x4 : 0000000000000001
[ 1683.029791] x3 : 775f041afc1e3200 x2 : ffff800013267860
[ 1683.035149] x1 : 775f041afc1e3200 x0 : 0000000000000000
[ 1683.040507] Call trace:
[ 1683.042977]  up_write+0x134/0x190
[ 1683.046323]  __arm64_sys_swapon+0x3fc/0x1140
[ 1683.050632]  el0_svc_common.constprop.2+0x7c/0x178
[ 1683.055464]  do_el0_svc+0x34/0xa0
[ 1683.058810]  el0_sync_handler+0x114/0x1d0
[ 1683.062854]  el0_sync+0x140/0x180
[ 1683.066196] irq event stamp: 1095
[ 1683.069543] hardirqs last  enabled at (1095): [<ffff80001191b724>] _raw_spin_unlock_irqrestore+0x7c/0x88
[ 1683.079104] hardirqs last disabled at (1094): [<ffff80001191b4c0>] _raw_spin_lock_irqsave+0x38/0x88
[ 1683.088226] softirqs last  enabled at (996): [<ffff8000100818a4>] __do_softirq+0x4bc/0x568
[ 1683.096562] softirqs last disabled at (985): [<ffff800010114064>] irq_exit+0x144/0x150
[ 1683.104545] ---[ end trace 737bf4f253f20ead ]---


### WARNING 2 ###


[   15.502583] Unable to find swap-space signature
[   15.507496]
[   15.508996] ======================================================
[   15.515202] WARNING: possible circular locking dependency detected
[   15.521411] 5.6.0-rc6 #533 Not tainted
[   15.525173] ------------------------------------------------------
[   15.531378] swapon/321 is trying to acquire lock:
[   15.536102] ffff000971020078 (&bdev->bd_mutex){+.+.}, at: blkdev_put+0x30/0x120
[   15.543460]
[   15.543460] but task is already holding lock:
[   15.549317] ffff0009710202d8 (&sb->s_type->i_mutex_key#7){+.+.}, at: __arm64_sys_swapon+0x2cc/0x1140
[   15.558505]
[   15.558505] which lock already depends on the new lock.
[   15.558505]
[   15.566719]
[   15.566719] the existing dependency chain (in reverse order) is:
[   15.574234]
[   15.574234] -> #1 (&sb->s_type->i_mutex_key#7){+.+.}:
[   15.580802]        down_write+0x50/0xb0
[   15.584656]        __blkdev_get+0x2a4/0x4f8
[   15.588859]        blkdev_get+0xfc/0x190
[   15.592800]        __device_add_disk+0x470/0x4b8
[   15.597437]        device_add_disk+0x38/0x48
[   15.601729]        sd_probe+0x350/0x488
[   15.605585]        really_probe+0x10c/0x358
[   15.609788]        driver_probe_device+0x5c/0x100
[   15.614514]        __device_attach_driver+0x98/0xb8
[   15.619415]        bus_for_each_drv+0x74/0xd8
[   15.623792]        __device_attach_async_helper+0xc8/0xf0
[   15.629217]        async_run_entry_fn+0x48/0x148
[   15.633857]        process_one_work+0x2a4/0x748
[   15.638407]        worker_thread+0x48/0x498
[   15.642609]        kthread+0x13c/0x140
[   15.646376]        ret_from_fork+0x10/0x18
[   15.650487]
[   15.650487] -> #0 (&bdev->bd_mutex){+.+.}:
[   15.656093]        __lock_acquire+0x1008/0x1450
[   15.660645]        lock_acquire+0xf8/0x280
[   15.664759]        __mutex_lock+0xac/0x920
[   15.668873]        mutex_lock_nested+0x3c/0x50
[   15.673337]        blkdev_put+0x30/0x120
[   15.677278]        __arm64_sys_swapon+0x5a8/0x1140
[   15.682093]        el0_svc_common.constprop.2+0x7c/0x178
[   15.687429]        do_el0_svc+0x34/0xa0
[   15.691282]        el0_sync_handler+0x114/0x1d0
[   15.695833]        el0_sync+0x140/0x180
[   15.699683]
[   15.699683] other info that might help us debug this:
[   15.699683]
[   15.707721]  Possible unsafe locking scenario:
[   15.707721]
[   15.713665]        CPU0                    CPU1
[   15.718213]        ----                    ----
[   15.722759]   lock(&sb->s_type->i_mutex_key#7);
[   15.727311]                                lock(&bdev->bd_mutex);
[   15.733430]                                lock(&sb->s_type->i_mutex_key#7);
[   15.740510]   lock(&bdev->bd_mutex);
[   15.744100]
[   15.744100]  *** DEADLOCK ***
[   15.744100]
[   15.750048] 1 lock held by swapon/321:
[   15.753810]  #0: ffff0009710202d8 (&sb->s_type->i_mutex_key#7){+.+.}, at: __arm64_sys_swapon+0x2cc/0x1140
[   15.763432]
[   15.763432] stack backtrace:
[   15.767811] CPU: 3 PID: 321 Comm: swapon Not tainted 5.6.0-rc6 #533
[   15.774104] Hardware name: ARM Juno development board (r2) (DT)
[   15.780048] Call trace:
[   15.782505]  dump_backtrace+0x0/0x1a8
[   15.786182]  show_stack+0x24/0x30
[   15.789512]  dump_stack+0xe8/0x150
[   15.792928]  print_circular_bug.isra.39+0x1b8/0x210
[   15.797826]  check_noncircular+0x178/0x1e0
[   15.801940]  __lock_acquire+0x1008/0x1450
[   15.805967]  lock_acquire+0xf8/0x280
[   15.809558]  __mutex_lock+0xac/0x920
[   15.813149]  mutex_lock_nested+0x3c/0x50
[   15.817089]  blkdev_put+0x30/0x120
[   15.820507]  __arm64_sys_swapon+0x5a8/0x1140
[   15.824797]  el0_svc_common.constprop.2+0x7c/0x178
[   15.829609]  do_el0_svc+0x34/0xa0
[   15.832938]  el0_sync_handler+0x114/0x1d0
[   15.836964]  el0_sync+0x140/0x180
swapon: /dev/sda2: Invalid argument



Thanks

--
Qais Yousef

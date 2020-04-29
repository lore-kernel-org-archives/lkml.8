Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82305C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F2214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2LhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:37:24 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58693 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726737AbgD2LhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:37:24 -0400
X-IronPort-AV: E=Sophos;i="5.73,331,1583164800"; 
   d="scan'208";a="90776289"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Apr 2020 19:37:15 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 6A44B4BCC88B;
        Wed, 29 Apr 2020 19:37:14 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Apr 2020 19:37:14 +0800
Message-ID: <5EA966E8.30901@cn.fujitsu.com>
Date:   Wed, 29 Apr 2020 19:37:12 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
References: <20200424223630.224895-1-joel@joelfernandes.org> <5EA80319.7080005@cn.fujitsu.com>
In-Reply-To: <5EA80319.7080005@cn.fujitsu.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 6A44B4BCC88B.AD039
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel, Steven

First of all, the previous dmesg may not be reliable and I often got the
following dmesg by inserting and remving preemptirq_delay_test in loops:
(btw: I think these dmesgs are caused by the same bug).
---------------------------------------------------
[  178.484520] ------------[ cut here ]------------
[  178.510058] refcount_t: addition on 0; use-after-free.
[  178.511663] WARNING: CPU: 0 PID: 2389 at lib/refcount.c:25
refcount_warn_saturate+0x9c/0x140
[  178.512266] Modules linked in: preemptirq_delay_test(-) sunrpc vfat
fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
ip_tables xfs libcrc32c virtio_net net_failover virtio_mmio failover
virtio_blk [last unloaded: preemptirq_delay_test]
[  178.514061] CPU: 0 PID: 2389 Comm: rmmod Not tainted 5.6.0-rc7+ #18
[  178.514389] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[  178.514988] pstate: 40000005 (nZcv daif -PAN -UAO)
[  178.515259] pc : refcount_warn_saturate+0x9c/0x140
[  178.515562] lr : refcount_warn_saturate+0x9c/0x140
[  178.515865] sp : fffffe001300fd70
[  178.516082] x29: fffffe001300fd70 x28: fffffc004533e380
[  178.516366] x27: 0000000000000000 x26: 0000000000000000
[  178.516611] x25: 0000000000000000 x24: fffffe00115bbbf0
[  178.516847] x23: 0000000000000000 x22: 0000000000000200
[  178.517121] x21: fffffe0011273988 x20: fffffc007cf7af28
[  178.517554] x19: fffffc007cf7af00 x18: 0000000000000010
[  178.517795] x17: 0000000000000000 x16: 0000000000000000
[  178.518044] x15: ffffffffffffffff x14: fffffe0011273988
[  178.518279] x13: fffffe009300fa97 x12: fffffe001300fa9f
[  178.518518] x11: fffffe00112b0000 x10: fffffe001300fa20
[  178.518885] x9 : 00000000ffffffd0 x8 : 75203b30206e6f20
[  178.519316] x7 : 000000000000014e x6 : fffffe001127cf50
[  178.519661] x5 : fffffe001127c000 x4 : 0000000000000000
[  178.519978] x3 : fffffe001127cf50 x2 : 0000000000000000
[  178.520245] x1 : cecd1d29479b5500 x0 : 0000000000000000
[  178.520659] Call trace:
[  178.520850]  refcount_warn_saturate+0x9c/0x140
[  178.521084]  kthread_stop+0x48/0x278
[  178.521703]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
[  178.522006]  __arm64_sys_delete_module+0x14c/0x298
[  178.522226]  do_el0_svc+0xf8/0x1e0
[  178.522403]  el0_sync_handler+0x134/0x1bc
[  178.522598]  el0_sync+0x140/0x180
[  178.522862] ---[ end trace 437c7bc9df5e92dd ]---
[  178.524159] ------------[ cut here ]------------
[  178.524420] refcount_t: underflow; use-after-free.
[  178.524734] WARNING: CPU: 0 PID: 2389 at lib/refcount.c:28
refcount_warn_saturate+0xf0/0x140
[  178.525079] Modules linked in: preemptirq_delay_test(-) sunrpc vfat
fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
ip_tables xfs libcrc32c virtio_net net_failover virtio_mmio failover
virtio_blk [last unloaded: preemptirq_delay_test]
[  178.526190] CPU: 0 PID: 2389 Comm: rmmod Tainted: G        W
5.6.0-rc7+ #18
[  178.526541] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[  178.526836] pstate: 40000005 (nZcv daif -PAN -UAO)
[  178.527060] pc : refcount_warn_saturate+0xf0/0x140
[  178.527269] lr : refcount_warn_saturate+0xf0/0x140
[  178.527484] sp : fffffe001300fd70
[  178.527643] x29: fffffe001300fd70 x28: fffffc004533e380
[  178.527905] x27: 0000000000000000 x26: 0000000000000000
[  178.528166] x25: 0000000000000000 x24: fffffe00115bbbf0
[  178.528489] x23: 0000000000000000 x22: 0000000000000200
[  178.528808] x21: 0000000000000000 x20: fffffc007cf7af28
[  178.529080] x19: fffffc007cf7af00 x18: 0000000000000010
[  178.529429] x17: 0000000000000000 x16: 0000000000000000
[  178.529747] x15: ffffffffffffffff x14: 0720072007200720
[  178.530100] x13: 0720072007200720 x12: 0720072007200720
[  178.530366] x11: 0720072007200720 x10: 0720072007200720
[  178.530632] x9 : 0720072007200720 x8 : 072007200720072e
[  178.530891] x7 : 0000000000000170 x6 : fffffe001127cf50
[  178.531154] x5 : fffffe001127c000 x4 : 0000000000000000
[  178.531431] x3 : fffffe001127cf50 x2 : 0000000000000000
[  178.531705] x1 : cecd1d29479b5500 x0 : 0000000000000000
[  178.532003] Call trace:
[  178.532166]  refcount_warn_saturate+0xf0/0x140
[  178.532434]  kthread_stop+0x254/0x278
[  178.532644]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
[  178.532963]  __arm64_sys_delete_module+0x14c/0x298
[  178.533210]  do_el0_svc+0xf8/0x1e0
[  178.533415]  el0_sync_handler+0x134/0x1bc
[  178.533627]  el0_sync+0x140/0x180
[  178.533807] ---[ end trace 437c7bc9df5e92de ]---
[  178.626471] Unable to handle kernel paging request at virtual address
0000fffffc0043ca
[  178.627253] Mem abort info:
[  178.627539]   ESR = 0x96000004
[  178.627927]   EC = 0x25: DABT (current EL), IL = 32 bits
[  178.628414]   SET = 0, FnV = 0
[  178.628806]   EA = 0, S1PTW = 0
[  178.629090] Data abort info:
[  178.639723]   ISV = 0, ISS = 0x00000004
[  178.640182]   CM = 0, WnR = 0
[  178.640530] [0000fffffc0043ca] address between user and kernel
address ranges
[  178.641300] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  178.641931] Modules linked in: sunrpc vfat fat ext4 mbcache jbd2
crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce ip_tables xfs
libcrc32c virtio_net net_failover virtio_mmio failover virtio_blk [last
unloaded: preemptirq_delay_test]
[  178.643547] CPU: 1 PID: 2394 Comm: pmlogger_check Tainted: G        W
        5.6.0-rc7+ #18
[  178.644219] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
02/06/2015
[  178.644782] pstate: 60000005 (nZCv daif -PAN -UAO)
[  178.645219] pc : __kmalloc+0xc8/0x2e8
[  178.645538] lr : __kmalloc+0x9c/0x2e8
[  178.645841] sp : fffffe001312fc20
[  178.646127] x29: fffffe001312fc20 x28: fffffc0042a0af00
[  178.646532] x27: fffffc005a7ad000 x26: 00000000cc79f001
[  178.647037] x25: fffffc0042a0af00 x24: fffffc007d76fc00
[  178.647431] x23: fffffe00103e95e4 x22: 000000000000001b
[  178.647895] x21: 0000000000000cc0 x20: fffffc007d76fc00
[  178.648276] x19: 0000fffffc0043ca x18: 0000000000000000
[  178.648673] x17: 0000000000000000 x16: 0000000000000000
[  178.649077] x15: 0000000000000000 x14: 0000000000000010
[  178.649608] x13: 0000000000000000 x12: 0000000000000000
[  178.649963] x11: 0000000000000000 x10: 0000000000000000
[  178.650337] x9 : 0000000000000000 x8 : 0000000000001f18
[  178.650683] x7 : 0000000000001f18 x6 : fffffc005a7ad1f8
[  178.651099] x5 : 0000000000000000 x4 : 0000000000000000
[  178.651557] x3 : 0000000000000000 x2 : fffffe001021d1e0
[  178.652006] x1 : 0000000000000000 x0 : 0000000000000001
[  178.652407] Call trace:
[  178.652694]  __kmalloc+0xc8/0x2e8
[  178.652972]  load_elf_binary+0xdc/0xdb8
[  178.653286]  search_binary_handler+0x98/0x268
[  178.653626]  __do_execve_file+0x4ec/0x7c8
[  178.653985]  __arm64_sys_execve+0x40/0x50
[  178.654310]  do_el0_svc+0xf8/0x1e0
[  178.654578]  el0_sync_handler+0x134/0x1bc
[  178.654962]  el0_sync+0x140/0x180
[  178.655509] Code: b4001073 b9402281 b9401380 11000400 (f8616a7b)
[  178.656543] ---[ end trace 437c7bc9df5e92df ]---
[  178.657100] Kernel panic - not syncing: Fatal exception
[  178.657630] SMP: stopping secondary CPUs
[  178.658237] Kernel Offset: disabled
[  178.658644] CPU features: 0x10002,20006082
[  178.658903] Memory Limit: none
[  178.659263] ---[ end Kernel panic - not syncing: Fatal exception ]---
---------------------------------------------------

Thanks,
Xiao Yang
On 2020/4/28 18:19, Xiao Yang wrote:
> Hi Joel,
> 
> Thanks for your quick fix.
> 
> Unfortunately, it fixes my original panic but introduces other
> issues(two wanings and one panic) on my arm64 vm, as below:
> --------------------------------------------------------------------
> [ 3465.434942] ------------[ cut here ]------------
> [ 3465.435481] refcount_t: addition on 0; use-after-free.
> [ 3465.437071] WARNING: CPU: 1 PID: 6708 at lib/refcount.c:25
> refcount_warn_saturate+0x9c/0x140
> [ 3465.437720] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
> fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
> ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
> virtio_blk
> [ 3465.439787] CPU: 1 PID: 6708 Comm: rmmod Tainted: G           O
> 5.6.0-rc7+ #18
> [ 3465.440316] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [ 3465.440967] pstate: 40000005 (nZcv daif -PAN -UAO)
> [ 3465.441297] pc : refcount_warn_saturate+0x9c/0x140
> [ 3465.441592] lr : refcount_warn_saturate+0x9c/0x140
> [ 3465.441919] sp : fffffe001382fd70
> [ 3465.442160] x29: fffffe001382fd70 x28: fffffc004876d200
> [ 3465.442649] x27: 0000000000000000 x26: 0000000000000000
> [ 3465.443071] x25: 0000000000000000 x24: fffffe00115bbbf0
> [ 3465.443670] x23: 0000000000000000 x22: 0000000000000200
> [ 3465.444194] x21: fffffe0011273988 x20: fffffc0063fdd228
> [ 3465.444576] x19: fffffc0063fdd200 x18: 0000000000000010
> [ 3465.444939] x17: 0000000000000000 x16: 0000000000000000
> [ 3465.445329] x15: ffffffffffffffff x14: fffffe0011273988
> [ 3465.445698] x13: fffffe009382fa97 x12: fffffe001382fa9f
> [ 3465.446116] x11: fffffe00112b0000 x10: fffffe001382fa20
> [ 3465.446498] x9 : 00000000ffffffd0 x8 : 6572662d72657466
> [ 3465.446941] x7 : 0000000000000149 x6 : fffffe001127cf50
> [ 3465.447375] x5 : fffffe001127c000 x4 : 0000000000000000
> [ 3465.447757] x3 : fffffe001127cf50 x2 : 0000000000000000
> [ 3465.448161] x1 : 2e36d2803fe6b700 x0 : 0000000000000000
> [ 3465.448702] Call trace:
> [ 3465.448979]  refcount_warn_saturate+0x9c/0x140
> [ 3465.449330]  kthread_stop+0x48/0x278
> [ 3465.450144]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
> [ 3465.450625]  __arm64_sys_delete_module+0x14c/0x298
> [ 3465.450998]  do_el0_svc+0xf8/0x1e0
> [ 3465.451372]  el0_sync_handler+0x134/0x1bc
> [ 3465.451701]  el0_sync+0x140/0x180
> [ 3465.452099] ---[ end trace 1a8ec2201af5e8c7 ]---
> [ 3465.478208] ------------[ cut here ]------------
> [ 3465.478696] WARNING: CPU: 1 PID: 6708 at kernel/kthread.c:400
> __kthread_bind_mask+0x34/0x90
> [ 3465.479210] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
> fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
> ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
> virtio_blk
> [ 3465.480509] CPU: 1 PID: 6708 Comm: rmmod Tainted: G        W  O
> 5.6.0-rc7+ #18
> [ 3465.480966] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [ 3465.481465] pstate: 40000005 (nZcv daif -PAN -UAO)
> [ 3465.481821] pc : __kthread_bind_mask+0x34/0x90
> [ 3465.482129] lr : __kthread_bind_mask+0x30/0x90
> [ 3465.482419] sp : fffffe001382fd30
> [ 3465.482639] x29: fffffe001382fd30 x28: fffffc004876d200
> [ 3465.483017] x27: 0000000000000000 x26: 0000000000000000
> [ 3465.483385] x25: 0000000000000000 x24: fffffe00115bbbf0
> [ 3465.483795] x23: 0000000000000000 x22: 0000000000000200
> [ 3465.484251] x21: fffffe0010a9cb88 x20: 0000000000000040
> [ 3465.484599] x19: fffffc0063fdd200 x18: 0000000000000010
> [ 3465.484957] x17: 0000000000000000 x16: 0000000000000000
> [ 3465.485347] x15: ffffffffffffffff x14: fffffe0011273988
> [ 3465.485714] x13: fffffe009382fa97 x12: fffffe001382fa9f
> [ 3465.486210] x11: fffffe00112b0000 x10: fffffe001382fa20
> [ 3465.486599] x9 : 00000000ffffffd0 x8 : 6572662d72657466
> [ 3465.487039] x7 : 0000000000000149 x6 : fffffe001127cf50
> [ 3465.487447] x5 : fffffe001127c000 x4 : 0000000000000001
> [ 3465.487868] x3 : fffffe001127cf50 x2 : 2e36d2803fe6b700
> [ 3465.488252] x1 : 0000000000000000 x0 : 0000000000000000
> [ 3465.488628] Call trace:
> [ 3465.488851]  __kthread_bind_mask+0x34/0x90
> [ 3465.489192]  kthread_unpark+0xa0/0xb0
> [ 3465.489456]  kthread_stop+0x8c/0x278
> [ 3465.489736]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
> [ 3465.490216]  __arm64_sys_delete_module+0x14c/0x298
> [ 3465.490594]  do_el0_svc+0xf8/0x1e0
> [ 3465.490850]  el0_sync_handler+0x134/0x1bc
> [ 3465.491157]  el0_sync+0x140/0x180
> [ 3465.491413] ---[ end trace 1a8ec2201af5e8c8 ]---
> [ 3465.504614] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [ 3465.505340] Mem abort info:
> [ 3465.505553]   ESR = 0x96000006
> [ 3465.505855]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 3465.506234]   SET = 0, FnV = 0
> [ 3465.506525]   EA = 0, S1PTW = 0
> [ 3465.506786] Data abort info:
> [ 3465.507037]   ISV = 0, ISS = 0x00000006
> [ 3465.507304]   CM = 0, WnR = 0
> [ 3465.507685] user pgtable: 64k pages, 42-bit VAs, pgdp=0000000082450000
> [ 3465.508225] [0000000000000000] pgd=0000000000000000,
> pud=0000000000000000, pmd=0000000000000000
> [ 3465.509049] Internal error: Oops: 96000006 [#1] PREEMPT SMP
> [ 3465.509527] Modules linked in: preemptirq_delay_test(O-) sunrpc vfat
> fat ext4 mbcache jbd2 crct10dif_ce ghash_ce sha2_ce sha256_arm64 sha1_ce
> ip_tables xfs libcrc32c virtio_net net_failover failover virtio_mmio
> virtio_blk
> [ 3465.510964] CPU: 1 PID: 6708 Comm: rmmod Tainted: G        W  O
> 5.6.0-rc7+ #18
> [ 3465.511527] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0
> 02/06/2015
> [ 3465.512031] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [ 3465.512392] pc : __list_add_valid+0x18/0xa0
> [ 3465.512740] lr : wait_for_completion+0xc8/0x178
> [ 3465.513085] sp : fffffe001382fd00
> [ 3465.513362] x29: fffffe001382fd00 x28: fffffc004876d200
> [ 3465.513769] x27: 0000000000000000 x26: 0000000000000000
> [ 3465.514205] x25: 0000000000000000 x24: fffffc0076e616c8
> [ 3465.514638] x23: fffffe001382fd68 x22: 0000000000000000
> [ 3465.515030] x21: fffffe0011273988 x20: fffffc0076e616c0
> [ 3465.515444] x19: fffffc0076e616b8 x18: 0000000000000010
> [ 3465.515826] x17: 0000000000000000 x16: 0000000000000000
> [ 3465.516184] x15: ffffffffffffffff x14: fffffe0011273988
> [ 3465.516584] x13: fffffe009382fa97 x12: fffffe001382fa9f
> [ 3465.516976] x11: fffffe00112b0000 x10: fffffe001382fa20
> [ 3465.517351] x9 : 00000000ffffffd0 x8 : 6572662d72657466
> [ 3465.517750] x7 : 0000000000000149 x6 : fffffe001127cf50
> [ 3465.518169] x5 : 0000000000000001 x4 : fffffc0076e616c8
> [ 3465.518454] x3 : fffffe0010128b38 x2 : 0000000000000000
> [ 3465.518711] x1 : 0000000000000000 x0 : fffffe001382fd68
> [ 3465.518985] Call trace:
> [ 3465.519157]  __list_add_valid+0x18/0xa0
> [ 3465.519351]  wait_for_completion+0xc8/0x178
> [ 3465.519578]  kthread_stop+0x9c/0x278
> [ 3465.519779]  preemptirq_delay_exit+0x28/0xfc8c [preemptirq_delay_test]
> [ 3465.520109]  __arm64_sys_delete_module+0x14c/0x298
> [ 3465.520342]  do_el0_svc+0xf8/0x1e0
> [ 3465.520520]  el0_sync_handler+0x134/0x1bc
> [ 3465.520718]  el0_sync+0x140/0x180
> [ 3465.521177] Code: 910003fd f9400442 eb01005f 54000141 (f9400041)
> [ 3465.522258] ---[ end trace 1a8ec2201af5e8c9 ]---
> [ 3465.522746] Kernel panic - not syncing: Fatal exception
> [ 3465.523242] SMP: stopping secondary CPUs
> [ 3465.523898] Kernel Offset: disabled
> [ 3465.524423] CPU features: 0x10002,20006082
> [ 3465.524939] Memory Limit: none
> [ 3465.525534] ---[ end Kernel panic - not syncing: Fatal exception ]---
> --------------------------------------------------------------------
> 
> I am looking into these issues.
> 
> Thanks,
> Xiao Yang
> On 2020/4/25 6:36, Joel Fernandes (Google) wrote:
>> Kthread running the test needs to be stopped or it can continue
>> executing code unloaded by module causing a crash.
>>
>> Suggested-by: Steven Rostedt<rostedt@goodmis.org>
>> Reported-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> Link: http://lore.kernel.org/r/5EA2B0C8.2080706@cn.fujitsu.com
>> Signed-off-by: Joel Fernandes (Google)<joel@joelfernandes.org>
>> ---
>>    kernel/trace/preemptirq_delay_test.c | 5 ++++-
>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
>> index 31c0fad4cb9e1..1c28ca20e30b6 100644
>> --- a/kernel/trace/preemptirq_delay_test.c
>> +++ b/kernel/trace/preemptirq_delay_test.c
>> @@ -145,10 +145,10 @@ static struct attribute_group attr_group = {
>>    };
>>
>>    static struct kobject *preemptirq_delay_kobj;
>> +static struct task_struct *test_task;
>>
>>    static int __init preemptirq_delay_init(void)
>>    {
>> -	struct task_struct *test_task;
>>    	int retval;
>>
>>    	test_task = preemptirq_start_test();
>> @@ -171,6 +171,9 @@ static int __init preemptirq_delay_init(void)
>>    static void __exit preemptirq_delay_exit(void)
>>    {
>>    	kobject_put(preemptirq_delay_kobj);
>> +
>> +	if (test_task)
>> +		kthread_stop(test_task);
>>    }
>>
>>    module_init(preemptirq_delay_init)
> 




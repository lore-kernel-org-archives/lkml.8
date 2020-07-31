Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298D420838
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgGaGtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:49:03 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59304 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731365AbgGaGtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:49:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1B4A48030866;
        Fri, 31 Jul 2020 06:49:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GYECb2l0d0JB; Fri, 31 Jul 2020 09:48:59 +0300 (MSK)
Date:   Fri, 31 Jul 2020 09:48:58 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     "Nguyen, Dinh" <dinh.nguyen@intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: clocksource: dw_apb_timer: commit 6d2e16a3181b broke Arria10
 platform
Message-ID: <20200731064858.ts22p4i5dqcdqpaj@mobilestation>
References: <SA0PR11MB4590258490EB0DD191778F04E4710@SA0PR11MB4590.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SA0PR11MB4590258490EB0DD191778F04E4710@SA0PR11MB4590.namprd11.prod.outlook.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dinh,
It must be something wrong with your timer2 and timer3 declared in the Arria10
dts because the patch didn't change anything for the first two timers (timer0 and
timer1). It just permits to register all DW APB Timers found in dts.

If those timers are broken, then you should have disabled them in the dts in the
first place. If they are normal, then you need to investigate further why do
they cause the kernel panic.

-Sergey

On Thu, Jul 30, 2020 at 09:30:55PM +0000, Nguyen, Dinh wrote:
> Hi Sergey,
> 
> Commit "6d2e16a3181b clocksource: dw_apb_timer_of: Fix missing clockevent timers" broke the Arria10 platform. See the bootlog here:
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.8.0-rc7-next-20200730 (dinguyen@linux-builds1) (a
> rm-linux-gnueabihf-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011, GNU ld (Linaro_B
> inutils-2017.11) 2.28.2.20170706) #18 SMP Thu Jul 30 16:25:46 CDT 2020
> [    0.000000] CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instructio
> n cache
> [    0.000000] OF: fdt: Machine model: Altera SOCFPGA Arria 10
> [    0.000000] earlycon: uart0 at MMIO32 0xffc02100 (options '115200n8')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000003fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003fffffff]
> [    0.000000] percpu: Embedded 19 pages/cpu s45132 r8192 d24500 u77824
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
> [    0.000000] Kernel command line: earlycon console=ttyS0,115200 root=/dev/nfs
> rw nfsroot=10.122.105.146:/home/dnguyen/rootfs_yocto,tcp ip=dhcp
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes,
> linear)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, li
> near)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 1027232K/1048576K available (8192K kernel code, 690K rwda
> ta, 1792K rodata, 1024K init, 159K bss, 21344K reserved, 0K cma-reserved, 262144
> K highmem)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> [    0.000000] ftrace: allocating 28185 entries in 56 pages
> [    0.000000] ftrace: allocated 56 pages with 3 groups
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU event tracing is enabled.
> [    0.000000]  Rude variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jif
> fies.
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000000] L2C-310 erratum 769419 enabled
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 1 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
> [    0.000000] L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x76560001
> [    0.000000] random: get_random_bytes called from start_kernel+0x388/0x528 wit
> h crng_init=0
> [    0.000000] clocksource: timer1: mask: 0xffffffff max_cycles: 0xffffffff, max
> _idle_ns: 38225208935 ns
> [    0.000004] sched_clock: 32 bits at 50MHz, resolution 20ns, wraps every 42949
> 672950ns
> [    0.007796] Switching to timer-based delay loop, resolution 20ns
> [    0.013861] 8<--- cut here ---
> [    0.016901] Unhandled fault: imprecise external abort (0x406) at 0x4b96623e
> [    0.023828] pgd = (ptrval)
> [    0.026520] [4b96623e] *pgd=00000000
> [    0.030084] Internal error: : 406 [#1] SMP ARM
> [    0.034504] Modules linked in:
> [    0.037548] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc7-next-20200730
> #18
> [    0.044992] Hardware name: Altera SOCFPGA Arria10
> [    0.049677] PC is at apbt_enable_int+0x24/0x48
> [    0.054098] LR is at dw_apb_clockevent_register+0x3c/0x40
> [    0.059468] pc : [<c06facd4>]    lr : [<c06fb13c>]    psr: 600000d3
> [    0.065702] sp : c0c01ef8  ip : c0c01f10  fp : c0c01f0c
> [    0.070908] r10: c0b44a3c  r9 : 00000000  r8 : c0a5ace0
> [    0.076106] r7 : 00000013  r6 : ef7f7640  r5 : ef06c0c0  r4 : a5f2106f
> [    0.082608] r3 : f081c000  r2 : 0000012c  r1 : 200000d3  r0 : ef06c0c0
> [    0.089112] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment no
> ne
> [    0.096384] Control: 10c5387d  Table: 0000404a  DAC: 00000051
> [    0.102110] Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
> [    0.108085] Stack: (0xc0c01ef8 to 0xc0c02000)
> [    0.112420] 1ee0:                                                       ef06c
> 000 c0c03cc8
> [    0.120558] 1f00: c0c01f24 c0c01f10 c06fb13c c06facbc c0ccd534 c0c03cc8 c0c01
> f5c c0c01f28
> [    0.128697] 1f20: c0b27e84 c06fb10c 00000013 02faf080 ef7f7640 f081c000 02faf
> 080 daec3655
> [    0.136844] 1f40: ef7f7640 c0c03cc8 00000004 c0b70700 c0c01f8c c0c01f60 c0b27
> b68 c0b27d38
> [    0.144981] 1f60: c0b7094c daec3655 c0c03cc8 c0cad000 c0c03cc8 c0c03cc0 c0cad
> 068 c0b44a3c
> [    0.153119] 1f80: c0c01f9c c0c01f90 c0b04d78 c0b27af4 c0c01ff4 c0c01fa0 c0b00
> ed4 c0b04d48
> [    0.161257] 1fa0: ffffffff ffffffff 00000000 c0b00670 00000000 efffedc0 00000
> 000 c0b44a3c
> [    0.169403] 1fc0: dae93e55 00000000 00000000 c0b00330 00000051 10c0387d 00000
> 000 09ff8000
> [    0.177541] 1fe0: 414fc091 10c5387d 00000000 c0c01ff8 00000000 c0b00b28 00000
> 000 00000000
> [    0.185675] Backtrace:
> [    0.188115] [<c06facb0>] (apbt_enable_int) from [<c06fb13c>] (dw_apb_clockeve
> nt_register+0x3c/0x40)
> [    0.197116]  r5:c0c03cc8 r4:ef06c000
> [    0.200681] [<c06fb100>] (dw_apb_clockevent_register) from [<c0b27e84>] (dw_a
> pb_timer_init+0x158/0x184)
> [    0.210027]  r5:c0c03cc8 r4:c0ccd534
> [    0.213587] [<c0b27d2c>] (dw_apb_timer_init) from [<c0b27b68>] (timer_probe+0
> x80/0xf4)
> [    0.221465]  r7:c0b70700 r6:00000004 r5:c0c03cc8 r4:ef7f7640
> [    0.227100] [<c0b27ae8>] (timer_probe) from [<c0b04d78>] (time_init+0x3c/0x44
> )
> [    0.234287]  r8:c0b44a3c r7:c0cad068 r6:c0c03cc0 r5:c0c03cc8 r4:c0cad000
> [    0.240966] [<c0b04d3c>] (time_init) from [<c0b00ed4>] (start_kernel+0x3b8/0x
> 528)
> [    0.248414] [<c0b00b1c>] (start_kernel) from [<00000000>] (0x0)
> [    0.254306]  r10:10c5387d r9:414fc091 r8:09ff8000 r7:00000000 r6:10c0387d r5:
> 00000051
> [    0.262104]  r4:c0b00330
> [    0.264627] Code: e1a05000 e5903000 e5934008 f57ff04f (e5903000)
> [    0.270694] ---[ end trace 35b8b1d373aa1593 ]---
> [    0.275289] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.281961] ---[ end Kernel panic - not syncing: Attempted to kill the idle t
> ask! ]---
> 
> Dinh

Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095FDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C00D020888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="NC6cDu9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390643AbgEZVNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390472AbgEZVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:13:32 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AED3C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:13:32 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 83B912304C;
        Tue, 26 May 2020 23:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590527606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLtW373Wes+4pmfrZAyfhMViZFU7s6MEBT8Wj4zGtps=;
        b=NC6cDu9wxOaJ70zuYquz9OTEA9CCQDkjjgZnFB5qWtO/WHG/Hpc6QwVKqOcMFsczzwloI7
        qtnmcGDEBcK4O3TeAIWhQMstOE7HGuSa9pM0iVB0Niz36qgoCApLSBTyQiLVDKx9haSywh
        ljsIvzrs6ToSvCQMNncIZMUlKg4jCkk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 23:13:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
In-Reply-To: <20200526194328.258722-1-saravanak@google.com>
References: <20200526194328.258722-1-saravanak@google.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <66f871c4c457d908ea86545c1aa871bf@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-05-26 21:43, schrieb Saravana Kannan:
> When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
> core: Add device link support for SYNC_STATE_ONLY flag"),
> SYNC_STATE_ONLY links were treated similar to STATELESS links in terms
> of not blocking consumer probe if the supplier hasn't probed yet.
> 
> That caused a SYNC_STATE_ONLY device link's status to not get updated.
> Since SYNC_STATE_ONLY device link is no longer useful once the
> consumer probes, commit 21c27f06587d ("driver core: Fix
> SYNC_STATE_ONLY device link implementation") addresses the status
> update issue by deleting the SYNC_STATE_ONLY device link instead of
> complicating the status update code.
> 
> However, there are still some cases where we need to update the status
> of a SYNC_STATE_ONLY device link. This is because a SYNC_STATE_ONLY
> device link can later get converted into a normal MANAGED device link
> when a normal MANAGED device link is created between a supplier and
> consumer that already have a SYNC_STATE_ONLY device link between them.
> 
> If a SYNC_STATE_ONLY device link's status isn't maintained correctly
> till it's converted to a normal MANAGED device link, then the normal
> MANAGED device link will end up with a wrong link status. This can 
> cause
> a warning stack trace[1] when the consumer device probes successfully.
> 
> This commit fixes the SYNC_STATE_ONLY device link status update issue
> where it wouldn't transition correctly from DL_STATE_DORMANT or
> DL_STATE_AVAILABLE to DL_STATE_CONSUMER_PROBE. It also resets the 
> status
> back to DL_STATE_DORMANT or DL_STATE_AVAILABLE if the consumer probe
> fails.
> 
> [1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
> Fixes: 05ef983e0d65 ("driver core: Add device link support for
> SYNC_STATE_ONLY flag")
> Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
> implementation")
> Reported-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> 
> v1->v2:
> - Added code to "revert" the link status if consumer probe fails
> 
> Greg,
> 
> I think this is the issue Michael ran into. I'd like him to test the 
> fix
> before it's pulled in.
> 
> Michael,
> 
> If you can test this on the branch you saw the issue in and give a
> Tested-by if it works, that'd be great.

with v2 I'm triggering the
   WARN_ON(!(link->status & DL_FLAG_SYNC_STATE_ONLY));
in __device_links_no_driver().

I've added the debug output for this WARN_ON()

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
[    0.000000] Linux version 
5.7.0-rc7-next-20200525-00001-ged5852b8c488-dirty (mw@apollo) 
(aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU ld (GNU Binutils for 
Debian) 2.31.1) #836 SMP PREEMPT Tue May 26 23:08:57 CEST 2020
[    0.000000] Machine model: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 32 MiB at 0x00000000f9c00000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 
0x0000000080000000-0x00000020ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x20ff7fe100-0x20ff7fffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000020ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000fbdfffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000020ffffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000080000000-0x00000020ffffffff]
[    0.000000] On node 0 totalpages: 1031680
[    0.000000]   DMA zone: 4096 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 262144 pages, LIFO batch:63
[    0.000000]   DMA32 zone: 3832 pages used for memmap
[    0.000000]   DMA32 zone: 245248 pages, LIFO batch:63
[    0.000000]   Normal zone: 8192 pages used for memmap
[    0.000000]   Normal zone: 524288 pages, LIFO batch:63
[    0.000000] percpu: Embedded 30 pages/cpu s82904 r8192 d31784 u122880
[    0.000000] pcpu-alloc: s82904 r8192 d31784 u122880 alloc=30*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: EL2 vector hardening
[    0.000000] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
[    0.000000] CPU features: detected: ARM errata 1165522, 1319367, or 
1530923
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 
1015560
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: debug root=/dev/mmcblk1p2 rootwait
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 
4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0xbbfff000-0xbffff000] 
(64MB)
[    0.000000] Memory: 3930016K/4126720K available (9532K kernel code, 
1114K rwdata, 3556K rodata, 3200K init, 398K bss, 163936K reserved, 
32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, 
Nodes=1
[    0.000000] ftrace: allocating 32616 entries in 128 pages
[    0.000000] ftrace: allocated 128 pages with 1 groups
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to 
nr_cpu_ids=2.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, 
nr_cpu_ids=2
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: 256 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: 16 PPIs implemented
[    0.000000] GICv3: CPU0: found redistributor 0 region 
0:0x0000000006040000
[    0.000000] ITS [mem 0x06020000-0x0603ffff]
[    0.000000] ITS@0x0000000006020000: allocated 65536 Devices 
@20fad80000 (flat, esz 8, psz 64K, shr 0)
[    0.000000] ITS: using cache flushing for cmd queue
[    0.000000] GICv3: using LPI property table @0x00000020fad30000
[    0.000000] GIC: using cache flushing for LPI property table
[    0.000000] GICv3: CPU0: using allocated LPI pending table 
@0x00000020fad40000
[    0.000000] random: get_random_bytes called from 
start_kernel+0x604/0x7cc with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 25.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x5c40939b5, max_idle_ns: 440795202646 ns
[    0.000002] sched_clock: 56 bits at 25MHz, resolution 40ns, wraps 
every 4398046511100ns
[    0.000107] Console: colour dummy device 80x25
[    0.000391] printk: console [tty0] enabled
[    0.000439] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 50.00 BogoMIPS (lpj=100000)
[    0.000452] pid_max: default: 32768 minimum: 301
[    0.000499] LSM: Security Framework initializing
[    0.000551] Mount-cache hash table entries: 8192 (order: 4, 65536 
bytes, linear)
[    0.000582] Mountpoint-cache hash table entries: 8192 (order: 4, 
65536 bytes, linear)
[    0.001429] rcu: Hierarchical SRCU implementation.
[    0.001578] Platform MSI: gic-its@6020000 domain created
[    0.001651] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000 
domain created
[    0.001850] EFI services will not be available.
[    0.001946] smp: Bringing up secondary CPUs ...
[    0.002223] Detected PIPT I-cache on CPU1
[    0.002244] GICv3: CPU1: found redistributor 1 region 
0:0x0000000006060000
[    0.002250] GICv3: CPU1: using allocated LPI pending table 
@0x00000020fad50000
[    0.002273] CPU1: Booted secondary processor 0x0000000001 
[0x410fd083]
[    0.002324] smp: Brought up 1 node, 2 CPUs
[    0.002350] SMP: Total of 2 processors activated.
[    0.002358] CPU features: detected: 32-bit EL0 Support
[    0.002365] CPU features: detected: CRC32 instructions
[    0.010433] CPU: All CPU(s) started at EL2
[    0.010452] alternatives: patching kernel code
[    0.011049] devtmpfs: initialized
[    0.012987] KASLR disabled due to lack of seed
[    0.013150] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.013167] futex hash table entries: 512 (order: 3, 32768 bytes, 
linear)
[    0.013938] thermal_sys: Registered thermal governor 'step_wise'
[    0.014061] DMI not present or invalid.
[    0.014244] NET: Registered protocol family 16
[    0.015143] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic 
allocations
[    0.015851] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    0.016580] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    0.016617] audit: initializing netlink subsys (disabled)
[    0.016739] audit: type=2000 audit(0.016:1): state=initialized 
audit_enabled=0 res=1
[    0.017038] cpuidle: using governor menu
[    0.017107] hw-breakpoint: found 6 breakpoint and 4 watchpoint 
registers.
[    0.017137] ASID allocator initialised with 65536 entries
[    0.017403] Serial: AMBA PL011 UART driver
[    0.023156] platform 2140000.mmc: Link attempted to 5000000.iommu 
0xc0
[    0.023170] platform 2140000.mmc: Link done to 5000000.iommu 0xc0 0
[    0.023193] platform 2150000.mmc: Link attempted to 5000000.iommu 
0xc0
[    0.023202] platform 2150000.mmc: Link done to 5000000.iommu 0xc0 0
[    0.023265] platform 22c0000.dma-controller: Link attempted to 
5000000.iommu 0xc0
[    0.023275] platform 22c0000.dma-controller: Link done to 
5000000.iommu 0xc0 0
[    0.023317] platform 3100000.usb: Link attempted to 5000000.iommu 
0xc0
[    0.023325] platform 3100000.usb: Link done to 5000000.iommu 0xc0 0
[    0.023341] platform 3110000.usb: Link attempted to 5000000.iommu 
0xc0
[    0.023349] platform 3110000.usb: Link done to 5000000.iommu 0xc0 0
[    0.023375] platform 3400000.pcie: Link attempted to 5000000.iommu 
0xc0
[    0.023383] platform 3400000.pcie: Link done to 5000000.iommu 0xc0 0
[    0.023406] platform 3500000.pcie: Link attempted to 5000000.iommu 
0xc0
[    0.023414] platform 3500000.pcie: Link done to 5000000.iommu 0xc0 0
[    0.023431] platform 8380000.dma-controller: Link attempted to 
5000000.iommu 0xc0
[    0.023441] platform 8380000.dma-controller: Link done to 
5000000.iommu 0xc0 0
[    0.023540] platform 1f0000000.pcie: Link attempted to 5000000.iommu 
0xc0
[    0.023548] platform 1f0000000.pcie: Link done to 5000000.iommu 0xc0 
0
[    0.023591] platform f080000.display: Link attempted to 5000000.iommu 
0xc0
[    0.023600] platform f080000.display: Link done to 5000000.iommu 0xc0 
0
[    0.023867] Machine: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval 
2.0 carrier
[    0.023877] SoC family: QorIQ LS1028A
[    0.023882] SoC ID: svr:0x870b0110, Revision: 1.0
[    0.026885] HugeTLB registered 1.00 GiB page size, pre-allocated 0 
pages
[    0.026899] HugeTLB registered 32.0 MiB page size, pre-allocated 0 
pages
[    0.026907] HugeTLB registered 2.00 MiB page size, pre-allocated 0 
pages
[    0.026915] HugeTLB registered 64.0 KiB page size, pre-allocated 0 
pages
[    0.027977] cryptd: max_cpu_qlen set to 1000
[    0.029319] ------------[ cut here ]------------
[    0.029332] sup:5000000.iommu - con:22c0000.dma-controller f:192 s:2
[    0.029369] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:993 
__device_links_no_driver+0xf0/0xf8
[    0.029377] Modules linked in:
[    0.029387] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
5.7.0-rc7-next-20200525-00001-ged5852b8c488-dirty #836
[    0.029396] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier (DT)
[    0.029407] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[    0.029414] pc : __device_links_no_driver+0xf0/0xf8
[    0.029421] lr : __device_links_no_driver+0xf0/0xf8
[    0.029426] sp : ffff80001118bbb0
[    0.029432] x29: ffff80001118bbb0 x28: 0000000000000000
[    0.029440] x27: 0000000000000004 x26: ffff800010cd04e8
[    0.029447] x25: ffff800010d51950 x24: ffff00207a41bc10
[    0.029455] x23: 0000000000000001 x22: ffff800010bd4698
[    0.029462] x21: ffff00207a41bcb0 x20: ffff00207a401080
[    0.029469] x19: ffff00207a41bc90 x18: 0000000000000010
[    0.029476] x17: 0000000057af2a13 x16: 00000000ad23dded
[    0.029483] x15: ffffffffffffffff x14: 0720072007200720
[    0.029490] x13: 0720072007200720 x12: 07200732073a0773
[    0.029497] x11: 0720073207390731 x10: 073a076607200772
[    0.029504] x9 : ffff800010091f64 x8 : 07720774076e076f
[    0.029511] x7 : 0000000000000087 x6 : ffff00207ac21f00
[    0.029518] x5 : 0000000000000000 x4 : 0000000000000000
[    0.029525] x3 : 00000000ffffffff x2 : ffff80001101b6c8
[    0.029531] x1 : 3ee0a21bc55cf800 x0 : 0000000000000000
[    0.029539] Call trace:
[    0.029546]  __device_links_no_driver+0xf0/0xf8
[    0.029553]  device_links_no_driver+0x74/0x90
[    0.029561]  really_probe+0x1ac/0x318
[    0.029568]  driver_probe_device+0x40/0x90
[    0.029574]  device_driver_attach+0x7c/0x88
[    0.029581]  __driver_attach+0x60/0xe8
[    0.029588]  bus_for_each_dev+0x7c/0xd0
[    0.029594]  driver_attach+0x2c/0x38
[    0.029600]  bus_add_driver+0x194/0x1f8
[    0.029607]  driver_register+0x6c/0x128
[    0.029614]  __platform_driver_register+0x50/0x60
[    0.029623]  fsl_edma_init+0x24/0x30
[    0.029631]  do_one_initcall+0x54/0x298
[    0.029639]  kernel_init_freeable+0x1ec/0x268
[    0.029648]  kernel_init+0x1c/0x118
[    0.029655]  ret_from_fork+0x10/0x1c
[    0.029662] ---[ end trace e2cf5516fda822af ]---
[    0.029799] iommu: Default domain type: Translated
[    0.029862] vgaarb: loaded
[    0.030000] SCSI subsystem initialized
[    0.030088] usbcore: registered new interface driver usbfs
[    0.030113] usbcore: registered new interface driver hub
[    0.030144] usbcore: registered new device driver usb
[    0.030277] imx-i2c 2000000.i2c: can't get pinctrl, bus recovery not 
supported
[    0.030456] i2c i2c-0: IMX I2C adapter registered
[    0.030531] imx-i2c 2030000.i2c: can't get pinctrl, bus recovery not 
supported
[    0.030607] i2c i2c-1: IMX I2C adapter registered
[    0.030679] imx-i2c 2040000.i2c: can't get pinctrl, bus recovery not 
supported
[    0.030778] i2c i2c-2: IMX I2C adapter registered
[    0.030861] pps_core: LinuxPPS API ver. 1 registered
[    0.030868] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.030882] PTP clock support registered
[    0.031108] Advanced Linux Sound Architecture Driver Initialized.
[    0.031461] clocksource: Switched to clocksource arch_sys_counter
[    0.067525] VFS: Disk quotas dquot_6.6.0
[    0.067570] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    0.070282] NET: Registered protocol family 2
[    0.070514] tcp_listen_portaddr_hash hash table entries: 2048 (order: 
3, 32768 bytes, linear)
[    0.070538] TCP established hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.070630] TCP bind hash table entries: 32768 (order: 7, 524288 
bytes, linear)
[    0.070936] TCP: Hash tables configured (established 32768 bind 
32768)
[    0.071035] UDP hash table entries: 2048 (order: 4, 65536 bytes, 
linear)
[    0.071063] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, 
linear)
[    0.071149] NET: Registered protocol family 1
[    0.071169] PCI: CLS 0 bytes, default 64
[    0.071528] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 
7 counters available
[    0.071984] Initialise system trusted keyrings
[    0.072111] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    0.105492] Key type asymmetric registered
[    0.105506] Asymmetric key parser 'x509' registered
[    0.105533] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 248)
[    0.105543] io scheduler mq-deadline registered
[    0.105550] io scheduler kyber registered
[    0.105982] pci-host-generic 1f0000000.pcie: host bridge 
/soc/pcie@1f0000000 ranges:
[    0.106010] pci-host-generic 1f0000000.pcie:      MEM 
0x01f8000000..0x01f815ffff -> 0x0000000000
[    0.106031] pci-host-generic 1f0000000.pcie:      MEM 
0x01f8160000..0x01f81cffff -> 0x0000000000
[    0.106051] pci-host-generic 1f0000000.pcie:      MEM 
0x01f81d0000..0x01f81effff -> 0x0000000000
[    0.106070] pci-host-generic 1f0000000.pcie:      MEM 
0x01f81f0000..0x01f820ffff -> 0x0000000000
[    0.106090] pci-host-generic 1f0000000.pcie:      MEM 
0x01f8210000..0x01f822ffff -> 0x0000000000
[    0.106109] pci-host-generic 1f0000000.pcie:      MEM 
0x01f8230000..0x01f824ffff -> 0x0000000000
[    0.106123] pci-host-generic 1f0000000.pcie:      MEM 
0x01fc000000..0x01fc3fffff -> 0x0000000000
[    0.106174] pci-host-generic 1f0000000.pcie: ECAM at [mem 
0x1f0000000-0x1f00fffff] for [bus 00]
[    0.106234] pci-host-generic 1f0000000.pcie: PCI host bridge to bus 
0000:00
[    0.106244] pci_bus 0000:00: root bus resource [bus 00]
[    0.106253] pci_bus 0000:00: root bus resource [mem 
0x1f8000000-0x1f815ffff] (bus address [0x00000000-0x0015ffff])
[    0.106264] pci_bus 0000:00: root bus resource [mem 
0x1f8160000-0x1f81cffff pref] (bus address [0x00000000-0x0006ffff])
[    0.106275] pci_bus 0000:00: root bus resource [mem 
0x1f81d0000-0x1f81effff] (bus address [0x00000000-0x0001ffff])
[    0.106286] pci_bus 0000:00: root bus resource [mem 
0x1f81f0000-0x1f820ffff pref] (bus address [0x00000000-0x0001ffff])
[    0.106297] pci_bus 0000:00: root bus resource [mem 
0x1f8210000-0x1f822ffff] (bus address [0x00000000-0x0001ffff])
[    0.106308] pci_bus 0000:00: root bus resource [mem 
0x1f8230000-0x1f824ffff pref] (bus address [0x00000000-0x0001ffff])
[    0.106318] pci_bus 0000:00: root bus resource [mem 
0x1fc000000-0x1fc3fffff] (bus address [0x00000000-0x003fffff])
[    0.106340] pci 0000:00:00.0: [1957:e100] type 00 class 0x020001
[    0.106382] pci 0000:00:00.0: BAR 0: [mem 0x1f8000000-0x1f803ffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.106395] pci 0000:00:00.0: BAR 2: [mem 0x1f8160000-0x1f816ffff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.106407] pci 0000:00:00.0: VF BAR 0: [mem 0x1f81d0000-0x1f81dffff 
64bit] (from Enhanced Allocation, properties 0x4)
[    0.106419] pci 0000:00:00.0: VF BAR 2: [mem 0x1f81f0000-0x1f81fffff 
64bit pref] (from Enhanced Allocation, properties 0x3)
[    0.106444] pci 0000:00:00.0: PME# supported from D0 D3hot
[    0.106458] pci 0000:00:00.0: VF(n) BAR0 space: [mem 
0x1f81d0000-0x1f81effff 64bit] (contains BAR0 for 2 VFs)
[    0.106469] pci 0000:00:00.0: VF(n) BAR2 space: [mem 
0x1f81f0000-0x1f820ffff 64bit pref] (contains BAR2 for 2 VFs)
[    0.106585] pci 0000:00:00.1: [1957:e100] type 00 class 0x020001
[    0.106615] pci 0000:00:00.1: BAR 0: [mem 0x1f8040000-0x1f807ffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.106627] pci 0000:00:00.1: BAR 2: [mem 0x1f8170000-0x1f817ffff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.106639] pci 0000:00:00.1: VF BAR 0: [mem 0x1f8210000-0x1f821ffff 
64bit] (from Enhanced Allocation, properties 0x4)
[    0.106650] pci 0000:00:00.1: VF BAR 2: [mem 0x1f8230000-0x1f823ffff 
64bit pref] (from Enhanced Allocation, properties 0x3)
[    0.106673] pci 0000:00:00.1: PME# supported from D0 D3hot
[    0.106686] pci 0000:00:00.1: VF(n) BAR0 space: [mem 
0x1f8210000-0x1f822ffff 64bit] (contains BAR0 for 2 VFs)
[    0.106697] pci 0000:00:00.1: VF(n) BAR2 space: [mem 
0x1f8230000-0x1f824ffff 64bit pref] (contains BAR2 for 2 VFs)
[    0.106788] pci 0000:00:00.2: [1957:e100] type 00 class 0x020001
[    0.106818] pci 0000:00:00.2: BAR 0: [mem 0x1f8080000-0x1f80bffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.106830] pci 0000:00:00.2: BAR 2: [mem 0x1f8180000-0x1f818ffff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.106852] pci 0000:00:00.2: PME# supported from D0 D3hot
[    0.106934] pci 0000:00:00.3: [1957:ee01] type 00 class 0x088001
[    0.106967] pci 0000:00:00.3: BAR 0: [mem 0x1f8100000-0x1f811ffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.106979] pci 0000:00:00.3: BAR 2: [mem 0x1f8190000-0x1f819ffff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.107000] pci 0000:00:00.3: PME# supported from D0 D3hot
[    0.107086] pci 0000:00:00.4: [1957:ee02] type 00 class 0x088001
[    0.107117] pci 0000:00:00.4: BAR 0: [mem 0x1f8120000-0x1f813ffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.107129] pci 0000:00:00.4: BAR 2: [mem 0x1f81a0000-0x1f81affff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.107150] pci 0000:00:00.4: PME# supported from D0 D3hot
[    0.107238] pci 0000:00:00.5: [1957:eef0] type 00 class 0x020801
[    0.107268] pci 0000:00:00.5: BAR 0: [mem 0x1f8140000-0x1f815ffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.107279] pci 0000:00:00.5: BAR 2: [mem 0x1f81b0000-0x1f81bffff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.107291] pci 0000:00:00.5: BAR 4: [mem 0x1fc000000-0x1fc3fffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.107312] pci 0000:00:00.5: PME# supported from D0 D3hot
[    0.107399] pci 0000:00:00.6: [1957:e100] type 00 class 0x020001
[    0.107428] pci 0000:00:00.6: BAR 0: [mem 0x1f80c0000-0x1f80fffff 
64bit] (from Enhanced Allocation, properties 0x0)
[    0.107440] pci 0000:00:00.6: BAR 2: [mem 0x1f81c0000-0x1f81cffff 
64bit pref] (from Enhanced Allocation, properties 0x1)
[    0.107481] pci 0000:00:00.6: PME# supported from D0 D3hot
[    0.108243] pci 0000:00:1f.0: [1957:e001] type 00 class 0x080700
[    0.108289] OF: /soc/pcie@1f0000000: no msi-map translation for rid 
0xf8 on (null)
[    0.108599] layerscape-pcie 3400000.pcie: host bridge 
/soc/pcie@3400000 ranges:
[    0.108624] layerscape-pcie 3400000.pcie:       IO 
0x8000010000..0x800001ffff -> 0x0000000000
[    0.108641] layerscape-pcie 3400000.pcie:      MEM 
0x8040000000..0x807fffffff -> 0x0040000000
[    0.108727] layerscape-pcie 3400000.pcie: PCI host bridge to bus 
0001:00
[    0.108737] pci_bus 0001:00: root bus resource [bus 00-ff]
[    0.108745] pci_bus 0001:00: root bus resource [io  0x0000-0xffff]
[    0.108754] pci_bus 0001:00: root bus resource [mem 
0x8040000000-0x807fffffff] (bus address [0x40000000-0x7fffffff])
[    0.108774] pci 0001:00:00.0: [1957:82c1] type 01 class 0x060400
[    0.108835] pci 0001:00:00.0: supports D1 D2
[    0.108842] pci 0001:00:00.0: PME# supported from D0 D1 D2 D3hot
[    0.110259] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 
01
[    0.110273] pci 0001:00:00.0: PCI bridge to [bus 01]
[    0.110361] layerscape-pcie 3500000.pcie: host bridge 
/soc/pcie@3500000 ranges:
[    0.110385] layerscape-pcie 3500000.pcie:       IO 
0x8800010000..0x880001ffff -> 0x0000000000
[    0.110401] layerscape-pcie 3500000.pcie:      MEM 
0x8840000000..0x887fffffff -> 0x0040000000
[    0.110478] layerscape-pcie 3500000.pcie: PCI host bridge to bus 
0002:00
[    0.110488] pci_bus 0002:00: root bus resource [bus 00-ff]
[    0.110497] pci_bus 0002:00: root bus resource [io  0x10000-0x1ffff] 
(bus address [0x0000-0xffff])
[    0.110508] pci_bus 0002:00: root bus resource [mem 
0x8840000000-0x887fffffff] (bus address [0x40000000-0x7fffffff])
[    0.110528] pci 0002:00:00.0: [1957:82c1] type 01 class 0x060400
[    0.110586] pci 0002:00:00.0: supports D1 D2
[    0.110593] pci 0002:00:00.0: PME# supported from D0 D1 D2 D3hot
[    0.112016] pci_bus 0002:01: busn_res: [bus 01-ff] end is updated to 
01
[    0.112029] pci 0002:00:00.0: PCI bridge to [bus 01]
[    0.112294] IPMI message handler: version 39.2
[    0.112320] ipmi device interface
[    0.112347] ipmi_si: IPMI System Interface driver
[    0.112467] ipmi_si: Unable to find any System Interface(s)
[    0.112817] ------------[ cut here ]------------
[    0.112825] sup:5000000.iommu - con:8380000.dma-controller f:192 s:2
[    0.112858] WARNING: CPU: 1 PID: 1 at drivers/base/core.c:993 
__device_links_no_driver+0xf0/0xf8
[    0.112866] Modules linked in:
[    0.112876] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         
5.7.0-rc7-next-20200525-00001-ged5852b8c488-dirty #836
[    0.112885] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier (DT)
[    0.112895] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[    0.112903] pc : __device_links_no_driver+0xf0/0xf8
[    0.112910] lr : __device_links_no_driver+0xf0/0xf8
[    0.112915] sp : ffff80001118bbb0
[    0.112920] x29: ffff80001118bbb0 x28: 0000000000000000
[    0.112928] x27: 0000000000000006 x26: ffff800010cd04e8
[    0.112936] x25: ffff800010d51960 x24: ffff00207a422010
[    0.112943] x23: 0000000000000001 x22: ffff800010bd4698
[    0.112950] x21: ffff00207a4220b0 x20: ffff00207a401300
[    0.112957] x19: ffff00207a422090 x18: 0000000000000010
[    0.112964] x17: 0000000000000001 x16: 0000000000000001
[    0.112971] x15: ffffffffffffffff x14: 0720072007200720
[    0.112978] x13: 0720072007200720 x12: 07200732073a0773
[    0.112985] x11: 0720073207390731 x10: 073a076607200772
[    0.112992] x9 : ffff800010091f64 x8 : 07720774076e076f
[    0.112999] x7 : 000000000000012b x6 : ffff00207ac21f00
[    0.113006] x5 : 0000000000000000 x4 : 0000000000000000
[    0.113013] x3 : 00000000ffffffff x2 : ffff80001101b6c8
[    0.113020] x1 : 3ee0a21bc55cf800 x0 : 0000000000000000
[    0.113027] Call trace:
[    0.113034]  __device_links_no_driver+0xf0/0xf8
[    0.113041]  device_links_no_driver+0x74/0x90
[    0.113049]  really_probe+0x1ac/0x318
[    0.113056]  driver_probe_device+0x40/0x90
[    0.113062]  device_driver_attach+0x7c/0x88
[    0.113069]  __driver_attach+0x60/0xe8
[    0.113076]  bus_for_each_dev+0x7c/0xd0
[    0.113082]  driver_attach+0x2c/0x38
[    0.113088]  bus_add_driver+0x194/0x1f8
[    0.113095]  driver_register+0x6c/0x128
[    0.113102]  __platform_driver_register+0x50/0x60
[    0.113110]  fsl_qdma_driver_init+0x24/0x30
[    0.113118]  do_one_initcall+0x54/0x298
[    0.113126]  kernel_init_freeable+0x1ec/0x268
[    0.113136]  kernel_init+0x1c/0x118
[    0.113142]  ret_from_fork+0x10/0x1c
[    0.113148] ---[ end trace e2cf5516fda822b0 ]---
[    0.114250] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.114933] 21c0500.serial: ttyS0 at MMIO 0x21c0500 (irq = 16, 
base_baud = 12500000) is a 16550A
[    2.251687] printk: console [ttyS0] enabled
[    2.256149] 21c0600.serial: ttyS1 at MMIO 0x21c0600 (irq = 16, 
base_baud = 12500000) is a 16550A
[    2.265257] 2270000.serial: ttyLP2 at MMIO 0x2270000 (irq = 17, 
base_baud = 12500000) is a FSL_LPUART
[    2.275312] arm-smmu 5000000.iommu: probing hardware configuration...
[    2.281800] arm-smmu 5000000.iommu: SMMUv2 with:
[    2.286442] arm-smmu 5000000.iommu:  stage 1 translation
[    2.291787] arm-smmu 5000000.iommu:  stage 2 translation
[    2.297122] arm-smmu 5000000.iommu:  nested translation
[    2.302370] arm-smmu 5000000.iommu:  stream matching with 128 
register groups
[    2.309538] arm-smmu 5000000.iommu:  64 context banks (0 stage-2 
only)
[    2.316102] arm-smmu 5000000.iommu:  Supported page sizes: 0x61311000
[    2.322573] arm-smmu 5000000.iommu:  Stage-1: 48-bit VA -> 48-bit IPA
[    2.329044] arm-smmu 5000000.iommu:  Stage-2: 48-bit IPA -> 48-bit PA
[    2.336017] at24 0-0050: supply vcc not found, using dummy regulator
[    2.343189] at24 0-0050: 4096 byte 24c32 EEPROM, writable, 32 
bytes/write
[    2.350061] at24 1-0057: supply vcc not found, using dummy regulator
[    2.357203] at24 1-0057: 8192 byte 24c64 EEPROM, writable, 32 
bytes/write
[    2.364071] at24 2-0050: supply vcc not found, using dummy regulator
[    2.371205] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 32 
bytes/write
[    2.378152] mpt3sas version 34.100.00.00 loaded
[    2.383576] spi-nor spi1.0: mx25u3235f (4096 Kbytes)
[    2.392502] spi-nor spi0.0: w25q32dw (4096 Kbytes)
[    2.399966] 10 fixed-partitions partitions found on MTD device 
20c0000.spi
[    2.406887] Creating 10 MTD partitions on "20c0000.spi":
[    2.412237] 0x000000000000-0x000000010000 : "rcw"
[    2.423775] 0x000000010000-0x000000100000 : "failsafe bootloader"
[    2.439768] 0x000000100000-0x000000140000 : "failsafe DP firmware"
[    2.447799] 0x000000140000-0x0000001e0000 : "failsafe trusted 
firmware"
[    2.455792] 0x0000001e0000-0x000000200000 : "reserved"
[    2.463786] 0x000000200000-0x000000210000 : "configuration store"
[    2.471793] 0x000000210000-0x000000300000 : "bootloader"
[    2.479800] 0x000000300000-0x000000340000 : "DP firmware"
[    2.487782] 0x000000340000-0x0000003e0000 : "trusted firmware"
[    2.495791] 0x0000003e0000-0x000000400000 : "bootloader environment"
[    2.504383] libphy: Fixed MDIO Bus: probed
[    2.508665] mscc_felix 0000:00:00.5: Link attempted to 5000000.iommu 
0x54
[    2.515490] mscc_felix 0000:00:00.5: Link done to 5000000.iommu 0x54 
2
[    2.522081] mscc_felix 0000:00:00.5: Adding to iommu group 0
[    2.527897] mscc_felix 0000:00:00.5: device is disabled, skipping
[    2.534057] fsl_enetc 0000:00:00.0: Link attempted to 5000000.iommu 
0x54
[    2.540793] fsl_enetc 0000:00:00.0: Link done to 5000000.iommu 0x54 2
[    2.547287] fsl_enetc 0000:00:00.0: Adding to iommu group 1
[    2.659477] fsl_enetc 0000:00:00.0: enabling device (0400 -> 0402)
[    2.665722] fsl_enetc 0000:00:00.0: no MAC address specified for SI1, 
using 0e:87:05:e9:99:e2
[    2.674289] fsl_enetc 0000:00:00.0: no MAC address specified for SI2, 
using 32:0b:6b:3a:49:50
[    2.683200] libphy: Freescale ENETC MDIO Bus: probed
[    2.689766] fsl_enetc 0000:00:00.1: Link attempted to 5000000.iommu 
0x54
[    2.696523] fsl_enetc 0000:00:00.1: Link done to 5000000.iommu 0x54 2
[    2.703027] fsl_enetc 0000:00:00.1: Adding to iommu group 2
[    2.708717] fsl_enetc 0000:00:00.1: device is disabled, skipping
[    2.714770] fsl_enetc 0000:00:00.2: Link attempted to 5000000.iommu 
0x54
[    2.721503] fsl_enetc 0000:00:00.2: Link done to 5000000.iommu 0x54 2
[    2.727995] fsl_enetc 0000:00:00.2: Adding to iommu group 3
[    2.733665] fsl_enetc 0000:00:00.2: device is disabled, skipping
[    2.739717] fsl_enetc 0000:00:00.6: Link attempted to 5000000.iommu 
0x54
[    2.746450] fsl_enetc 0000:00:00.6: Link done to 5000000.iommu 0x54 2
[    2.752940] fsl_enetc 0000:00:00.6: Adding to iommu group 4
[    2.758606] fsl_enetc 0000:00:00.6: device is disabled, skipping
[    2.764687] fsl_enetc_mdio 0000:00:00.3: Link attempted to 
5000000.iommu 0x54
[    2.771858] fsl_enetc_mdio 0000:00:00.3: Link done to 5000000.iommu 
0x54 2
[    2.778786] fsl_enetc_mdio 0000:00:00.3: Adding to iommu group 5
[    2.891472] fsl_enetc_mdio 0000:00:00.3: enabling device (0400 -> 
0402)
[    2.898295] libphy: FSL PCIe IE Central MDIO Bus: probed
[    2.903665] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.6.0-k
[    2.910659] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.916345] dwc3 3100000.usb: Link attempted to 5000000.iommu 0x54
[    2.922556] dwc3 3100000.usb: Link done to 5000000.iommu 0x44 2
[    2.928513] dwc3 3100000.usb: Adding to iommu group 6
[    2.933887] dwc3 3110000.usb: Link attempted to 5000000.iommu 0x54
[    2.940101] dwc3 3110000.usb: Link done to 5000000.iommu 0x44 2
[    2.946065] dwc3 3110000.usb: Adding to iommu group 7
[    2.951512] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) 
Driver
[    2.958069] ehci-pci: EHCI PCI platform driver
[    2.962698] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    2.968219] xhci-hcd xhci-hcd.0.auto: new USB bus registered, 
assigned bus number 1
[    2.976061] xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci 
version 0x100 quirks 0x0000000002010010
[    2.985516] xhci-hcd xhci-hcd.0.auto: irq 21, io mem 0x03100000
[    2.991841] hub 1-0:1.0: USB hub found
[    2.995623] hub 1-0:1.0: 1 port detected
[    2.999673] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
[    3.005189] xhci-hcd xhci-hcd.0.auto: new USB bus registered, 
assigned bus number 2
[    3.012885] xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 
SuperSpeed
[    3.019477] usb usb2: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    3.027812] hub 2-0:1.0: USB hub found
[    3.031592] hub 2-0:1.0: 1 port detected
[    3.035670] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    3.041188] xhci-hcd xhci-hcd.1.auto: new USB bus registered, 
assigned bus number 3
[    3.049019] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220f66d hci 
version 0x100 quirks 0x0000000002010010
[    3.058478] xhci-hcd xhci-hcd.1.auto: irq 22, io mem 0x03110000
[    3.064739] hub 3-0:1.0: USB hub found
[    3.068519] hub 3-0:1.0: 1 port detected
[    3.072559] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    3.078075] xhci-hcd xhci-hcd.1.auto: new USB bus registered, 
assigned bus number 4
[    3.085772] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 
SuperSpeed
[    3.092357] usb usb4: We don't know the algorithms for LPM for this 
host, disabling LPM.
[    3.100693] hub 4-0:1.0: USB hub found
[    3.104556] hub 4-0:1.0: 1 port detected
[    3.108685] usbcore: registered new interface driver usb-storage
[    3.115477] rtc-rv8803 0-0032: Voltage low, temperature compensation 
stopped.
[    3.122652] rtc-rv8803 0-0032: Voltage low, data loss detected.
[    3.129672] rtc-rv8803 0-0032: Voltage low, data is invalid.
[    3.135424] rtc-rv8803 0-0032: registered as rtc0
[    3.140826] rtc-rv8803 0-0032: Voltage low, data is invalid.
[    3.146516] rtc-rv8803 0-0032: hctosys: unable to read the hardware 
clock
[    3.153411] i2c /dev entries driver
[    3.162811] sp805-wdt c000000.watchdog: registration successful
[    3.168849] sp805-wdt c010000.watchdog: registration successful
[    3.175345] qoriq-cpufreq qoriq-cpufreq: Freescale QorIQ CPU 
frequency scaling driver
[    3.183972] sdhci: Secure Digital Host Controller Interface driver
[    3.190232] sdhci: Copyright(c) Pierre Ossman
[    3.194656] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.201034] sdhci-esdhc 2140000.mmc: Link attempted to 5000000.iommu 
0x54
[    3.207913] sdhci-esdhc 2140000.mmc: Link done to 5000000.iommu 0x44 
2
[    3.214728] sdhci-esdhc 2140000.mmc: Adding to iommu group 8
[    3.247591] mmc0: SDHCI controller on 2140000.mmc [2140000.mmc] using 
ADMA
[    3.254738] sdhci-esdhc 2150000.mmc: Link attempted to 5000000.iommu 
0x54
[    3.261670] sdhci-esdhc 2150000.mmc: Link done to 5000000.iommu 0x44 
2
[    3.268488] sdhci-esdhc 2150000.mmc: Adding to iommu group 9
[    3.302025] mmc1: SDHCI controller on 2150000.mmc [2150000.mmc] using 
ADMA
[    3.310942] usbcore: registered new interface driver usbhid
[    3.316639] usbhid: USB HID core driver
[    3.321829] wm8904 2-001a: supply DCVDD not found, using dummy 
regulator
[    3.328964] wm8904 2-001a: supply DBVDD not found, using dummy 
regulator
[    3.336051] wm8904 2-001a: supply AVDD not found, using dummy 
regulator
[    3.343070] wm8904 2-001a: supply CPVDD not found, using dummy 
regulator
[    3.350290] wm8904 2-001a: supply MICVDD not found, using dummy 
regulator
[    3.360310] wm8904 2-001a: revision A
[    3.373907] ------------[ cut here ]------------
[    3.378655] sup:22c0000.dma-controller - con:f140000.audio-controller 
f:192 s:2
[    3.386461] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:993 
__device_links_no_driver+0xf0/0xf8
[    3.395312] Modules linked in:
[    3.398406] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         
5.7.0-rc7-next-20200525-00001-ged5852b8c488-dirty #836
[    3.409698] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier (DT)
[    3.418027] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[    3.419539] usb 3-1: new high-speed USB device number 2 using 
xhci-hcd
[    3.423644] pc : __device_links_no_driver+0xf0/0xf8
[    3.423655] lr : __device_links_no_driver+0xf0/0xf8
[    3.423666] sp : ffff80001118bbb0
[    3.443376] x29: ffff80001118bbb0 x28: 0000000000000000
[    3.448734] x27: 0000000000000006 x26: ffff800010cd04e8
[    3.454090] x25: ffff800010d51960 x24: ffff00207a422c10
[    3.459444] x23: 0000000000000001 x22: ffff800010bd4698
[    3.464797] x21: ffff00207a422cb0 x20: ffff00207a401380
[    3.470150] x19: ffff00207a422c90 x18: 0000000000000001
[    3.475502] x17: 0000000000000000 x16: 0000000000000003
[    3.480855] x15: ffffffffffffffff x14: ffff800010ff9948
[    3.486208] x13: ffff8000112cbe08 x12: ffff8000112cbdfa
[    3.491560] x11: 0720072007200720 x10: 00000000000009f0
[    3.496914] x9 : ffff800010091f64 x8 : ffff00207ae50a50
[    3.502266] x7 : 0000000000000000 x6 : 0000000000000001
[    3.507618] x5 : 0000000000012890 x4 : 0000000000000000
[    3.512970] x3 : ffff80206ea0e000 x2 : ffff80001101b6c8
[    3.518322] x1 : 3ee0a21bc55cf800 x0 : 0000000000000000
[    3.523676] Call trace:
[    3.526148]  __device_links_no_driver+0xf0/0xf8
[    3.530715]  device_links_no_driver+0x74/0x90
[    3.535110]  really_probe+0x1ac/0x318
[    3.538805]  driver_probe_device+0x40/0x90
[    3.542936]  device_driver_attach+0x7c/0x88
[    3.547153]  __driver_attach+0x60/0xe8
[    3.550934]  bus_for_each_dev+0x7c/0xd0
[    3.554803]  driver_attach+0x2c/0x38
[    3.558409]  bus_add_driver+0x194/0x1f8
[    3.562278]  driver_register+0x6c/0x128
[    3.566151]  __platform_driver_register+0x50/0x60
[    3.570897]  fsl_sai_driver_init+0x24/0x30
[    3.575028]  do_one_initcall+0x54/0x298
[    3.578902]  kernel_init_freeable+0x1ec/0x268
[    3.583300]  kernel_init+0x1c/0x118
[    3.586819]  ret_from_fork+0x10/0x1c
[    3.590421] ---[ end trace e2cf5516fda822b1 ]---
[    3.596351] ------------[ cut here ]------------
[    3.601142] sup:22c0000.dma-controller - con:f150000.audio-controller 
f:192 s:2
[    3.608880] WARNING: CPU: 0 PID: 1 at drivers/base/core.c:993 
__device_links_no_driver+0xf0/0xf8
[    3.617729] Modules linked in:
[    3.620818] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         
5.7.0-rc7-next-20200525-00001-ged5852b8c488-dirty #836
[    3.632109] Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC 
Eval 2.0 carrier (DT)
[    3.640437] pstate: 60000005 (nZCv daif -PAN -UAO BTYPE=--)
[    3.646052] pc : __device_links_no_driver+0xf0/0xf8
[    3.650966] lr : __device_links_no_driver+0xf0/0xf8
[    3.655876] sp : ffff80001118bbb0
[    3.659214] x29: ffff80001118bbb0 x28: 0000000000000000
[    3.664568] x27: 0000000000000006 x26: ffff800010cd04e8
[    3.669921] x25: ffff800010d51960 x24: ffff00207a423010
[    3.675273] x23: 0000000000000001 x22: ffff800010bd4698
[    3.680625] x21: ffff00207a4230b0 x20: ffff00207a401400
[    3.685977] x19: ffff00207a423090 x18: 0000000000000010
[    3.691329] x17: 0000000000000000 x16: 0000000000000003
[    3.696681] x15: ffffffffffffffff x14: 0720072007200720
[    3.702034] x13: 0720072007200720 x12: 0720072007200720
[    3.707388] x11: 0720072007200720 x10: 00000000000009f0
[    3.712740] x9 : ffff800010091f64 x8 : ffff00207ae50a50
[    3.718092] x7 : 00000000ffffffff x6 : 0000000000000001
[    3.723445] x5 : 0000000000026318 x4 : 0000000000000000
[    3.728797] x3 : ffff80206ea0e000 x2 : ffff80001101b6c8
[    3.734148] x1 : 3ee0a21bc55cf800 x0 : 0000000000000000
[    3.739501] Call trace:
[    3.741971]  __device_links_no_driver+0xf0/0xf8
[    3.746536]  device_links_no_driver+0x74/0x90
[    3.750931]  really_probe+0x1ac/0x318
[    3.754624]  driver_probe_device+0x40/0x90
[    3.758755]  device_driver_attach+0x7c/0x88
[    3.762972]  __driver_attach+0x60/0xe8
[    3.766753]  bus_for_each_dev+0x7c/0xd0
[    3.770619]  driver_attach+0x2c/0x38
[    3.774225]  bus_add_driver+0x194/0x1f8
[    3.778094]  driver_register+0x6c/0x128
[    3.781966]  __platform_driver_register+0x50/0x60
[    3.786711]  fsl_sai_driver_init+0x24/0x30
[    3.790841]  do_one_initcall+0x54/0x298
[    3.794714]  kernel_init_freeable+0x1ec/0x268
[    3.799110]  kernel_init+0x1c/0x118
[    3.802630]  ret_from_fork+0x10/0x1c
[    3.806232] ---[ end trace e2cf5516fda822b2 ]---
[    3.814231] NET: Registered protocol family 10
[    3.820479] Segment Routing with IPv6
[    3.824834] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.831872] NET: Registered protocol family 17
[    3.836563] Bridge firewalling registered
[    3.840986] 8021q: 802.1Q VLAN Support v1.8
[    3.845354] Key type dns_resolver registered
[    3.850170] registered taskstats version 1
[    3.854411] Loading compiled-in X.509 certificates
[    3.865482] fsl-edma 22c0000.dma-controller: Link attempted to 
5000000.iommu 0x54
[    3.870243] mmc1: new HS400 MMC card at address 0001
[    3.873227] fsl-edma 22c0000.dma-controller: Link done to 
5000000.iommu 0x44 2
[    3.886624] fsl-edma 22c0000.dma-controller: Adding to iommu group 10
[    3.893881] mmcblk1: mmc1:0001 S0J58X 29.6 GiB
[    3.897220] pcieport 0001:00:00.0: Link attempted to 5000000.iommu 
0x54
[    3.899125] mmcblk1boot0: mmc1:0001 S0J58X partition 1 31.5 MiB
[    3.906282] pcieport 0001:00:00.0: Link done to 5000000.iommu 0x54 2
[    3.911856] mmcblk1boot1: mmc1:0001 S0J58X partition 2 31.5 MiB
[    3.918769] pcieport 0001:00:00.0: Adding to iommu group 11
[    3.923955] mmcblk1rpmb: mmc1:0001 S0J58X partition 3 4.00 MiB, 
chardev (245:0)
[    3.931177] pcieport 0001:00:00.0: AER: enabled with IRQ 24
[    3.940995]  mmcblk1: p1 p2
[    3.944231] pcieport 0002:00:00.0: Link attempted to 5000000.iommu 
0x54
[    3.952783] pcieport 0002:00:00.0: Link done to 5000000.iommu 0x54 2
[    3.960461] pcieport 0002:00:00.0: Adding to iommu group 12
[    3.967139] mmc0: Tuning failed, falling back to fixed sampling clock
[    3.973690] mmc0: tuning execution failed: -11
[    3.978715] mmc0: error -11 whilst initialising SD card
[    3.986303] pcieport 0002:00:00.0: AER: enabled with IRQ 26
[    3.992238] hub 3-1:1.0: USB hub found
[    3.996205] hub 3-1:1.0: 7 ports detected
[    4.000757] fsl-qdma 8380000.dma-controller: Link attempted to 
5000000.iommu 0x54
[    4.008679] fsl-qdma 8380000.dma-controller: Link done to 
5000000.iommu 0x44 2
[    4.016152] fsl-qdma 8380000.dma-controller: Adding to iommu group 13
[    4.022739] random: fast init done
[    4.031806] asoc-simple-card sound: wm8904-hifi <-> 
f150000.audio-controller mapping ok
[    4.042202] asoc-simple-card sound: wm8904-hifi <-> 
f140000.audio-controller mapping ok
[    4.050453] asoc-simple-card sound: ASoC: no DMI vendor name!
[    4.060914] irq: no irq domain found for sl28cpld@4a !
[    4.066219] irq: no irq domain found for sl28cpld@4a !
[    4.071577] gpio-keys buttons0: Found button without gpio or irq
[    4.077719] gpio-keys: probe of buttons0 failed with error -22
[    4.083992] ALSA device list:
[    4.086990]   #0: f150000.audio-controller-wm8904-hifi
[    4.097062] EXT4-fs (mmcblk1p2): INFO: recovery required on readonly 
filesystem
[    4.104524] EXT4-fs (mmcblk1p2): write access will be enabled during 
recovery
[    4.129244] EXT4-fs (mmcblk1p2): recovery complete
[    4.136609] EXT4-fs (mmcblk1p2): mounted filesystem with ordered data 
mode. Opts: (null)
[    4.145056] VFS: Mounted root (ext4 filesystem) readonly on device 
179:2.
[    4.152637] devtmpfs: mounted
[    4.165237] mmc0: new ultra high speed SDR104 SDHC card at address 
1234
[    4.167777] Freeing unused kernel memory: 3200K
[    4.176808] Run /sbin/init as init process
[    4.180973]   with arguments:
[    4.181560] mmcblk0: mmc0:1234 SA16G 14.4 GiB
[    4.183988]     /sbin/init
[    4.183994]   with environment:
[    4.184003]     HOME=/
[    4.197079]     TERM=linux
[    4.197109]  mmcblk0: p1
[    4.250330] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
[    4.343586] usb 3-1.6: new full-speed USB device number 3 using 
xhci-hcd
[    4.426118] udevd[128]: starting version 3.2.8
[    4.432917] random: udevd: uninitialized urandom read (16 bytes read)
[    4.440809] random: udevd: uninitialized urandom read (16 bytes read)
[    4.447516] random: udevd: uninitialized urandom read (16 bytes read)
[    4.459626] udevd[128]: specified group 'kvm' unknown
[    4.487594] udevd[129]: starting eudev-3.2.8
[    6.745883] fsl_enetc 0000:00:00.0 gbe0: renamed from eth0
[    9.579015] urandom_read: 3 callbacks suppressed
[    9.579028] random: dd: uninitialized urandom read (512 bytes read)
[    9.740749] Qualcomm Atheros AR8031/AR8033 0000:00:00.0:05: attached 
PHY driver [Qualcomm Atheros AR8031/AR8033] 
(mii_bus:phy_addr=0000:00:00.0:05, irq=POLL)
[    9.773881] fsl_enetc 0000:00:00.0 gbe0: Link is Down
[    9.833227] random: dropbear: uninitialized urandom read (32 bytes 
read)
[   11.812081] fsl_enetc 0000:00:00.0 gbe0: Link is Up - 10Mbps/Full - 
flow control off
[   11.819966] IPv6: ADDRCONF(NETDEV_CHANGE): gbe0: link becomes ready
[   12.835873] fsl_enetc 0000:00:00.0 gbe0: Link is Down
[   14.884068] fsl_enetc 0000:00:00.0 gbe0: Link is Up - 1Gbps/Full - 
flow control off


-michael

Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D764C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1CD205CB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r7KmP8re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgIDJqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgIDJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:46:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E710C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVSQdkJku0lzaY9hfTNOZl+VhauhkXuus8gnwioVvZ0=; b=r7KmP8reYtZ5ZsCivGMaq8+DKv
        6iA6HwrXC4ayxgumG9XSui/6uDIGPzfE4xKXM03lvv6O9v0QgXwB2n/L9FL815+cd0kodz4Qyeydz
        /AH1q0wAS1cjXnqO6Bt/iwwXw3Rjn4vvwdx5YH1rrxZMwTaVbnk/gnCd3PEkX4+UhjsXM3/8HLdTX
        ll6fvR/LiibeP2r5c29+0+/GsJ0GbyChj+09VFVmz+EV6wSpVy/r7nAYzKkAO0SBImhLeHEE2PhS6
        u6jSOj4Y7ls/eGVS197cLGAmO+7mfb3i+23/6DqFgV8iqCIt4QofJQLU1ZnyFDIpuKIbTvRUNnfbv
        Tf6vpY1w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE8IT-0007Mo-1x; Fri, 04 Sep 2020 09:46:17 +0000
Date:   Fri, 4 Sep 2020 10:46:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
Message-ID: <20200904094617.GA27846@infradead.org>
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
 <20200904083109.GA9182@infradead.org>
 <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:12:18PM +0530, Anup Patel wrote:
> I tried Linux-5.9-rc3 using nommu_virt_defconfig at my end. I am not
> able to reproduce
> this issue. Is there additional Kconfig option required to reproduce
> this issue ??

export CROSS_COMPILE=/usr/bin/riscv64-linux-gnu-
make ARCH=riscv nommu_virt_defconfig
make ARCH=riscv -j4 loader

/opt/qemu-riscv/bin/qemu-system-riscv64 \
        -smp 2 \
        -m 256 \
        -machine virt \
        -nographic \
        -kernel arch/riscv/boot/loader \
        -drive file=rootfs.ext2,format=raw,id=hd0 \
        -device virtio-blk-device,drive=hd0

> 
> anup@anup-ubuntu64-vm:~/Work/riscv-test/nommu$ qemu-system-riscv64 -M
> virt -m 8M -display none -nographic -kernel
> ./build-riscv64/arch/riscv/boot/loader -append "root=/dev/ram rw
> console=ttyS0" -smp 4
> qemu-system-riscv64: warning: No -bios option specified. Not loading a firmware.
> qemu-system-riscv64: warning: This default will change in a future
> QEMU release. Please use the -bios option to avoid breakages when this
> happens.
> qemu-system-riscv64: warning: See QEMU's deprecation documentation for details.
> [    0.000000] Linux version 5.9.0-rc3 (anup@anup-ubuntu64-vm)
> (riscv64-unknown-linux-gnu-gcc (GCC) 9.2.0, GNU ld (GNU Binutils)
> 2.34) #1 SMP Fri Sep 4 15:02:31 IST 2020
> [    0.000000] earlycon: uart8250 at MMIO 0x0000000010000000 (options
> '115200n8')
> [    0.000000] printk: bootconsole [uart8250] enabled
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000807fffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000807fffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000000807fffff]
> [    0.000000] riscv: ISA extensions acdfimsu
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: max_distance=0x30000 too large for vmalloc space 0x0
> [    0.000000] percpu: Embedded 12 pages/cpu s18592 r0 d30560 u49152
> [    0.000000] Built 1 zonelists, mobility grouping off.  Total pages: 2020
> [    0.000000] Kernel command line: root=/dev/vda rw
> earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0
> [    0.000000] Dentry cache hash table entries: 1024 (order: 1, 8192
> bytes, linear)
> [    0.000000] Inode-cache hash table entries: 512 (order: 0, 4096
> bytes, linear)
> [    0.000000] Sorting __ex_table...
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 6016K/8192K available (1283K kernel code, 138K
> rwdata, 200K rodata, 106K init, 133K bss, 2176K reserved, 0K
> cma-reserved)
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
> is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: plic@c000000: mapped 53 interrupts with 4
> handlers for 8 contexts.
> [    0.000000] random: get_random_bytes called from 0x00000000800019b4
> with crng_init=0
> [    0.000000] clint: clint@2000000: timer running at 10000000 Hz
> [    0.000000] clocksource: clint_clocksource: mask:
> 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120
> ns
> [    0.000212] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
> every 4398046511100ns
> [    0.016835] Console: colour dummy device 80x25
> [    0.034899] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 20.00 BogoMIPS (lpj=40000)
> [    0.050107] pid_max: default: 4096 minimum: 301
> [    0.051951] Mount-cache hash table entries: 512 (order: 0, 4096
> bytes, linear)
> [    0.052711] Mountpoint-cache hash table entries: 512 (order: 0,
> 4096 bytes, linear)
> [    0.151318] rcu: Hierarchical SRCU implementation.
> [    0.158697] smp: Bringing up secondary CPUs ...
> [    0.213140] smp: Brought up 1 node, 4 CPUs
> [    0.245903] devtmpfs: initialized
> [    0.262757] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.264822] futex hash table entries: 16 (order: -2, 1024 bytes, linear)
> [    0.413555] clocksource: Switched to clocksource clint_clocksource
> [    0.580364] workingset: timestamp_bits=62 max_order=11 bucket_order=0
> [    0.589640] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
> [    0.604478] printk: console [ttyS0] disabled
> [    0.611025] 10000000.uart: ttyS0 at MMIO 0x10000000 (irq = 2,
> base_baud = 230400) is a 16550A
> [    0.621897] printk: console [ttyS0] enabled
> [    0.621897] printk: console [ttyS0] enabled
> [    0.622997] printk: bootconsole [uart8250] disabled
> [    0.622997] printk: bootconsole [uart8250] disabled
> [    0.646964] syscon-poweroff soc:poweroff: pm_power_off already
> claimed (____ptrval____)
> [    0.648264] syscon-poweroff: probe of soc:poweroff failed with error -16
> [    0.677403] VFS: Cannot open root device "vda" or
> unknown-block(0,0): error -6
> [    0.679474] Please append a correct "root=" boot option; here are
> the available partitions:
> [    0.682862] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(0,0)
> 
> Regards,
> Anup
---end quoted text---

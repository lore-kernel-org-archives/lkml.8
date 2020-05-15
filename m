Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56661C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E18420728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4GZbv+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEON5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEON5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:57:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D899C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:57:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so3642932wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YqtEZA4AXPs4yASY3mfnlQTtzqgWuTVMj2nmC017yGo=;
        b=N4GZbv+XBK7BXJpzrkiUVs4IT20P3UWA0w4sbVRPoMsPDaDK/a1z3XU9eFNY0e5M9Q
         XtvqKAHNOBz27RroElB4vf73EQY2FznZ9jMW0ONotsRzpaPplywz+j/FUl+HWglePTlU
         gTjzNwJfuUqTmHrurz777+9FtHY0qemb+PeGsoL53HVOQITilApsGkfyz49x6qST3fpn
         r5y8tgstrvD9wmLsg8DIjd3hFPmMIXbHROPaGCU6jTaCdQAJLZ89KbZU83xcqs36ZXPq
         V3zsBLIpmx+D9qwJQFqV+0q9P7X6qPH6/XeUsjLrLSTBcVgxInSIcbCMZTquF2mowgVO
         dSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YqtEZA4AXPs4yASY3mfnlQTtzqgWuTVMj2nmC017yGo=;
        b=Lqui/1jqMH5IMFvXCz5KHl9rgGC6LtmmNDlxbQD6b+nAv8COIVeElPRh6ftXavvJfg
         NF30iCBl7f0IkMtC1MLqBNS6rUzs3rs7/anSkl8GwZ9snXkdtwm3qtoJjotK+sQJxuxr
         4lls8eZqV2MCnVRN3fg8VZs22C2PF9dxSFx4DgYRm7U3h7OtBpPP6rXmWzVxbdGldkah
         4+m6X9RIbrVEgJm/kjmNZWKz6iNUXeOYnv9Vy3DWwh/HHb2sKcXIqUzxFEWJ2xf/G4fW
         c3//d9aruESL/NfiQ7yZo+R85QKYRXG9/quEuv5f/bubsYeKLtumpr8HE2AQ9frNJhoJ
         m+ug==
X-Gm-Message-State: AOAM530hfwZ4+RzAP2/6DjPwbaXoPd3bmH9gSeE9oUtTfqXyHm7Z12oO
        pBqTi3f4SIzqIzy8HMcMTzw=
X-Google-Smtp-Source: ABdhPJzMkhfbxqjtfoLFO4h6chZ+Augljp8hw5UYF4RllT5Sdvz2kk0OFr/rGZCFJOVvtj+e6EYUtg==
X-Received: by 2002:a5d:5682:: with SMTP id f2mr4288569wrv.382.1589551034563;
        Fri, 15 May 2020 06:57:14 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u127sm3863377wme.8.2020.05.15.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:57:14 -0700 (PDT)
Date:   Fri, 15 May 2020 15:57:12 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: kexec: arm: possible overwrite of initrd
Message-ID: <20200515135712.GA5979@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Following https://lkml.org/lkml/2020/4/6/96 I was able to boot my Cubieboard4 via kexec reliabily.

But now I have started to use kernelCI builds, I got problems.
All sunxi_defconfig kernel works but not multi_v7_defconfig which got:
[    1.896540] Trying to unpack rootfs image as initramfs...
[    1.896947] rootfs image is not initramfs (invalid magic at start of compressed archive); looks like an initrd
Then:
[    3.927732] RAMDISK: Couldn't find valid RAM disk image starting at 0.
[    3.934489] VFS: Cannot open root device \"(null)\" or unknown-block(0,0): error -6

I have tryed to disable all related RD/RAMFS/compression CONFIGs without change.
Only the size of the kernel seems to matter which let me think that the initrd is overwritten by the kernel.

I use kexec-tools master
This is the output of my kexec run
run kexec with --debug --kexec-syscall --force --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
Try gzip decompression.
kernel: 0xb65c0008 kernel_size: 0x853200
MEMORY RANGES
0000000020000000-000000009fffffff (0)
zImage header: 0x016f2818 0x00000000 0x00853200
zImage size 0x853200, file size 0x853200
zImage requires 0x00864200 bytes
  offset 0x0000b810 tag 0x5a534c4b size 8
Decompressed kernel sizes:
 text+data 0x01563f54 bss 0x0005ca84 total 0x015c09d8
Resulting kernel space: 0x01dc8154
Kernel: address=0x20008000 size=0x01dc8154
Initrd: address=0x21dd1000 size=0x01c64369
DT    : address=0x23a36000 size=0x000060bb
kexec_load: entry = 0x20008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0xb65c0008
segment[0].bufsz = 0x853204
segment[0].mem   = 0x20008000
segment[0].memsz = 0x854000
segment[1].buf   = 0xb495b000
segment[1].bufsz = 0x1c64369
segment[1].mem   = 0x21dd1000
segment[1].memsz = 0x1c65000
segment[2].buf   = 0x4f030
segment[2].bufsz = 0x60bb
segment[2[   39.693411] sun7i-dwmac 830000.ethernet eth0: Link is Down
].mem   = 0x23a36000
segment[2].memsz = 0x7000
[   39.709586] kexec_core: Starting new kernel
[   40.120408] Bye!
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.6.11-dirty (compile@Red) (gcc version 9.2.0 (Gentoo 9.2.0-r2 p3)) #43 SMP Fri May 15 15:31:20 CEST 2020
[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt: Machine model: Cubietech Cubieboard4
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] Ignoring RAM at 0x50000000-0xa0000000
[    0.000000] Consider using a HIGHMEM enabled kernel.
[    0.000000] cma: Reserved 64 MiB at 0x4c000000
[    0.000000] percpu: Embedded 20 pages/cpu s49228 r8192 d24500 u81920
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 195072
[    0.000000] Kernel command line: 'console=ttyS0,115200n8
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 662712K/786432K available (12288K kernel code, 1455K rwdata, 4788K rodata, 2048K init, 370K bss, 58184K reserved, 65536K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=8.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x2fc/0x494 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000006] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000018] Switching to timer-based delay loop, resolution 41ns
[    0.001476] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.002630] Console: colour dummy device 80x30
[    0.002953] printk: console [tty0] enabled
[    0.002997] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.003026] pid_max: default: 32768 minimum: 301
[    0.003201] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.003237] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.003933] CPU: Testing write buffer coherency: ok
[    0.004409] CPU0: update cpu_capacity 523
[    0.004433] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.005032] Setting up static identity map for 0x20300000 - 0x203000ac
[    0.005475] ARM CCI driver probed
[    0.005783] sunxi multi cluster SMP support installed
[    0.006198] rcu: Hierarchical SRCU implementation.
[    0.008162] EFI services will not be available.
[    0.008500] smp: Bringing up secondary CPUs ...
[    0.009318] CPU1: update cpu_capacity 523
[    0.009324] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.010326] CPU2: update cpu_capacity 523
[    0.010333] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.011197] CPU3: update cpu_capacity 523
[    0.011203] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.012178] CPU4: update cpu_capacity 1538
[    0.012192] CPU4: thread -1, cpu 0, socket 1, mpidr 80000100
[    0.012208] CPU4: Spectre v2: using ICIALLU workaround
[    0.013422] CPU5: update cpu_capacity 1538
[    0.013435] CPU5: thread -1, cpu 1, socket 1, mpidr 80000101
[    0.013449] CPU5: Spectre v2: using ICIALLU workaround
[    0.014582] CPU6: update cpu_capacity 1538
[    0.014596] CPU6: thread -1, cpu 2, socket 1, mpidr 80000102
[    0.014611] CPU6: Spectre v2: using ICIALLU workaround
[    0.015757] CPU7: update cpu_capacity 1538
[    0.015771] CPU7: thread -1, cpu 3, socket 1, mpidr 80000103
[    0.015787] CPU7: Spectre v2: using ICIALLU workaround
[    0.016070] smp: Brought up 1 node, 8 CPUs
[    0.016110] SMP: Total of 8 processors activated (384.00 BogoMIPS).
[    0.016125] CPU: All CPU(s) started in SVC mode.
[    0.017054] devtmpfs: initialized
[    0.027537] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.027597] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.029778] pinctrl core: initialized pinctrl subsystem
[    0.032100] thermal_sys: Registered thermal governor 'step_wise'
[    0.032374] DMI not present or invalid.
[    0.032934] NET: Registered protocol family 16
[    0.035272] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.038735] cpuidle: using governor menu
[    0.038866] No ATAGs?
[    0.039281] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.039335] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.041953] Serial: AMBA PL011 UART driver
[    0.044873] sram 20000.sram: can't request region for resource [mem 0x00020000-0x0005ffff]
[    0.044925] sram 20000.sram: could not map SRAM registers
[    0.044976] sram: probe of 20000.sram failed with error -16
[    0.104030] AT91: Could not find identification node
[    0.105987] iommu: Default domain type: Translated 
[    0.106465] vgaarb: loaded
[    0.107861] SCSI subsystem initialized
[    0.108599] usbcore: registered new interface driver usbfs
[    0.108705] usbcore: registered new interface driver hub
[    0.108893] usbcore: registered new device driver usb
[    0.110629] pps_core: LinuxPPS API ver. 1 registered
[    0.110663] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.110732] PTP clock support registered
[    0.111020] EDAC MC: Ver: 3.0.0
[    0.114979] clocksource: Switched to clocksource arch_sys_counter
[    1.892786] NET: Registered protocol family 2
[    1.893828] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
[    1.893912] TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    1.894090] TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    1.894411] TCP: Hash tables configured (established 8192 bind 8192)
[    1.894622] UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
[    1.894725] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
[    1.895155] NET: Registered protocol family 1
[    1.896009] RPC: Registered named UNIX socket transport module.
[    1.896047] RPC: Registered udp transport module.
[    1.896077] RPC: Registered tcp transport module.
[    1.896106] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.896144] PCI: CLS 0 bytes, default 64
[    1.896540] Trying to unpack rootfs image as initramfs...
[    1.896947] rootfs image is not initramfs (invalid magic at start of compressed archive); looks like an initrd
[    2.040365] Freeing initrd memory: 29076K

Regards

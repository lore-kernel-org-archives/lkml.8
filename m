Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E89C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08DE20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 10:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgCXKqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 06:46:18 -0400
Received: from foss.arm.com ([217.140.110.172]:60498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgCXKqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 06:46:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC6C230E;
        Tue, 24 Mar 2020 03:46:15 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6AB3F792;
        Tue, 24 Mar 2020 03:46:14 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:46:12 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Oliver Neukum <oneukum@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200324104610.pqdtaocg6qctlnqv@e107158-lin>
References: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
 <1584977769.27949.18.camel@suse.de>
 <20200323172932.5s7txy2juhut5qdv@e107158-lin.cambridge.arm.com>
 <1585040918.7151.6.camel@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uf6xon2srgw5q6ii"
Content-Disposition: inline
In-Reply-To: <1585040918.7151.6.camel@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uf6xon2srgw5q6ii
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 03/24/20 10:08, Oliver Neukum wrote:
> Am Montag, den 23.03.2020, 17:29 +0000 schrieb Qais Yousef:
> > Hi Oliver
> 
> Hi,
> 
> > First time I use dynamic debugging, hopefully I've done correctly.
> 
> I am afraid not.
> 
> > 	echo "file drivers/usb/* +p" > /sys/kernel/debug/dynamic_debug/control
> 
> Overkill but correct. +mpf would be even better
> 
> > 	$REPRODUCE
> 
> Good
> 
> > 	cat /sys/kernel/debug/dynamic_debug/control | grep usb > usb.debug
> 
> No.
> 
> /sys/kernel/debug/dynamic_debug/control holds the collection of the
> messages that may be triggered, but it does not tell you which messages
> are triggered and in which order. The triggered messages end up
> in syslog. So you would use 'dmesg'
> I am afraid you redid the test correctly and then threw away the
> result.
> Could you redo it and just attach the output of dmesg?
> 
> 	Sorry

I should have stuck to what I know then. I misread the documentation. Hopefully
the attached looks better. I don't see the new debug you added emitted.

Thanks

--
Qais Yousef

--uf6xon2srgw5q6ii
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="usb.dmesg"

[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] Linux version 5.6.0-rc6-00002-g533440e608d2 (qyousef@e107158-lin) (gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)) #537 SMP PREEMPT Tue Mar 24 10:16:57 GMT 2020
[    0.000000] Machine model: ARM Juno development board (r2)
[    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x00000009ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x9fefdb000-0x9fefdcfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000]   DMA32    [mem 0x00000000c0000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
[    0.000000] On node 0 totalpages: 2093056
[    0.000000]   DMA zone: 4096 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 262144 pages, LIFO batch:63
[    0.000000]   DMA32 zone: 4096 pages used for memmap
[    0.000000]   DMA32 zone: 258048 pages, LIFO batch:63
[    0.000000]   Normal zone: 24576 pages used for memmap
[    0.000000]   Normal zone: 1572864 pages, LIFO batch:63
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 48 pages/cpu s159176 r8192 d29240 u196608
[    0.000000] pcpu-alloc: s159176 r8192 d29240 u196608 alloc=48*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] CPU features: detected: ARM erratum 843419
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2060288
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ttyAMA0,115200n8 root=/dev/nfs rw verbose debug ip=dhcp nfsroot=xx.xx.xx.xx:/mnt/data/exports/juno,vers=4,tcp nfsrootdebug rootwait earlycon=pl011,0x7ff80000 systemd.log_target=null user_debug=31 androidboot.hardware=juno loglevel=9 bootargs_sky2=sky2.mac_address=0x00,0x02,0xf7,0x00,0x67,0xbe
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0xbbfff000-0xbffff000] (64MB)
[    0.000000] Memory: 8044448K/8372224K available (25724K kernel code, 4126K rwdata, 12236K rodata, 14656K init, 11192K bss, 295008K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] ftrace: allocating 77609 entries in 304 pages
[    0.000000] ftrace: allocated 304 pages with 3 groups
[    0.000000] Running RCU self tests
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
[    0.000000] 	Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] GICv2m: range[mem 0x2c1c0000-0x2c1cffff], SPI[224:255]
[    0.000000] GICv2m: range[mem 0x2c1d0000-0x2c1dffff], SPI[256:287]
[    0.000000] GICv2m: range[mem 0x2c1e0000-0x2c1effff], SPI[288:319]
[    0.000000] GICv2m: range[mem 0x2c1f0000-0x2c1fffff], SPI[320:351]
[    0.000000] random: get_random_bytes called from start_kernel+0x5d8/0x784 with crng_init=0
[    0.000000] clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
[    0.000007] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.008555] Failed to initialize '/smb@8000000/motherboard/iofpga@3,00000000/timer@120000': -22
[    0.018098] arch_timer: cp15 and mmio timer(s) running at 50.00MHz (phys/phys).
[    0.025443] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.036273] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.045515] Console: colour dummy device 80x25
[    0.050047] printk: console [tty0] enabled
[    0.054293] printk: bootconsole [pl11] disabled
[    0.058985] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.059152] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.059252] ... MAX_LOCK_DEPTH:          48
[    0.059353] ... MAX_LOCKDEP_KEYS:        8192
[    0.059457] ... CLASSHASH_SIZE:          4096
[    0.059561] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.059667] ... MAX_LOCKDEP_CHAINS:      65536
[    0.059772] ... CHAINHASH_SIZE:          32768
[    0.059878]  memory used by lock dependency info: 6237 kB
[    0.060000]  memory used for stack traces: 4224 kB
[    0.060111]  per task-struct memory footprint: 1920 bytes
[    0.060233] ------------------------
[    0.060322] | Locking API testsuite:
[    0.060412] ----------------------------------------------------------------------------
[    0.060583]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.060754]   --------------------------------------------------------------------------
[    0.060934]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.079458]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.099597]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.121450]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.143252]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.166754]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.190217]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.213728]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.232179]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.250005]   --------------------------------------------------------------------------
[    0.250174]               recursive read-lock:             |  ok  |             |  ok  |
[    0.255815]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.261226]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.266651]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.272074]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
[    0.277794]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
[    0.283677]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
[    0.289568]   --------------------------------------------------------------------------
[    0.289899]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.297861]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.305876]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.313850]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.321869]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.329856]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.337879]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.345855]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.353875]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.361849]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.369867]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.378541]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.387259]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.395932]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.404647]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.413331]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.422056]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.430717]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.439420]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.447627]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.455885]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.464544]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.473249]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.481912]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.490637]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.499308]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.508034]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.516698]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.525421]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.534078]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.542801]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.551463]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.560185]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.568838]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.577560]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.586226]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.594948]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.603609]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.612335]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.620999]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.629714]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.638387]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.647101]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.655767]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.664501]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.673168]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.681885]       hard-irq read-recursion/123:  ok  |
[    0.684842]       soft-irq read-recursion/123:  ok  |
[    0.687847]       hard-irq read-recursion/132:  ok  |
[    0.690799]       soft-irq read-recursion/132:  ok  |
[    0.693801]       hard-irq read-recursion/213:  ok  |
[    0.696755]       soft-irq read-recursion/213:  ok  |
[    0.699754]       hard-irq read-recursion/231:  ok  |
[    0.702712]       soft-irq read-recursion/231:  ok  |
[    0.705716]       hard-irq read-recursion/312:  ok  |
[    0.708669]       soft-irq read-recursion/312:  ok  |
[    0.711670]       hard-irq read-recursion/321:  ok  |
[    0.714628]       soft-irq read-recursion/321:  ok  |
[    0.717628]   --------------------------------------------------------------------------
[    0.717796]   | Wound/wait tests |
[    0.717883]   ---------------------
[    0.717970]                   ww api failures:  ok  |  ok  |  ok  |
[    0.726471]                ww contexts mixing:  ok  |  ok  |
[    0.732069]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.743150]                locking mismatches:  ok  |  ok  |  ok  |
[    0.751625]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.780554]            spinlock nest unlocked:  ok  |
[    0.783275]   -----------------------------------------------------
[    0.783410]                                  |block | try  |context|
[    0.783545]   -----------------------------------------------------
[    0.783679]                           context:  ok  |  ok  |  ok  |
[    0.792405]                               try:  ok  |  ok  |  ok  |
[    0.800609]                             block:  ok  |  ok  |  ok  |
[    0.808865]                          spinlock:  ok  |  ok  |  ok  |
[    0.817805] -------------------------------------------------------
[    0.817940] Good, all 261 testcases passed! |
[    0.818042] ---------------------------------
[    0.818374] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.818650] pid_max: default: 32768 minimum: 301
[    0.819127] LSM: Security Framework initializing
[    0.819431] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.819637] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.855086] rcu: Hierarchical SRCU implementation.
[    0.872279] EFI services will not be available.
[    0.879406] smp: Bringing up secondary CPUs ...
[    0.925493] CPU features: detected: EL2 vector hardening
[    0.925506] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
[    0.925513] CPU features: detected: ARM erratum 1319367
[    0.925520] Detected PIPT I-cache on CPU1
[    0.925581] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[    0.969796] Detected PIPT I-cache on CPU2
[    0.969832] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[    1.014237] Detected VIPT I-cache on CPU3
[    1.014311] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[    1.058634] Detected VIPT I-cache on CPU4
[    1.058692] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[    1.103056] Detected VIPT I-cache on CPU5
[    1.103113] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[    1.103736] smp: Brought up 1 node, 6 CPUs
[    1.105371] SMP: Total of 6 processors activated.
[    1.105592] CPU features: detected: 32-bit EL0 Support
[    1.105727] CPU features: detected: CRC32 instructions
[    1.168474] CPU: All CPU(s) started at EL2
[    1.168736] alternatives: patching kernel code
[    1.173894] devtmpfs: initialized
[    1.193840] KASLR disabled due to lack of seed
[    1.195999] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.196122] futex hash table entries: 2048 (order: 6, 262144 bytes, linear)
[    1.197685] xor: measuring software checksum speed
[    1.234635]    8regs     :  4238.000 MB/sec
[    1.274844]    32regs    :  4762.000 MB/sec
[    1.315096]    arm64_neon:  4290.000 MB/sec
[    1.315150] xor: using function: 32regs (4762.000 MB/sec)
[    1.315220] pinctrl core: initialized pinctrl subsystem
[    1.317981] thermal_sys: Registered thermal governor 'step_wise'
[    1.317988] thermal_sys: Registered thermal governor 'power_allocator'
[    1.319705] DMI not present or invalid.
[    1.320967] NET: Registered protocol family 16
[    1.325075] DMA: preallocated 256 KiB pool for atomic allocations
[    1.325159] audit: initializing netlink subsys (disabled)
[    1.325695] audit: type=2000 audit(1.044:1): state=initialized audit_enabled=0 res=1
[    1.327803] cpuidle: using governor menu
[    1.328072] NET: Registered protocol family 42
[    1.328670] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.329170] ASID allocator initialised with 65536 entries
[    1.331184] Serial: AMBA PL011 UART driver
[    1.361153] 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 31, base_baud = 0) is a PL011 rev3
[    2.798369] printk: console [ttyAMA0] enabled
[    2.870617] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.877509] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    2.884316] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.891122] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    2.924275] cryptd: max_cpu_qlen set to 1000
[    3.021921] raid6: neonx8   gen()  3076 MB/s
[    3.094380] raid6: neonx8   xor()  2156 MB/s
[    3.166878] raid6: neonx4   gen()  3066 MB/s
[    3.239290] raid6: neonx4   xor()  2275 MB/s
[    3.311749] raid6: neonx2   gen()  2655 MB/s
[    3.384196] raid6: neonx2   xor()  2059 MB/s
[    3.456660] raid6: neonx1   gen()  1970 MB/s
[    3.529097] raid6: neonx1   xor()  1619 MB/s
[    3.601566] raid6: int64x8  gen()  1555 MB/s
[    3.674001] raid6: int64x8  xor()   899 MB/s
[    3.746469] raid6: int64x4  gen()  1788 MB/s
[    3.818905] raid6: int64x4  xor()   971 MB/s
[    3.891361] raid6: int64x2  gen()  1592 MB/s
[    3.963807] raid6: int64x2  xor()   846 MB/s
[    4.036254] raid6: int64x1  gen()  1225 MB/s
[    4.108747] raid6: int64x1  xor()   639 MB/s
[    4.113096] raid6: using algorithm neonx8 gen() 3076 MB/s
[    4.118582] raid6: .... xor() 2156 MB/s, rmw enabled
[    4.123628] raid6: using neon recovery algorithm
[    4.129207] ACPI: Interpreter disabled.
[    4.135997] iommu: Default domain type: Translated 
[    4.141562] vgaarb: loaded
[    4.145325] SCSI subsystem initialized
[    4.149678] libata version 3.00 loaded.
[    4.154233] usbcore: registered new interface driver usbfs
[    4.159929] usbcore: registered new interface driver hub
[    4.165531] usbcore: registered new device driver usb
[    4.173548] mc: Linux media interface: v0.10
[    4.177978] videodev: Linux video capture interface: v2.00
[    4.183822] pps_core: LinuxPPS API ver. 1 registered
[    4.188875] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.198170] PTP clock support registered
[    4.202965] EDAC MC: Ver: 3.0.0
[    4.208840] FPGA manager framework
[    4.212815] Advanced Linux Sound Architecture Driver Initialized.
[    4.220404] Bluetooth: Core ver 2.22
[    4.224123] NET: Registered protocol family 31
[    4.228653] Bluetooth: HCI device and connection manager initialized
[    4.235146] Bluetooth: HCI socket layer initialized
[    4.240120] Bluetooth: L2CAP socket layer initialized
[    4.245316] Bluetooth: SCO socket layer initialized
[    4.251866] clocksource: Switched to clocksource arch_sys_counter
[    5.094257] VFS: Disk quotas dquot_6.6.0
[    5.098389] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.106111] pnp: PnP ACPI: disabled
[    5.128825] NET: Registered protocol family 2
[    5.134147] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, linear)
[    5.143582] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    5.151961] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes, linear)
[    5.170386] TCP: Hash tables configured (established 65536 bind 65536)
[    5.177605] UDP hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    5.186030] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    5.195062] NET: Registered protocol family 1
[    5.201498] RPC: Registered named UNIX socket transport module.
[    5.207580] RPC: Registered udp transport module.
[    5.212385] RPC: Registered tcp transport module.
[    5.217186] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.224830] PCI: CLS 0 bytes, default 64
[    6.572338] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    6.581996] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    6.590456] kvm [1]: IPA Size Limit: 40bits
[    6.603487] kvm [1]: vgic interrupt IRQ1
[    6.608115] kvm [1]: Hyp mode initialized successfully
[    7.077003] rcu-torture:--- Start of test: nreaders=5 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
[    7.110912] rcu-torture: Creating rcu_torture_writer task
[    7.116921] rcu-torture: rcu_torture_writer task started
[    7.116978] rcu-torture: Creating rcu_torture_fakewriter task
[    7.122474] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    7.128706] rcu-torture: Creating rcu_torture_fakewriter task
[    7.128721] rcu-torture: rcu_torture_fakewriter task started
[    7.135516] rcu_torture_writer: Testing conditional GPs.
[    7.135529] rcu_torture_writer: Testing expedited GPs.
[    7.135541] rcu_torture_writer: Testing asynchronous GPs.
[    7.135553] rcu_torture_writer: Testing normal GPs.
[    7.169278] rcu-torture: Creating rcu_torture_fakewriter task
[    7.169332] rcu-torture: rcu_torture_fakewriter task started
[    7.175479] rcu-torture: Creating rcu_torture_fakewriter task
[    7.175508] rcu-torture: rcu_torture_fakewriter task started
[    7.192882] rcu-torture: rcu_torture_fakewriter task started
[    7.192892] rcu-torture: Creating rcu_torture_reader task
[    7.204420] rcu-torture: Creating rcu_torture_reader task
[    7.204461] rcu-torture: rcu_torture_reader task started
[    7.210172] rcu-torture: Creating rcu_torture_reader task
[    7.210201] rcu-torture: rcu_torture_reader task started
[    7.226585] rcu-torture: Creating rcu_torture_reader task
[    7.228494] rcu-torture: rcu_torture_reader task started
[    7.232344] rcu-torture: Creating rcu_torture_reader task
[    7.237625] rcu-torture: rcu_torture_reader task started
[    7.243256] rcu-torture: Creating rcu_torture_stats task
[    7.244853] rcu-torture: rcu_torture_reader task started
[    7.259962] rcu-torture: Creating torture_shuffle task
[    7.259968] rcu-torture: rcu_torture_stats task started
[    7.265475] rcu-torture: Creating torture_stutter task
[    7.275822] rcu-torture: torture_shuffle task started
[    7.281238] rcu-torture: Creating rcu_torture_fwd_prog task
[    7.287088] rcu-torture: torture_stutter task started
[    7.290982] Initialise system trusted keyrings
[    7.292318] rcu-torture: rcu_torture_fwd_progress task started
[    7.297206] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    7.338244] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.346622] NFS: Registering the id_resolver key type
[    7.351878] Key type id_resolver registered
[    7.356176] Key type id_legacy registered
[    7.360288] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.367522] fuse: init (API version 7.31)
[    7.373094] 9p: Installing v9fs 9p2000 file system support
[    7.402140] Key type asymmetric registered
[    7.406393] Asymmetric key parser 'x509' registered
[    7.411440] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    7.418983] io scheduler mq-deadline registered
[    7.423603] io scheduler kyber registered
[    7.443299] pl061_gpio 1c1d0000.gpio: PL061 GPIO chip registered
[    7.453154] pci-host-generic 40000000.pcie: host bridge /pcie@40000000 ranges:
[    7.460555] pci-host-generic 40000000.pcie:       IO 0x005f800000..0x005fffffff -> 0x0000000000
[    7.469469] pci-host-generic 40000000.pcie:      MEM 0x0050000000..0x0057ffffff -> 0x0050000000
[    7.478332] pci-host-generic 40000000.pcie:      MEM 0x4000000000..0x40ffffffff -> 0x4000000000
[    7.487282] pci-host-generic 40000000.pcie: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-ff]
[    7.496483] pci-host-generic 40000000.pcie: PCI host bridge to bus 0000:00
[    7.503487] pci_bus 0000:00: root bus resource [bus 00-ff]
[    7.509081] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
[    7.515554] pci_bus 0000:00: root bus resource [mem 0x50000000-0x57ffffff]
[    7.522555] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x40ffffffff pref]
[    7.530434] pci 0000:00:00.0: [1556:1100] type 01 class 0x060400
[    7.536607] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit pref]
[    7.544142] pci 0000:00:00.0: supports D1 D2
[    7.548504] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.557347] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.565770] pci 0000:01:00.0: [111d:8090] type 01 class 0x060400
[    7.572049] pci 0000:01:00.0: enabling Extended Tags
[    7.577301] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    7.597290] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.605812] pci 0000:02:01.0: [111d:8090] type 01 class 0x060400
[    7.612083] pci 0000:02:01.0: enabling Extended Tags
[    7.617356] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    7.624225] pci 0000:02:02.0: [111d:8090] type 01 class 0x060400
[    7.630498] pci 0000:02:02.0: enabling Extended Tags
[    7.635769] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    7.642594] pci 0000:02:03.0: [111d:8090] type 01 class 0x060400
[    7.648862] pci 0000:02:03.0: enabling Extended Tags
[    7.654133] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    7.661312] pci 0000:02:0c.0: [111d:8090] type 01 class 0x060400
[    7.667579] pci 0000:02:0c.0: enabling Extended Tags
[    7.672850] pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
[    7.679805] pci 0000:02:10.0: [111d:8090] type 01 class 0x060400
[    7.686059] pci 0000:02:10.0: enabling Extended Tags
[    7.691313] pci 0000:02:10.0: PME# supported from D0 D3hot D3cold
[    7.698750] pci 0000:02:1f.0: [111d:8090] type 01 class 0x060400
[    7.705018] pci 0000:02:1f.0: enabling Extended Tags
[    7.710287] pci 0000:02:1f.0: PME# supported from D0 D3hot D3cold
[    7.717099] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.725258] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.733423] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.741596] pci 0000:02:0c.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.749754] pci 0000:02:10.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.757908] pci 0000:02:1f.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.766376] pci 0000:03:00.0: [1095:3132] type 00 class 0x018000
[    7.772564] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000007f 64bit]
[    7.779501] pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x00003fff 64bit]
[    7.786422] pci 0000:03:00.0: reg 0x20: [io  0x0000-0x007f]
[    7.792133] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    7.799115] pci 0000:03:00.0: supports D1 D2
[    7.803979] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    7.815435] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    7.823681] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    7.831969] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    7.840257] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    7.848558] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    7.855611] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000
[    7.861796] pci 0000:08:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    7.868717] pci 0000:08:00.0: reg 0x18: [io  0x0000-0x00ff]
[    7.874629] pci 0000:08:00.0: supports D1 D2
[    7.878987] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.887674] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 08
[    7.894415] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 08
[    7.901151] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 08
[    7.907908] pci 0000:00:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    7.914903] pci 0000:00:00.0: BAR 0: assigned [mem 0x4000000000-0x4000003fff 64bit pref]
[    7.923140] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.929441] pci 0000:01:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    7.936433] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.942734] pci 0000:02:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
[    7.949726] pci 0000:02:1f.0: BAR 14: assigned [mem 0x50100000-0x501fffff]
[    7.956722] pci 0000:02:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    7.963027] pci 0000:02:1f.0: BAR 13: assigned [io  0x2000-0x2fff]
[    7.969336] pci 0000:03:00.0: BAR 6: assigned [mem 0x50000000-0x5007ffff pref]
[    7.976696] pci 0000:03:00.0: BAR 2: assigned [mem 0x50080000-0x50083fff 64bit]
[    7.984155] pci 0000:03:00.0: BAR 0: assigned [mem 0x50084000-0x5008407f 64bit]
[    7.991613] pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
[    7.997826] pci 0000:02:01.0: PCI bridge to [bus 03]
[    8.002888] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    8.009099] pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
[    8.016023] pci 0000:02:02.0: PCI bridge to [bus 04]
[    8.021115] pci 0000:02:03.0: PCI bridge to [bus 05]
[    8.026206] pci 0000:02:0c.0: PCI bridge to [bus 06]
[    8.031297] pci 0000:02:10.0: PCI bridge to [bus 07]
[    8.036397] pci 0000:08:00.0: BAR 0: assigned [mem 0x50100000-0x50103fff 64bit]
[    8.043882] pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
[    8.050092] pci 0000:02:1f.0: PCI bridge to [bus 08]
[    8.055153] pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
[    8.061363] pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
[    8.068290] pci 0000:01:00.0: PCI bridge to [bus 02-08]
[    8.073633] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    8.079883] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    8.086808] pci 0000:00:00.0: PCI bridge to [bus 01-08]
[    8.092132] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    8.098343] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    8.105696] pcieport 0000:00:00.0: enabling device (0000 -> 0003)
[    8.119956] pcieport 0000:00:00.0: PME: Signaling with IRQ 44
[    8.126905] pcieport 0000:00:00.0: AER: enabled with IRQ 44
[    8.133174] pcieport 0000:01:00.0: enabling device (0000 -> 0003)
[    8.139619] pcieport 0000:02:01.0: enabling device (0000 -> 0003)
[    8.150481] pcieport 0000:02:1f.0: enabling device (0000 -> 0003)
[    8.160437] IPMI message handler: version 39.2
[    8.165148] ipmi device interface
[    8.168672] ipmi_si: IPMI System Interface driver
[    8.174113] ipmi_si: Unable to find any System Interface(s)
[    8.181063] EINJ: ACPI disabled.
[    8.193709] dma-pl330 7ff00000.dma: WARN: Device release is not defined so it is not safe to unbind this driver while in use
[    8.206485] dma-pl330 7ff00000.dma: Loaded driver for PL330 DMAC-341330
[    8.213223] dma-pl330 7ff00000.dma: 	DBUFF-1024x16bytes Num_Chans-8 Num_Peri-8 Num_Events-8
[    8.238224] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.250126] SuperH (H)SCI(F) driver initialized
[    8.255426] msm_serial: driver initialized
[    8.263297] arm-smmu 7fb10000.iommu: probing hardware configuration...
[    8.269962] arm-smmu 7fb10000.iommu: SMMUv1 with:
[    8.274768] arm-smmu 7fb10000.iommu: 	stage 2 translation
[    8.280274] arm-smmu 7fb10000.iommu: 	non-coherent table walk
[    8.286124] arm-smmu 7fb10000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    8.293648] arm-smmu 7fb10000.iommu: 	stream matching with 2 register groups
[    8.300820] arm-smmu 7fb10000.iommu: 	1 context banks (1 stage-2 only)
[    8.307472] arm-smmu 7fb10000.iommu: 	Supported page sizes: 0x60211000
[    8.314117] arm-smmu 7fb10000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.321680] arm-smmu 7fb20000.iommu: probing hardware configuration...
[    8.328333] arm-smmu 7fb20000.iommu: SMMUv1 with:
[    8.333131] arm-smmu 7fb20000.iommu: 	stage 2 translation
[    8.338635] arm-smmu 7fb20000.iommu: 	non-coherent table walk
[    8.344489] arm-smmu 7fb20000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    8.352026] arm-smmu 7fb20000.iommu: 	stream matching with 2 register groups
[    8.359206] arm-smmu 7fb20000.iommu: 	1 context banks (1 stage-2 only)
[    8.365869] arm-smmu 7fb20000.iommu: 	Supported page sizes: 0x60211000
[    8.372530] arm-smmu 7fb20000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.379670] arm-smmu 7fb30000.iommu: probing hardware configuration...
[    8.386320] arm-smmu 7fb30000.iommu: SMMUv1 with:
[    8.391116] arm-smmu 7fb30000.iommu: 	stage 2 translation
[    8.396615] arm-smmu 7fb30000.iommu: 	coherent table walk
[    8.402122] arm-smmu 7fb30000.iommu: 	stream matching with 2 register groups
[    8.409299] arm-smmu 7fb30000.iommu: 	1 context banks (1 stage-2 only)
[    8.415948] arm-smmu 7fb30000.iommu: 	Supported page sizes: 0x60211000
[    8.422588] arm-smmu 7fb30000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.567995] tda998x 0-0070: found TDA19988
[    8.700032] tda998x 0-0071: found TDA19988
[    8.770858] loop: module loaded
[    8.909277] mpt3sas version 33.100.00.00 loaded
[    8.918139] sata_sil24 0000:03:00.0: version 1.1
[    8.922891] sata_sil24 0000:03:00.0: enabling device (0000 -> 0003)
[    8.932880] scsi host0: sata_sil24
[    8.937935] scsi host1: sata_sil24
[    8.941931] ata1: SATA max UDMA/100 host m128@0x50084000 port 0x50080000 irq 51
[    8.949371] ata2: SATA max UDMA/100 host m128@0x50084000 port 0x50082000 irq 51
[    8.964337] libphy: Fixed MDIO Bus: probed
[    8.970767] tun: Universal TUN/TAP device driver, 1.6
[    8.977464] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.713.36-0 (2014/02/10)
[    8.987430] thunder_xcv, ver 1.0
[    8.990880] thunder_bgx, ver 1.0
[    8.994307] nicpf, ver 1.0
[    8.997957] hclge is initializing
[    9.001745] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    9.009110] hns3: Copyright (c) 2017 Huawei Corporation.
[    9.014690] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    9.020626] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    9.026786] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
[    9.033865] igb: Copyright (c) 2007-2014 Intel Corporation.
[    9.039659] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    9.047614] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    9.054325] sky2: driver version 1.30
[    9.058390] sky2 0000:08:00.0: enabling device (0000 -> 0003)
[    9.064334] sky2 0000:08:00.0: Yukon-2 UL 2 chip revision 0
[    9.070122] sky2 0000:08:00.0 (unnamed net_device) (uninitialized): Invalid MAC address, defaulting to random
[    9.122388] libphy: smsc911x-mdio: probed
[    9.137784] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    9.145400] usbcore: registered new interface driver pegasus
[    9.151233] usbcore: registered new interface driver rtl8150
[    9.157096] usbcore: registered new interface driver r8152
[    9.162746] usbcore: registered new interface driver lan78xx
[    9.168604] usbcore: registered new interface driver asix
[    9.174168] usbcore: registered new interface driver ax88179_178a
[    9.180438] usbcore: registered new interface driver cdc_ether
[    9.186437] usbcore: registered new interface driver dm9601
[    9.192200] usbcore: registered new interface driver CoreChips
[    9.198235] usbcore: registered new interface driver smsc75xx
[    9.204176] usbcore: registered new interface driver smsc95xx
[    9.210087] usbcore: registered new interface driver net1080
[    9.215963] usbcore: registered new interface driver plusb
[    9.221634] usbcore: registered new interface driver cdc_subset
[    9.227726] usbcore: registered new interface driver zaurus
[    9.233461] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[    9.241085] usbcore: registered new interface driver cdc_ncm
[    9.247396] VFIO - User Level meta-driver version: 0.3
[    9.256195] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.262889] ehci-pci: EHCI PCI platform driver
[    9.267528] ehci-platform: EHCI generic platform driver
[    9.273435] ehci-platform 7ffc0000.ehci: Adding to iommu group 0
[    9.280068] ehci-platform 7ffc0000.ehci: EHCI Host Controller
[    9.286078] ehci-platform 7ffc0000.ehci: new USB bus registered, assigned bus number 1
[    9.294554] ehci-platform 7ffc0000.ehci: irq 34, io mem 0x7ffc0000
[    9.315965] ehci-platform 7ffc0000.ehci: USB 2.0 started, EHCI 1.00
[    9.325070] hub 1-0:1.0: USB hub found
[    9.329074] hub 1-0:1.0: 1 port detected
[    9.334431] ehci-orion: EHCI orion driver
[    9.338751] ehci-exynos: EHCI Exynos driver
[    9.343214] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    9.349530] ohci-pci: OHCI PCI platform driver
[    9.354170] ohci-platform: OHCI generic platform driver
[    9.359769] ohci-platform 7ffb0000.ohci: Adding to iommu group 0
[    9.366095] ohci-platform 7ffb0000.ohci: Generic Platform OHCI controller
[    9.373043] ohci-platform 7ffb0000.ohci: new USB bus registered, assigned bus number 2
[    9.381357] ohci-platform 7ffb0000.ohci: irq 33, io mem 0x7ffb0000
[    9.465980] hub 2-0:1.0: USB hub found
[    9.469922] hub 2-0:1.0: 1 port detected
[    9.474925] ohci-exynos: OHCI Exynos driver
[    9.480138] usbcore: registered new interface driver usb-storage
[    9.495052] rtc-pl031 1c170000.rtc: registered as rtc0
[    9.501816] i2c /dev entries driver
[    9.510750] usbcore: registered new interface driver uvcvideo
[    9.516601] USB Video Class driver (1.1.1)
[    9.520780] gspca_main: v2.14.0 registered
[    9.531569] sp805-wdt 1c0f0000.wdt: registration successful
[    9.540146] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    9.548791] Bluetooth: HCI UART driver ver 2.3
[    9.553326] Bluetooth: HCI UART protocol H4 registered
[    9.558609] Bluetooth: HCI UART protocol LL registered
[    9.564081] Bluetooth: HCI UART protocol Broadcom registered
[    9.569971] usbcore: registered new interface driver btusb
[    9.578149] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 9,0 (pio)
[    9.612337] sdhci: Secure Digital Host Controller Interface driver
[    9.618760] sdhci: Copyright(c) Pierre Ossman
[    9.623910] Synopsys Designware Multimedia Card Interface Driver
[    9.631804] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.641121] leds-syscon 1c010000.apbregs:led0: registered LED vexpress:0
[    9.648501] leds-syscon 1c010000.apbregs:led1: registered LED vexpress:1
[    9.655722] leds-syscon 1c010000.apbregs:led2: registered LED vexpress:2
[    9.663004] leds-syscon 1c010000.apbregs:led3: registered LED vexpress:3
[    9.670217] leds-syscon 1c010000.apbregs:led4: registered LED vexpress:4
[    9.675925] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    9.677555] leds-syscon 1c010000.apbregs:led5: registered LED vexpress:5
[    9.691379] leds-syscon 1c010000.apbregs:led6: registered LED vexpress:6
[    9.698697] leds-syscon 1c010000.apbregs:led7: registered LED vexpress:7
[    9.706674] ledtrig-cpu: registered to indicate activity on CPUs
[    9.716940] usbcore: registered new interface driver usbhid
[    9.718536] hub 1-1:1.0: USB hub found
[    9.722710] usbhid: USB HID core driver
[    9.726796] hub 1-1:1.0: 4 ports detected
[    9.731660] mhu 2b1f0000.mhu: ARM MHU Mailbox registered
[    9.753570] drop_monitor: Initializing network drop monitor service
[    9.764502] NET: Registered protocol family 10
[    9.771387] Segment Routing with IPv6
[    9.775683] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.783056] NET: Registered protocol family 17
[    9.787822] Bridge firewalling registered
[    9.791925] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.797958] Bluetooth: HIDP socket layer initialized
[    9.803093] 8021q: 802.1Q VLAN Support v1.8
[    9.807737] 9pnet: Installing 9P2000 support
[    9.812269] Key type dns_resolver registered
[    9.818002] registered taskstats version 1
[    9.818711] random: fast init done
[    9.822216] Loading compiled-in X.509 certificates
[    9.833679] Btrfs loaded, crc32c=crc32c-generic
[    9.849847] scpi_protocol scpi: SCP Protocol 1.2 Firmware 1.21.0 version
[    9.902826] arm-smmu 2b600000.iommu: probing hardware configuration...
[    9.909730] arm-smmu 2b600000.iommu: SMMUv1 with:
[    9.914561] arm-smmu 2b600000.iommu: 	stage 2 translation
[    9.920057] arm-smmu 2b600000.iommu: 	coherent table walk
[    9.925554] arm-smmu 2b600000.iommu: 	stream matching with 2 register groups
[    9.932718] arm-smmu 2b600000.iommu: 	1 context banks (1 stage-2 only)
[    9.939356] arm-smmu 2b600000.iommu: 	Supported page sizes: 0x60211000
[    9.945999] arm-smmu 2b600000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    9.955816] input: smb@8000000:motherboard:gpio-keys as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:gpio-keys/input/input1
[    9.972285] rtc-pl031 1c170000.rtc: setting system clock to 2020-03-24T10:26:12 UTC (1585045572)
[   10.300127] usb 1-1.1: new high-speed USB device number 3 using ehci-platform
[   10.349460] usb-storage 1-1.1:1.0: USB Mass Storage device detected
[   10.363200] scsi host2: usb-storage 1-1.1:1.0
[   10.503999] atkbd serio0: keyboard reset failed on 1c060000.kmi
[   10.960092] ata1: SATA link down (SStatus 0 SControl 0)
[   11.410625] scsi 2:0:0:0: Direct-Access     TOSHIBA  TransMemory      PMAP PQ: 0 ANSI: 6
[   11.427539] sd 2:0:0:0: [sda] 30253056 512-byte logical blocks: (15.5 GB/14.4 GiB)
[   11.437183] sd 2:0:0:0: [sda] Write Protect is off
[   11.442275] sd 2:0:0:0: [sda] Mode Sense: 45 00 00 00
[   11.449859] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   11.532644]  sda: sda1 sda2
[   11.554491] sd 2:0:0:0: [sda] Attached SCSI removable disk
[   11.751890] atkbd serio1: keyboard reset failed on 1c070000.kmi
[   13.016042] ata2: SATA link down (SStatus 0 SControl 0)
[   13.027503] sky2 0000:08:00.0 eth0: enabling interface
[   13.034374] Generic PHY 18000000.ethernet-ffffffff:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=18000000.ethernet-ffffffff:01, irq=POLL)
[   13.049029] smsc911x 18000000.ethernet eth1: SMSC911x/921x identified at 0xffff800018ca0000, IRQ: 8
[   15.120048] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   15.271436] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.280364] ALSA device list:
[   15.283426]   No soundcards found.
[   15.287501] uart-pl011 7ff80000.uart: no DMA platform data
[   15.293135] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   15.331598] Freeing unused kernel memory: 14656K
[   15.368044] Run /init as init process
[   15.371814]   with arguments:
[   15.376160]     /init
[   15.378500]     ttyAMA0,115200n8
[   15.381866]     verbose
[   15.384435]     nfsrootdebug
[   15.387392]   with environment:
[   15.390678]     HOME=/
[   15.393159]     TERM=linux
[   15.396026]     user_debug=31
[   15.399071]     bootargs_sky2=sky2.mac_address=0x00,0x02,0xf7,0x00,0x67,0xbe
[   15.520448] Adding 2543608k swap on /dev/sda2.  Priority:-2 extents:1 across:2543608k 
[   18.653510] input: PS/2 Generic Mouse as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c060000.kmi/serio0/input/input3
[   18.797800] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[   19.752741] random: dd: uninitialized urandom read (512 bytes read)
[   19.871823] random: ssh-keygen: uninitialized urandom read (32 bytes read)
[   19.903479] random: sshd: uninitialized urandom read (32 bytes read)
[   19.978048] sky2 0000:08:00.0 eth0: enabling interface
[   25.360833] input: PS/2 Generic Mouse as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c070000.kmi/serio1/input/input4
[   25.496980] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[   51.795983] Adding 2543608k swap on /dev/sda2.  Priority:-2 extents:1 across:2543608k 
[   58.003911] Adding 2543608k swap on /dev/sda2.  Priority:-2 extents:1 across:2543608k 
[   68.871904] rcu-torture: rtc: (____ptrval____) ver: 1352 tfle: 0 rta: 1353 rtaf: 0 rtf: 1341 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 24895 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[   68.891877] rcu-torture: Reader Pipe:  15093251 3894 0 0 0 0 0 0 0 0 0
[   68.898586] rcu-torture: Reader Batch:  15088478 8668 0 0 0 0 0 0 0 0 0
[   68.905361] rcu-torture: Free-Block Circulation:  1352 1351 1350 1349 1348 1347 1345 1344 1342 1341 0
[   77.064682] cfg80211: failed to load regulatory.db
[   82.483925] rcu_torture_fwd_prog_nr: Duration 3313 cver 132 gps 323
[   83.050946] rcu_torture_fwd_prog_cr Duration 29 barrier: 52 pending 11716 n_launders: 13871 n_launders_sa: 4213 n_max_gps: 100 n_max_cbs: 11831 cver 2 gps 7
[   83.135905] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 103 jiffies): 1s/10: 7996:6 2s/10: 17706:4
[  130.311938] rcu-torture: rtc: (____ptrval____) ver: 2845 tfle: 0 rta: 2845 rtaf: 0 rtf: 2833 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 49544 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  130.331472] rcu-torture: Reader Pipe:  30267437 8086 0 0 0 0 0 0 0 0 0
[  130.338371] rcu-torture: Reader Batch:  30258284 17244 0 0 0 0 0 0 0 0 0
[  130.345317] rcu-torture: Free-Block Circulation:  2847 2844 2842 2841 2839 2838 2837 2836 2834 2833 0
[  155.448590] PM: hibernation: hibernation entry
[  155.460881] Filesystems sync: 0.001 seconds
[  155.465293] Freezing user space processes ... (elapsed 0.002 seconds) done.
[  155.475391] OOM killer disabled.
[  155.483313] PM: hibernation: Preallocating image memory
[  157.508143] ------------[ cut here ]------------
[  157.512899] WARNING: CPU: 0 PID: 261 at kernel/rcu/rcutorture.c:1055 rcu_torture_writer+0x664/0xa90
[  157.522134] Modules linked in:
[  157.525267] CPU: 0 PID: 261 Comm: rcu_torture_wri Not tainted 5.6.0-rc6-00002-g533440e608d2 #537
[  157.534233] Hardware name: ARM Juno development board (r2) (DT)
[  157.540278] pstate: 00000005 (nzcv daif -PAN -UAO)
[  157.545175] pc : rcu_torture_writer+0x664/0xa90
[  157.549805] lr : rcu_torture_writer+0x65c/0xa90
[  157.554432] sp : ffff800018b63de0
[  157.557821] x29: ffff800018b63de0 x28: ffff80001426e320 
[  157.563253] x27: ffff80001426cf08 x26: ffff80001426cf08 
[  157.568683] x25: ffff8000121b5000 x24: 0000000000000001 
[  157.574111] x23: ffff80001426d648 x22: ffff80001426b000 
[  157.579540] x21: ffff800013439000 x20: ffff80001426e938 
[  157.584968] x19: ffff80001426c000 x18: 0000000000000000 
[  157.590397] x17: 0000000000000000 x16: 0000000000000000 
[  157.595825] x15: 0000000000000000 x14: 0000000000000000 
[  157.601254] x13: 0000000000000000 x12: 0000000000000003 
[  157.606682] x11: 000000000000050f x10: 0000000000000000 
[  157.612116] x9 : ffff800013a130a0 x8 : ffff000975051fd0 
[  157.617547] x7 : 0000000000000000 x6 : ffff800018b63cc0 
[  157.622977] x5 : 0000000000000001 x4 : 0000000000000000 
[  157.628406] x3 : 0000000000000080 x2 : 0000000002611501 
[  157.633835] x1 : 0000000000000000 x0 : 0000000000000001 
[  157.639265] Call trace:
[  157.641775]  rcu_torture_writer+0x664/0xa90
[  157.646054]  kthread+0x13c/0x140
[  157.649359]  ret_from_fork+0x10/0x18
[  157.653016] irq event stamp: 113198
[  157.656590] hardirqs last  enabled at (113197): [<ffff800010114300>] __local_bh_enable_ip+0x98/0x148
[  157.665917] hardirqs last disabled at (113198): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
[  157.675154] softirqs last  enabled at (113196): [<ffff8000101b92a4>] rcu_torture_free+0x84/0x98
[  157.684038] softirqs last disabled at (113194): [<ffff8000101b9280>] rcu_torture_free+0x60/0x98
[  157.692916] ---[ end trace dc3eeb58f7182c07 ]---
[  157.787490] PM: hibernation: Allocated 97253 pages for snapshot
[  157.793533] PM: hibernation: Allocated 389012 kbytes in 2.29 seconds (169.87 MB/s)
[  157.801242] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[  157.813411] printk: Suspending console(s) (use no_console_suspend to debug)
[  157.872686] usbcore:hub_suspend: hub 1-1:1.0: hub_suspend
[  157.872801] ehci_hcd:qh_unlink_periodic: usb 1-1: unlink qh256-0001/(____ptrval____) start 1 [1/0 us]
[  157.875261] usbcore:hub_suspend: hub 1-0:1.0: hub_suspend
[  157.875422] usbcore:hcd_bus_suspend: usb usb1: bus suspend, wakeup 0
[  157.875435] ehci_hcd:ehci_bus_suspend: ehci-platform 7ffc0000.ehci: suspend root hub
[  157.918359] Disabling non-boot CPUs ...
[  157.922121] CPU1: shutdown
[  157.922214] psci: CPU1 killed (polled 0 ms)
[  157.931368] CPU2: shutdown
[  157.931919] psci: CPU2 killed (polled 4 ms)
[  157.958718] CPU3: shutdown
[  157.958742] psci: CPU3 killed (polled 0 ms)
[  157.978433] CPU4: shutdown
[  157.978457] psci: CPU4 killed (polled 0 ms)
[  157.987192] CPU5: shutdown
[  157.987216] psci: CPU5 killed (polled 0 ms)
[  157.989182] PM: hibernation: Creating image:
[  157.989182] PM: hibernation: Need to copy 95313 pages
[  157.989182] PM: hibernation: Image created (95313 pages copied)
[  157.989984] Enabling non-boot CPUs ...
[  158.003937] Detected PIPT I-cache on CPU1
[  158.004001] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[  158.007405] CPU1 is up
[  158.029491] Detected PIPT I-cache on CPU2
[  158.029529] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[  158.030995] CPU2 is up
[  158.044660] Detected VIPT I-cache on CPU3
[  158.044745] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[  158.047796] CPU3 is up
[  158.061584] Detected VIPT I-cache on CPU4
[  158.061649] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[  158.064910] CPU4 is up
[  158.078695] Detected VIPT I-cache on CPU5
[  158.078758] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[  158.083170] CPU5 is up
[  158.103957] usbcore:hcd_bus_resume: usb usb1: usb resume
[  158.103986] ehci_hcd:ehci_bus_resume: ehci-platform 7ffc0000.ehci: resume root hub
[  158.113836] ohci_hcd:ohci_resume: ohci-platform 7ffb0000.ohci: powerup ports
[  158.139682] usbcore:hcd_bus_resume: usb usb2: usb resume
[  158.139715] ohci_hcd:ohci_rh_resume: ohci-platform 7ffb0000.ohci: resume root hub
[  158.162826] usbcore:hub_resume: hub 1-0:1.0: hub_resume
[  158.163176] usbcore:hub_activate: usb usb1-port1: status 0503 change 0000
[  158.163369] usbcore:hub_resume: hub 1-1:1.0: hub_resume
[  158.163735] usbcore:hub_activate: usb 1-1-port1: status 0503 change 0000
[  158.164492] ehci_hcd:qh_schedule: ehci-platform 7ffc0000.ehci: reused qh (____ptrval____) schedule
[  158.164506] ehci_hcd:qh_link_periodic: usb 1-1: link qh256-0001/(____ptrval____) start 1 [1/0 us]
[  158.219604] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  158.220482] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[  158.482995] PM: Cannot find swap device, try swapon -a
[  158.488379] PM: Cannot get swap writer
[  159.064094] OOM killer enabled.
[  159.067351] Restarting tasks ... 
[  159.068831] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  159.079921] usbcore:hub_event: hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
[  159.079959] usbcore:hub_event: hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  159.090776] done.
[  159.097076] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  159.102961] ------------[ cut here ]------------
[  159.107805] URB (____ptrval____) submitted while active
[  159.113322] WARNING: CPU: 5 PID: 388 at drivers/usb/core/urb.c:363 usb_submit_urb+0x3d8/0x590
[  159.122054] Modules linked in:
[  159.125350] CPU: 5 PID: 388 Comm: kworker/5:2 Tainted: G        W         5.6.0-rc6-00002-g533440e608d2 #537
[  159.125365] Hardware name: ARM Juno development board (r2) (DT)
[  159.125379] Workqueue: usb_hub_wq hub_event
[  159.125396] pstate: 40000005 (nZcv daif -PAN -UAO)
[  159.150713] pc : usb_submit_urb+0x3d8/0x590
[  159.150724] lr : usb_submit_urb+0x3d8/0x590
[  159.150732] sp : ffff8000190938b0
[  159.150740] x29: ffff8000190938b0 x28: 0000000000000003 
[  159.150755] x27: ffff000970512b20 x26: ffff80001340d000 
[  159.150769] x25: ffff80001340d000 x24: ffff800019093b38 
[  159.150783] x23: 0000000000000004 x22: 0000000000000c00 
[  159.150797] x21: 0000000000000000 x20: 00000000fffffff0 
[  159.150811] x19: ffff0009704ef700 x18: ffffffffffffffff 
[  159.150825] x17: 0000000000000000 x16: 0000000000000000 
[  159.150839] x15: ffff80001340da88 x14: 0720072007200720 
[  159.150853] x13: 0720072007200720 x12: 0720072007200720 
[  159.150867] x11: 0000000000000000 x10: 00000000b9d5c580 
[  159.150881] x9 : 0000000000000002 x8 : ffff00097504a020 
[  159.150895] x7 : 0000000000000000 x6 : ffff00097efb6450 
[  159.150911] x5 : ffff00097efb6450 x4 : 0000000000000000 
[  159.150942] PM: hibernation: hibernation exit
[  159.240807] x3 : ffff00097efc6070 x2 : 0000000000000001 
[  159.246257] x1 : 9f98e61376502200 x0 : 0000000000000000 
[  159.251708] Call trace:
[  159.254228]  usb_submit_urb+0x3d8/0x590
[  159.258167]  hub_activate+0x108/0x7f0
[  159.261929]  hub_resume+0xac/0x148
[  159.265426]  usb_resume_interface.isra.10+0x60/0x138
[  159.270519]  usb_resume_both+0xe4/0x140
[  159.274460]  usb_runtime_resume+0x24/0x30
[  159.278579]  __rpm_callback+0xdc/0x138
[  159.282430]  rpm_callback+0x34/0x98
[  159.286015]  rpm_resume+0x4a8/0x720
[  159.289601]  rpm_resume+0x50c/0x720
[  159.293186]  __pm_runtime_resume+0x4c/0xb8
[  159.297393]  usb_autopm_get_interface+0x28/0x60
[  159.302041]  hub_event+0x80/0x16d8
[  159.305540]  process_one_work+0x2a4/0x748
[  159.309659]  worker_thread+0x48/0x498
[  159.313422]  kthread+0x13c/0x140
[  159.316742]  ret_from_fork+0x10/0x18
[  159.320413] irq event stamp: 1628
[  159.323825] hardirqs last  enabled at (1627): [<ffff80001019ea1c>] console_unlock+0x504/0x5b8
[  159.332561] hardirqs last disabled at (1628): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
[  159.341650] softirqs last  enabled at (1624): [<ffff8000100818a4>] __do_softirq+0x4bc/0x568
[  159.350207] softirqs last disabled at (1613): [<ffff8000101145a4>] irq_exit+0x144/0x150
[  159.358406] ---[ end trace dc3eeb58f7182c08 ]---
[  159.363503] hub 2-0:1.0: activate --> -16
[  159.367776] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  159.375217] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[  159.380981] usbcore:hcd_bus_suspend: usb usb2: bus auto-suspend, wakeup 1
[  159.388048] ohci_hcd:ohci_rh_suspend: ohci-platform 7ffb0000.ohci: suspend root hub
[  159.767477] rcu_torture_fwd_prog_nr: Duration 3762 cver 287 gps 446
[  160.127595] ata1: SATA link down (SStatus 0 SControl 0)
[  160.199587] ata2: SATA link down (SStatus 0 SControl 0)
[  160.364599] rcu_torture_fwd_prog_cr Duration 60 barrier: 31 pending 14166 n_launders: 41977 n_launders_sa: 32650 n_max_gps: 100 n_max_cbs: 25188 cver 0 gps 13
[  160.378993] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 94 jiffies): 1s/10: 9328:3 2s/10: 34895:6 3s/10: 22942:7
[  161.166729] usbcore:usb_remote_wakeup: usb usb2: usb wakeup-resume
[  161.173564] usbcore:hcd_bus_resume: usb usb2: usb auto-resume
[  161.179575] ohci_hcd:ohci_rh_resume: ohci-platform 7ffb0000.ohci: resume root hub
[  161.259656] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  161.265457] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  161.272917] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[  161.279238] usbcore:hcd_bus_suspend: usb usb2: bus auto-suspend, wakeup 1
[  161.286336] ohci_hcd:ohci_rh_suspend: ohci-platform 7ffb0000.ohci: suspend root hub
[  164.787580] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[  171.429093] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[  171.510004] random: crng init done
[  187.479501] cpufreq: __target_index: Failed to change cpu frequency: -5
[  187.555502] cpufreq: __target_index: Failed to change cpu frequency: -5
[  187.623502] cpufreq: __target_index: Failed to change cpu frequency: -5

--uf6xon2srgw5q6ii--

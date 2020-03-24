Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF27C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6491A20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbgCXOGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:06:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:06:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 231021FB;
        Tue, 24 Mar 2020 07:06:14 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6843F52E;
        Tue, 24 Mar 2020 07:06:13 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:06:10 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200324140609.gqvjgxdbcm5ndhvo@e107158-lin>
References: <20200324134353.eamiridhnjrmirgt@e107158-lin>
 <Pine.LNX.4.44L0.2003240949180.4640-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pbstite62b3gsbf2"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003240949180.4640-100000@netrider.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pbstite62b3gsbf2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 03/24/20 09:52, Alan Stern wrote:
> On Tue, 24 Mar 2020, Qais Yousef wrote:
> 
> > On 03/24/20 14:20, Oliver Neukum wrote:
> > > Am Dienstag, den 24.03.2020, 10:46 +0000 schrieb Qais Yousef:
> > > > 
> > > > I should have stuck to what I know then. I misread the documentation. Hopefully
> > > > the attached looks better. I don't see the new debug you added emitted.
> > > 
> > > That is odd. Please try
> > > 
> > > echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> > > 
> > > with the attached improved patch.
> > 
> > Hmm still no luck
> > 
> > 
> > # history
> >    0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
> >    1 swapoff -a
> >    2 echo suspend > /sys/power/disk
> >    3 echo disk > /sys/power/state
> >    4 dmesg > usb.dmesg
> 
> What happens if you omit step 1 (the swapoff)?

It seems to hibernate (suspend) successfully. If I omit that step I must setup
a wakealarm to trigger the wakeup, but that's it.

I attached the dmesg; I didn't reboot the system in between.


# history
   0 echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control
   1 swapoff -a
   2 echo suspend > /sys/power/disk
   3 echo disk > /sys/power/state
   4 dmesg > usb.dmesg
   5 history
   6 grep URB /sys/kernel/debug/dynamic_debug/control
   7 grep "URB allocated" /sys/kernel/debug/dynamic_debug/control
   8 swapon -a
   9 echo +60 > /sys/class/rtc/rtc0/wakealarm
  10 echo disk > /sys/power/state
  11 dmesg > usb.dmesg


Thanks

--
Qais Yousef

> 
> > $ git log -p
> > commit dfd1731f9a3e7592135d2a6b2a5c5e1640a7eea4 (HEAD)
> > Author: Oliver Neukum <oneukum@suse.com>
> > Date:   Mon Mar 23 16:34:35 2020 +0100
> > 
> >     usb: hub additional debugging
> > 
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 54cd8ef795ec..12ce2fdc4c2a 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -1629,6 +1629,7 @@ static int hub_configure(struct usb_hub *hub,
> >                 ret = -ENOMEM;
> >                 goto fail;
> >         }
> > +       dev_dbg(hub_dev, "%p URB allocated \n", hub->urb);
> > 
> >         usb_fill_int_urb(hub->urb, hdev, pipe, *hub->buffer, maxp, hub_irq,
> >                 hub, endpoint->bInterval);
> 
> Oliver, by the way, %p isn't a good way to get pointer values for 
> debugging.  Its output depends on how the system is configured.  Use 
> %px instead (see Documentation/core-api/printk-formats.rst).
> 
> Alan Stern
> 

--pbstite62b3gsbf2
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="usb.dmesg"

[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] Linux version 5.6.0-rc6-00002-gdfd1731f9a3e (qyousef@e107158-lin) (gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)) #541 SMP PREEMPT Tue Mar 24 13:29:19 GMT 2020
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
[    0.008559] Failed to initialize '/smb@8000000/motherboard/iofpga@3,00000000/timer@120000': -22
[    0.018104] arch_timer: cp15 and mmio timer(s) running at 50.00MHz (phys/phys).
[    0.025447] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.036277] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.045514] Console: colour dummy device 80x25
[    0.050047] printk: console [tty0] enabled
[    0.054294] printk: bootconsole [pl11] disabled
[    0.058987] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.059154] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.059254] ... MAX_LOCK_DEPTH:          48
[    0.059355] ... MAX_LOCKDEP_KEYS:        8192
[    0.059460] ... CLASSHASH_SIZE:          4096
[    0.059565] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.059672] ... MAX_LOCKDEP_CHAINS:      65536
[    0.059777] ... CHAINHASH_SIZE:          32768
[    0.059883]  memory used by lock dependency info: 6237 kB
[    0.060005]  memory used for stack traces: 4224 kB
[    0.060117]  per task-struct memory footprint: 1920 bytes
[    0.060239] ------------------------
[    0.060330] | Locking API testsuite:
[    0.060421] ----------------------------------------------------------------------------
[    0.060593]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.060764]   --------------------------------------------------------------------------
[    0.060943]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.079471]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.099610]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.121456]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.143259]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.166767]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.190249]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.213763]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.232219]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.250044]   --------------------------------------------------------------------------
[    0.250214]               recursive read-lock:             |  ok  |             |  ok  |
[    0.255845]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.261257]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.266678]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.272102]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
[    0.277826]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
[    0.283714]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
[    0.289603]   --------------------------------------------------------------------------
[    0.289934]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.297909]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.305930]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.313903]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.321911]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.329897]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.337919]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.345890]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.353910]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.361883]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.369892]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.378560]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.387282]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.395952]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.404671]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.413340]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.422052]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.430701]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.439410]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.447609]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.455852]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.464512]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.473223]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.481908]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.490625]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.499298]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.508019]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.516684]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.525407]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.534083]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.542794]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.551452]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.560171]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.568833]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.577549]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.586217]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.594934]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.603596]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.612318]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.620989]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.629708]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.638374]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.647089]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.655746]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.664467]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.673130]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.681851]       hard-irq read-recursion/123:  ok  |
[    0.684808]       soft-irq read-recursion/123:  ok  |
[    0.687809]       hard-irq read-recursion/132:  ok  |
[    0.690765]       soft-irq read-recursion/132:  ok  |
[    0.693770]       hard-irq read-recursion/213:  ok  |
[    0.696726]       soft-irq read-recursion/213:  ok  |
[    0.699730]       hard-irq read-recursion/231:  ok  |
[    0.702687]       soft-irq read-recursion/231:  ok  |
[    0.705688]       hard-irq read-recursion/312:  ok  |
[    0.708645]       soft-irq read-recursion/312:  ok  |
[    0.711647]       hard-irq read-recursion/321:  ok  |
[    0.714602]       soft-irq read-recursion/321:  ok  |
[    0.717604]   --------------------------------------------------------------------------
[    0.717772]   | Wound/wait tests |
[    0.717859]   ---------------------
[    0.717947]                   ww api failures:  ok  |  ok  |  ok  |
[    0.726453]                ww contexts mixing:  ok  |  ok  |
[    0.732068]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.743151]                locking mismatches:  ok  |  ok  |  ok  |
[    0.751623]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.780528]            spinlock nest unlocked:  ok  |
[    0.783253]   -----------------------------------------------------
[    0.783387]                                  |block | try  |context|
[    0.783524]   -----------------------------------------------------
[    0.783658]                           context:  ok  |  ok  |  ok  |
[    0.792394]                               try:  ok  |  ok  |  ok  |
[    0.800608]                             block:  ok  |  ok  |  ok  |
[    0.808862]                          spinlock:  ok  |  ok  |  ok  |
[    0.817795] -------------------------------------------------------
[    0.817931] Good, all 261 testcases passed! |
[    0.818034] ---------------------------------
[    0.818373] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.818650] pid_max: default: 32768 minimum: 301
[    0.819122] LSM: Security Framework initializing
[    0.819426] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.819632] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.855086] rcu: Hierarchical SRCU implementation.
[    0.872249] EFI services will not be available.
[    0.879375] smp: Bringing up secondary CPUs ...
[    0.925462] CPU features: detected: EL2 vector hardening
[    0.925475] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
[    0.925482] CPU features: detected: ARM erratum 1319367
[    0.925489] Detected PIPT I-cache on CPU1
[    0.925551] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[    0.969765] Detected PIPT I-cache on CPU2
[    0.969800] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[    1.014206] Detected VIPT I-cache on CPU3
[    1.014278] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[    1.058602] Detected VIPT I-cache on CPU4
[    1.058660] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[    1.103026] Detected VIPT I-cache on CPU5
[    1.103083] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[    1.103707] smp: Brought up 1 node, 6 CPUs
[    1.105347] SMP: Total of 6 processors activated.
[    1.105567] CPU features: detected: 32-bit EL0 Support
[    1.105703] CPU features: detected: CRC32 instructions
[    1.168589] CPU: All CPU(s) started at EL2
[    1.168851] alternatives: patching kernel code
[    1.173882] devtmpfs: initialized
[    1.193809] KASLR disabled due to lack of seed
[    1.195961] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.196083] futex hash table entries: 2048 (order: 6, 262144 bytes, linear)
[    1.197646] xor: measuring software checksum speed
[    1.234611]    8regs     :  4238.000 MB/sec
[    1.274820]    32regs    :  4763.000 MB/sec
[    1.315072]    arm64_neon:  4290.000 MB/sec
[    1.315126] xor: using function: 32regs (4763.000 MB/sec)
[    1.315194] pinctrl core: initialized pinctrl subsystem
[    1.317944] thermal_sys: Registered thermal governor 'step_wise'
[    1.317950] thermal_sys: Registered thermal governor 'power_allocator'
[    1.319665] DMI not present or invalid.
[    1.320924] NET: Registered protocol family 16
[    1.325042] DMA: preallocated 256 KiB pool for atomic allocations
[    1.325127] audit: initializing netlink subsys (disabled)
[    1.325663] audit: type=2000 audit(1.044:1): state=initialized audit_enabled=0 res=1
[    1.327747] cpuidle: using governor menu
[    1.328011] NET: Registered protocol family 42
[    1.328608] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.329105] ASID allocator initialised with 65536 entries
[    1.331101] Serial: AMBA PL011 UART driver
[    1.360865] 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 31, base_baud = 0) is a PL011 rev3
[    2.798063] printk: console [ttyAMA0] enabled
[    2.869683] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.876629] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    2.883447] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.890254] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    2.923328] cryptd: max_cpu_qlen set to 1000
[    3.021904] raid6: neonx8   gen()  3081 MB/s
[    3.094355] raid6: neonx8   xor()  2156 MB/s
[    3.166859] raid6: neonx4   gen()  3067 MB/s
[    3.239275] raid6: neonx4   xor()  2275 MB/s
[    3.311745] raid6: neonx2   gen()  2656 MB/s
[    3.384186] raid6: neonx2   xor()  2059 MB/s
[    3.456655] raid6: neonx1   gen()  1971 MB/s
[    3.529101] raid6: neonx1   xor()  1619 MB/s
[    3.601566] raid6: int64x8  gen()  1555 MB/s
[    3.674013] raid6: int64x8  xor()   899 MB/s
[    3.746476] raid6: int64x4  gen()  1790 MB/s
[    3.818913] raid6: int64x4  xor()   971 MB/s
[    3.891357] raid6: int64x2  gen()  1592 MB/s
[    3.963815] raid6: int64x2  xor()   846 MB/s
[    4.036263] raid6: int64x1  gen()  1224 MB/s
[    4.108748] raid6: int64x1  xor()   639 MB/s
[    4.113097] raid6: using algorithm neonx8 gen() 3081 MB/s
[    4.118582] raid6: .... xor() 2156 MB/s, rmw enabled
[    4.123628] raid6: using neon recovery algorithm
[    4.129187] ACPI: Interpreter disabled.
[    4.135980] iommu: Default domain type: Translated 
[    4.141597] vgaarb: loaded
[    4.145349] SCSI subsystem initialized
[    4.149692] libata version 3.00 loaded.
[    4.154219] usbcore: registered new interface driver usbfs
[    4.159916] usbcore: registered new interface driver hub
[    4.165517] usbcore: registered new device driver usb
[    4.173528] mc: Linux media interface: v0.10
[    4.177949] videodev: Linux video capture interface: v2.00
[    4.183789] pps_core: LinuxPPS API ver. 1 registered
[    4.188842] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.198139] PTP clock support registered
[    4.202924] EDAC MC: Ver: 3.0.0
[    4.208900] FPGA manager framework
[    4.212863] Advanced Linux Sound Architecture Driver Initialized.
[    4.220442] Bluetooth: Core ver 2.22
[    4.224164] NET: Registered protocol family 31
[    4.228690] Bluetooth: HCI device and connection manager initialized
[    4.235176] Bluetooth: HCI socket layer initialized
[    4.240150] Bluetooth: L2CAP socket layer initialized
[    4.245346] Bluetooth: SCO socket layer initialized
[    4.251847] clocksource: Switched to clocksource arch_sys_counter
[    5.094664] VFS: Disk quotas dquot_6.6.0
[    5.098862] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.106585] pnp: PnP ACPI: disabled
[    5.129217] NET: Registered protocol family 2
[    5.134547] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, linear)
[    5.144017] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    5.152363] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes, linear)
[    5.170770] TCP: Hash tables configured (established 65536 bind 65536)
[    5.177861] UDP hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    5.186272] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    5.195315] NET: Registered protocol family 1
[    5.201490] RPC: Registered named UNIX socket transport module.
[    5.207660] RPC: Registered udp transport module.
[    5.212485] RPC: Registered tcp transport module.
[    5.217296] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.224881] PCI: CLS 0 bytes, default 64
[    6.578984] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    6.589062] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    6.597532] kvm [1]: IPA Size Limit: 40bits
[    6.610626] kvm [1]: vgic interrupt IRQ1
[    6.615204] kvm [1]: Hyp mode initialized successfully
[    7.077112] rcu-torture:--- Start of test: nreaders=5 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0
[    7.110494] rcu-torture: Creating rcu_torture_writer task
[    7.116379] rcu-torture: Creating rcu_torture_fakewriter task
[    7.116385] rcu-torture: rcu_torture_writer task started
[    7.122491] rcu-torture: Creating rcu_torture_fakewriter task
[    7.122522] rcu-torture: rcu_torture_fakewriter task started
[    7.128171] rcu-torture: GP expediting controlled from boot/sysfs for rcu.
[    7.133916] rcu-torture: Creating rcu_torture_fakewriter task
[    7.133945] rcu-torture: rcu_torture_fakewriter task started
[    7.139582] rcu_torture_writer: Testing conditional GPs.
[    7.146788] rcu-torture: Creating rcu_torture_fakewriter task
[    7.146817] rcu-torture: rcu_torture_fakewriter task started
[    7.155874] rcu_torture_writer: Testing expedited GPs.
[    7.158579] rcu-torture: Creating rcu_torture_reader task
[    7.158607] rcu-torture: rcu_torture_fakewriter task started
[    7.163675] rcu_torture_writer: Testing asynchronous GPs.
[    7.169749] rcu-torture: Creating rcu_torture_reader task
[    7.169782] rcu-torture: rcu_torture_reader task started
[    7.175265] rcu_torture_writer: Testing normal GPs.
[    7.213385] rcu-torture: Creating rcu_torture_reader task
[    7.213443] rcu-torture: rcu_torture_reader task started
[    7.219139] rcu-torture: Creating rcu_torture_reader task
[    7.219168] rcu-torture: rcu_torture_reader task started
[    7.235646] rcu-torture: Creating rcu_torture_reader task
[    7.235684] rcu-torture: rcu_torture_reader task started
[    7.241392] rcu-torture: Creating rcu_torture_stats task
[    7.241397] rcu-torture: rcu_torture_reader task started
[    7.257785] rcu-torture: Creating torture_shuffle task
[    7.263087] rcu-torture: rcu_torture_stats task started
[    7.268826] rcu-torture: Creating torture_stutter task
[    7.268858] rcu-torture: torture_shuffle task started
[    7.274329] rcu-torture: Creating rcu_torture_fwd_prog task
[    7.274355] rcu-torture: torture_stutter task started
[    7.290466] rcu-torture: rcu_torture_fwd_progress task started
[    7.293479] Initialise system trusted keyrings
[    7.301423] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    7.336884] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.349427] NFS: Registering the id_resolver key type
[    7.354642] Key type id_resolver registered
[    7.358937] Key type id_legacy registered
[    7.363047] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.370267] fuse: init (API version 7.31)
[    7.375772] 9p: Installing v9fs 9p2000 file system support
[    7.404730] Key type asymmetric registered
[    7.408986] Asymmetric key parser 'x509' registered
[    7.414040] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    7.421582] io scheduler mq-deadline registered
[    7.426202] io scheduler kyber registered
[    7.445797] pl061_gpio 1c1d0000.gpio: PL061 GPIO chip registered
[    7.455590] pci-host-generic 40000000.pcie: host bridge /pcie@40000000 ranges:
[    7.462988] pci-host-generic 40000000.pcie:       IO 0x005f800000..0x005fffffff -> 0x0000000000
[    7.471956] pci-host-generic 40000000.pcie:      MEM 0x0050000000..0x0057ffffff -> 0x0050000000
[    7.480842] pci-host-generic 40000000.pcie:      MEM 0x4000000000..0x40ffffffff -> 0x4000000000
[    7.489788] pci-host-generic 40000000.pcie: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-ff]
[    7.498975] pci-host-generic 40000000.pcie: PCI host bridge to bus 0000:00
[    7.505978] pci_bus 0000:00: root bus resource [bus 00-ff]
[    7.511570] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
[    7.518038] pci_bus 0000:00: root bus resource [mem 0x50000000-0x57ffffff]
[    7.525038] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x40ffffffff pref]
[    7.532922] pci 0000:00:00.0: [1556:1100] type 01 class 0x060400
[    7.539090] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit pref]
[    7.546617] pci 0000:00:00.0: supports D1 D2
[    7.550978] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.559711] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.568127] pci 0000:01:00.0: [111d:8090] type 01 class 0x060400
[    7.574387] pci 0000:01:00.0: enabling Extended Tags
[    7.579627] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    7.597244] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.605766] pci 0000:02:01.0: [111d:8090] type 01 class 0x060400
[    7.612042] pci 0000:02:01.0: enabling Extended Tags
[    7.617316] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    7.624195] pci 0000:02:02.0: [111d:8090] type 01 class 0x060400
[    7.630469] pci 0000:02:02.0: enabling Extended Tags
[    7.635741] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    7.642575] pci 0000:02:03.0: [111d:8090] type 01 class 0x060400
[    7.648842] pci 0000:02:03.0: enabling Extended Tags
[    7.654113] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    7.661293] pci 0000:02:0c.0: [111d:8090] type 01 class 0x060400
[    7.667561] pci 0000:02:0c.0: enabling Extended Tags
[    7.672832] pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
[    7.679795] pci 0000:02:10.0: [111d:8090] type 01 class 0x060400
[    7.686056] pci 0000:02:10.0: enabling Extended Tags
[    7.691318] pci 0000:02:10.0: PME# supported from D0 D3hot D3cold
[    7.698753] pci 0000:02:1f.0: [111d:8090] type 01 class 0x060400
[    7.705021] pci 0000:02:1f.0: enabling Extended Tags
[    7.710291] pci 0000:02:1f.0: PME# supported from D0 D3hot D3cold
[    7.717084] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.725252] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.733413] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.741593] pci 0000:02:0c.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.749753] pci 0000:02:10.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.757907] pci 0000:02:1f.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.766363] pci 0000:03:00.0: [1095:3132] type 00 class 0x018000
[    7.772551] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000007f 64bit]
[    7.779489] pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x00003fff 64bit]
[    7.786411] pci 0000:03:00.0: reg 0x20: [io  0x0000-0x007f]
[    7.792122] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    7.799106] pci 0000:03:00.0: supports D1 D2
[    7.803984] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    7.815450] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    7.823713] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    7.832011] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    7.840311] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    7.848601] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    7.855662] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000
[    7.861847] pci 0000:08:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    7.868769] pci 0000:08:00.0: reg 0x18: [io  0x0000-0x00ff]
[    7.874684] pci 0000:08:00.0: supports D1 D2
[    7.879043] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.887739] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 08
[    7.894481] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 08
[    7.901219] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 08
[    7.907976] pci 0000:00:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    7.914978] pci 0000:00:00.0: BAR 0: assigned [mem 0x4000000000-0x4000003fff 64bit pref]
[    7.923243] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.929548] pci 0000:01:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    7.936542] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.942844] pci 0000:02:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
[    7.949838] pci 0000:02:1f.0: BAR 14: assigned [mem 0x50100000-0x501fffff]
[    7.956830] pci 0000:02:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    7.963120] pci 0000:02:1f.0: BAR 13: assigned [io  0x2000-0x2fff]
[    7.969424] pci 0000:03:00.0: BAR 6: assigned [mem 0x50000000-0x5007ffff pref]
[    7.976773] pci 0000:03:00.0: BAR 2: assigned [mem 0x50080000-0x50083fff 64bit]
[    7.984244] pci 0000:03:00.0: BAR 0: assigned [mem 0x50084000-0x5008407f 64bit]
[    7.991702] pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
[    7.997917] pci 0000:02:01.0: PCI bridge to [bus 03]
[    8.002980] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    8.009191] pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
[    8.016115] pci 0000:02:02.0: PCI bridge to [bus 04]
[    8.021208] pci 0000:02:03.0: PCI bridge to [bus 05]
[    8.026305] pci 0000:02:0c.0: PCI bridge to [bus 06]
[    8.031418] pci 0000:02:10.0: PCI bridge to [bus 07]
[    8.036523] pci 0000:08:00.0: BAR 0: assigned [mem 0x50100000-0x50103fff 64bit]
[    8.043981] pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
[    8.050190] pci 0000:02:1f.0: PCI bridge to [bus 08]
[    8.055258] pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
[    8.061477] pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
[    8.068407] pci 0000:01:00.0: PCI bridge to [bus 02-08]
[    8.073732] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    8.079944] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    8.086873] pci 0000:00:00.0: PCI bridge to [bus 01-08]
[    8.092201] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    8.098407] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    8.105743] pcieport 0000:00:00.0: enabling device (0000 -> 0003)
[    8.120032] pcieport 0000:00:00.0: PME: Signaling with IRQ 44
[    8.126997] pcieport 0000:00:00.0: AER: enabled with IRQ 44
[    8.133261] pcieport 0000:01:00.0: enabling device (0000 -> 0003)
[    8.139707] pcieport 0000:02:01.0: enabling device (0000 -> 0003)
[    8.150518] pcieport 0000:02:1f.0: enabling device (0000 -> 0003)
[    8.160458] IPMI message handler: version 39.2
[    8.165174] ipmi device interface
[    8.168698] ipmi_si: IPMI System Interface driver
[    8.174132] ipmi_si: Unable to find any System Interface(s)
[    8.181111] EINJ: ACPI disabled.
[    8.193706] dma-pl330 7ff00000.dma: WARN: Device release is not defined so it is not safe to unbind this driver while in use
[    8.206494] dma-pl330 7ff00000.dma: Loaded driver for PL330 DMAC-341330
[    8.213230] dma-pl330 7ff00000.dma: 	DBUFF-1024x16bytes Num_Chans-8 Num_Peri-8 Num_Events-8
[    8.237794] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.249476] SuperH (H)SCI(F) driver initialized
[    8.254765] msm_serial: driver initialized
[    8.262532] arm-smmu 7fb10000.iommu: probing hardware configuration...
[    8.269207] arm-smmu 7fb10000.iommu: SMMUv1 with:
[    8.274005] arm-smmu 7fb10000.iommu: 	stage 2 translation
[    8.279509] arm-smmu 7fb10000.iommu: 	non-coherent table walk
[    8.285365] arm-smmu 7fb10000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    8.292894] arm-smmu 7fb10000.iommu: 	stream matching with 2 register groups
[    8.300072] arm-smmu 7fb10000.iommu: 	1 context banks (1 stage-2 only)
[    8.306717] arm-smmu 7fb10000.iommu: 	Supported page sizes: 0x60211000
[    8.313357] arm-smmu 7fb10000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.320927] arm-smmu 7fb20000.iommu: probing hardware configuration...
[    8.327578] arm-smmu 7fb20000.iommu: SMMUv1 with:
[    8.332379] arm-smmu 7fb20000.iommu: 	stage 2 translation
[    8.337882] arm-smmu 7fb20000.iommu: 	non-coherent table walk
[    8.343734] arm-smmu 7fb20000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    8.351262] arm-smmu 7fb20000.iommu: 	stream matching with 2 register groups
[    8.358439] arm-smmu 7fb20000.iommu: 	1 context banks (1 stage-2 only)
[    8.365088] arm-smmu 7fb20000.iommu: 	Supported page sizes: 0x60211000
[    8.371733] arm-smmu 7fb20000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.378889] arm-smmu 7fb30000.iommu: probing hardware configuration...
[    8.385544] arm-smmu 7fb30000.iommu: SMMUv1 with:
[    8.390347] arm-smmu 7fb30000.iommu: 	stage 2 translation
[    8.395849] arm-smmu 7fb30000.iommu: 	coherent table walk
[    8.401352] arm-smmu 7fb30000.iommu: 	stream matching with 2 register groups
[    8.408523] arm-smmu 7fb30000.iommu: 	1 context banks (1 stage-2 only)
[    8.415173] arm-smmu 7fb30000.iommu: 	Supported page sizes: 0x60211000
[    8.421817] arm-smmu 7fb30000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.563772] tda998x 0-0070: found TDA19988
[    8.696060] tda998x 0-0071: found TDA19988
[    8.766216] loop: module loaded
[    8.893170] mpt3sas version 33.100.00.00 loaded
[    8.903315] sata_sil24 0000:03:00.0: version 1.1
[    8.908345] sata_sil24 0000:03:00.0: enabling device (0000 -> 0003)
[    8.918391] scsi host0: sata_sil24
[    8.923496] scsi host1: sata_sil24
[    8.927499] ata1: SATA max UDMA/100 host m128@0x50084000 port 0x50080000 irq 51
[    8.934940] ata2: SATA max UDMA/100 host m128@0x50084000 port 0x50082000 irq 51
[    8.950044] libphy: Fixed MDIO Bus: probed
[    8.956437] tun: Universal TUN/TAP device driver, 1.6
[    8.962964] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.713.36-0 (2014/02/10)
[    8.972980] thunder_xcv, ver 1.0
[    8.976426] thunder_bgx, ver 1.0
[    8.979813] nicpf, ver 1.0
[    8.983449] hclge is initializing
[    8.987220] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    8.994608] hns3: Copyright (c) 2017 Huawei Corporation.
[    9.000181] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    9.006119] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    9.012273] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
[    9.019349] igb: Copyright (c) 2007-2014 Intel Corporation.
[    9.025142] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    9.033096] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    9.039878] sky2: driver version 1.30
[    9.043915] sky2 0000:08:00.0: enabling device (0000 -> 0003)
[    9.049850] sky2 0000:08:00.0: Yukon-2 UL 2 chip revision 0
[    9.055639] sky2 0000:08:00.0 (unnamed net_device) (uninitialized): Invalid MAC address, defaulting to random
[    9.067331] sky2 0000:08:00.0 eth0: addr ae:19:c6:f0:10:e2
[    9.110208] libphy: smsc911x-mdio: probed
[    9.115328] smsc911x 18000000.ethernet eth1: MAC Address: 00:02:f7:00:67:bd
[    9.125648] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    9.133322] usbcore: registered new interface driver pegasus
[    9.139170] usbcore: registered new interface driver rtl8150
[    9.145034] usbcore: registered new interface driver r8152
[    9.150697] usbcore: registered new interface driver lan78xx
[    9.156568] usbcore: registered new interface driver asix
[    9.162135] usbcore: registered new interface driver ax88179_178a
[    9.168409] usbcore: registered new interface driver cdc_ether
[    9.174408] usbcore: registered new interface driver dm9601
[    9.180169] usbcore: registered new interface driver CoreChips
[    9.186202] usbcore: registered new interface driver smsc75xx
[    9.192194] usbcore: registered new interface driver smsc95xx
[    9.198107] usbcore: registered new interface driver net1080
[    9.203931] usbcore: registered new interface driver plusb
[    9.209590] usbcore: registered new interface driver cdc_subset
[    9.215686] usbcore: registered new interface driver zaurus
[    9.221421] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[    9.229036] usbcore: registered new interface driver cdc_ncm
[    9.235198] VFIO - User Level meta-driver version: 0.3
[    9.244049] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.250734] ehci-pci: EHCI PCI platform driver
[    9.255373] ehci-platform: EHCI generic platform driver
[    9.261265] ehci-platform 7ffc0000.ehci: Adding to iommu group 0
[    9.267943] ehci-platform 7ffc0000.ehci: EHCI Host Controller
[    9.273960] ehci-platform 7ffc0000.ehci: new USB bus registered, assigned bus number 1
[    9.282413] ehci-platform 7ffc0000.ehci: irq 34, io mem 0x7ffc0000
[    9.303894] ehci-platform 7ffc0000.ehci: USB 2.0 started, EHCI 1.00
[    9.312750] hub 1-0:1.0: USB hub found
[    9.316756] hub 1-0:1.0: 1 port detected
[    9.322098] ehci-orion: EHCI orion driver
[    9.326429] ehci-exynos: EHCI Exynos driver
[    9.330880] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    9.337203] ohci-pci: OHCI PCI platform driver
[    9.341844] ohci-platform: OHCI generic platform driver
[    9.347445] ohci-platform 7ffb0000.ohci: Adding to iommu group 0
[    9.353789] ohci-platform 7ffb0000.ohci: Generic Platform OHCI controller
[    9.360733] ohci-platform 7ffb0000.ohci: new USB bus registered, assigned bus number 2
[    9.369041] ohci-platform 7ffb0000.ohci: irq 33, io mem 0x7ffb0000
[    9.454060] hub 2-0:1.0: USB hub found
[    9.458002] hub 2-0:1.0: 1 port detected
[    9.462996] ohci-exynos: OHCI Exynos driver
[    9.468199] usbcore: registered new interface driver usb-storage
[    9.483090] rtc-pl031 1c170000.rtc: registered as rtc0
[    9.489863] i2c /dev entries driver
[    9.498761] usbcore: registered new interface driver uvcvideo
[    9.504616] USB Video Class driver (1.1.1)
[    9.508794] gspca_main: v2.14.0 registered
[    9.519678] sp805-wdt 1c0f0000.wdt: registration successful
[    9.528211] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    9.536840] Bluetooth: HCI UART driver ver 2.3
[    9.541374] Bluetooth: HCI UART protocol H4 registered
[    9.546654] Bluetooth: HCI UART protocol LL registered
[    9.552062] Bluetooth: HCI UART protocol Broadcom registered
[    9.557942] usbcore: registered new interface driver btusb
[    9.566162] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 9,0 (pio)
[    9.600728] sdhci: Secure Digital Host Controller Interface driver
[    9.607167] sdhci: Copyright(c) Pierre Ossman
[    9.612329] Synopsys Designware Multimedia Card Interface Driver
[    9.620229] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.629527] leds-syscon 1c010000.apbregs:led0: registered LED vexpress:0
[    9.636858] leds-syscon 1c010000.apbregs:led1: registered LED vexpress:1
[    9.644123] leds-syscon 1c010000.apbregs:led2: registered LED vexpress:2
[    9.651333] leds-syscon 1c010000.apbregs:led3: registered LED vexpress:3
[    9.658549] leds-syscon 1c010000.apbregs:led4: registered LED vexpress:4
[    9.660037] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    9.665756] leds-syscon 1c010000.apbregs:led5: registered LED vexpress:5
[    9.679910] leds-syscon 1c010000.apbregs:led6: registered LED vexpress:6
[    9.687122] leds-syscon 1c010000.apbregs:led7: registered LED vexpress:7
[    9.695039] ledtrig-cpu: registered to indicate activity on CPUs
[    9.704066] hub 1-1:1.0: USB hub found
[    9.704866] usbcore: registered new interface driver usbhid
[    9.708570] hub 1-1:1.0: 4 ports detected
[    9.713711] usbhid: USB HID core driver
[    9.714861] mhu 2b1f0000.mhu: ARM MHU Mailbox registered
[    9.740849] drop_monitor: Initializing network drop monitor service
[    9.751356] NET: Registered protocol family 10
[    9.752975] random: fast init done
[    9.761199] Segment Routing with IPv6
[    9.765574] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.772882] NET: Registered protocol family 17
[    9.777629] Bridge firewalling registered
[    9.781804] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.787875] Bluetooth: HIDP socket layer initialized
[    9.793029] 8021q: 802.1Q VLAN Support v1.8
[    9.797718] 9pnet: Installing 9P2000 support
[    9.802205] Key type dns_resolver registered
[    9.807996] registered taskstats version 1
[    9.812243] Loading compiled-in X.509 certificates
[    9.820380] Btrfs loaded, crc32c=crc32c-generic
[    9.836554] scpi_protocol scpi: SCP Protocol 1.2 Firmware 1.21.0 version
[    9.900309] arm-smmu 2b600000.iommu: probing hardware configuration...
[    9.906999] arm-smmu 2b600000.iommu: SMMUv1 with:
[    9.911929] arm-smmu 2b600000.iommu: 	stage 2 translation
[    9.917444] arm-smmu 2b600000.iommu: 	coherent table walk
[    9.922977] arm-smmu 2b600000.iommu: 	stream matching with 2 register groups
[    9.930180] arm-smmu 2b600000.iommu: 	1 context banks (1 stage-2 only)
[    9.936853] arm-smmu 2b600000.iommu: 	Supported page sizes: 0x60211000
[    9.943495] arm-smmu 2b600000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    9.953325] input: smb@8000000:motherboard:gpio-keys as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:gpio-keys/input/input1
[    9.969875] rtc-pl031 1c170000.rtc: setting system clock to 2020-03-24T13:26:36 UTC (1585056396)
[   10.280067] usb 1-1.1: new high-speed USB device number 3 using ehci-platform
[   10.325610] usb-storage 1-1.1:1.0: USB Mass Storage device detected
[   10.340148] scsi host2: usb-storage 1-1.1:1.0
[   10.503982] atkbd serio0: keyboard reset failed on 1c060000.kmi
[   10.992124] ata1: SATA link down (SStatus 0 SControl 0)
[   11.372862] scsi 2:0:0:0: Direct-Access     TOSHIBA  TransMemory      PMAP PQ: 0 ANSI: 6
[   11.385025] sd 2:0:0:0: [sda] 30253056 512-byte logical blocks: (15.5 GB/14.4 GiB)
[   11.395886] sd 2:0:0:0: [sda] Write Protect is off
[   11.400946] sd 2:0:0:0: [sda] Mode Sense: 45 00 00 00
[   11.407205] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   11.476739]  sda: sda1 sda2
[   11.495313] sd 2:0:0:0: [sda] Attached SCSI removable disk
[   11.751875] atkbd serio1: keyboard reset failed on 1c070000.kmi
[   13.048101] ata2: SATA link down (SStatus 0 SControl 0)
[   13.059761] sky2 0000:08:00.0 eth0: enabling interface
[   13.068686] Generic PHY 18000000.ethernet-ffffffff:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=18000000.ethernet-ffffffff:01, irq=POLL)
[   13.083104] smsc911x 18000000.ethernet eth1: SMSC911x/921x identified at 0xffff800018d90000, IRQ: 8
[   15.144751] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   15.163932] Sending DHCP requests ., OK
[   15.300992] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.304182] ALSA device list:
[   15.309940] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   15.313166]   No soundcards found.
[   15.325677] uart-pl011 7ff80000.uart: no DMA platform data
[   15.381459] Freeing unused kernel memory: 14656K
[   15.576075] Run /init as init process
[   15.579784]   with arguments:
[   15.582818]     /init
[   15.585143]     ttyAMA0,115200n8
[   15.588438]     verbose
[   15.590911]     nfsrootdebug
[   15.593846]   with environment:
[   15.597044]     HOME=/
[   15.599429]     TERM=linux
[   15.602189]     user_debug=31
[   16.000277] Adding 2543608k swap on /dev/sda2.  Priority:-2 extents:1 across:2543608k 
[   18.690278] input: PS/2 Generic Mouse as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c060000.kmi/serio0/input/input3
[   18.815258] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[   20.581550] random: dd: uninitialized urandom read (512 bytes read)
[   20.695317] random: ssh-keygen: uninitialized urandom read (32 bytes read)
[   20.725071] random: sshd: uninitialized urandom read (32 bytes read)
[   20.805838] sky2 0000:08:00.0 eth0: enabling interface
[   25.641788] input: PS/2 Generic Mouse as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c070000.kmi/serio1/input/input4
[   25.770081] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[   68.871949] rcu-torture: rtc: (____ptrval____) ver: 1430 tfle: 0 rta: 1431 rtaf: 0 rtf: 1419 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 24137 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[   68.891859] rcu-torture: Reader Pipe:  14518041 3920 0 0 0 0 0 0 0 0 0
[   68.898567] rcu-torture: Reader Batch:  14513170 8794 0 0 0 0 0 0 0 0 0
[   68.905308] rcu-torture: Free-Block Circulation:  1430 1430 1429 1428 1426 1425 1424 1423 1421 1420 0
[   77.075919] cfg80211: failed to load regulatory.db
[   85.395510] PM: hibernation: hibernation entry
[   85.407291] Filesystems sync: 0.001 seconds
[   85.411706] Freezing user space processes ... (elapsed 0.003 seconds) done.
[   85.422153] OOM killer disabled.
[   85.432722] PM: hibernation: Preallocating image memory
[   86.962730] PM: hibernation: Allocated 97206 pages for snapshot
[   86.968783] PM: hibernation: Allocated 388824 kbytes in 1.52 seconds (255.80 MB/s)
[   86.976488] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   86.988496] printk: Suspending console(s) (use no_console_suspend to debug)
[   87.052353] usbcore:hub_suspend: hub 1-1:1.0: hub_suspend
[   87.054920] usbcore:hub_suspend: hub 1-0:1.0: hub_suspend
[   87.055211] usbcore:hcd_bus_suspend: usb usb1: bus suspend, wakeup 0
[   87.106030] Disabling non-boot CPUs ...
[   87.115339] CPU1: shutdown
[   87.115396] psci: CPU1 killed (polled 0 ms)
[   87.124698] CPU2: shutdown
[   87.125786] psci: CPU2 killed (polled 0 ms)
[   87.142474] CPU3: shutdown
[   87.142499] psci: CPU3 killed (polled 0 ms)
[   87.158793] CPU4: shutdown
[   87.158818] psci: CPU4 killed (polled 0 ms)
[   87.170296] CPU5: shutdown
[   87.170322] psci: CPU5 killed (polled 0 ms)
[   87.181175] PM: hibernation: Creating image:
[   87.181175] PM: hibernation: Need to copy 95355 pages
[   87.181175] PM: hibernation: Image created (95355 pages copied)
[   87.181755] Enabling non-boot CPUs ...
[   87.195741] Detected PIPT I-cache on CPU1
[   87.195807] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[   87.199267] CPU1 is up
[   87.218474] Detected PIPT I-cache on CPU2
[   87.218514] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[   87.220090] CPU2 is up
[   87.233753] Detected VIPT I-cache on CPU3
[   87.233836] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[   87.236870] CPU3 is up
[   87.251072] Detected VIPT I-cache on CPU4
[   87.251139] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[   87.254256] CPU4 is up
[   87.268055] Detected VIPT I-cache on CPU5
[   87.268119] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[   87.272310] CPU5 is up
[   87.308368] usbcore:hcd_bus_resume: usb usb1: usb resume
[   87.339802] usbcore:hcd_bus_resume: usb usb2: usb resume
[   87.370809] usbcore:hub_resume: hub 1-0:1.0: hub_resume
[   87.371148] usbcore:hub_activate: usb usb1-port1: status 0503 change 0000
[   87.371358] usbcore:hub_resume: hub 1-1:1.0: hub_resume
[   87.371785] usbcore:hub_activate: usb 1-1-port1: status 0503 change 0000
[   87.418064] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[   87.418308] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[   87.622694] PM: Cannot find swap device, try swapon -a
[   87.628057] PM: Cannot get swap writer
[   88.214621] OOM killer enabled.
[   88.217943] Restarting tasks ... 
[   88.220049] usbcore:hub_event: hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   88.225181] done.
[   88.231030] usbcore:hub_event: hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
[   88.240461] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   88.248053] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[   88.253967] ------------[ cut here ]------------
[   88.258945] URB (____ptrval____) submitted while active
[   88.264629] WARNING: CPU: 4 PID: 379 at drivers/usb/core/urb.c:363 usb_submit_urb+0x3d8/0x590
[   88.273808] Modules linked in:
[   88.273830] CPU: 4 PID: 379 Comm: kworker/4:2 Not tainted 5.6.0-rc6-00002-gdfd1731f9a3e #541
[   88.273839] Hardware name: ARM Juno development board (r2) (DT)
[   88.273852] Workqueue: usb_hub_wq hub_event
[   88.273865] pstate: 40000005 (nZcv daif -PAN -UAO)
[   88.273876] pc : usb_submit_urb+0x3d8/0x590
[   88.273886] lr : usb_submit_urb+0x3d8/0x590
[   88.273894] sp : ffff8000190038b0
[   88.273902] x29: ffff8000190038b0 x28: 0000000000000003 
[   88.273916] x27: ffff00097050fb20 x26: ffff80001340d000 
[   88.273930] x25: ffff80001340d000 x24: ffff800019003b38 
[   88.273944] x23: 0000000000000004 x22: 0000000000000c00 
[   88.273958] x21: 0000000000000000 x20: 00000000fffffff0 
[   88.273971] x19: ffff00097046fe00 x18: ffffffffffffffff 
[   88.273986] x17: 00000000934eeaf4 x16: 00000000ad4e46a7 
[   88.273999] x15: ffff80001340da88 x14: 0720072007200720 
[   88.274013] x13: 0720072007200720 x12: 0720072007200720 
[   88.274027] x11: 0000000000000000 x10: 000000008f00fc00 
[   88.274041] x9 : 0000000000000002 x8 : ffff000970fa08a0 
[   88.274055] x7 : 0000000000000000 x6 : ffff00097ef86450 
[   88.274069] x5 : ffff00097ef86450 x4 : 0000000000000000 
[   88.274082] x3 : ffff00097ef96070 x2 : 0000000000000001 
[   88.274096] x1 : bf0dcc4e01afe000 x0 : 0000000000000000 
[   88.274110] Call trace:
[   88.274121]  usb_submit_urb+0x3d8/0x590
[   88.274131]  hub_activate+0x108/0x7f0
[   88.274140]  hub_resume+0xac/0x148
[   88.274152]  usb_resume_interface.isra.10+0x60/0x138
[   88.274163]  usb_resume_both+0xe4/0x140
[   88.274173]  usb_runtime_resume+0x24/0x30
[   88.274187]  __rpm_callback+0xdc/0x138
[   88.274197]  rpm_callback+0x34/0x98
[   88.274208]  rpm_resume+0x4a8/0x720
[   88.274218]  rpm_resume+0x50c/0x720
[   88.274229]  __pm_runtime_resume+0x4c/0xb8
[   88.274240]  usb_autopm_get_interface+0x28/0x60
[   88.274249]  hub_event+0x80/0x16d8
[   88.274262]  process_one_work+0x2a4/0x748
[   88.274273]  worker_thread+0x48/0x498
[   88.274284]  kthread+0x13c/0x140
[   88.274295]  ret_from_fork+0x10/0x18
[   88.274303] irq event stamp: 392
[   88.274318] hardirqs last  enabled at (391): [<ffff800011982754>] _raw_spin_unlock_irq+0x34/0x68
[   88.274332] hardirqs last disabled at (392): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
[   88.274344] softirqs last  enabled at (386): [<ffff8000100818a4>] __do_softirq+0x4bc/0x568
[   88.274355] softirqs last disabled at (375): [<ffff8000101145a4>] irq_exit+0x144/0x150
[   88.274363] ---[ end trace f4c0292c296f056a ]---
[   88.286435] hub 2-0:1.0: activate --> -16
[   88.286692] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[   88.286765] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[   88.287042] usbcore:hcd_bus_suspend: usb usb2: bus auto-suspend, wakeup 1
[   88.537224] PM: hibernation: hibernation exit
[   89.075447] rcu_torture_fwd_prog_nr: Duration 5043 cver 276 gps 501
[   89.311502] ata1: SATA link down (SStatus 0 SControl 0)
[   89.367552] ata2: SATA link down (SStatus 0 SControl 0)
[   89.530995] rcu_torture_fwd_prog_cr Duration 36 barrier: 29 pending 11061 n_launders: 18738 n_launders_sa: 9612 n_max_gps: 100 n_max_cbs: 14380 cver 0 gps 8
[   89.545347] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 69 jiffies): 1s/10: 8737:5 2s/10: 24381:7
[   93.948034] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[  100.793867] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[  106.293706] random: sshd: uninitialized urandom read (32 bytes read)
[  106.322993] random: sshd: uninitialized urandom read (32 bytes read)
[  130.312035] rcu-torture: rtc: (____ptrval____) ver: 2453 tfle: 0 rta: 2454 rtaf: 0 rtf: 2444 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 48147 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  130.331466] rcu-torture: Reader Pipe:  29178800 6720 0 0 0 0 0 0 0 0 0
[  130.338507] rcu-torture: Reader Batch:  29169686 15840 0 0 0 0 0 0 0 0 0
[  130.347485] rcu-torture: Free-Block Circulation:  2455 2454 2453 2452 2451 2450 2449 2448 2447 2446 0
[  168.979443] rcu_torture_fwd_prog_nr: Duration 4535 cver 329 gps 542
[  169.462873] rcu_torture_fwd_prog_cr Duration 42 barrier: 27 pending 5715 n_launders: 12294 n_launders_sa: 9046 n_max_gps: 100 n_max_cbs: 8946 cver 5 gps 9
[  169.477147] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 73 jiffies): 1s/10: 3249:3 2s/10: 16026:7 3s/10: 1965:1
[  191.751468] rcu-torture: rtc: (____ptrval____) ver: 3728 tfle: 0 rta: 3729 rtaf: 0 rtf: 3717 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 71415 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  191.771463] rcu-torture: Reader Pipe:  43149852 10217 0 0 0 0 0 0 0 0 0
[  191.778225] rcu-torture: Reader Batch:  43136800 23279 0 0 0 0 0 0 0 0 0
[  191.785086] rcu-torture: Free-Block Circulation:  3728 3727 3725 3723 3722 3721 3720 3719 3718 3717 0
[  215.694144] random: crng init done
[  251.559438] rcu_torture_fwd_prog_nr: Duration 5215 cver 332 gps 598
[  252.162079] rcu_torture_fwd_prog_cr Duration 56 barrier: 35 pending 5879 n_launders: 12528 n_launders_sa: 103 n_max_gps: 100 n_max_cbs: 9511 cver 6 gps 9
[  252.187444] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 98 jiffies): 1s/10: 4198:4 2s/10: 8228:4 3s/10: 9613:4
[  253.191437] rcu-torture: rtc: 00000000cf292551 ver: 5140 tfle: 0 rta: 5141 rtaf: 0 rtf: 5127 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 96642 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  253.209993] rcu-torture: Reader Pipe:  58692259 14278 0 0 0 0 0 0 0 0 0
[  253.217640] rcu-torture: Reader Batch:  58675125 31423 0 0 0 0 0 0 0 0 0
[  253.224491] rcu-torture: Free-Block Circulation:  5140 5139 5138 5136 5135 5134 5132 5131 5130 5127 0
[  314.631456] rcu-torture: rtc: 000000009d05af10 ver: 6725 tfle: 0 rta: 6726 rtaf: 0 rtf: 6715 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 121951 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  314.651893] rcu-torture: Reader Pipe:  74645463 18849 0 0 0 0 0 0 0 0 0
[  314.658834] rcu-torture: Reader Batch:  74623829 40496 0 0 0 0 0 0 0 0 0
[  314.665811] rcu-torture: Free-Block Circulation:  6725 6723 6722 6721 6720 6719 6718 6717 6716 6715 0
[  333.051407] rcu_torture_fwd_prog_nr: Duration 4594 cver 321 gps 512
[  333.713547] rcu_torture_fwd_prog_cr Duration 50 barrier: 53 pending 11353 n_launders: 29003 n_launders_sa: 317 n_max_gps: 100 n_max_cbs: 28989 cver 7 gps 9
[  333.727825] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 107 jiffies): 1s/10: 10585:5 2s/10: 34728:4 3s/10: 12679:3
[  376.071467] rcu-torture: rtc: 00000000d7f79419 ver: 7994 tfle: 0 rta: 7995 rtaf: 0 rtf: 7983 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 147180 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  376.091417] rcu-torture: Reader Pipe:  90164393 22480 0 0 0 0 0 0 0 0 0
[  376.098188] rcu-torture: Reader Batch:  90139122 47764 0 0 0 0 0 0 0 0 0
[  376.105006] rcu-torture: Free-Block Circulation:  7994 7993 7992 7991 7990 7989 7988 7986 7985 7983 0
[  419.103457] rcu_torture_fwd_prog_nr: Duration 5609 cver 364 gps 827
[  419.623718] rcu_torture_fwd_prog_cr Duration 50 barrier: 33 pending 6786 n_launders: 29745 n_launders_sa: 102 n_max_gps: 100 n_max_cbs: 22162 cver 8 gps 12
[  419.637804] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 86 jiffies): 1s/10: 13487:5 2s/10: 30939:7 3s/10: 7481:2
[  437.511566] rcu-torture: rtc: 00000000acae9a3a ver: 9408 tfle: 0 rta: 9408 rtaf: 0 rtf: 9399 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 171889 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  437.530207] rcu-torture: Reader Pipe:  105326024 26408 0 0 0 0 0 0 0 0 0
[  437.537399] rcu-torture: Reader Batch:  105296742 55707 0 0 0 0 0 0 0 0 0
[  437.544516] rcu-torture: Free-Block Circulation:  9407 9407 9406 9405 9404 9403 9402 9401 9400 9399 0
[  448.227482] cpufreq: __target_index: Failed to change cpu frequency: -5
[  448.283466] cpufreq: __target_index: Failed to change cpu frequency: -5
[  448.343464] cpufreq: __target_index: Failed to change cpu frequency: -5
[  498.767427] rcu_torture_fwd_prog_nr: Duration 4043 cver 314 gps 482
[  498.955449] rcu-torture: rtc: 000000006f4ac24b ver: 10838 tfle: 0 rta: 10839 rtaf: 0 rtf: 10824 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 199047 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  498.974351] rcu-torture: Reader Pipe:  122211400 30464 0 0 0 0 0 0 0 0 0
[  498.981281] rcu-torture: Reader Batch:  122177972 63909 0 0 0 0 0 0 0 0 0
[  498.988223] rcu-torture: Free-Block Circulation:  10838 10837 10836 10835 10834 10833 10831 10828 10825 10824 0
[  499.193895] rcu_torture_fwd_prog_cr Duration 34 barrier: 24 pending 15388 n_launders: 32067 n_launders_sa: 7102 n_max_gps: 100 n_max_cbs: 20880 cver 1 gps 10
[  499.208156] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 62 jiffies): 1s/10: 21050:6 2s/10: 31897:8
[  560.391467] rcu-torture: rtc: 000000006fac79f9 ver: 12420 tfle: 0 rta: 12420 rtaf: 0 rtf: 12407 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 224178 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  560.410615] rcu-torture: Reader Pipe:  137980786 35026 0 0 0 0 0 0 0 0 0
[  560.417610] rcu-torture: Reader Batch:  137942800 73030 0 0 0 0 0 0 0 0 0
[  560.424675] rcu-torture: Free-Block Circulation:  12422 12419 12417 12416 12414 12412 12411 12410 12409 12408 0
[  585.963407] rcu_torture_fwd_prog_nr: Duration 5362 cver 311 gps 604
[  586.427747] rcu_torture_fwd_prog_cr Duration 30 barrier: 36 pending 12966 n_launders: 15864 n_launders_sa: 6592 n_max_gps: 100 n_max_cbs: 14363 cver 6 gps 7
[  586.442133] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 69 jiffies): 1s/10: 9273:6 2s/10: 20954:4
[  621.831497] rcu-torture: rtc: 0000000088efe1d5 ver: 13771 tfle: 0 rta: 13772 rtaf: 0 rtf: 13760 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 249276 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  621.851423] rcu-torture: Reader Pipe:  153460629 38916 0 0 0 0 0 0 0 0 0
[  621.858293] rcu-torture: Reader Batch:  153418888 80677 0 0 0 0 0 0 0 0 0
[  621.865261] rcu-torture: Free-Block Circulation:  13771 13770 13768 13767 13765 13764 13763 13762 13761 13760 0
[  657.427423] rcu_torture_fwd_prog_nr: Duration 2236 cver 166 gps 264
[  657.979270] rcu_torture_fwd_prog_cr Duration 36 barrier: 42 pending 14533 n_launders: 24368 n_launders_sa: 1 n_max_gps: 100 n_max_cbs: 14535 cver 6 gps 9
[  657.993374] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 82 jiffies): 1s/10: 15341:6 2s/10: 23562:6
[  683.275456] rcu-torture: rtc: 000000006c6fda6a ver: 15243 tfle: 0 rta: 15243 rtaf: 0 rtf: 15231 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 274134 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  683.294353] rcu-torture: Reader Pipe:  168823340 43102 0 0 0 0 0 0 0 0 0
[  683.303434] rcu-torture: Reader Batch:  168777355 89107 0 0 0 0 0 0 0 0 0
[  683.310384] rcu-torture: Free-Block Circulation:  15243 15242 15241 15240 15239 15238 15237 15236 15235 15234 0
[  744.711488] rcu-torture: rtc: 000000009d05af10 ver: 16532 tfle: 0 rta: 16533 rtaf: 0 rtf: 16522 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 298520 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  744.730630] rcu-torture: Reader Pipe:  183621702 46641 0 0 0 0 0 0 0 0 0
[  744.737674] rcu-torture: Reader Batch:  183571809 96556 0 0 0 0 0 0 0 0 0
[  744.744775] rcu-torture: Free-Block Circulation:  16532 16531 16530 16529 16528 16527 16526 16525 16524 16523 0
[  745.895408] rcu_torture_fwd_prog_nr: Duration 6429 cver 360 gps 742
[  746.343098] rcu_torture_fwd_prog_cr Duration 36 barrier: 29 pending 11544 n_launders: 21556 n_launders_sa: 12255 n_max_gps: 100 n_max_cbs: 15596 cver 5 gps 9
[  746.358669] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 69 jiffies): 1s/10: 11069:6 2s/10: 26083:6
[  806.151563] rcu-torture: rtc: 00000000a00e51a8 ver: 17936 tfle: 0 rta: 17937 rtaf: 0 rtf: 17925 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 323365 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  806.170711] rcu-torture: Reader Pipe:  199004925 50650 0 0 0 0 0 0 0 0 0
[  806.177745] rcu-torture: Reader Batch:  198950674 104922 0 0 0 0 0 0 0 0 0
[  806.184879] rcu-torture: Free-Block Circulation:  17937 17936 17935 17932 17931 17930 17929 17928 17927 17926 0
[  820.059424] rcu_torture_fwd_prog_nr: Duration 2953 cver 193 gps 314
[  820.587381] rcu_torture_fwd_prog_cr Duration 34 barrier: 30 pending 7052 n_launders: 17731 n_launders_sa: 103 n_max_gps: 100 n_max_cbs: 18574 cver 6 gps 11
[  820.601711] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 68 jiffies): 1s/10: 17629:7 2s/10: 18676:6
[  867.591480] rcu-torture: rtc: 000000007015fe2e ver: 19268 tfle: 0 rta: 19269 rtaf: 0 rtf: 19255 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 347779 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  867.611453] rcu-torture: Reader Pipe:  213932998 54453 0 0 0 0 0 0 0 0 0
[  867.618330] rcu-torture: Reader Batch:  213874751 112723 0 0 0 0 0 0 0 0 0
[  867.625335] rcu-torture: Free-Block Circulation:  19269 19268 19267 19265 19264 19263 19262 19261 19259 19256 0
[  891.535435] rcu_torture_fwd_prog_nr: Duration 2397 cver 192 gps 316
[  891.997923] rcu_torture_fwd_prog_cr Duration 38 barrier: 29 pending 10717 n_launders: 19422 n_launders_sa: 185 n_max_gps: 100 n_max_cbs: 14935 cver 8 gps 10
[  892.012309] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 71 jiffies): 1s/10: 13052:7 2s/10: 21305:6
[  929.031526] rcu-torture: rtc: 00000000950ec0d1 ver: 20738 tfle: 0 rta: 20738 rtaf: 0 rtf: 20729 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 373451 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  929.050430] rcu-torture: Reader Pipe:  229637192 58557 0 0 0 0 0 0 0 0 0
[  929.057299] rcu-torture: Reader Batch:  229574549 121227 0 0 0 0 0 0 0 0 0
[  929.064321] rcu-torture: Free-Block Circulation:  20737 20737 20736 20735 20734 20733 20732 20731 20730 20729 0
[  983.239440] rcu_torture_fwd_prog_nr: Duration 6374 cver 392 gps 771
[  983.699796] rcu_torture_fwd_prog_cr Duration 20 barrier: 32 pending 7084 n_launders: 10068 n_launders_sa: 101 n_max_gps: 100 n_max_cbs: 10233 cver 4 gps 7
[  983.713981] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 55 jiffies): 1s/10: 16621:8 2s/10: 3680:2
[  990.471456] rcu-torture: rtc: 00000000a00e51a8 ver: 22144 tfle: 0 rta: 22145 rtaf: 0 rtf: 22132 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 398547 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[  990.490361] rcu-torture: Reader Pipe:  245038234 62427 0 0 0 0 0 0 0 0 0
[  990.497269] rcu-torture: Reader Batch:  244971458 129230 0 0 0 0 0 0 0 0 0
[  990.504295] rcu-torture: Free-Block Circulation:  22144 22144 22143 22142 22141 22140 22139 22137 22136 22134 0
[ 1051.911438] rcu-torture: rtc: 00000000a2033ded ver: 23556 tfle: 0 rta: 23557 rtaf: 0 rtf: 23543 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 422979 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1051.930353] rcu-torture: Reader Pipe:  260300077 66370 0 0 0 0 0 0 0 0 0
[ 1051.937224] rcu-torture: Reader Batch:  260229042 137435 0 0 0 0 0 0 0 0 0
[ 1051.944304] rcu-torture: Free-Block Circulation:  23556 23556 23555 23554 23552 23551 23550 23548 23547 23546 0
[ 1057.235408] rcu_torture_fwd_prog_nr: Duration 2860 cver 183 gps 316
[ 1057.620007] rcu_torture_fwd_prog_cr Duration 33 barrier: 25 pending 16028 n_launders: 28240 n_launders_sa: 4401 n_max_gps: 100 n_max_cbs: 21616 cver 0 gps 8
[ 1057.634176] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 61 jiffies): 1s/10: 20966:6 2s/10: 28890:5
[ 1113.351453] rcu-torture: rtc: 00000000e7866be4 ver: 25042 tfle: 0 rta: 25043 rtaf: 0 rtf: 25031 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 447783 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1113.371458] rcu-torture: Reader Pipe:  275866686 70632 0 0 0 0 0 0 0 0 0
[ 1113.378316] rcu-torture: Reader Batch:  275791374 145975 0 0 0 0 0 0 0 0 0
[ 1113.385344] rcu-torture: Free-Block Circulation:  25042 25041 25040 25039 25038 25037 25036 25033 25032 25031 0
[ 1141.035410] rcu_torture_fwd_prog_nr: Duration 4864 cver 241 gps 482
[ 1141.438910] rcu_torture_fwd_prog_cr Duration 25 barrier: 27 pending 11862 n_launders: 12518 n_launders_sa: 0 n_max_gps: 100 n_max_cbs: 11864 cver 3 gps 8
[ 1141.453265] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 56 jiffies): 1s/10: 12316:8 2s/10: 12066:2
[ 1174.791496] rcu-torture: rtc: 00000000b3cbeac9 ver: 26410 tfle: 0 rta: 26411 rtaf: 0 rtf: 26401 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 473097 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1174.810663] rcu-torture: Reader Pipe:  291515904 74558 0 0 0 0 0 0 0 0 0
[ 1174.817647] rcu-torture: Reader Batch:  291436558 153934 0 0 0 0 0 0 0 0 0
[ 1174.824783] rcu-torture: Free-Block Circulation:  26411 26410 26409 26408 26407 26406 26405 26404 26403 26402 0
[ 1199.467463] cpufreq: __target_index: Failed to change cpu frequency: -5
[ 1199.523431] cpufreq: __target_index: Failed to change cpu frequency: -5
[ 1199.579444] cpufreq: __target_index: Failed to change cpu frequency: -5
[ 1199.631442] cpufreq: __target_index: Failed to change cpu frequency: -5
[ 1199.683444] cpufreq: __target_index: Failed to change cpu frequency: -5
[ 1213.751408] rcu_torture_fwd_prog_nr: Duration 2561 cver 156 gps 272
[ 1214.493676] rcu_torture_fwd_prog_cr Duration 64 barrier: 75 pending 6309 n_launders: 28428 n_launders_sa: 9192 n_max_gps: 100 n_max_cbs: 44878 cver 12 gps 14
[ 1214.511007] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 143 jiffies): 1s/10: 4946:4 2s/10: 34203:4 3s/10: 34157:8
[ 1236.231477] rcu-torture: rtc: 00000000291363a7 ver: 27745 tfle: 0 rta: 27746 rtaf: 0 rtf: 27732 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 498035 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1236.251425] rcu-torture: Reader Pipe:  306958447 78330 0 0 0 0 0 0 0 0 0
[ 1236.258568] rcu-torture: Reader Batch:  306874956 161854 0 0 0 0 0 0 0 0 0
[ 1236.265608] rcu-torture: Free-Block Circulation:  27745 27742 27741 27740 27739 27737 27736 27735 27734 27732 0
[ 1288.855420] rcu_torture_fwd_prog_nr: Duration 2910 cver 150 gps 450
[ 1289.193347] rcu_torture_fwd_prog_cr Duration 27 barrier: 18 pending 9130 n_launders: 19196 n_launders_sa: 13850 n_max_gps: 100 n_max_cbs: 13749 cver 0 gps 9
[ 1289.207581] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 49 jiffies): 1s/10: 19096:8 2s/10: 13849:3
[ 1297.671545] rcu-torture: rtc: 0000000089bba9ca ver: 29158 tfle: 0 rta: 29158 rtaf: 0 rtf: 29148 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 522215 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1297.690658] rcu-torture: Reader Pipe:  321974523 82313 0 0 0 0 0 0 0 0 0
[ 1297.697706] rcu-torture: Reader Batch:  321886741 170129 0 0 0 0 0 0 0 0 0
[ 1297.704924] rcu-torture: Free-Block Circulation:  29160 29159 29158 29157 29156 29155 29154 29153 29152 29150 0
[ 1359.111511] rcu-torture: rtc: 000000001bdbf93f ver: 30625 tfle: 0 rta: 30626 rtaf: 0 rtf: 30614 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 547332 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1359.130654] rcu-torture: Reader Pipe:  337720601 86544 0 0 0 0 0 0 0 0 0
[ 1359.137675] rcu-torture: Reader Batch:  337628286 178893 0 0 0 0 0 0 0 0 0
[ 1359.144854] rcu-torture: Free-Block Circulation:  30627 30625 30624 30623 30622 30621 30620 30619 30618 30616 0
[ 1370.903433] rcu_torture_fwd_prog_nr: Duration 4991 cver 259 gps 574
[ 1371.417591] rcu_torture_fwd_prog_cr Duration 41 barrier: 32 pending 8114 n_launders: 13569 n_launders_sa: 427 n_max_gps: 100 n_max_cbs: 14569 cver 6 gps 8
[ 1371.431856] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 77 jiffies): 1s/10: 4875:4 2s/10: 22835:6 3s/10: 428:1
[ 1420.551661] rcu-torture: rtc: 00000000a439da5b ver: 31971 tfle: 0 rta: 31971 rtaf: 0 rtf: 31962 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 572674 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1420.570631] rcu-torture: Reader Pipe:  353218469 90358 0 0 0 0 0 0 0 0 0
[ 1420.577546] rcu-torture: Reader Batch:  353122253 186608 0 0 0 0 0 0 0 0 0
[ 1420.584565] rcu-torture: Free-Block Circulation:  31970 31970 31969 31968 31967 31966 31965 31964 31963 31962 0
[ 1443.575634] rcu_torture_fwd_prog_nr: Duration 2677 cver 197 gps 307
[ 1444.229871] rcu_torture_fwd_prog_cr Duration 69 barrier: 41 pending 8749 n_launders: 47293 n_launders_sa: 40732 n_max_gps: 100 n_max_cbs: 28517 cver 4 gps 13
[ 1444.263240] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 118 jiffies): 1s/10: 6562:3 2s/10: 36657:5 3s/10: 30190:6 4s/10: 2401:2
[ 1481.991457] rcu-torture: rtc: 00000000babfc60e ver: 33433 tfle: 0 rta: 33433 rtaf: 0 rtf: 33423 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 598519 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1482.010374] rcu-torture: Reader Pipe:  369283515 94426 0 0 0 0 0 0 0 0 0
[ 1482.017538] rcu-torture: Reader Batch:  369182893 195081 0 0 0 0 0 0 0 0 0
[ 1482.024735] rcu-torture: Free-Block Circulation:  33433 33432 33431 33430 33429 33428 33427 33426 33425 33424 0
[ 1487.891535] Adding 2543608k swap on /dev/sda2.  Priority:-2 extents:1 across:2543608k 
[ 1506.901112] PM: hibernation: hibernation entry
[ 1506.908948] Filesystems sync: 0.000 seconds
[ 1506.913461] Freezing user space processes ... (elapsed 0.004 seconds) done.
[ 1506.925595] OOM killer disabled.
[ 1506.933280] PM: hibernation: Preallocating image memory
[ 1508.326491] PM: hibernation: Allocated 97058 pages for snapshot
[ 1508.332547] PM: hibernation: Allocated 388232 kbytes in 1.38 seconds (281.32 MB/s)
[ 1508.340256] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 1508.351931] printk: Suspending console(s) (use no_console_suspend to debug)
[ 1508.396262] usbcore:hub_suspend: hub 1-1:1.0: hub_suspend
[ 1508.398618] usbcore:hub_suspend: hub 1-0:1.0: hub_suspend
[ 1508.398702] usbcore:hcd_bus_suspend: usb usb1: bus suspend, wakeup 0
[ 1508.454532] Disabling non-boot CPUs ...
[ 1508.457758] CPU1: shutdown
[ 1508.457772] psci: CPU1 killed (polled 0 ms)
[ 1508.466944] CPU2: shutdown
[ 1508.468030] psci: CPU2 killed (polled 4 ms)
[ 1508.473377] CPU3: shutdown
[ 1508.473401] psci: CPU3 killed (polled 0 ms)
[ 1508.497978] CPU4: shutdown
[ 1508.498002] psci: CPU4 killed (polled 0 ms)
[ 1508.515008] CPU5: shutdown
[ 1508.515032] psci: CPU5 killed (polled 0 ms)
[ 1508.516800] PM: hibernation: Creating image:
[ 1508.516800] PM: hibernation: Need to copy 95831 pages
[ 1508.516800] PM: hibernation: Image created (95831 pages copied)
[ 1508.516989] Enabling non-boot CPUs ...
[ 1508.530874] Detected PIPT I-cache on CPU1
[ 1508.530938] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[ 1508.533432] CPU1 is up
[ 1508.547085] Detected PIPT I-cache on CPU2
[ 1508.547124] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[ 1508.548734] CPU2 is up
[ 1508.562597] Detected VIPT I-cache on CPU3
[ 1508.562680] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[ 1508.565722] CPU3 is up
[ 1508.579511] Detected VIPT I-cache on CPU4
[ 1508.579577] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[ 1508.582624] CPU4 is up
[ 1508.596422] Detected VIPT I-cache on CPU5
[ 1508.596484] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[ 1508.599819] CPU5 is up
[ 1508.635427] usbcore:hcd_bus_resume: usb usb1: usb resume
[ 1508.663949] usbcore:hcd_bus_resume: usb usb2: usb resume
[ 1508.698488] usbcore:hub_resume: hub 1-0:1.0: hub_resume
[ 1508.698684] usbcore:hub_activate: usb usb1-port1: status 0503 change 0000
[ 1508.698960] usbcore:hub_resume: hub 1-1:1.0: hub_resume
[ 1508.699424] usbcore:hub_activate: usb 1-1-port1: status 0503 change 0000
[ 1508.744319] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[ 1508.744535] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[ 1508.952296] hibernate: Hibernating on CPU 0 [mpidr:0x100]
[ 1509.029654] PM: Using 3 thread(s) for compression
[ 1509.034501] PM: Compressing and saving image data (96019 pages)...
[ 1509.040930] PM: Image saving progress:   0%
[ 1510.695439] ata1: SATA link down (SStatus 0 SControl 0)
[ 1510.700971] ata2: SATA link down (SStatus 0 SControl 0)
[ 1514.118386] PM: Image saving progress:  10%
[ 1514.281248] PM: Image saving progress:  20%
[ 1514.352696] PM: Image saving progress:  30%
[ 1515.313655] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[ 1517.074193] PM: Image saving progress:  40%
[ 1521.275281] PM: Image saving progress:  50%
[ 1521.985264] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[ 1523.463876] ------------[ cut here ]------------
[ 1523.468620] WARNING: CPU: 3 PID: 261 at kernel/rcu/rcutorture.c:1055 rcu_torture_writer+0x664/0xa90
[ 1523.477854] Modules linked in:
[ 1523.480989] CPU: 3 PID: 261 Comm: rcu_torture_wri Tainted: G        W         5.6.0-rc6-00002-gdfd1731f9a3e #541
[ 1523.491374] Hardware name: ARM Juno development board (r2) (DT)
[ 1523.497421] pstate: 00000005 (nzcv daif -PAN -UAO)
[ 1523.502318] pc : rcu_torture_writer+0x664/0xa90
[ 1523.506950] lr : rcu_torture_writer+0x65c/0xa90
[ 1523.511579] sp : ffff800018c4bde0
[ 1523.514970] x29: ffff800018c4bde0 x28: ffff80001426e200 
[ 1523.520401] x27: ffff80001426cf08 x26: ffff80001426cf08 
[ 1523.525832] x25: ffff8000121b5000 x24: 0000000000000001 
[ 1523.531264] x23: ffff80001426d648 x22: ffff80001426b000 
[ 1523.536694] x21: ffff800013439000 x20: ffff80001426e938 
[ 1523.542125] x19: ffff80001426c000 x18: 00000000fffffffd 
[ 1523.547555] x17: dc1a0015bd1a0108 x16: 102d7c245e000f18 
[ 1523.552986] x15: 8003952700001b91 x14: 80003abf2549fc26 
[ 1523.558418] x13: 1a00a41000240120 x12: 0000000000000003 
[ 1523.563848] x11: 0000000000003b06 x10: 0000000000000000 
[ 1523.569279] x9 : ffff800013a130a0 x8 : ffff0009750d3750 
[ 1523.574710] x7 : 0000000000000000 x6 : ffff800018c4bd20 
[ 1523.580140] x5 : 0000000000000001 x4 : 0000000000000000 
[ 1523.585571] x3 : 0000000000000080 x2 : 0000000002611501 
[ 1523.591001] x1 : 0000000000000000 x0 : 0000000000000001 
[ 1523.596431] Call trace:
[ 1523.598940]  rcu_torture_writer+0x664/0xa90
[ 1523.603220]  kthread+0x13c/0x140
[ 1523.606527]  ret_from_fork+0x10/0x18
[ 1523.610184] irq event stamp: 1104256
[ 1523.613846] hardirqs last  enabled at (1104255): [<ffff8000101beb4c>] call_rcu+0xec/0x1e0
[ 1523.622201] hardirqs last disabled at (1104256): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
[ 1523.631528] softirqs last  enabled at (1104250): [<ffff8000101ba304>] rcu_torture_writer+0x28c/0xa90
[ 1523.640854] softirqs last disabled at (1104248): [<ffff8000101ba2b8>] rcu_torture_writer+0x240/0xa90
[ 1523.650174] ---[ end trace f4c0292c296f056b ]---
[ 1525.952260] rcu_torture_fwd_prog_nr: Duration 4836 cver 442 gps 555
[ 1526.364916] rcu_torture_fwd_prog_cr Duration 35 barrier: 30 pending 14089 n_launders: 20949 n_launders_sa: 7854 n_max_gps: 100 n_max_cbs: 14938 cver 3 gps 11
[ 1526.379365] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 69 jiffies): 1s/10: 13096:7 2s/10: 22791:7
[ 1529.173844] PM: Image saving progress:  60%
[ 1529.641286] PM: Image saving progress:  70%
[ 1533.819717] PM: Image saving progress:  80%
[ 1539.807208] PM: Image saving progress:  90%
[ 1540.289830] PM: Image saving progress: 100%
[ 1540.299999] PM: Image saving done
[ 1540.303543] PM: hibernation: Wrote 384076 kbytes in 31.25 seconds (12.29 MB/s)
[ 1540.316607] PM: S|
[ 1540.623981] printk: Suspending console(s) (use no_console_suspend to debug)
[ 1540.660035] usbcore:usb_port_suspend: usb 1-1.1: usb suspend, wakeup 0
[ 1540.660198] usbcore:hub_suspend: hub 1-1:1.0: hub_suspend
[ 1540.662500] usbcore:usb_port_suspend: usb 1-1: usb suspend, wakeup 0
[ 1540.744669] psmouse serio1: Failed to disable mouse on 1c070000.kmi
[ 1541.071650] psmouse serio0: Failed to disable mouse on 1c060000.kmi
[ 1541.293276] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[ 1541.293428] usbcore:hcd_bus_suspend: usb usb2: bus suspend, wakeup 0
[ 1541.294019] usbcore:hub_suspend: hub 1-0:1.0: hub_suspend
[ 1541.294626] usbcore:hcd_bus_suspend: usb usb1: bus suspend, wakeup 0
[ 1541.672882] Disabling non-boot CPUs ...
[ 1541.677863] CPU1: shutdown
[ 1541.677892] psci: CPU1 killed (polled 0 ms)
[ 1541.683584] CPU2: shutdown
[ 1541.684659] psci: CPU2 killed (polled 0 ms)
[ 1541.698413] CPU3: shutdown
[ 1541.698437] psci: CPU3 killed (polled 0 ms)
[ 1541.703558] CPU4: shutdown
[ 1541.703581] psci: CPU4 killed (polled 0 ms)
[ 1541.709947] CPU5: shutdown
[ 1541.709971] psci: CPU5 killed (polled 0 ms)
[ 1541.712919] Enabling non-boot CPUs ...
[ 1541.728562] Detected PIPT I-cache on CPU1
[ 1541.728623] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[ 1541.731362] CPU1 is up
[ 1541.745968] Detected PIPT I-cache on CPU2
[ 1541.746007] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[ 1541.747593] CPU2 is up
[ 1541.761801] Detected VIPT I-cache on CPU3
[ 1541.761881] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[ 1541.765426] CPU3 is up
[ 1541.779111] Detected VIPT I-cache on CPU4
[ 1541.779176] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[ 1541.782619] CPU4 is up
[ 1541.796272] Detected VIPT I-cache on CPU5
[ 1541.796337] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[ 1541.800310] CPU5 is up
[ 1542.140492] usbcore:hcd_bus_resume: usb usb1: usb resume
[ 1542.175352] usbcore:hcd_bus_resume: usb usb2: usb resume
[ 1542.202449] usbcore:hub_resume: hub 1-0:1.0: hub_resume
[ 1542.202641] usbcore:hub_activate: usb usb1-port1: status 0503 change 0000
[ 1542.203370] usbcore:wait_for_connected: usb 1-1: Waited 0ms for CONNECT
[ 1542.203396] usbcore:finish_port_resume: usb 1-1: finish resume
[ 1542.203766] usbcore:hub_resume: hub 1-1:1.0: hub_resume
[ 1542.203980] usbcore:hub_activate: usb 1-1-port1: status 0503 change 0000
[ 1542.205097] usbcore:wait_for_connected: usb 1-1.1: Waited 0ms for CONNECT
[ 1542.205110] usbcore:finish_port_resume: usb 1-1.1: finish resume
[ 1542.259265] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[ 1542.259393] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[ 1543.431275] rcu-torture: rtc: 0000000005e1898f ver: 35307 tfle: 0 rta: 35308 rtaf: 0 rtf: 35298 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 623130 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/0:0
[ 1543.431302] rcu-torture: Reader Pipe:  384476031 99661 0 0 0 0 0 0 0 0 0
[ 1543.431333] rcu-torture: Reader Batch:  384372023 203703 0 0 0 0 0 0 0 0 0
[ 1543.431363] rcu-torture: Free-Block Circulation:  35307 35306 35305 35304 35303 35302 35301 35300 35299 35298 0
[ 1544.195320] ata2: SATA link down (SStatus 0 SControl 0)
[ 1544.195401] ata1: SATA link down (SStatus 0 SControl 0)
[ 1548.761974] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[ 1555.407092] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[ 1557.844726] OOM killer enabled.
[ 1557.847957] Restarting tasks ... 
[ 1557.848416] usbcore:hub_event: hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[ 1557.848578] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[ 1557.849774] done.
[ 1557.871361] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[ 1557.871498] hub 2-0:1.0: activate --> -16
[ 1557.871560] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[ 1557.871624] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[ 1557.871633] PM: hibernation: hibernation exit
[ 1557.898882] usbcore:hcd_bus_suspend: usb usb2: bus auto-suspend, wakeup 1
[ 1562.118339] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[ 1565.237499] usbcore:usb_remote_wakeup: usb usb2: usb wakeup-resume
[ 1565.244115] usbcore:hcd_bus_resume: usb usb2: usb auto-resume
[ 1565.254962] usbcore:hub_event: hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
[ 1565.327389] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[ 1565.333227] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[ 1565.340689] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[ 1565.346490] usbcore:hcd_bus_suspend: usb usb2: bus auto-suspend, wakeup 1
[ 1568.819545] psmouse serio1: Failed to enable mouse on 1c070000.kmi

--pbstite62b3gsbf2--

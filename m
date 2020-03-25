Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FAC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBFE20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgCYPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:00:27 -0400
Received: from foss.arm.com ([217.140.110.172]:49490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgCYPA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:00:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 017CB1FB;
        Wed, 25 Mar 2020 08:00:24 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F36FC3F71E;
        Wed, 25 Mar 2020 08:00:22 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:00:20 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Oliver Neukum <oneukum@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200325150017.xhabucfo3v6i234o@e107158-lin>
References: <20200324172235.bsxea6qb3id6bhb3@e107158-lin>
 <Pine.LNX.4.44L0.2003241445210.8484-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qxu4bpb5wy3tv6mq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2003241445210.8484-100000@netrider.rowland.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qxu4bpb5wy3tv6mq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 03/24/20 15:22, Alan Stern wrote:
> On Tue, 24 Mar 2020, Qais Yousef wrote:
> 
> > On 03/24/20 11:56, Alan Stern wrote:
> 
> > > This certainly reinforces the initial impression that the cause of the
> > > warnings is a bug in the platform code.  You should ask the appropriate
> > > maintainer.
> > 
> > The device-tree compatible node returns "generic-ohci".
> > drivers/usb/host/ohci-platform.c returns you as the maintainer :-)
> 
> I'm the maintainer of the driver for the device.  But the device
> structure itself (the one named 7ffb0000.ohci) gets created by 
> device-tree -- that's what I was referring to.
> 
> Here's the first error message:
> 
> usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
> 
> The runtime PM status of 7ffb0000.ohci is set in ohci_platform_probe(),
> which does:
> 
>         pm_runtime_set_active(&dev->dev);
> 
> The runtime PM status can change, and there aren't any debugging 
> statements in ohci_platform_suspend() or ohci_platform_resume() (or 
> ohci_suspend()/ohci_resume() in ohci-hcd.c, for that matter).  Maybe 
> you can add some so we can see if anything strange is going on.
> 
> Any maybe you can find out exactly where that error message is coming 
> from by calling dump_stack() immediately after the dev_err() line 
> (approximately line 1198 in drivers/base/power/runtime.c).
> 
> (Also, you might want to turn off rcutorture.  It adds a lot of 
> messages to the system log that are irrelevant for our purposes.)

Thanks for all the hints Alan.

I think I figured it out, the below patch seems to fix it for me. Looking
at other drivers resume functions it seems we're missing the
pm_runtime_disable()->set_active()->enable() dance. Doing that fixes the
warning and the dev_err() in driver/base/power.

I don't see xhci-plat.c doing that, I wonder if it needs it too.

I'm not well versed about the details and the rules here. So my fix could be
a hack, though it does seem the right thing to do.

I wonder why the power core doesn't handle this transparently..

Requested dmesg is attached too.


diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 7addfc2cbadc..eb92c8092fae 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -299,6 +299,10 @@ static int ohci_platform_resume(struct device *dev)
        }

        ohci_resume(hcd, false);
+
+       pm_runtime_disable(dev);
+       pm_runtime_set_active(dev);
+       pm_runtime_enable(dev);
        return 0;
 }
 #endif /* CONFIG_PM_SLEEP */


Thanks

--
Qais Yousef

--qxu4bpb5wy3tv6mq
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="usb.dmesg"

[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] Linux version 5.6.0-rc6-00002-gdfd1731f9a3e-dirty (qyousef@e107158-lin) (gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)) #545 SMP PREEMPT Wed Mar 25 14:16:10 GMT 2020
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
[    0.000000] percpu: Embedded 48 pages/cpu s158536 r8192 d29880 u196608
[    0.000000] pcpu-alloc: s158536 r8192 d29880 u196608 alloc=48*4096
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
[    0.000000] Memory: 8044524K/8372224K available (25660K kernel code, 4120K rwdata, 12216K rodata, 14656K init, 11183K bss, 294932K reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] ftrace: allocating 77520 entries in 303 pages
[    0.000000] ftrace: allocated 303 pages with 6 groups
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
[    0.000008] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
[    0.008557] Failed to initialize '/smb@8000000/motherboard/iofpga@3,00000000/timer@120000': -22
[    0.018103] arch_timer: cp15 and mmio timer(s) running at 50.00MHz (phys/phys).
[    0.025447] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.036276] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps every 4398046511100ns
[    0.045517] Console: colour dummy device 80x25
[    0.050050] printk: console [tty0] enabled
[    0.054295] printk: bootconsole [pl11] disabled
[    0.058992] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.059159] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.059260] ... MAX_LOCK_DEPTH:          48
[    0.059361] ... MAX_LOCKDEP_KEYS:        8192
[    0.059465] ... CLASSHASH_SIZE:          4096
[    0.059570] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.059676] ... MAX_LOCKDEP_CHAINS:      65536
[    0.059782] ... CHAINHASH_SIZE:          32768
[    0.059887]  memory used by lock dependency info: 6237 kB
[    0.060010]  memory used for stack traces: 4224 kB
[    0.060122]  per task-struct memory footprint: 1920 bytes
[    0.060244] ------------------------
[    0.060334] | Locking API testsuite:
[    0.060424] ----------------------------------------------------------------------------
[    0.060596]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.060767]   --------------------------------------------------------------------------
[    0.060946]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.079440]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.099547]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.121354]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.143126]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.166625]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.190062]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.213553]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.231966]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.249767]   --------------------------------------------------------------------------
[    0.249937]               recursive read-lock:             |  ok  |             |  ok  |
[    0.255564]            recursive read-lock #2:             |  ok  |             |  ok  |
[    0.260970]             mixed read-write-lock:             |  ok  |             |  ok  |
[    0.266382]             mixed write-read-lock:             |  ok  |             |  ok  |
[    0.271793]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
[    0.277515]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
[    0.283397]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
[    0.289274]   --------------------------------------------------------------------------
[    0.289605]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.297567]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    0.305563]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.313516]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    0.321520]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    0.329488]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    0.337502]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.345458]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    0.353477]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.361441]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    0.369453]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.378116]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    0.386824]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.395480]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    0.404183]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.412842]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    0.421545]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.430196]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    0.438895]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.447085]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    0.455316]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.463973]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    0.472673]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.481336]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    0.490034]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.498693]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    0.507410]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.516066]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    0.524770]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.533425]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    0.542130]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.550787]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    0.559501]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.568163]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    0.576870]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.585537]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    0.594252]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.602905]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    0.611620]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.620272]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    0.628982]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.637635]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    0.646346]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.655006]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    0.663718]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.672361]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    0.681063]       hard-irq read-recursion/123:  ok  |
[    0.684017]       soft-irq read-recursion/123:  ok  |
[    0.687014]       hard-irq read-recursion/132:  ok  |
[    0.689967]       soft-irq read-recursion/132:  ok  |
[    0.692963]       hard-irq read-recursion/213:  ok  |
[    0.695917]       soft-irq read-recursion/213:  ok  |
[    0.698910]       hard-irq read-recursion/231:  ok  |
[    0.701862]       soft-irq read-recursion/231:  ok  |
[    0.704861]       hard-irq read-recursion/312:  ok  |
[    0.707814]       soft-irq read-recursion/312:  ok  |
[    0.710809]       hard-irq read-recursion/321:  ok  |
[    0.713763]       soft-irq read-recursion/321:  ok  |
[    0.716757]   --------------------------------------------------------------------------
[    0.716927]   | Wound/wait tests |
[    0.717014]   ---------------------
[    0.717102]                   ww api failures:  ok  |  ok  |  ok  |
[    0.725588]                ww contexts mixing:  ok  |  ok  |
[    0.731180]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    0.742246]                locking mismatches:  ok  |  ok  |  ok  |
[    0.750716]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.779593]            spinlock nest unlocked:  ok  |
[    0.782307]   -----------------------------------------------------
[    0.782442]                                  |block | try  |context|
[    0.782577]   -----------------------------------------------------
[    0.782711]                           context:  ok  |  ok  |  ok  |
[    0.791429]                               try:  ok  |  ok  |  ok  |
[    0.799631]                             block:  ok  |  ok  |  ok  |
[    0.807872]                          spinlock:  ok  |  ok  |  ok  |
[    0.816791] -------------------------------------------------------
[    0.816927] Good, all 261 testcases passed! |
[    0.817029] ---------------------------------
[    0.817366] Calibrating delay loop (skipped), value calculated using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.817640] pid_max: default: 32768 minimum: 301
[    0.818117] LSM: Security Framework initializing
[    0.818411] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.818617] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.854086] rcu: Hierarchical SRCU implementation.
[    0.871249] EFI services will not be available.
[    0.878379] smp: Bringing up secondary CPUs ...
[    0.924476] CPU features: detected: EL2 vector hardening
[    0.924488] ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware
[    0.924496] CPU features: detected: ARM erratum 1319367
[    0.924502] Detected PIPT I-cache on CPU1
[    0.924565] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[    0.968768] Detected PIPT I-cache on CPU2
[    0.968804] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[    1.013229] Detected VIPT I-cache on CPU3
[    1.013300] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[    1.057633] Detected VIPT I-cache on CPU4
[    1.057692] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[    1.102062] Detected VIPT I-cache on CPU5
[    1.102119] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[    1.102748] smp: Brought up 1 node, 6 CPUs
[    1.104412] SMP: Total of 6 processors activated.
[    1.104635] CPU features: detected: 32-bit EL0 Support
[    1.104773] CPU features: detected: CRC32 instructions
[    1.168392] CPU: All CPU(s) started at EL2
[    1.168658] alternatives: patching kernel code
[    1.173720] devtmpfs: initialized
[    1.193388] KASLR disabled due to lack of seed
[    1.195550] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    1.195672] futex hash table entries: 2048 (order: 6, 262144 bytes, linear)
[    1.197239] xor: measuring software checksum speed
[    1.234111]    8regs     :  4239.000 MB/sec
[    1.274329]    32regs    :  4763.000 MB/sec
[    1.314588]    arm64_neon:  4422.000 MB/sec
[    1.314642] xor: using function: 32regs (4763.000 MB/sec)
[    1.314711] pinctrl core: initialized pinctrl subsystem
[    1.317493] thermal_sys: Registered thermal governor 'step_wise'
[    1.317499] thermal_sys: Registered thermal governor 'power_allocator'
[    1.319214] DMI not present or invalid.
[    1.320478] NET: Registered protocol family 16
[    1.324609] DMA: preallocated 256 KiB pool for atomic allocations
[    1.324694] audit: initializing netlink subsys (disabled)
[    1.325236] audit: type=2000 audit(1.044:1): state=initialized audit_enabled=0 res=1
[    1.327342] cpuidle: using governor menu
[    1.327610] NET: Registered protocol family 42
[    1.328197] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    1.328700] ASID allocator initialised with 65536 entries
[    1.330723] Serial: AMBA PL011 UART driver
[    1.360582] 7ff80000.uart: ttyAMA0 at MMIO 0x7ff80000 (irq = 31, base_baud = 0) is a PL011 rev3
[    2.798170] printk: console [ttyAMA0] enabled
[    2.862142] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.869034] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    2.875841] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.882657] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    2.916023] cryptd: max_cpu_qlen set to 1000
[    3.017580] raid6: neonx8   gen()  3109 MB/s
[    3.090046] raid6: neonx8   xor()  2105 MB/s
[    3.162564] raid6: neonx4   gen()  3115 MB/s
[    3.234985] raid6: neonx4   xor()  2169 MB/s
[    3.307454] raid6: neonx2   gen()  2693 MB/s
[    3.379910] raid6: neonx2   xor()  2010 MB/s
[    3.452380] raid6: neonx1   gen()  1993 MB/s
[    3.524838] raid6: neonx1   xor()  1589 MB/s
[    3.597305] raid6: int64x8  gen()  1567 MB/s
[    3.669756] raid6: int64x8  xor()   889 MB/s
[    3.742226] raid6: int64x4  gen()  1815 MB/s
[    3.814687] raid6: int64x4  xor()   958 MB/s
[    3.887140] raid6: int64x2  gen()  1601 MB/s
[    3.959610] raid6: int64x2  xor()   839 MB/s
[    4.032067] raid6: int64x1  gen()  1222 MB/s
[    4.104533] raid6: int64x1  xor()   631 MB/s
[    4.108935] raid6: using algorithm neonx4 gen() 3115 MB/s
[    4.114420] raid6: .... xor() 2169 MB/s, rmw enabled
[    4.119466] raid6: using neon recovery algorithm
[    4.125047] ACPI: Interpreter disabled.
[    4.131906] iommu: Default domain type: Translated 
[    4.137540] vgaarb: loaded
[    4.141299] SCSI subsystem initialized
[    4.145645] libata version 3.00 loaded.
[    4.150204] usbcore: registered new interface driver usbfs
[    4.155912] usbcore: registered new interface driver hub
[    4.161514] usbcore: registered new device driver usb
[    4.169580] mc: Linux media interface: v0.10
[    4.174009] videodev: Linux video capture interface: v2.00
[    4.179858] pps_core: LinuxPPS API ver. 1 registered
[    4.184911] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.194206] PTP clock support registered
[    4.199016] EDAC MC: Ver: 3.0.0
[    4.204950] FPGA manager framework
[    4.208929] Advanced Linux Sound Architecture Driver Initialized.
[    4.216504] Bluetooth: Core ver 2.22
[    4.220219] NET: Registered protocol family 31
[    4.224747] Bluetooth: HCI device and connection manager initialized
[    4.231233] Bluetooth: HCI socket layer initialized
[    4.236207] Bluetooth: L2CAP socket layer initialized
[    4.241403] Bluetooth: SCO socket layer initialized
[    4.247908] clocksource: Switched to clocksource arch_sys_counter
[    5.092304] VFS: Disk quotas dquot_6.6.0
[    5.096486] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.104257] pnp: PnP ACPI: disabled
[    5.126899] NET: Registered protocol family 2
[    5.132268] tcp_listen_portaddr_hash hash table entries: 4096 (order: 6, 294912 bytes, linear)
[    5.141703] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    5.150017] TCP bind hash table entries: 65536 (order: 10, 4194304 bytes, linear)
[    5.168454] TCP: Hash tables configured (established 65536 bind 65536)
[    5.175673] UDP hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    5.184143] UDP-Lite hash table entries: 4096 (order: 7, 655360 bytes, linear)
[    5.193203] NET: Registered protocol family 1
[    5.199434] RPC: Registered named UNIX socket transport module.
[    5.205500] RPC: Registered udp transport module.
[    5.210304] RPC: Registered tcp transport module.
[    5.215105] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    5.222684] PCI: CLS 0 bytes, default 64
[    6.577624] hw perfevents: enabled with armv8_cortex_a72 PMU driver, 7 counters available
[    6.587298] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    6.595760] kvm [1]: IPA Size Limit: 40bits
[    6.608906] kvm [1]: vgic interrupt IRQ1
[    6.613502] kvm [1]: Hyp mode initialized successfully
[    7.080099] Initialise system trusted keyrings
[    7.085057] workingset: timestamp_bits=44 max_order=21 bucket_order=0
[    7.120549] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.129076] NFS: Registering the id_resolver key type
[    7.134304] Key type id_resolver registered
[    7.138597] Key type id_legacy registered
[    7.142713] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.149953] fuse: init (API version 7.31)
[    7.155477] 9p: Installing v9fs 9p2000 file system support
[    7.183946] Key type asymmetric registered
[    7.188171] Asymmetric key parser 'x509' registered
[    7.193229] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    7.200782] io scheduler mq-deadline registered
[    7.205432] io scheduler kyber registered
[    7.225296] pl061_gpio 1c1d0000.gpio: PL061 GPIO chip registered
[    7.235193] pci-host-generic 40000000.pcie: host bridge /pcie@40000000 ranges:
[    7.242600] pci-host-generic 40000000.pcie:       IO 0x005f800000..0x005fffffff -> 0x0000000000
[    7.251513] pci-host-generic 40000000.pcie:      MEM 0x0050000000..0x0057ffffff -> 0x0050000000
[    7.260389] pci-host-generic 40000000.pcie:      MEM 0x4000000000..0x40ffffffff -> 0x4000000000
[    7.269326] pci-host-generic 40000000.pcie: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-ff]
[    7.278527] pci-host-generic 40000000.pcie: PCI host bridge to bus 0000:00
[    7.285533] pci_bus 0000:00: root bus resource [bus 00-ff]
[    7.291123] pci_bus 0000:00: root bus resource [io  0x0000-0x7fffff]
[    7.297590] pci_bus 0000:00: root bus resource [mem 0x50000000-0x57ffffff]
[    7.304582] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x40ffffffff pref]
[    7.312464] pci 0000:00:00.0: [1556:1100] type 01 class 0x060400
[    7.318635] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit pref]
[    7.326164] pci 0000:00:00.0: supports D1 D2
[    7.330525] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.339261] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.347697] pci 0000:01:00.0: [111d:8090] type 01 class 0x060400
[    7.353962] pci 0000:01:00.0: enabling Extended Tags
[    7.359209] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    7.377317] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.385860] pci 0000:02:01.0: [111d:8090] type 01 class 0x060400
[    7.392141] pci 0000:02:01.0: enabling Extended Tags
[    7.397415] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    7.404279] pci 0000:02:02.0: [111d:8090] type 01 class 0x060400
[    7.410549] pci 0000:02:02.0: enabling Extended Tags
[    7.415822] pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
[    7.422643] pci 0000:02:03.0: [111d:8090] type 01 class 0x060400
[    7.428912] pci 0000:02:03.0: enabling Extended Tags
[    7.434185] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[    7.441395] pci 0000:02:0c.0: [111d:8090] type 01 class 0x060400
[    7.447666] pci 0000:02:0c.0: enabling Extended Tags
[    7.452938] pci 0000:02:0c.0: PME# supported from D0 D3hot D3cold
[    7.459931] pci 0000:02:10.0: [111d:8090] type 01 class 0x060400
[    7.466186] pci 0000:02:10.0: enabling Extended Tags
[    7.471444] pci 0000:02:10.0: PME# supported from D0 D3hot D3cold
[    7.478879] pci 0000:02:1f.0: [111d:8090] type 01 class 0x060400
[    7.485150] pci 0000:02:1f.0: enabling Extended Tags
[    7.490430] pci 0000:02:1f.0: PME# supported from D0 D3hot D3cold
[    7.497230] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.505402] pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.513562] pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.521720] pci 0000:02:0c.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.529877] pci 0000:02:10.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.538035] pci 0000:02:1f.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.546502] pci 0000:03:00.0: [1095:3132] type 00 class 0x018000
[    7.552696] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000007f 64bit]
[    7.559637] pci 0000:03:00.0: reg 0x18: [mem 0x00000000-0x00003fff 64bit]
[    7.566562] pci 0000:03:00.0: reg 0x20: [io  0x0000-0x007f]
[    7.572276] pci 0000:03:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    7.579263] pci 0000:03:00.0: supports D1 D2
[    7.584131] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    7.595613] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    7.603920] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    7.612230] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    7.620534] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    7.628842] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    7.635950] pci 0000:08:00.0: [11ab:4380] type 00 class 0x020000
[    7.642138] pci 0000:08:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    7.649063] pci 0000:08:00.0: reg 0x18: [io  0x0000-0x00ff]
[    7.654979] pci 0000:08:00.0: supports D1 D2
[    7.659341] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    7.668084] pci_bus 0000:08: busn_res: [bus 08-ff] end is updated to 08
[    7.674828] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 08
[    7.681569] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 08
[    7.688330] pci 0000:00:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    7.695330] pci 0000:00:00.0: BAR 0: assigned [mem 0x4000000000-0x4000003fff 64bit pref]
[    7.703581] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.709886] pci 0000:01:00.0: BAR 14: assigned [mem 0x50000000-0x501fffff]
[    7.716883] pci 0000:01:00.0: BAR 13: assigned [io  0x1000-0x2fff]
[    7.723190] pci 0000:02:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]
[    7.730187] pci 0000:02:1f.0: BAR 14: assigned [mem 0x50100000-0x501fffff]
[    7.737183] pci 0000:02:01.0: BAR 13: assigned [io  0x1000-0x1fff]
[    7.743477] pci 0000:02:1f.0: BAR 13: assigned [io  0x2000-0x2fff]
[    7.749786] pci 0000:03:00.0: BAR 6: assigned [mem 0x50000000-0x5007ffff pref]
[    7.757139] pci 0000:03:00.0: BAR 2: assigned [mem 0x50080000-0x50083fff 64bit]
[    7.764614] pci 0000:03:00.0: BAR 0: assigned [mem 0x50084000-0x5008407f 64bit]
[    7.772078] pci 0000:03:00.0: BAR 4: assigned [io  0x1000-0x107f]
[    7.778296] pci 0000:02:01.0: PCI bridge to [bus 03]
[    7.783364] pci 0000:02:01.0:   bridge window [io  0x1000-0x1fff]
[    7.789580] pci 0000:02:01.0:   bridge window [mem 0x50000000-0x500fffff]
[    7.796509] pci 0000:02:02.0: PCI bridge to [bus 04]
[    7.801605] pci 0000:02:03.0: PCI bridge to [bus 05]
[    7.806701] pci 0000:02:0c.0: PCI bridge to [bus 06]
[    7.811797] pci 0000:02:10.0: PCI bridge to [bus 07]
[    7.816902] pci 0000:08:00.0: BAR 0: assigned [mem 0x50100000-0x50103fff 64bit]
[    7.824363] pci 0000:08:00.0: BAR 2: assigned [io  0x2000-0x20ff]
[    7.830578] pci 0000:02:1f.0: PCI bridge to [bus 08]
[    7.835644] pci 0000:02:1f.0:   bridge window [io  0x2000-0x2fff]
[    7.841859] pci 0000:02:1f.0:   bridge window [mem 0x50100000-0x501fffff]
[    7.848787] pci 0000:01:00.0: PCI bridge to [bus 02-08]
[    7.854116] pci 0000:01:00.0:   bridge window [io  0x1000-0x2fff]
[    7.860331] pci 0000:01:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    7.867259] pci 0000:00:00.0: PCI bridge to [bus 01-08]
[    7.872593] pci 0000:00:00.0:   bridge window [io  0x1000-0x2fff]
[    7.878802] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x501fffff]
[    7.886081] pcieport 0000:00:00.0: enabling device (0000 -> 0003)
[    7.900350] pcieport 0000:00:00.0: PME: Signaling with IRQ 44
[    7.907274] pcieport 0000:00:00.0: AER: enabled with IRQ 44
[    7.913552] pcieport 0000:01:00.0: enabling device (0000 -> 0003)
[    7.920030] pcieport 0000:02:01.0: enabling device (0000 -> 0003)
[    7.930863] pcieport 0000:02:1f.0: enabling device (0000 -> 0003)
[    7.940840] IPMI message handler: version 39.2
[    7.945556] ipmi device interface
[    7.949078] ipmi_si: IPMI System Interface driver
[    7.954515] ipmi_si: Unable to find any System Interface(s)
[    7.961434] EINJ: ACPI disabled.
[    7.974192] dma-pl330 7ff00000.dma: WARN: Device release is not defined so it is not safe to unbind this driver while in use
[    7.986948] dma-pl330 7ff00000.dma: Loaded driver for PL330 DMAC-341330
[    7.993684] dma-pl330 7ff00000.dma: 	DBUFF-1024x16bytes Num_Chans-8 Num_Peri-8 Num_Events-8
[    8.018275] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.029986] SuperH (H)SCI(F) driver initialized
[    8.035328] msm_serial: driver initialized
[    8.043194] arm-smmu 7fb10000.iommu: probing hardware configuration...
[    8.049858] arm-smmu 7fb10000.iommu: SMMUv1 with:
[    8.054660] arm-smmu 7fb10000.iommu: 	stage 2 translation
[    8.060164] arm-smmu 7fb10000.iommu: 	non-coherent table walk
[    8.066016] arm-smmu 7fb10000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    8.073545] arm-smmu 7fb10000.iommu: 	stream matching with 2 register groups
[    8.080722] arm-smmu 7fb10000.iommu: 	1 context banks (1 stage-2 only)
[    8.087371] arm-smmu 7fb10000.iommu: 	Supported page sizes: 0x60211000
[    8.094016] arm-smmu 7fb10000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.101582] arm-smmu 7fb20000.iommu: probing hardware configuration...
[    8.108298] arm-smmu 7fb20000.iommu: SMMUv1 with:
[    8.113100] arm-smmu 7fb20000.iommu: 	stage 2 translation
[    8.118604] arm-smmu 7fb20000.iommu: 	non-coherent table walk
[    8.124456] arm-smmu 7fb20000.iommu: 	(IDR0.CTTW overridden by FW configuration)
[    8.131985] arm-smmu 7fb20000.iommu: 	stream matching with 2 register groups
[    8.139162] arm-smmu 7fb20000.iommu: 	1 context banks (1 stage-2 only)
[    8.145821] arm-smmu 7fb20000.iommu: 	Supported page sizes: 0x60211000
[    8.152466] arm-smmu 7fb20000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.159610] arm-smmu 7fb30000.iommu: probing hardware configuration...
[    8.166260] arm-smmu 7fb30000.iommu: SMMUv1 with:
[    8.171060] arm-smmu 7fb30000.iommu: 	stage 2 translation
[    8.176562] arm-smmu 7fb30000.iommu: 	coherent table walk
[    8.182068] arm-smmu 7fb30000.iommu: 	stream matching with 2 register groups
[    8.189242] arm-smmu 7fb30000.iommu: 	1 context banks (1 stage-2 only)
[    8.195967] arm-smmu 7fb30000.iommu: 	Supported page sizes: 0x60211000
[    8.202613] arm-smmu 7fb30000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    8.347541] tda998x 0-0070: found TDA19988
[    8.476376] tda998x 0-0071: found TDA19988
[    8.547034] loop: module loaded
[    8.673238] mpt3sas version 33.100.00.00 loaded
[    8.682167] sata_sil24 0000:03:00.0: version 1.1
[    8.686921] sata_sil24 0000:03:00.0: enabling device (0000 -> 0003)
[    8.696899] scsi host0: sata_sil24
[    8.701952] scsi host1: sata_sil24
[    8.705964] ata1: SATA max UDMA/100 host m128@0x50084000 port 0x50080000 irq 51
[    8.713412] ata2: SATA max UDMA/100 host m128@0x50084000 port 0x50082000 irq 51
[    8.728534] libphy: Fixed MDIO Bus: probed
[    8.734961] tun: Universal TUN/TAP device driver, 1.6
[    8.741517] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.713.36-0 (2014/02/10)
[    8.751549] thunder_xcv, ver 1.0
[    8.755013] thunder_bgx, ver 1.0
[    8.758439] nicpf, ver 1.0
[    8.762092] hclge is initializing
[    8.765875] hns3: Hisilicon Ethernet Network Driver for Hip08 Family - version
[    8.773260] hns3: Copyright (c) 2017 Huawei Corporation.
[    8.778842] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    8.784782] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    8.790947] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
[    8.798024] igb: Copyright (c) 2007-2014 Intel Corporation.
[    8.803824] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
[    8.811780] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    8.818521] sky2: driver version 1.30
[    8.822596] sky2 0000:08:00.0: enabling device (0000 -> 0003)
[    8.828564] sky2 0000:08:00.0: Yukon-2 UL 2 chip revision 0
[    8.834357] sky2 0000:08:00.0 (unnamed net_device) (uninitialized): Invalid MAC address, defaulting to random
[    8.846043] sky2 0000:08:00.0 eth0: addr fe:9a:bd:e5:a7:ff
[    8.886584] libphy: smsc911x-mdio: probed
[    8.901994] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
[    8.909637] usbcore: registered new interface driver pegasus
[    8.915469] usbcore: registered new interface driver rtl8150
[    8.921330] usbcore: registered new interface driver r8152
[    8.926986] usbcore: registered new interface driver lan78xx
[    8.932837] usbcore: registered new interface driver asix
[    8.938418] usbcore: registered new interface driver ax88179_178a
[    8.944688] usbcore: registered new interface driver cdc_ether
[    8.950686] usbcore: registered new interface driver dm9601
[    8.956448] usbcore: registered new interface driver CoreChips
[    8.962492] usbcore: registered new interface driver smsc75xx
[    8.968474] usbcore: registered new interface driver smsc95xx
[    8.974386] usbcore: registered new interface driver net1080
[    8.980208] usbcore: registered new interface driver plusb
[    8.985862] usbcore: registered new interface driver cdc_subset
[    8.991964] usbcore: registered new interface driver zaurus
[    8.997710] usbcore: registered new interface driver MOSCHIP usb-ethernet driver
[    9.005326] usbcore: registered new interface driver cdc_ncm
[    9.011485] VFIO - User Level meta-driver version: 0.3
[    9.020377] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.027057] ehci-pci: EHCI PCI platform driver
[    9.031695] ehci-platform: EHCI generic platform driver
[    9.037597] ehci-platform 7ffc0000.ehci: Adding to iommu group 0
[    9.044283] ehci-platform 7ffc0000.ehci: EHCI Host Controller
[    9.050291] ehci-platform 7ffc0000.ehci: new USB bus registered, assigned bus number 1
[    9.058744] ehci-platform 7ffc0000.ehci: irq 34, io mem 0x7ffc0000
[    9.079967] ehci-platform 7ffc0000.ehci: USB 2.0 started, EHCI 1.00
[    9.088797] hub 1-0:1.0: USB hub found
[    9.092798] hub 1-0:1.0: 1 port detected
[    9.098135] ehci-orion: EHCI orion driver
[    9.102462] ehci-exynos: EHCI Exynos driver
[    9.106916] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    9.113238] ohci-pci: OHCI PCI platform driver
[    9.117881] ohci-platform: OHCI generic platform driver
[    9.123495] ohci-platform 7ffb0000.ohci: Adding to iommu group 0
[    9.129894] ohci-platform 7ffb0000.ohci: Generic Platform OHCI controller
[    9.136861] ohci-platform 7ffb0000.ohci: new USB bus registered, assigned bus number 2
[    9.145189] ohci-platform 7ffb0000.ohci: irq 33, io mem 0x7ffb0000
[    9.230048] hub 2-0:1.0: USB hub found
[    9.233993] hub 2-0:1.0: 1 port detected
[    9.239005] ohci-exynos: OHCI Exynos driver
[    9.244235] usbcore: registered new interface driver usb-storage
[    9.259192] rtc-pl031 1c170000.rtc: registered as rtc0
[    9.266003] i2c /dev entries driver
[    9.275028] usbcore: registered new interface driver uvcvideo
[    9.280884] USB Video Class driver (1.1.1)
[    9.285065] gspca_main: v2.14.0 registered
[    9.296038] sp805-wdt 1c0f0000.wdt: registration successful
[    9.304583] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    9.313212] Bluetooth: HCI UART driver ver 2.3
[    9.317746] Bluetooth: HCI UART protocol H4 registered
[    9.323026] Bluetooth: HCI UART protocol LL registered
[    9.328441] Bluetooth: HCI UART protocol Broadcom registered
[    9.334327] usbcore: registered new interface driver btusb
[    9.342601] mmci-pl18x 1c050000.mmci: mmc0: PL180 manf 41 rev0 at 0x1c050000 irq 9,0 (pio)
[    9.377097] sdhci: Secure Digital Host Controller Interface driver
[    9.383545] sdhci: Copyright(c) Pierre Ossman
[    9.388697] Synopsys Designware Multimedia Card Interface Driver
[    9.396519] sdhci-pltfm: SDHCI platform and OF driver helper
[    9.405237] leds-syscon 1c010000.apbregs:led0: registered LED vexpress:0
[    9.412494] leds-syscon 1c010000.apbregs:led1: registered LED vexpress:1
[    9.419731] leds-syscon 1c010000.apbregs:led2: registered LED vexpress:2
[    9.426949] leds-syscon 1c010000.apbregs:led3: registered LED vexpress:3
[    9.432038] usb 1-1: new high-speed USB device number 2 using ehci-platform
[    9.434150] leds-syscon 1c010000.apbregs:led4: registered LED vexpress:4
[    9.448228] leds-syscon 1c010000.apbregs:led5: registered LED vexpress:5
[    9.455450] leds-syscon 1c010000.apbregs:led6: registered LED vexpress:6
[    9.462677] leds-syscon 1c010000.apbregs:led7: registered LED vexpress:7
[    9.470608] ledtrig-cpu: registered to indicate activity on CPUs
[    9.471854] hub 1-1:1.0: USB hub found
[    9.480403] usbcore: registered new interface driver usbhid
[    9.481137] hub 1-1:1.0: 4 ports detected
[    9.486375] usbhid: USB HID core driver
[    9.487558] mhu 2b1f0000.mhu: ARM MHU Mailbox registered
[    9.513690] drop_monitor: Initializing network drop monitor service
[    9.520317] random: fast init done
[    9.524235] NET: Registered protocol family 10
[    9.531342] Segment Routing with IPv6
[    9.535733] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    9.542881] NET: Registered protocol family 17
[    9.547631] Bridge firewalling registered
[    9.551728] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    9.557760] Bluetooth: HIDP socket layer initialized
[    9.562911] 8021q: 802.1Q VLAN Support v1.8
[    9.567556] 9pnet: Installing 9P2000 support
[    9.572093] Key type dns_resolver registered
[    9.577890] registered taskstats version 1
[    9.582110] Loading compiled-in X.509 certificates
[    9.590285] Btrfs loaded, crc32c=crc32c-generic
[    9.606480] scpi_protocol scpi: SCP Protocol 1.2 Firmware 1.21.0 version
[    9.667669] arm-smmu 2b600000.iommu: probing hardware configuration...
[    9.674460] arm-smmu 2b600000.iommu: SMMUv1 with:
[    9.679337] arm-smmu 2b600000.iommu: 	stage 2 translation
[    9.684895] arm-smmu 2b600000.iommu: 	coherent table walk
[    9.690397] arm-smmu 2b600000.iommu: 	stream matching with 2 register groups
[    9.697574] arm-smmu 2b600000.iommu: 	1 context banks (1 stage-2 only)
[    9.704214] arm-smmu 2b600000.iommu: 	Supported page sizes: 0x60211000
[    9.710849] arm-smmu 2b600000.iommu: 	Stage-2: 40-bit IPA -> 40-bit PA
[    9.720694] input: smb@8000000:motherboard:gpio-keys as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:gpio-keys/input/input1
[    9.737183] rtc-pl031 1c170000.rtc: setting system clock to 2020-03-25T14:11:59 UTC (1585145519)
[   10.060137] usb 1-1.1: new high-speed USB device number 3 using ehci-platform
[   10.105383] usb-storage 1-1.1:1.0: USB Mass Storage device detected
[   10.119740] scsi host2: usb-storage 1-1.1:1.0
[   10.280188] atkbd serio0: keyboard reset failed on 1c060000.kmi
[   10.780087] ata1: SATA link down (SStatus 0 SControl 0)
[   11.150232] scsi 2:0:0:0: Direct-Access     TOSHIBA  TransMemory      PMAP PQ: 0 ANSI: 6
[   11.163134] sd 2:0:0:0: [sda] 30253056 512-byte logical blocks: (15.5 GB/14.4 GiB)
[   11.172288] sd 2:0:0:0: [sda] Write Protect is off
[   11.177604] sd 2:0:0:0: [sda] Mode Sense: 45 00 00 00
[   11.184331] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   11.264921]  sda: sda1 sda2
[   11.293352] sd 2:0:0:0: [sda] Attached SCSI removable disk
[   11.528536] atkbd serio1: keyboard reset failed on 1c070000.kmi
[   12.836137] ata2: SATA link down (SStatus 0 SControl 0)
[   12.849154] sky2 0000:08:00.0 eth0: enabling interface
[   12.855704] Generic PHY 18000000.ethernet-ffffffff:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=18000000.ethernet-ffffffff:01, irq=POLL)
[   12.880247] smsc911x 18000000.ethernet eth1: SMSC911x/921x identified at 0xffff800018cb0000, IRQ: 8
[   14.928231] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   14.948102] Sending DHCP requests ., OK
[   15.068128] ALSA device list:
[   15.071357]   No soundcards found.
[   15.076585] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   15.085596] uart-pl011 7ff80000.uart: no DMA platform data
[   15.091359] platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
[   15.120243] Freeing unused kernel memory: 14656K
[   15.128168] Run /init as init process
[   15.131870]   with arguments:
[   15.134909]     /init
[   15.137239]     ttyAMA0,115200n8
[   15.140526]     verbose
[   15.142998]     nfsrootdebug
[   15.145933]   with environment:
[   15.149131]     HOME=/
[   15.151515]     TERM=linux
[   15.154273]     user_debug=31
[   15.280504] Adding 2543608k swap on /dev/sda2.  Priority:-2 extents:1 across:2543608k 
[   18.132184] input: PS/2 Generic Mouse as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c060000.kmi/serio0/input/input3
[   18.256896] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[   19.369253] random: dd: uninitialized urandom read (512 bytes read)
[   19.503090] random: ssh-keygen: uninitialized urandom read (32 bytes read)
[   19.533868] random: sshd: uninitialized urandom read (32 bytes read)
[   19.614518] sky2 0000:08:00.0 eth0: enabling interface
[   24.632590] input: PS/2 Generic Mouse as /devices/platform/smb@8000000/smb@8000000:motherboard/smb@8000000:motherboard:iofpga@3,00000000/1c070000.kmi/serio1/input/input4
[   24.756753] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[   77.066210] cfg80211: failed to load regulatory.db
[  109.484923] PM: hibernation: hibernation entry
[  109.505798] Filesystems sync: 0.003 seconds
[  109.510720] Freezing user space processes ... (elapsed 0.004 seconds) done.
[  109.522347] OOM killer disabled.
[  109.535034] PM: hibernation: Preallocating image memory
[  110.858314] PM: hibernation: Allocated 96587 pages for snapshot
[  110.864358] PM: hibernation: Allocated 386348 kbytes in 1.31 seconds (294.92 MB/s)
[  110.872058] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  110.883798] printk: Suspending console(s) (use no_console_suspend to debug)
[  110.894359] ohci-platform 7ffb0000.ohci: ohci_platform_suspend : ret=0
[  110.908778] usbcore:hub_suspend: hub 1-1:1.0: hub_suspend
[  110.911448] usbcore:hub_suspend: hub 1-0:1.0: hub_suspend
[  110.911588] usbcore:hcd_bus_suspend: usb usb1: bus suspend, wakeup 0
[  110.942466] Disabling non-boot CPUs ...
[  110.945799] CPU1: shutdown
[  110.945826] psci: CPU1 killed (polled 0 ms)
[  110.951729] CPU2: shutdown
[  110.952840] psci: CPU2 killed (polled 4 ms)
[  110.959068] CPU3: shutdown
[  110.959097] psci: CPU3 killed (polled 0 ms)
[  110.964518] CPU4: shutdown
[  110.964547] psci: CPU4 killed (polled 0 ms)
[  110.969407] CPU5: shutdown
[  110.969434] psci: CPU5 killed (polled 0 ms)
[  110.971466] PM: hibernation: Creating image:
[  110.971466] PM: hibernation: Need to copy 95098 pages
[  110.971466] PM: hibernation: Image created (95098 pages copied)
[  110.972416] Enabling non-boot CPUs ...
[  110.986470] Detected PIPT I-cache on CPU1
[  110.986534] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[  110.989804] CPU1 is up
[  111.003759] Detected PIPT I-cache on CPU2
[  111.003798] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[  111.005181] CPU2 is up
[  111.018850] Detected VIPT I-cache on CPU3
[  111.018945] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[  111.022529] CPU3 is up
[  111.036187] Detected VIPT I-cache on CPU4
[  111.036263] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[  111.040050] CPU4 is up
[  111.053709] Detected VIPT I-cache on CPU5
[  111.053784] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[  111.058844] CPU5 is up
[  111.080887] usbcore:hcd_bus_resume: usb usb1: usb resume
[  111.084174] ohci-platform 7ffb0000.ohci: ohci_platform_resume
[  111.111950] usbcore:hcd_bus_resume: usb usb2: usb resume
[  111.138939] usbcore:hub_resume: hub 1-0:1.0: hub_resume
[  111.139333] usbcore:hub_activate: usb usb1-port1: status 0503 change 0000
[  111.139718] usbcore:hub_resume: hub 1-1:1.0: hub_resume
[  111.140090] usbcore:hub_activate: usb 1-1-port1: status 0503 change 0000
[  111.187608] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  111.187893] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[  111.187979] CPU: 3 PID: 369 Comm: kworker/u12:6 Not tainted 5.6.0-rc6-00002-gdfd1731f9a3e-dirty #545
[  111.187994] Hardware name: ARM Juno development board (r2) (DT)
[  111.188022] Workqueue: events_unbound async_run_entry_fn
[  111.188041] Call trace:
[  111.188060]  dump_backtrace+0x0/0x1d8
[  111.188077]  show_stack+0x24/0x30
[  111.188096]  dump_stack+0xe8/0x150
[  111.188116]  __pm_runtime_set_status+0x1b8/0x2e8
[  111.188135]  usb_resume+0x64/0x88
[  111.188152]  usb_dev_thaw+0x24/0x30
[  111.188170]  dpm_run_callback+0x90/0x348
[  111.188188]  device_resume+0xe0/0x1c8
[  111.188205]  async_resume+0x30/0x60
[  111.188223]  async_run_entry_fn+0x48/0x1a8
[  111.188242]  process_one_work+0x2a4/0x748
[  111.188259]  worker_thread+0x48/0x498
[  111.188276]  kthread+0x13c/0x140
[  111.188294]  ret_from_fork+0x10/0x18
[  111.473320] PM: Cannot find swap device, try swapon -a
[  111.478559] PM: Cannot get swap writer
[  111.740186] OOM killer enabled.
[  111.743377] Restarting tasks ... 
[  111.744458] usbcore:hub_event: hub 1-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  111.744660] usbcore:hub_event: hub 1-1:1.0: state 7 ports 4 chg 0000 evt 0000
[  111.744971] done.
[  111.748289] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  111.773192] usbcore:hub_resume: hub 2-0:1.0: hub_resume
[  111.773249] PM: hibernation: hibernation exit
[  111.779649] ------------[ cut here ]------------
[  111.788382] URB (____ptrval____) submitted while active
[  111.796646] WARNING: CPU: 3 PID: 365 at drivers/usb/core/urb.c:363 usb_submit_urb+0x3d8/0x590
[  111.805417] Modules linked in:
[  111.808584] CPU: 3 PID: 365 Comm: kworker/3:2 Not tainted 5.6.0-rc6-00002-gdfd1731f9a3e-dirty #545
[  111.817796] Hardware name: ARM Juno development board (r2) (DT)
[  111.823896] Workqueue: usb_hub_wq hub_event
[  111.828217] pstate: 60000005 (nZCv daif -PAN -UAO)
[  111.833156] pc : usb_submit_urb+0x3d8/0x590
[  111.837471] lr : usb_submit_urb+0x3d8/0x590
[  111.841783] sp : ffff800018de38b0
[  111.845205] x29: ffff800018de38b0 x28: 0000000000000003 
[  111.850682] x27: ffff000970530b20 x26: ffff8000133fd000 
[  111.856159] x25: ffff8000133fd000 x24: ffff800018de3b38 
[  111.861635] x23: 0000000000000004 x22: 0000000000000c00 
[  111.867112] x21: 0000000000000000 x20: 00000000fffffff0 
[  111.872589] x19: ffff0009704e7a00 x18: ffffffffffffffff 
[  111.878065] x17: 00000000a7c8f4bc x16: 000000002af33de8 
[  111.883542] x15: ffff8000133fda88 x14: 0720072007200720 
[  111.889019] x13: 0720072007200720 x12: 0720072007200720 
[  111.894496] x11: 0000000000000000 x10: 00000000a5286134 
[  111.899973] x9 : 0000000000000002 x8 : ffff000970c837a0 
[  111.905449] x7 : 0000000000000000 x6 : ffff800018de3570 
[  111.910926] x5 : 0000000000000001 x4 : 0000000000000003 
[  111.916401] x3 : 0000000000000000 x2 : ffff800013427118 
[  111.921879] x1 : 9d4e965b4b7d7c00 x0 : 0000000000000000 
[  111.927356] Call trace:
[  111.929892]  usb_submit_urb+0x3d8/0x590
[  111.933852]  hub_activate+0x108/0x7f0
[  111.937633]  hub_resume+0xac/0x148
[  111.941149]  usb_resume_interface.isra.10+0x60/0x138
[  111.946265]  usb_resume_both+0xe4/0x140
[  111.950225]  usb_runtime_resume+0x24/0x30
[  111.954365]  __rpm_callback+0xdc/0x138
[  111.958236]  rpm_callback+0x34/0x98
[  111.961841]  rpm_resume+0x4a8/0x720
[  111.965445]  rpm_resume+0x50c/0x720
[  111.969049]  __pm_runtime_resume+0x4c/0xb8
[  111.973276]  usb_autopm_get_interface+0x28/0x60
[  111.977948]  hub_event+0x80/0x16d8
[  111.981466]  process_one_work+0x2a4/0x748
[  111.985604]  worker_thread+0x48/0x498
[  111.989387]  kthread+0x13c/0x140
[  111.992725]  ret_from_fork+0x10/0x18
[  111.996415] irq event stamp: 354
[  111.999756] hardirqs last  enabled at (353): [<ffff80001019ea1c>] console_unlock+0x504/0x5b8
[  112.008441] hardirqs last disabled at (354): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
[  112.017479] softirqs last  enabled at (350): [<ffff8000100818a4>] __do_softirq+0x4bc/0x568
[  112.025984] softirqs last disabled at (343): [<ffff8000101145a4>] irq_exit+0x144/0x150
[  112.034129] ---[ end trace dc96030b9cf6c8a3 ]---
[  112.039119] hub 2-0:1.0: activate --> -16
[  112.043367] usbcore:hub_event: hub 2-0:1.0: state 7 ports 1 chg 0000 evt 0000
[  112.050825] usbcore:hub_suspend: hub 2-0:1.0: hub_suspend
[  112.056596] usbcore:hcd_bus_suspend: usb usb2: bus auto-suspend, wakeup 1
[  113.131730] ata1: SATA link down (SStatus 0 SControl 0)
[  113.138068] ata2: SATA link down (SStatus 0 SControl 0)
[  117.651706] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[  124.239499] psmouse serio1: Failed to enable mouse on 1c070000.kmi

--qxu4bpb5wy3tv6mq--

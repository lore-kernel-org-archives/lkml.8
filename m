Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D736206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YACWvbKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgHTP2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTP2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:28:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D09C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:28:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t14so1960351wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/Zh4Eg91yUqYXp3ydoUYkJLgEppE5RYSskGf5S9JBw=;
        b=YACWvbKVMfcjaNep1cBwCPL4v3dSWmF4waWi6xRrHqj6cx0VQRrVgOzbXJsh1ZrzOo
         R0oApLLlxUzRJelqi4UADoxoFofZQCdxnFs16kmn4M8PI3hKpUihGx9sVR2DP5Lc9czs
         aqB1X5MDofkOU0iUgiHg1sQHcTrnQRw0gFBnCHklpQ7hnRRcccDIDNao8D+0QeRSyIWs
         vFj1kX8I2gW4Psjjwa7+crh2crU5qovwXPUJHYa+Pmyy7ZJiMGQdRBJFkRL1s+So01FZ
         yEx7kP3UcVUf3hS+3SFJONmz7b8hLrSRW/RM7FoCh3iO8GJXClvmvMmcqreEOcdWtUfp
         bTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/Zh4Eg91yUqYXp3ydoUYkJLgEppE5RYSskGf5S9JBw=;
        b=ATLmEPyEancLMkLRDtSLJl2CMPrOFQKpluMxR4SENTeur6EuKzRyIxCGoXMpnziOFr
         1Ajx4sjZrkbO2orXbsbUvVJOX1wdGG3UzaFcMLKSvtg0Tta57aXzGM4tpCU7r761SxaF
         hseQAd/Kw2KPwQTSRFRbdlkoVL9MSgTMErwIBOicVAC9GtcF5JJbr2L6YplvMRhKvHdf
         RTZyu5o5Cx8GPKvh58vR/9OF81dXgeOvfGwzSq5fbIX7ZDaymf78ufLK9Q6h1FdLNS4t
         QFtDgL7PfqAyNdI39olHOvoZwHC9Z2M4Wq59mkKw0sSmgCZ8myUHXvN6z12BnazVlmXY
         S6lQ==
X-Gm-Message-State: AOAM531INdpIbx07ItCJpLPyaq/MaCclWAtVhlCRKL9lKzOKVu+SUVsz
        Y2lm8ix7ctnIJMOWF5vPFGx6uw==
X-Google-Smtp-Source: ABdhPJyoZQt1SG0sp6hzU3qTBy/4DCGregU6mmbYRUS51SE8fia1zz3u54tWzZKCkDQn5MjXW1P1sw==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr4147620wmi.165.1597937311751;
        Thu, 20 Aug 2020 08:28:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g7sm4892454wrv.82.2020.08.20.08.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:28:30 -0700 (PDT)
Date:   Thu, 20 Aug 2020 16:28:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820152828.tvluka3lvmzof5xt@holly.lan>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820104905.294802764@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:38:36PM +0200, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/traps.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
>  		goto out;
>  	}
>  
> -	if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
> -		/*
> -		 * Historical junk that used to handle SYSENTER single-stepping.
> -		 * This should be unreachable now.  If we survive for a while
> -		 * without anyone hitting this warning, we'll turn this into
> -		 * an oops.
> -		 */
> -		tsk->thread.debugreg6 &= ~DR_STEP;
> -		set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> -		regs->flags &= ~X86_EFLAGS_TF;
> -	}
> -
>  	si_code = get_si_code(tsk->thread.debugreg6);
>  	if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
>  		send_sigtrap(regs, 0, si_code);
> @@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
>  	if (kprobe_debug_handler(regs))
>  		goto out;
>  
> +	if (WARN_ON_ONCE(dr6 & DR_STEP)) {
> +		/*
> +		 * Historical junk that used to handle SYSENTER single-stepping.
> +		 * This should be unreachable now.  If we survive for a while
> +		 * without anyone hitting this warning, we'll turn this into
> +		 * an oops.
> +		 */
> +		dr6 &= ~DR_STEP;
> +		set_thread_flag(TIF_SINGLESTEP);
> +		regs->flags &= ~X86_EFLAGS_TF;
> +	}
> +

I was hoping just to share a Tested-by: on the patchset but
unfortunately it wasn't to be. After a quick bisect this patch comes
back as causing kdb single stepping to fail.

I picked it up with the kgdbtest suite but the output from that can be a
bit difficult to read so I have shown included a a simpler semi-manual
reproduction below which is hopefully easier on the eyes. I believe all
the "action" is in the last fifty lines but I have included the
boilerplate at the top to show how the kernel is configured and to
illustrate what the machine is running when we try to step.

Specifically I've entered the kdb in pretty much the simplest way
possible: a direct call to kgdb_breakpoint() from a task context. I
generate a backtrace to illustrate this, just to give you a better
understanding of what might be happening) and then ran the single step.

To be clear, neither the "entering in the simplest way possible", nor
printing the backtrace is required to reproduce. Both are simply to
make the logs below as clear as possible.


Daniel.


+ export ARCH=x86
+ ARCH=x86
+ unset CROSS_COMPILE
+ gcc --version
gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

+ '[' 2 -eq 0 ']'
+ make -C ../kgdbtest interact K=nowait
make: Entering directory '/home/drt/Development/Kernel/kgdbtest'
tests/interact.py nowait
+ make -C .. O=$PWD x86_64_defconfig
make[1]: Entering directory '/home/drt/Development/Kernel/linux-kgdb'
make[2]: Entering directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
  GEN     Makefile
#
# configuration written to .config
#
make[2]: Leaving directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
make[1]: Leaving directory '/home/drt/Development/Kernel/linux-kgdb'
+ ../scripts/config --enable RUNTIME_TESTING_MENU
+ ../scripts/config --enable DEBUG_INFO --enable DEBUG_FS --enable KALLSYMS_ALL --enable MAGIC_SYSRQ --enable KGDB --enable KGDB_TESTS --enable KGDB_KDB --enable KDB_KEYBOARD --enable LKDTM
+ ../scripts/config --enable PROVE_LOCKING --enable DEBUG_ATOMIC_SLEEP
+ make olddefconfig
make[1]: Entering directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
  GEN     Makefile
scripts/kconfig/conf  --olddefconfig Kconfig
#
# configuration written to .config
#
make[1]: Leaving directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
+ make -s -j `nproc` all
make[1]: Entering directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
make[1]: Leaving directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
+ make -s -j `nproc` modules_install INSTALL_MOD_PATH=$PWD/mod-rootfs INSTALL_MOD_STRIP=1
make[1]: Entering directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
make[1]: Leaving directory '/home/drt/Development/Kernel/linux-kgdb/build-x86'
+ unxz -c $KGDBTEST_DIR/buildroot/x86/images/rootfs.cpio.xz > rootfs.cpio
+ (cd mod-rootfs; find . | cpio -H newc -AoF ../rootfs.cpio)
3341 blocks
+ gzip -f rootfs.cpio
+| qemu-system-x86_64 -enable-kvm -m 1G -smp 2 -kernel arch/x86/boot/bzImage -nographic -monitor none -chardev stdio,id=mon,mux=on,signal=off -serial chardev:mon -initrd rootfs.cpio.gz -append " console=ttyS0,115200 kgdboc=ttyS0"
SeaBIOS (version ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc
31)


iPXE (http://ipxe.org) 00:03.0 C980 PCI2.10 PnP PMM+3FF922D0+3FED22D0 C980



Booting from ROM..
[    0.000000] Linux version 5.9.0-rc1+ (drt@wychelm) (gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2), GNU ld version 2.32-31.fc31) #25 SMP Thu Aug 20 16:08:10 BST 2020
[    0.000000] Command line:  console=ttyS0,115200 kgdboc=ttyS0
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3194.058 MHz processor
[    0.000629] last_pfn = 0x3ffe0 max_arch_pfn = 0x400000000
[    0.000679] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.002401] found SMP MP-table at [mem 0x000f5ca0-0x000f5caf]
[    0.002435] check: Scanning 1 areas for low memory corruption
[    0.002516] RAMDISK: [mem 0x3fe8c000-0x3ffdffff]
[    0.002526] ACPI: Early table checksum verification disabled
[    0.002530] ACPI: RSDP 0x00000000000F5A60 000014 (v00 BOCHS )
[    0.002533] ACPI: RSDT 0x000000003FFE15C9 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.002538] ACPI: FACP 0x000000003FFE149D 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.002542] ACPI: DSDT 0x000000003FFE0040 00145D (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.002545] ACPI: FACS 0x000000003FFE0000 000040
[    0.002547] ACPI: APIC 0x000000003FFE1511 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.002550] ACPI: HPET 0x000000003FFE1591 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.002745] No NUMA configuration found
[    0.002746] Faking a node at [mem 0x0000000000000000-0x000000003ffdffff]
[    0.002749] NODE_DATA(0) allocated [mem 0x3fe88000-0x3fe8bfff]
[    0.002761] Zone ranges:
[    0.002762]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002764]   DMA32    [mem 0x0000000001000000-0x000000003ffdffff]
[    0.002765]   Normal   empty
[    0.002767] Movable zone start for each node
[    0.002768] Early memory node ranges
[    0.002769]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.002770]   node   0: [mem 0x0000000000100000-0x000000003ffdffff]
[    0.003221] Zeroed struct page in unavailable ranges: 130 pages
[    0.003221] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ffdffff]
[    0.005544] ACPI: PM-Timer IO Port: 0x608
[    0.005553] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.005589] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.005593] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.005595] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.005597] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.005598] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.005600] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.005605] Using ACPI (MADT) for SMP configuration information
[    0.005607] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.005614] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.005623] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.005625] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.005626] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.005627] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.005630] [mem 0x40000000-0xfeffbfff] available for PCI devices
[    0.005633] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.009623] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
[    0.009943] percpu: Embedded 53 pages/cpu s179664 r8192 d29232 u1048576
[    0.009967] Built 1 zonelists, mobility grouping on.  Total pages: 257897
[    0.009968] Policy zone: DMA32
[    0.009974] Kernel command line:  console=ttyS0,115200 kgdboc=ttyS0
[    0.010228] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.010240] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.010255] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.012242] Memory: 982836K/1048056K available (16388K kernel code, 1826K rwdata, 4704K rodata, 1196K init, 12744K bss, 64960K reserved, 0K cma-reserved)
[    0.012293] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.012647] Running RCU self tests
[    0.012653] rcu: Hierarchical RCU implementation.
[    0.012654] rcu:     RCU event tracing is enabled.
[    0.012655] rcu:     RCU lockdep checking is enabled.
[    0.012657] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.012659] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.012660] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.012848] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    0.013096] random: get_random_bytes called from start_kernel+0x36d/0x547 with crng_init=0
[    0.017858] Console: colour VGA+ 80x25
[    0.069187] printk: console [ttyS0] enabled
[    0.069614] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.070400] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.070827] ... MAX_LOCK_DEPTH:          48
[    0.071268] ... MAX_LOCKDEP_KEYS:        8192
[    0.071719] ... CLASSHASH_SIZE:          4096
[    0.072177] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.072636] ... MAX_LOCKDEP_CHAINS:      65536
[    0.073097] ... CHAINHASH_SIZE:          32768
[    0.073563]  memory used by lock dependency info: 6301 kB
[    0.074122]  memory used for stack traces: 4224 kB
[    0.074631]  per task-struct memory footprint: 1920 bytes
[    0.075232] ACPI: Core revision 20200717
[    0.075780] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.076838] APIC: Switch to symmetric I/O mode setup
[    0.078294] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.083795] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.084430] Calibrating delay loop (skipped), value calculated using timer frequency.. 6388.11 BogoMIPS (lpj=3194058)
[    0.085426] pid_max: default: 32768 minimum: 301
[    0.086448] LSM: Security Framework initializing
[    0.086952] SELinux:  Initializing.
[    0.087466] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.088235] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.089708] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.090274] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.090434] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.091426] Spectre V2 : Mitigation: Full AMD retpoline
[    0.091958] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.092425] Speculative Store Bypass: Vulnerable
[    0.093592] Freeing SMP alternatives memory: 40K
[    0.196626] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 0x6, model: 0x6, stepping: 0x3)
[    0.197641] Performance Events: AMD PMU driver.
[    0.198126] ... version:                0
[    0.198426] ... bit width:              48
[    0.198863] ... generic registers:      4
[    0.199272] ... value mask:             0000ffffffffffff
[    0.199426] ... max period:             00007fffffffffff
[    0.200426] ... fixed-purpose events:   0
[    0.200848] ... event mask:             000000000000000f
[    0.201509] rcu: Hierarchical SRCU implementation.
[    0.202170] smp: Bringing up secondary CPUs ...
[    0.202686] x86: Booting SMP configuration:
[    0.203437] .... node  #0, CPUs:      #1
[    0.066354] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.276494] smp: Brought up 1 node, 2 CPUs
[    0.276925] smpboot: Max logical packages: 2
[    0.277430] smpboot: Total of 2 processors activated (12776.16 BogoMIPS)
[    0.278730] devtmpfs: initialized
[    0.279661] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.280441] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    0.281684] PM: RTC time: 15:09:44, date: 2020-08-20
[    0.282689] NET: Registered protocol family 16
[    0.283629] audit: initializing netlink subsys (disabled)
[    0.284467] audit: type=2000 audit(1597936184.206:1): state=initialized audit_enabled=0 res=1
[    0.284637] thermal_sys: Registered thermal governor 'step_wise'
[    0.284638] thermal_sys: Registered thermal governor 'user_space'
[    0.286471] cpuidle: using governor menu
[    0.287497] ACPI: bus type PCI registered
[    0.288049] PCI: Using configuration type 1 for base access
[    0.293537] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.294580] cryptomgr_test (25) used greatest stack depth: 14928 bytes left
[    0.297591] ACPI: Added _OSI(Module Device)
[    0.298429] ACPI: Added _OSI(Processor Device)
[    0.298895] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.299426] ACPI: Added _OSI(Processor Aggregator Device)
[    0.300428] ACPI: Added _OSI(Linux-Dell-Video)
[    0.300904] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.301431] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.303164] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.304753] ACPI: Interpreter enabled
[    0.305163] ACPI: (supports S0 S3 S4 S5)
[    0.305438] ACPI: Using IOAPIC for interrupt routing
[    0.305970] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.306583] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.312375] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.312433] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.313472] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.314526] PCI host bridge to bus 0000:00
[    0.315428] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.316135] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.316427] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.317427] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
[    0.318427] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.319427] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.320033] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.320914] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.321897] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.324220] pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
[    0.325441] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.326186] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.326426] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.327426] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.328512] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.329413] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.329433] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.330700] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.332431] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.334430] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.337156] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.337714] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.339427] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[    0.340427] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[    0.343973] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[    0.346140] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.346540] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.347539] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.348461] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.349308] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.349751] iommu: Default domain type: Translated
[    0.350570] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.351098] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.351428] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.352015] vgaarb: loaded
[    0.352605] SCSI subsystem initialized
[    0.353064] ACPI: bus type USB registered
[    0.353470] usbcore: registered new interface driver usbfs
[    0.354065] usbcore: registered new interface driver hub
[    0.354455] usbcore: registered new device driver usb
[    0.355447] pps_core: LinuxPPS API ver. 1 registered
[    0.355981] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.356431] PTP clock support registered
[    0.357523] Advanced Linux Sound Architecture Driver Initialized.
[    0.358584] NetLabel: Initializing
[    0.358951] NetLabel:  domain hash size = 128
[    0.359411] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.359451] NetLabel:  unlabeled traffic allowed by default
[    0.360471] PCI: Using ACPI for IRQ routing
[    0.361006] hpet: 3 channels of 0 reserved for per-cpu timers
[    0.361433] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.362426] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.366483] clocksource: Switched to clocksource hpet
[    0.469185] VFS: Disk quotas dquot_6.6.0
[    0.469654] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.470462] pnp: PnP ACPI init
[    0.471325] pnp: PnP ACPI: found 6 devices
[    0.489459] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.490419] NET: Registered protocol family 2
[    0.491132] tcp_listen_portaddr_hash hash table entries: 512 (order: 3, 40960 bytes, linear)
[    0.492033] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.493072] TCP bind hash table entries: 8192 (order: 7, 589824 bytes, linear)
[    0.493956] TCP: Hash tables configured (established 8192 bind 8192)
[    0.494683] UDP hash table entries: 512 (order: 4, 81920 bytes, linear)
[    0.495408] UDP-Lite hash table entries: 512 (order: 4, 81920 bytes, linear)
[    0.496229] NET: Registered protocol family 1
[    0.497207] RPC: Registered named UNIX socket transport module.
[    0.497899] RPC: Registered udp transport module.
[    0.498402] RPC: Registered tcp transport module.
[    0.498942] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.499901] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.500604] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.501256] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.502009] pci_bus 0000:00: resource 7 [mem 0x40000000-0xfebfffff window]
[    0.502784] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    0.503610] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.504222] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.504874] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.505563] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.506469] PCI: CLS 0 bytes, default 64
[    0.507009] Unpacking initramfs...
[    0.534795] Freeing initrd memory: 1360K
[    0.536254] check: Scanning for low memory corruption every 60 seconds
[    0.537646] Initialise system trusted keyrings
[    0.538270] workingset: timestamp_bits=56 max_order=18 bucket_order=0
[    0.543016] NFS: Registering the id_resolver key type
[    0.543592] Key type id_resolver registered
[    0.544037] Key type id_legacy registered
[    0.553774] Key type asymmetric registered
[    0.553797] cryptomgr_test (54) used greatest stack depth: 14600 bytes left
[    0.554208] Asymmetric key parser 'x509' registered
[    0.556511] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.557284] io scheduler mq-deadline registered
[    0.557799] io scheduler kyber registered
[    0.558515] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.559587] ACPI: Power Button [PWRF]
[    0.560542] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.561318] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.563023] KGDB: Registered I/O driver kgdboc
[    0.564110] Non-volatile memory driver v1.3
[    0.564762] Linux agpgart interface v0.103
[    0.569874] loop: module loaded
[    0.570347] lkdtm: No crash points registered, enable through debugfs
[    0.572113] scsi host0: ata_piix
[    0.573219] scsi host1: ata_piix
[    0.574695] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc040 irq 14
[    0.576893] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc048 irq 15
[    0.579626] e100: Intel(R) PRO/100 Network Driver
[    0.580276] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.581047] e1000: Intel(R) PRO/1000 Network Driver
[    0.581709] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.643761] PCI Interrupt Link [LNKC] enabled at IRQ 11
[    0.735164] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.737740] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    0.865729] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.867493] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.870563] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.953721] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[    0.954419] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[    0.955365] e1000e: Intel(R) PRO/1000 Network Driver
[    0.955911] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.956558] sky2: driver version 1.30
[    0.957283] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.957985] ehci-pci: EHCI PCI platform driver
[    0.958489] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.959120] ohci-pci: OHCI PCI platform driver
[    0.959625] uhci_hcd: USB Universal Host Controller Interface driver
[    0.960342] usbcore: registered new interface driver usblp
[    0.960974] usbcore: registered new interface driver usb-storage
[    0.961666] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.963191] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.963786] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.965096] rtc_cmos 00:00: RTC can wake from S4
[    0.966484] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.966824] rtc_cmos 00:00: registered as rtc0
[    0.968772] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[    0.970818] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    0.972209] hid: raw HID events driver (C) Jiri Kosina
[    0.973057] usbcore: registered new interface driver usbhid
[    0.973698] usbhid: USB HID core driver
[    0.975474] Initializing XFRM netlink socket
[    0.976119] NET: Registered protocol family 10
[    0.977114] Segment Routing with IPv6
[    0.977776] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.978611] NET: Registered protocol family 17
[    0.979118] Key type dns_resolver registered
[    0.979974] IPI shorthand broadcast: enabled
[    0.980741] registered taskstats version 1
[    0.981183] Loading compiled-in X.509 certificates
[    0.982252] PM:   Magic number: 0:722:184
[    0.982803] printk: console [netcon0] enabled
[    0.983272] netconsole: network logging started
[    0.984082] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    0.987006] modprobe (66) used greatest stack depth: 14344 bytes left
[    0.988768] modprobe (67) used greatest stack depth: 14048 bytes left
[    0.991725] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    0.992682] Unstable clock detected, switching default tracing clock to "global"
[    0.992682] If you want to keep using the local clock, then add:
[    0.992682]   "trace_clock=local"
[    0.992682] on the kernel command line
[    0.995635] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    0.996887] cfg80211: failed to load regulatory.db
[    0.997708] ALSA device list:
[    0.998141]   No soundcards found.
[    0.999352] Freeing unused kernel image (initmem) memory: 1196K
[    1.002549] Write protecting the kernel read-only data: 24576k
[    1.004939] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    1.007136] Freeing unused kernel image (rodata/data gap) memory: 1440K
[    1.008050] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: [    1.041088] random: dd: uninitialized urandom read (512 bytes read)
OK
Starting network: [    1.047330] wait_iface (107) used greatest stack depth: 13536 bytes left
[    1.049598] ip (108) used greatest stack depth: 13064 bytes left
udhcpc: started, v1.31.1
udhcpc: sending discover
[    1.592964] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
[    3.118775] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    3.122246] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
udhcpc: sending discover
udhcpc: sending select for 10.0.2.15
udhcpc: lease of 10.0.2.15 obtained, lease time 86400
deleting routers
adding dns 10.0.2.3
OK
Starting dropbear sshd: [    4.153248] random: dropbear: uninitialized urandom read (32 bytes read)
OK

Welcome to Buildroot
buildroot login: root
# echo g > /proc/sysrq-trigger
[   20.621302] sysrq: DEBUG

Entering kdb (current=0xffff93f73cd9ad00, pid 143) on processor 1 due to NonMaskable Interrupt @ 0xffffffff93b53d4b
[1]kdb> bt
Stack traceback for pid 143
0xffff93f73cd9ad00      143        1  1    1   R  0xffff93f73cd9c080 *sh
CPU: 1 PID: 143 Comm: sh Not tainted 5.9.0-rc1+ #25
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
Call Trace:
 dump_stack+0x78/0xa0
 kdb_show_stack+0x79/0x90
 kdb_bt1+0xb3/0x120
 kdb_bt+0x325/0x390
 kdb_parse+0x439/0x700
 kdb_main_loop+0x4d0/0x950
 ? write_enabled_file_bool.cold+0x4c/0x7c
 kdb_stub+0x1c7/0x3d0
 kgdb_cpu_enter+0x3a5/0x770
 kgdb_handle_exception+0xb1/0x1b0
 __kgdb_notify+0x28/0x70
 kgdb_notify+0x1d/0x50
 notifier_call_chain+0x42/0x60
 __atomic_notifier_call_chain+0x66/0x100
 notify_die+0x5a/0xa0
 exc_int3+0xee/0x130
 asm_exc_int3+0x31/0x40
RIP: 0010:kgdb_breakpoint+0xb/0x20
Code: c7 78 2c f4 94 e8 de ad f8 ff eb c5 cc cc cc 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f0 ff 05 51 f1 8e 02 0f ae f8 cc <0f> ae f8 f0 ff 0d 43 f1 8e 02 c3 66 2e 0f 1f 84 00 00 00 00 00 e8
RSP: 0018:ffffa1e04028fe78 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff93f73ed17da0 RDI: 0000000000000067
RBP: 0000000000000067 R08: ffff93f73ed17da0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000080000 R12: 0000000000000000
R13: 0000000000000007 R14: ffffffff94c0ee20 R15: 0000000000000002
 ? kgdb_breakpoint+0xb/0x20
 __handle_sysrq.cold+0x51/0x130
 write_sysrq_trigger+0x3a/0x45
 proc_reg_write+0x4e/0x80
 vfs_write+0xe7/0x230
 ksys_write+0x63/0xe0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fe1f84235ed
Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 46 d3 ff ff 41 54 b8 02 00 00 00 49 89 f4 be 00 08 08 00 55
RSP: 002b:00007ffec6dd7478 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe1f8464d88 RCX: 00007fe1f84235ed
RDX: 0000000000000002 RSI: 00007fe1f8465f60 RDI: 0000000000000001
RBP: 00007fe1f8465f60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 00007fe1f8465f60 R15: 00007fe1f8465ce5
[1]kdb> ss
[   24.736726] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 0.000 msecs
[   24.736773] ------------[ cut here ]------------
[   24.736774] WARNING: CPU: 1 PID: 143 at arch/x86/kernel/traps.c:865 exc_debug+0xee/0x120
[   24.736775] Modules linked in:
[   24.736775] CPU: 1 PID: 143 Comm: sh Not tainted 5.9.0-rc1+ #25
[   24.736776] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[   24.736776] RIP: 0010:exc_debug+0xee/0x120
[   24.736777] Code: c2 73 1e e8 d4 59 40 ff 85 c0 75 b9 4c 89 e6 81 e6 0f b0 00 00 eb a4 31 c0 0f 23 f8 e9 64 ff ff ff e8 b6 59 40 ff 85 c0 75 9b <0f> 0b 4c 89 e6 81 e6 0f b0 00 00 65 48 8b 04 25 40 6f 01 00 f0 80
[   24.736777] RSP: 0018:fffffe000003ef30 EFLAGS: 00010046
[   24.736778] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 4000000000000002
[   24.736778] RDX: ffffffffff352a0e RSI: ffffffff94800b21 RDI: fffffe000003ef58
[   24.736779] RBP: fffffe000003ef58 R08: 0000000000000000 R09: 0000000000000000
[   24.736779] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffff4ff0
[   24.736779] R13: 00000000ffff4f01 R14: 0000000000000000 R15: 0000000000000000
[   24.736780] FS:  00007fe1f8464d88(0000) GS:ffff93f73ed00000(0000) knlGS:0000000000000000
[   24.736780] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.736780] CR2: 000000000045a843 CR3: 000000003ccd0000 CR4: 00000000000006e0
[   24.736780] Call Trace:
[   24.736781]  <#DB>
[   24.736781]  asm_exc_debug+0x19/0x30
[   24.736781] RIP: 0010:kgdb_breakpoint+0xe/0x20
[   24.736782] Code: f4 94 e8 de ad f8 ff eb c5 cc cc cc 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f0 ff 05 51 f1 8e 02 0f ae f8 cc 0f ae f8 <f0> ff 0d 43 f1 8e 02 c3 66 2e 0f 1f 84 00 00 00 00 00 e8 db ff ff
[   24.736782] RSP: 0018:ffffa1e04028fe78 EFLAGS: 00000302
[   24.736783] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
[   24.736783] RDX: 0000000000000000 RSI: ffff93f73ed17da0 RDI: 0000000000000067
[   24.736783] RBP: 0000000000000067 R08: ffff93f73ed17da0 R09: 0000000000000001
[   24.736784] R10: 0000000000000000 R11: 0000000000080000 R12: 0000000000000000
[   24.736784] R13: 0000000000000007 R14: ffffffff94c0ee20 R15: 0000000000000002
[   24.736784]  </#DB>
[   24.736784]  __handle_sysrq.cold+0x51/0x130
[   24.736785]  write_sysrq_trigger+0x3a/0x45
[   24.736785]  proc_reg_write+0x4e/0x80
[   24.736785]  vfs_write+0xe7/0x230
[   24.736785]  ksys_write+0x63/0xe0
[   24.736785]  do_syscall_64+0x33/0x40
[   24.736786]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   24.736786] RIP: 0033:0x7fe1f84235ed
[   24.736787] Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 46 d3 ff ff 41 54 b8 02 00 00 00 49 89 f4 be 00 08 08 00 55
[   24.736787] RSP: 002b:00007ffec6dd7478 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   24.736787] RAX: ffffffffffffffda RBX: 00007fe1f8464d88 RCX: 00007fe1f84235ed
[   24.736788] RDX: 0000000000000002 RSI: 00007fe1f8465f60 RDI: 0000000000000001
[   24.736788] RBP: 00007fe1f8465f60 R08: 0000000000000000 R09: 0000000000000000
[   24.736788] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[   24.736789] R13: 0000000000000001 R14: 00007fe1f8465f60 R15: 00007fe1f8465ce5
[   24.736789] irq event stamp: 8874
[   24.736789] hardirqs last  enabled at (8873): [<ffffffff94800c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20
[   24.736790] hardirqs last disabled at (8874): [<ffffffff9464b341>] exc_debug+0x51/0x120
[   24.736790] softirqs last  enabled at (8872): [<ffffffff94a0033c>] __do_softirq+0x33c/0x458
[   24.736790] softirqs last disabled at (8859): [<ffffffff94800f72>] asm_call_on_stack+0x12/0x20
[   24.736791] ---[ end trace 16146f99e9adcc28 ]---

Welcome to Buildroot
buildroot login:

>  	handle_debug(regs, dr6, false);
>  
>  out:
> 
> 

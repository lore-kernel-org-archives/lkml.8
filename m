Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71957C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F235821556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NK2lG2K4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBXVgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:36:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36914 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgBXVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:36:33 -0500
Received: from zn.tnic (p200300EC2F0C0F00A4C33048F8AFAF18.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:f00:a4c3:3048:f8af:af18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B7701EC071C;
        Mon, 24 Feb 2020 22:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582580187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ok6HJICRmgFIyXkm7Yy8X2EPauw8KrdbzeWzf67Nm4M=;
        b=NK2lG2K49o2DYAdHYyXwYHXCCuyaTzCdzS45dWvBjH31epaJyb9sJgwTXqtty2llv9uVt6
        QjCofSTLFwyn7Dxq/9/qgPZdSx38DjpylYCU5gqedsH/tM+CxHLfXKP2QQb4GZDBz89Dch
        AJ9RyFouWpMIBQ5E6G6hAiuiScHwv5A=
Date:   Mon, 24 Feb 2020 22:36:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Kconfig: make CMDLINE_OVERRIDE depend on CMDLINE
Message-ID: <20200224213621.GF29318@zn.tnic>
References: <20200124114615.11577-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124114615.11577-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 12:46:15PM +0100, Anders Roxell wrote:
> When trying to boot an allmodconfig kernel that is build with
> KCONFIG_ALLCONFIG=$(pwd)/arch/x86/configs/x86_64_defconfig, it doesn't
> boot since CONFIG_CMDLINE_OVERRIDE gets enabled. Which forces the user
> to pass the full cmdline to CONFIG_CMDLINE="...".

Hmmm, so I tried your way of building it and booting it in a guest, it
does boot here until the watchdog fires due to that tracer selftest
which gets enabled too, see below.

What it doesn't happen is that even if I have "console=ttyS0,115200
console=tty0" on the guest kernel's command line, the below doesn't get
logged to the qemu -serial file:... switch because of the command line
override. If I add the command line to CONFIG_CMDLINE - i.e., builtin -
it gets overridden and it works.

So I'm thinking your change makes sense - a cmdline should be overridden
only if there's something to be overridden with in the first place...

Thx.

early console in setup code
Wrong EFI loader signature.
early console in extract_kernel
input_data: 0x0000000008c553ac
input_len: 0x0000000001d848ba
output: 0x0000000001000000
output_len: 0x0000000009930214
kernel_total_size: 0x0000000008a2c000
needed_size: 0x0000000009a00000
trampoline_32bit: 0x000000000009d000
booted via startup_32()
Physical KASLR using RDRAND RDTSC...
Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.
[    0.000000][    T0] Linux version 5.6.0-rc3+ (boris@zn) (gcc version 9.2.1 20190909 (Debian 9.2.1-8)) #6 SMP Mon Feb 24 22:10:04 CET 2020
[    0.000000][    T0] Command line: root=/dev/sda1 resume=/dev/sda2 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend net.ifnames=0 
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai  
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000][    T0] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdefff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000007ffdf000-0x000000007fffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] printk: bootconsole [earlyser0] enabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002][    T0] kvm-clock: cpu 0, msr 53801001, primary cpu clock
[    0.000002][    T0] kvm-clock: using sched offset of 710633533 cycles
[    0.000517][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001925][    T0] tsc: Detected 3699.998 MHz processor
[    0.008781][    T0] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.009388][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.009894][    T0] last_pfn = 0x7ffdf max_arch_pfn = 0x400000000
[    0.010397][    T0] MTRR default type: write-back
[    0.010778][    T0] MTRR fixed ranges enabled:
[    0.011135][    T0]   00000-9FFFF write-back
[    0.011478][    T0]   A0000-BFFFF uncachable
[    0.011823][    T0]   C0000-FFFFF write-protect
[    0.012185][    T0] MTRR variable ranges enabled:
[    0.012563][    T0]   0 base 0080000000 mask FF80000000 uncachable
[    0.013054][    T0]   1 disabled
[    0.013321][    T0]   2 disabled
[    0.013586][    T0]   3 disabled
[    0.013851][    T0]   4 disabled
[    0.014116][    T0]   5 disabled
[    0.014381][    T0]   6 disabled
[    0.014646][    T0]   7 disabled
[    0.014926][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.020099][    T0] found SMP MP-table at [mem 0x000f5c10-0x000f5c1f]
[    0.020663][    T0] check: Scanning 1 areas for low memory corruption
[    0.021206][    T0] BRK [0x53a01000, 0x53a01fff] PGTABLE
[    0.021640][    T0] BRK [0x53a02000, 0x53a02fff] PGTABLE
[    0.022067][    T0] BRK [0x53a03000, 0x53a03fff] PGTABLE
[    0.022689][    T0] BRK [0x53a04000, 0x53a04fff] PGTABLE
[    0.023119][    T0] BRK [0x53a05000, 0x53a05fff] PGTABLE
[    0.023704][    T0] BRK [0x53a06000, 0x53a06fff] PGTABLE
[    0.024171][    T0] BRK [0x53a07000, 0x53a07fff] PGTABLE
[    0.024640][    T0] BRK [0x53a08000, 0x53a08fff] PGTABLE
[    0.025113][    T0] BRK [0x53a09000, 0x53a09fff] PGTABLE
[    0.025574][    T0] BRK [0x53a0a000, 0x53a0afff] PGTABLE
[    0.026035][    T0] BRK [0x53a0b000, 0x53a0bfff] PGTABLE
[    0.026494][    T0] BRK [0x53a0c000, 0x53a0cfff] PGTABLE
[    0.071123][    T0] printk: log_buf_len: 16777216 bytes
[    0.071585][    T0] printk: early log buf free: 258040(98%)
[    0.072044][    T0] ACPI: Early table checksum verification disabled
[    0.072558][    T0] ACPI: RSDP 0x00000000000F5BC0 000014 (v00 BOCHS )
[    0.073094][    T0] ACPI: RSDT 0x000000007FFE153B 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.073843][    T0] ACPI: FACP 0x000000007FFE139F 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.074594][    T0] ACPI: DSDT 0x000000007FFDFA80 00191F (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.075514][    T0] ACPI: FACS 0x000000007FFDFA40 000040
[    0.075986][    T0] ACPI: APIC 0x000000007FFE1413 0000F0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.076731][    T0] ACPI: HPET 0x000000007FFE1503 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.077494][    T0] ACPI: Local APIC address 0xfee00000
[    0.078817][    T0] No NUMA configuration found
[    0.079181][    T0] Faking a node at [mem 0x0000000000000000-0x000000007ffdefff]
[    0.079847][    T0] NODE_DATA(0) allocated [mem 0x7ffa0000-0x7ffdefff]
[    0.082635][    T0] cma: dma_contiguous_reserve(limit 7ffdf000)
[    0.087410][    T0] Zone ranges:
[    0.087706][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.088251][    T0]   DMA32    [mem 0x0000000001000000-0x000000007ffdefff]
[    0.088794][    T0]   Normal   empty
[    0.089097][    T0]   Device   empty
[    0.089389][    T0] Movable zone start for each node
[    0.089785][    T0] Early memory node ranges
[    0.090127][    T0]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.090673][    T0]   node   0: [mem 0x0000000000100000-0x000000007ffdefff]
[    0.091235][    T0] Zeroed struct page in unavailable ranges: 131 pages
[    0.091241][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdefff]
[    0.092350][    T0] On node 0 totalpages: 524157
[    0.092715][    T0]   DMA zone: 64 pages used for memmap
[    0.093134][    T0]   DMA zone: 21 pages reserved
[    0.093513][    T0]   DMA zone: 3998 pages, LIFO batch:0
[    0.094278][    T0]   DMA32 zone: 8128 pages used for memmap
[    0.094727][    T0]   DMA32 zone: 520159 pages, LIFO batch:63
[    0.174972][    T0] kasan: KernelAddressSanitizer initialized
[    0.175749][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.176130][    T0] ACPI: Local APIC address 0xfee00000
[    0.176571][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.177132][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.177741][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.178297][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.178871][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.179486][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.180081][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.180677][    T0] ACPI: IRQ0 used by override.
[    0.181056][    T0] ACPI: IRQ5 used by override.
[    0.181430][    T0] ACPI: IRQ9 used by override.
[    0.181802][    T0] ACPI: IRQ10 used by override.
[    0.182182][    T0] ACPI: IRQ11 used by override.
[    0.182564][    T0] Using ACPI (MADT) for SMP configuration information
[    0.183091][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.183565][    T0] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.184117][    T0] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.184768][    T0] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.185423][    T0] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.186066][    T0] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.186719][    T0] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.187249][    T0] Booting paravirtualized kernel on KVM
[    0.187687][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.205706][    T0] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.220248][    T0] percpu: Embedded 574 pages/cpu s2314240 r8192 d28672 u4194304
[    0.220932][    T0] pcpu-alloc: s2314240 r8192 d28672 u4194304 alloc=2*2097152
[    0.221528][    T0] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07 
[    0.222195][    T0] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15 
[    0.223061][    T0] KVM setup async PF for cpu 0
[    0.223434][    T0] kvm-stealtime: cpu 0, msr 59034040
[    0.223863][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 515944
[    0.224455][    T0] Policy zone: DMA32
[    0.224764][    T0] Kernel command line: root=/dev/sda1 resume=/dev/sda2 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend net.ifnames=0 
[    0.227171][    T0] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.227949][    T0] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.228919][    T0] mem auto-init: stack:off, heap alloc:on, heap free:on
[    0.229469][    T0] mem auto-init: clearing system memory may take some time...
[    0.686887][    T0] Memory: 261668K/2096628K available (40965K kernel code, 25700K rwdata, 19416K rodata, 7008K init, 35516K bss, 756348K reserved, 0K cma-reserved)
[    0.694120][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.694705][    T0] kmemleak: Kernel memory leak detector disabled
[    0.702825][    T0] ODEBUG: selftest passed
[    0.703320][    T0] ftrace: allocating 63183 entries in 247 pages
[    0.770830][    T0] ftrace: allocated 247 pages with 7 groups
[    0.775769][    T0] Running RCU self tests
[    0.776157][    T0] rcu: Hierarchical RCU implementation.
[    0.776591][    T0] rcu: 	RCU event tracing is enabled.
[    0.777026][    T0] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.777620][    T0] rcu: 	RCU lockdep checking is enabled.
[    0.778063][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.778670][    T0] rcu: 	RCU callback double-/use-after-free debug enabled.
[    0.779234][    T0] rcu: 	RCU debug extended QS entry/exit.
[    0.779682][    T0] 	Tasks RCU enabled.
[    0.779993][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.780652][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.814637][    T0] NR_IRQS: 524544, nr_irqs: 552, preallocated irqs: 16
[    0.816942][    T0] workqueue: round-robin CPU selection forced, expect performance impact
[    0.817630][    T0] random: crng done (trusting CPU's manufacturer)
[    0.822381][    T0] Console: colour VGA+ 80x25
[    0.822763][    T0] printk: console [tty0] enabled
[    0.823454][    T0] printk: bootconsole [earlyser0] disabled
[    0.000000][    T0] Linux version 5.6.0-rc3+ (boris@zn) (gcc version 9.2.1 20190909 (Debian 9.2.1-8)) #6 SMP Mon Feb 24 22:10:04 CET 2020
[    0.000000][    T0] Command line: root=/dev/sda1 resume=/dev/sda2 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend net.ifnames=0 
[    0.000000][    T0] KERNEL supported cpus:
[    0.000000][    T0]   Intel GenuineIntel
[    0.000000][    T0]   AMD AuthenticAMD
[    0.000000][    T0]   Hygon HygonGenuine
[    0.000000][    T0]   Centaur CentaurHauls
[    0.000000][    T0]   zhaoxin   Shanghai  
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000][    T0] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000][    T0] BIOS-provided physical RAM map:
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x0000000000100000-0x000000007ffdefff] usable
[    0.000000][    T0] BIOS-e820: [mem 0x000000007ffdf000-0x000000007fffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000][    T0] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000][    T0] printk: debug: ignoring loglevel setting.
[    0.000000][    T0] printk: bootconsole [earlyser0] enabled
[    0.000000][    T0] NX (Execute Disable) protection: active
[    0.000000][    T0] SMBIOS 2.8 present.
[    0.000000][    T0] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    0.000000][    T0] Hypervisor detected: KVM
[    0.000000][    T0] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000002][    T0] kvm-clock: cpu 0, msr 53801001, primary cpu clock
[    0.000002][    T0] kvm-clock: using sched offset of 710633533 cycles
[    0.000517][    T0] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001925][    T0] tsc: Detected 3699.998 MHz processor
[    0.008781][    T0] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.009388][    T0] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.009894][    T0] last_pfn = 0x7ffdf max_arch_pfn = 0x400000000
[    0.010397][    T0] MTRR default type: write-back
[    0.010778][    T0] MTRR fixed ranges enabled:
[    0.011135][    T0]   00000-9FFFF write-back
[    0.011478][    T0]   A0000-BFFFF uncachable
[    0.011823][    T0]   C0000-FFFFF write-protect
[    0.012185][    T0] MTRR variable ranges enabled:
[    0.012563][    T0]   0 base 0080000000 mask FF80000000 uncachable
[    0.013054][    T0]   1 disabled
[    0.013321][    T0]   2 disabled
[    0.013586][    T0]   3 disabled
[    0.013851][    T0]   4 disabled
[    0.014116][    T0]   5 disabled
[    0.014381][    T0]   6 disabled
[    0.014646][    T0]   7 disabled
[    0.014926][    T0] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.020099][    T0] found SMP MP-table at [mem 0x000f5c10-0x000f5c1f]
[    0.020663][    T0] check: Scanning 1 areas for low memory corruption
[    0.021206][    T0] BRK [0x53a01000, 0x53a01fff] PGTABLE
[    0.021640][    T0] BRK [0x53a02000, 0x53a02fff] PGTABLE
[    0.022067][    T0] BRK [0x53a03000, 0x53a03fff] PGTABLE
[    0.022689][    T0] BRK [0x53a04000, 0x53a04fff] PGTABLE
[    0.023119][    T0] BRK [0x53a05000, 0x53a05fff] PGTABLE
[    0.023704][    T0] BRK [0x53a06000, 0x53a06fff] PGTABLE
[    0.024171][    T0] BRK [0x53a07000, 0x53a07fff] PGTABLE
[    0.024640][    T0] BRK [0x53a08000, 0x53a08fff] PGTABLE
[    0.025113][    T0] BRK [0x53a09000, 0x53a09fff] PGTABLE
[    0.025574][    T0] BRK [0x53a0a000, 0x53a0afff] PGTABLE
[    0.026035][    T0] BRK [0x53a0b000, 0x53a0bfff] PGTABLE
[    0.026494][    T0] BRK [0x53a0c000, 0x53a0cfff] PGTABLE
[    0.071123][    T0] printk: log_buf_len: 16777216 bytes
[    0.071585][    T0] printk: early log buf free: 258040(98%)
[    0.072044][    T0] ACPI: Early table checksum verification disabled
[    0.072558][    T0] ACPI: RSDP 0x00000000000F5BC0 000014 (v00 BOCHS )
[    0.073094][    T0] ACPI: RSDT 0x000000007FFE153B 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.073843][    T0] ACPI: FACP 0x000000007FFE139F 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.074594][    T0] ACPI: DSDT 0x000000007FFDFA80 00191F (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.075514][    T0] ACPI: FACS 0x000000007FFDFA40 000040
[    0.075986][    T0] ACPI: APIC 0x000000007FFE1413 0000F0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.076731][    T0] ACPI: HPET 0x000000007FFE1503 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.077494][    T0] ACPI: Local APIC address 0xfee00000
[    0.078817][    T0] No NUMA configuration found
[    0.079181][    T0] Faking a node at [mem 0x0000000000000000-0x000000007ffdefff]
[    0.079847][    T0] NODE_DATA(0) allocated [mem 0x7ffa0000-0x7ffdefff]
[    0.082635][    T0] cma: dma_contiguous_reserve(limit 7ffdf000)
[    0.087410][    T0] Zone ranges:
[    0.087706][    T0]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.088251][    T0]   DMA32    [mem 0x0000000001000000-0x000000007ffdefff]
[    0.088794][    T0]   Normal   empty
[    0.089097][    T0]   Device   empty
[    0.089389][    T0] Movable zone start for each node
[    0.089785][    T0] Early memory node ranges
[    0.090127][    T0]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.090673][    T0]   node   0: [mem 0x0000000000100000-0x000000007ffdefff]
[    0.091235][    T0] Zeroed struct page in unavailable ranges: 131 pages
[    0.091241][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffdefff]
[    0.092350][    T0] On node 0 totalpages: 524157
[    0.092715][    T0]   DMA zone: 64 pages used for memmap
[    0.093134][    T0]   DMA zone: 21 pages reserved
[    0.093513][    T0]   DMA zone: 3998 pages, LIFO batch:0
[    0.094278][    T0]   DMA32 zone: 8128 pages used for memmap
[    0.094727][    T0]   DMA32 zone: 520159 pages, LIFO batch:63
[    0.174972][    T0] kasan: KernelAddressSanitizer initialized
[    0.175749][    T0] ACPI: PM-Timer IO Port: 0x608
[    0.176130][    T0] ACPI: Local APIC address 0xfee00000
[    0.176571][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.177132][    T0] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.177741][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.178297][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.178871][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.179486][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.180081][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.180677][    T0] ACPI: IRQ0 used by override.
[    0.181056][    T0] ACPI: IRQ5 used by override.
[    0.181430][    T0] ACPI: IRQ9 used by override.
[    0.181802][    T0] ACPI: IRQ10 used by override.
[    0.182182][    T0] ACPI: IRQ11 used by override.
[    0.182564][    T0] Using ACPI (MADT) for SMP configuration information
[    0.183091][    T0] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.183565][    T0] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.184117][    T0] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.184768][    T0] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.185423][    T0] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.186066][    T0] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.186719][    T0] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.187249][    T0] Booting paravirtualized kernel on KVM
[    0.187687][    T0] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.205706][    T0] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.220248][    T0] percpu: Embedded 574 pages/cpu s2314240 r8192 d28672 u4194304
[    0.220932][    T0] pcpu-alloc: s2314240 r8192 d28672 u4194304 alloc=2*2097152
[    0.221528][    T0] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07 
[    0.222195][    T0] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15 
[    0.223061][    T0] KVM setup async PF for cpu 0
[    0.223434][    T0] kvm-stealtime: cpu 0, msr 59034040
[    0.223863][    T0] Built 1 zonelists, mobility grouping on.  Total pages: 515944
[    0.224455][    T0] Policy zone: DMA32
[    0.224764][    T0] Kernel command line: root=/dev/sda1 resume=/dev/sda2 debug ignore_loglevel log_buf_len=16M earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 no_console_suspend net.ifnames=0 
[    0.227171][    T0] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.227949][    T0] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.228919][    T0] mem auto-init: stack:off, heap alloc:on, heap free:on
[    0.229469][    T0] mem auto-init: clearing system memory may take some time...
[    0.686887][    T0] Memory: 261668K/2096628K available (40965K kernel code, 25700K rwdata, 19416K rodata, 7008K init, 35516K bss, 756348K reserved, 0K cma-reserved)
[    0.694120][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.694705][    T0] kmemleak: Kernel memory leak detector disabled
[    0.702825][    T0] ODEBUG: selftest passed
[    0.703320][    T0] ftrace: allocating 63183 entries in 247 pages
[    0.770830][    T0] ftrace: allocated 247 pages with 7 groups
[    0.775769][    T0] Running RCU self tests
[    0.776157][    T0] rcu: Hierarchical RCU implementation.
[    0.776591][    T0] rcu: 	RCU event tracing is enabled.
[    0.777026][    T0] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.777620][    T0] rcu: 	RCU lockdep checking is enabled.
[    0.778063][    T0] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.778670][    T0] rcu: 	RCU callback double-/use-after-free debug enabled.
[    0.779234][    T0] rcu: 	RCU debug extended QS entry/exit.
[    0.779682][    T0] 	Tasks RCU enabled.
[    0.779993][    T0] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.780652][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.814637][    T0] NR_IRQS: 524544, nr_irqs: 552, preallocated irqs: 16
[    0.816942][    T0] workqueue: round-robin CPU selection forced, expect performance impact
[    0.817630][    T0] random: crng done (trusting CPU's manufacturer)
[    0.822381][    T0] Console: colour VGA+ 80x25
[    0.822763][    T0] printk: console [tty0] enabled
[    0.823454][    T0] printk: bootconsole [earlyser0] disabled
[    0.906816][    T0] printk: console [ttyS0] enabled
[    0.907517][    T0] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.908691][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.909379][    T0] ... MAX_LOCK_DEPTH:          48
[    0.910072][    T0] ... MAX_LOCKDEP_KEYS:        8192
[    0.910782][    T0] ... CLASSHASH_SIZE:          4096
[    0.911497][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.912222][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    0.912946][    T0] ... CHAINHASH_SIZE:          32768
[    0.913681][    T0]  memory used by lock dependency info: 6749 kB
[    0.914503][    T0]  memory used for stack traces: 4224 kB
[    0.915862][    T0]  per task-struct memory footprint: 2688 bytes
[    0.916700][    T0] ------------------------
[    0.917341][    T0] | Locking API testsuite:
[    0.917976][    T0] ----------------------------------------------------------------------------
[    0.919193][    T0]                                  | spin |wlock |rlock |mutex | wsem | rsem |
[    0.920409][    T0]   --------------------------------------------------------------------------
[    0.921642][    T0]                      A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.944437][    T0]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.969387][    T0]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.996668][    T0]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.023737][    T0]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.052731][    T0]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.081716][    T0]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.110820][    T0]                     double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.133669][    T0]                   initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.156179][    T0]   --------------------------------------------------------------------------
[    1.157418][    T0]               recursive read-lock:             |  ok  |             |  ok  |
[    1.165076][    T0]            recursive read-lock #2:             |  ok  |             |  ok  |
[    1.172456][    T0]             mixed read-write-lock:             |  ok  |             |  ok  |
[    1.179799][    T0]             mixed write-read-lock:             |  ok  |             |  ok  |
[    1.187238][    T0]   mixed read-lock/lock-write ABBA:             |FAILED|             |  ok  |
[    1.194027][    T0]    mixed read-lock/lock-read ABBA:             |  ok  |             |  ok  |
[    1.201977][    T0]  mixed write-lock/lock-write ABBA:             |  ok  |             |  ok  |
[    1.209882][    T0]   --------------------------------------------------------------------------
[    1.212289][    T0]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    1.222448][    T0]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    1.232607][    T0]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    1.242725][    T0]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    1.252891][    T0]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    1.263030][    T0]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    1.273110][    T0]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    1.283294][    T0]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    1.293413][    T0]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    1.303554][    T0]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    1.313774][    T0]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    1.324793][    T0]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    1.336341][    T0]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    1.347383][    T0]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    1.358365][    T0]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    1.369423][    T0]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    1.380428][    T0]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    1.391452][    T0]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    1.402654][    T0]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    1.413467][    T0]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    1.424069][    T0]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    1.435236][    T0]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    1.446442][    T0]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    1.457636][    T0]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    1.469222][    T0]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    1.480414][    T0]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    1.491527][    T0]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    1.502606][    T0]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    1.513716][    T0]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    1.524814][    T0]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    1.535928][    T0]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    1.547018][    T0]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    1.558112][    T0]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    1.569144][    T0]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    1.580171][    T0]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    1.591275][    T0]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    1.602393][    T0]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    1.613526][    T0]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    1.624618][    T0]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    1.636174][    T0]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    1.647244][    T0]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    1.658320][    T0]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    1.669408][    T0]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    1.680477][    T0]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    1.691499][    T0]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    1.702529][    T0]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    1.713526][    T0]       hard-irq read-recursion/123:  ok  |
[    1.717698][    T0]       soft-irq read-recursion/123:  ok  |
[    1.721861][    T0]       hard-irq read-recursion/132:  ok  |
[    1.726563][    T0]       soft-irq read-recursion/132:  ok  |
[    1.730711][    T0]       hard-irq read-recursion/213:  ok  |
[    1.734825][    T0]       soft-irq read-recursion/213:  ok  |
[    1.738975][    T0]       hard-irq read-recursion/231:  ok  |
[    1.743106][    T0]       soft-irq read-recursion/231:  ok  |
[    1.747262][    T0]       hard-irq read-recursion/312:  ok  |
[    1.751371][    T0]       soft-irq read-recursion/312:  ok  |
[    1.756043][    T0]       hard-irq read-recursion/321:  ok  |
[    1.760205][    T0]       soft-irq read-recursion/321:  ok  |
[    1.764345][    T0]   --------------------------------------------------------------------------
[    1.765553][    T0]   | Wound/wait tests |
[    1.766165][    T0]   ---------------------
[    1.766785][    T0]                   ww api failures:  ok  |  ok  |  ok  |
[    1.777497][    T0]                ww contexts mixing:  ok  |  ok  |
[    1.784724][    T0]              finishing ww context:  ok  |  ok  |  ok  |  ok  |
[    1.798636][    T0]                locking mismatches:  ok  |  ok  |  ok  |
[    1.809241][    T0]                  EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.844283][    T0]            spinlock nest unlocked:  ok  |
[    1.848147][    T0]   -----------------------------------------------------
[    1.849051][    T0]                                  |block | try  |context|
[    1.849966][    T0]   -----------------------------------------------------
[    1.850865][    T0]                           context:  ok  |  ok  |  ok  |
[    1.861844][    T0]                               try:  ok  |  ok  |  ok  |
[    1.872223][    T0]                             block:  ok  |  ok  |  ok  |
[    1.882668][    T0]                          spinlock:  ok  |  ok  |  ok  |
[    1.893950][    T0] -------------------------------------------------------
[    1.894840][    T0] Good, all 261 testcases passed! |
[    1.895539][    T0] ---------------------------------
[    1.896537][    T0] ACPI: Core revision 20200110
[    1.898476][    T0] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    1.900039][    T0] APIC: Switch to symmetric I/O mode setup
[    1.900982][    T0] x2apic enabled
[    1.901680][    T0] Switched APIC routing to physical x2apic.
[    1.904477][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    1.905950][    T0] tsc: Marking TSC unstable due to TSCs unsynchronized
[    1.906866][    T0] Calibrating delay loop (skipped) preset value.. 7399.99 BogoMIPS (lpj=3699998)
[    1.907854][    T0] pid_max: default: 32768 minimum: 301
[    1.909706][    T0] LSM: Security Framework initializing
[    1.910069][    T0] Yama: becoming mindful.
[    1.910978][    T0] LoadPin: ready to pin (currently enforcing)
[    1.911955][    T0] SELinux:  Initializing.
[    1.913449][    T0] *** VALIDATE selinux ***
[    1.913876][    T0] TOMOYO Linux initialized
[    1.916059][    T0] Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    1.916867][    T0] Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
[    1.918883][    T0] kobject: 'fs' ((____ptrval____)): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    1.919951][    T0] *** VALIDATE tmpfs ***
[    1.924142][    T0] *** VALIDATE proc ***
[    1.945251][    T0] *** VALIDATE cgroup ***
[    1.945855][    T0] *** VALIDATE cgroup2 ***
Poking KASLR using RDRAND RDTSC...
[    1.947479][    T0] numa_add_cpu cpu 0 node 0: mask now 0
[    1.947856][    T0] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    1.948854][    T0] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    1.949865][    T0] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.950853][    T0] Spectre V2 : Mitigation: Full AMD retpoline
[    1.951851][    T0] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    1.952852][    T0] Speculative Store Bypass: Vulnerable
[    1.955180][    T0] debug: unmapping init [mem 0xffffffff8f343000-0xffffffff8f34ffff]
[    2.062219][    T1] smpboot: CPU0: AMD EPYC Processor (family: 0x17, model: 0x1, stepping: 0x2)
[    2.069771][    T1] Performance Events: AMD PMU driver.
[    2.069885][    T1] ... version:                0
[    2.070865][    T1] ... bit width:              48
[    2.071865][    T1] ... generic registers:      4
[    2.072851][    T1] ... value mask:             0000ffffffffffff
[    2.073642][    T1] ... max period:             00007fffffffffff
[    2.073850][    T1] ... fixed-purpose events:   0
[    2.074850][    T1] ... event mask:             000000000000000f
[    2.076555][    T1] rcu: Hierarchical SRCU implementation.
[    2.089937][    T1] smp: Bringing up secondary CPUs ...
[    2.093994][    T1] x86: Booting SMP configuration:
[    2.094714][    T1] .... node  #0, CPUs:        #1
[    1.088173][    T0] kvm-clock: cpu 1, msr 53801041, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 1 node 0: mask now 0-1
[    1.088173][    T0] smpboot: CPU 1 Converting physical 0 to logical die 1
[    2.100990][   T15] KVM setup async PF for cpu 1
[    2.101836][   T15] kvm-stealtime: cpu 1, msr 59434040
[    2.108926][    T1]   #2
[    1.088173][    T0] kvm-clock: cpu 2, msr 53801081, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 2 node 0: mask now 0-2
[    1.088173][    T0] smpboot: CPU 2 Converting physical 0 to logical die 2
[    2.114524][   T21] KVM setup async PF for cpu 2
[    2.114836][   T21] kvm-stealtime: cpu 2, msr 59834040
[    2.120911][    T1]   #3
[    1.088173][    T0] kvm-clock: cpu 3, msr 538010c1, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 3 node 0: mask now 0-3
[    1.088173][    T0] smpboot: CPU 3 Converting physical 0 to logical die 3
[    2.125850][   T27] KVM setup async PF for cpu 3
[    2.125850][   T27] kvm-stealtime: cpu 3, msr 59c34040
[    2.134182][    T1]   #4
[    1.088173][    T0] kvm-clock: cpu 4, msr 53801101, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 4 node 0: mask now 0-4
[    1.088173][    T0] smpboot: CPU 4 Converting physical 0 to logical die 4
[    2.136845][   T33] KVM setup async PF for cpu 4
[    2.136845][   T33] kvm-stealtime: cpu 4, msr 5a034040
[    2.141883][    T1]   #5
[    1.088173][    T0] kvm-clock: cpu 5, msr 53801141, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 5 node 0: mask now 0-5
[    1.088173][    T0] smpboot: CPU 5 Converting physical 0 to logical die 5
[    2.146843][   T39] KVM setup async PF for cpu 5
[    2.146843][   T39] kvm-stealtime: cpu 5, msr 5a434040
[    2.153492][    T1]   #6
[    1.088173][    T0] kvm-clock: cpu 6, msr 53801181, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 6 node 0: mask now 0-6
[    1.088173][    T0] smpboot: CPU 6 Converting physical 0 to logical die 6
[    2.156191][   T45] KVM setup async PF for cpu 6
[    2.156836][   T45] kvm-stealtime: cpu 6, msr 5a834040
[    2.162560][    T1]   #7
[    1.088173][    T0] kvm-clock: cpu 7, msr 538011c1, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 7 node 0: mask now 0-7
[    1.088173][    T0] smpboot: CPU 7 Converting physical 0 to logical die 7
[    2.165846][   T51] KVM setup async PF for cpu 7
[    2.165846][   T51] kvm-stealtime: cpu 7, msr 5ac34040
[    2.173726][    T1]   #8
[    1.088173][    T0] kvm-clock: cpu 8, msr 53801201, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 8 node 0: mask now 0-8
[    1.088173][    T0] smpboot: CPU 8 Converting physical 0 to logical die 8
[    2.178846][   T57] KVM setup async PF for cpu 8
[    2.178846][   T57] kvm-stealtime: cpu 8, msr 5b034040
[    2.187285][    T1]   #9
[    1.088173][    T0] kvm-clock: cpu 9, msr 53801241, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 9 node 0: mask now 0-9
[    1.088173][    T0] smpboot: CPU 9 Converting physical 0 to logical die 9
[    2.190518][   T63] KVM setup async PF for cpu 9
[    2.190836][   T63] kvm-stealtime: cpu 9, msr 5b434040
[    2.198189][    T1]  #10
[    1.088173][    T0] kvm-clock: cpu 10, msr 53801281, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 10 node 0: mask now 0-10
[    1.088173][    T0] smpboot: CPU 10 Converting physical 0 to logical die 10
[    2.203844][   T69] KVM setup async PF for cpu 10
[    2.203844][   T69] kvm-stealtime: cpu 10, msr 5b834040
[    2.212252][    T1]  #11
[    1.088173][    T0] kvm-clock: cpu 11, msr 538012c1, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 11 node 0: mask now 0-11
[    1.088173][    T0] smpboot: CPU 11 Converting physical 0 to logical die 11
[    2.217843][   T75] KVM setup async PF for cpu 11
[    2.217843][   T75] kvm-stealtime: cpu 11, msr 5bc34040
[    2.224979][    T1]  #12
[    1.088173][    T0] kvm-clock: cpu 12, msr 53801301, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 12 node 0: mask now 0-12
[    1.088173][    T0] smpboot: CPU 12 Converting physical 0 to logical die 12
[    2.230844][   T81] KVM setup async PF for cpu 12
[    2.230844][   T81] kvm-stealtime: cpu 12, msr 5c034040
[    2.238933][    T1]  #13
[    1.088173][    T0] kvm-clock: cpu 13, msr 53801341, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 13 node 0: mask now 0-13
[    1.088173][    T0] smpboot: CPU 13 Converting physical 0 to logical die 13
[    2.244591][   T87] KVM setup async PF for cpu 13
[    2.244836][   T87] kvm-stealtime: cpu 13, msr 5c434040
[    2.252743][    T1]  #14
[    1.088173][    T0] kvm-clock: cpu 14, msr 53801381, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 14 node 0: mask now 0-14
[    1.088173][    T0] smpboot: CPU 14 Converting physical 0 to logical die 14
[    2.257844][   T93] KVM setup async PF for cpu 14
[    2.257844][   T93] kvm-stealtime: cpu 14, msr 5c834040
[    2.266865][    T1]  #15
[    1.088173][    T0] kvm-clock: cpu 15, msr 538013c1, secondary cpu clock
[    1.088173][    T0] numa_add_cpu cpu 15 node 0: mask now 0-15
[    1.088173][    T0] smpboot: CPU 15 Converting physical 0 to logical die 15
[    2.272903][   T99] KVM setup async PF for cpu 15
[    2.273836][   T99] kvm-stealtime: cpu 15, msr 5cc34040
[    2.275420][    T1] smp: Brought up 1 node, 16 CPUs
[    2.275896][    T1] smpboot: Max logical packages: 16
[    2.277914][    T1] ----------------
[    2.278860][    T1] | NMI testsuite:
[    2.279859][    T1] --------------------
[    2.280860][    T1]   remote IPI:  ok  |
[    2.282872][    T1]    local IPI:  ok  |
[    2.283972][    T1] --------------------
[    2.284881][    T1] Good, all   2 testcases passed! |
[    2.285871][    T1] ---------------------------------
[    2.286863][    T1] smpboot: Total of 16 processors activated (118399.93 BogoMIPS)
[    3.195878][  T105] node 0 initialised, 269653 pages in 892ms
[    3.197191][  T105] pgdatinit0 (105) used greatest stack depth: 30096 bytes left
[    3.203228][    T1] devtmpfs: initialized
[    3.203897][    T1] kobject: 'devices' (00000000a2ec875e): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.204910][    T1] kobject: 'devices' (00000000a2ec875e): kobject_uevent_env
[    3.206862][    T1] kobject: 'devices' (00000000a2ec875e): kobject_uevent_env: attempted to send uevent without kset!
[    3.207909][    T1] kobject: 'dev' (0000000034371bf7): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.209909][    T1] kobject: 'block' (00000000da442984): kobject_add_internal: parent: 'dev', set: '<NULL>'
[    3.211895][    T1] kobject: 'char' (0000000006666516): kobject_add_internal: parent: 'dev', set: '<NULL>'
[    3.212888][    T1] kobject: 'bus' (00000000a76f5638): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.213873][    T1] kobject: 'bus' (00000000a76f5638): kobject_uevent_env
[    3.214855][    T1] kobject: 'bus' (00000000a76f5638): kobject_uevent_env: attempted to send uevent without kset!
[    3.216855][    T1] kobject: 'system' (000000004c1de689): kobject_add_internal: parent: 'devices', set: '<NULL>'
[    3.217876][    T1] kobject: 'system' (000000004c1de689): kobject_uevent_env
[    3.218854][    T1] kobject: 'system' (000000004c1de689): kobject_uevent_env: attempted to send uevent without kset!
[    3.220858][    T1] kobject: 'class' (00000000c2d7cd02): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.221873][    T1] kobject: 'class' (00000000c2d7cd02): kobject_uevent_env
[    3.222854][    T1] kobject: 'class' (00000000c2d7cd02): kobject_uevent_env: attempted to send uevent without kset!
[    3.223871][    T1] kobject: 'firmware' (000000007890e0a8): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.224889][    T1] kobject: 'hypervisor' (0000000045bd0cbf): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.226864][    T1] kobject: 'devicetree' (00000000877ac6b7): kobject_add_internal: parent: 'firmware', set: '<NULL>'
[    3.227894][    T1] kobject: 'devicetree' (00000000877ac6b7): kobject_uevent_env
[    3.228858][    T1] kobject: 'devicetree' (00000000877ac6b7): kobject_uevent_env: attempted to send uevent without kset!
[    3.229888][    T1] device: 'platform': device_add
[    3.230874][    T1] kobject: 'platform' (0000000045a25100): kobject_add_internal: parent: 'devices', set: 'devices'
[    3.232098][    T1] PM: Adding info for No Bus:platform
[    3.232888][    T1] kobject: 'platform' (0000000045a25100): kobject_uevent_env
[    3.233855][    T1] kobject: 'platform' (0000000045a25100): kobject_uevent_env: filter function caused the event to drop!
[    3.234888][    T1] kobject: 'platform' (00000000cf68e920): kobject_add_internal: parent: 'bus', set: 'bus'
[    3.235874][    T1] kobject: 'platform' (00000000cf68e920): kobject_uevent_env
[    3.236905][    T1] kobject: 'platform' (00000000cf68e920): fill_kobj_path: path = '/bus/platform'
[    3.237920][    T1] kobject: 'devices' (00000000d755f09e): kobject_add_internal: parent: 'platform', set: '<NULL>'
[    3.238874][    T1] kobject: 'devices' (00000000d755f09e): kobject_uevent_env
[    3.239856][    T1] kobject: 'devices' (00000000d755f09e): kobject_uevent_env: filter function caused the event to drop!
[    3.240873][    T1] kobject: 'drivers' (00000000e40d62c6): kobject_add_internal: parent: 'platform', set: '<NULL>'
[    3.241874][    T1] kobject: 'drivers' (00000000e40d62c6): kobject_uevent_env
[    3.242855][    T1] kobject: 'drivers' (00000000e40d62c6): kobject_uevent_env: filter function caused the event to drop!
[    3.244858][    T1] bus: 'platform': registered
[    3.245619][    T1] kobject: 'cpu' (000000009db1a7e2): kobject_add_internal: parent: 'bus', set: 'bus'
[    3.245875][    T1] kobject: 'cpu' (000000009db1a7e2): kobject_uevent_env
[    3.246889][    T1] kobject: 'cpu' (000000009db1a7e2): fill_kobj_path: path = '/bus/cpu'
[    3.247905][    T1] kobject: 'devices' (00000000fd28d475): kobject_add_internal: parent: 'cpu', set: '<NULL>'
[    3.248874][    T1] kobject: 'devices' (00000000fd28d475): kobject_uevent_env
[    3.249855][    T1] kobject: 'devices' (00000000fd28d475): kobject_uevent_env: filter function caused the event to drop!
[    3.250871][    T1] kobject: 'drivers' (00000000ae782193): kobject_add_internal: parent: 'cpu', set: '<NULL>'
[    3.251874][    T1] kobject: 'drivers' (00000000ae782193): kobject_uevent_env
[    3.252855][    T1] kobject: 'drivers' (00000000ae782193): kobject_uevent_env: filter function caused the event to drop!
[    3.253889][    T1] bus: 'cpu': registered
[    3.254888][    T1] device: 'cpu': device_add
[    3.255571][    T1] kobject: 'cpu' (0000000072d052a0): kobject_add_internal: parent: 'system', set: 'devices'
[    3.256169][    T1] PM: Adding info for No Bus:cpu
[    3.256856][    T1] kobject: 'cpu' (0000000072d052a0): kobject_uevent_env
[    3.257854][    T1] kobject: 'cpu' (0000000072d052a0): kobject_uevent_env: filter function caused the event to drop!
[    3.259014][    T1] x86/mm: Memory block size: 128MB
[    3.259874][    T1] kobject: 'memory' (00000000b2b93323): kobject_add_internal: parent: 'bus', set: 'bus'
[    3.260874][    T1] kobject: 'memory' (00000000b2b93323): kobject_uevent_env
[    3.261905][    T1] kobject: 'memory' (00000000b2b93323): fill_kobj_path: path = '/bus/memory'
[    3.262906][    T1] kobject: 'devices' (0000000084680eaa): kobject_add_internal: parent: 'memory', set: '<NULL>'
[    3.263875][    T1] kobject: 'devices' (0000000084680eaa): kobject_uevent_env
[    3.264855][    T1] kobject: 'devices' (0000000084680eaa): kobject_uevent_env: filter function caused the event to drop!
[    3.265871][    T1] kobject: 'drivers' (00000000a9467efe): kobject_add_internal: parent: 'memory', set: '<NULL>'
[    3.266874][    T1] kobject: 'drivers' (00000000a9467efe): kobject_uevent_env
[    3.267854][    T1] kobject: 'drivers' (00000000a9467efe): kobject_uevent_env: filter function caused the event to drop!
[    3.268889][    T1] bus: 'memory': registered
[    3.269887][    T1] device: 'memory': device_add
[    3.270599][    T1] kobject: 'memory' (00000000b658e78e): kobject_add_internal: parent: 'system', set: 'devices'
[    3.271140][    T1] PM: Adding info for No Bus:memory
[    3.271857][    T1] kobject: 'memory' (00000000b658e78e): kobject_uevent_env
[    3.272854][    T1] kobject: 'memory' (00000000b658e78e): kobject_uevent_env: filter function caused the event to drop!
[    3.274853][    T1] device: 'memory0': device_add
[    3.275574][    T1] kobject: 'memory0' (0000000048b35b02): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.275995][    T1] bus: 'memory': add device memory0
[    3.277094][    T1] PM: Adding info for memory:memory0
[    3.277857][    T1] kobject: 'memory0' (0000000048b35b02): kobject_uevent_env
[    3.278887][    T1] kobject: 'memory0' (0000000048b35b02): fill_kobj_path: path = '/devices/system/memory/memory0'
[    3.279962][    T1] device: 'memory1': device_add
[    3.280857][    T1] kobject: 'memory1' (00000000b0b9b085): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.282019][    T1] bus: 'memory': add device memory1
[    3.283036][    T1] PM: Adding info for memory:memory1
[    3.283803][    T1] kobject: 'memory1' (00000000b0b9b085): kobject_uevent_env
[    3.284869][    T1] kobject: 'memory1' (00000000b0b9b085): fill_kobj_path: path = '/devices/system/memory/memory1'
[    3.285927][    T1] device: 'memory2': device_add
[    3.286857][    T1] kobject: 'memory2' (000000002ada5242): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.288021][    T1] bus: 'memory': add device memory2
[    3.289066][    T1] PM: Adding info for memory:memory2
[    3.289859][    T1] kobject: 'memory2' (000000002ada5242): kobject_uevent_env
[    3.290885][    T1] kobject: 'memory2' (000000002ada5242): fill_kobj_path: path = '/devices/system/memory/memory2'
[    3.292088][    T1] device: 'memory3': device_add
[    3.292857][    T1] kobject: 'memory3' (00000000632ac011): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.294974][    T1] bus: 'memory': add device memory3
[    3.295951][    T1] PM: Adding info for memory:memory3
[    3.296719][    T1] kobject: 'memory3' (00000000632ac011): kobject_uevent_env
[    3.296898][    T1] kobject: 'memory3' (00000000632ac011): fill_kobj_path: path = '/devices/system/memory/memory3'
[    3.297918][    T1] device: 'memory4': device_add
[    3.298856][    T1] kobject: 'memory4' (00000000055aa2e4): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.300014][    T1] bus: 'memory': add device memory4
[    3.301068][    T1] PM: Adding info for memory:memory4
[    3.301861][    T1] kobject: 'memory4' (00000000055aa2e4): kobject_uevent_env
[    3.302895][    T1] kobject: 'memory4' (00000000055aa2e4): fill_kobj_path: path = '/devices/system/memory/memory4'
[    3.303938][    T1] device: 'memory5': device_add
[    3.304659][    T1] kobject: 'memory5' (000000008cf6bdcf): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.305010][    T1] bus: 'memory': add device memory5
[    3.306079][    T1] PM: Adding info for memory:memory5
[    3.306873][    T1] kobject: 'memory5' (000000008cf6bdcf): kobject_uevent_env
[    3.307915][    T1] kobject: 'memory5' (000000008cf6bdcf): fill_kobj_path: path = '/devices/system/memory/memory5'
[    3.309853][    T1] device: 'memory6': device_add
[    3.310585][    T1] kobject: 'memory6' (000000007963a032): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.310996][    T1] bus: 'memory': add device memory6
[    3.312055][    T1] PM: Adding info for memory:memory6
[    3.312857][    T1] kobject: 'memory6' (000000007963a032): kobject_uevent_env
[    3.313883][    T1] kobject: 'memory6' (000000007963a032): fill_kobj_path: path = '/devices/system/memory/memory6'
[    3.314922][    T1] device: 'memory7': device_add
[    3.315643][    T1] kobject: 'memory7' (00000000c65c9ad9): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.316008][    T1] bus: 'memory': add device memory7
[    3.317051][    T1] PM: Adding info for memory:memory7
[    3.317857][    T1] kobject: 'memory7' (00000000c65c9ad9): kobject_uevent_env
[    3.318897][    T1] kobject: 'memory7' (00000000c65c9ad9): fill_kobj_path: path = '/devices/system/memory/memory7'
[    3.319922][    T1] device: 'memory8': device_add
[    3.320856][    T1] kobject: 'memory8' (0000000015a0863c): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.322004][    T1] bus: 'memory': add device memory8
[    3.323068][    T1] PM: Adding info for memory:memory8
[    3.323858][    T1] kobject: 'memory8' (0000000015a0863c): kobject_uevent_env
[    3.324884][    T1] kobject: 'memory8' (0000000015a0863c): fill_kobj_path: path = '/devices/system/memory/memory8'
[    3.325937][    T1] device: 'memory9': device_add
[    3.326857][    T1] kobject: 'memory9' (00000000f7da3195): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.328917][    T1] bus: 'memory': add device memory9
[    3.329891][    T1] PM: Adding info for memory:memory9
[    3.330668][    T1] kobject: 'memory9' (00000000f7da3195): kobject_uevent_env
[    3.330900][    T1] kobject: 'memory9' (00000000f7da3195): fill_kobj_path: path = '/devices/system/memory/memory9'
[    3.331926][    T1] device: 'memory10': device_add
[    3.332857][    T1] kobject: 'memory10' (0000000011583ad1): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.333996][    T1] bus: 'memory': add device memory10
[    3.335093][    T1] PM: Adding info for memory:memory10
[    3.335860][    T1] kobject: 'memory10' (0000000011583ad1): kobject_uevent_env
[    3.336885][    T1] kobject: 'memory10' (0000000011583ad1): fill_kobj_path: path = '/devices/system/memory/memory10'
[    3.337949][    T1] device: 'memory11': device_add
[    3.338864][    T1] kobject: 'memory11' (000000009472845e): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.339995][    T1] bus: 'memory': add device memory11
[    3.341068][    T1] PM: Adding info for memory:memory11
[    3.341857][    T1] kobject: 'memory11' (000000009472845e): kobject_uevent_env
[    3.342899][    T1] kobject: 'memory11' (000000009472845e): fill_kobj_path: path = '/devices/system/memory/memory11'
[    3.343927][    T1] device: 'memory12': device_add
[    3.344860][    T1] kobject: 'memory12' (0000000020f63e8e): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.346014][    T1] bus: 'memory': add device memory12
[    3.347054][    T1] PM: Adding info for memory:memory12
[    3.347859][    T1] kobject: 'memory12' (0000000020f63e8e): kobject_uevent_env
[    3.348882][    T1] kobject: 'memory12' (0000000020f63e8e): fill_kobj_path: path = '/devices/system/memory/memory12'
[    3.349930][    T1] device: 'memory13': device_add
[    3.350856][    T1] kobject: 'memory13' (0000000098045da8): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.351992][    T1] bus: 'memory': add device memory13
[    3.353047][    T1] PM: Adding info for memory:memory13
[    3.353859][    T1] kobject: 'memory13' (0000000098045da8): kobject_uevent_env
[    3.354897][    T1] kobject: 'memory13' (0000000098045da8): fill_kobj_path: path = '/devices/system/memory/memory13'
[    3.355934][    T1] device: 'memory14': device_add
[    3.356856][    T1] kobject: 'memory14' (0000000034979f39): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.357993][    T1] bus: 'memory': add device memory14
[    3.359031][    T1] PM: Adding info for memory:memory14
[    3.359815][    T1] kobject: 'memory14' (0000000034979f39): kobject_uevent_env
[    3.359883][    T1] kobject: 'memory14' (0000000034979f39): fill_kobj_path: path = '/devices/system/memory/memory14'
[    3.360930][    T1] device: 'memory15': device_add
[    3.361857][    T1] kobject: 'memory15' (00000000324eee8d): kobject_add_internal: parent: 'memory', set: 'devices'
[    3.363015][    T1] bus: 'memory': add device memory15
[    3.364067][    T1] PM: Adding info for memory:memory15
[    3.364861][    T1] kobject: 'memory15' (00000000324eee8d): kobject_uevent_env
[    3.365898][    T1] kobject: 'memory15' (00000000324eee8d): fill_kobj_path: path = '/devices/system/memory/memory15'
[    3.366910][    T1] kobject: 'container' (000000008eabd7c0): kobject_add_internal: parent: 'bus', set: 'bus'
[    3.367875][    T1] kobject: 'container' (000000008eabd7c0): kobject_uevent_env
[    3.369865][    T1] kobject: 'container' (000000008eabd7c0): fill_kobj_path: path = '/bus/container'
[    3.370903][    T1] kobject: 'devices' (00000000a480077f): kobject_add_internal: parent: 'container', set: '<NULL>'
[    3.371875][    T1] kobject: 'devices' (00000000a480077f): kobject_uevent_env
[    3.372855][    T1] kobject: 'devices' (00000000a480077f): kobject_uevent_env: filter function caused the event to drop!
[    3.373871][    T1] kobject: 'drivers' (00000000d6066c28): kobject_add_internal: parent: 'container', set: '<NULL>'
[    3.375875][    T1] kobject: 'drivers' (00000000d6066c28): kobject_uevent_env
[    3.376856][    T1] kobject: 'drivers' (00000000d6066c28): kobject_uevent_env: filter function caused the event to drop!
[    3.377901][    T1] bus: 'container': registered
[    3.378886][    T1] device: 'container': device_add
[    3.379856][    T1] kobject: 'container' (0000000078e1fccb): kobject_add_internal: parent: 'system', set: 'devices'
[    3.381060][    T1] PM: Adding info for No Bus:container
[    3.381857][    T1] kobject: 'container' (0000000078e1fccb): kobject_uevent_env
[    3.382854][    T1] kobject: 'container' (0000000078e1fccb): kobject_uevent_env: filter function caused the event to drop!
[    3.386746][    T1] version magic: 0x4139322a
[    3.395277][    T1] kobject: 'virtual' (00000000885ab6b0): kobject_add_internal: parent: 'devices', set: '<NULL>'
[    3.396883][    T1] kobject: 'workqueue' (00000000c5618671): kobject_add_internal: parent: 'bus', set: 'bus'
[    3.397876][    T1] kobject: 'workqueue' (00000000c5618671): kobject_uevent_env
[    3.398910][    T1] kobject: 'workqueue' (00000000c5618671): fill_kobj_path: path = '/bus/workqueue'
[    3.399915][    T1] kobject: 'devices' (00000000e7a6afcc): kobject_add_internal: parent: 'workqueue', set: '<NULL>'
[    3.400882][    T1] kobject: 'devices' (00000000e7a6afcc): kobject_uevent_env
[    3.401861][    T1] kobject: 'devices' (00000000e7a6afcc): kobject_uevent_env: filter function caused the event to drop!
[    3.402872][    T1] kobject: 'drivers' (00000000f5a1a00e): kobject_add_internal: parent: 'workqueue', set: '<NULL>'
[    3.403877][    T1] kobject: 'drivers' (00000000f5a1a00e): kobject_uevent_env
[    3.404856][    T1] kobject: 'drivers' (00000000f5a1a00e): kobject_uevent_env: filter function caused the event to drop!
[    3.405903][    T1] bus: 'workqueue': registered
[    3.406895][    T1] device: 'workqueue': device_add
[    3.407643][    T1] kobject: 'workqueue' (0000000036f63526): kobject_add_internal: parent: 'virtual', set: 'devices'
[    3.408053][    T1] PM: Adding info for No Bus:workqueue
[    3.408858][    T1] kobject: 'workqueue' (0000000036f63526): kobject_uevent_env
[    3.409855][    T1] kobject: 'workqueue' (0000000036f63526): kobject_uevent_env: filter function caused the event to drop!
[    3.410903][    T1] kobject: 'kernel' (0000000012b1894a): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.412464][    T1] kobject: 'power' (00000000ee965fd2): kobject_add_internal: parent: '<NULL>', set: '<NULL>'
[    3.413576][    T1] device: 'wakeup0': device_add
[    3.413868][    T1] kobject: 'wakeup0' (0000000085f18f03): kobject_add_internal: parent: 'devices', set: 'devices'
[    3.415067][    T1] kobject: 'wakeup0' (0000000085f18f03): kobject_uevent_env
[    3.415855][    T1] kobject: 'wakeup0' (0000000085f18f03): kobject_uevent_env: filter function caused the event to drop!
[    3.436566][    T1] DMA-API: preallocated 65536 debug entries
[    3.436857][    T1] DMA-API: debugging enabled by kernel config
[    3.437857][    T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.438928][    T1] futex hash table entries: 4096 (order: 7, 524288 bytes, linear)
[    3.441213][    T1] Running postponed tracer tests:
[    3.451866][    T1] Testing tracer function: PASSED
[    4.862853][    T1] Testing dynamic ftrace: PASSED
[    5.201877][    T1] Testing dynamic ftrace ops #1: 
[    5.667592][    T1] (1 0 1 0 0) 
[    5.667856][    T1] (1 1 2 0 0) 
[    6.726153][    T1] (2 1 3 0 5622969) 
[    6.726864][    T1] (2 2 4 0 5625112) PASSED
[    7.433871][    T1] Testing dynamic ftrace ops #2: 
[    8.561410][    T1] (1 0 1 4821797 0) 
[    8.562868][    T1] (1 1 2 4825562 0) 
[   34.207093][   C10] watchdog: BUG: soft lockup - CPU#10 stuck for 22s! [swapper/0:1]
[   34.228096][   C10] Modules linked in:
[   34.230836][   C10] irq event stamp: 2219328
[   34.234025][   C10] hardirqs last  enabled at (2219327): [<ffffffff88ee143e>] on_each_cpu+0xce/0x160
[   34.238286][   C10] hardirqs last disabled at (2219328): [<ffffffff88c0566b>] trace_hardirqs_off_thunk+0x1a/0x1c
[   34.241348][   C10] softirqs last  enabled at (2070462): [<ffffffff8b400510>] __do_softirq+0x510/0x662
[   34.247138][   C10] softirqs last disabled at (2070443): [<ffffffff88d55e26>] irq_exit+0x136/0x140
[   34.251836][   C10] CPU: 10 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc3+ #6
[   34.254836][   C10] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   34.259076][   C10] RIP: 0010:hash_contains_ip.isra.0+0x1f7/0x3b0
[   34.264027][   C10] Code: af e1 fc ff 48 8d 7b 08 e8 56 fa 2e 00 4c 03 63 08 4c 89 e7 e8 4a fa 2e 00 49 8b 1c 24 e8 21 1b ee ff 48 83 05 f1 ba 16 07 01 <48> 85 db 75 61 e8 7f e1 fc ff 48 83 05 ff ba 16 07 01 e8 72 e1 fc
[   34.271836][   C10] RSP: 0018:ffffc900000877f0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[   34.276040][   C10] RAX: 0000000000000001 RBX: ffff88805a4f2580 RCX: dffffc0000000000
[   34.281042][   C10] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88800ed29cc4
[   34.283836][   C10] RBP: ffffffff88c73f10 R08: ffffffff88e70d12 R09: ffffc90000087990
[   34.287836][   C10] R10: fffff52000010f3f R11: ffffc900000879ff R12: ffff88805c469d90
[   34.291376][   C10] R13: ffffc90000087848 R14: 0000000000000000 R15: 0000000000000000
[   34.295453][   C10] FS:  0000000000000000(0000) GS:ffff88805b600000(0000) knlGS:0000000000000000
[   34.299690][   C10] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.303836][   C10] CR2: 00000000ffffffff CR3: 000000004ee3e000 CR4: 00000000003406e0
[   34.306836][   C10] Call Trace:
[   34.309413][   C10]  ftrace_ops_test+0xf2/0x1b0
[   34.311071][   C10]  ? ftrace_free_filter+0x110/0x110
[   34.315366][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.319038][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.322376][   C10]  ? insn_get_sib+0xee/0x170
[   34.324836][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.327346][   C10]  ? __sanitizer_cov_trace_switch+0x50/0x90
[   34.332008][   C10]  ? insn_get_immediate+0x1d4/0x910
[   34.334836][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.337836][   C10]  ? insn_get_length+0x76/0xa0
[   34.340836][   C10]  ? text_poke_sync+0x20/0x20
[   34.342836][   C10]  ftrace_ops_list_func+0x299/0x370
[   34.345836][   C10]  ? ftrace_replace_code+0x15c/0x1d0
[   34.350136][   C10]  ftrace_call+0x5/0x34
[   34.353055][   C10]  ? r8a7740_pinmux_get_bias+0x110/0x110
[   34.356836][   C10]  ? text_poke_loc_init+0x5/0x220
[   34.358836][   C10]  text_poke_loc_init+0x5/0x220
[   34.362734][   C10]  ftrace_replace_code+0x15c/0x1d0
[   34.365836][   C10]  ftrace_modify_all_code+0x251/0x3e0
[   34.368836][   C10]  ftrace_run_update_code+0x41/0x110
[   34.372434][   C10]  ftrace_startup_enable+0x63/0xb0
[   34.374836][   C10]  ftrace_startup+0x191/0x270
[   34.378007][   C10]  register_ftrace_function+0x6b/0xf0
[   34.380446][   C10]  trace_selftest_ops+0x3c6/0x774
[   34.385091][   C10]  trace_selftest_startup_dynamic_tracing.constprop.0+0x35e/0x3a6
[   34.388836][   C10]  ? run_tracer_selftest+0x371/0x371
[   34.392836][   C10]  trace_selftest_startup_function+0x26b/0x79c
[   34.397197][   C10]  ? tracing_set_default_clock+0xd9/0xd9
[   34.402115][   C10]  run_tracer_selftest+0x271/0x371
[   34.405064][   C10]  ? latency_fsnotify_init+0x67/0x67
[   34.407721][   C10]  init_trace_selftests+0xd3/0x2a8
[   34.409836][   C10]  ? register_ftrace_command+0x13a/0x14d
[   34.414085][   C10]  ? latency_fsnotify_init+0x67/0x67
[   34.417028][   C10]  do_one_initcall+0x11b/0x6a0
[   34.420056][   C10]  ? boot_config_checksum+0x80/0x80
[   34.422046][   C10]  ? rcu_read_lock_sched_held+0xa1/0x100
[   34.425836][   C10]  ? rcu_read_lock_bh_held+0xe0/0xe0
[   34.430399][   C10]  ? cpumask_test_cpu.constprop.0+0x46/0x60
[   34.434369][   C10]  kernel_init_freeable+0x3bd/0x49f
[   34.437190][   C10]  ? start_kernel+0xa4b/0xa4b
[   34.440836][   C10]  ? tracer_hardirqs_on+0x3b/0x3c0
[   34.445080][   C10]  ? mark_held_locks+0x23/0x90
[   34.448036][   C10]  ? _raw_spin_unlock_irq+0x24/0x50
[   34.449836][   C10]  ? _raw_spin_unlock_irq+0x24/0x50
[   34.452346][   C10]  ? rest_init+0x346/0x346
[   34.455836][   C10]  kernel_init+0x12/0x1ca
[   34.458836][   C10]  ret_from_fork+0x27/0x50
[   34.463089][   C10] Kernel panic - not syncing: softlockup: hung tasks
[   34.466836][   C10] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G             L    5.6.0-rc3+ #6
[   34.471038][   C10] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   34.475836][   C10] Call Trace:
[   34.476836][   C10]  <IRQ>
[   34.480030][   C10]  dump_stack+0x155/0x1d7
[   34.483077][   C10]  panic+0x266/0x651
[   34.485703][   C10]  ? add_taint.cold+0x16/0x16
[   34.489836][   C10]  ? watchdog_timer_fn.cold+0xcd/0x105
[   34.492836][   C10]  watchdog_timer_fn.cold+0xde/0x105
[   34.496528][   C10]  __hrtimer_run_queues+0x2bd/0xa60
[   34.500040][   C10]  ? __lockup_detector_cleanup+0x70/0x70
[   34.504836][   C10]  ? enqueue_hrtimer+0x2c0/0x2c0
[   34.508836][   C10]  hrtimer_run_queues+0x196/0x200
[   34.512343][   C10]  run_local_timers+0x20/0xa0
[   34.514323][   C10]  update_process_times+0x23/0x70
[   34.517244][   C10]  tick_periodic+0x5c/0x100
[   34.520692][   C10]  tick_handle_periodic+0x30/0xc0
[   34.523836][   C10]  smp_apic_timer_interrupt+0xdb/0x3a0
[   34.523836][   C10]  apic_timer_interrupt+0xf/0x20
[   34.528836][   C10]  </IRQ>
[   34.530836][   C10] RIP: 0010:hash_contains_ip.isra.0+0x1f7/0x3b0
[   34.534670][   C10] Code: af e1 fc ff 48 8d 7b 08 e8 56 fa 2e 00 4c 03 63 08 4c 89 e7 e8 4a fa 2e 00 49 8b 1c 24 e8 21 1b ee ff 48 83 05 f1 ba 16 07 01 <48> 85 db 75 61 e8 7f e1 fc ff 48 83 05 ff ba 16 07 01 e8 72 e1 fc
[   34.542836][   C10] RSP: 0018:ffffc900000877f0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[   34.546427][   C10] RAX: 0000000000000001 RBX: ffff88805a4f2580 RCX: dffffc0000000000
[   34.551367][   C10] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88800ed29cc4
[   34.554195][   C10] RBP: ffffffff88c73f10 R08: ffffffff88e70d12 R09: ffffc90000087990
[   34.557358][   C10] R10: fffff52000010f3f R11: ffffc900000879ff R12: ffff88805c469d90
[   34.562836][   C10] R13: ffffc90000087848 R14: 0000000000000000 R15: 0000000000000000
[   34.565560][    C4] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   34.567836][   C10]  ? text_poke_sync+0x20/0x20
[   34.565836][    C4] rcu: 	10-....: (25642 ticks this GP) idle=c2a/1/0x4000000000000002 softirq=1395/1395 fqs=2024 last_accelerate: 0000/ebba dyntick_enabled: 0
[   34.570982][   C10]  ? debug_lockdep_rcu_enabled+0x42/0x60
[   34.570982][   C10]  ftrace_ops_test+0xf2/0x1b0
[   34.565836][    C4] 	(detected by 4, t=26007 jiffies, g=-1007, q=0)
[   34.574836][   C10]  ? ftrace_free_filter+0x110/0x110
[   34.565836][    C4] Sending NMI from CPU 4 to CPUs 10:
[   34.576836][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4] NMI backtrace for cpu 10
[   34.565836][    C4] CPU: 10 PID: 1 Comm: swapper/0 Tainted: G             L    5.6.0-rc3+ #6
[   34.565836][    C4] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   34.565836][    C4] RIP: 0010:memcpy+0x41/0x50
[   34.565836][    C4] Code: e6 4c 89 ef e8 40 2a 00 00 48 8b 4c 24 18 4c 89 e6 48 89 ef ba 01 00 00 00 e8 2b 2a 00 00 4c 89 e2 4c 89 ee 48 89 ef 5d 41 5c <41> 5d e9 78 30 e5 01 0f 1f 84 00 00 00 00 00 48 b9 00 00 00 00 00
[   34.565836][    C4] RSP: 0018:ffffc90000658758 EFLAGS: 00000046
[   34.565836][    C4] RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff8b0bddc5
[   34.565836][    C4] RDX: 0000000000000001 RSI: ffffffff8b6bc9c5 RDI: ffffc9000065899e
[   34.565836][    C4] RBP: ffffc9000065899e R08: 0000000000000001 R09: fffff520000cb134
[   34.565836][    C4] R10: fffff520000cb133 R11: ffffc9000065899e R12: ffffffff8b6bc9c5
[   34.565836][    C4] R13: ffffffff8b6bc9c5 R14: ffffc90000658858 R15: 0000000000000001
[   34.565836][    C4] FS:  0000000000000000(0000) GS:ffff88805b600000(0000) knlGS:0000000000000000
[   34.565836][    C4] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.565836][    C4] CR2: 00000000ffffffff CR3: 000000004ee3e000 CR4: 00000000003406e0
[   34.565836][    C4] Call Trace:
[   34.565836][    C4]  <IRQ>
[   34.565836][    C4]  vsnprintf+0x555/0xb30
[   34.565836][    C4]  ? pointer+0x6a0/0x6a0
[   34.565836][    C4]  ? ftrace_ops_test+0x10f/0x1b0
[   34.565836][    C4]  ? ftrace_free_filter+0x110/0x110
[   34.565836][    C4]  sprintf+0xc0/0x100
[   34.565836][    C4]  ? scnprintf+0x140/0x140
[   34.565836][    C4]  ? check_prev_add+0xfe0/0xfe0
[   34.565836][    C4]  ? sched_clock_local+0x99/0xc0
[   34.565836][    C4]  ? check_chain_key+0x1d8/0x2d0
[   34.565836][    C4]  msg_print_text+0x3a7/0x3c0
[   34.565836][    C4]  ? msg_print_ext_body+0x300/0x300
[   34.565836][    C4]  ? ftrace_call+0x5/0x34
[   34.565836][    C4]  ? lock_contended+0x720/0x720
[   34.565836][    C4]  console_unlock+0x300/0xbd0
[   34.565836][    C4]  vprintk_emit+0x364/0x6a0
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  vprintk_default+0x4f/0xa0
[   34.565836][    C4]  vprintk_func+0x7a/0x118
[   34.565836][    C4]  printk+0xbf/0xf2
[   34.565836][    C4]  ? kmsg_dump_rewind+0x17b/0x17b
[   34.565836][    C4]  ? unwind_get_return_address_ptr+0xe/0x48
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  show_trace_log_lvl+0x273/0x30f
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  ? ftrace_ops_list_func+0x299/0x370
[   34.565836][    C4]  dump_stack+0x155/0x1d7
[   34.565836][    C4]  panic+0x266/0x651
[   34.565836][    C4]  ? add_taint.cold+0x16/0x16
[   34.565836][    C4]  ? watchdog_timer_fn.cold+0xcd/0x105
[   34.565836][    C4]  watchdog_timer_fn.cold+0xde/0x105
[   34.565836][    C4]  __hrtimer_run_queues+0x2bd/0xa60
[   34.565836][    C4]  ? __lockup_detector_cleanup+0x70/0x70
[   34.565836][    C4]  ? enqueue_hrtimer+0x2c0/0x2c0
[   34.565836][    C4]  hrtimer_run_queues+0x196/0x200
[   34.565836][    C4]  run_local_timers+0x20/0xa0
[   34.565836][    C4]  update_process_times+0x23/0x70
[   34.565836][    C4]  tick_periodic+0x5c/0x100
[   34.565836][    C4]  tick_handle_periodic+0x30/0xc0
[   34.565836][    C4]  smp_apic_timer_interrupt+0xdb/0x3a0
[   34.565836][    C4]  apic_timer_interrupt+0xf/0x20
[   34.565836][    C4]  </IRQ>
[   34.565836][    C4] RIP: 0010:hash_contains_ip.isra.0+0x1f7/0x3b0
[   34.565836][    C4] Code: af e1 fc ff 48 8d 7b 08 e8 56 fa 2e 00 4c 03 63 08 4c 89 e7 e8 4a fa 2e 00 49 8b 1c 24 e8 21 1b ee ff 48 83 05 f1 ba 16 07 01 <48> 85 db 75 61 e8 7f e1 fc ff 48 83 05 ff ba 16 07 01 e8 72 e1 fc
[   34.565836][    C4] RSP: 0018:ffffc900000877f0 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[   34.565836][    C4] RAX: 0000000000000001 RBX: ffff88805a4f2580 RCX: dffffc0000000000
[   34.565836][    C4] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88800ed29cc4
[   34.565836][    C4] RBP: ffffffff88c73f10 R08: ffffffff88e70d12 R09: ffffc90000087990
[   34.565836][    C4] R10: fffff52000010f3f R11: ffffc900000879ff R12: ffff88805c469d90
[   34.565836][    C4] R13: ffffc90000087848 R14: 0000000000000000 R15: 0000000000000000
[   34.565836][    C4]  ? text_poke_sync+0x20/0x20
[   34.565836][    C4]  ? debug_lockdep_rcu_enabled+0x42/0x60
[   34.565836][    C4]  ftrace_ops_test+0xf2/0x1b0
[   34.565836][    C4]  ? ftrace_free_filter+0x110/0x110
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  ? insn_get_sib+0xee/0x170
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  ? __sanitizer_cov_trace_switch+0x50/0x90
[   34.565836][    C4]  ? insn_get_immediate+0x1d4/0x910
[   34.565836][    C4]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.565836][    C4]  ? insn_get_length+0x76/0xa0
[   34.565836][    C4]  ? text_poke_sync+0x20/0x20
[   34.565836][    C4]  ftrace_ops_list_func+0x299/0x370
[   34.565836][    C4]  ? ftrace_replace_code+0x15c/0x1d0
[   34.565836][    C4]  ftrace_call+0x5/0x34
[   34.565836][    C4]  ? r8a7740_pinmux_get_bias+0x110/0x110
[   34.565836][    C4]  ? text_poke_loc_init+0x5/0x220
[   34.565836][    C4]  text_poke_loc_init+0x5/0x220
[   34.565836][    C4]  ftrace_replace_code+0x15c/0x1d0
[   34.565836][    C4]  ftrace_modify_all_code+0x251/0x3e0
[   34.565836][    C4]  ftrace_run_update_code+0x41/0x110
[   34.565836][    C4]  ftrace_startup_enable+0x63/0xb0
[   34.565836][    C4]  ftrace_startup+0x191/0x270
[   34.565836][    C4]  register_ftrace_function+0x6b/0xf0
[   34.565836][    C4]  trace_selftest_ops+0x3c6/0x774
[   34.565836][    C4]  trace_selftest_startup_dynamic_tracing.constprop.0+0x35e/0x3a6
[   34.565836][    C4]  ? run_tracer_selftest+0x371/0x371
[   34.565836][    C4]  trace_selftest_startup_function+0x26b/0x79c
[   34.565836][    C4]  ? tracing_set_default_clock+0xd9/0xd9
[   34.565836][    C4]  run_tracer_selftest+0x271/0x371
[   34.565836][    C4]  ? latency_fsnotify_init+0x67/0x67
[   34.565836][    C4]  init_trace_selftests+0xd3/0x2a8
[   34.565836][    C4]  ? register_ftrace_command+0x13a/0x14d
[   34.565836][    C4]  ? latency_fsnotify_init+0x67/0x67
[   34.565836][    C4]  do_one_initcall+0x11b/0x6a0
[   34.565836][    C4]  ? boot_config_checksum+0x80/0x80
[   34.565836][    C4]  ? rcu_read_lock_sched_held+0xa1/0x100
[   34.565836][    C4]  ? rcu_read_lock_bh_held+0xe0/0xe0
[   34.565836][    C4]  ? cpumask_test_cpu.constprop.0+0x46/0x60
[   34.565836][    C4]  kernel_init_freeable+0x3bd/0x49f
[   34.565836][    C4]  ? start_kernel+0xa4b/0xa4b
[   34.565836][    C4]  ? tracer_hardirqs_on+0x3b/0x3c0
[   34.565836][    C4]  ? mark_held_locks+0x23/0x90
[   34.565836][    C4]  ? _raw_spin_unlock_irq+0x24/0x50
[   34.565836][    C4]  ? _raw_spin_unlock_irq+0x24/0x50
[   34.565836][    C4]  ? rest_init+0x346/0x346
[   34.565836][    C4]  kernel_init+0x12/0x1ca
[   34.565836][    C4]  ret_from_fork+0x27/0x50
[   34.565836][    C4] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 0.000 msecs
[   34.891009][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.894032][   C10]  ? insn_get_sib+0xee/0x170
[   34.895836][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.899381][   C10]  ? __sanitizer_cov_trace_switch+0x50/0x90
[   34.901075][   C10]  ? insn_get_immediate+0x1d4/0x910
[   34.906141][   C10]  ? r8a73a4_pinmux_set_bias+0xb0/0xb0
[   34.909371][   C10]  ? insn_get_length+0x76/0xa0
[   34.913366][   C10]  ? text_poke_sync+0x20/0x20
[   34.915076][   C10]  ftrace_ops_list_func+0x299/0x370
[   34.918101][   C10]  ? ftrace_replace_code+0x15c/0x1d0
[   34.921836][   C10]  ftrace_call+0x5/0x34
[   34.925836][   C10]  ? r8a7740_pinmux_get_bias+0x110/0x110
[   34.929439][   C10]  ? text_poke_loc_init+0x5/0x220
[   34.932348][   C10]  text_poke_loc_init+0x5/0x220
[   34.934371][   C10]  ftrace_replace_code+0x15c/0x1d0
[   34.938836][   C10]  ftrace_modify_all_code+0x251/0x3e0
[   34.941836][   C10]  ftrace_run_update_code+0x41/0x110
[   34.944836][   C10]  ftrace_startup_enable+0x63/0xb0
[   34.947836][   C10]  ftrace_startup+0x191/0x270
[   34.949370][   C10]  register_ftrace_function+0x6b/0xf0
[   34.954077][   C10]  trace_selftest_ops+0x3c6/0x774
[   34.958379][   C10]  trace_selftest_startup_dynamic_tracing.constprop.0+0x35e/0x3a6
[   34.961836][   C10]  ? run_tracer_selftest+0x371/0x371
[   34.966010][   C10]  trace_selftest_startup_function+0x26b/0x79c
[   34.970024][   C10]  ? tracing_set_default_clock+0xd9/0xd9
[   34.975371][   C10]  run_tracer_selftest+0x271/0x371
[   34.977836][   C10]  ? latency_fsnotify_init+0x67/0x67
[   34.980109][   C10]  init_trace_selftests+0xd3/0x2a8
[   34.983836][   C10]  ? register_ftrace_command+0x13a/0x14d
[   34.986378][   C10]  ? latency_fsnotify_init+0x67/0x67
[   34.990073][   C10]  do_one_initcall+0x11b/0x6a0
[   34.993078][   C10]  ? boot_config_checksum+0x80/0x80
[   34.995836][   C10]  ? rcu_read_lock_sched_held+0xa1/0x100
[   34.998836][   C10]  ? rcu_read_lock_bh_held+0xe0/0xe0
[   35.003098][   C10]  ? cpumask_test_cpu.constprop.0+0x46/0x60
[   35.007035][   C10]  kernel_init_freeable+0x3bd/0x49f
[   35.010083][   C10]  ? start_kernel+0xa4b/0xa4b
[   35.014836][   C10]  ? tracer_hardirqs_on+0x3b/0x3c0
[   35.016836][   C10]  ? mark_held_locks+0x23/0x90
[   35.020029][   C10]  ? _raw_spin_unlock_irq+0x24/0x50
[   35.023084][   C10]  ? _raw_spin_unlock_irq+0x24/0x50
[   35.025836][   C10]  ? rest_init+0x346/0x346
[   35.028388][   C10]  kernel_init+0x12/0x1ca
[   35.031836][   C10]  ret_from_fork+0x27/0x50
[   35.038442][   C10] ---[ end Kernel panic - not syncing: softlockup: hung tasks ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC23EC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7104C2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587994905;
	bh=8zgvJjIQPDDu+nEMFC15PiOYWCc81YKOdvulBnqImLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e1nRhewg4gwMvr3pbZin1gqHWIDalJCP0tSjFP+YD9jEp1I0Gxrtn+FpOjqIru7cv
	 7o+kYaE4qWTv7U+4XeNLfis6uKYDhaIiFDoXCdWEXUF+PLV4m4RMOPSBEpNYl7c/W7
	 6YYK11qu0C/EzqgIrHbOEWb+SWUoN7goMfRSvbuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgD0Nlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgD0Nlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:41:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8E5F206B6;
        Mon, 27 Apr 2020 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587994894;
        bh=8zgvJjIQPDDu+nEMFC15PiOYWCc81YKOdvulBnqImLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyNMQdNu9qWKg2qwTHICNtEsl62q6UuB+awbD8Wf/CR5dBeLPLTWQIbkQodByUupW
         RsnTiHffiP9ueSiuiBI9IjMoBqAoeTVc5Tgu1JE5rQSnj7CtVhHm+NqOTejnM3u4NI
         MU0Qvh6PKrrbGOQwt1i36UbdZWdKB3EgWhfLtdkQ=
Date:   Mon, 27 Apr 2020 16:41:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200427134130.GE134660@unreal>
References: <20200407170925.1775019-1-leon@kernel.org>
 <20200414054836.GA956407@unreal>
 <20200414062454.GA84326@gmail.com>
 <87tv15qj5u.fsf@nanos.tec.linutronix.de>
 <20200427113218.GB134660@unreal>
 <87h7x5qe3v.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <87h7x5qe3v.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2020 at 02:59:00PM +0200, Thomas Gleixner wrote:
> Leon Romanovsky <leon@kernel.org> writes:
> > On Mon, Apr 27, 2020 at 01:09:49PM +0200, Thomas Gleixner wrote:
> >> The local APIC timer (in this case the TSC deadline timer) is set up
> >> during early boot on the boot CPU (before SMP setup) with this call
> >> chain:
> >>
> >> smp_prepare_cpus()
> >>  native_smp_prepare_cpus()
> >>    x86_init.timers.setup_percpu_clockev()
> >>      setup_boot_APIC_clock()
> >>        setup_APIC_timer()
> >>          clockevents_config_and_register()
> >>            tick_check_new_device()
> >>              tick_setup_device()
> >>                tick_setup_oneshot()
> >>                  clockevents_switch_state()
> >>                    lapic_timer_set_oneshot()
> >>                      __setup_APIC_LVTT()
> >>                        printk_once(...)
> >>
> >> Nothing holds hrtimer.base_lock in this call chain.
> >
> > Can't printk hold that lock through console/netconsole?
>
> How so?

OK, I consulted with verification people and back then the trigger was:
Reproduce when run "echo 1 > /sys/kernel/debug/clear_warn_once" after reboot

>
> The lockdep splat is about this:
>
>  [  735.324154] swapper/3/0 is trying to acquire lock:
>  [  735.324155] ffffffff8442c858 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x13/0x70
>  [  735.324162]
>  [  735.324164] but task is already holding lock:
>  [  735.324165] ffff88842dfb9958 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base+0x71/0x120
>
> and the call chain is:
>
>  [  735.324283]        __lock_acquire+0x374a/0x5210
>  [  735.324284]        lock_acquire+0x1b9/0x920
>  [  735.324286]        _raw_spin_lock_irqsave+0x3c/0x4b
>  [  735.324288]        down_trylock+0x13/0x70
>  [  735.324289]        __down_trylock_console_sem+0x33/0xa0
>  [  735.324291]        console_trylock+0x13/0x60
>  [  735.324292]        vprintk_emit+0xec/0x370
>  [  735.324294]        printk+0x9c/0xc3
>  [  735.324296]        lapic_timer_set_oneshot+0x4e/0x60
>  [  735.324297]        clockevents_switch_state+0x1e1/0x360
>  [  735.324299]        tick_program_event+0xae/0xc0
>  [  735.324301]        hrtimer_start_range_ns+0x4b6/0xaa0
>  [  735.324302]        tick_nohz_idle_stop_tick+0x67c/0xa90
>  [  735.324304]        do_idle+0x326/0x530
>  [  735.324305]        cpu_startup_entry+0x19/0x20
>  [  735.324307]        start_secondary+0x2ee/0x3e0
>  [  735.324309]        secondary_startup_64+0xa4/0xb0
>
> hrtimer_start_range_ns() clearly holds htimer_base::lock
>
> >> But the lockdep splat clearly says:
> >>
> >>  [  735.324357] stack backtrace:
> >>  [  735.324360] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1
> >>
> >> ...
> >>
> >> So how can that be the first invocation of that printk_once()?
> >>
> >> While the patch looks innocent, it papers over the underlying problem
> >> and wild theories are not really helping here.
> >>
> >> Here is a boot log excerpt with lockdep enabled and 'debug' on the
> >> command line:
> >>
> >> [    0.000000] Linux version 5.7.0-rc3 ...
> >> ...
> >> [    3.992125] TSC deadline timer enabled
> >> [    3.995820] smpboot: CPU0: Intel(R) ....
> >> ...
> >> [    4.050766] smp: Bringing up secondary CPUs ...
> >>
> >> No splat nothing. The real question is WHY this triggers on Leons
> >> machine 735 seconds after boot and on CPU3.
> >
> > I want to believe that the timestamp are not correct, have no clue if it
> > is even possible.
>
> It does not matter whether the timestamps are correct or not. Even if
> they are not, then this does not change the fact that this happens on
> CPU3 way after the first invocation of __setup_APIC_LVTT() on CPU0 which
> simply cannot trigger this splat.
>
> Can you please provide the full dmesg with the splat?

Attached

>
> > But let's talk about facts:
> > 1. It is started after -rc1 (we don't test linux-next).
>
> Is that a plain kernel from Linus tree or do you have other patches
> applied?

It is clean one.

>
> A .config file would be appreciated as well along with information about
> the hardware or whatever this runs on.

This is passthrough VM with Mellanox NICs in it, everything else is
virtual.

>
> > 2. This workaround helped to eliminate the splat.
>
> It's eliminating the symptom, but this does not make the root cause go
> away nor does it explain anything.
>
> > 3. My machine experiences the extra splat all the time
> > https://lore.kernel.org/lkml/20200414070502.GR334007@unreal/
>
> which is completely unrelated.
>
> Thanks,
>
>         tglx

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=bug_2131735

[    0.000000] Linux version 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 (jenkins@281120a7fa96) (gcc version 7.3.1 20180130 (Red Hat 7.3.1-2) (GCC)) #1 SMP Fri Apr 3 07:53:30 UTC 2020
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 root=UUID=d6ebbea4-17a0-43ef-b491-695fef2aeb1c ro net.ifnames=0 biosdevname=0 console=tty0 console=ttyS1,115200 audit=0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.000000] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.000000] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.000000] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    0.000000] x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffddfff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ffde000-0x000000007fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000001] kvm-clock: cpu 0, msr 599c001, primary cpu clock
[    0.000001] kvm-clock: using sched offset of 25664996450613 cycles
[    0.000013] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000029] tsc: Detected 2294.614 MHz processor
[    0.002225] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002229] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.002237] last_pfn = 0x480000 max_arch_pfn = 0x400000000
[    0.002280] MTRR default type: write-back
[    0.002282] MTRR fixed ranges enabled:
[    0.002285]   00000-9FFFF write-back
[    0.002288]   A0000-BFFFF uncachable
[    0.002291]   C0000-FFFFF write-protect
[    0.002293] MTRR variable ranges enabled:
[    0.002296]   0 base 00C0000000 mask FFC0000000 uncachable
[    0.002298]   1 disabled
[    0.002301]   2 disabled
[    0.002303]   3 disabled
[    0.002305]   4 disabled
[    0.002307]   5 disabled
[    0.002309]   6 disabled
[    0.002311]   7 disabled
[    0.002335] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002355] last_pfn = 0x7ffde max_arch_pfn = 0x400000000
[    0.004933] Using GB pages for direct mapping
[    0.004945] BRK [0x07401000, 0x07401fff] PGTABLE
[    0.004948] BRK [0x07402000, 0x07402fff] PGTABLE
[    0.004951] BRK [0x07403000, 0x07403fff] PGTABLE
[    0.005567] RAMDISK: [mem 0x362f1000-0x37170fff]
[    0.005588] ACPI: Early table checksum verification disabled
[    0.005620] ACPI: RSDP 0x00000000000F59F0 000014 (v00 BOCHS )
[    0.005629] ACPI: RSDT 0x000000007FFE2014 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.005648] ACPI: FACP 0x000000007FFE1DEC 0000F4 (v03 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.005667] ACPI: DSDT 0x000000007FFDFC40 0021AC (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.005675] ACPI: FACS 0x000000007FFDFC00 000040
[    0.005683] ACPI: APIC 0x000000007FFE1EE0 0000C0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.005691] ACPI: HPET 0x000000007FFE1FA0 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.005699] ACPI: MCFG 0x000000007FFE1FD8 00003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
[    0.005719] ACPI: Local APIC address 0xfee00000
[    0.006053] No NUMA configuration found
[    0.006057] Faking a node at [mem 0x0000000000000000-0x000000047fffffff]
[    0.006093] NODE_DATA(0) allocated [mem 0x47ffdc000-0x47fffdfff]
[    0.006219] Zone ranges:
[    0.006223]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.006228]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.006232]   Normal   [mem 0x0000000100000000-0x000000047fffffff]
[    0.006236] Movable zone start for each node
[    0.006243] Early memory node ranges
[    0.006247]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.006251]   node   0: [mem 0x0000000000100000-0x000000007ffddfff]
[    0.006255]   node   0: [mem 0x0000000100000000-0x000000047fffffff]
[    0.006279] Zeroed struct page in unavailable ranges: 132 pages
[    0.006281] Initmem setup node 0 [mem 0x0000000000001000-0x000000047fffffff]
[    0.006287] On node 0 totalpages: 4194172
[    0.006293]   DMA zone: 64 pages used for memmap
[    0.006295]   DMA zone: 21 pages reserved
[    0.006298]   DMA zone: 3998 pages, LIFO batch:0
[    0.006479]   DMA32 zone: 8128 pages used for memmap
[    0.006481]   DMA32 zone: 520158 pages, LIFO batch:63
[    0.027897]   Normal zone: 57344 pages used for memmap
[    0.027901]   Normal zone: 3670016 pages, LIFO batch:63
[    0.398641] kasan: KernelAddressSanitizer initialized
[    0.401443] ACPI: PM-Timer IO Port: 0x608
[    0.401451] ACPI: Local APIC address 0xfee00000
[    0.401473] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.401538] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.401553] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.401559] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.401563] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.401573] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.401578] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.401583] ACPI: IRQ0 used by override.
[    0.401586] ACPI: IRQ5 used by override.
[    0.401589] ACPI: IRQ9 used by override.
[    0.401592] ACPI: IRQ10 used by override.
[    0.401594] ACPI: IRQ11 used by override.
[    0.401599] Using ACPI (MADT) for SMP configuration information
[    0.401604] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.401626] smpboot: Allowing 10 CPUs, 0 hotplug CPUs
[    0.401658] KVM setup pv remote TLB flush
[    0.401713] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.401719] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.401723] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.401727] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.401733] PM: hibernation: Registered nosave memory: [mem 0x7ffde000-0x7fffffff]
[    0.401737] PM: hibernation: Registered nosave memory: [mem 0x80000000-0xafffffff]
[    0.401741] PM: hibernation: Registered nosave memory: [mem 0xb0000000-0xbfffffff]
[    0.401745] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfed1bfff]
[    0.401749] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.401752] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfeffbfff]
[    0.401756] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.401760] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.401764] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.401775] [mem 0xc0000000-0xfed1bfff] available for PCI devices
[    0.401779] Booting paravirtualized kernel on KVM
[    0.401794] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.446614] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:10 nr_node_ids:1
[    0.447773] percpu: Embedded 82 pages/cpu s296464 r8192 d31216 u524288
[    0.447805] pcpu-alloc: s296464 r8192 d31216 u524288 alloc=1*2097152
[    0.447808] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.447816] pcpu-alloc: [0] 08 09 -- -- 
[    0.447878] KVM setup async PF for cpu 0
[    0.447886] kvm-stealtime: cpu 0, msr 42de22a80
[    0.447910] Built 1 zonelists, mobility grouping on.  Total pages: 4128615
[    0.447914] Policy zone: Normal
[    0.447920] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 root=UUID=d6ebbea4-17a0-43ef-b491-695fef2aeb1c ro net.ifnames=0 biosdevname=0 console=tty0 console=ttyS1,115200 audit=0
[    0.448205] audit: disabled (until reboot)
[    0.449936] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.450862] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.451077] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.694475] Memory: 14178092K/16776688K available (38916K kernel code, 15192K rwdata, 8212K rodata, 2748K init, 27204K bss, 2598596K reserved, 0K cma-reserved)
[    0.695842] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=10, Nodes=1
[    0.696122] Kernel/User page tables isolation: enabled
[    0.696242] ftrace: allocating 39452 entries in 155 pages
[    0.719655] ftrace: allocated 155 pages with 5 groups
[    0.720860] Running RCU self tests
[    0.720869] rcu: Hierarchical RCU implementation.
[    0.720873] rcu: 	RCU event tracing is enabled.
[    0.720876] rcu: 	RCU lockdep checking is enabled.
[    0.720883] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=10.
[    0.720889] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.720893] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=10
[    0.732329] NR_IRQS: 33024, nr_irqs: 504, preallocated irqs: 16
[    0.733272] random: get_random_bytes called from start_kernel+0x3bb/0x6ed with crng_init=0
[    0.750313] Console: colour VGA+ 80x25
[    0.801061] printk: console [tty0] enabled
[    0.888177] printk: console [ttyS1] enabled
[    0.888983] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.890409] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.891207] ... MAX_LOCK_DEPTH:          48
[    0.892025] ... MAX_LOCKDEP_KEYS:        8192
[    0.892861] ... CLASSHASH_SIZE:          4096
[    0.893674] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.894494] ... MAX_LOCKDEP_CHAINS:      65536
[    0.895321] ... CHAINHASH_SIZE:          32768
[    0.896153]  memory used by lock dependency info: 6301 kB
[    0.897103]  memory used for stack traces: 4224 kB
[    0.897980]  per task-struct memory footprint: 1920 bytes
[    0.899258] ACPI: Core revision 20200214
[    0.901057] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.902823] APIC: Switch to symmetric I/O mode setup
[    0.904077] x2apic enabled
[    0.904974] Switched APIC routing to physical x2apic.
[    0.905939] KVM setup pv IPIs
[    0.908175] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.909259] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x211354f4cc6, max_idle_ns: 440795207008 ns
[    0.911120] Calibrating delay loop (skipped) preset value.. 4589.22 BogoMIPS (lpj=2294614)
[    0.912110] pid_max: default: 32768 minimum: 301
[    0.914876] LSM: Security Framework initializing
[    0.915335] SELinux:  Initializing.
[    0.917291] *** VALIDATE selinux ***
[    0.918379] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.919157] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.921263] *** VALIDATE tmpfs ***
[    0.924393] *** VALIDATE proc ***
[    0.926406] *** VALIDATE cgroup ***
[    0.927112] *** VALIDATE cgroup2 ***
[    0.928176] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.929239] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.930109] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.931116] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.932110] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    0.932112] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.934118] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.935109] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.937310] Freeing SMP alternatives memory: 32K
[    0.940471] TSC deadline timer enabled
[    0.940491] smpboot: CPU0: Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.942049] Performance Events: Skylake events, Intel PMU driver.
[    0.942130] ... version:                2
[    0.943112] ... bit width:              48
[    0.944111] ... generic registers:      4
[    0.945112] ... value mask:             0000ffffffffffff
[    0.946112] ... max period:             000000007fffffff
[    0.947111] ... fixed-purpose events:   3
[    0.948111] ... event mask:             000000070000000f
[    0.949519] rcu: Hierarchical SRCU implementation.
[    0.953374] smp: Bringing up secondary CPUs ...
[    0.955315] x86: Booting SMP configuration:
[    0.956116] .... node  #0, CPUs:        #1
[    0.173935] kvm-clock: cpu 1, msr 599c041, secondary cpu clock
[    0.173935] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.963260] KVM setup async PF for cpu 1
[    0.964103] kvm-stealtime: cpu 1, msr 42dea2a80
[    0.966516]   #2
[    0.173935] kvm-clock: cpu 2, msr 599c081, secondary cpu clock
[    0.173935] smpboot: CPU 2 Converting physical 0 to logical die 2
[    0.972195] KVM setup async PF for cpu 2
[    0.973103] kvm-stealtime: cpu 2, msr 42df22a80
[    0.975272]   #3
[    0.173935] kvm-clock: cpu 3, msr 599c0c1, secondary cpu clock
[    0.173935] smpboot: CPU 3 Converting physical 0 to logical die 3
[    0.981219] KVM setup async PF for cpu 3
[    0.982103] kvm-stealtime: cpu 3, msr 42dfa2a80
[    0.984408]   #4
[    0.173935] kvm-clock: cpu 4, msr 599c101, secondary cpu clock
[    0.173935] smpboot: CPU 4 Converting physical 0 to logical die 4
[    0.990206] KVM setup async PF for cpu 4
[    0.991103] kvm-stealtime: cpu 4, msr 42e022a80
[    0.995764]   #5
[    0.173935] kvm-clock: cpu 5, msr 599c141, secondary cpu clock
[    0.173935] smpboot: CPU 5 Converting physical 0 to logical die 5
[    1.002202] KVM setup async PF for cpu 5
[    1.003103] kvm-stealtime: cpu 5, msr 42e0a2a80
[    1.005239]   #6
[    0.173935] kvm-clock: cpu 6, msr 599c181, secondary cpu clock
[    0.173935] smpboot: CPU 6 Converting physical 0 to logical die 6
[    1.011192] KVM setup async PF for cpu 6
[    1.012103] kvm-stealtime: cpu 6, msr 42e122a80
[    1.014267]   #7
[    0.173935] kvm-clock: cpu 7, msr 599c1c1, secondary cpu clock
[    0.173935] smpboot: CPU 7 Converting physical 0 to logical die 7
[    1.020195] KVM setup async PF for cpu 7
[    1.021103] kvm-stealtime: cpu 7, msr 42e1a2a80
[    1.023314]   #8
[    0.173935] kvm-clock: cpu 8, msr 599c201, secondary cpu clock
[    0.173935] smpboot: CPU 8 Converting physical 0 to logical die 8
[    1.029212] KVM setup async PF for cpu 8
[    1.030103] kvm-stealtime: cpu 8, msr 42e222a80
[    1.032424]   #9
[    0.173935] kvm-clock: cpu 9, msr 599c241, secondary cpu clock
[    0.173935] smpboot: CPU 9 Converting physical 0 to logical die 9
[    1.038200] KVM setup async PF for cpu 9
[    1.039103] kvm-stealtime: cpu 9, msr 42e2a2a80
[    1.040367] smp: Brought up 1 node, 10 CPUs
[    1.041114] smpboot: Max logical packages: 10
[    1.042120] smpboot: Total of 10 processors activated (45892.28 BogoMIPS)
[    1.049809] devtmpfs: initialized
[    1.050960] x86/mm: Memory block size: 128MB
[    1.091201] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.092738] futex hash table entries: 4096 (order: 7, 524288 bytes, linear)
[    1.095407] thermal_sys: Registered thermal governor 'fair_share'
[    1.095409] thermal_sys: Registered thermal governor 'bang_bang'
[    1.096116] thermal_sys: Registered thermal governor 'step_wise'
[    1.097113] thermal_sys: Registered thermal governor 'user_space'
[    1.100212] NET: Registered protocol family 16
[    1.105565] cpuidle: using governor menu
[    1.106630] ACPI: bus type PCI registered
[    1.108103] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000000-0xbfffffff] (base 0xb0000000)
[    1.109167] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in E820
[    1.110194] PCI: Using configuration type 1 for base access
[    1.157410] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    1.158539] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    1.219204] cryptd: max_cpu_qlen set to 1000
[    1.274150] ACPI: Added _OSI(Module Device)
[    1.276163] ACPI: Added _OSI(Processor Device)
[    1.278141] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.280121] ACPI: Added _OSI(Processor Aggregator Device)
[    1.282160] ACPI: Added _OSI(Linux-Dell-Video)
[    1.283144] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    1.285129] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    1.361730] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    1.377763] ACPI: Interpreter enabled
[    1.379330] ACPI: (supports S0 S3 S4 S5)
[    1.380113] ACPI: Using IOAPIC for interrupt routing
[    1.382530] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.387159] ACPI: Enabled 1 GPEs in block 00 to 3F
[    1.484822] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.485160] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    1.491006] acpi PNP0A08:00: _OSC: platform does not support [LTR]
[    1.495630] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
[    1.498186] PCI host bridge to bus 0000:00
[    1.499207] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    1.500126] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    1.501125] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    1.502124] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[    1.503124] pci_bus 0000:00: root bus resource [mem 0x480000000-0xc7fffffff window]
[    1.504127] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.505348] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
[    1.508420] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000
[    1.511119] pci 0000:00:01.0: reg 0x10: [mem 0xfc000000-0xfcffffff pref]
[    1.516118] pci 0000:00:01.0: reg 0x18: [mem 0xfea10000-0xfea10fff]
[    1.523118] pci 0000:00:01.0: reg 0x30: [mem 0xfea00000-0xfea0ffff pref]
[    1.525911] pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400
[    1.527668] pci 0000:00:02.0: reg 0x10: [mem 0xfea11000-0xfea11fff]
[    1.533388] pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400
[    1.535712] pci 0000:00:02.1: reg 0x10: [mem 0xfea12000-0xfea12fff]
[    1.540788] pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400
[    1.542737] pci 0000:00:02.2: reg 0x10: [mem 0xfea13000-0xfea13fff]
[    1.548382] pci 0000:00:02.3: [1b36:000c] type 01 class 0x060400
[    1.550700] pci 0000:00:02.3: reg 0x10: [mem 0xfea14000-0xfea14fff]
[    1.556383] pci 0000:00:02.4: [1b36:000c] type 01 class 0x060400
[    1.558665] pci 0000:00:02.4: reg 0x10: [mem 0xfea15000-0xfea15fff]
[    1.563951] pci 0000:00:08.0: [15b3:1017] type 00 class 0x020000
[    1.565118] pci 0000:00:08.0: reg 0x10: [mem 0xf8000000-0xf9ffffff 64bit pref]
[    1.572902] pci 0000:00:08.0: PME# supported from D3cold
[    1.575415] pci 0000:00:08.1: [15b3:1017] type 00 class 0x020000
[    1.577118] pci 0000:00:08.1: reg 0x10: [mem 0xfa000000-0xfbffffff 64bit pref]
[    1.584891] pci 0000:00:08.1: PME# supported from D3cold
[    1.586770] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
[    1.587503] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
[    1.589755] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
[    1.595117] pci 0000:00:1f.2: reg 0x20: [io  0xc040-0xc05f]
[    1.597737] pci 0000:00:1f.2: reg 0x24: [mem 0xfea16000-0xfea16fff]
[    1.600342] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
[    1.603672] pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
[    1.618639] pci 0000:01:00.0: [1b36:000d] type 00 class 0x0c0330
[    1.619747] pci 0000:01:00.0: reg 0x10: [mem 0xfe800000-0xfe803fff 64bit]
[    1.624305] pci 0000:00:02.0: PCI bridge to [bus 01]
[    1.625138] pci 0000:00:02.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    1.626134] pci 0000:00:02.0:   bridge window [mem 0xfd800000-0xfd9fffff 64bit pref]
[    1.628287] pci 0000:02:00.0: [1af4:1042] type 00 class 0x010000
[    1.631742] pci 0000:02:00.0: reg 0x14: [mem 0xfe600000-0xfe600fff]
[    1.635118] pci 0000:02:00.0: reg 0x20: [mem 0xfd600000-0xfd603fff 64bit pref]
[    1.638537] pci 0000:00:02.1: PCI bridge to [bus 02]
[    1.639139] pci 0000:00:02.1:   bridge window [mem 0xfe600000-0xfe7fffff]
[    1.640135] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd7fffff 64bit pref]
[    1.642251] pci 0000:03:00.0: [1af4:1045] type 00 class 0x00ff00
[    1.645676] pci 0000:03:00.0: reg 0x20: [mem 0xfd400000-0xfd403fff 64bit pref]
[    1.648009] pci 0000:00:02.2: PCI bridge to [bus 03]
[    1.648139] pci 0000:00:02.2:   bridge window [mem 0xfe400000-0xfe5fffff]
[    1.649134] pci 0000:00:02.2:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
[    1.651280] pci 0000:04:00.0: [1af4:1041] type 00 class 0x020000
[    1.654117] pci 0000:04:00.0: reg 0x14: [mem 0xfe240000-0xfe240fff]
[    1.658117] pci 0000:04:00.0: reg 0x20: [mem 0xfd200000-0xfd203fff 64bit pref]
[    1.661118] pci 0000:04:00.0: reg 0x30: [mem 0xfe200000-0xfe23ffff pref]
[    1.663515] pci 0000:00:02.3: PCI bridge to [bus 04]
[    1.664138] pci 0000:00:02.3:   bridge window [mem 0xfe200000-0xfe3fffff]
[    1.665135] pci 0000:00:02.3:   bridge window [mem 0xfd200000-0xfd3fffff 64bit pref]
[    1.667248] pci 0000:05:00.0: [1af4:1041] type 00 class 0x020000
[    1.670117] pci 0000:05:00.0: reg 0x14: [mem 0xfe040000-0xfe040fff]
[    1.674117] pci 0000:05:00.0: reg 0x20: [mem 0xfd000000-0xfd003fff 64bit pref]
[    1.676118] pci 0000:05:00.0: reg 0x30: [mem 0xfe000000-0xfe03ffff pref]
[    1.678511] pci 0000:00:02.4: PCI bridge to [bus 05]
[    1.679137] pci 0000:00:02.4:   bridge window [mem 0xfe000000-0xfe1fffff]
[    1.680135] pci 0000:00:02.4:   bridge window [mem 0xfd000000-0xfd1fffff 64bit pref]
[    1.693160] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.696453] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.699441] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.702358] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.705436] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    1.714449] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    1.723402] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    1.728798] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    1.729693] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    1.730487] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    1.731467] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    1.732484] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    1.733476] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    1.734475] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    1.735487] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    1.736482] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    1.753566] iommu: Default domain type: Translated 
[    1.759447] pci 0000:00:01.0: vgaarb: setting as boot VGA device
[    1.760103] pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.760130] pci 0000:00:01.0: vgaarb: bridge control possible
[    1.761113] vgaarb: loaded
[    1.764356] SCSI subsystem initialized
[    1.765425] libata version 3.00 loaded.
[    1.766202] ACPI: bus type USB registered
[    1.767490] usbcore: registered new interface driver usbfs
[    1.768318] usbcore: registered new interface driver hub
[    1.769404] usbcore: registered new device driver usb
[    1.770804] EDAC MC: Ver: 3.0.0
[    1.773554] PCI: Using ACPI for IRQ routing
[    1.813467] PCI: pci_cache_line_size set to 64 bytes
[    1.813697] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    1.813737] e820: reserve RAM buffer [mem 0x7ffde000-0x7fffffff]
[    1.816463] NetLabel: Initializing
[    1.817117] NetLabel:  domain hash size = 128
[    1.818112] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.819411] NetLabel:  unlabeled traffic allowed by default
[    1.820363] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    1.821129] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    1.824313] clocksource: Switched to clocksource kvm-clock
[    2.149834] *** VALIDATE bpf ***
[    2.155561] VFS: Disk quotas dquot_6.6.0
[    2.157070] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.158881] *** VALIDATE ramfs ***
[    2.160000] *** VALIDATE hugetlbfs ***
[    2.162105] pnp: PnP ACPI init
[    2.163890] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.164528] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    2.165047] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    2.166456] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.167383] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.173646] pnp: PnP ACPI: found 5 devices
[    2.208854] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    2.211044] pci 0000:00:02.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    2.213093] pci 0000:00:02.1: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    2.215147] pci 0000:00:02.2: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    2.217167] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    2.219216] pci 0000:00:02.4: bridge window [io  0x1000-0x0fff] to [bus 05] add_size 1000
[    2.221366] pci 0000:00:02.0: BAR 13: assigned [io  0x1000-0x1fff]
[    2.222738] pci 0000:00:02.1: BAR 13: assigned [io  0x2000-0x2fff]
[    2.224060] pci 0000:00:02.2: BAR 13: assigned [io  0x3000-0x3fff]
[    2.225381] pci 0000:00:02.3: BAR 13: assigned [io  0x4000-0x4fff]
[    2.226758] pci 0000:00:02.4: BAR 13: assigned [io  0x5000-0x5fff]
[    2.228155] pci 0000:00:02.0: PCI bridge to [bus 01]
[    2.229328] pci 0000:00:02.0:   bridge window [io  0x1000-0x1fff]
[    2.232317] pci 0000:00:02.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    2.234823] pci 0000:00:02.0:   bridge window [mem 0xfd800000-0xfd9fffff 64bit pref]
[    2.238786] pci 0000:00:02.1: PCI bridge to [bus 02]
[    2.239977] pci 0000:00:02.1:   bridge window [io  0x2000-0x2fff]
[    2.242794] pci 0000:00:02.1:   bridge window [mem 0xfe600000-0xfe7fffff]
[    2.245173] pci 0000:00:02.1:   bridge window [mem 0xfd600000-0xfd7fffff 64bit pref]
[    2.249070] pci 0000:00:02.2: PCI bridge to [bus 03]
[    2.250278] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    2.253697] pci 0000:00:02.2:   bridge window [mem 0xfe400000-0xfe5fffff]
[    2.255810] pci 0000:00:02.2:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
[    2.259141] pci 0000:00:02.3: PCI bridge to [bus 04]
[    2.260334] pci 0000:00:02.3:   bridge window [io  0x4000-0x4fff]
[    2.262932] pci 0000:00:02.3:   bridge window [mem 0xfe200000-0xfe3fffff]
[    2.266295] pci 0000:00:02.3:   bridge window [mem 0xfd200000-0xfd3fffff 64bit pref]
[    2.269449] pci 0000:00:02.4: PCI bridge to [bus 05]
[    2.270691] pci 0000:00:02.4:   bridge window [io  0x5000-0x5fff]
[    2.272949] pci 0000:00:02.4:   bridge window [mem 0xfe000000-0xfe1fffff]
[    2.276015] pci 0000:00:02.4:   bridge window [mem 0xfd000000-0xfd1fffff 64bit pref]
[    2.279220] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.280564] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.281885] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    2.283322] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[    2.284786] pci_bus 0000:00: resource 8 [mem 0x480000000-0xc7fffffff window]
[    2.286237] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    2.287539] pci_bus 0000:01: resource 1 [mem 0xfe800000-0xfe9fffff]
[    2.288871] pci_bus 0000:01: resource 2 [mem 0xfd800000-0xfd9fffff 64bit pref]
[    2.290797] pci_bus 0000:02: resource 0 [io  0x2000-0x2fff]
[    2.292034] pci_bus 0000:02: resource 1 [mem 0xfe600000-0xfe7fffff]
[    2.293365] pci_bus 0000:02: resource 2 [mem 0xfd600000-0xfd7fffff 64bit pref]
[    2.295259] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    2.296558] pci_bus 0000:03: resource 1 [mem 0xfe400000-0xfe5fffff]
[    2.297892] pci_bus 0000:03: resource 2 [mem 0xfd400000-0xfd5fffff 64bit pref]
[    2.299782] pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
[    2.301026] pci_bus 0000:04: resource 1 [mem 0xfe200000-0xfe3fffff]
[    2.302360] pci_bus 0000:04: resource 2 [mem 0xfd200000-0xfd3fffff 64bit pref]
[    2.304260] pci_bus 0000:05: resource 0 [io  0x5000-0x5fff]
[    2.305507] pci_bus 0000:05: resource 1 [mem 0xfe000000-0xfe1fffff]
[    2.306900] pci_bus 0000:05: resource 2 [mem 0xfd000000-0xfd1fffff 64bit pref]
[    2.309633] NET: Registered protocol family 2
[    2.313633] tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 655360 bytes, linear)
[    2.316426] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    2.319370] TCP bind hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc)
[    2.323702] TCP: Hash tables configured (established 131072 bind 65536)
[    2.325956] UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[    2.328809] UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[    2.332794] NET: Registered protocol family 1
[    2.333977] NET: Registered protocol family 44
[    2.335232] pci 0000:00:01.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.352992] PCI Interrupt Link [GSIG] enabled at IRQ 22
[    2.384530] pci 0000:01:00.0: quirk_usb_early_handoff+0x0/0xbd0 took 46018 usecs
[    2.388815] PCI: CLS 0 bytes, default 64
[    2.390576] Trying to unpack rootfs image as initramfs...
[    3.030135] Freeing initrd memory: 14848K
[    3.033914] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.035315] software IO TLB: mapped [mem 0x7bfde000-0x7ffde000] (64MB)
[    3.036870] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211354f4cc6, max_idle_ns: 440795207008 ns
[    3.082631] Initialise system trusted keyrings
[    3.084884] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    3.171329] NET: Registered protocol family 38
[    3.173216] Key type asymmetric registered
[    3.174982] Asymmetric key parser 'x509' registered
[    3.177173] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    3.182969] io scheduler bfq registered
[    3.186843] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    3.193125] pcieport 0000:00:02.0: PME: Signaling with IRQ 24
[    3.195911] pcieport 0000:00:02.0: AER: enabled with IRQ 24
[    3.218905] pcieport 0000:00:02.1: PME: Signaling with IRQ 25
[    3.221610] pcieport 0000:00:02.1: AER: enabled with IRQ 25
[    3.246498] pcieport 0000:00:02.2: PME: Signaling with IRQ 26
[    3.249149] pcieport 0000:00:02.2: AER: enabled with IRQ 26
[    3.281560] pcieport 0000:00:02.3: PME: Signaling with IRQ 27
[    3.284365] pcieport 0000:00:02.3: AER: enabled with IRQ 27
[    3.307761] pcieport 0000:00:02.4: PME: Signaling with IRQ 28
[    3.310430] pcieport 0000:00:02.4: AER: enabled with IRQ 28
[    3.313297] intel_idle: Please enable MWAIT in BIOS SETUP
[    3.394351] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    3.396253] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.399948] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.415877] Non-volatile memory driver v1.3
[    3.417485] Linux agpgart interface v0.103
[    3.454826] virtio_blk virtio0: [vda] 73400320 512-byte logical blocks (37.6 GB/35.0 GiB)
[    3.456895] vda: detected capacity change from 0 to 37580963840
[    3.460536]  vda: vda1
[    3.464687] Loading iSCSI transport class v2.0-870.
[    3.468359] rdac: device handler registered
[    3.469993] hp_sw: device handler registered
[    3.471101] emc: device handler registered
[    3.472589] alua: device handler registered
[    3.474127] iscsi: registered transport (tcp)
[    3.475267] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
[    3.477127] mpt3sas version 33.100.00.00 loaded
[    3.479592] libcxgbi:libcxgbi_init_module: Chelsio iSCSI driver library libcxgbi v0.9.1-ko (Apr. 2015)
[    3.481860] Chelsio T3 iSCSI Driver cxgb3i v2.0.1-ko (Apr. 2015)
[    3.483354] iscsi: registered transport (cxgb3i)
[    3.484504] Chelsio T4-T6 iSCSI Driver cxgb4i v0.9.5-ko (Apr. 2015)
[    3.486081] iscsi: registered transport (cxgb4i)
[    3.487292] QLogic NetXtreme II iSCSI Driver bnx2i v2.7.10.1 (Jul 16, 2014)
[    3.488884] iscsi: registered transport (bnx2i)
[    3.495820] ahci 0000:00:1f.2: version 3.0
[    3.514879] PCI Interrupt Link [GSIA] enabled at IRQ 16
[    3.517637] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    3.519737] ahci 0000:00:1f.2: flags: 64bit ncq only 
[    3.531690] scsi host0: ahci
[    3.535534] scsi host1: ahci
[    3.540802] scsi host2: ahci
[    3.543791] scsi host3: ahci
[    3.546775] scsi host4: ahci
[    3.549766] scsi host5: ahci
[    3.552069] ata1: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16100 irq 31
[    3.554075] ata2: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16180 irq 31
[    3.556078] ata3: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16200 irq 31
[    3.557975] ata4: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16280 irq 31
[    3.559960] ata5: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16300 irq 31
[    3.570916] ata6: SATA max UDMA/133 abar m4096@0xfea16000 port 0xfea16380 irq 31
[    3.575557] libphy: Fixed MDIO Bus: probed
[    3.576854] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
[    3.579043] Fusion MPT base driver 3.04.20
[    3.580150] Copyright (c) 1999-2008 LSI Corporation
[    3.581357] Fusion MPT SAS Host driver 3.04.20
[    3.583498] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.584968] ehci-pci: EHCI PCI platform driver
[    3.586245] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.587658] ohci-pci: OHCI PCI platform driver
[    3.588872] uhci_hcd: USB Universal Host Controller Interface driver
[    3.610205] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.612660] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    3.615522] xhci_hcd 0000:01:00.0: hcc params 0x00087001 hci version 0x100 quirks 0x0000000000000010
[    3.625878] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.06
[    3.628018] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.630422] usb usb1: Product: xHCI Host Controller
[    3.631629] usb usb1: Manufacturer: Linux 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 xhci-hcd
[    3.633786] usb usb1: SerialNumber: 0000:01:00.0
[    3.639522] hub 1-0:1.0: USB hub found
[    3.640843] hub 1-0:1.0: 4 ports detected
[    3.645548] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    3.647686] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    3.649638] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[    3.651369] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.654043] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.06
[    3.656202] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.658061] usb usb2: Product: xHCI Host Controller
[    3.659287] usb usb2: Manufacturer: Linux 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 xhci-hcd
[    3.661451] usb usb2: SerialNumber: 0000:01:00.0
[    3.664937] hub 2-0:1.0: USB hub found
[    3.666268] hub 2-0:1.0: 4 ports detected
[    3.671080] usbcore: registered new interface driver usbserial_generic
[    3.672697] usbserial: USB Serial support registered for generic
[    3.674369] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    3.677733] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.679056] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.682273] mousedev: PS/2 mouse device common for all mice
[    3.684926] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    3.689785] rtc_cmos 00:00: RTC can wake from S4
[    3.702702] rtc_cmos 00:00: registered as rtc0
[    3.704227] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[    3.706303] intel_pstate: CPU model not supported
[    3.709280] No iBFT detected.
[    3.710417] hid: raw HID events driver (C) Jiri Kosina
[    3.713557] usbcore: registered new interface driver usbhid
[    3.714851] usbhid: USB HID core driver
[    3.716229] drop_monitor: Initializing network drop monitor service
[    3.721618] NET: Registered protocol family 10
[    3.728644] Segment Routing with IPv6
[    3.729821] NET: Registered protocol family 17
[    3.747947] IPI shorthand broadcast: enabled
[    3.749402] AVX2 version of gcm_enc/dec engaged.
[    3.750924] AES CTR mode by8 optimization enabled
[    3.880576] ata2: SATA link down (SStatus 0 SControl 300)
[    3.882372] ata1: SATA link down (SStatus 0 SControl 300)
[    3.886836] ata3: SATA link down (SStatus 0 SControl 300)
[    3.888517] ata6: SATA link down (SStatus 0 SControl 300)
[    3.890247] ata5: SATA link down (SStatus 0 SControl 300)
[    3.894988] ata4: SATA link down (SStatus 0 SControl 300)
[    3.998971] sched_clock: Marking stable (3825962125, 172935552)->(4387522858, -388625181)
[    4.002875] registered taskstats version 1
[    4.004204] Loading compiled-in X.509 certificates
[    4.049597] Loaded X.509 cert 'Build time autogenerated kernel key: 46dec4a16668423e305ae94ef227cc4428ba7bf4'
[    4.061618] zswap: default zpool zbud not available
[    4.063195] zswap: pool creation failed
[    4.065861] kmemleak: Kernel memory leak detector initialized (mem pool available: 14078)
[    4.065871] kmemleak: Automatic memory scanning thread started
[    4.069001] ima: No TPM chip found, activating TPM-bypass!
[    4.072227] ima: Allocated hash algorithm: sha1
[    4.073801] ima: No architecture policies found
[    4.079788] rtc_cmos 00:00: setting system clock to 2020-04-27T16:34:48 UTC (1588005288)
[    4.101321] Freeing unused kernel image (initmem) memory: 2748K
[    4.117572] Write protecting the kernel read-only data: 51200k
[    4.122454] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    4.125894] Freeing unused kernel image (rodata/data gap) memory: 2028K
[    4.127633] Run /init as init process
[    4.128663]   with arguments:
[    4.128666]     /init
[    4.128668]   with environment:
[    4.128670]     HOME=/
[    4.128673]     TERM=linux
[    4.128675]     BOOT_IMAGE=/boot/vmlinuz-5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70
[    4.128678]     biosdevname=0
[    4.266090] systemd[1]: systemd 234 running in system mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN default-hierarchy=hybrid)
[    4.270505] systemd[1]: Detected virtualization kvm.
[    4.271721] systemd[1]: Detected architecture x86-64.
[    4.272926] systemd[1]: Running in initial RAM disk.
[    4.277038] systemd[1]: Set hostname to <localhost.localdomain>.
[    4.553360] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
[    4.637324] random: systemd: uninitialized urandom read (16 bytes read)
[    4.639485] systemd[1]: Reached target Local File Systems.
[    4.642999] random: systemd: uninitialized urandom read (16 bytes read)
[    4.644459] systemd[1]: Reached target Swap.
[    4.647957] random: systemd: uninitialized urandom read (16 bytes read)
[    4.649951] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    4.655306] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.664604] systemd[1]: Created slice System Slice.
[    6.140856] EXT4-fs (vda1): mounted filesystem with ordered data mode. Opts: (null)
[    6.686768] random: fast init done
[    6.934859] systemd-journald[284]: Received SIGTERM from PID 1 (systemd).
[    7.120034] printk: systemd: 20 output lines suppressed due to ratelimiting
[    7.221895] SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.
[    7.224066] SELinux:  Disabled at runtime.
[    7.268669] systemd[1]: RTC configured in localtime, applying delta of 180 minutes to system time.
[    8.031138] systemd-journald[419]: File /run/log/journal/0a211f346c314823a8416b5687b4ad98/system.journal corrupted or uncleanly shut down, renaming and replacing.
[    8.054540] EXT4-fs (vda1): re-mounted. Opts: (null)
[    8.445058] systemd-journald[419]: Received request to flush runtime journal from PID 1
[    8.896199] Adding 2097148k swap on /swapfile.  Priority:-2 extents:2 across:2236412k FS
[    9.000665] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    9.004961] ACPI: Power Button [PWRF]
[    9.163767] pps_core: LinuxPPS API ver. 1 registered
[    9.165119] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    9.170377] lpc_ich 0000:00:1f.0: I/O space for GPIO uninitialized
[    9.187884] PTP clock support registered
[    9.265570] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    9.270176] RPC: Registered named UNIX socket transport module.
[    9.271618] RPC: Registered udp transport module.
[    9.272911] RPC: Registered tcp transport module.
[    9.274284] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    9.330799] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    9.653328] iTCO_vendor_support: vendor-support=0
[    9.658086] PCI Interrupt Link [GSIE] enabled at IRQ 20
[    9.659764] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    9.660254] iTCO_wdt: Found a ICH9 TCO device (Version=2, TCOBASE=0x0660)
[    9.662052] mlx5_core 0000:00:08.0: firmware version: 16.27.2048
[    9.662134] mlx5_core 0000:00:08.0: 0.000 Gb/s available PCIe bandwidth (Unknown speed x255 link)
[    9.662647] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    9.913070] Rounding down aligned max_sectors from 4294967295 to 4294967288
[    9.915992] db_root: cannot open: /etc/target
[   10.025122] iscsi: registered transport (iser)
[   10.409292] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   10.431387] RPC: Registered rdma transport module.
[   10.432680] RPC: Registered rdma backchannel transport module.
[   10.435718] mlx5_core 0000:00:08.0: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
[   10.439354] mlx5_core 0000:00:08.0: E-Switch: Total vports 2, per vport: max uc(1024) max mc(16384)
[   10.481002] mlx5_core 0000:00:08.0: Port module event: module 0, Cable plugged
[   10.483782] mlx5_core 0000:00:08.0: mlx5_pcie_event:296:(pid 182): PCIe slot advertised sufficient power (75W).
[   10.547504] PCI Interrupt Link [GSIF] enabled at IRQ 21
[   10.550501] mlx5_core 0000:00:08.1: firmware version: 16.27.2048
[   10.551914] mlx5_core 0000:00:08.1: 0.000 Gb/s available PCIe bandwidth (Unknown speed x255 link)
[   11.227431] mlx5_core 0000:00:08.1: Rate limit: 127 rates are supported, range: 0Mbps to 97656Mbps
[   11.233521] mlx5_core 0000:00:08.1: E-Switch: Total vports 2, per vport: max uc(1024) max mc(16384)
[   11.276441] mlx5_core 0000:00:08.1: Port module event: module 1, Cable plugged
[   11.284457] mlx5_core 0000:00:08.1: mlx5_pcie_event:296:(pid 180): PCIe slot advertised sufficient power (75W).
[   11.316383] mlx5_core 0000:00:08.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
[   11.546350] mlx5_core 0000:00:08.1: MLX5E: StrdRq(1) RqSz(8) StrdSz(2048) RxCqeCmprss(0)
[   11.831729] mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
[   12.243248] random: crng init done
[   12.244300] random: 7 urandom warning(s) missed due to ratelimiting
[   13.199541] FS-Cache: Loaded
[   13.286377] FS-Cache: Netfs 'nfs' registered for caching
[   13.294924] *** VALIDATE nfs ***
[   13.300966] *** VALIDATE nfs4 ***
[   13.318863] Key type dns_resolver registered
[   13.572240] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   13.582633] Bridge firewalling registered
[   13.586043] NFS: Registering the id_resolver key type
[   13.587377] Key type id_resolver registered
[   13.588516] Key type id_legacy registered
[   90.771014] NFS4: Couldn't follow remote path
[   90.778825] NFS4: Couldn't follow remote path
[   90.783949] NFS4: Couldn't follow remote path
[  132.549020] TSC deadline timer enabled

[  132.575308] ======================================================
[  132.575308] WARNING: possible circular locking dependency detected
[  132.575309] 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1 Not tainted
[  132.575310] ------------------------------------------------------
[  132.575311] swapper/7/0 is trying to acquire lock:
[  132.575311] ffffffff8442c858 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x13/0x70

[  132.575314] but task is already holding lock:
[  132.575315] ffff88842e1b9958 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base+0x71/0x120

[  132.575317] which lock already depends on the new lock.


[  132.575319] the existing dependency chain (in reverse order) is:

[  132.575320] -> #4 (hrtimer_bases.lock){-.-.}-{2:2}:
[  132.575322]        _raw_spin_lock_irqsave+0x3c/0x4b
[  132.575322]        lock_hrtimer_base+0x71/0x120
[  132.575323]        hrtimer_start_range_ns+0xc6/0xaa0
[  132.575323]        __enqueue_rt_entity+0xc44/0xf50
[  132.575324]        enqueue_rt_entity+0x79/0xc0
[  132.575325]        enqueue_task_rt+0x5c/0x2e0
[  132.575325]        activate_task+0x15a/0x2c0
[  132.575326]        ttwu_do_activate+0xcf/0x120
[  132.575326]        sched_ttwu_pending+0x160/0x230
[  132.575327]        do_idle+0x2cf/0x530
[  132.575327]        cpu_startup_entry+0x19/0x20
[  132.575328]        start_secondary+0x2ee/0x3e0
[  132.575328]        secondary_startup_64+0xa4/0xb0

[  132.575329] -> #3 (&rt_b->rt_runtime_lock){-...}-{2:2}:
[  132.575331]        _raw_spin_lock+0x25/0x30
[  132.575331]        rq_online_rt+0x288/0x550
[  132.575332]        set_rq_online+0x11f/0x190
[  132.575332]        sched_cpu_activate+0x1d4/0x390
[  132.575333]        cpuhp_invoke_callback+0x1c5/0x1560
[  132.575333]        cpuhp_thread_fun+0x3f8/0x6f0
[  132.575334]        smpboot_thread_fn+0x305/0x5f0
[  132.575335]        kthread+0x2f8/0x3b0
[  132.575335]        ret_from_fork+0x24/0x30

[  132.575336] -> #2 (&rq->lock){-.-.}-{2:2}:
[  132.575338]        _raw_spin_lock+0x25/0x30
[  132.575338]        task_fork_fair+0x34/0x430
[  132.575339]        sched_fork+0x48a/0xa60
[  132.575339]        copy_process+0x15df/0x5970
[  132.575340]        _do_fork+0x106/0xcd0
[  132.575340]        kernel_thread+0x9e/0xe0
[  132.575341]        rest_init+0x28/0x330
[  132.575341]        start_kernel+0x6ac/0x6ed
[  132.575342]        secondary_startup_64+0xa4/0xb0

[  132.575342] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[  132.575344]        _raw_spin_lock_irqsave+0x3c/0x4b
[  132.575345]        try_to_wake_up+0x9a/0x1700
[  132.575345]        up+0x7a/0xb0
[  132.575346]        __up_console_sem+0x3c/0x70
[  132.575346]        console_unlock+0x4f4/0xab0
[  132.575347]        con_font_op+0x907/0x1010
[  132.575347]        vt_ioctl+0x10a6/0x2890
[  132.575348]        tty_ioctl+0x257/0x1240
[  132.575348]        ksys_ioctl+0x3e9/0x1190
[  132.575349]        __x64_sys_ioctl+0x6f/0xb0
[  132.575349]        do_syscall_64+0xe7/0x12c0
[  132.575350]        entry_SYSCALL_64_after_hwframe+0x49/0xb3

[  132.575350] -> #0 ((console_sem).lock){-...}-{2:2}:
[  132.575352]        __lock_acquire+0x374a/0x5210
[  132.575353]        lock_acquire+0x1b9/0x920
[  132.575353]        _raw_spin_lock_irqsave+0x3c/0x4b
[  132.575354]        down_trylock+0x13/0x70
[  132.575354]        __down_trylock_console_sem+0x33/0xa0
[  132.575355]        console_trylock+0x13/0x60
[  132.575356]        vprintk_emit+0xec/0x370
[  132.575356]        printk+0x9c/0xc3
[  132.575357]        lapic_timer_set_oneshot+0x4e/0x60
[  132.575357]        clockevents_switch_state+0x1e1/0x360
[  132.575358]        tick_program_event+0xae/0xc0
[  132.575358]        hrtimer_start_range_ns+0x4b6/0xaa0
[  132.575359]        __tick_nohz_idle_restart_tick+0x2a9/0x380
[  132.575359]        tick_nohz_idle_exit+0x149/0x190
[  132.575360]        do_idle+0x2b8/0x530
[  132.575360]        cpu_startup_entry+0x19/0x20
[  132.575361]        start_secondary+0x2ee/0x3e0
[  132.575361]        secondary_startup_64+0xa4/0xb0

[  132.575362] other info that might help us debug this:

[  132.575363] Chain exists of:
[  132.575364]   (console_sem).lock --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

[  132.575367]  Possible unsafe locking scenario:

[  132.575368]        CPU0                    CPU1
[  132.575368]        ----                    ----
[  132.575368]   lock(hrtimer_bases.lock);
[  132.575370]                                lock(&rt_b->rt_runtime_lock);
[  132.575371]                                lock(hrtimer_bases.lock);
[  132.575372]   lock((console_sem).lock);

[  132.575374]  *** DEADLOCK ***

[  132.575374] 1 lock held by swapper/7/0:
[  132.575375]  #0: ffff88842e1b9958 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base+0x71/0x120

[  132.575377] stack backtrace:
[  132.575378] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1
[  132.575379] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[  132.575380] Call Trace:
[  132.575380]  dump_stack+0xb7/0x10b
[  132.575381]  check_noncircular+0x37f/0x460
[  132.575381]  ? arch_stack_walk+0x7c/0xd0
[  132.575382]  ? print_circular_bug+0x4e0/0x4e0
[  132.575382]  ? mark_lock+0x1a4/0xb60
[  132.575383]  ? __lock_acquire+0x374a/0x5210
[  132.575383]  __lock_acquire+0x374a/0x5210
[  132.575384]  ? register_lock_class+0x17e0/0x17e0
[  132.575384]  ? register_lock_class+0x17e0/0x17e0
[  132.575385]  lock_acquire+0x1b9/0x920
[  132.575385]  ? down_trylock+0x13/0x70
[  132.575386]  ? check_flags.part.29+0x450/0x450
[  132.575386]  ? lock_downgrade+0x760/0x760
[  132.575387]  ? vprintk_emit+0xec/0x370
[  132.575387]  _raw_spin_lock_irqsave+0x3c/0x4b
[  132.575388]  ? down_trylock+0x13/0x70
[  132.575388]  down_trylock+0x13/0x70
[  132.575389]  __down_trylock_console_sem+0x33/0xa0
[  132.575389]  console_trylock+0x13/0x60
[  132.575390]  vprintk_emit+0xec/0x370
[  132.575390]  printk+0x9c/0xc3
[  132.575391]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[  132.575391]  lapic_timer_set_oneshot+0x4e/0x60
[  132.575392]  clockevents_switch_state+0x1e1/0x360
[  132.575392]  ? enqueue_hrtimer+0x116/0x310
[  132.575393]  tick_program_event+0xae/0xc0
[  132.575393]  hrtimer_start_range_ns+0x4b6/0xaa0
[  132.575394]  ? _raw_spin_unlock_irqrestore+0x49/0x50
[  132.575394]  ? hrtimer_run_softirq+0x210/0x210
[  132.575395]  ? rcu_read_lock_bh_held+0xe0/0xe0
[  132.575395]  __tick_nohz_idle_restart_tick+0x2a9/0x380
[  132.575396]  tick_nohz_idle_exit+0x149/0x190
[  132.575396]  do_idle+0x2b8/0x530
[  132.575397]  ? arch_cpu_idle_exit+0x40/0x40
[  132.575397]  ? _raw_spin_unlock_irqrestore+0x2d/0x50
[  132.575398]  cpu_startup_entry+0x19/0x20
[  132.575398]  start_secondary+0x2ee/0x3e0
[  132.575399]  ? set_cpu_sibling_map+0x2f70/0x2f70
[  132.575400]  secondary_startup_64+0xa4/0xb0

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--

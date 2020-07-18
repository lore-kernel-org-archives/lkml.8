Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AD2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DF720724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595075367;
	bh=tKbUsNSTYz3jTxc0UA/NA5dTQIYRmEAHs9/IYeHuK+o=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=RPWyCdaEHRldBtjZE+5Y+xiEC0aKQux9OgdudQvAp3YNsBb9BvcLyiZhs2G/AZ+eq
	 U38un29MIxD8GfpY+JbbbGsXnHKmegjh0qy+k+sadpkTbWwURNrU8LA/cMAzWFl17C
	 TRYh0qQ6qmWQINOarr0+me47IHhPFnESWjGIFAss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGRM3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 08:29:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36247 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGRM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 08:28:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id dg28so9683036edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 05:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=hmBmDGMRrcsFDpJNO6G5ctBVtL4vcFu0I2D8T/TS8lE=;
        b=V6dN7T7cue0l1bDSa+vePAfDps8q4/f0IU+SQWNZk/jWsib8Kxv9rTyFkSNnLUKZiO
         3oA7aAN7wFEZ2ePAAqeGdvJnCM8P8UPlFFRs4Kp2GHJZsKyxTUndpQWX52vx9IDaLndH
         lmPJ9LS0d1dTuWC/bmlb2XBIPABzUwPCf3ArayT7taODb17XHb8yloOy1PKsssygYb5g
         idkNY2RWgXzVsSgtkxJ5PWNRJ/tOTFvUSqWlW5zNdn/f8z0yHzqFMjqFeb9+ZLIXPHre
         XTa9Kbc8i4UJ52Dcr/Z56eTeoLUu6o+J7UNBn8fWWHSYF/mn6/qovH8TVAHcrw6S4zGJ
         8V0Q==
X-Gm-Message-State: AOAM532o9eZhoVx1HVV5ThWMfw4vSdzO9p0wnZkQc+L5jstRQOMnIfSF
        C1gATGbo17dr45YHbFBGWEjvPIwR
X-Google-Smtp-Source: ABdhPJwgNkUwDEhGvV3A2hsjXXTF7xeRbCicKeSxiTQ5xs2ulFacLFnXvK75+NfMJuhEUCETjD6buQ==
X-Received: by 2002:a05:6402:354:: with SMTP id r20mr14219066edw.32.1595075329246;
        Sat, 18 Jul 2020 05:28:49 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b98sm11203052edf.24.2020.07.18.05.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 05:28:47 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
 <5a8c4c38-7aeb-981a-8d3b-a7a5c8ca5564@kernel.org>
 <20200717122651.GA6067@redhat.com> <20200717124017.GB6067@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
Date:   Sat, 18 Jul 2020 14:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717124017.GB6067@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------83D230D142721D4635144020"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------83D230D142721D4635144020
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit

On 17. 07. 20, 14:40, Oleg Nesterov wrote:
> On 07/17, Oleg Nesterov wrote:
>>
>> On 07/17, Jiri Slaby wrote:
>>>
>>> On 17. 07. 20, 12:45, Jiri Slaby wrote:
>>>> Hi,
>>>>
>>>> the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
>>>> and i586:
>>>
>>> make check needs -jsomething, running is sequentially (-j1) doesn't
>>> trigger it. After the error, I cannot run anything. Like ps to find out
>>> what test caused the crash...
>>
>> Strange... I'll try to reproduce but I can't do this till Monday.
>>
>> Meanwhile, could you try the patch below? It needs CONFIG_DEBUG_ATOMIC_SLEEP.
> 
> please see the updated patch below, lets check ptrace_unfreeze() too.

Sure, dmesg attached.

thanks,
-- 
js

--------------83D230D142721D4635144020
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.txt"

[    0.000000] Linux version 5.8.0-rc5-100.g55927f9-default (geeko@buildhost) (gcc (SUSE Linux) 10.1.1 20200625 [revision c91e43e9363bd119a695d64505f96539fa451bf2], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.34.0.20200325-1) #1 SMP Sat Jul 18 06:57:08 UTC 2020 (55927f9)
[    0.000000] Command line: root=/dev/disk/by-id/virtio-0 rootfstype=ext4 rootflags=noatime ext4.allow_unsupported=1 kpti=off pti=off spectre_v2=off panic=1 quiet no-kvmclock elevator=noop nmi_watchdog=0 rw rd.driver.pre=binfmt_misc console=ttyS0 init=/.build/build
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffd8fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffd9000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000521ffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2799.858 MHz processor
[    0.000348] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000349] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000354] last_pfn = 0x522000 max_arch_pfn = 0x400000000
[    0.000380] MTRR default type: write-back
[    0.000380] MTRR fixed ranges enabled:
[    0.000381]   00000-9FFFF write-back
[    0.000382]   A0000-BFFFF uncachable
[    0.000383]   C0000-FFFFF write-protect
[    0.000383] MTRR variable ranges enabled:
[    0.000384]   0 base 000C0000000 mask 3FFC0000000 uncachable
[    0.000385]   1 disabled
[    0.000385]   2 disabled
[    0.000385]   3 disabled
[    0.000386]   4 disabled
[    0.000386]   5 disabled
[    0.000387]   6 disabled
[    0.000387]   7 disabled
[    0.000394] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000408] last_pfn = 0xbffd9 max_arch_pfn = 0x400000000
[    0.015173] check: Scanning 1 areas for low memory corruption
[    0.015226] Kernel/User page tables isolation: disabled on command line.
[    0.015230] Using GB pages for direct mapping
[    0.015416] RAMDISK: [mem 0x7f7a2000-0x7fffffff]
[    0.015459] ACPI: Early table checksum verification disabled
[    0.015474] ACPI: RSDP 0x00000000000F5B30 000014 (v00 BOCHS )
[    0.015477] ACPI: RSDT 0x00000000BFFE2369 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.015486] ACPI: FACP 0x00000000BFFE1D4D 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.015493] ACPI: DSDT 0x00000000BFFDD400 00494D (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.015497] ACPI: FACS 0x00000000BFFDD3C0 000040
[    0.015499] ACPI: APIC 0x00000000BFFE1DC1 000570 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.015502] ACPI: HPET 0x00000000BFFE2331 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.015512] ACPI: Local APIC address 0xfee00000
[    0.015847] No NUMA configuration found
[    0.015847] Faking a node at [mem 0x0000000000000000-0x0000000521ffffff]
[    0.015862] NODE_DATA(0) allocated [mem 0x521fea000-0x521ffffff]
[    0.016605] Zone ranges:
[    0.016606]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.016606]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.016607]   Normal   [mem 0x0000000100000000-0x0000000521ffffff]
[    0.016608]   Device   empty
[    0.016608] Movable zone start for each node
[    0.016610] Early memory node ranges
[    0.016611]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.016612]   node   0: [mem 0x0000000000100000-0x00000000bffd8fff]
[    0.016612]   node   0: [mem 0x0000000100000000-0x0000000521ffffff]
[    0.019125] Zeroed struct page in unavailable ranges: 24713 pages
[    0.019126] Initmem setup node 0 [mem 0x0000000000001000-0x0000000521ffffff]
[    0.019127] On node 0 totalpages: 5119863
[    0.019131]   DMA zone: 64 pages used for memmap
[    0.019132]   DMA zone: 21 pages reserved
[    0.019132]   DMA zone: 3998 pages, LIFO batch:0
[    0.019171]   DMA32 zone: 12224 pages used for memmap
[    0.019172]   DMA32 zone: 782297 pages, LIFO batch:63
[    0.041378]   Normal zone: 67712 pages used for memmap
[    0.041379]   Normal zone: 4333568 pages, LIFO batch:63
[    0.042911] ACPI: PM-Timer IO Port: 0x608
[    0.042914] ACPI: Local APIC address 0xfee00000
[    0.042950] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.043001] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.043005] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.043006] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.043007] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.043012] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.043013] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.043014] ACPI: IRQ0 used by override.
[    0.043015] ACPI: IRQ5 used by override.
[    0.043016] ACPI: IRQ9 used by override.
[    0.043016] ACPI: IRQ10 used by override.
[    0.043016] ACPI: IRQ11 used by override.
[    0.043020] Using ACPI (MADT) for SMP configuration information
[    0.043022] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.043027] TSC deadline timer available
[    0.043030] smpboot: Allowing 160 CPUs, 0 hotplug CPUs
[    0.043059] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.043060] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.043061] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.043061] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.043063] PM: hibernation: Registered nosave memory: [mem 0xbffd9000-0xbfffffff]
[    0.043063] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.043064] PM: hibernation: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.043065] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.043065] PM: hibernation: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.043067] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.043068] Booting paravirtualized kernel on KVM
[    0.043075] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.047910] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:160 nr_node_ids:1
[    0.067311] percpu: Embedded 58 pages/cpu s200704 r8192 d28672 u262144
[    0.067323] pcpu-alloc: s200704 r8192 d28672 u262144 alloc=1*2097152
[    0.067324] pcpu-alloc: [0] 000 001 002 003 004 005 006 007 
[    0.067326] pcpu-alloc: [0] 008 009 010 011 012 013 014 015 
[    0.067327] pcpu-alloc: [0] 016 017 018 019 020 021 022 023 
[    0.067329] pcpu-alloc: [0] 024 025 026 027 028 029 030 031 
[    0.067330] pcpu-alloc: [0] 032 033 034 035 036 037 038 039 
[    0.067332] pcpu-alloc: [0] 040 041 042 043 044 045 046 047 
[    0.067333] pcpu-alloc: [0] 048 049 050 051 052 053 054 055 
[    0.067335] pcpu-alloc: [0] 056 057 058 059 060 061 062 063 
[    0.067336] pcpu-alloc: [0] 064 065 066 067 068 069 070 071 
[    0.067338] pcpu-alloc: [0] 072 073 074 075 076 077 078 079 
[    0.067339] pcpu-alloc: [0] 080 081 082 083 084 085 086 087 
[    0.067341] pcpu-alloc: [0] 088 089 090 091 092 093 094 095 
[    0.067342] pcpu-alloc: [0] 096 097 098 099 100 101 102 103 
[    0.067344] pcpu-alloc: [0] 104 105 106 107 108 109 110 111 
[    0.067346] pcpu-alloc: [0] 112 113 114 115 116 117 118 119 
[    0.067347] pcpu-alloc: [0] 120 121 122 123 124 125 126 127 
[    0.067349] pcpu-alloc: [0] 128 129 130 131 132 133 134 135 
[    0.067350] pcpu-alloc: [0] 136 137 138 139 140 141 142 143 
[    0.067352] pcpu-alloc: [0] 144 145 146 147 148 149 150 151 
[    0.067353] pcpu-alloc: [0] 152 153 154 155 156 157 158 159 
[    0.067402] KVM setup async PF for cpu 0
[    0.067407] kvm-stealtime: cpu 0, msr 50bc30080
[    0.067414] PV qspinlock hash table entries: 512 (order: 1, 8192 bytes, linear)
[    0.067428] Built 1 zonelists, mobility grouping on.  Total pages: 5039842
[    0.067429] Policy zone: Normal
[    0.067430] Kernel command line: root=/dev/disk/by-id/virtio-0 rootfstype=ext4 rootflags=noatime ext4.allow_unsupported=1 kpti=off pti=off spectre_v2=off panic=1 quiet no-kvmclock elevator=noop nmi_watchdog=0 rw rd.driver.pre=binfmt_misc console=ttyS0 init=/.build/build
[    0.067504] Kernel parameter elevator= does not have any effect anymore.
               Please use sysfs to set IO scheduler for individual devices.
[    0.067550] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.067551] printk: log_buf_len total cpu_extra contributions: 5210112 bytes
[    0.067551] printk: log_buf_len min size: 262144 bytes
[    0.071163] printk: log_buf_len: 8388608 bytes
[    0.071164] printk: early log buf free: 252348(96%)
[    0.085153] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.091415] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.094324] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.147531] Memory: 3202064K/20479452K available (14339K kernel code, 1625K rwdata, 4360K rodata, 2084K init, 12320K bss, 533872K reserved, 0K cma-reserved)
[    0.147552] random: get_random_u64 called from kmem_cache_open+0x26/0x230 with crng_init=0
[    0.149140] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=160, Nodes=1
[    0.149191] ftrace: allocating 43038 entries in 169 pages
[    0.168403] ftrace: allocated 169 pages with 4 groups
[    0.170396] rcu: Hierarchical RCU implementation.
[    0.170397] rcu: 	RCU event tracing is enabled.
[    0.170398] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=160.
[    0.170400] 	Trampoline variant of Tasks RCU enabled.
[    0.170400] 	Rude variant of Tasks RCU enabled.
[    0.170400] 	Tracing variant of Tasks RCU enabled.
[    0.170401] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.170402] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=160
[    0.173721] NR_IRQS: 33024, nr_irqs: 1704, preallocated irqs: 16
[    0.174372] random: crng done (trusting CPU's manufacturer)
[    0.174710] Console: colour *CGA 80x25
[    0.174788] printk: console [ttyS0] enabled
[    0.174937] ACPI: Core revision 20200528
[    0.175171] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.175317] APIC: Switch to symmetric I/O mode setup
[    0.175711] x2apic enabled
[    0.176123] Switched APIC routing to physical x2apic.
[    0.177451] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.177513] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x285bba78219, max_idle_ns: 440795257228 ns
[    0.177517] Calibrating delay loop (skipped), value calculated using timer frequency.. 5599.71 BogoMIPS (lpj=11199432)
[    0.177519] pid_max: default: 163840 minimum: 1280
[    0.177768] LSM: Security Framework initializing
[    0.177830] AppArmor: AppArmor initialized
[    0.178691] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.178724] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.181666] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.181722] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.181723] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.181728] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.181730] Spectre V2 : off selected on command line.
[    0.181732] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.181736] TAA: Mitigation: Clear CPU buffers
[    0.181737] MDS: Mitigation: Clear CPU buffers
[    0.182042] Freeing SMP alternatives memory: 36K
[    0.183970] smpboot: CPU0: Intel(R) Xeon(R) CPU E7-8891 v4 @ 2.80GHz (family: 0x6, model: 0x4f, stepping: 0x1)
[    0.184209] Performance Events: Broadwell events, Intel PMU driver.
[    0.184231] ... version:                2
[    0.184232] ... bit width:              48
[    0.184232] ... generic registers:      4
[    0.184233] ... value mask:             0000ffffffffffff
[    0.184234] ... max period:             000000007fffffff
[    0.184234] ... fixed-purpose events:   3
[    0.184235] ... event mask:             000000070000000f
[    0.184379] rcu: Hierarchical SRCU implementation.
[    0.185515] smp: Bringing up secondary CPUs ...
[    0.185515] x86: Booting SMP configuration:
[    0.185515] .... node  #0, CPUs:          #1
[    0.003208] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.265608] KVM setup async PF for cpu 1
[    0.265612] kvm-stealtime: cpu 1, msr 50bc70080
[    0.266318]    #2
[    0.003208] smpboot: CPU 2 Converting physical 0 to logical die 2
[    0.349634] KVM setup async PF for cpu 2
[    0.349638] kvm-stealtime: cpu 2, msr 50bcb0080
[    0.349644]    #3
[    0.003208] smpboot: CPU 3 Converting physical 0 to logical die 3
[    0.433552] KVM setup async PF for cpu 3
[    0.433556] kvm-stealtime: cpu 3, msr 50bcf0080
[    0.433619]    #4
[    0.003208] smpboot: CPU 4 Converting physical 0 to logical die 4
[    0.517605] KVM setup async PF for cpu 4
[    0.517609] kvm-stealtime: cpu 4, msr 50bd30080
[    0.517651]    #5
[    0.003208] smpboot: CPU 5 Converting physical 0 to logical die 5
[    0.601556] KVM setup async PF for cpu 5
[    0.601561] kvm-stealtime: cpu 5, msr 50bd70080
[    0.601608]    #6
[    0.003208] smpboot: CPU 6 Converting physical 0 to logical die 6
[    0.685864] KVM setup async PF for cpu 6
[    0.685870] kvm-stealtime: cpu 6, msr 50bdb0080
[    0.685915]    #7
[    0.003208] smpboot: CPU 7 Converting physical 0 to logical die 7
[    0.769702] KVM setup async PF for cpu 7
[    0.769708] kvm-stealtime: cpu 7, msr 50bdf0080
[    0.769767]    #8
[    0.003208] smpboot: CPU 8 Converting physical 0 to logical die 8
[    0.853594] KVM setup async PF for cpu 8
[    0.853599] kvm-stealtime: cpu 8, msr 50be30080
[    0.853662]    #9
[    0.003208] smpboot: CPU 9 Converting physical 0 to logical die 9
[    0.937561] KVM setup async PF for cpu 9
[    0.937566] kvm-stealtime: cpu 9, msr 50be70080
[    0.937615]   #10
[    0.003208] smpboot: CPU 10 Converting physical 0 to logical die 10
[    1.021558] KVM setup async PF for cpu 10
[    1.021562] kvm-stealtime: cpu 10, msr 50beb0080
[    1.021626]   #11
[    0.003208] smpboot: CPU 11 Converting physical 0 to logical die 11
[    1.105568] KVM setup async PF for cpu 11
[    1.105573] kvm-stealtime: cpu 11, msr 50bef0080
[    1.106583]   #12
[    0.003208] smpboot: CPU 12 Converting physical 0 to logical die 12
[    1.189550] KVM setup async PF for cpu 12
[    1.189554] kvm-stealtime: cpu 12, msr 50bf30080
[    1.189630]   #13
[    0.003208] smpboot: CPU 13 Converting physical 0 to logical die 13
[    1.273546] KVM setup async PF for cpu 13
[    1.273550] kvm-stealtime: cpu 13, msr 50bf70080
[    1.273612]   #14
[    0.003208] smpboot: CPU 14 Converting physical 0 to logical die 14
[    1.357550] KVM setup async PF for cpu 14
[    1.357554] kvm-stealtime: cpu 14, msr 50bfb0080
[    1.357630]   #15
[    0.003208] smpboot: CPU 15 Converting physical 0 to logical die 15
[    1.441852] KVM setup async PF for cpu 15
[    1.441858] kvm-stealtime: cpu 15, msr 50bff0080
[    1.441919]   #16
[    0.003208] smpboot: CPU 16 Converting physical 0 to logical die 16
[    1.525560] KVM setup async PF for cpu 16
[    1.525566] kvm-stealtime: cpu 16, msr 50c030080
[    1.525634]   #17
[    0.003208] smpboot: CPU 17 Converting physical 0 to logical die 17
[    1.609560] KVM setup async PF for cpu 17
[    1.609564] kvm-stealtime: cpu 17, msr 50c070080
[    1.609613]   #18
[    0.003208] smpboot: CPU 18 Converting physical 0 to logical die 18
[    1.693548] KVM setup async PF for cpu 18
[    1.693552] kvm-stealtime: cpu 18, msr 50c0b0080
[    1.693627]   #19
[    0.003208] smpboot: CPU 19 Converting physical 0 to logical die 19
[    1.777547] KVM setup async PF for cpu 19
[    1.777551] kvm-stealtime: cpu 19, msr 50c0f0080
[    1.777621]   #20
[    0.003208] smpboot: CPU 20 Converting physical 0 to logical die 20
[    1.861544] KVM setup async PF for cpu 20
[    1.861548] kvm-stealtime: cpu 20, msr 50c130080
[    1.861639]   #21
[    0.003208] smpboot: CPU 21 Converting physical 0 to logical die 21
[    1.945549] KVM setup async PF for cpu 21
[    1.945554] kvm-stealtime: cpu 21, msr 50c170080
[    1.946364]   #22
[    0.003208] smpboot: CPU 22 Converting physical 0 to logical die 22
[    2.029560] KVM setup async PF for cpu 22
[    2.029565] kvm-stealtime: cpu 22, msr 50c1b0080
[    2.029661]   #23
[    0.003208] smpboot: CPU 23 Converting physical 0 to logical die 23
[    2.113828] KVM setup async PF for cpu 23
[    2.113839] kvm-stealtime: cpu 23, msr 50c1f0080
[    2.114113]   #24
[    0.003208] smpboot: CPU 24 Converting physical 0 to logical die 24
[    2.197575] KVM setup async PF for cpu 24
[    2.197579] kvm-stealtime: cpu 24, msr 50c230080
[    2.197928]   #25
[    0.003208] smpboot: CPU 25 Converting physical 0 to logical die 25
[    2.281582] KVM setup async PF for cpu 25
[    2.281586] kvm-stealtime: cpu 25, msr 50c270080
[    2.281846]   #26
[    0.003208] smpboot: CPU 26 Converting physical 0 to logical die 26
[    2.365577] KVM setup async PF for cpu 26
[    2.365581] kvm-stealtime: cpu 26, msr 50c2b0080
[    2.365928]   #27
[    0.003208] smpboot: CPU 27 Converting physical 0 to logical die 27
[    2.449584] KVM setup async PF for cpu 27
[    2.449588] kvm-stealtime: cpu 27, msr 50c2f0080
[    2.449847]   #28
[    0.003208] smpboot: CPU 28 Converting physical 0 to logical die 28
[    2.533573] KVM setup async PF for cpu 28
[    2.533577] kvm-stealtime: cpu 28, msr 50c330080
[    2.533905]   #29
[    0.003208] smpboot: CPU 29 Converting physical 0 to logical die 29
[    2.617576] KVM setup async PF for cpu 29
[    2.617580] kvm-stealtime: cpu 29, msr 50c370080
[    2.617837]   #30
[    0.003208] smpboot: CPU 30 Converting physical 0 to logical die 30
[    2.701586] KVM setup async PF for cpu 30
[    2.701590] kvm-stealtime: cpu 30, msr 50c3b0080
[    2.701922]   #31
[    0.003208] smpboot: CPU 31 Converting physical 0 to logical die 31
[    2.785585] KVM setup async PF for cpu 31
[    2.785589] kvm-stealtime: cpu 31, msr 50c3f0080
[    2.785971]   #32
[    0.003208] smpboot: CPU 32 Converting physical 0 to logical die 32
[    2.869580] KVM setup async PF for cpu 32
[    2.869584] kvm-stealtime: cpu 32, msr 50c430080
[    2.869749]   #33
[    0.003208] smpboot: CPU 33 Converting physical 0 to logical die 33
[    2.953578] KVM setup async PF for cpu 33
[    2.953583] kvm-stealtime: cpu 33, msr 50c470080
[    2.953707]   #34
[    0.003208] smpboot: CPU 34 Converting physical 0 to logical die 34
[    3.037625] KVM setup async PF for cpu 34
[    3.037630] kvm-stealtime: cpu 34, msr 50c4b0080
[    3.037789]   #35
[    0.003208] smpboot: CPU 35 Converting physical 0 to logical die 35
[    3.121587] KVM setup async PF for cpu 35
[    3.121592] kvm-stealtime: cpu 35, msr 50c4f0080
[    3.121692]   #36
[    0.003208] smpboot: CPU 36 Converting physical 0 to logical die 36
[    3.205629] KVM setup async PF for cpu 36
[    3.205633] kvm-stealtime: cpu 36, msr 50c530080
[    3.205748]   #37
[    0.003208] smpboot: CPU 37 Converting physical 0 to logical die 37
[    3.289598] KVM setup async PF for cpu 37
[    3.289602] kvm-stealtime: cpu 37, msr 50c570080
[    3.289675]   #38
[    0.003208] smpboot: CPU 38 Converting physical 0 to logical die 38
[    3.373575] KVM setup async PF for cpu 38
[    3.373579] kvm-stealtime: cpu 38, msr 50c5b0080
[    3.373750]   #39
[    0.003208] smpboot: CPU 39 Converting physical 0 to logical die 39
[    3.457577] KVM setup async PF for cpu 39
[    3.457581] kvm-stealtime: cpu 39, msr 50c5f0080
[    3.457656]   #40
[    0.003208] smpboot: CPU 40 Converting physical 0 to logical die 40
[    3.541574] KVM setup async PF for cpu 40
[    3.541578] kvm-stealtime: cpu 40, msr 50c630080
[    3.541733]   #41
[    0.003208] smpboot: CPU 41 Converting physical 0 to logical die 41
[    3.625577] KVM setup async PF for cpu 41
[    3.625581] kvm-stealtime: cpu 41, msr 50c670080
[    3.626373]   #42
[    0.003208] smpboot: CPU 42 Converting physical 0 to logical die 42
[    3.709576] KVM setup async PF for cpu 42
[    3.709580] kvm-stealtime: cpu 42, msr 50c6b0080
[    3.709743]   #43
[    0.003208] smpboot: CPU 43 Converting physical 0 to logical die 43
[    3.793572] KVM setup async PF for cpu 43
[    3.793577] kvm-stealtime: cpu 43, msr 50c6f0080
[    3.793655]   #44
[    0.003208] smpboot: CPU 44 Converting physical 0 to logical die 44
[    3.877574] KVM setup async PF for cpu 44
[    3.877578] kvm-stealtime: cpu 44, msr 50c730080
[    3.877713]   #45
[    0.003208] smpboot: CPU 45 Converting physical 0 to logical die 45
[    3.961573] KVM setup async PF for cpu 45
[    3.961577] kvm-stealtime: cpu 45, msr 50c770080
[    3.961676]   #46
[    0.003208] smpboot: CPU 46 Converting physical 0 to logical die 46
[    4.045574] KVM setup async PF for cpu 46
[    4.045579] kvm-stealtime: cpu 46, msr 50c7b0080
[    4.045802]   #47
[    0.003208] smpboot: CPU 47 Converting physical 0 to logical die 47
[    4.129575] KVM setup async PF for cpu 47
[    4.129579] kvm-stealtime: cpu 47, msr 50c7f0080
[    4.129688]   #48
[    0.003208] smpboot: CPU 48 Converting physical 0 to logical die 48
[    4.213611] KVM setup async PF for cpu 48
[    4.213616] kvm-stealtime: cpu 48, msr 50c830080
[    4.213741]   #49
[    0.003208] smpboot: CPU 49 Converting physical 0 to logical die 49
[    4.297619] KVM setup async PF for cpu 49
[    4.297624] kvm-stealtime: cpu 49, msr 50c870080
[    4.297722]   #50
[    0.003208] smpboot: CPU 50 Converting physical 0 to logical die 50
[    4.381576] KVM setup async PF for cpu 50
[    4.381580] kvm-stealtime: cpu 50, msr 50c8b0080
[    4.381738]   #51
[    0.003208] smpboot: CPU 51 Converting physical 0 to logical die 51
[    4.465577] KVM setup async PF for cpu 51
[    4.465580] kvm-stealtime: cpu 51, msr 50c8f0080
[    4.466342]   #52
[    0.003208] smpboot: CPU 52 Converting physical 0 to logical die 52
[    4.549571] KVM setup async PF for cpu 52
[    4.549575] kvm-stealtime: cpu 52, msr 50c930080
[    4.549745]   #53
[    0.003208] smpboot: CPU 53 Converting physical 0 to logical die 53
[    4.633575] KVM setup async PF for cpu 53
[    4.633579] kvm-stealtime: cpu 53, msr 50c970080
[    4.633675]   #54
[    0.003208] smpboot: CPU 54 Converting physical 0 to logical die 54
[    4.717576] KVM setup async PF for cpu 54
[    4.717580] kvm-stealtime: cpu 54, msr 50c9b0080
[    4.717714]   #55
[    0.003208] smpboot: CPU 55 Converting physical 0 to logical die 55
[    4.801571] KVM setup async PF for cpu 55
[    4.801575] kvm-stealtime: cpu 55, msr 50c9f0080
[    4.801646]   #56
[    0.003208] smpboot: CPU 56 Converting physical 0 to logical die 56
[    4.885568] KVM setup async PF for cpu 56
[    4.885573] kvm-stealtime: cpu 56, msr 50ca30080
[    4.885746]   #57
[    0.003208] smpboot: CPU 57 Converting physical 0 to logical die 57
[    4.969582] KVM setup async PF for cpu 57
[    4.969587] kvm-stealtime: cpu 57, msr 50ca70080
[    4.969722]   #58
[    0.003208] smpboot: CPU 58 Converting physical 0 to logical die 58
[    5.053582] KVM setup async PF for cpu 58
[    5.053586] kvm-stealtime: cpu 58, msr 50cab0080
[    5.053814]   #59
[    0.003208] smpboot: CPU 59 Converting physical 0 to logical die 59
[    5.137572] KVM setup async PF for cpu 59
[    5.137576] kvm-stealtime: cpu 59, msr 50caf0080
[    5.137681]   #60
[    0.003208] smpboot: CPU 60 Converting physical 0 to logical die 60
[    5.221579] KVM setup async PF for cpu 60
[    5.221583] kvm-stealtime: cpu 60, msr 50cb30080
[    5.221750]   #61
[    0.003208] smpboot: CPU 61 Converting physical 0 to logical die 61
[    5.305583] KVM setup async PF for cpu 61
[    5.305588] kvm-stealtime: cpu 61, msr 50cb70080
[    5.306443]   #62
[    0.003208] smpboot: CPU 62 Converting physical 0 to logical die 62
[    5.389586] KVM setup async PF for cpu 62
[    5.389590] kvm-stealtime: cpu 62, msr 50cbb0080
[    5.389748]   #63
[    0.003208] smpboot: CPU 63 Converting physical 0 to logical die 63
[    5.473745] KVM setup async PF for cpu 63
[    5.473751] kvm-stealtime: cpu 63, msr 50cbf0080
[    5.473996]   #64
[    0.003208] smpboot: CPU 64 Converting physical 0 to logical die 64
[    5.557641] KVM setup async PF for cpu 64
[    5.557645] kvm-stealtime: cpu 64, msr 50cc30080
[    5.557756]   #65
[    0.003208] smpboot: CPU 65 Converting physical 0 to logical die 65
[    5.641582] KVM setup async PF for cpu 65
[    5.641587] kvm-stealtime: cpu 65, msr 50cc70080
[    5.641674]   #66
[    0.003208] smpboot: CPU 66 Converting physical 0 to logical die 66
[    5.725588] KVM setup async PF for cpu 66
[    5.725592] kvm-stealtime: cpu 66, msr 50ccb0080
[    5.725728]   #67
[    0.003208] smpboot: CPU 67 Converting physical 0 to logical die 67
[    5.809572] KVM setup async PF for cpu 67
[    5.809576] kvm-stealtime: cpu 67, msr 50ccf0080
[    5.809708]   #68
[    0.003208] smpboot: CPU 68 Converting physical 0 to logical die 68
[    5.893572] KVM setup async PF for cpu 68
[    5.893576] kvm-stealtime: cpu 68, msr 50cd30080
[    5.893758]   #69
[    0.003208] smpboot: CPU 69 Converting physical 0 to logical die 69
[    5.977577] KVM setup async PF for cpu 69
[    5.977581] kvm-stealtime: cpu 69, msr 50cd70080
[    5.977675]   #70
[    0.003208] smpboot: CPU 70 Converting physical 0 to logical die 70
[    6.061578] KVM setup async PF for cpu 70
[    6.061583] kvm-stealtime: cpu 70, msr 50cdb0080
[    6.061843]   #71
[    0.003208] smpboot: CPU 71 Converting physical 0 to logical die 71
[    6.145573] KVM setup async PF for cpu 71
[    6.145577] kvm-stealtime: cpu 71, msr 50cdf0080
[    6.146595]   #72
[    0.003208] smpboot: CPU 72 Converting physical 0 to logical die 72
[    6.229578] KVM setup async PF for cpu 72
[    6.229582] kvm-stealtime: cpu 72, msr 50ce30080
[    6.229759]   #73
[    0.003208] smpboot: CPU 73 Converting physical 0 to logical die 73
[    6.313575] KVM setup async PF for cpu 73
[    6.313579] kvm-stealtime: cpu 73, msr 50ce70080
[    6.313683]   #74
[    0.003208] smpboot: CPU 74 Converting physical 0 to logical die 74
[    6.397644] KVM setup async PF for cpu 74
[    6.397649] kvm-stealtime: cpu 74, msr 50ceb0080
[    6.397777]   #75
[    0.003208] smpboot: CPU 75 Converting physical 0 to logical die 75
[    6.481614] KVM setup async PF for cpu 75
[    6.481618] kvm-stealtime: cpu 75, msr 50cef0080
[    6.481746]   #76
[    0.003208] smpboot: CPU 76 Converting physical 0 to logical die 76
[    6.565569] KVM setup async PF for cpu 76
[    6.565573] kvm-stealtime: cpu 76, msr 50cf30080
[    6.565763]   #77
[    0.003208] smpboot: CPU 77 Converting physical 0 to logical die 77
[    6.649580] KVM setup async PF for cpu 77
[    6.649584] kvm-stealtime: cpu 77, msr 50cf70080
[    6.649685]   #78
[    0.003208] smpboot: CPU 78 Converting physical 0 to logical die 78
[    6.733650] KVM setup async PF for cpu 78
[    6.733656] kvm-stealtime: cpu 78, msr 50cfb0080
[    6.733804]   #79
[    0.003208] smpboot: CPU 79 Converting physical 0 to logical die 79
[    6.817583] KVM setup async PF for cpu 79
[    6.817587] kvm-stealtime: cpu 79, msr 50cff0080
[    6.817731]   #80
[    0.003208] smpboot: CPU 80 Converting physical 0 to logical die 80
[    6.901580] KVM setup async PF for cpu 80
[    6.901584] kvm-stealtime: cpu 80, msr 50d030080
[    6.902537]   #81
[    0.003208] smpboot: CPU 81 Converting physical 0 to logical die 81
[    6.985578] KVM setup async PF for cpu 81
[    6.985582] kvm-stealtime: cpu 81, msr 50d070080
[    6.985690]   #82
[    0.003208] smpboot: CPU 82 Converting physical 0 to logical die 82
[    7.069576] KVM setup async PF for cpu 82
[    7.069580] kvm-stealtime: cpu 82, msr 50d0b0080
[    7.069868]   #83
[    0.003208] smpboot: CPU 83 Converting physical 0 to logical die 83
[    7.153575] KVM setup async PF for cpu 83
[    7.153580] kvm-stealtime: cpu 83, msr 50d0f0080
[    7.153725]   #84
[    0.003208] smpboot: CPU 84 Converting physical 0 to logical die 84
[    7.237577] KVM setup async PF for cpu 84
[    7.237581] kvm-stealtime: cpu 84, msr 50d130080
[    7.237764]   #85
[    0.003208] smpboot: CPU 85 Converting physical 0 to logical die 85
[    7.321577] KVM setup async PF for cpu 85
[    7.321582] kvm-stealtime: cpu 85, msr 50d170080
[    7.321699]   #86
[    0.003208] smpboot: CPU 86 Converting physical 0 to logical die 86
[    7.405580] KVM setup async PF for cpu 86
[    7.405584] kvm-stealtime: cpu 86, msr 50d1b0080
[    7.405766]   #87
[    0.003208] smpboot: CPU 87 Converting physical 0 to logical die 87
[    7.489575] KVM setup async PF for cpu 87
[    7.489579] kvm-stealtime: cpu 87, msr 50d1f0080
[    7.489695]   #88
[    0.003208] smpboot: CPU 88 Converting physical 0 to logical die 88
[    7.573575] KVM setup async PF for cpu 88
[    7.573579] kvm-stealtime: cpu 88, msr 50d230080
[    7.573765]   #89
[    0.003208] smpboot: CPU 89 Converting physical 0 to logical die 89
[    7.657577] KVM setup async PF for cpu 89
[    7.657581] kvm-stealtime: cpu 89, msr 50d270080
[    7.657692]   #90
[    0.003208] smpboot: CPU 90 Converting physical 0 to logical die 90
[    7.741571] KVM setup async PF for cpu 90
[    7.741575] kvm-stealtime: cpu 90, msr 50d2b0080
[    7.742461]   #91
[    0.003208] smpboot: CPU 91 Converting physical 0 to logical die 91
[    7.825572] KVM setup async PF for cpu 91
[    7.825576] kvm-stealtime: cpu 91, msr 50d2f0080
[    7.825696]   #92
[    0.003208] smpboot: CPU 92 Converting physical 0 to logical die 92
[    7.909576] KVM setup async PF for cpu 92
[    7.909581] kvm-stealtime: cpu 92, msr 50d330080
[    7.909755]   #93
[    0.003208] smpboot: CPU 93 Converting physical 0 to logical die 93
[    7.993565] KVM setup async PF for cpu 93
[    7.993570] kvm-stealtime: cpu 93, msr 50d370080
[    7.993686]   #94
[    0.003208] smpboot: CPU 94 Converting physical 0 to logical die 94
[    8.077611] KVM setup async PF for cpu 94
[    8.077616] kvm-stealtime: cpu 94, msr 50d3b0080
[    8.077891]   #95
[    0.003208] smpboot: CPU 95 Converting physical 0 to logical die 95
[    8.161576] KVM setup async PF for cpu 95
[    8.161580] kvm-stealtime: cpu 95, msr 50d3f0080
[    8.161746]   #96
[    0.003208] smpboot: CPU 96 Converting physical 0 to logical die 96
[    8.245571] KVM setup async PF for cpu 96
[    8.245575] kvm-stealtime: cpu 96, msr 50d430080
[    8.245776]   #97
[    0.003208] smpboot: CPU 97 Converting physical 0 to logical die 97
[    8.329572] KVM setup async PF for cpu 97
[    8.329575] kvm-stealtime: cpu 97, msr 50d470080
[    8.329704]   #98
[    0.003208] smpboot: CPU 98 Converting physical 0 to logical die 98
[    8.413570] KVM setup async PF for cpu 98
[    8.413574] kvm-stealtime: cpu 98, msr 50d4b0080
[    8.413770]   #99
[    0.003208] smpboot: CPU 99 Converting physical 0 to logical die 99
[    8.497579] KVM setup async PF for cpu 99
[    8.497583] kvm-stealtime: cpu 99, msr 50d4f0080
[    8.497702]  #100
[    0.003208] smpboot: CPU 100 Converting physical 0 to logical die 100
[    8.581572] KVM setup async PF for cpu 100
[    8.581575] kvm-stealtime: cpu 100, msr 50d530080
[    8.582560]  #101
[    0.003208] smpboot: CPU 101 Converting physical 0 to logical die 101
[    8.665571] KVM setup async PF for cpu 101
[    8.665575] kvm-stealtime: cpu 101, msr 50d570080
[    8.665702]  #102
[    0.003208] smpboot: CPU 102 Converting physical 0 to logical die 102
[    8.749605] KVM setup async PF for cpu 102
[    8.749610] kvm-stealtime: cpu 102, msr 50d5b0080
[    8.749764]  #103
[    0.003208] smpboot: CPU 103 Converting physical 0 to logical die 103
[    8.833575] KVM setup async PF for cpu 103
[    8.833581] kvm-stealtime: cpu 103, msr 50d5f0080
[    8.833767]  #104
[    0.003208] smpboot: CPU 104 Converting physical 0 to logical die 104
[    8.917580] KVM setup async PF for cpu 104
[    8.917585] kvm-stealtime: cpu 104, msr 50d630080
[    8.917797]  #105
[    0.003208] smpboot: CPU 105 Converting physical 0 to logical die 105
[    9.001571] KVM setup async PF for cpu 105
[    9.001575] kvm-stealtime: cpu 105, msr 50d670080
[    9.001731]  #106
[    0.003208] smpboot: CPU 106 Converting physical 0 to logical die 106
[    9.085613] KVM setup async PF for cpu 106
[    9.085617] kvm-stealtime: cpu 106, msr 50d6b0080
[    9.085915]  #107
[    0.003208] smpboot: CPU 107 Converting physical 0 to logical die 107
[    9.169575] KVM setup async PF for cpu 107
[    9.169579] kvm-stealtime: cpu 107, msr 50d6f0080
[    9.169755]  #108
[    0.003208] smpboot: CPU 108 Converting physical 0 to logical die 108
[    9.253604] KVM setup async PF for cpu 108
[    9.253608] kvm-stealtime: cpu 108, msr 50d730080
[    9.253778]  #109
[    0.003208] smpboot: CPU 109 Converting physical 0 to logical die 109
[    9.337573] KVM setup async PF for cpu 109
[    9.337577] kvm-stealtime: cpu 109, msr 50d770080
[    9.337706]  #110
[    0.003208] smpboot: CPU 110 Converting physical 0 to logical die 110
[    9.421576] KVM setup async PF for cpu 110
[    9.421580] kvm-stealtime: cpu 110, msr 50d7b0080
[    9.422734]  #111
[    0.003208] smpboot: CPU 111 Converting physical 0 to logical die 111
[    9.505567] KVM setup async PF for cpu 111
[    9.505573] kvm-stealtime: cpu 111, msr 50d7f0080
[    9.505772]  #112
[    0.003208] smpboot: CPU 112 Converting physical 0 to logical die 112
[    9.589581] KVM setup async PF for cpu 112
[    9.589585] kvm-stealtime: cpu 112, msr 50d830080
[    9.589782]  #113
[    0.003208] smpboot: CPU 113 Converting physical 0 to logical die 113
[    9.673576] KVM setup async PF for cpu 113
[    9.673580] kvm-stealtime: cpu 113, msr 50d870080
[    9.673711]  #114
[    0.003208] smpboot: CPU 114 Converting physical 0 to logical die 114
[    9.757571] KVM setup async PF for cpu 114
[    9.757575] kvm-stealtime: cpu 114, msr 50d8b0080
[    9.757780]  #115
[    0.003208] smpboot: CPU 115 Converting physical 0 to logical die 115
[    9.841575] KVM setup async PF for cpu 115
[    9.841579] kvm-stealtime: cpu 115, msr 50d8f0080
[    9.841712]  #116
[    0.003208] smpboot: CPU 116 Converting physical 0 to logical die 116
[    9.925574] KVM setup async PF for cpu 116
[    9.925578] kvm-stealtime: cpu 116, msr 50d930080
[    9.925782]  #117
[    0.003208] smpboot: CPU 117 Converting physical 0 to logical die 117
[   10.009572] KVM setup async PF for cpu 117
[   10.009575] kvm-stealtime: cpu 117, msr 50d970080
[   10.009830]  #118
[    0.003208] smpboot: CPU 118 Converting physical 0 to logical die 118
[   10.093576] KVM setup async PF for cpu 118
[   10.093580] kvm-stealtime: cpu 118, msr 50d9b0080
[   10.093803]  #119
[    0.003208] smpboot: CPU 119 Converting physical 0 to logical die 119
[   10.177602] KVM setup async PF for cpu 119
[   10.177607] kvm-stealtime: cpu 119, msr 50d9f0080
[   10.177837]  #120
[    0.003208] smpboot: CPU 120 Converting physical 0 to logical die 120
[   10.261553] KVM setup async PF for cpu 120
[   10.261558] kvm-stealtime: cpu 120, msr 50da30080
[   10.262547]  #121
[    0.003208] smpboot: CPU 121 Converting physical 0 to logical die 121
[   10.345610] KVM setup async PF for cpu 121
[   10.345614] kvm-stealtime: cpu 121, msr 50da70080
[   10.345826]  #122
[    0.003208] smpboot: CPU 122 Converting physical 0 to logical die 122
[   10.429580] KVM setup async PF for cpu 122
[   10.429584] kvm-stealtime: cpu 122, msr 50dab0080
[   10.429773]  #123
[    0.003208] smpboot: CPU 123 Converting physical 0 to logical die 123
[   10.513561] KVM setup async PF for cpu 123
[   10.513565] kvm-stealtime: cpu 123, msr 50daf0080
[   10.513756]  #124
[    0.003208] smpboot: CPU 124 Converting physical 0 to logical die 124
[   10.597606] KVM setup async PF for cpu 124
[   10.597610] kvm-stealtime: cpu 124, msr 50db30080
[   10.597815]  #125
[    0.003208] smpboot: CPU 125 Converting physical 0 to logical die 125
[   10.682489] KVM setup async PF for cpu 125
[   10.682494] kvm-stealtime: cpu 125, msr 50db70080
[   10.682558]  #126
[    0.003208] smpboot: CPU 126 Converting physical 0 to logical die 126
[   10.765602] KVM setup async PF for cpu 126
[   10.765606] kvm-stealtime: cpu 126, msr 50dbb0080
[   10.765789]  #127
[    0.003208] smpboot: CPU 127 Converting physical 0 to logical die 127
[   10.849572] KVM setup async PF for cpu 127
[   10.849576] kvm-stealtime: cpu 127, msr 50dbf0080
[   10.849721]  #128
[    0.003208] smpboot: CPU 128 Converting physical 0 to logical die 128
[   10.933647] KVM setup async PF for cpu 128
[   10.933652] kvm-stealtime: cpu 128, msr 50dc30080
[   10.933882]  #129
[    0.003208] smpboot: CPU 129 Converting physical 0 to logical die 129
[   11.017590] KVM setup async PF for cpu 129
[   11.017595] kvm-stealtime: cpu 129, msr 50dc70080
[   11.017710]  #130
[    0.003208] smpboot: CPU 130 Converting physical 0 to logical die 130
[   11.101654] KVM setup async PF for cpu 130
[   11.101658] kvm-stealtime: cpu 130, msr 50dcb0080
[   11.102616]  #131
[    0.003208] smpboot: CPU 131 Converting physical 0 to logical die 131
[   11.189382] KVM setup async PF for cpu 131
[   11.189388] kvm-stealtime: cpu 131, msr 50dcf0080
[   11.190831]  #132
[    0.003208] smpboot: CPU 132 Converting physical 0 to logical die 132
[   11.273673] KVM setup async PF for cpu 132
[   11.273678] kvm-stealtime: cpu 132, msr 50dd30080
[   11.273900]  #133
[    0.003208] smpboot: CPU 133 Converting physical 0 to logical die 133
[   11.357628] KVM setup async PF for cpu 133
[   11.357632] kvm-stealtime: cpu 133, msr 50dd70080
[   11.357720]  #134
[    0.003208] smpboot: CPU 134 Converting physical 0 to logical die 134
[   11.441573] KVM setup async PF for cpu 134
[   11.441577] kvm-stealtime: cpu 134, msr 50ddb0080
[   11.441760]  #135
[    0.003208] smpboot: CPU 135 Converting physical 0 to logical die 135
[   11.525584] KVM setup async PF for cpu 135
[   11.525589] kvm-stealtime: cpu 135, msr 50ddf0080
[   11.525817]  #136
[    0.003208] smpboot: CPU 136 Converting physical 0 to logical die 136
[   11.609664] KVM setup async PF for cpu 136
[   11.609669] kvm-stealtime: cpu 136, msr 50de30080
[   11.609898]  #137
[    0.003208] smpboot: CPU 137 Converting physical 0 to logical die 137
[   11.693576] KVM setup async PF for cpu 137
[   11.693581] kvm-stealtime: cpu 137, msr 50de70080
[   11.693700]  #138
[    0.003208] smpboot: CPU 138 Converting physical 0 to logical die 138
[   11.777656] KVM setup async PF for cpu 138
[   11.777660] kvm-stealtime: cpu 138, msr 50deb0080
[   11.777766]  #139
[    0.003208] smpboot: CPU 139 Converting physical 0 to logical die 139
[   11.861607] KVM setup async PF for cpu 139
[   11.861611] kvm-stealtime: cpu 139, msr 50def0080
[   11.861853]  #140
[    0.003208] smpboot: CPU 140 Converting physical 0 to logical die 140
[   11.945633] KVM setup async PF for cpu 140
[   11.945638] kvm-stealtime: cpu 140, msr 50df30080
[   11.946977]  #141
[    0.003208] smpboot: CPU 141 Converting physical 0 to logical die 141
[   12.029554] KVM setup async PF for cpu 141
[   12.029563] kvm-stealtime: cpu 141, msr 50df70080
[   12.029799]  #142
[    0.003208] smpboot: CPU 142 Converting physical 0 to logical die 142
[   12.113607] KVM setup async PF for cpu 142
[   12.113611] kvm-stealtime: cpu 142, msr 50dfb0080
[   12.113850]  #143
[    0.003208] smpboot: CPU 143 Converting physical 0 to logical die 143
[   12.197608] KVM setup async PF for cpu 143
[   12.197612] kvm-stealtime: cpu 143, msr 50dff0080
[   12.197719]  #144
[    0.003208] smpboot: CPU 144 Converting physical 0 to logical die 144
[   12.281576] KVM setup async PF for cpu 144
[   12.281580] kvm-stealtime: cpu 144, msr 50e030080
[   12.281751]  #145
[    0.003208] smpboot: CPU 145 Converting physical 0 to logical die 145
[   12.365552] KVM setup async PF for cpu 145
[   12.365557] kvm-stealtime: cpu 145, msr 50e070080
[   12.365801]  #146
[    0.003208] smpboot: CPU 146 Converting physical 0 to logical die 146
[   12.449543] KVM setup async PF for cpu 146
[   12.449547] kvm-stealtime: cpu 146, msr 50e0b0080
[   12.449743]  #147
[    0.003208] smpboot: CPU 147 Converting physical 0 to logical die 147
[   12.533576] KVM setup async PF for cpu 147
[   12.533580] kvm-stealtime: cpu 147, msr 50e0f0080
[   12.533828]  #148
[    0.003208] smpboot: CPU 148 Converting physical 0 to logical die 148
[   12.617568] KVM setup async PF for cpu 148
[   12.617572] kvm-stealtime: cpu 148, msr 50e130080
[   12.617762]  #149
[    0.003208] smpboot: CPU 149 Converting physical 0 to logical die 149
[   12.701564] KVM setup async PF for cpu 149
[   12.701568] kvm-stealtime: cpu 149, msr 50e170080
[   12.702928]  #150
[    0.003208] smpboot: CPU 150 Converting physical 0 to logical die 150
[   12.785574] KVM setup async PF for cpu 150
[   12.785579] kvm-stealtime: cpu 150, msr 50e1b0080
[   12.785842]  #151
[    0.003208] smpboot: CPU 151 Converting physical 0 to logical die 151
[   12.869607] KVM setup async PF for cpu 151
[   12.869612] kvm-stealtime: cpu 151, msr 50e1f0080
[   12.869726]  #152
[    0.003208] smpboot: CPU 152 Converting physical 0 to logical die 152
[   12.953570] KVM setup async PF for cpu 152
[   12.953574] kvm-stealtime: cpu 152, msr 50e230080
[   12.953767]  #153
[    0.003208] smpboot: CPU 153 Converting physical 0 to logical die 153
[   13.037560] KVM setup async PF for cpu 153
[   13.037570] kvm-stealtime: cpu 153, msr 50e270080
[   13.037865]  #154
[    0.003208] smpboot: CPU 154 Converting physical 0 to logical die 154
[   13.121618] KVM setup async PF for cpu 154
[   13.121623] kvm-stealtime: cpu 154, msr 50e2b0080
[   13.121881]  #155
[    0.003208] smpboot: CPU 155 Converting physical 0 to logical die 155
[   13.205552] KVM setup async PF for cpu 155
[   13.205557] kvm-stealtime: cpu 155, msr 50e2f0080
[   13.205818]  #156
[    0.003208] smpboot: CPU 156 Converting physical 0 to logical die 156
[   13.289576] KVM setup async PF for cpu 156
[   13.289580] kvm-stealtime: cpu 156, msr 50e330080
[   13.289841]  #157
[    0.003208] smpboot: CPU 157 Converting physical 0 to logical die 157
[   13.373571] KVM setup async PF for cpu 157
[   13.373575] kvm-stealtime: cpu 157, msr 50e370080
[   13.373726]  #158
[    0.003208] smpboot: CPU 158 Converting physical 0 to logical die 158
[   13.457578] KVM setup async PF for cpu 158
[   13.457582] kvm-stealtime: cpu 158, msr 50e3b0080
[   13.457754]  #159
[    0.003208] smpboot: CPU 159 Converting physical 0 to logical die 159
[   13.541566] KVM setup async PF for cpu 159
[   13.541571] kvm-stealtime: cpu 159, msr 50e3f0080
[   13.544451] smp: Brought up 1 node, 160 CPUs
[   13.544460] smpboot: Max logical packages: 160
[   13.544465] smpboot: Total of 160 processors activated (898247.16 BogoMIPS)
[   13.590416] node 0 deferred pages initialised in 20ms
[   13.629997] devtmpfs: initialized
[   13.629997] x86/mm: Memory block size: 128MB
[   13.637620] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[   13.637620] futex hash table entries: 65536 (order: 10, 4194304 bytes, linear)
[   13.645662] pinctrl core: initialized pinctrl subsystem
[   13.657746] PM: RTC time: 12:22:53, date: 2020-07-18
[   13.657768] thermal_sys: Registered thermal governor 'fair_share'
[   13.657769] thermal_sys: Registered thermal governor 'bang_bang'
[   13.657770] thermal_sys: Registered thermal governor 'step_wise'
[   13.657771] thermal_sys: Registered thermal governor 'user_space'
[   13.661773] NET: Registered protocol family 16
[   13.662043] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[   13.662062] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[   13.662076] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[   13.663613] audit: initializing netlink subsys (disabled)
[   13.663638] audit: type=2000 audit(1595074970.488:1): state=initialized audit_enabled=0 res=1
[   13.663638] cpuidle: using governor ladder
[   13.663638] cpuidle: using governor menu
[   13.665576] ACPI: bus type PCI registered
[   13.665590] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[   13.666036] PCI: Using configuration type 1 for base access
[   13.674223] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[   13.674223] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[   13.686230] ACPI: Added _OSI(Module Device)
[   13.686230] ACPI: Added _OSI(Processor Device)
[   13.686231] ACPI: Added _OSI(3.0 _SCP Extensions)
[   13.686232] ACPI: Added _OSI(Processor Aggregator Device)
[   13.686233] ACPI: Added _OSI(Linux-Dell-Video)
[   13.686235] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[   13.686236] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[   13.691499] ACPI: 1 ACPI AML tables successfully acquired and loaded
[   13.694683] ACPI: Interpreter enabled
[   13.694715] ACPI: (supports S0 S3 S4 S5)
[   13.694717] ACPI: Using IOAPIC for interrupt routing
[   13.694738] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[   13.695102] ACPI: Enabled 2 GPEs in block 00 to 0F
[   13.711399] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[   13.711420] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI EDR HPX-Type3]
[   13.711446] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[   13.711827] acpiphp: Slot [2] registered
[   13.711854] acpiphp: Slot [3] registered
[   13.711875] acpiphp: Slot [4] registered
[   13.711897] acpiphp: Slot [5] registered
[   13.711917] acpiphp: Slot [6] registered
[   13.711936] acpiphp: Slot [7] registered
[   13.711955] acpiphp: Slot [8] registered
[   13.711974] acpiphp: Slot [9] registered
[   13.711993] acpiphp: Slot [10] registered
[   13.712013] acpiphp: Slot [11] registered
[   13.712032] acpiphp: Slot [12] registered
[   13.712051] acpiphp: Slot [13] registered
[   13.712071] acpiphp: Slot [14] registered
[   13.712110] acpiphp: Slot [15] registered
[   13.712129] acpiphp: Slot [16] registered
[   13.712147] acpiphp: Slot [17] registered
[   13.712166] acpiphp: Slot [18] registered
[   13.712185] acpiphp: Slot [19] registered
[   13.712204] acpiphp: Slot [20] registered
[   13.712223] acpiphp: Slot [21] registered
[   13.712255] acpiphp: Slot [22] registered
[   13.712275] acpiphp: Slot [23] registered
[   13.712294] acpiphp: Slot [24] registered
[   13.712313] acpiphp: Slot [25] registered
[   13.712332] acpiphp: Slot [26] registered
[   13.712350] acpiphp: Slot [27] registered
[   13.712389] acpiphp: Slot [28] registered
[   13.712408] acpiphp: Slot [29] registered
[   13.712427] acpiphp: Slot [30] registered
[   13.712445] acpiphp: Slot [31] registered
[   13.712463] PCI host bridge to bus 0000:00
[   13.712466] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[   13.712467] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[   13.712468] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[   13.712470] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
[   13.712471] pci_bus 0000:00: root bus resource [mem 0x540000000-0x5bfffffff window]
[   13.712473] pci_bus 0000:00: root bus resource [bus 00-ff]
[   13.712520] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[   13.713337] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[   13.714110] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[   13.717922] pci 0000:00:01.1: reg 0x20: [io  0xc0e0-0xc0ef]
[   13.719575] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[   13.719576] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[   13.719577] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[   13.719579] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[   13.719828] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[   13.720374] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[   13.720384] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[   13.720937] pci 0000:00:02.0: [1af4:1005] type 00 class 0x00ff00
[   13.722368] pci 0000:00:02.0: reg 0x10: [io  0xc0c0-0xc0df]
[   13.728707] pci 0000:00:02.0: reg 0x20: [mem 0xfebf4000-0xfebf7fff 64bit pref]
[   13.731223] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[   13.732914] pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
[   13.734340] pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
[   13.742324] pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
[   13.742845] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[   13.745522] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[   13.747730] pci 0000:00:04.0: reg 0x14: [mem 0xfebe0000-0xfebe0fff]
[   13.753522] pci 0000:00:04.0: reg 0x20: [mem 0xfebf8000-0xfebfbfff 64bit pref]
[   13.757045] pci 0000:00:05.0: [1af4:1001] type 00 class 0x010000
[   13.758878] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc0bf]
[   13.761227] pci 0000:00:05.0: reg 0x14: [mem 0xfebe1000-0xfebe1fff]
[   13.767528] pci 0000:00:05.0: reg 0x20: [mem 0xfebfc000-0xfebfffff 64bit pref]
[   13.775957] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[   13.776187] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[   13.776322] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[   13.776452] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[   13.776539] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[   13.787765] iommu: Default domain type: Passthrough 
[   13.787765] vgaarb: loaded
[   13.787765] SCSI subsystem initialized
[   13.789691] libata version 3.00 loaded.
[   13.789691] pps_core: LinuxPPS API ver. 1 registered
[   13.789691] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   13.789691] PTP clock support registered
[   13.789691] EDAC MC: Ver: 3.0.0
[   13.790142] NetLabel: Initializing
[   13.790142] NetLabel:  domain hash size = 128
[   13.790143] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[   13.790185] NetLabel:  unlabeled traffic allowed by default
[   13.790188] PCI: Using ACPI for IRQ routing
[   13.790191] PCI: pci_cache_line_size set to 64 bytes
[   13.790356] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[   13.790359] e820: reserve RAM buffer [mem 0xbffd9000-0xbfffffff]
[   13.790360] e820: reserve RAM buffer [mem 0x522000000-0x523ffffff]
[   13.791135] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   13.791138] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[   13.810076] clocksource: Switched to clocksource tsc-early
[   13.837175] VFS: Disk quotas dquot_6.6.0
[   13.837295] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[   13.837701] AppArmor: AppArmor Filesystem Enabled
[   13.837730] pnp: PnP ACPI init
[   13.837817] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[   13.837881] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[   13.837908] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[   13.837920] pnp 00:03: [dma 2]
[   13.837930] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[   13.838060] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[   13.838306] pnp: PnP ACPI: found 5 devices
[   13.846900] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[   13.848711] NET: Registered protocol family 2
[   13.851148] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes, linear)
[   13.851186] TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[   13.852633] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[   13.852701] TCP: Hash tables configured (established 262144 bind 65536)
[   13.853680] UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
[   13.854988] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
[   13.855926] NET: Registered protocol family 1
[   13.855940] NET: Registered protocol family 44
[   13.856018] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[   13.856019] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[   13.856021] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[   13.856022] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
[   13.856023] pci_bus 0000:00: resource 8 [mem 0x540000000-0x5bfffffff window]
[   13.856084] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[   13.856103] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[   13.856119] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[   13.856192] PCI: CLS 0 bytes, default 64
[   13.856289] Trying to unpack rootfs image as initramfs...
[   14.642308] Freeing initrd memory: 8568K
[   14.642338] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   14.642340] software IO TLB: mapped [mem 0xbbfd9000-0xbffd9000] (64MB)
[   14.642966] check: Scanning for low memory corruption every 60 seconds
[   14.645326] Initialise system trusted keyrings
[   14.645366] Key type blacklist registered
[   14.645619] workingset: timestamp_bits=37 max_order=23 bucket_order=0
[   14.648098] zbud: loaded
[   14.651193] integrity: Platform Keyring initialized
[   14.661154] Key type asymmetric registered
[   14.661159] Asymmetric key parser 'x509' registered
[   14.661177] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[   14.662445] io scheduler mq-deadline registered
[   14.662446] io scheduler kyber registered
[   14.662521] io scheduler bfq registered
[   14.668606] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   14.668634] intel_idle: Please enable MWAIT in BIOS SETUP
[   14.700011] PCI Interrupt Link [LNKB] enabled at IRQ 10
[   14.727034] PCI Interrupt Link [LNKD] enabled at IRQ 11
[   14.753790] PCI Interrupt Link [LNKA] enabled at IRQ 10
[   14.754934] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[   14.755359] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[   14.757725] Non-volatile memory driver v1.3
[   14.757745] Linux agpgart interface v0.103
[   14.812773] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[   14.814037] serio: i8042 KBD port at 0x60,0x64 irq 1
[   14.814043] serio: i8042 AUX port at 0x60,0x64 irq 12
[   14.814155] mousedev: PS/2 mouse device common for all mice
[   14.814414] rtc_cmos 00:00: RTC can wake from S4
[   14.815157] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[   14.815695] rtc_cmos 00:00: registered as rtc0
[   14.816283] rtc_cmos 00:00: setting system clock to 2020-07-18T12:22:54 UTC (1595074974)
[   14.816475] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[   14.816490] intel_pstate: CPU model not supported
[   14.816799] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input3
[   14.817228] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042/serio1/input/input2
[   14.822806] ledtrig-cpu: registered to indicate activity on CPUs
[   14.822823] hid: raw HID events driver (C) Jiri Kosina
[   14.824185] drop_monitor: Initializing network drop monitor service
[   14.824620] NET: Registered protocol family 10
[   14.840065] Segment Routing with IPv6
[   14.840067] RPL Segment Routing with IPv6
[   14.863766] IPI shorthand broadcast: enabled
[   14.863781] sched_clock: Marking stable (14864446565, -791863)->(17527225445, -2663570743)
[   14.864914] registered taskstats version 1
[   14.864927] Loading compiled-in X.509 certificates
[   14.866157] Loaded X.509 cert 'Build time autogenerated kernel key: d610b9d9f2f61494b49ce33261c2a922d2bb45f0'
[   14.866374] zswap: loaded using pool lzo/zbud
[   14.868570] page_owner is disabled
[   14.868714] Key type ._fscrypt registered
[   14.868715] Key type .fscrypt registered
[   14.868717] Key type fscrypt-provisioning registered
[   14.874615] Key type encrypted registered
[   14.874620] AppArmor: AppArmor sha1 policy hashing enabled
[   14.874636] ima: No TPM chip found, activating TPM-bypass!
[   14.874640] ima: Allocated hash algorithm: sha256
[   14.874667] ima: No architecture policies found
[   14.874682] evm: Initialising EVM extended attributes:
[   14.874683] evm: security.selinux
[   14.874684] evm: security.apparmor
[   14.874684] evm: security.ima
[   14.874685] evm: security.capability
[   14.874686] evm: HMAC attrs: 0x1
[   14.875191] PM:   Magic number: 12:453:380
[   14.875521] processor cpu109: hash matches
[   14.881960] RAS: Correctable Errors collector initialized.
[   14.885365] Freeing unused decrypted memory: 2040K
[   14.887822] Freeing unused kernel image (initmem) memory: 2084K
[   14.905578] Write protecting the kernel read-only data: 22528k
[   14.908930] Freeing unused kernel image (text/rodata gap) memory: 2044K
[   14.910952] Freeing unused kernel image (rodata/data gap) memory: 1784K
[   14.910961] Run /init as init process
[   14.910963]   with arguments:
[   14.910964]     /init
[   14.910964]   with environment:
[   14.910965]     HOME=/
[   14.910965]     TERM=linux
[   14.910966]     kpti=off
[   14.910967]     pti=off
[   14.910967]     spectre_v2=off
[   14.920863] virtio_rng: module verification failed: signature and/or required key missing - tainting kernel
[   14.926025] systemd[1]: systemd 245.6+suse.48.gb12cd8b89b running in system mode. (+PAM -AUDIT +SELINUX -IMA -APPARMOR -SMACK -SYSVINIT +UTMP -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL -XZ -LZ4 -SECCOMP +BLKID -ELFUTILS +KMOD -IDN2 -IDN -PCRE2 default-hierarchy=hybrid)
[   14.926069] systemd[1]: Detected virtualization kvm.
[   14.926078] systemd[1]: Detected architecture x86-64.
[   14.926080] systemd[1]: Running in initial RAM disk.
[   14.945819] systemd[1]: No hostname configured.
[   14.945824] systemd[1]: Set hostname to <localhost>.
[   14.945877] systemd[1]: Initializing machine ID from random generator.
[   15.043165] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   15.043212] systemd[1]: Reached target Local File Systems.
[   15.043220] systemd[1]: Reached target Paths.
[   15.043232] systemd[1]: Reached target Slices.
[   15.043240] systemd[1]: Reached target Swap.
[   15.043248] systemd[1]: Reached target Timers.
[   15.043371] systemd[1]: Listening on Journal Socket (/dev/log).
[   15.043462] systemd[1]: Listening on Journal Socket.
[   15.043543] systemd[1]: Listening on udev Control Socket.
[   15.043597] systemd[1]: Listening on udev Kernel Socket.
[   15.043607] systemd[1]: Reached target Sockets.
[   15.049491] systemd[1]: Starting Create list of static device nodes for the current kernel...
[   15.057777] systemd[1]: Starting Journal Service...
[   15.059677] systemd[1]: Starting Load Kernel Modules...
[   15.061389] systemd[1]: Starting Setup Virtual Console...
[   15.062402] systemd[1]: Finished Create list of static device nodes for the current kernel.
[   15.064021] systemd[1]: Starting Create Static Device Nodes in /dev...
[   15.070543] systemd[1]: Finished Setup Virtual Console.
[   15.070782] systemd[1]: Condition check resulted in dracut ask for additional cmdline parameters being skipped.
[   15.072324] systemd[1]: Starting dracut cmdline hook...
[   15.073080] systemd[1]: Finished Load Kernel Modules.
[   15.075018] systemd[1]: Starting Apply Kernel Variables...
[   15.078978] systemd[1]: Finished Create Static Device Nodes in /dev.
[   15.081582] systemd[1]: Finished Apply Kernel Variables.
[   15.081915] systemd[1]: Started Journal Service.
[   15.180519] loop: unknown parameter 'lbs' ignored
[   15.657599] tsc: Refined TSC clocksource calibration: 2799.997 MHz
[   15.658155] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x285c3e19794, max_idle_ns: 440795289996 ns
[   15.677924] clocksource: Switched to clocksource tsc
[   16.371636] loop: module loaded
[   16.390520] device-mapper: uevent: version 1.0.3
[   16.390654] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[   16.415395] fuse: init (API version 7.31)
[   16.425371] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   16.517541] raid6: avx2x4   gen() 23855 MB/s
[   16.585539] raid6: avx2x4   xor()  6652 MB/s
[   16.653536] raid6: avx2x2   gen() 27151 MB/s
[   16.721541] raid6: avx2x2   xor() 16045 MB/s
[   16.789534] raid6: avx2x1   gen() 21292 MB/s
[   16.857535] raid6: avx2x1   xor() 13684 MB/s
[   16.925540] raid6: sse2x4   gen() 14339 MB/s
[   16.993537] raid6: sse2x4   xor()  5993 MB/s
[   17.061530] raid6: sse2x2   gen() 13937 MB/s
[   17.129544] raid6: sse2x2   xor()  9241 MB/s
[   17.197531] raid6: sse2x1   gen() 11585 MB/s
[   17.265536] raid6: sse2x1   xor()  7612 MB/s
[   17.265537] raid6: using algorithm avx2x2 gen() 27151 MB/s
[   17.265538] raid6: .... xor() 16045 MB/s, rmw enabled
[   17.265539] raid6: using avx2x2 recovery algorithm
[   17.267590] xor: automatically using best checksumming function   avx       
[   17.290013] Btrfs loaded, crc32c=crc32c-intel, assert=on
[   17.317236] SGI XFS with ACLs, security attributes, quota, no debug enabled
[   17.344044] virtio_blk virtio1: [vda] 8388608 512-byte logical blocks (4.29 GB/4.00 GiB)
[   17.344055] vda: detected capacity change from 0 to 4294967296
[   17.396129] virtio_blk virtio2: [vdb] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)
[   17.396132] vdb: detected capacity change from 0 to 1073741824
[   17.451115] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   17.451117] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   17.477330] PCI Interrupt Link [LNKC] enabled at IRQ 11
[   17.835447] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[   17.835453] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
[   17.916036] e1000 0000:00:03.0 ens3: renamed from eth0
[   18.072485] ata_piix 0000:00:01.1: version 2.13
[   18.080166] scsi host0: ata_piix
[   18.082195] scsi host1: ata_piix
[   18.082307] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0e0 irq 14
[   18.082309] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0e8 irq 15
[   18.191516] EXT4-fs (vda): warning: mounting unchecked fs, running e2fsck is recommended
[   18.192187] EXT4-fs (vda): mounted filesystem without journal. Opts: (null)
[   18.523664] systemd-journald[1266]: Received SIGTERM from PID 1 (systemd).
[   18.621292] EXT4-fs error (device vda): ext4_mb_generate_buddy:805: group 2, block bitmap and bg descriptor inconsistent: 3818 vs 3831 free clusters
[   18.644621] sysrq: Changing Loglevel
[   18.645424] sysrq: Loglevel set to 4
[   18.649893] EXT4-fs (vda): re-mounted. Opts: (null)
[   18.693573] Adding 1048572k swap on /dev/vdb.  Priority:-2 extents:1 across:1048572k FS
[   20.210032] e1000: ens3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   20.210497] IPv6: ADDRCONF(NETDEV_CHANGE): ens3: link becomes ready
[   94.513944] ------------[ cut here ]------------
[   94.513985] do not call blocking ops when !TASK_RUNNING; state=8 set at [<000000002fe279e9>] ptrace_check_attach+0xbf/0x110
[   94.514019] WARNING: CPU: 16 PID: 34171 at kernel/sched/core.c:6881 __might_sleep+0x6c/0x70
[   94.514020] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.514082] CPU: 16 PID: 34171 Comm: strace Tainted: G            E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.514084] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.514087] RIP: 0010:__might_sleep+0x6c/0x70
[   94.514090] Code: 41 5c 41 5d e9 25 ff ff ff 48 8b 90 68 1a 00 00 48 8b 70 10 48 c7 c7 10 45 70 8f c6 05 4f a9 68 01 01 48 89 d1 e8 7a bb fc ff <0f> 0b eb c8 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 fd
[   94.514092] RSP: 0018:ffff9ffa4ba1be00 EFLAGS: 00010286
[   94.514093] RAX: 0000000000000000 RBX: ffff8dc82b503e00 RCX: 0000000000000489
[   94.514094] RDX: 0000000000000001 RSI: 0000000000000096 RDI: 0000000000000247
[   94.514095] RBP: ffffffff8f6ffa6b R08: 0000000000000004 R09: 0000000000000489
[   94.514095] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000039
[   94.514096] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5045e4
[   94.514098] FS:  00007fa00f1f9240(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
[   94.514099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.514100] CR2: 0000557b53d25877 CR3: 00000004ca490005 CR4: 0000000000360ee0
[   94.514103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.514104] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.514105] Call Trace:
[   94.514821]  ptrace_stop+0x1a9/0x300
[   94.514824]  ptrace_do_notify+0x82/0xb0
[   94.514826]  ptrace_notify+0x4e/0x80
[   94.514835]  syscall_trace_enter+0x1c1/0x2a0
[   94.514838]  ? ptrace_notify+0x5a/0x80
[   94.514847]  do_syscall_64+0x81/0xd0
[   94.514859]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.514872] RIP: 0033:0x7fa00f3a7649
[   94.514873] Code: Bad RIP value.
[   94.514873] RSP: 002b:00007fffe6ac5fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ba
[   94.514875] RAX: ffffffffffffffda RBX: 00007fffe6ac603c RCX: 00007fa00f3a7649
[   94.514875] RDX: 00000000caf2bea2 RSI: 00000000caf1bea1 RDI: 00000000caf0bea0
[   94.514876] RBP: 000000000000857b R08: 00000000caf4bea4 R09: 00000000caf5bea5
[   94.514877] R10: 00000000caf3bea3 R11: 0000000000000246 R12: 0000000000000001
[   94.514878] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fa00f1f91b0
[   94.514879] ---[ end trace c9afdbbfeaf9d95b ]---
[   94.514885] ------------[ cut here ]------------
[   94.514888] WARNING: CPU: 16 PID: 34171 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.514888] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.514897] CPU: 16 PID: 34171 Comm: strace Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.514898] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.514899] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.514901] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.514902] RSP: 0018:ffff9ffa4ba1be20 EFLAGS: 00010202
[   94.514903] RAX: 0000000000000008 RBX: ffff8dc82b503e00 RCX: 0000000000000489
[   94.514904] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.514904] RBP: ffff8dc82b503e00 R08: 0000000000000004 R09: 0000000000000489
[   94.514905] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000004
[   94.514905] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5045e4
[   94.514906] FS:  00007fa00f1f9240(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
[   94.514907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.514907] CR2: 0000557b53d25877 CR3: 00000004ca490005 CR4: 0000000000360ee0
[   94.514910] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.514910] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.514910] Call Trace:
[   94.514912]  ptrace_do_notify+0x82/0xb0
[   94.514914]  ptrace_notify+0x4e/0x80
[   94.514915]  syscall_trace_enter+0x1c1/0x2a0
[   94.514917]  ? ptrace_notify+0x5a/0x80
[   94.514918]  do_syscall_64+0x81/0xd0
[   94.514919]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.514920] RIP: 0033:0x7fa00f3a7649
[   94.514921] Code: Bad RIP value.
[   94.514921] RSP: 002b:00007fffe6ac5fa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ba
[   94.514922] RAX: ffffffffffffffda RBX: 00007fffe6ac603c RCX: 00007fa00f3a7649
[   94.514923] RDX: 00000000caf2bea2 RSI: 00000000caf1bea1 RDI: 00000000caf0bea0
[   94.514923] RBP: 000000000000857b R08: 00000000caf4bea4 R09: 00000000caf5bea5
[   94.514924] R10: 00000000caf3bea3 R11: 0000000000000246 R12: 0000000000000001
[   94.514925] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fa00f1f91b0
[   94.514927] ---[ end trace c9afdbbfeaf9d95c ]---
[   94.530858] ------------[ cut here ]------------
[   94.530865] WARNING: CPU: 14 PID: 34001 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.530866] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.530877] CPU: 14 PID: 34001 Comm: add_key Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.530878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.530880] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.530882] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.530883] RSP: 0018:ffff9ffa4b6ebe20 EFLAGS: 00010202
[   94.530884] RAX: 0000000000000008 RBX: ffff8dcaf0803e00 RCX: ffff8dcb0bfaf0d0
[   94.530885] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.530886] RBP: ffff8dcaf0803e00 R08: 00000016027a4877 R09: ffff9ffa4b6ebd38
[   94.530886] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.530887] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcaf08045e4
[   94.530888] FS:  00007fb2b1699540(0000) GS:ffff8dcb0bf80000(0000) knlGS:0000000000000000
[   94.530889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.530890] CR2: 00007fb2b14ce000 CR3: 00000004ca4ec002 CR4: 0000000000360ee0
[   94.530892] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.530893] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.530893] Call Trace:
[   94.530897]  ptrace_do_notify+0x82/0xb0
[   94.530899]  ptrace_notify+0x4e/0x80
[   94.530901]  syscall_trace_enter+0x1c1/0x2a0
[   94.530903]  ? ptrace_notify+0x5a/0x80
[   94.530905]  do_syscall_64+0x81/0xd0
[   94.530908]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.530909] RIP: 0033:0x7fb2b15cb649
[   94.530910] Code: Bad RIP value.
[   94.530910] RSP: 002b:00007ffc3be69e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
[   94.530911] RAX: ffffffffffffffda RBX: 00007ffc3be69eb0 RCX: 00007fb2b15cb649
[   94.530912] RDX: 00007fb2b14c1ffb RSI: 0000000000000000 RDI: 00007fb2b14ce000
[   94.530913] RBP: 0000000000000005 R08: 00000000499602d2 R09: 0000004061f318cc
[   94.530913] R10: 0000000000000005 R11: 0000000000000246 R12: 00007fb2b14c1ffb
[   94.530914] R13: 0000000000000000 R14: 00007fb2b14ce000 R15: 00000000499602d2
[   94.530915] ---[ end trace c9afdbbfeaf9d95d ]---
[   94.536788] ------------[ cut here ]------------
[   94.536794] WARNING: CPU: 90 PID: 34001 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.536794] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.536808] CPU: 90 PID: 34001 Comm: add_key Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.536809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.536812] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.536813] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.536815] RSP: 0018:ffff9ffa4b6ebe68 EFLAGS: 00010202
[   94.536816] RAX: 0000000000000008 RBX: ffff8dcaf0803e00 RCX: ffff8dcae9a0bea8
[   94.536817] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.536818] RBP: ffff8dcaf0803e00 R08: 0000001602d4c2d5 R09: ffff9ffa4b6ebd80
[   94.536819] R10: 00000000000000f0 R11: 0000000000004850 R12: 0000000000000004
[   94.536820] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcaf08045e4
[   94.536822] FS:  00007fb2b1699540(0000) GS:ffff8dcb0d280000(0000) knlGS:0000000000000000
[   94.536823] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.536824] CR2: 00007fb2b14ce000 CR3: 00000004ca4ec001 CR4: 0000000000360ee0
[   94.536827] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.536828] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.536829] Call Trace:
[   94.536833]  ptrace_do_notify+0x82/0xb0
[   94.536835]  ptrace_notify+0x4e/0x80
[   94.536838]  __syscall_return_slowpath+0xa2/0x190
[   94.536840]  do_syscall_64+0x59/0xd0
[   94.536842]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.536844] RIP: 0033:0x7fb2b15cb649
[   94.536844] Code: Bad RIP value.
[   94.536845] RSP: 002b:00007ffc3be69e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
[   94.536847] RAX: fffffffffffffff2 RBX: 00007ffc3be69eb0 RCX: 00007fb2b15cb649
[   94.536847] RDX: 00007fb2b14c1ffb RSI: 000055ee42e9f4ae RDI: 00007fb2b14ce000
[   94.536848] RBP: 0000000000000000 R08: 00000000499602d2 R09: 0000004061f318cc
[   94.536849] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb2b14c1ffb
[   94.536850] R13: 000055ee42e9f4ae R14: 00007fb2b14ce000 R15: 00000000499602d2
[   94.536852] ---[ end trace c9afdbbfeaf9d95e ]---
[   94.550893] ------------[ cut here ]------------
[   94.550899] WARNING: CPU: 90 PID: 34001 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.550899] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.550913] CPU: 90 PID: 34001 Comm: add_key Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.550914] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.550916] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.550918] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.550919] RSP: 0018:ffff9ffa4b6ebe68 EFLAGS: 00010202
[   94.550921] RAX: 0000000000000008 RBX: ffff8dcaf0803e00 RCX: ffff8dcb0d2af0d0
[   94.550922] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.550922] RBP: ffff8dcaf0803e00 R08: 0000001603abff48 R09: ffff9ffa4b6ebd80
[   94.550923] R10: 0000000000001000 R11: ffffffffffffffff R12: 0000000000000004
[   94.550924] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcaf08045e4
[   94.550926] FS:  00007fb2b1699540(0000) GS:ffff8dcb0d280000(0000) knlGS:0000000000000000
[   94.550927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.550927] CR2: 00007fb2b14c8000 CR3: 00000004ca4ec001 CR4: 0000000000360ee0
[   94.550930] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.550931] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.550932] Call Trace:
[   94.550936]  ptrace_do_notify+0x82/0xb0
[   94.550938]  ptrace_notify+0x4e/0x80
[   94.550941]  __syscall_return_slowpath+0xa2/0x190
[   94.550942]  do_syscall_64+0x59/0xd0
[   94.550945]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.550947] RIP: 0033:0x7fb2b15cb649
[   94.550947] Code: Bad RIP value.
[   94.550948] RSP: 002b:00007ffc3be69e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
[   94.550950] RAX: fffffffffffffff2 RBX: 00007ffc3be69ed0 RCX: 00007fb2b15cb649
[   94.550950] RDX: 0000000000000000 RSI: 00007fb2b14c8000 RDI: 000055ee42e9f48a
[   94.550951] RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000004061f318cc
[   94.550952] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   94.550953] R13: 00007fb2b14c8000 R14: 000055ee42e9f48a R15: 00000000ffffffff
[   94.550955] ---[ end trace c9afdbbfeaf9d95f ]---
[   94.566316] ------------[ cut here ]------------
[   94.566334] WARNING: CPU: 133 PID: 34001 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.566335] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.566372] CPU: 133 PID: 34001 Comm: add_key Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.566374] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.566377] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.566382] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.566383] RSP: 0018:ffff9ffa4b6ebe20 EFLAGS: 00010202
[   94.566385] RAX: 0000000000000008 RBX: ffff8dcaf0803e00 RCX: ffff8dcb0dd6f0d0
[   94.566386] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.566387] RBP: ffff8dcaf0803e00 R08: 000000160497071c R09: ffff9ffa4b6ebd38
[   94.566388] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.566389] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcaf08045e4
[   94.566391] FS:  00007fb2b1699540(0000) GS:ffff8dcb0dd40000(0000) knlGS:0000000000000000
[   94.566392] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.566394] CR2: 00007fb2b14c8000 CR3: 00000004ca4ec004 CR4: 0000000000360ee0
[   94.566398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.566399] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.566400] Call Trace:
[   94.566412]  ptrace_do_notify+0x82/0xb0
[   94.566415]  ptrace_notify+0x4e/0x80
[   94.566424]  syscall_trace_enter+0x1c1/0x2a0
[   94.566427]  ? ptrace_notify+0x5a/0x80
[   94.566433]  do_syscall_64+0x81/0xd0
[   94.566444]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.566448] RIP: 0033:0x7fb2b15cb649
[   94.566449] Code: Bad RIP value.
[   94.566450] RSP: 002b:00007ffc3be69e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
[   94.566452] RAX: ffffffffffffffda RBX: 00007ffc3be69ec0 RCX: 00007fb2b15cb649
[   94.566453] RDX: 0000000000000000 RSI: 00007fb2b14c7ffb RDI: 000055ee42e9f4a2
[   94.566454] RBP: 0000000000000000 R08: 00000000b669fd2e R09: 0000004061f318cc
[   94.566455] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   94.566456] R13: 00007fb2b14c7ffb R14: 000055ee42e9f4a2 R15: 00000000b669fd2e
[   94.566458] ---[ end trace c9afdbbfeaf9d960 ]---
[   94.612500] ------------[ cut here ]------------
[   94.612509] WARNING: CPU: 16 PID: 34283 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.612509] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.612523] CPU: 16 PID: 34283 Comm: bpf-v Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.612524] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.612526] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.612528] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.612529] RSP: 0000:ffff9ffa4bc2be68 EFLAGS: 00010202
[   94.612530] RAX: 0000000000000008 RBX: ffff8dc82b500000 RCX: ffff8dcb07479fa8
[   94.612531] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.612532] RBP: ffff8dc82b500000 R08: 0000001607580b68 R09: ffff9ffa4bc2bd80
[   94.612533] R10: 00000000000001d8 R11: 0000000000000000 R12: 0000000000000004
[   94.612533] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5007e4
[   94.612534] FS:  00007fe90753a540(0000) GS:ffff8dcb0c000000(0000) knlGS:0000000000000000
[   94.612535] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.612536] CR2: 00005652adb3cedd CR3: 00000004e948a003 CR4: 0000000000360ee0
[   94.612538] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.612539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.612539] Call Trace:
[   94.612543]  ptrace_do_notify+0x82/0xb0
[   94.612545]  ptrace_notify+0x4e/0x80
[   94.612547]  __syscall_return_slowpath+0xa2/0x190
[   94.612549]  do_syscall_64+0x59/0xd0
[   94.612552]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.612554] RIP: 0033:0x7fe90746c649
[   94.612554] Code: Bad RIP value.
[   94.612555] RSP: 002b:00007ffdb0989058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[   94.612556] RAX: fffffffffffffff9 RBX: 000000000000000c RCX: 00007fe90746c649
[   94.612557] RDX: 0000000000000100 RSI: 00007fe90736ef00 RDI: 0000000000000009
[   94.612557] RBP: 00000000000000f4 R08: 0000000000000029 R09: 00007fe90736e000
[   94.612558] R10: 00000000000000f4 R11: 0000000000000246 R12: 0000563142bc2b60
[   94.612559] R13: 00007fe90736ef00 R14: 00007fe90736ef0c R15: 0000563142bc1cc0
[   94.612561] ---[ end trace c9afdbbfeaf9d961 ]---
[   94.631220] ------------[ cut here ]------------
[   94.631236] WARNING: CPU: 104 PID: 35100 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.631238] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.631279] CPU: 104 PID: 35100 Comm: dev--decode-fds Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.631281] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.631285] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.631288] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.631290] RSP: 0018:ffff9ffa4c8a3e68 EFLAGS: 00010202
[   94.631292] RAX: 0000000000000008 RBX: ffff8dcac53abe00 RCX: ffff8dcb0d62f0d0
[   94.631294] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.631295] RBP: ffff8dcac53abe00 R08: 000000160875712b R09: 0000000000000000
[   94.631297] R10: 0000000000000000 R11: ffffffff8e7e7960 R12: 0000000000000004
[   94.631298] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcac53ac5e4
[   94.631300] FS:  00007f05710fa540(0000) GS:ffff8dcb0d600000(0000) knlGS:0000000000000000
[   94.631301] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.631303] CR2: 00007f05710a4445 CR3: 00000004b5764004 CR4: 0000000000360ee0
[   94.631307] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.631308] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.631310] Call Trace:
[   94.631323]  ptrace_do_notify+0x82/0xb0
[   94.631326]  ptrace_notify+0x4e/0x80
[   94.631335]  __syscall_return_slowpath+0xa2/0x190
[   94.631342]  do_syscall_64+0x59/0xd0
[   94.631353]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.631358] RIP: 0033:0x7f0571022ab3
[   94.631359] Code: Bad RIP value.
[   94.631360] RSP: 002b:00007ffd9de146d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   94.631361] RAX: 000000000000017a RBX: 000000000000017a RCX: 00007f0571022ab3
[   94.631363] RDX: 000000000000017a RSI: 0000562ba5f532a0 RDI: 0000000000000001
[   94.631364] RBP: 0000562ba5f532a0 R08: 0000000000000002 R09: 0000000000000001
[   94.631365] R10: 0000562ba4ed00c0 R11: 0000000000000246 R12: 000000000000017a
[   94.631366] R13: 00007f05710f3500 R14: 000000000000017a R15: 00007f05710f3700
[   94.631368] ---[ end trace c9afdbbfeaf9d962 ]---
[   94.631394] ------------[ cut here ]------------
[   94.631398] WARNING: CPU: 104 PID: 35100 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.631398] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.631412] CPU: 104 PID: 35100 Comm: dev--decode-fds Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.631414] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.631416] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.631417] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.631419] RSP: 0018:ffff9ffa4c8a3e20 EFLAGS: 00010202
[   94.631421] RAX: 0000000000000008 RBX: ffff8dcac53abe00 RCX: ffff8dcb0d62f0d0
[   94.631422] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.631424] RBP: ffff8dcac53abe00 R08: 0000001608785ac0 R09: ffff9ffa4c8a3d38
[   94.631425] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.631426] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcac53ac5e4
[   94.631427] FS:  00007f05710fa540(0000) GS:ffff8dcb0d600000(0000) knlGS:0000000000000000
[   94.631428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.631430] CR2: 00007f0570ffea10 CR3: 00000004b5764004 CR4: 0000000000360ee0
[   94.631433] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.631434] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.631434] Call Trace:
[   94.631437]  ptrace_do_notify+0x82/0xb0
[   94.631439]  ptrace_notify+0x4e/0x80
[   94.631442]  syscall_trace_enter+0x1c1/0x2a0
[   94.631444]  do_syscall_64+0x81/0xd0
[   94.631446]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.631448] RIP: 0033:0x7f0570ffea39
[   94.631448] Code: Bad RIP value.
[   94.631449] RSP: 002b:00007ffd9de14858 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   94.631451] RAX: ffffffffffffffda RBX: 00007f05710f4470 RCX: 00007f0570ffea39
[   94.631452] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   94.631453] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 0000000000000001
[   94.631454] R10: 0000562ba4ed00c0 R11: 0000000000000246 R12: 00007f05710f4470
[   94.631455] R13: 0000000000000001 R14: 00007f05710f4948 R15: 0000000000000000
[   94.631457] ---[ end trace c9afdbbfeaf9d963 ]---
[   94.631472] ------------[ cut here ]------------
[   94.631474] WARNING: CPU: 104 PID: 35100 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.631475] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.631493] CPU: 104 PID: 35100 Comm: dev--decode-fds Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.631495] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.631497] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.631499] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.631500] RSP: 0018:ffff9ffa4c8a3e30 EFLAGS: 00010202
[   94.631502] RAX: 0000000000000008 RBX: ffff8dcac53abe00 RCX: ffff8dcb0d62f0d0
[   94.631503] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.631504] RBP: ffff8dcac53abe00 R08: 0000001608798a47 R09: ffff9ffa4c8a3d48
[   94.631505] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.631506] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcac53ac5e4
[   94.631508] FS:  00007f05710fa540(0000) GS:ffff8dcb0d600000(0000) knlGS:0000000000000000
[   94.631509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.631510] CR2: 00007f0570ffea10 CR3: 00000004b5764004 CR4: 0000000000360ee0
[   94.631515] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.631516] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.631517] Call Trace:
[   94.631520]  ptrace_do_notify+0x82/0xb0
[   94.631522]  ptrace_notify+0x4e/0x80
[   94.631526]  do_exit+0x3f4/0x440
[   94.631529]  do_group_exit+0x33/0xb0
[   94.631533]  __x64_sys_exit_group+0x14/0x20
[   94.631534]  do_syscall_64+0x4d/0xd0
[   94.631538]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.631540] RIP: 0033:0x7f0570ffea39
[   94.631541] Code: Bad RIP value.
[   94.631542] RSP: 002b:00007ffd9de14858 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   94.631544] RAX: ffffffffffffffda RBX: 00007f05710f4470 RCX: 00007f0570ffea39
[   94.631545] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[   94.631546] RBP: 0000000000000000 R08: ffffffffffffff80 R09: 0000000000000001
[   94.631547] R10: 0000562ba4ed00c0 R11: 0000000000000246 R12: 00007f05710f4470
[   94.631548] R13: 0000000000000001 R14: 00007f05710f4948 R15: 0000000000000000
[   94.631551] ---[ end trace c9afdbbfeaf9d964 ]---
[   94.656154] ------------[ cut here ]------------
[   94.656174] WARNING: CPU: 136 PID: 35298 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.656176] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.656221] CPU: 136 PID: 35298 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.656223] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.656226] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.656229] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.656231] RSP: 0018:ffff9ffa4cb93e20 EFLAGS: 00010202
[   94.656233] RAX: 0000000000000008 RBX: ffff8dcae9245d00 RCX: ffff8dcb0de2f0d0
[   94.656234] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.656235] RBP: ffff8dcae9245d00 R08: 0000001609f1ced2 R09: ffff9ffa4cb93d38
[   94.656236] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.656237] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcae92464e4
[   94.656239] FS:  00007f007334f580(0000) GS:ffff8dcb0de00000(0000) knlGS:0000000000000000
[   94.656240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.656241] CR2: 000056336d7b82a8 CR3: 00000004e91e6002 CR4: 0000000000360ee0
[   94.656245] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.656245] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.656247] Call Trace:
[   94.656264]  ptrace_do_notify+0x82/0xb0
[   94.656267]  ptrace_notify+0x4e/0x80
[   94.656276]  syscall_trace_enter+0x1c1/0x2a0
[   94.656280]  ? ptrace_notify+0x5a/0x80
[   94.656286]  do_syscall_64+0x81/0xd0
[   94.656299]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.656304] RIP: 0033:0x7f0073281649
[   94.656305] Code: Bad RIP value.
[   94.656305] RSP: 002b:00007fffbbf61ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000012d
[   94.656306] RAX: ffffffffffffffda RBX: 00007fffbbf62070 RCX: 00007f0073281649
[   94.656307] RDX: 0000000000000000 RSI: ffffffff00000000 RDI: deadfeed12345678
[   94.656308] RBP: 000056336c9c0100 R08: 00007f0073183fc0 R09: 0000000000000000
[   94.656309] R10: dec0ded0ffffffff R11: 0000000000000246 R12: dec0ded0ffffffff
[   94.656310] R13: 000056336c9bc541 R14: 0000000000000000 R15: deadfeed12345678
[   94.656313] ---[ end trace c9afdbbfeaf9d965 ]---
[   94.659440] ------------[ cut here ]------------
[   94.659463] WARNING: CPU: 108 PID: 34283 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.659464] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.659510] CPU: 108 PID: 34283 Comm: bpf-v Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.659512] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.659516] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.659519] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.659521] RSP: 0018:ffff9ffa4bc2be68 EFLAGS: 00010202
[   94.659522] RAX: 0000000000000008 RBX: ffff8dc82b500000 RCX: ffff8dcb0d72f0d0
[   94.659523] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.659524] RBP: ffff8dc82b500000 R08: 000000160a23e9fd R09: ffff9ffa4bc2bd80
[   94.659525] R10: 000000000000008e R11: 0000000000000000 R12: 0000000000000004
[   94.659525] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dc82b5007e4
[   94.659527] FS:  00007fe90753a540(0000) GS:ffff8dcb0d700000(0000) knlGS:0000000000000000
[   94.659528] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.659528] CR2: 0000000000000078 CR3: 00000004e948a001 CR4: 0000000000360ee0
[   94.659533] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.659533] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.659535] Call Trace:
[   94.659549]  ptrace_do_notify+0x82/0xb0
[   94.659551]  ptrace_notify+0x4e/0x80
[   94.659564]  __syscall_return_slowpath+0xa2/0x190
[   94.659574]  do_syscall_64+0x59/0xd0
[   94.659592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.659598] RIP: 0033:0x7fe90746c649
[   94.659599] Code: Bad RIP value.
[   94.659599] RSP: 002b:00007ffdb0989058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
[   94.659601] RAX: ffffffffffffffea RBX: 0000000000000004 RCX: 00007fe90746c649
[   94.659602] RDX: 0000000000000004 RSI: 00007fe90736effc RDI: 0000000000000017
[   94.659603] RBP: 00007fe90736effc R08: 0000000000000051 R09: 00007fe90736e000
[   94.659604] R10: 00000000ffffffff R11: 0000000000000246 R12: 0000563142bc2d20
[   94.659605] R13: 0000000000000000 R14: 0000000000000004 R15: 0000563142bc13c0
[   94.659607] ---[ end trace c9afdbbfeaf9d966 ]---
[   94.664425] ------------[ cut here ]------------
[   94.664431] WARNING: CPU: 136 PID: 35298 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.664432] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.664445] CPU: 136 PID: 35298 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.664446] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.664449] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.664451] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.664452] RSP: 0018:ffff9ffa4cb93e20 EFLAGS: 00010202
[   94.664454] RAX: 0000000000000008 RBX: ffff8dcae9245d00 RCX: ffff8dcb0de2f0d0
[   94.664454] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.664455] RBP: ffff8dcae9245d00 R08: 000000160a705a84 R09: ffff9ffa4cb93d38
[   94.664455] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.664456] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcae92464e4
[   94.664457] FS:  00007f007334f580(0000) GS:ffff8dcb0de00000(0000) knlGS:0000000000000000
[   94.664458] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.664459] CR2: 000055c8975af8e0 CR3: 00000004e91e6003 CR4: 0000000000360ee0
[   94.664462] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.664463] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.664463] Call Trace:
[   94.664467]  ptrace_do_notify+0x82/0xb0
[   94.664468]  ptrace_notify+0x4e/0x80
[   94.664471]  syscall_trace_enter+0x1c1/0x2a0
[   94.664473]  ? ptrace_notify+0x5a/0x80
[   94.664475]  do_syscall_64+0x81/0xd0
[   94.664477]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.664478] RIP: 0033:0x7f0073281649
[   94.664479] Code: Bad RIP value.
[   94.664479] RSP: 002b:00007fffbbf61ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000012d
[   94.664480] RAX: ffffffffffffffda RBX: 00007fffbbf62050 RCX: 00007f0073281649
[   94.664481] RDX: deadfeedffffffff RSI: badc0deddeadffff RDI: deadfeed12345678
[   94.664482] RBP: 000056336c9bc4ac R08: 0000000000000000 R09: 0000000000000000
[   94.664483] R10: badfacedffffff9c R11: 0000000000000246 R12: badfacedffffff9c
[   94.664484] R13: 000056336c9bc4e2 R14: deadfeedffffffff R15: deadfeed12345678
[   94.664485] ---[ end trace c9afdbbfeaf9d967 ]---
[   94.666489] ------------[ cut here ]------------
[   94.666493] WARNING: CPU: 136 PID: 35298 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.666494] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.666504] CPU: 136 PID: 35298 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.666505] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.666507] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.666509] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.666511] RSP: 0018:ffff9ffa4cb93e68 EFLAGS: 00010202
[   94.666512] RAX: 0000000000000008 RBX: ffff8dcae9245d00 RCX: ffff8dcb0de2f0d0
[   94.666513] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.666514] RBP: ffff8dcae9245d00 R08: 000000160a8fe311 R09: ffff9ffa4cb93d80
[   94.666515] R10: 00000000000003a9 R11: 0000000000000000 R12: 0000000000000004
[   94.666516] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcae92464e4
[   94.666517] FS:  00007f007334f580(0000) GS:ffff8dcb0de00000(0000) knlGS:0000000000000000
[   94.666518] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.666518] CR2: 000055c8975af8e0 CR3: 00000004e91e6003 CR4: 0000000000360ee0
[   94.666521] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.666522] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.666522] Call Trace:
[   94.666524]  ptrace_do_notify+0x82/0xb0
[   94.666526]  ptrace_notify+0x4e/0x80
[   94.666528]  __syscall_return_slowpath+0xa2/0x190
[   94.666530]  do_syscall_64+0x59/0xd0
[   94.666532]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.666533] RIP: 0033:0x7f0073281649
[   94.666534] Code: Bad RIP value.
[   94.666534] RSP: 002b:00007fffbbf61ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000012d
[   94.666535] RAX: ffffffffffffffea RBX: 00007fffbbf62070 RCX: 00007f0073281649
[   94.666536] RDX: 0000000000000000 RSI: ffffffff00000000 RDI: ffffffff00000000
[   94.666537] RBP: 000056336c9c0100 R08: 00007f0073183fc0 R09: 0000000000000000
[   94.666538] R10: defaced1beeff00d R11: 0000000000000246 R12: defaced1beeff00d
[   94.666539] R13: 000056336c9bc553 R14: 0000000000000000 R15: ffffffff00000000
[   94.666541] ---[ end trace c9afdbbfeaf9d968 ]---
[   94.686586] ------------[ cut here ]------------
[   94.686595] WARNING: CPU: 14 PID: 35298 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.686596] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.686612] CPU: 14 PID: 35298 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.686613] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.686616] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.686618] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.686619] RSP: 0018:ffff9ffa4cb93e20 EFLAGS: 00010202
[   94.686620] RAX: 0000000000000008 RBX: ffff8dcae9245d00 RCX: ffff8dcb0bfaf0d0
[   94.686621] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.686622] RBP: ffff8dcae9245d00 R08: 000000160bc27fae R09: ffff9ffa4cb93d38
[   94.686622] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.686623] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcae92464e4
[   94.686625] FS:  00007f007334f580(0000) GS:ffff8dcb0bf80000(0000) knlGS:0000000000000000
[   94.686626] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.686627] CR2: 00007f1b775583ec CR3: 00000004e91e6001 CR4: 0000000000360ee0
[   94.686630] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.686631] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.686631] Call Trace:
[   94.686636]  ptrace_do_notify+0x82/0xb0
[   94.686638]  ptrace_notify+0x4e/0x80
[   94.686641]  syscall_trace_enter+0x1c1/0x2a0
[   94.686643]  ? ptrace_notify+0x5a/0x80
[   94.686646]  do_syscall_64+0x81/0xd0
[   94.686648]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.686650] RIP: 0033:0x7f0073281649
[   94.686651] Code: Bad RIP value.
[   94.686652] RSP: 002b:00007fffbbf61ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000012d
[   94.686653] RAX: ffffffffffffffda RBX: 00007fffbbf62070 RCX: 00007f0073281649
[   94.686653] RDX: 0000000000000000 RSI: badc0deddeadffff RDI: ffffffff00000000
[   94.686654] RBP: 000056336c9c0100 R08: 00007f0073183fc0 R09: 0000000000000000
[   94.686655] R10: facefeed00000001 R11: 0000000000000246 R12: facefeed00000001
[   94.686656] R13: 000056336c9bc4b1 R14: 0000000000000000 R15: ffffffff00000000
[   94.686657] ---[ end trace c9afdbbfeaf9d969 ]---
[   94.695468] ------------[ cut here ]------------
[   94.695473] WARNING: CPU: 14 PID: 35298 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.695473] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.695483] CPU: 14 PID: 35298 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.695484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.695486] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.695488] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.695489] RSP: 0018:ffff9ffa4cb93e68 EFLAGS: 00010202
[   94.695490] RAX: 0000000000000008 RBX: ffff8dcae9245d00 RCX: ffff8dcb0bfaf0d0
[   94.695490] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.695491] RBP: ffff8dcae9245d00 R08: 000000160c4a101f R09: ffff9ffa4cb93d80
[   94.695492] R10: 000000000000026b R11: 0000000000000000 R12: 0000000000000004
[   94.695492] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcae92464e4
[   94.695493] FS:  00007f007334f580(0000) GS:ffff8dcb0bf80000(0000) knlGS:0000000000000000
[   94.695494] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.695494] CR2: 00007f1b775583ec CR3: 00000004e91e6001 CR4: 0000000000360ee0
[   94.695497] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.695497] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.695498] Call Trace:
[   94.695501]  ptrace_do_notify+0x82/0xb0
[   94.695503]  ptrace_notify+0x4e/0x80
[   94.695505]  __syscall_return_slowpath+0xa2/0x190
[   94.695506]  do_syscall_64+0x59/0xd0
[   94.695508]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.695510] RIP: 0033:0x7f0073281649
[   94.695510] Code: Bad RIP value.
[   94.695511] RSP: 002b:00007fffbbf61ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000012d
[   94.695511] RAX: ffffffffffffffea RBX: 00007fffbbf62050 RCX: 00007f0073281649
[   94.695512] RDX: deadfeedffffffff RSI: da7a105700000040 RDI: deb0d1edffffffff
[   94.695513] RBP: 000056336c9bc4ac R08: 0000000000000000 R09: 0000000000000000
[   94.695514] R10: dec0ded0ffffffff R11: 0000000000000246 R12: dec0ded0ffffffff
[   94.695514] R13: 000056336c9bc541 R14: deadfeedffffffff R15: deb0d1edffffffff
[   94.695516] ---[ end trace c9afdbbfeaf9d96a ]---
[   94.701366] ------------[ cut here ]------------
[   94.701382] WARNING: CPU: 17 PID: 35673 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.701382] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.701411] CPU: 17 PID: 35673 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.701412] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.701415] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.701418] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.701419] RSP: 0018:ffff9ffa4d043e20 EFLAGS: 00010202
[   94.701420] RAX: 0000000000000008 RBX: ffff8dca8478dd00 RCX: ffff8dcb0c06f0d0
[   94.701421] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.701422] RBP: ffff8dca8478dd00 R08: 000000160ca3d87c R09: ffff9ffa4d043d38
[   94.701422] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.701423] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dca8478e4e4
[   94.701424] FS:  00007f41e2690580(0000) GS:ffff8dcb0c040000(0000) knlGS:0000000000000000
[   94.701425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.701425] CR2: 00007f41e25718b0 CR3: 0000000480686006 CR4: 0000000000360ee0
[   94.701428] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.701429] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.701430] Call Trace:
[   94.701438]  ptrace_do_notify+0x82/0xb0
[   94.701441]  ptrace_notify+0x4e/0x80
[   94.701447]  syscall_trace_enter+0x1c1/0x2a0
[   94.701449]  ? ptrace_notify+0x5a/0x80
[   94.701454]  do_syscall_64+0x81/0xd0
[   94.701465]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.701468] RIP: 0033:0x7f41e26b10f7
[   94.701469] Code: Bad RIP value.
[   94.701470] RSP: 002b:00007fffb2191998 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
[   94.701470] RAX: ffffffffffffffda RBX: 00007f41e26c1140 RCX: 00007f41e26b10f7
[   94.701471] RDX: 0000000000000001 RSI: 0000000000001000 RDI: 000055fd0a8c2000
[   94.701472] RBP: 00007fffb2191ab0 R08: 0000000000000000 R09: 00007f41e24d7948
[   94.701472] R10: 000055fd0a8be000 R11: 0000000000000206 R12: 0000000000000000
[   94.701473] R13: 0000001600000005 R14: 000055fd0a8be5e8 R15: 0000000000000180
[   94.701474] ---[ end trace c9afdbbfeaf9d96b ]---
[   94.767957] ------------[ cut here ]------------
[   94.767973] WARNING: CPU: 17 PID: 35673 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.767975] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.768008] CPU: 17 PID: 35673 Comm: fanotify_mark-X Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.768010] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.768013] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.768016] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.768018] RSP: 0018:ffff9ffa4d043e20 EFLAGS: 00010202
[   94.768019] RAX: 0000000000000008 RBX: ffff8dca8478dd00 RCX: ffff8dcb0c06f0d0
[   94.768021] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.768022] RBP: ffff8dca8478dd00 R08: 00000016109becc9 R09: ffff9ffa4d043d38
[   94.768022] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000004
[   94.768023] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dca8478e4e4
[   94.768026] FS:  00007f41e2690580(0000) GS:ffff8dcb0c040000(0000) knlGS:0000000000000000
[   94.768027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.768028] CR2: 00007f77513ce578 CR3: 0000000480686006 CR4: 0000000000360ee0
[   94.768032] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.768033] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.768033] Call Trace:
[   94.768044]  ptrace_do_notify+0x82/0xb0
[   94.768047]  ptrace_notify+0x4e/0x80
[   94.768054]  syscall_trace_enter+0x1c1/0x2a0
[   94.768057]  ? ptrace_notify+0x5a/0x80
[   94.768063]  do_syscall_64+0x81/0xd0
[   94.768073]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.768077] RIP: 0033:0x7f41e25c2649
[   94.768077] Code: Bad RIP value.
[   94.768078] RSP: 002b:00007fffb2191be8 EFLAGS: 00000246 ORIG_RAX: 000000000000012d
[   94.768080] RAX: ffffffffffffffda RBX: 00007fffb2191c40 RCX: 00007f41e25c2649
[   94.768081] RDX: deadfeedffffffff RSI: dec0deddefacec00 RDI: deb0d1edffffffff
[   94.768081] RBP: 000055fd0a8c14aa R08: 0000000000000000 R09: 0000000000000000
[   94.768082] R10: badfacedffffff9c R11: 0000000000000246 R12: badfacedffffff9c
[   94.768083] R13: 000055fd0a8c14de R14: deadfeedffffffff R15: deb0d1edffffffff
[   94.768086] ---[ end trace c9afdbbfeaf9d96c ]---
[   94.796467] ------------[ cut here ]------------
[   94.796484] WARNING: CPU: 100 PID: 36327 at kernel/signal.c:2219 ptrace_stop+0x1d8/0x300
[   94.796485] Modules linked in: ata_generic(E) pata_acpi(E) crc32_pclmul(E) qemu_fw_cfg(E) ata_piix(E) e1000(E) nls_iso8859_1(E) nls_cp437(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) xfs(E) btrfs(E) blake2b_generic(E) xor(E) raid6_pq(E) libcrc32c(E) crc32c_intel(E) reiserfs(E) squashfs(E) fuse(E) dm_snapshot(E) dm_bufio(E) dm_crypt(E) dm_mod(E) binfmt_misc(E) loop(E) sg(E) virtio_rng(E)
[   94.796517] CPU: 100 PID: 36327 Comm: ioctl_evdev-Xra Tainted: G        W   E     5.8.0-rc5-100.g55927f9-default #1 openSUSE Tumbleweed (unreleased)
[   94.796519] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-rebuilt.suse.com 04/01/2014
[   94.796523] RIP: 0010:ptrace_stop+0x1d8/0x300
[   94.796526] Code: 8b 05 50 42 dd 01 85 c0 0f 85 27 01 00 00 bf 01 00 00 00 e8 9a f4 0b 00 65 48 8b 04 25 c0 9b 01 00 48 8b 40 10 48 85 c0 74 52 <0f> 0b eb 4e 48 8b 93 28 05 00 00 48 3b 82 60 04 00 00 0f 85 14 ff
[   94.796527] RSP: 0018:ffff9ffa4d40be68 EFLAGS: 00010202
[   94.796528] RAX: 0000000000000008 RBX: ffff8dcacddb1f00 RCX: ffff8dcb0d52f0d0
[   94.796529] RDX: 0000000000000001 RSI: 0000000000000039 RDI: ffffffff9028a344
[   94.796530] RBP: ffff8dcacddb1f00 R08: 00000016124ee8b4 R09: ffff9ffa4d40bd80
[   94.796530] R10: 0000000000000379 R11: 0000000000000000 R12: 0000000000000004
[   94.796531] R13: 0000000000000000 R14: 0000000000000001 R15: ffff8dcacddb26e4
[   94.796533] FS:  00007f9dadbde540(0000) GS:ffff8dcb0d500000(0000) knlGS:0000000000000000
[   94.796534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   94.796535] CR2: 00007f9dadb88445 CR3: 00000004ed4f2006 CR4: 0000000000360ee0
[   94.796538] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   94.796539] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   94.796541] Call Trace:
[   94.796550]  ptrace_do_notify+0x82/0xb0
[   94.796552]  ptrace_notify+0x4e/0x80
[   94.796560]  __syscall_return_slowpath+0xa2/0x190
[   94.796564]  do_syscall_64+0x59/0xd0
[   94.796573]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   94.796577] RIP: 0033:0x7f9dadb0c7b7
[   94.796578] Code: Bad RIP value.
[   94.796579] RSP: 002b:00007ffd217e82d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   94.796581] RAX: fffffffffffffff7 RBX: 0000000000000000 RCX: 00007f9dadb0c7b7
[   94.796582] RDX: 0000000000000000 RSI: 000000008008450a RDI: 00000000ffffffff
[   94.796583] RBP: 00005595e26c2250 R08: 00000000ffffffff R09: 000000000000003d
[   94.796584] R10: 00007f9dadba2456 R11: 0000000000000246 R12: 00005595e26c1eb0
[   94.796585] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   94.796587] ---[ end trace c9afdbbfeaf9d96d ]---

--------------83D230D142721D4635144020--

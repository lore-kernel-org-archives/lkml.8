Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196E9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF4E20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H2rCyxXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbgG0Sj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgG0Sj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:39:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:39:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n5so10336861pgf.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=5SjiHVF5K05Ad662Oqs9E4NN0w7LmJ1sGAJcDqVt/jk=;
        b=H2rCyxXgSwnSdz+xhFbNXdweVwuP9+63kxZVTzUAxz0R78LHkCygEDetY+gM4k7q0c
         Z5fP6AqplvAaM5WqUzaTbWOwl5VxGg5HL2bjkaekJMLh4byuWgZL6R4r9PdUnxYfSwPh
         vjCAS/LreMxUtAWVUCe6iZaCvi/DmOm6nj8wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=5SjiHVF5K05Ad662Oqs9E4NN0w7LmJ1sGAJcDqVt/jk=;
        b=YkW1VBIbWKJNSlgHvBdofOgit8bQrkF3MH7UtMeYu93D7yttz6nDlribqaG0Blui/A
         pxasE/pHGDn6kmh6rYh/G19AiadVtXBOyKijxZl8u50uTclhVG0H9a1GkqK6Vqpf5bPU
         V5T7PL9jJZNYUqI1lV5PszjAY138BRk9E22EC0yxT3A65gppdw96Q4eKsAZT4gtOgs5z
         QLxG/ZbQ3m5JRyxKIuJeZCf6mz/g7Jdkjjq4rPIf0V8TFeO4OAju8RJ2zP/P+hbbCDty
         fF8UOaZZc3j+j/jjSOki+M9+JvJl0a/xGcYWpfcUiT2338StOidEWbDTB91F00ktGoRX
         L0eg==
X-Gm-Message-State: AOAM5305EMOnIFEkCaS5OhL29X9BU2L3uNHsA1Ap4hwvyzGEhumC5CcD
        1BdzyBXK2fQtro6uH61kFyHf82JgLnAl/Rc6D53cbrrtXZQNpJmH/3rsrFqkipmKBmFvSQu8KnX
        hN7WISXlkLkRkbKrR5nFTuW4+ks4Yx3q6WaY2OF3IJ1lHAtVy28AwqcpUJzdDu7LQlQvTiPv4bt
        s+zJYJJdMz
X-Google-Smtp-Source: ABdhPJyl6RtlPoONFl3kxeMtRq+6z8Qx7vOpoPgMkt+QVncWrGfYvje6RsW4neG+Szqy2v+xLuRmkg==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr21544973pgk.334.1595875166152;
        Mon, 27 Jul 2020 11:39:26 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id s131sm16137015pgc.30.2020.07.27.11.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:39:25 -0700 (PDT)
To:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
From:   Scott Branden <scott.branden@broadcom.com>
Subject: Kernel panic - not syncing: IO-APIC + timer doesn't work!
Message-ID: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
Date:   Mon, 27 Jul 2020 11:39:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Occasionally I get the following Kernel panic on boot.  This is running on the latest kernel but have seen it previously as well.
"Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report."

I don't know who I am support to send a report to.  But here is the log with apic=debug

Regards,
Scott

Loading /bzImage... ok
[    0.000000] Linux version 5.8.0-rc6 (oe-user@oe-host) (x86_64-poky-linux-gcc (GCC) 10.1.0, GNU ld (GNU Binutils) 2.34.0.20200220) #1 SMP Sat Jul 25 03:55:25 UTC 2020
[    0.000000] Command line: BOOT_IMAGE=/bzImage ima_policy=tcb apic=debug ip=dhcp raid=noautodetect console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfs/vxc,hard,tcp,g
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009d01fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009d02000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20bfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20c000-0x00000000d8983fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d8984000-0x00000000d8acdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000d8ace000-0x00000000d8c56fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000d8c57000-0x00000000d9107fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000d9108000-0x00000000da55cfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000da55d000-0x00000000dcffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000dfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041f37ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: System manufacturer System Product Name/PRIME X570-P, BIOS 1405 11/19/2019
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] last_pfn = 0x41f380 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT 
[    0.000000] last_pfn = 0xdd000 max_arch_pfn = 0x400000000
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] Scan for SMP in [mem 0x0009d400-0x0009d7ff]
[    0.000000] check: Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05A0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000D8BF30A0 0000BC (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000D8BFEBF0 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000D8BF31F8 00B9F4 (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000D90F0E00 000040
[    0.000000] ACPI: APIC 0x00000000D8BFED08 00015E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000D8BFEE68 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000D8BFEEB0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000D8BFEF50 0000C8 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.000000] ACPI: WSMT 0x00000000D8C10E08 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000D8BFF070 008C98 (v02 AMD    AMD ALIB 00000002 MSFT 04000000)
[    0.000000] ACPI: SSDT 0x00000000D8C07D08 00368A (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000D8C0B398 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000D8C0B3D8 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: SSDT 0x00000000D8C0B410 000024 (v01 AMD    BIXBY    00001000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x00000000D8C0B438 000042 (v01 ALASKA A M I    00000002      01000013)
[    0.000000] ACPI: WPBT 0x00000000D8C0B480 00003C (v01 ALASKA A M I    00000001 ASUS 00000001)
[    0.000000] ACPI: IVRS 0x00000000D8C0B4C0 0000D0 (v02 AMD    AMD IVRS 00000001 AMD  00000000)
[    0.000000] ACPI: PCCT 0x00000000D8C0B590 00006E (v01 AMD    AMD PCCT 00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000D8C0B600 002F29 (v01 AMD    AMD CPU  00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000D8C0E530 000B58 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x00000000D8C0F088 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000D8C0F0B8 001D4A (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000041f37ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x41f37c000-0x41f37ffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000041f37ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009d01fff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.000000]   node   0: [mem 0x000000000a20c000-0x00000000d8983fff]
[    0.000000]   node   0: [mem 0x00000000da55d000-0x00000000dcffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000041f37ffff]
[    0.000000] Zeroed struct page in unavailable ranges: 23495 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000041f37ffff]
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID d, APIC INT 02
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] Int: type 0, pol 3, trig 3, bus 00, IRQ 09, APIC ID d, APIC INT 09
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID d, APIC INT 01
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID d, APIC INT 03
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID d, APIC INT 04
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID d, APIC INT 05
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID d, APIC INT 06
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID d, APIC INT 07
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID d, APIC INT 08
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID d, APIC INT 0a
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID d, APIC INT 0b
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID d, APIC INT 0c
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID d, APIC INT 0d
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID d, APIC INT 0e
[    0.000000] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID d, APIC INT 0f
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 20 hotplug CPUs
[    0.000000] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.000000] mapped IOAPIC to ffffffffff5fa000 (fec01000)
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x09d02000-0x09ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20bfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd8984000-0xd8acdfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd8ace000-0xd8c56fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd8c57000-0xd9107fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd9108000-0xda55cfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xdd000000-0xdfffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfcffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd000000-0xffffffff]
[    0.000000] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:32 nr_node_ids:1
[    0.000000] percpu: Embedded 52 pages/cpu s172760 r8192 d32040 u262144
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 4105617
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/bzImage ima_policy=tcb apic=debug ip=dhcp raid=noautodetect console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfs/vxc,hag
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 16288908K/16683236K available (16388K kernel code, 1982K rwdata, 4144K rodata, 1604K init, 1484K bss, 394328K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.000000] ftrace: allocating 48968 entries in 192 pages
[    0.000000] ftrace: allocated 192 pages with 2 groups
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=32.
[    0.000000]  Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.000000] NR_IRQS: 4352, nr_irqs: 1224, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x361/0x531 with crng_init=0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] printk: console [ttyS0] enabled
[    0.000000] ACPI: Core revision 20200528
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.001000] Switched APIC routing to physical flat.
[    0.003000] enabled ExtINT on CPU#0
[    0.006000] ENABLING IO-APIC IRQs
[    0.007000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.007000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.007000] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.007000] ..... (found apic 0 pin 2) ...
[    0.007000] ....... failed.
[    0.007000] ...trying to set up timer as Virtual Wire IRQ...
[    0.007000] ..... failed.
[    0.007000] ...trying to set up timer as ExtINT IRQ...
[    0.007000] ..... failed :(.
[    0.007000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
[    0.007000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc6 #1
[    0.007000] Hardware name: System manufacturer System Product Name/PRIME X570-P, BIOS 1405 11/19/2019
[    0.007000] Call Trace:
[    0.007000]  dump_stack+0x78/0xa0
[    0.007000]  panic+0x100/0x2c6
[    0.007000]  setup_IO_APIC+0x826/0x86a
[    0.007000]  ? clear_IO_APIC_pin+0x173/0x240
[    0.007000]  x86_late_time_init+0x20/0x30
[    0.007000]  start_kernel+0x478/0x531
[    0.007000]  secondary_startup_64+0xb6/0xc0
[    0.007000] ---[ end Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option. ]---


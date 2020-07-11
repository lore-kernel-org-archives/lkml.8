Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FE7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C782078B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0xNK3Ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGKAXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKAXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:23:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15A4C08C5DC;
        Fri, 10 Jul 2020 17:23:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e11so7066622qkm.3;
        Fri, 10 Jul 2020 17:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kttdSIa4lRhiVwgpzoVD0bKA5IVuSKlNRtKvIPQ/gms=;
        b=L0xNK3ObjUbaEQn1sKGy1RMntwUArjDfTPaiYrm7Bk22A2NTnFY6X1TiA+bvWjOOBV
         FVAwvi1zbutvGULV5s1v21xbzZNyaaUp+VgLNixbW3z8vzth3NZG2XOtYXawBxKirJB4
         Wc+rkhkDcPa1jy4giaKVUe0IcSh6830Rxrk/FNhyf2B8kgHqcvGm1t99skMO+valUvqK
         bJkzcOZwV7sX/gK5Q5kvnLcb0v85DQoALqKDFhT3yaDc4k4PFZGM7+UeTvb6YH/Quvqf
         xeUXz4UrfD+y08qsyinxCd7efM/Kv3/Oqh7O8YenNQRCdJub+6H0WbJqjaabj0duj6jz
         /dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kttdSIa4lRhiVwgpzoVD0bKA5IVuSKlNRtKvIPQ/gms=;
        b=h/w4Ei5bq+pv9rQ9/BrahbjULWVgRPENAw3P2LoKxRl1+AiURkqvEUqCjmKM50fyzp
         IMvhRV8W60L/zVKbLApTGGvMH6sJSsv7dlIfxDuKHCSsZZ5HBODOg+47hh7A5YzLzNua
         Cu8YPdJ3soAz7NKbsDfsD1SHEPt6IRgp7xK7KwrteuxS3+b5qiifsPOZTvPDIo1F+wZ6
         UilD2oNEJily3vVQg+htUGqnqKPQpmq6cyeCKQMzfSKaTbRENoy8oGjQd/9DsXfCNfnl
         frYcs4ryLL9SxrzWRa4j0O2PKyUySvFtlZe7fKsZblmpg+jbHJanxl5dWlIQc6xRkpNr
         gYww==
X-Gm-Message-State: AOAM530IpRttYgr3AZ8i3HQH9uEZde1oP0glbvzlyvXltPeUe21HI1JS
        2WL4sCpaiodKAfQTd8KQjGcqwbV4UvhXtTlg8Mk6MIev
X-Google-Smtp-Source: ABdhPJxNQtlD9UmUz26RQfFswEZcltkUjhiuLjAlnnnQBjcSaRI9lPJi62bARz5LdrRJo8Sl7dmxUrMBJ/XBhd8+ZUs=
X-Received: by 2002:a37:6295:: with SMTP id w143mr67892477qkb.486.1594427015120;
 Fri, 10 Jul 2020 17:23:35 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Hancock <hancockrwd@gmail.com>
Date:   Fri, 10 Jul 2020 18:23:23 -0600
Message-ID: <CADLC3L20DuXw8WbS=SApmu2m49mkxxWKZrMJS_GBHDX7Vh0TvQ@mail.gmail.com>
Subject: 5.7 regression: Lots of PCIe AER errors and suspend failure without pcie=noaer
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed a problem on my desktop with an Asus PRIME H270-PRO
motherboard after Fedora 32 upgraded to the 5.7 kernel (now on 5.7.8):
periodically there are PCIe AER errors getting spewed in dmesg that
weren't happening before, and this also seems to causes suspend to
fail - the system just wakes back up again right away, I am assuming
due to some AER errors interrupting the process. 5.6 kernels didn't
have this problem. Setting "pcie=3Dnoaer" on the kernel command line
works around the issue, but I'm not sure what would have changed to
trigger this to occur?

The errors look like this:

[    0.757005] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[    0.757011] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[    0.757012] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[    0.757013] pcieport 0000:00:1c.0: AER:    [12] Timeout

That device referenced is one of the Intel PCH PCIe root ports, which
seems to be connected to this PCIe to PCI bridge:

02:00.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1083/1085 PCIe
to PCI Bridge [1b21:1080] (rev 04)

which in turn has nothing connected to it. I've seen reports of this
stupid ASMedia bridge device causing issues due to non-compliant
behavior in the past, this may be another case of such.

Previously reported as a Fedora bug here:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1853960

Details follow:

lspci -nn:
00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v6/7th Gen
Core Processor Host Bridge/DRAM Registers [8086:591f] (rev 05)
00:02.0 VGA compatible controller [0300]: Intel Corporation HD
Graphics 630 [8086:5912] (rev 04)
00:14.0 USB controller [0c03]: Intel Corporation 200 Series/Z370
Chipset Family USB 3.0 xHCI Controller [8086:a2af]
00:16.0 Communication controller [0780]: Intel Corporation 200 Series
PCH CSME HECI #1 [8086:a2ba]
00:17.0 SATA controller [0106]: Intel Corporation 200 Series PCH SATA
controller [AHCI mode] [8086:a282]
00:1b.0 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI
Express Root Port #19 [8086:a2e9] (rev f0)
00:1c.0 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI
Express Root Port #3 [8086:a292] (rev f0)
00:1c.4 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI
Express Root Port #5 [8086:a294] (rev f0)
00:1d.0 PCI bridge [0604]: Intel Corporation 200 Series PCH PCI
Express Root Port #9 [8086:a298] (rev f0)
00:1f.0 ISA bridge [0601]: Intel Corporation 200 Series PCH LPC
Controller (H270) [8086:a2c4]
00:1f.2 Memory controller [0580]: Intel Corporation 200 Series/Z370
Chipset Family Power Management Controller [8086:a2a1]
00:1f.3 Audio device [0403]: Intel Corporation 200 Series PCH HD Audio
[8086:a2f0]
00:1f.4 SMBus [0c05]: Intel Corporation 200 Series/Z370 Chipset Family
SMBus Controller [8086:a2a3]
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet
Connection (2) I219-V [8086:15b8]
02:00.0 PCI bridge [0604]: ASMedia Technology Inc. ASM1083/1085 PCIe
to PCI Bridge [1b21:1080] (rev 04)
04:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1142 USB 3.1
Host Controller [1b21:1242]
05:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co
Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]

lspci -t:
[root@haswell linux]# lspci -t
-[0000:00]-+-00.0
           +-02.0
           +-14.0
           +-16.0
           +-17.0
           +-1b.0-[01]--
           +-1c.0-[02-03]----00.0-[03]--
           +-1c.4-[04]----00.0
           +-1d.0-[05]----00.0
           +-1f.0
           +-1f.2
           +-1f.3
           +-1f.4
           \-1f.6

dmesg:
[    0.008064] ACPI: Local APIC address 0xfee00000
[    0.008171] No NUMA configuration found
[    0.008172] Faking a node at [mem 0x0000000000000000-0x0000000436ffffff]
[    0.008180] NODE_DATA(0) allocated [mem 0x436fd4000-0x436ffefff]
[    0.027257] Zone ranges:
[    0.027258]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.027259]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.027259]   Normal   [mem 0x0000000100000000-0x0000000436ffffff]
[    0.027260]   Device   empty
[    0.027260] Movable zone start for each node
[    0.027263] Early memory node ranges
[    0.027263]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.027264]   node   0: [mem 0x0000000000059000-0x000000000008ffff]
[    0.027264]   node   0: [mem 0x0000000000091000-0x000000000009dfff]
[    0.027265]   node   0: [mem 0x0000000000100000-0x00000000b4105fff]
[    0.027265]   node   0: [mem 0x00000000b413b000-0x00000000b44f6fff]
[    0.027266]   node   0: [mem 0x00000000b44f9000-0x00000000c1141fff]
[    0.027266]   node   0: [mem 0x00000000c29d5000-0x00000000c2a1afff]
[    0.027266]   node   0: [mem 0x00000000c33a1000-0x00000000c33fefff]
[    0.027267]   node   0: [mem 0x0000000100000000-0x0000000436ffffff]
[    0.027483] Zeroed struct page in unavailable ranges: 32438 pages
[    0.027483] Initmem setup node 0 [mem 0x0000000000001000-0x0000000436fff=
fff]
[    0.027485] On node 0 totalpages: 4161866
[    0.027485]   DMA zone: 64 pages used for memmap
[    0.027486]   DMA zone: 22 pages reserved
[    0.027486]   DMA zone: 3995 pages, LIFO batch:0
[    0.027524]   DMA32 zone: 12295 pages used for memmap
[    0.027524]   DMA32 zone: 786863 pages, LIFO batch:63
[    0.035543]   Normal zone: 52672 pages used for memmap
[    0.035543]   Normal zone: 3371008 pages, LIFO batch:63
[    0.067800] Reserving Intel graphics memory at [mem 0xc4000000-0xc7fffff=
f]
[    0.068619] ACPI: PM-Timer IO Port: 0x1808
[    0.068620] ACPI: Local APIC address 0xfee00000
[    0.068624] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.068624] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.068625] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.068625] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.068652] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.068653] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.068654] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.068654] ACPI: IRQ0 used by override.
[    0.068655] ACPI: IRQ9 used by override.
[    0.068656] Using ACPI (MADT) for SMP configuration information
[    0.068657] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.068661] e820: update [mem 0xbe842000-0xbe887fff] usable =3D=3D> rese=
rved
[    0.068669] TSC deadline timer available
[    0.068669] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.068687] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.068688] PM: hibernation: Registered nosave memory: [mem
0x00058000-0x00058fff]
[    0.068689] PM: hibernation: Registered nosave memory: [mem
0x00090000-0x00090fff]
[    0.068690] PM: hibernation: Registered nosave memory: [mem
0x0009e000-0x000fffff]
[    0.068691] PM: hibernation: Registered nosave memory: [mem
0xb3af2000-0xb3af2fff]
[    0.068692] PM: hibernation: Registered nosave memory: [mem
0xb3b02000-0xb3b02fff]
[    0.068693] PM: hibernation: Registered nosave memory: [mem
0xb3b03000-0xb3b03fff]
[    0.068694] PM: hibernation: Registered nosave memory: [mem
0xb3b13000-0xb3b13fff]
[    0.068695] PM: hibernation: Registered nosave memory: [mem
0xb4106000-0xb413afff]
[    0.068696] PM: hibernation: Registered nosave memory: [mem
0xb44f7000-0xb44f7fff]
[    0.068697] PM: hibernation: Registered nosave memory: [mem
0xb44f8000-0xb44f8fff]
[    0.068698] PM: hibernation: Registered nosave memory: [mem
0xbe842000-0xbe887fff]
[    0.068699] PM: hibernation: Registered nosave memory: [mem
0xbf28a000-0xbf28afff]
[    0.068700] PM: hibernation: Registered nosave memory: [mem
0xc1142000-0xc29c1fff]
[    0.068700] PM: hibernation: Registered nosave memory: [mem
0xc29c2000-0xc29d4fff]
[    0.068702] PM: hibernation: Registered nosave memory: [mem
0xc2a1b000-0xc2a72fff]
[    0.068702] PM: hibernation: Registered nosave memory: [mem
0xc2a73000-0xc33a0fff]
[    0.068703] PM: hibernation: Registered nosave memory: [mem
0xc33ff000-0xc7ffffff]
[    0.068704] PM: hibernation: Registered nosave memory: [mem
0xc8000000-0xf7ffffff]
[    0.068704] PM: hibernation: Registered nosave memory: [mem
0xf8000000-0xfbffffff]
[    0.068704] PM: hibernation: Registered nosave memory: [mem
0xfc000000-0xfdffffff]
[    0.068705] PM: hibernation: Registered nosave memory: [mem
0xfe000000-0xfe010fff]
[    0.068705] PM: hibernation: Registered nosave memory: [mem
0xfe011000-0xfebfffff]
[    0.068705] PM: hibernation: Registered nosave memory: [mem
0xfec00000-0xfec00fff]
[    0.068706] PM: hibernation: Registered nosave memory: [mem
0xfec01000-0xfecfffff]
[    0.068706] PM: hibernation: Registered nosave memory: [mem
0xfed00000-0xfed00fff]
[    0.068706] PM: hibernation: Registered nosave memory: [mem
0xfed01000-0xfedfffff]
[    0.068707] PM: hibernation: Registered nosave memory: [mem
0xfee00000-0xfee00fff]
[    0.068707] PM: hibernation: Registered nosave memory: [mem
0xfee01000-0xfeffffff]
[    0.068707] PM: hibernation: Registered nosave memory: [mem
0xff000000-0xffffffff]
[    0.068708] [mem 0xc8000000-0xf7ffffff] available for PCI devices
[    0.068709] Booting paravirtualized kernel on bare hardware
[    0.068711] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.072763] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4
nr_cpu_ids:4 nr_node_ids:1
[    0.072867] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u524288
[    0.072872] pcpu-alloc: s188416 r8192 d28672 u524288 alloc=3D1*2097152
[    0.072872] pcpu-alloc: [0] 0 1 2 3
[    0.072893] Built 1 zonelists, mobility grouping on.  Total pages: 40968=
13
[    0.072893] Policy zone: Normal
[    0.072894] Kernel command line:
BOOT_IMAGE=3D(hd3,gpt2)/vmlinuz-5.7.8-200.fc32.x86_64
root=3D/dev/mapper/fedora-root ro rd.lvm.lv=3Dfedora/swap
vconsole.font=3Dlatarcyrheb-sun16 rd.lvm.lv=3Dfedora/root rhgb quiet
intel_iommu=3Don,igfx_off acpi_enforce_resources=3Dlax
[    0.072971] DMAR: IOMMU enabled
[    0.072971] DMAR: Disable GFX device mapping
[    0.073568] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.073873] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.073908] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.101867] Memory: 16009524K/16647464K available (14339K kernel
code, 2406K rwdata, 8164K rodata, 2472K init, 5072K bss, 637940K
reserved, 0K cma-reserved)
[    0.101872] random: get_random_u64 called from
__kmem_cache_create+0x3e/0x610 with crng_init=3D0
[    0.101952] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.101962] Kernel/User page tables isolation: enabled
[    0.101977] ftrace: allocating 41358 entries in 162 pages
[    0.113354] ftrace: allocated 162 pages with 3 groups
[    0.113552] rcu: Hierarchical RCU implementation.
[    0.113553] rcu:     RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_=
ids=3D4.
[    0.113553]     Tasks RCU enabled.
[    0.113554] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.113554] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.115852] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    0.116287] random: crng done (trusting CPU's manufacturer)
[    0.116305] Console: colour dummy device 80x25
[    0.116309] printk: console [tty0] enabled
[    0.116322] ACPI: Core revision 20200326
[    0.116584] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 79635855245 ns
[    0.116665] APIC: Switch to symmetric I/O mode setup
[    0.116666] DMAR: Host address width 39
[    0.116667] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.116671] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
1c0000c40660462 ecap 19e2ff0505e
[    0.116671] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.116674] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008c40660462 ecap f050da
[    0.116674] DMAR: RMRR base: 0x000000c1951000 end: 0x000000c1970fff
[    0.116675] DMAR: RMRR base: 0x000000c3800000 end: 0x000000c7ffffff
[    0.116677] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.116677] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.116678] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    0.118138] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.118139] x2apic enabled
[    0.118152] Switched APIC routing to cluster x2apic.
[    0.122087] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.126647] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x3101f59f5e6, max_idle_ns: 440795259996 ns
[    0.126650] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6799.81 BogoMIPS (lpj=3D3399906)
[    0.126651] pid_max: default: 32768 minimum: 301
[    0.132684] LSM: Security Framework initializing
[    0.132692] Yama: becoming mindful.
[    0.132696] SELinux:  Initializing.
[    0.132736] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    0.132754] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    0.132945] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.132961] process: using mwait in idle threads
[    0.132963] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    0.132963] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.132965] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.132966] Spectre V2 : Mitigation: Full generic retpoline
[    0.132966] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.132967] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.132968] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.132969] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.132972] TAA: Mitigation: Clear CPU buffers
[    0.132975] SRBDS: Mitigation: Microcode
[    0.132976] MDS: Mitigation: Clear CPU buffers
[    0.133200] Freeing SMP alternatives memory: 36K
[    0.135317] smpboot: CPU0: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
(family: 0x6, model: 0x9e, stepping: 0x9)
[    0.135409] Performance Events: PEBS fmt3+, Skylake events, 32-deep
LBR, full-width counters, Intel PMU driver.
[    0.135413] ... version:                4
[    0.135413] ... bit width:              48
[    0.135414] ... generic registers:      8
[    0.135414] ... value mask:             0000ffffffffffff
[    0.135414] ... max period:             00007fffffffffff
[    0.135415] ... fixed-purpose events:   3
[    0.135415] ... event mask:             00000007000000ff
[    0.135442] rcu: Hierarchical SRCU implementation.
[    0.135648] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.135648] smp: Bringing up secondary CPUs ...
[    0.135648] x86: Booting SMP configuration:
[    0.135648] .... node  #0, CPUs:      #1 #2 #3
[    0.140240] smp: Brought up 1 node, 4 CPUs
[    0.140240] smpboot: Max logical packages: 1
[    0.140240] smpboot: Total of 4 processors activated (27199.24 BogoMIPS)
[    0.141009] devtmpfs: initialized
[    0.141009] x86/mm: Memory block size: 128MB
[    0.142077] PM: Registering ACPI NVS region [mem
0xb44f7000-0xb44f7fff] (4096 bytes)
[    0.142077] PM: Registering ACPI NVS region [mem
0xc2a1b000-0xc2a72fff] (360448 bytes)
[    0.142077] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.142077] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.142077] pinctrl core: initialized pinctrl subsystem
[    0.142077] PM: RTC time: 00:06:30, date: 2020-07-11
[    0.142077] thermal_sys: Registered thermal governor 'fair_share'
[    0.142077] thermal_sys: Registered thermal governor 'bang_bang'
[    0.142077] thermal_sys: Registered thermal governor 'step_wise'
[    0.142077] thermal_sys: Registered thermal governor 'user_space'
[    0.142077] NET: Registered protocol family 16
[    0.142077] audit: initializing netlink subsys (disabled)
[    0.142077] audit: type=3D2000 audit(1594425990.022:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.142077] cpuidle: using governor menu
[    0.142676] ACPI: bus type PCI registered
[    0.142677] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.142732] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.142734] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E82=
0
[    0.142739] PCI: Using configuration type 1 for base access
[    0.144260] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.144260] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.240655] cryptd: max_cpu_qlen set to 1000
[    0.240797] alg: No test for 842 (842-generic)
[    0.240797] alg: No test for 842 (842-scomp)
[    0.242771] ACPI: Added _OSI(Module Device)
[    0.242771] ACPI: Added _OSI(Processor Device)
[    0.242771] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.242771] ACPI: Added _OSI(Processor Aggregator Device)
[    0.242771] ACPI: Added _OSI(Linux-Dell-Video)
[    0.242771] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.242771] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.270901] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.275703] ACPI: Dynamic OEM Table Load:
[    0.275707] ACPI: SSDT 0xFFFF8B5224AF5000 000717 (v02 PmRef
Cpu0Ist  00003000 INTL 20160422)
[    0.276666] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.277585] ACPI: Dynamic OEM Table Load:
[    0.277588] ACPI: SSDT 0xFFFF8B5224764400 0003FF (v02 PmRef
Cpu0Cst  00003001 INTL 20160422)
[    0.278697] ACPI: Dynamic OEM Table Load:
[    0.278701] ACPI: SSDT 0xFFFF8B5224AF0800 00065C (v02 PmRef  ApIst
  00003000 INTL 20160422)
[    0.279814] ACPI: Dynamic OEM Table Load:
[    0.279817] ACPI: SSDT 0xFFFF8B5224033400 00018A (v02 PmRef  ApCst
  00003000 INTL 20160422)
[    0.282378] ACPI: Interpreter enabled
[    0.282409] ACPI: (supports S0 S3 S4 S5)
[    0.282410] ACPI: Using IOAPIC for interrupt routing
[    0.282437] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.283154] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.287940] ACPI: Power Resource [WRST] (on)
[    0.288255] ACPI: Power Resource [WRST] (on)
[    0.288568] ACPI: Power Resource [WRST] (on)
[    0.288877] ACPI: Power Resource [WRST] (on)
[    0.289186] ACPI: Power Resource [WRST] (on)
[    0.289495] ACPI: Power Resource [WRST] (on)
[    0.289805] ACPI: Power Resource [WRST] (on)
[    0.290307] ACPI: Power Resource [WRST] (on)
[    0.290628] ACPI: Power Resource [WRST] (on)
[    0.291038] ACPI: Power Resource [WRST] (on)
[    0.291341] ACPI: Power Resource [WRST] (on)
[    0.291660] ACPI: Power Resource [WRST] (on)
[    0.291970] ACPI: Power Resource [WRST] (on)
[    0.292277] ACPI: Power Resource [WRST] (on)
[    0.292583] ACPI: Power Resource [WRST] (on)
[    0.292911] ACPI: Power Resource [WRST] (on)
[    0.293217] ACPI: Power Resource [WRST] (on)
[    0.294432] ACPI: Power Resource [WRST] (on)
[    0.294744] ACPI: Power Resource [WRST] (on)
[    0.295054] ACPI: Power Resource [WRST] (on)
[    0.304557] ACPI: Power Resource [FN00] (off)
[    0.304613] ACPI: Power Resource [FN01] (off)
[    0.304668] ACPI: Power Resource [FN02] (off)
[    0.304722] ACPI: Power Resource [FN03] (off)
[    0.304778] ACPI: Power Resource [FN04] (off)
[    0.305744] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.305747] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI EDR HPX-Type3]
[    0.306961] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR DPC]
[    0.307634] PCI host bridge to bus 0000:00
[    0.307635] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.307636] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.307637] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.307637] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000c3fff window]
[    0.307638] pci_bus 0000:00: root bus resource [mem
0x000c4000-0x000c7fff window]
[    0.307639] pci_bus 0000:00: root bus resource [mem
0x000c8000-0x000cbfff window]
[    0.307639] pci_bus 0000:00: root bus resource [mem
0x000cc000-0x000cffff window]
[    0.307640] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000d3fff window]
[    0.307640] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff window]
[    0.307641] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff window]
[    0.307642] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff window]
[    0.307642] pci_bus 0000:00: root bus resource [mem
0xc8000000-0xf7ffffff window]
[    0.307643] pci_bus 0000:00: root bus resource [mem
0xfd000000-0xfe7fffff window]
[    0.307644] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.307651] pci 0000:00:00.0: [8086:591f] type 00 class 0x060000
[    0.307916] pci 0000:00:02.0: [8086:5912] type 00 class 0x030000
[    0.307924] pci 0000:00:02.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit=
]
[    0.307928] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.307931] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.307942] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.308116] pci 0000:00:14.0: [8086:a2af] type 00 class 0x0c0330
[    0.308148] pci 0000:00:14.0: reg 0x10: [mem 0xf7230000-0xf723ffff 64bit=
]
[    0.308245] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.308537] pci 0000:00:16.0: [8086:a2ba] type 00 class 0x078000
[    0.308566] pci 0000:00:16.0: reg 0x10: [mem 0xf724d000-0xf724dfff 64bit=
]
[    0.308648] pci 0000:00:16.0: PME# supported from D3hot
[    0.308868] pci 0000:00:17.0: [8086:a282] type 00 class 0x010601
[    0.308896] pci 0000:00:17.0: reg 0x10: [mem 0xf7248000-0xf7249fff]
[    0.308907] pci 0000:00:17.0: reg 0x14: [mem 0xf724c000-0xf724c0ff]
[    0.308918] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    0.308929] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    0.308939] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    0.308950] pci 0000:00:17.0: reg 0x24: [mem 0xf724b000-0xf724b7ff]
[    0.309012] pci 0000:00:17.0: PME# supported from D3hot
[    0.309174] pci 0000:00:1b.0: [8086:a2e9] type 01 class 0x060400
[    0.309354] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.309598] pci 0000:00:1c.0: [8086:a292] type 01 class 0x060400
[    0.309736] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.309759] pci 0000:00:1c.0: Intel SPT PCH root port ACS workaround ena=
bled
[    0.309970] pci 0000:00:1c.4: [8086:a294] type 01 class 0x060400
[    0.310108] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.310131] pci 0000:00:1c.4: Intel SPT PCH root port ACS workaround ena=
bled
[    0.310344] pci 0000:00:1d.0: [8086:a298] type 01 class 0x060400
[    0.310480] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.310504] pci 0000:00:1d.0: Intel SPT PCH root port ACS workaround ena=
bled
[    0.310729] pci 0000:00:1f.0: [8086:a2c4] type 00 class 0x060100
[    0.310958] pci 0000:00:1f.2: [8086:a2a1] type 00 class 0x058000
[    0.310975] pci 0000:00:1f.2: reg 0x10: [mem 0xf7244000-0xf7247fff]
[    0.311160] pci 0000:00:1f.3: [8086:a2f0] type 00 class 0x040300
[    0.311189] pci 0000:00:1f.3: reg 0x10: [mem 0xf7240000-0xf7243fff 64bit=
]
[    0.311217] pci 0000:00:1f.3: reg 0x20: [mem 0xf7220000-0xf722ffff 64bit=
]
[    0.311270] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.311555] pci 0000:00:1f.4: [8086:a2a3] type 00 class 0x0c0500
[    0.311615] pci 0000:00:1f.4: reg 0x10: [mem 0xf724a000-0xf724a0ff 64bit=
]
[    0.311682] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    0.311893] pci 0000:00:1f.6: [8086:15b8] type 00 class 0x020000
[    0.311920] pci 0000:00:1f.6: reg 0x10: [mem 0xf7200000-0xf721ffff]
[    0.312034] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.312247] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.312507] pci 0000:02:00.0: [1b21:1080] type 01 class 0x060400
[    0.313152] pci 0000:02:00.0: supports D1 D2
[    0.313152] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.316726] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    0.316895] pci_bus 0000:03: extended config space not accessible
[    0.317410] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.317631] pci 0000:04:00.0: [1b21:1242] type 00 class 0x0c0330
[    0.317714] pci 0000:04:00.0: reg 0x10: [mem 0xf7100000-0xf7107fff 64bit=
]
[    0.317792] pci 0000:04:00.0: enabling Extended Tags
[    0.318064] pci 0000:04:00.0: PME# supported from D3hot D3cold
[    0.318522] pci 0000:00:1c.4: PCI bridge to [bus 04]
[    0.318529] pci 0000:00:1c.4:   bridge window [mem 0xf7100000-0xf71fffff=
]
[    0.318666] pci 0000:05:00.0: [144d:a808] type 00 class 0x010802
[    0.318707] pci 0000:05:00.0: reg 0x10: [mem 0xf7000000-0xf7003fff 64bit=
]
[    0.319195] pci 0000:00:1d.0: PCI bridge to [bus 05]
[    0.319202] pci 0000:00:1d.0:   bridge window [mem 0xf7000000-0xf70fffff=
]
[    0.320808] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.320847] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 1=
5)
[    0.320885] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.320922] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.320959] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.320999] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.321035] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.321073] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 1=
5)
[    0.321654] iommu: Default domain type: Translated
[    0.321666] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.321666] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.321666] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.321666] vgaarb: loaded
[    0.321711] SCSI subsystem initialized
[    0.321715] libata version 3.00 loaded.
[    0.321715] ACPI: bus type USB registered
[    0.321715] usbcore: registered new interface driver usbfs
[    0.321715] usbcore: registered new interface driver hub
[    0.321715] usbcore: registered new device driver usb
[    0.321715] pps_core: LinuxPPS API ver. 1 registered
[    0.321715] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.321715] PTP clock support registered
[    0.321715] EDAC MC: Ver: 3.0.0
[    0.321859] Registered efivars operations
[    0.321859] PCI: Using ACPI for IRQ routing
[    0.328466] PCI: pci_cache_line_size set to 64 bytes
[    0.328636] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.328637] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.328638] e820: reserve RAM buffer [mem 0xb3af2018-0xb3ffffff]
[    0.328638] e820: reserve RAM buffer [mem 0xb3b03018-0xb3ffffff]
[    0.328639] e820: reserve RAM buffer [mem 0xb4106000-0xb7ffffff]
[    0.328640] e820: reserve RAM buffer [mem 0xb44f7000-0xb7ffffff]
[    0.328640] e820: reserve RAM buffer [mem 0xbe842000-0xbfffffff]
[    0.328641] e820: reserve RAM buffer [mem 0xbf28a000-0xbfffffff]
[    0.328641] e820: reserve RAM buffer [mem 0xc1142000-0xc3ffffff]
[    0.328642] e820: reserve RAM buffer [mem 0xc2a1b000-0xc3ffffff]
[    0.328643] e820: reserve RAM buffer [mem 0xc33ff000-0xc3ffffff]
[    0.328643] e820: reserve RAM buffer [mem 0x437000000-0x437ffffff]
[    0.328704] NetLabel: Initializing
[    0.328705] NetLabel:  domain hash size =3D 128
[    0.328705] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.328713] NetLabel:  unlabeled traffic allowed by default
[    0.328718] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.328720] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    0.330660] clocksource: Switched to clocksource tsc-early
[    0.340643] VFS: Disk quotas dquot_6.6.0
[    0.340653] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.340690] pnp: PnP ACPI init
[    0.340839] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.340843] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.341101] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.341102] system 00:01: [io  0xffff] has been reserved
[    0.341103] system 00:01: [io  0xffff] has been reserved
[    0.341103] system 00:01: [io  0xffff] has been reserved
[    0.341104] system 00:01: [io  0x1800-0x18fe] has been reserved
[    0.341105] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.341107] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.341173] system 00:02: [io  0x0800-0x087f] has been reserved
[    0.341174] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.341186] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.341209] system 00:04: [io  0x1854-0x1857] has been reserved
[    0.341210] system 00:04: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.341368] system 00:05: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.341369] system 00:05: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.341370] system 00:05: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.341371] system 00:05: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.341371] system 00:05: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.341372] system 00:05: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.341373] system 00:05: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.341374] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.341375] system 00:05: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.341376] system 00:05: [mem 0xf7fe0000-0xf7ffffff] has been reserved
[    0.341378] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.341404] system 00:06: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.341405] system 00:06: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.341406] system 00:06: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.341407] system 00:06: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.341408] system 00:06: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.341408] system 00:06: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.341409] system 00:06: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    0.341410] system 00:06: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.341411] system 00:06: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.341412] system 00:06: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.341413] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.341628] system 00:07: [io  0xfe00-0xfefe] has been reserved
[    0.341630] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.342441] system 00:08: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.342442] system 00:08: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.342442] system 00:08: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.342444] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.343086] pnp: PnP ACPI: found 9 devices
[    0.348360] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.348395] pci 0000:00:1b.0: bridge window [io  0x1000-0x0fff] to
[bus 01] add_size 1000
[    0.348396] pci 0000:00:1b.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000
add_align 100000
[    0.348397] pci 0000:00:1b.0: bridge window [mem
0x00100000-0x000fffff] to [bus 01] add_size 200000 add_align 100000
[    0.348403] pci 0000:00:1b.0: BAR 14: assigned [mem 0xc8000000-0xc81ffff=
f]
[    0.348408] pci 0000:00:1b.0: BAR 15: assigned [mem
0xc8200000-0xc83fffff 64bit pref]
[    0.348410] pci 0000:00:1b.0: BAR 13: assigned [io  0x2000-0x2fff]
[    0.348411] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.348415] pci 0000:00:1b.0:   bridge window [io  0x2000-0x2fff]
[    0.348420] pci 0000:00:1b.0:   bridge window [mem 0xc8000000-0xc81fffff=
]
[    0.348424] pci 0000:00:1b.0:   bridge window [mem
0xc8200000-0xc83fffff 64bit pref]
[    0.348430] pci 0000:02:00.0: PCI bridge to [bus 03]
[    0.348576] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    0.348590] pci 0000:00:1c.4: PCI bridge to [bus 04]
[    0.348595] pci 0000:00:1c.4:   bridge window [mem 0xf7100000-0xf71fffff=
]
[    0.348605] pci 0000:00:1d.0: PCI bridge to [bus 05]
[    0.348611] pci 0000:00:1d.0:   bridge window [mem 0xf7000000-0xf70fffff=
]
[    0.348621] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.348622] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.348623] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.348623] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.348624] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.348625] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.348625] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.348626] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.348626] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.348627] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.348628] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.348628] pci_bus 0000:00: resource 15 [mem 0xc8000000-0xf7ffffff wind=
ow]
[    0.348629] pci_bus 0000:00: resource 16 [mem 0xfd000000-0xfe7fffff wind=
ow]
[    0.348630] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.348630] pci_bus 0000:01: resource 1 [mem 0xc8000000-0xc81fffff]
[    0.348631] pci_bus 0000:01: resource 2 [mem 0xc8200000-0xc83fffff
64bit pref]
[    0.348632] pci_bus 0000:04: resource 1 [mem 0xf7100000-0xf71fffff]
[    0.348632] pci_bus 0000:05: resource 1 [mem 0xf7000000-0xf70fffff]
[    0.348736] NET: Registered protocol family 2
[    0.348825] tcp_listen_portaddr_hash hash table entries: 8192
(order: 5, 131072 bytes, linear)
[    0.348838] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    0.348924] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    0.348993] TCP: Hash tables configured (established 131072 bind 65536)
[    0.349038] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear=
)
[    0.349066] UDP-Lite hash table entries: 8192 (order: 6, 262144
bytes, linear)
[    0.349107] NET: Registered protocol family 1
[    0.349110] NET: Registered protocol family 44
[    0.349116] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.349535] PCI: CLS 64 bytes, default 64
[    0.349560] Trying to unpack rootfs image as initramfs...
[    0.748755] Freeing initrd memory: 33816K
[    0.748802] DMAR: [Firmware Bug]: RMRR entry for device 04:00.0 is
broken - applying workaround
[    0.748803] DMAR: No ATSR found
[    0.748824] DMAR: dmar1: Using Queued invalidation
[    0.748897] pci 0000:00:00.0: Adding to iommu group 0
[    0.748936] pci 0000:00:14.0: Adding to iommu group 1
[    0.748964] pci 0000:00:16.0: Adding to iommu group 2
[    0.748986] pci 0000:00:17.0: Adding to iommu group 3
[    0.749018] pci 0000:00:1b.0: Adding to iommu group 4
[    0.749041] pci 0000:00:1c.0: Adding to iommu group 5
[    0.749069] pci 0000:00:1c.4: Adding to iommu group 6
[    0.749097] pci 0000:00:1d.0: Adding to iommu group 7
[    0.750293] pci 0000:00:1f.0: Adding to iommu group 8
[    0.750300] pci 0000:00:1f.2: Adding to iommu group 8
[    0.750306] pci 0000:00:1f.3: Adding to iommu group 8
[    0.750312] pci 0000:00:1f.4: Adding to iommu group 8
[    0.750335] pci 0000:00:1f.6: Adding to iommu group 9
[    0.750367] pci 0000:02:00.0: Adding to iommu group 10
[    0.750408] pci 0000:04:00.0: Adding to iommu group 11
[    0.750437] pci 0000:05:00.0: Adding to iommu group 12
[    0.750440] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.752204] Initialise system trusted keyrings
[    0.752219] Key type blacklist registered
[    0.752247] workingset: timestamp_bits=3D36 max_order=3D22 bucket_order=
=3D0
[    0.753118] zbud: loaded
[    0.753403] integrity: Platform Keyring initialized
[    0.755853] NET: Registered protocol family 38
[    0.755855] Key type asymmetric registered
[    0.755855] Asymmetric key parser 'x509' registered
[    0.755859] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 246)
[    0.755881] io scheduler mq-deadline registered
[    0.755881] io scheduler kyber registered
[    0.755896] io scheduler bfq registered
[    0.755929] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[    0.756143] pcieport 0000:00:1b.0: PME: Signaling with IRQ 122
[    0.756174] pcieport 0000:00:1b.0: pciehp: Slot #0 AttnBtn-
PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+
IbPresDis- LLActRep+
[    0.756389] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    0.756428] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[    0.756547] pcieport 0000:00:1c.4: PME: Signaling with IRQ 124
[    0.756583] pcieport 0000:00:1c.4: AER: enabled with IRQ 124
[    0.756771] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    0.756812] pcieport 0000:00:1d.0: AER: enabled with IRQ 125
[    0.757002] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.757005] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[    0.757011] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[    0.757012] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[    0.757013] pcieport 0000:00:1c.0: AER:    [12] Timeout
[    0.757016] efifb: probing for efifb
[    0.757020] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[    0.757023] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[    0.757030] efifb: showing boot graphics
[    0.757370] efifb: framebuffer at 0xe0000000, using 3072k, total 3072k
[    0.757370] efifb: mode is 1024x768x32, linelength=3D4096, pages=3D1
[    0.757371] efifb: scrolling: redraw
[    0.757371] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.757392] fbcon: Deferring console take-over
[    0.757393] fb0: EFI VGA frame buffer device
[    0.757397] intel_idle: MWAIT substates: 0x142120
[    0.757398] intel_idle: v0.5.1 model 0x9E
[    0.757521] intel_idle: Local APIC timer is reliable in all C-states
[    0.757647] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.757663] ACPI: Sleep Button [SLPB]
[    0.757685] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.757694] ACPI: Power Button [PWRB]
[    0.757714] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    0.757731] ACPI: Power Button [PWRF]
[    0.758253] thermal LNXTHERM:00: registered as thermal_zone0
[    0.758254] ACPI: Thermal Zone [TZ00] (28 C)
[    0.758341] thermal LNXTHERM:01: registered as thermal_zone1
[    0.758342] ACPI: Thermal Zone [TZ01] (30 C)
[    0.758484] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.759616] Non-volatile memory driver v1.3
[    0.759629] Linux agpgart interface v0.103
[    0.760661] tpm_crb MSFT0101:00: [Firmware Bug]: ACPI region does
not cover the entire command/response buffer. [mem
0xfed40000-0xfed4087f flags 0x201] vs fed40080 f80
[    0.760667] tpm_crb MSFT0101:00: [Firmware Bug]: ACPI region does
not cover the entire command/response buffer. [mem
0xfed40000-0xfed4087f flags 0x201] vs fed40080 f80
[    0.779331] ahci 0000:00:17.0: version 3.0
[    0.789773] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6
Gbps 0x3f impl SATA mode
[    0.789774] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo
only pio slum part ems deso sadm sds apst
[    0.805259] scsi host0: ahci
[    0.805472] scsi host1: ahci
[    0.805549] scsi host2: ahci
[    0.805595] scsi host3: ahci
[    0.805636] scsi host4: ahci
[    0.805682] scsi host5: ahci
[    0.805705] ata1: SATA max UDMA/133 abar m2048@0xf724b000 port
0xf724b100 irq 126
[    0.805707] ata2: SATA max UDMA/133 abar m2048@0xf724b000 port
0xf724b180 irq 126
[    0.805709] ata3: SATA max UDMA/133 abar m2048@0xf724b000 port
0xf724b200 irq 126
[    0.805710] ata4: SATA max UDMA/133 abar m2048@0xf724b000 port
0xf724b280 irq 126
[    0.805712] ata5: SATA max UDMA/133 abar m2048@0xf724b000 port
0xf724b300 irq 126
[    0.805713] ata6: SATA max UDMA/133 abar m2048@0xf724b000 port
0xf724b380 irq 126
[    0.805798] libphy: Fixed MDIO Bus: probed
[    0.805844] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.805845] ehci-pci: EHCI PCI platform driver
[    0.805851] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.805852] ohci-pci: OHCI PCI platform driver
[    0.805856] uhci_hcd: USB Universal Host Controller Interface driver
[    0.805946] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.805964] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    0.807094] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x0000000000009810
[    0.807099] xhci_hcd 0000:00:14.0: cache line size of 64 is not supporte=
d
[    0.807304] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.07
[    0.807305] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.807305] usb usb1: Product: xHCI Host Controller
[    0.807306] usb usb1: Manufacturer: Linux 5.7.8-200.fc32.x86_64 xhci-hcd
[    0.807307] usb usb1: SerialNumber: 0000:00:14.0
[    0.807360] hub 1-0:1.0: USB hub found
[    0.807393] hub 1-0:1.0: 16 ports detected
[    0.808615] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    0.808669] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    0.808671] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    0.808696] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 5.07
[    0.808697] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.808698] usb usb2: Product: xHCI Host Controller
[    0.808699] usb usb2: Manufacturer: Linux 5.7.8-200.fc32.x86_64 xhci-hcd
[    0.808699] usb usb2: SerialNumber: 0000:00:14.0
[    0.808781] hub 2-0:1.0: USB hub found
[    0.808798] hub 2-0:1.0: 8 ports detected
[    0.809479] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    0.809529] xhci_hcd 0000:04:00.0: new USB bus registered, assigned
bus number 3
[    0.868463] xhci_hcd 0000:04:00.0: hcc params 0x0200eec1 hci
version 0x110 quirks 0x0000000000000010
[    0.868652] usb usb3: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.07
[    0.868653] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.868653] usb usb3: Product: xHCI Host Controller
[    0.868654] usb usb3: Manufacturer: Linux 5.7.8-200.fc32.x86_64 xhci-hcd
[    0.868654] usb usb3: SerialNumber: 0000:04:00.0
[    0.868721] hub 3-0:1.0: USB hub found
[    0.868727] hub 3-0:1.0: 2 ports detected
[    0.868809] xhci_hcd 0000:04:00.0: xHCI Host Controller
[    0.868857] xhci_hcd 0000:04:00.0: new USB bus registered, assigned
bus number 4
[    0.868858] xhci_hcd 0000:04:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.868880] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    0.868891] usb usb4: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 5.07
[    0.868892] usb usb4: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    0.868893] usb usb4: Product: xHCI Host Controller
[    0.868893] usb usb4: Manufacturer: Linux 5.7.8-200.fc32.x86_64 xhci-hcd
[    0.868894] usb usb4: SerialNumber: 0000:04:00.0
[    0.868967] hub 4-0:1.0: USB hub found
[    0.868973] hub 4-0:1.0: 2 ports detected
[    0.869036] usbcore: registered new interface driver usbserial_generic
[    0.869038] usbserial: USB Serial support registered for generic
[    0.869049] i8042: PNP: No PS/2 controller found.
[    0.869100] mousedev: PS/2 mouse device common for all mice
[    0.869291] rtc_cmos 00:03: RTC can wake from S4
[    0.869776] rtc_cmos 00:03: registered as rtc0
[    0.869904] rtc_cmos 00:03: setting system clock to
2020-07-11T00:06:31 UTC (1594425991)
[    0.869904] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    0.869928] device-mapper: uevent: version 1.0.3
[    0.869957] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27)
initialised: dm-devel@redhat.com
[    0.870030] intel_pstate: Intel P-state driver initializing
[    0.870043] intel_pstate: Disabling energy efficiency optimization
[    0.870241] intel_pstate: HWP enabled
[    0.870414] hid: raw HID events driver (C) Jiri Kosina
[    0.870430] usbcore: registered new interface driver usbhid
[    0.870431] usbhid: USB HID core driver
[    0.870477] resource sanity check: requesting [mem
0xfdffe800-0xfe0007ff], which spans more than pnp 00:06 [mem
0xfdb00000-0xfdffffff]
[    0.870479] caller pmc_core_probe+0x6d/0x350 mapping multiple BARs
[    0.870487] intel_pmc_core INT33A1:00:  initialized
[    0.870521] drop_monitor: Initializing network drop monitor service
[    0.870582] Initializing XFRM netlink socket
[    0.870647] NET: Registered protocol family 10
[    0.873525] Segment Routing with IPv6
[    0.873526] RPL Segment Routing with IPv6
[    0.873538] mip6: Mobile IPv6
[    0.873539] NET: Registered protocol family 17
[    0.873756] RAS: Correctable Errors collector initialized.
[    0.873773] microcode: sig=3D0x906e9, pf=3D0x2, revision=3D0xd6
[    0.873816] microcode: Microcode Update Driver: v2.2.
[    0.873818] IPI shorthand broadcast: enabled
[    0.873836] AVX2 version of gcm_enc/dec engaged.
[    0.873836] AES CTR mode by8 optimization enabled
[    0.887427] sched_clock: Marking stable (883915631,
3507050)->(888961620, -1538939)
[    0.887510] registered taskstats version 1
[    0.887515] Loading compiled-in X.509 certificates
[    0.909062] Loaded X.509 cert 'Fedora kernel signing key:
cd3a20694e57806227a8b28002d259fd9172b95b'
[    0.909075] zswap: loaded using pool lzo/zbud
[    0.909305] Key type ._fscrypt registered
[    0.909305] Key type .fscrypt registered
[    0.909306] Key type fscrypt-provisioning registered
[    0.914034] Key type big_key registered
[    0.916308] Key type encrypted registered
[    0.917611] integrity: Loading X.509 certificate: UEFI:db
[    0.917765] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW
Key Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    0.917765] integrity: Loading X.509 certificate: UEFI:db
[    0.917891] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key
Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    0.917891] integrity: Loading X.509 certificate: UEFI:db
[    0.917907] integrity: Loaded X.509 cert 'Microsoft Corporation
UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.917908] integrity: Loading X.509 certificate: UEFI:db
[    0.917923] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.917923] integrity: Loading X.509 certificate: UEFI:db
[    0.918051] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    0.919802] ima: Allocated hash algorithm: sha256
[    0.978722] ima: No architecture policies found
[    0.980439] PM:   Magic number: 12:891:101
[    0.980608] Lockdown: swapper/0: hibernation is restricted; see man
kernel_lockdown.7
[    1.117742] ata1: SATA link down (SStatus 4 SControl 300)
[    1.117782] ata5: SATA link down (SStatus 4 SControl 300)
[    1.117824] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.117864] ata6: SATA link down (SStatus 4 SControl 300)
[    1.117904] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.117939] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.122257] ata4.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[    1.122263] ata4.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[    1.122267] ata4.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    1.122284] ata2.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[    1.122289] ata2.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[    1.122294] ata2.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    1.122977] ata4.00: ATA-8: ST2000DM001-9YN164, CC4H, max UDMA/133
[    1.122982] ata4.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    1.124708] ata3.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[    1.124713] ata3.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[    1.124718] ata3.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    1.124851] ata4.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[    1.124856] ata4.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[    1.124861] ata4.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    1.125069] ata2.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    1.125073] ata2.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32),=
 AA
[    1.125456] ata4.00: configured for UDMA/133
[    1.126180] ata3.00: ATAPI: HL-DT-ST BDDVDRW CH12NS30, 1.01, max UDMA/10=
0
[    1.127938] ata2.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[    1.127944] ata2.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[    1.127948] ata2.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    1.129696] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    1.130558] ata2.00: configured for UDMA/133
[    1.130805] scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA
DT01ACA3 ABB0 PQ: 0 ANSI: 5
[    1.131188] sd 1:0:0:0: [sda] 5860533168 512-byte logical blocks:
(3.00 TB/2.73 TiB)
[    1.131190] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.131194] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    1.131211] sd 1:0:0:0: [sda] Write Protect is off
[    1.131215] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.131240] sd 1:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.131818] ata3.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[    1.131824] ata3.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[    1.131828] ata3.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[    1.134131] ata3.00: configured for UDMA/100
[    1.140157] scsi 2:0:0:0: CD-ROM            HL-DT-ST BDDVDRW
CH12NS30 1.01 PQ: 0 ANSI: 5
[    1.159479]  sda: sda1
[    1.160198] sd 1:0:0:0: [sda] Attached SCSI disk
[    1.182444] sr 2:0:0:0: [sr0] scsi3-mmc drive: 1x/1x writer dvd-ram
cd/rw xa/form2 cdda tray
[    1.182447] cdrom: Uniform CD-ROM driver Revision: 3.20
[    1.183003] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    1.183212] sr 2:0:0:0: Attached scsi generic sg1 type 5
[    1.183639] scsi 3:0:0:0: Direct-Access     ATA
ST2000DM001-9YN1 CC4H PQ: 0 ANSI: 5
[    1.184014] sd 3:0:0:0: Attached scsi generic sg2 type 0
[    1.184058] sd 3:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    1.184062] sd 3:0:0:0: [sdb] 4096-byte physical blocks
[    1.184079] sd 3:0:0:0: [sdb] Write Protect is off
[    1.184082] sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.184108] sd 3:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.225313]  sdb: sdb1 sdb2 sdb3 sdb4
[    1.226375] sd 3:0:0:0: [sdb] Attached SCSI disk
[    1.229731] Freeing unused decrypted memory: 2040K
[    1.230779] Freeing unused kernel image (initmem) memory: 2472K
[    1.235755] Write protecting the kernel read-only data: 24576k
[    1.237090] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.237303] Freeing unused kernel image (rodata/data gap) memory: 28K
[    1.258422] usb 1-1: New USB device found, idVendor=3D046d,
idProduct=3Dc52b, bcdDevice=3D12.11
[    1.258427] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.258430] usb 1-1: Product: USB Receiver
[    1.258433] usb 1-1: Manufacturer: Logitech
[    1.262424] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:046D:C52B.0001/input=
/input3
[    1.313881] hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID
v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-1/input0
[    1.314247] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.314250] rodata_test: all tests were successful
[    1.314251] x86/mm: Checking user space page tables
[    1.315534] input: Logitech USB Receiver Mouse as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046D:C52B.0002/input=
/input4
[    1.315608] input: Logitech USB Receiver Consumer Control as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046D:C52B.0002/input=
/input5
[    1.354754] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.354755] Run /init as init process
[    1.354756]   with arguments:
[    1.354756]     /init
[    1.354757]     rhgb
[    1.354757]   with environment:
[    1.354757]     HOME=3D/
[    1.354758]     TERM=3Dlinux
[    1.354758]     BOOT_IMAGE=3D(hd3,gpt2)/vmlinuz-5.7.8-200.fc32.x86_64
[    1.354758]     intel_iommu=3Don,igfx_off
[    1.367637] input: Logitech USB Receiver System Control as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:046D:C52B.0002/input=
/input6
[    1.367735] hid-generic 0003:046D:C52B.0002:
input,hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:00:14.0-1/input1
[    1.370325] usb 2-5: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    1.370423] hid-generic 0003:046D:C52B.0003: hiddev97,hidraw2: USB
HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-1/input2
[    1.384168] usb 2-5: New USB device found, idVendor=3D0451,
idProduct=3D8140, bcdDevice=3D 1.00
[    1.384169] usb 2-5: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.387190] hub 2-5:1.0: USB hub found
[    1.387270] hub 2-5:1.0: 4 ports detected
[    1.450213] systemd[1]: systemd v245.6-2.fc32 running in system
mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dunified)
[    1.461793] systemd[1]: Detected architecture x86-64.
[    1.461797] systemd[1]: Running in initial RAM disk.
[    1.461834] systemd[1]: Set hostname to <haswell>.
[    1.462275] Lockdown: systemd: /dev/mem,kmem,port is restricted;
see man kernel_lockdown.7
[    1.496829] usb 1-5: new high-speed USB device number 3 using xhci_hcd
[    1.551146] systemd[1]: Reached target Local File Systems.
[    1.551197] systemd[1]: Reached target Slices.
[    1.551212] systemd[1]: Reached target Swap.
[    1.551224] systemd[1]: Reached target Timers.
[    1.551369] systemd[1]: Listening on Journal Audit Socket.
[    1.551453] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.551553] systemd[1]: Listening on Journal Socket.
[    1.551631] systemd[1]: Listening on udev Control Socket.
[    1.551695] systemd[1]: Listening on udev Kernel Socket.
[    1.551709] systemd[1]: Reached target Sockets.
[    1.553125] systemd[1]: Starting Create list of static device nodes
for the current kernel...
[    1.553624] systemd[1]: Started Hardware RNG Entropy Gatherer Daemon.
[    1.554811] systemd[1]: Starting Journal Service...
[    1.555424] systemd[1]: Starting Load Kernel Modules...
[    1.555919] systemd[1]: Starting Setup Virtual Console...
[    1.556335] systemd[1]: Finished Create list of static device nodes
for the current kernel.
[    1.556906] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.565574] i2c /dev entries driver
[    1.567600] systemd[1]: Finished Create Static Device Nodes in /dev.
[    1.574446] fuse: init (API version 7.31)
[    1.579004] systemd[1]: Finished Load Kernel Modules.
[    1.579486] systemd[1]: Starting Apply Kernel Variables...
[    1.587859] systemd[1]: Finished Apply Kernel Variables.
[    1.618673] systemd[1]: Finished Setup Virtual Console.
[    1.618769] systemd[1]: Condition check resulted in dracut ask for
additional cmdline parameters being skipped.
[    1.619188] systemd[1]: Starting dracut cmdline hook...
[    1.622921] usb 1-5: New USB device found, idVendor=3D0451,
idProduct=3D8142, bcdDevice=3D 1.00
[    1.622922] usb 1-5: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D1
[    1.622923] usb 1-5: SerialNumber: A0020869C37F
[    1.623961] hub 1-5:1.0: USB hub found
[    1.623983] hub 1-5:1.0: 4 ports detected
[    1.695464] systemd[1]: Finished dracut cmdline hook.
[    1.695996] systemd[1]: Starting dracut pre-udev hook...
[    1.720417] systemd[1]: Finished dracut pre-udev hook.
[    1.720946] systemd[1]: Starting udev Kernel Device Manager...
[    1.736781] usb 2-2: new SuperSpeed Gen 1 USB device number 3 using xhci=
_hcd
[    1.750807] usb 2-2: New USB device found, idVendor=3D05e3,
idProduct=3D0743, bcdDevice=3D 8.13
[    1.750808] usb 2-2: New USB device strings: Mfr=3D3, Product=3D4, Seria=
lNumber=3D5
[    1.750809] usb 2-2: Product: USB Storage
[    1.750810] usb 2-2: Manufacturer: Generic
[    1.750810] usb 2-2: SerialNumber: 000000000813
[    1.812678] usb 2-5.4: new SuperSpeed Gen 1 USB device number 4
using xhci_hcd
[    1.815660] tsc: Refined TSC clocksource calibration: 3407.999 MHz
[    1.815664] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x311fd336761, max_idle_ns: 440795243819 ns
[    1.815672] clocksource: Switched to clocksource tsc
[    1.824875] usb 2-5.4: New USB device found, idVendor=3D0451,
idProduct=3D8140, bcdDevice=3D 1.00
[    1.824876] usb 2-5.4: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D0
[    1.826303] hub 2-5.4:1.0: USB hub found
[    1.826571] hub 2-5.4:1.0: 4 ports detected
[    1.877769] systemd[1]: Started Journal Service.
[    1.877846] audit: type=3D1130 audit(1594425992.506:2): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-jour=
nald
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    1.885716] audit: type=3D1130 audit(1594425992.514:3): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel
msg=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[    1.938653] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    2.013746] audit: type=3D1130 audit(1594425992.641:4): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-udev=
d
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    2.023252] usb-storage 2-2:1.0: USB Mass Storage device detected
[    2.034662] scsi host6: usb-storage 2-2:1.0
[    2.034722] usbcore: registered new interface driver usb-storage
[    2.039733] usbcore: registered new interface driver uas
[    2.066803] usb 1-9: New USB device found, idVendor=3D046d,
idProduct=3Dc338, bcdDevice=3D 4.12
[    2.066804] usb 1-9: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[    2.066805] usb 1-9: Product: Gaming Keyboard G610
[    2.066805] usb 1-9: Manufacturer: Logitech
[    2.066806] usb 1-9: SerialNumber: 038535563737
[    2.069632] input: Logitech Gaming Keyboard G610 as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:046D:C338.0004/input=
/input8
[    2.096156] audit: type=3D1130 audit(1594425992.724:5): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel
msg=3D'unit=3Dsystemd-udev-trigger comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[    2.110375] audit: type=3D1130 audit(1594425992.738:6): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dplymouth-sta=
rt
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    2.121731] hid-generic 0003:046D:C338.0004: input,hidraw3: USB HID
v1.11 Keyboard [Logitech Gaming Keyboard G610] on
usb-0000:00:14.0-9/input0
[    2.122355] input: Logitech Gaming Keyboard G610 Keyboard as
/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.1/0003:046D:C338.0005/input=
/input9
[    2.129653] usb 1-5.1: new high-speed USB device number 5 using xhci_hcd
[    2.174694] input: Logitech Gaming Keyboard G610 Consumer Control
as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.1/0003:046D:C338.0005/in=
put/input10
[    2.174737] hid-generic 0003:046D:C338.0005:
input,hiddev98,hidraw4: USB HID v1.11 Keyboard [Logitech Gaming
Keyboard G610] on usb-0000:00:14.0-9/input1
[    2.223383] usb 1-5.1: New USB device found, idVendor=3D045e,
idProduct=3D0779, bcdDevice=3D 1.06
[    2.223384] usb 1-5.1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[    2.223385] usb 1-5.1: Product: Microsoft=C2=AE LifeCam HD-3000
[    2.223385] usb 1-5.1: Manufacturer: Microsoft
[    2.321656] usb 1-10: new full-speed USB device number 6 using xhci_hcd
[    2.333326] nvme nvme0: pci function 0000:05:00.0
[    2.340045] nvme nvme0: missing or invalid SUBNQN field.
[    2.340057] nvme nvme0: Shutdown timeout set to 8 seconds
[    2.347754] nvme nvme0: 4/0/0 default/read/poll queues
[    2.350606]  nvme0n1: p1 p2 p3
[    2.351582] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.351582] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.351745] e1000e 0000:00:1f.6: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[    2.449765] usb 1-10: New USB device found, idVendor=3D0764,
idProduct=3D0501, bcdDevice=3D 0.01
[    2.449767] usb 1-10: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    2.449768] usb 1-10: Product: CRDA103#BJ1
[    2.449768] usb 1-10: Manufacturer: CP850PFCLCD
[    2.449769] usb 1-10: SerialNumber: CPS
[    2.452305] hid-generic 0003:0764:0501.0006: hiddev99,hidraw5: USB
HID v1.10 Device [CP850PFCLCD CRDA103#BJ1] on
usb-0000:00:14.0-10/input0
[    2.512658] usb 1-5.3: new full-speed USB device number 7 using xhci_hcd
[    2.591504] usb 1-5.3: New USB device found, idVendor=3D0a5c,
idProduct=3D21e8, bcdDevice=3D 1.12
[    2.591505] usb 1-5.3: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D3
[    2.591506] usb 1-5.3: Product: BCM920702 Bluetooth 4.0
[    2.591507] usb 1-5.3: Manufacturer: Broadcom Corp
[    2.591508] usb 1-5.3: SerialNumber: 5CF3707DEA8F
[    2.605665] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized):
registered PHC clock
[    2.646493] checking generic (e0000000 300000) vs hw (f6000000 1000000)
[    2.646494] checking generic (e0000000 300000) vs hw (e0000000 10000000)
[    2.646495] fb0: switching to inteldrmfb from EFI VGA
[    2.649672] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.650306] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.650585] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    2.651056] i915 0000:00:02.0: [drm] Finished loading DMC firmware
i915/kbl_dmc_ver1_04.bin (v1.4)
[    2.669655] usb 1-5.4: new high-speed USB device number 8 using xhci_hcd
[    2.680870] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width
x1) 38:d5:47:7d:f8:ea
[    2.680872] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    2.680965] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0=
FF
[    2.685144] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    2.746919] usb 1-5.4: New USB device found, idVendor=3D0451,
idProduct=3D8142, bcdDevice=3D 1.00
[    2.746920] usb 1-5.4: New USB device strings: Mfr=3D0, Product=3D0,
SerialNumber=3D1
[    2.746921] usb 1-5.4: SerialNumber: A0020849C37F
[    2.748836] hub 1-5.4:1.0: USB hub found
[    2.748914] hub 1-5.4:1.0: 4 ports detected
[    2.834667] logitech-djreceiver 0003:046D:C52B.0003:
hiddev96,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:00:14.0-1/input2
[    2.940341] i915 0000:00:02.0: [drm] failed to retrieve link info,
disabling eDP
[    2.941238] input: Logitech Unifying Device. Wireless PID:405e
Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52=
B.0003/0003:046D:405E.0007/input/input13
[    2.942079] input: Logitech Unifying Device. Wireless PID:405e
Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0=
003/0003:046D:405E.0007/input/input14
[    2.942148] input: Logitech Unifying Device. Wireless PID:405e
Consumer Control as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0003/0003:=
046D:405E.0007/input/input15
[    2.942178] input: Logitech Unifying Device. Wireless PID:405e
System Control as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0003/0003:=
046D:405E.0007/input/input16
[    2.942215] hid-generic 0003:046D:405E.0007: input,hidraw1: USB HID
v1.11 Keyboard [Logitech Unifying Device. Wireless PID:405e] on
usb-0000:00:14.0-1/input2:1
[    2.982175] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on mi=
nor 0
[    2.983733] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.983915] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input20
[    3.016148] input: Logitech M720 Triathlon as
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.2/0003:046D:C52B.0003/0003:=
046D:405E.0007/input/input21
[    3.016699] logitech-hidpp-device 0003:046D:405E.0007:
input,hidraw1: USB HID v1.11 Keyboard [Logitech M720 Triathlon] on
usb-0000:00:14.0-1/input2:1
[    3.046585] fbcon: i915drmfb (fb0) is primary device
[    3.046586] fbcon: Deferring console take-over
[    3.046588] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    3.100085] scsi 6:0:0:0: Direct-Access     Generic  STORAGE DEVICE
  0813 PQ: 0 ANSI: 5
[    3.100367] sd 6:0:0:0: Attached scsi generic sg3 type 0
[    3.109524] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[    3.379512] audit: type=3D1130 audit(1594425994.006:7): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Ddracut-initq=
ueue
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    3.399011] audit: type=3D1130 audit(1594425994.026:8): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dkernel msg=3D'unit=3Dsystemd-fsck=
-root
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    3.411779] EXT4-fs (dm-1): mounted filesystem with ordered data
mode. Opts: (null)
[    3.427397] audit: type=3D1334 audit(1594425994.055:9): prog-id=3D5 op=
=3DUNLOAD
[    3.427451] audit: type=3D1334 audit(1594425994.055:10): prog-id=3D4 op=
=3DUNLOAD
[    3.717118] systemd-journald[231]: Received SIGTERM from PID 1 (systemd)=
.
[    3.922499] SELinux:  Permission watch in class filesystem not
defined in policy.
[    3.922502] SELinux:  Permission watch in class file not defined in poli=
cy.
[    3.922503] SELinux:  Permission watch_mount in class file not
defined in policy.
[    3.922503] SELinux:  Permission watch_sb in class file not defined
in policy.
[    3.922504] SELinux:  Permission watch_with_perm in class file not
defined in policy.
[    3.922504] SELinux:  Permission watch_reads in class file not
defined in policy.
[    3.922507] SELinux:  Permission watch in class dir not defined in polic=
y.
[    3.922507] SELinux:  Permission watch_mount in class dir not
defined in policy.
[    3.922507] SELinux:  Permission watch_sb in class dir not defined in po=
licy.
[    3.922508] SELinux:  Permission watch_with_perm in class dir not
defined in policy.
[    3.922508] SELinux:  Permission watch_reads in class dir not
defined in policy.
[    3.922511] SELinux:  Permission watch in class lnk_file not
defined in policy.
[    3.922511] SELinux:  Permission watch_mount in class lnk_file not
defined in policy.
[    3.922512] SELinux:  Permission watch_sb in class lnk_file not
defined in policy.
[    3.922512] SELinux:  Permission watch_with_perm in class lnk_file
not defined in policy.
[    3.922512] SELinux:  Permission watch_reads in class lnk_file not
defined in policy.
[    3.922514] SELinux:  Permission watch in class chr_file not
defined in policy.
[    3.922514] SELinux:  Permission watch_mount in class chr_file not
defined in policy.
[    3.922515] SELinux:  Permission watch_sb in class chr_file not
defined in policy.
[    3.922515] SELinux:  Permission watch_with_perm in class chr_file
not defined in policy.
[    3.922516] SELinux:  Permission watch_reads in class chr_file not
defined in policy.
[    3.922517] SELinux:  Permission watch in class blk_file not
defined in policy.
[    3.922518] SELinux:  Permission watch_mount in class blk_file not
defined in policy.
[    3.922518] SELinux:  Permission watch_sb in class blk_file not
defined in policy.
[    3.922518] SELinux:  Permission watch_with_perm in class blk_file
not defined in policy.
[    3.922518] SELinux:  Permission watch_reads in class blk_file not
defined in policy.
[    3.922520] SELinux:  Permission watch in class sock_file not
defined in policy.
[    3.922521] SELinux:  Permission watch_mount in class sock_file not
defined in policy.
[    3.922521] SELinux:  Permission watch_sb in class sock_file not
defined in policy.
[    3.922521] SELinux:  Permission watch_with_perm in class sock_file
not defined in policy.
[    3.922522] SELinux:  Permission watch_reads in class sock_file not
defined in policy.
[    3.922523] SELinux:  Permission watch in class fifo_file not
defined in policy.
[    3.922524] SELinux:  Permission watch_mount in class fifo_file not
defined in policy.
[    3.922524] SELinux:  Permission watch_sb in class fifo_file not
defined in policy.
[    3.922524] SELinux:  Permission watch_with_perm in class fifo_file
not defined in policy.
[    3.922525] SELinux:  Permission watch_reads in class fifo_file not
defined in policy.
[    3.922626] SELinux:  Class perf_event not defined in policy.
[    3.922626] SELinux:  Class lockdown not defined in policy.
[    3.922626] SELinux: the above unknown classes and permissions will
be allowed
[    3.922632] SELinux:  policy capability network_peer_controls=3D1
[    3.922632] SELinux:  policy capability open_perms=3D1
[    3.922633] SELinux:  policy capability extended_socket_class=3D1
[    3.922633] SELinux:  policy capability always_check_network=3D0
[    3.922633] SELinux:  policy capability cgroup_seclabel=3D1
[    3.922633] SELinux:  policy capability nnp_nosuid_transition=3D1
[    3.922634] SELinux:  policy capability genfs_seclabel_symlinks=3D0
[    3.941381] systemd[1]: Successfully loaded SELinux policy in 163.213ms.
[    3.989308] systemd[1]: Relabelled /dev, /dev/shm, /run,
/sys/fs/cgroup in 25.379ms.
[    3.994847] systemd[1]: systemd v245.6-2.fc32 running in system
mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dunified)
[    4.006815] systemd[1]: Detected architecture x86-64.
[    4.007693] systemd[1]: Set hostname to <haswell>.
[    4.008757] Lockdown: systemd: /dev/mem,kmem,port is restricted;
see man kernel_lockdown.7
[    4.146279] systemd[1]: /usr/lib/systemd/system/sssd.service:13:
PIDFile=3D references a path below legacy directory /var/run/, updating
/var/run/sssd.pid =E2=86=92 /run/sssd.pid; please update the unit file
accordingly.
[    4.157726] systemd[1]: /usr/lib/systemd/system/sssd-kcm.socket:7:
ListenStream=3D references a path below legacy directory /var/run/,
updating /var/run/.heim_org.h5l.kcm-socket =E2=86=92
/run/.heim_org.h5l.kcm-socket; please update the unit file
accordingly.
[    4.208676] systemd[1]: initrd-switch-root.service: Succeeded.
[    4.208773] systemd[1]: Stopped Switch Root.
[    4.209112] systemd[1]: systemd-journald.service: Scheduled restart
job, restart counter is at 1.
[    4.209332] systemd[1]: Created slice Virtual Machine and Container Slic=
e.
[    4.209483] systemd[1]: Created slice system-getty.slice.
[    4.209632] systemd[1]: Created slice system-modprobe.slice.
[    4.209827] systemd[1]: Created slice system-sshd\x2dkeygen.slice.
[    4.209990] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    4.210222] systemd[1]: Created slice User and Session Slice.
[    4.210258] systemd[1]: Condition check resulted in Dispatch
Password Requests to Console Directory Watch being skipped.
[    4.210356] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    4.210699] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    4.210755] systemd[1]: Reached target Login Prompts.
[    4.210776] systemd[1]: Stopped target Switch Root.
[    4.210791] systemd[1]: Stopped target Initrd File Systems.
[    4.210804] systemd[1]: Stopped target Initrd Root File System.
[    4.210828] systemd[1]: Reached target User and Group Name Lookups.
[    4.210851] systemd[1]: Reached target Remote File Systems.
[    4.210866] systemd[1]: Reached target Slices.
[    4.211219] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    4.211851] systemd[1]: Listening on LVM2 poll daemon socket.
[    4.213181] systemd[1]: Listening on Process Core Dump Socket.
[    4.213301] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    4.213712] systemd[1]: Listening on udev Control Socket.
[    4.213952] systemd[1]: Listening on udev Kernel Socket.
[    4.214184] systemd[1]: Listening on User Database Manager Socket.
[    4.214666] systemd[1]: Activating swap /dev/mapper/fedora-swap...
[    4.215346] systemd[1]: Mounting Huge Pages File System...
[    4.216060] systemd[1]: Mounting POSIX Message Queue File System...
[    4.216809] systemd[1]: Mounting Kernel Debug File System...
[    4.217468] systemd[1]: Mounting Kernel Trace File System...
[    4.218116] systemd[1]: Started Device-mapper event daemon.
[    4.218863] systemd[1]: Starting Create list of static device nodes
for the current kernel...
[    4.219458] systemd[1]: Started LVM2 poll daemon.
[    4.220418] systemd[1]: Starting Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling...
[    4.220482] systemd[1]: Condition check resulted in Load Kernel
Module drm being skipped.
[    4.220611] systemd[1]: plymouth-switch-root.service: Succeeded.
[    4.220741] systemd[1]: Stopped Plymouth switch root service.
[    4.222464] systemd[1]: Starting Set Up Additional Binary Formats...
[    4.222585] systemd[1]: Stopped Journal Service.
[    4.223655] systemd[1]: Starting Journal Service...
[    4.224854] systemd[1]: Starting Load Kernel Modules...
[    4.225395] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.225909] systemd[1]: Starting Repartition Root Disk...
[    4.226456] systemd[1]: Starting udev Coldplug all Devices...
[    4.227191] systemd[1]: sysroot.mount: Succeeded.
[    4.227746] systemd[1]: Mounted Huge Pages File System.
[    4.227966] systemd[1]: Mounted POSIX Message Queue File System.
[    4.228135] systemd[1]: Mounted Kernel Debug File System.
[    4.229850] systemd[1]: Mounted Kernel Trace File System.
[    4.230264] systemd[1]: Finished Create list of static device nodes
for the current kernel.
[    4.230537] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got
automount request for /proc/sys/fs/binfmt_misc, triggered by 579
(systemd-binfmt)
[    4.230662] Adding 4079612k swap on /dev/mapper/fedora-swap.
Priority:-2 extents:1 across:4079612k SSFS
[    4.233558] systemd[1]: Activated swap /dev/mapper/fedora-swap.
[    4.234774] systemd[1]: Reached target Swap.
[    4.238269] systemd[1]: Mounting Arbitrary Executable File Formats
File System...
[    4.238803] systemd[1]: tmp.mount: Directory /tmp to mount over is
not empty, mounting anyway.
[    4.239314] systemd[1]: Mounting Temporary Directory (/tmp)...
[    4.252398] systemd[1]: Finished Load Kernel Modules.
[    4.252940] systemd[1]: Finished Repartition Root Disk.
[    4.253122] systemd[1]: Mounted Arbitrary Executable File Formats
File System.
[    4.253258] systemd[1]: Mounted Temporary Directory (/tmp).
[    4.254027] systemd[1]: Mounting FUSE Control File System...
[    4.255115] systemd[1]: Starting Apply Kernel Variables...
[    4.255373] systemd[1]: Finished Set Up Additional Binary Formats.
[    4.255436] EXT4-fs (dm-1): re-mounted. Opts: (null)
[    4.256303] systemd[1]: Finished Remount Root and Kernel File Systems.
[    4.256462] systemd[1]: Mounted FUSE Control File System.
[    4.256575] systemd[1]: Condition check resulted in OSTree Remount
OS/ Bind Mounts being skipped.
[    4.258984] systemd[1]: Starting Configure read-only root support...
[    4.259057] systemd[1]: Condition check resulted in First Boot
Wizard being skipped.
[    4.262153] systemd[1]: Condition check resulted in Rebuild
Hardware Database being skipped.
[    4.262181] systemd[1]: Condition check resulted in Create System
Users being skipped.
[    4.262726] systemd[1]: Starting Create Static Device Nodes in /dev...
[    4.264092] systemd[1]: Finished Apply Kernel Variables.
[    4.281988] systemd[1]: Finished Configure read-only root support.
[    4.282688] systemd[1]: Starting Load/Save Random Seed...
[    4.295212] systemd[1]: Finished Load/Save Random Seed.
[    4.298791] systemd[1]: Finished Create Static Device Nodes in /dev.
[    4.299693] systemd[1]: Starting udev Kernel Device Manager...
[    4.330048] systemd[1]: Finished udev Coldplug all Devices.
[    4.330767] systemd[1]: Starting udev Wait for Complete Device
Initialization...
[    4.472354] systemd[1]: Started Journal Service.
[    4.479728] systemd-journald[580]: Received client request to flush
runtime journal.
[    6.205423] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    8.222559] mc: Linux media interface: v0.10
[    8.246898] videodev: Linux video capture interface: v2.00
[    8.302243] uvcvideo: Found UVC 1.00 device Microsoft=C2=AE LifeCam
HD-3000 (045e:0779)
[    8.314373] uvcvideo 1-5.1:1.0: Entity type for entity Extension 5
was not initialized!
[    8.314375] uvcvideo 1-5.1:1.0: Entity type for entity Processing 4
was not initialized!
[    8.314375] uvcvideo 1-5.1:1.0: Entity type for entity Selector 3
was not initialized!
[    8.314376] uvcvideo 1-5.1:1.0: Entity type for entity Camera 1 was
not initialized!
[    8.316705] input: Microsoft=C2=AE LifeCam HD-3000: Mi as
/devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5.1/1-5.1:1.0/input/input22
[    8.316775] usbcore: registered new interface driver uvcvideo
[    8.316775] USB Video Class driver (1.1.1)
[    8.405503] Bluetooth: Core ver 2.22
[    8.405830] NET: Registered protocol family 31
[    8.405830] Bluetooth: HCI device and connection manager initialized
[    8.405832] Bluetooth: HCI socket layer initialized
[    8.405834] Bluetooth: L2CAP socket layer initialized
[    8.405837] Bluetooth: SCO socket layer initialized
[    8.513822] usbcore: registered new interface driver btusb
[    8.522016] usbcore: registered new interface driver snd-usb-audio
[    8.626299] Bluetooth: hci0: BCM: chip id 63
[    8.627488] Bluetooth: hci0: BCM: features 0x07
[    8.643528] Bluetooth: hci0: haswell
[    8.644388] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338
[    8.732610] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    8.732662] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[    8.732671] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[    8.732671] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[    8.732672] pcieport 0000:00:1c.0: AER:    [12] Timeout
[    8.732926] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    8.739539] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[    8.739544] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[    8.739545] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[    8.739546] pcieport 0000:00:1c.0: AER:    [12] Timeout
[    8.802296] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    8.802438] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    8.887777] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC887-VD: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    8.887778] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[    8.887779] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1
(0x1b/0x0/0x0/0x0/0x0)
[    8.887780] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    8.887780] snd_hda_codec_realtek hdaudioC1D0:    dig-out=3D0x11/0x0
[    8.887781] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    8.887781] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=3D0x19
[    8.887782] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=3D0x18
[    8.887783] snd_hda_codec_realtek hdaudioC1D0:      Line=3D0x1a
[    8.970859] input: PC Speaker as /devices/platform/pcspkr/input/input28
[    8.982144] input: HDA Intel PCH Front Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input23
[    8.982201] input: HDA Intel PCH Rear Mic as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input24
[    8.982542] input: HDA Intel PCH Line as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input25
[    8.982572] input: HDA Intel PCH Line Out as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input26
[    8.983353] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input27
[    8.983387] input: HDA Intel PCH HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input29
[    8.983412] input: HDA Intel PCH HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input30
[    8.983440] input: HDA Intel PCH HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input31
[    8.983464] input: HDA Intel PCH HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:1f.3/sound/card1/input32
[    9.208241] asus_wmi: ASUS WMI generic driver loaded
[    9.211339] asus_wmi: Initialization: 0x0
[    9.211356] asus_wmi: BIOS WMI version: 0.9
[    9.211405] asus_wmi: SFUN value: 0x0
[    9.211406] eeepc-wmi eeepc-wmi: Detected ASUSWMI, use DCTS
[    9.211636] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input33
[    9.440169] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters,
655360 ms ovfl timer
[    9.440170] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    9.440170] RAPL PMU: hw unit of domain package 2^-14 Joules
[    9.440170] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    9.440171] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    9.466488] Bluetooth: hci0: BCM20702A1 (001.002.014) build 1338
[    9.482225] Bluetooth: hci0: Broadcom Bluetooth Device
[   11.244169] mei_hdcp
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
(ops i915_hdcp_component_ops [i915])
[   11.392403] iTCO_vendor_support: vendor-support=3D0
[   11.397087] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.397201] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4,
TCOBASE=3D0x0400)
[   11.397374] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.515963] kauditd_printk_skb: 74 callbacks suppressed
[   11.515963] audit: type=3D1130 audit(1594426002.144:83): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dsystemd-rfkill comm=3D"systemd" exe=3D"/usr/lib/systemd/syste=
md"
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   12.087282] intel_rapl_common: Found RAPL domain package
[   12.087286] intel_rapl_common: Found RAPL domain core
[   12.087287] intel_rapl_common: Found RAPL domain uncore
[   12.087287] intel_rapl_common: Found RAPL domain dram
[   12.092497] audit: type=3D1130 audit(1594426002.720:84): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dlvm2-monitor comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd=
"
hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
[   12.092772] audit: type=3D1130 audit(1594426002.721:85): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dlvm2-pvscan@259:3 comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   12.323751] audit: type=3D1130 audit(1594426002.952:86): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dsystemd-udev-settle comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   12.376865] audit: type=3D1130 audit(1594426003.005:87): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Ddmraid-activation comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   12.376872] audit: type=3D1131 audit(1594426003.005:88): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Ddmraid-activation comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   12.445682] audit: type=3D1130 audit(1594426003.072:89): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dsystemd-fsck@dev-disk-by\x2duuid-0dcc7397\x2dae40\x2d4d2b\x2d=
b6ef\x2d5b635b65bbc1
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   12.450956] audit: type=3D1130 audit(1594426003.079:90): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dsystemd-fsck@dev-mapper-fedora\x2dhome comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   12.461124] EXT4-fs (nvme0n1p2): mounted filesystem with ordered
data mode. Opts: (null)
[   12.466048] ext4 filesystem being mounted at /boot supports
timestamps until 2038 (0x7fffffff)
[   12.506727] EXT4-fs (dm-2): mounted filesystem with ordered data
mode. Opts: (null)
[   12.517610] EXT4-fs (sdb1): mounted filesystem with ordered data
mode. Opts: (null)
[   12.585821] audit: type=3D1130 audit(1594426003.214:91): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Dsystemd-fsck@dev-disk-by\x2duuid-4d1c78aa\x2d8887\x2d4832\x2d=
9ef9\x2d3207637e0e3f
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   12.690565] EXT4-fs (sda1): mounted filesystem with ordered data
mode. Opts: (null)
[   12.714832] audit: type=3D1130 audit(1594426003.343:92): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0
msg=3D'unit=3Ddracut-shutdown comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   13.001255] nct6775: Enabling hardware monitor logical device mappings.
[   13.001283] nct6775: Found NCT6793D or compatible chip at 0x2e:0x290
[   13.001286] ACPI Warning: SystemIO range
0x0000000000000295-0x0000000000000296 conflicts with OpRegion
0x0000000000000290-0x0000000000000299 (\_GPE.HWM)
(20200326/utaddress-204)
[   13.001290] ACPI: This conflict may cause random problems and
system instability
[   13.001290] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver
[   13.001780] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.001865] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.001866] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.001867] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.001979] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002064] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.002065] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.002066] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.002151] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002262] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.002263] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.002264] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.002317] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002342] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.002343] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.002344] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.002398] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002414] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002414] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002430] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002431] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002446] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002447] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002464] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002464] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002476] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002477] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002492] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002493] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002509] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002509] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002524] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002525] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002541] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002541] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002557] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002557] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002573] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002637] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002721] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.002724] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[   13.002724] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.002836] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.002889] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.002889] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.002890] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.002915] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002918] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002919] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002921] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002922] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002925] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002925] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002928] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.002929] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.002931] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003093] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003137] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003138] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[   13.003139] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003222] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003265] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003265] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.003266] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003360] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003376] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003376] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003425] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003426] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.003452] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003452] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.003453] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003468] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003481] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003482] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003501] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003501] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003515] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003515] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003565] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003566] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.003567] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003641] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.003660] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003661] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003730] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003731] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.003731] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003756] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003770] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.003771] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003837] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003837] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.003838] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003899] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.003925] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.003926] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.003926] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.003949] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.004025] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   13.004025] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   13.004026] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   13.004048] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.004051] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.004051] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.004054] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.004055] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   13.004057] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.004058] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.004062] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.004063] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   13.004065] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   13.021773] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.021773] Bluetooth: BNEP filters: protocol multicast
[   13.021775] Bluetooth: BNEP socket layer initialized
[   13.418992] Lockdown: tuned: /dev/mem,kmem,port is restricted; see
man kernel_lockdown.7
[   13.456697] snd_hda_intel 0000:00:1f.3: EDR: ACPI event 0x2 received
[   13.982231] snd_hda_intel 0000:00:1f.3: EDR: ACPI event 0x2 received
[   14.087135] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[   14.109334] tun: Universal TUN/TAP device driver, 1.6
[   14.110656] virbr0: port 1(virbr0-nic) entered blocking state
[   14.110657] virbr0: port 1(virbr0-nic) entered disabled state
[   14.110691] device virbr0-nic entered promiscuous mode
[   14.485554] virbr0: port 1(virbr0-nic) entered blocking state
[   14.485556] virbr0: port 1(virbr0-nic) entered listening state
[   14.533981] virbr0: port 1(virbr0-nic) entered disabled state
[   14.713856] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.713984] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.713985] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   14.713986] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.714163] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.714325] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.714325] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001100/00002000
[   14.714326] pcieport 0000:00:1c.0: AER:    [ 8] Rollover
[   14.714327] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.714374] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.714377] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.714378] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.714441] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.714442] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.714625] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.714626] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001100/00002000
[   14.714626] pcieport 0000:00:1c.0: AER:    [ 8] Rollover
[   14.714627] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.714705] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.714837] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.714837] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   14.714838] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.714876] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.714886] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.714886] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.714906] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.714907] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   14.714907] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.714939] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715025] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.715026] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   14.715026] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.715143] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715288] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.715289] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   14.715289] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.715405] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715460] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   14.715461] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   14.715461] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   14.715467] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715470] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715470] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715473] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715474] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715476] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715477] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715480] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715480] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715483] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715484] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715486] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715487] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715490] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715490] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715493] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715494] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715496] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715497] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715500] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715500] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715503] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715504] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715506] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715507] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715509] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715510] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715513] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715513] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715516] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715517] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715520] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715520] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715523] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715524] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715526] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715527] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715529] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715530] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   14.715533] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   14.715533] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   14.715536] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   16.700728] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   17.024273] rfkill: input handler disabled
[   18.920160] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps
Full Duplex, Flow Control: Rx/Tx
[   18.920233] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s31f6: link becomes ready
[   25.331540] rfkill: input handler enabled
[   26.418344] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   26.870176] rfkill: input handler disabled
[   26.971507] Bluetooth: RFCOMM TTY layer initialized
[   26.971511] Bluetooth: RFCOMM socket layer initialized
[   26.971551] Bluetooth: RFCOMM ver 1.11
[   29.878103] logitech-hidpp-device 0003:046D:405E.0007: HID++ 4.5
device connected.
[   30.366104] logitech-hidpp-device 0003:046D:405E.0007: multiplier =3D 8
[   30.368524] [drm:drm_dp_mst_dpcd_read [drm_kms_helper]] *ERROR*
mstb 0000000064d6440c port 1: DPCD read on addr 0x4b0 for 1 bytes
NAKed
[   43.407557] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   45.105738] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   45.116263] Lockdown: systemd-logind: hibernation is restricted;
see man kernel_lockdown.7
[   45.133410] PM: suspend entry (deep)
[   45.145159] Filesystems sync: 0.011 seconds
[   45.303287] Freezing user space processes ... (elapsed 0.193 seconds) do=
ne.
[   45.497050] OOM killer disabled.
[   45.497052] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   45.498559] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   45.499383] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.499468] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.499472] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[   45.499475] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.499565] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.499672] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.499676] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.499699] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.499780] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.499874] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.499877] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.499879] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.499959] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.500075] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.500078] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.500080] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.500139] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.500249] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.500251] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.500253] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.500348] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.500432] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.500435] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.500437] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.500557] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.500621] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.500623] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.500626] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.500730] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.500824] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.500827] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.500829] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.500909] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.501068] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.501070] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.501095] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.501171] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.501265] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.501267] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.501270] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.501323] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.501426] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.501428] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.501431] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.501538] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.501607] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.501610] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.501612] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.501727] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.501791] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.501794] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.501796] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.501906] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.502004] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.502007] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.502009] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.502094] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.502200] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.502203] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.502205] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.502289] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.502354] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.502357] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.502359] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.502440] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.502501] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.502504] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.502506] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.502628] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.502685] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.502688] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.502690] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.502805] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.502895] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.502898] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.502900] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.502988] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.503105] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.503108] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.503110] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.503169] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.503282] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.503285] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.503287] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.503372] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.503480] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.503481] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.503481] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.503538] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.503633] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.503633] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.503634] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.503657] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.503769] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.503769] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.503770] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.503825] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.503911] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.503911] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.503912] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504028] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.504109] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.504110] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.504110] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504197] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.504252] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.504253] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.504253] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504312] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.504415] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.504416] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.504416] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504510] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.504560] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.504560] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.504561] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504632] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.504714] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.504714] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.504715] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504774] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.504850] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.504851] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.504851] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.504958] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.505040] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505040] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505041] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505131] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.505186] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505187] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505187] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505294] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.505349] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505350] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505350] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505409] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.505491] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505492] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505492] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505551] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.505586] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505587] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505587] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505662] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.505723] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505723] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505724] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505826] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.505939] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.505940] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.505940] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.505997] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.506041] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.506042] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.506123] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.506124] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.506124] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.506183] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.506239] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.506240] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.506240] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.506299] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.506375] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.506376] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.506376] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.506482] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.506541] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.506542] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.506542] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.506628] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.506706] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.506706] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.506707] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.506827] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.506917] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.506917] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.506918] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.506973] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507079] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.507080] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.507081] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.507137] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507224] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.507225] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.507225] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.507300] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507407] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.507407] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.507408] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.507498] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507557] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   45.507558] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   45.507558] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   45.507589] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507592] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507593] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507596] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507596] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507599] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507599] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507602] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507603] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507605] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507606] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507608] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507609] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507612] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507612] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507615] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507615] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507618] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507634] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507640] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507640] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507646] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507646] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507652] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507653] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507659] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507659] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507664] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507664] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507667] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507668] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507670] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507671] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507674] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507674] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507676] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507677] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507680] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507680] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507683] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507684] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507686] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507687] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507690] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507690] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507693] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507693] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507700] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507700] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507706] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507706] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507709] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507710] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507712] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507713] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507716] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507716] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507722] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507723] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507728] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507729] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507733] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507733] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507736] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507736] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507739] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507740] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507742] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507743] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507759] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507759] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507762] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507762] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507765] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507766] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507782] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507783] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507786] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507786] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.507789] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507790] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507792] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507793] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507795] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507796] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507799] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507799] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.507802] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.507803] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508020] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508020] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508023] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508023] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508026] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508027] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508042] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508043] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508045] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508046] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508049] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508049] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508052] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508053] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508055] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508056] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508058] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508059] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508067] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508067] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508082] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508082] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508098] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508098] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508128] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508128] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508137] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508138] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508140] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508141] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508144] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508144] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508147] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508148] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508163] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508164] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508167] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508168] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508171] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508171] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508174] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508174] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508179] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508180] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508183] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508197] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508199] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508200] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508203] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508203] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508206] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508206] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508209] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508210] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508212] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508213] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508216] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508216] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508219] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508220] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508222] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508223] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508227] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508228] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508230] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508231] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508248] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508248] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508251] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508251] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508254] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508255] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508272] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508273] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508276] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508276] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508279] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508280] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508285] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508286] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508288] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508289] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508292] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508292] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508295] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508295] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508298] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508299] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508301] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508302] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508305] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508305] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508321] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508322] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508324] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508325] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508327] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508328] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508343] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508344] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508346] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508347] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508350] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508350] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508353] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508354] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508356] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508357] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508360] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508360] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508363] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508364] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508379] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508379] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508382] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508382] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508385] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508399] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508402] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508403] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508405] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508406] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508409] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508409] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508412] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508413] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508415] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508416] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508418] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508419] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508435] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508435] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508438] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508439] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508441] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508442] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508458] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508458] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508461] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508462] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508464] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508465] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508468] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508468] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508471] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508472] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508474] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508475] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508477] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508478] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508481] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508481] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508484] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508485] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508490] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508491] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508493] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508494] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508497] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508497] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508500] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508501] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508503] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508504] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   45.508506] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508507] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   45.508510] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   45.508858] e1000e: EEE TX LPI TIMER: 00000011
[   45.511637] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
[   45.511736] sd 3:0:0:0: [sdb] Stopping disk
[   45.515690] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   45.515766] sd 1:0:0:0: [sda] Stopping disk
[   46.517791] PM: suspend devices took 1.020 seconds
[   46.557473] ACPI: Preparing to enter system sleep state S3
[   46.762205] PM: Saving platform NVS memory
[   46.762213] Disabling non-boot CPUs ...
[   46.762215] Wakeup pending. Abort CPU freeze
[   46.762216] Non-boot CPUs are not disabled
[   46.762220] ACPI: Waking up from system sleep state S3
[   46.768282] pcieport 0000:00:1c.0: EDR: ACPI event 0x0 received
[   46.768288] pcieport 0000:00:1c.4: EDR: ACPI event 0x0 received
[   46.768323] pcieport 0000:00:1d.0: EDR: ACPI event 0x0 received
[   46.768326] pcieport 0000:00:1b.0: EDR: ACPI event 0x0 received
[   46.769427] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS
workaround enabled
[   46.780834] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS
workaround enabled
[   46.780836] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
workaround enabled
[   46.792965] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   46.792972] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   46.792973] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001100/00002000
[   46.792975] pcieport 0000:00:1c.0: AER:    [ 8] Rollover
[   46.792976] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   46.794518] usb usb3: root hub lost power or was reset
[   46.794520] usb usb4: root hub lost power or was reset
[   46.804489] sd 1:0:0:0: [sda] Starting disk
[   46.804501] sd 3:0:0:0: [sdb] Starting disk
[   46.858451] nvme nvme0: Shutdown timeout set to 8 seconds
[   46.870409] nvme nvme0: 4/0/0 default/read/poll queues
[   46.946527] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946540] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   46.946544] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[   46.946548] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   46.946561] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946569] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946572] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946579] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946582] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946588] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946591] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946606] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946609] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946617] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946619] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946626] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946629] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946636] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946639] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946646] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946649] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946656] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946658] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946666] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946668] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946675] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946678] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946685] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946688] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946694] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946697] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946704] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946707] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946714] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946717] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946724] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946726] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946734] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946736] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946744] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946747] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946754] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946757] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946764] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946766] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946773] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946776] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946783] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946786] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946793] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946796] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   46.946803] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946806] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946813] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946816] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946823] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946825] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946832] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946835] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946842] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946845] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946851] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946854] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946861] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946864] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946871] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946873] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946881] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946883] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946890] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946893] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946901] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946904] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946911] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946913] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946921] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946923] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946930] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946933] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946940] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946943] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946950] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946952] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946960] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946962] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946969] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946972] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946979] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946982] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946989] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.946991] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.946999] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.947001] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.947009] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   46.947012] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   46.947019] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.025861] PM: resume devices took 0.232 seconds
[   47.026253] acpi LNXPOWER:13: Turning OFF
[   47.026467] acpi LNXPOWER:12: Turning OFF
[   47.026692] acpi LNXPOWER:11: Turning OFF
[   47.026902] acpi LNXPOWER:10: Turning OFF
[   47.027108] acpi LNXPOWER:0f: Turning OFF
[   47.027313] acpi LNXPOWER:0e: Turning OFF
[   47.027518] acpi LNXPOWER:0d: Turning OFF
[   47.027741] acpi LNXPOWER:0c: Turning OFF
[   47.027948] acpi LNXPOWER:0b: Turning OFF
[   47.028153] acpi LNXPOWER:0a: Turning OFF
[   47.028356] acpi LNXPOWER:09: Turning OFF
[   47.028559] acpi LNXPOWER:08: Turning OFF
[   47.028989] acpi LNXPOWER:07: Turning OFF
[   47.029193] mei_hdcp
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
(ops i915_hdcp_component_ops [i915])
[   47.029410] acpi LNXPOWER:06: Turning OFF
[   47.029630] acpi LNXPOWER:05: Turning OFF
[   47.029862] acpi LNXPOWER:04: Turning OFF
[   47.030068] acpi LNXPOWER:03: Turning OFF
[   47.030274] acpi LNXPOWER:02: Turning OFF
[   47.030480] acpi LNXPOWER:01: Turning OFF
[   47.030698] acpi LNXPOWER:00: Turning OFF
[   47.030834] OOM killer enabled.
[   47.030835] Restarting tasks ...
[   47.031185] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   47.031197] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   47.031201] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   47.031205] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   47.035327] done.
[   47.036632] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   47.036739] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   47.036742] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   47.036747] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   47.036998] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037227] pci_bus 0000:03: Allocating resources
[   47.037236] pci 0000:02:00.0: bridge window [io  0x1000-0x0fff] to
[bus 03] add_size 1000
[   47.037238] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   47.037242] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001100/00002000
[   47.037247] pci 0000:02:00.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000
add_align 100000
[   47.037253] pci 0000:02:00.0: bridge window [mem
0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[   47.037255] pcieport 0000:00:1c.0: AER:    [ 8] Rollover
[   47.037258] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   47.037264] pci 0000:02:00.0: BAR 14: no space for [mem size 0x00200000]
[   47.037267] pci 0000:02:00.0: BAR 14: failed to assign [mem size 0x00200=
000]
[   47.037271] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037273] pci 0000:02:00.0: BAR 15: no space for [mem size
0x00200000 64bit pref]
[   47.037277] pci 0000:02:00.0: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[   47.037281] pci 0000:02:00.0: BAR 13: no space for [io  size 0x1000]
[   47.037282] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037286] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037288] pci 0000:02:00.0: BAR 13: failed to assign [io  size 0x1000]
[   47.037293] pci 0000:02:00.0: BAR 14: no space for [mem size 0x00200000]
[   47.037296] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037298] pci 0000:02:00.0: BAR 14: failed to assign [mem size 0x00200=
000]
[   47.037301] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037303] pci 0000:02:00.0: BAR 15: no space for [mem size
0x00200000 64bit pref]
[   47.037307] pci 0000:02:00.0: BAR 15: failed to assign [mem size
0x00200000 64bit pref]
[   47.037311] pci 0000:02:00.0: BAR 13: no space for [io  size 0x1000]
[   47.037312] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037315] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037317] pci 0000:02:00.0: BAR 13: failed to assign [io  size 0x1000]
[   47.037322] pci 0000:02:00.0: PCI bridge to [bus 03]
[   47.037325] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037328] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037345] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037348] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   47.037456] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   47.037459] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[   47.037462] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   47.037473] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037481] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037484] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037491] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037494] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037501] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037504] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   47.037511] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037514] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   47.037521] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037524] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   47.037531] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.037534] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   47.037541] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   47.040351] PM: suspend exit
[   47.040483] PM: suspend entry (s2idle)
[   47.129158] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   47.129883] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   47.130274] ata4.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   47.130275] ata4.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   47.130276] ata4.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   47.130299] ata5: SATA link down (SStatus 4 SControl 300)
[   47.130673] ata6: SATA link down (SStatus 4 SControl 300)
[   47.130697] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   47.130711] ata1: SATA link down (SStatus 4 SControl 300)
[   47.132299] ata2.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   47.132300] ata2.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   47.132301] ata2.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   47.134555] ata3.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   47.134557] ata3.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   47.134558] ata3.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   47.135672] ata2.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   47.135673] ata2.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   47.135674] ata2.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   47.137431] ata2.00: configured for UDMA/133
[   47.143359] ata3.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   47.143360] ata3.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   47.143361] ata3.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   47.144266] ata3.00: configured for UDMA/100
[   49.610283] logitech-hidpp-device 0003:046D:405E.0007: multiplier =3D 8
[   50.290809] ata4.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   50.290815] ata4.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   50.290819] ata4.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   50.291393] ata4.00: configured for UDMA/133
[   50.308959] Filesystems sync: 3.268 seconds
[   50.466404] Freezing user space processes ... (elapsed 0.003 seconds) do=
ne.
[   50.469982] OOM killer disabled.
[   50.469984] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[   50.471535] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   50.482674] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482679] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   50.482679] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003100/00002000
[   50.482680] pcieport 0000:00:1c.0: AER:    [ 8] Rollover
[   50.482681] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   50.482687] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482690] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482690] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482693] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482693] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482696] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482697] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482699] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482700] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482702] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482703] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482706] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482706] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482709] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482709] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482712] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482713] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482715] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482716] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482718] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482719] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482722] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482722] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482725] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482725] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482728] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482728] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482731] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482732] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482734] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482735] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482738] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482738] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482741] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482741] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482744] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482744] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482747] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482748] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482750] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482751] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482753] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482754] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482757] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482757] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482760] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482760] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482763] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482764] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482766] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482767] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482769] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482770] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482773] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482773] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482776] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482776] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482779] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482779] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482782] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482783] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482785] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482786] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482789] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482789] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482792] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482792] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482795] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482795] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482798] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482799] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482801] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482802] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482804] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482805] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482808] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482808] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482811] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482811] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482814] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482815] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482817] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482818] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482820] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482821] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482823] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482824] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482827] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482827] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482830] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482830] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482833] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482834] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482836] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482837] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482839] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482840] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482843] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482843] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482846] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482846] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482849] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482850] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482852] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482853] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482855] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482856] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482859] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482859] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482862] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482862] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482865] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482866] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482868] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482869] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482871] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482872] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482875] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482875] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482878] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482878] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482881] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482882] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482884] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482885] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482887] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482888] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482891] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482891] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482894] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482894] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482897] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482898] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482900] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482901] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482903] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482904] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482907] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482907] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482910] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482910] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482913] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482914] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482916] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482917] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482919] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482920] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482923] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482923] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482926] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482926] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482929] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482929] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482932] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482933] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482935] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482936] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482939] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482939] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482942] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482942] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482945] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482945] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482948] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482949] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482951] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482952] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482954] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482955] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482958] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482958] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482961] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482961] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482964] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482965] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482967] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482968] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482971] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482971] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482974] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482974] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482977] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482977] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482980] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482981] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482983] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482984] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482986] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482987] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482990] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482990] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482993] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482993] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482996] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.482997] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.482999] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483000] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483002] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483003] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483006] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483006] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483009] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483009] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483012] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483013] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483015] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483016] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483018] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483019] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483021] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483022] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483025] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483025] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483028] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483028] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483031] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483032] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483034] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483035] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483038] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483038] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483041] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483041] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483044] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483044] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483047] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483048] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483050] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483051] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483053] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483054] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483057] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483057] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483060] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483060] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   50.483063] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483064] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483066] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483067] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483069] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483070] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483073] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483073] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483076] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483076] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483079] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483079] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483082] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483083] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483085] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483086] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483088] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483089] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   50.483092] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   50.483665] e1000e: EEE TX LPI TIMER: 00000011
[   50.486701] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[   50.486823] sd 1:0:0:0: [sda] Stopping disk
[   50.489672] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
[   50.489824] sd 3:0:0:0: [sdb] Stopping disk
[   51.494527] PM: suspend devices took 1.023 seconds
[   51.545051] pcieport 0000:00:1c.4: Intel SPT PCH root port ACS
workaround enabled
[   51.557025] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[   51.557039] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   51.557042] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003100/00002000
[   51.557046] pcieport 0000:00:1c.0: AER:    [ 8] Rollover
[   51.557049] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   51.559595] pcieport 0000:00:1c.0: Intel SPT PCH root port ACS
workaround enabled
[   51.559602] pcieport 0000:00:1d.0: Intel SPT PCH root port ACS
workaround enabled
[   51.560571] usb usb3: root hub lost power or was reset
[   51.560575] usb usb4: root hub lost power or was reset
[   51.561808] sd 1:0:0:0: [sda] Starting disk
[   51.561810] sd 3:0:0:0: [sdb] Starting disk
[   51.713716] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713728] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[   51.713732] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[   51.713736] pcieport 0000:00:1c.0: AER:    [12] Timeout
[   51.713749] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713757] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713760] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713767] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713770] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713777] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713780] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713787] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713789] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713796] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713799] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713806] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713809] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713816] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713819] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713826] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713829] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713836] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713838] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713845] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713848] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713855] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713858] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713865] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713867] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713875] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713877] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713884] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713887] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713894] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713897] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713904] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713906] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713914] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713916] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713923] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713926] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713933] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713936] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713943] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713946] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713953] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713955] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713963] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713965] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713972] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713975] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713982] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713985] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.713992] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.713994] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714001] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714004] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714011] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714014] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714021] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714023] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714031] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714033] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714040] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714043] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714050] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714053] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714060] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714062] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714069] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714072] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714079] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714082] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714089] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714091] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714099] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714101] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714108] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714111] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714118] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714121] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714128] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714130] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714138] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714140] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714147] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714150] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714157] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714160] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714167] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714169] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714176] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714179] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714186] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714189] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714196] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714199] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714206] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.714209] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[   51.714216] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[   51.820118] PM: resume devices took 0.262 seconds
[   51.820123] OOM killer enabled.
[   51.820123] Restarting tasks ... done.
[   51.823095] mei_hdcp
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
(ops i915_hdcp_component_ops [i915])
[   51.823548] logitech-hidpp-device 0003:046D:405E.0007: multiplier =3D 8
[   51.826039] PM: suspend exit
[   51.851672] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps
Half Duplex, Flow Control: None
[   51.887049] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   51.889113] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   51.889129] ata4.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   51.889130] ata4.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   51.889131] ata4.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   51.889141] ata5: SATA link down (SStatus 4 SControl 300)
[   51.889157] ata6: SATA link down (SStatus 4 SControl 300)
[   51.889951] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   51.889971] ata1: SATA link down (SStatus 4 SControl 300)
[   51.894730] ata3.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   51.894732] ata3.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   51.894733] ata3.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   51.902572] ata2.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   51.902573] ata2.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   51.902574] ata2.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   51.902577] ata3.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   51.902578] ata3.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   51.902579] ata3.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   51.904887] ata3.00: configured for UDMA/100
[   51.907039] ata2.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   51.907041] ata2.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   51.907042] ata2.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   51.908515] ata2.00: configured for UDMA/133
[   51.929930] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Down
[   54.767180] ata4.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succee=
ded
[   54.767181] ata4.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
LOCK) filtered out
[   54.767182] ata4.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
CONFIGURATION OVERLAY) filtered out
[   54.767627] ata4.00: configured for UDMA/133
[   57.327218] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps
Full Duplex, Flow Control: Rx/Tx
[   57.327293] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s31f6: link becomes ready
[  181.191027] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  181.191106] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[  181.191107] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[  181.191108] pcieport 0000:00:1c.0: AER:    [12] Timeout
[  181.191175] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  181.191186] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  181.191187] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  181.191191] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  181.191191] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  181.191194] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  183.027487] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  183.027586] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[  183.027587] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00003000/00002000
[  183.027588] pcieport 0000:00:1c.0: AER:    [12] Timeout
[  183.027636] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  183.027641] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  183.027642] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  183.027648] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  183.027649] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  183.027655] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  187.453660] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  187.453824] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[  187.453825] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[  187.453825] pcieport 0000:00:1c.0: AER:    [12] Timeout
[  187.453849] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  187.453854] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  187.453855] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  187.453861] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  187.453862] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  187.453868] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  187.453868] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  187.453875] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054903] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054909] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[  426.054910] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[  426.054911] pcieport 0000:00:1c.0: AER:    [12] Timeout
[  426.054917] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054920] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054921] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054923] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054924] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054927] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054927] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054930] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054931] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054933] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054934] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054937] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  426.054937] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  426.054940] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  442.425825] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  442.425841] pcieport 0000:00:1c.0: AER: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[  442.425845] pcieport 0000:00:1c.0: AER:   device [8086:a292] error
status/mask=3D00001000/00002000
[  442.425848] pcieport 0000:00:1c.0: AER:    [12] Timeout
[  442.425868] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[  442.425877] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  442.425881] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  442.425889] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  442.425891] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  442.425899] pcieport 0000:00:1c.0: AER: can't find device of ID00e0
[  442.425901] pcieport 0000:00:1c.0: AER: Multiple Corrected error
received: 0000:00:1c.0
[  442.425908] pcieport 0000:00:1c.0: AER: can't find device of ID00e0

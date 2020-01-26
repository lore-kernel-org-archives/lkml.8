Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50116C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0618D2071A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="P/MSmq6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAZOl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 09:41:28 -0500
Received: from mout.gmx.net ([212.227.17.21]:53961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgAZOl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 09:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580049684;
        bh=U0RQNL+QSK9vxeHNGl8rFaqlide/5eH5/tKdLbjFx20=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=P/MSmq6Z1I6fyXN4pSUWcSf38d5rmu4BLyqTNjXIjcz9A9jriKAgXtq3iBemFj/o0
         Zlz/lZscCifEGz9NN6VtnJP6O5D7ml7iL+isWPyG31dmkwDTz+uOJwBlWW54n21b3d
         bmLS5IP3xsQj/MljHkJD1KhhE8CYQf0FefYjlzUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.1.113.146]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5wPb-1iyECl1clf-007UfY for
 <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 15:41:24 +0100
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: delayed "random: get_random_bytes" line in dmesg
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a4d06aa4-30df-4333-6b94-46fa95e32129@gmx.de>
Date:   Sun, 26 Jan 2020 15:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GKiLmDEKyLFhWQM59MOBVo7DPQfM2R7Vws/zROAt0Z4V1D/7i5K
 bm0I2HgirrJXSsk5njnQZQGCHkrOKoN2PFxQpkK7E0vHH36Pra+rJ9BuTHXF9K+aEIPKIDn
 FYe/M1r93T8kpN6itOu7LA9gEdOEQg7SKRW3rkAVJzevyeel9VRiFYsXjJ4gqIj+kwfvibM
 6BvuxR5TrB7B9Z2DaAVzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4xtop3UXAg=:EdUXycyDpTyKuNFOv8LaZA
 63NaG9ko5d3q3fQGlGjf84xrGley1+1tqQRIXhpaykbbEXdzhMoowUZhxO1h78KSNLnKe1ddW
 S2jrhhXICyuP6ugMFslL+MaCfbcS6DwVwkQmQQuPxAzyZDQ9miG9b1dxJb2iTRr425mvWLwke
 3cT7f5mEKs1rPIpI0FCOvhI8l9LceVBBRURAGjLS1i9ZOKdOFrgEdmrmpyGMLCo8NtverFBBs
 x6n+XoDy3W3iT3EpNifMOqNqR+xZe2+kOgr34JHN/soI7tUVJOgeJ+ozcbBXL+N/2qGZ6zupt
 dVtbgkWeJly6Vs5743HlPWwiXO9hM1b02vME9Yu5sgMTXBeNRDmcU/9a9Dl9uFTYBfXNigQMl
 nM/9R1YO97/stbBvTRiOfc3LlGKNB+340v+UoSpN3hnl8jjKegHWhL/7eYpevKLloMbCIWo93
 IMgB42TczkEJBmGRWEKA+x2J6WoW40NG7iT1lR/+AGoEZq3Ou9LFVM1GJkGwL6Tg7yLhu/W5w
 v/7R3oC3hFkLZKGN9FqXTBvLB24EL4HhPDMa8hClrixhrAGVQvdJdlda+KyJ/WLmvVvaWeIUk
 U+eiViWVMDBGxN/iQPVN3mTzcZYZXreGIVI+Qo5gxQywONYIjJCCSU0MmwVXJh+OAJx1aAdZ+
 5iTNhqSYO0OQR2WAX4mW9MacjIUWhtsSu5ce8SXawIwJxg6h4b03kg2KbPpkBbEmJDCAHFQ5S
 /5t0v6wUy3ob8mXOANO/5g0Lwno4WNI5vOGwytZIgEtjK9FTbioXdZuno34HXuhq5UfZUJ0FY
 1yvXQpO8rvLTPTfe36R76t2WK6FTDKNZJXuD6U4DywrxZdzq799LM4Z5TMDS9CP7wTjsOz9BU
 70OdmgLClX5qhrUvic4rbi8mFNhLT/WgQam7WI/DqgFqDmKCKFezzrzk4SWdN0dwsFbmJI748
 3qgpU5QQhWNhJ/+sjZba7aYzfmVsZwuUnzEqUVjXY4IiTSlW7QehJhLASHZ8qF6YbvWKY3dua
 EbRep9HLkmQnAWfgzYf8k2xDR4nDm/51XWBEL0I/vbIjw7SV6vuuWN9BkdYc4sEHavzqPWH8s
 OwvoXjS/de1r1JtY2nLKnC+2WesKWI7Xu7wK9K/gkqD4gtW6jXOEeWOcG7yLWAOS8lAl/tDo7
 JGz1a4sOJUi7QS9QWmo4KwlUYxYz3hJjV1pV8E3sbsME7lUyM7watHJSLxemcLUNTspjP3voH
 jOwZDyhhv5mLTXjCE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do wonder a little bit about the timestamp of the "random: get_random_by=
tes" near the end b/c it is way delayed, or?

[    0.000000] microcode: microcode updated early to revision 0x43, date =
=3D 2019-03-01
[    0.000000] Linux version 5.4.15 (root@mr-fox) (gcc version 9.2.0 (Gent=
oo Hardened 9.2.0-r2 p3)) #6 SMP Sun Jan 26 10:07:17 CET 2020
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.4.15 root=3D/dev/sda4=
 ro spectre_v2_user=3Don
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poin=
t registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 b=
ytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000078e7afff] usab=
le
[    0.000000] BIOS-e820: [mem 0x0000000078e7b000-0x000000007afecfff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x000000007afed000-0x000000007b047fff] ACPI=
 data
[    0.000000] BIOS-e820: [mem 0x000000007b048000-0x000000007be68fff] ACPI=
 NVS
[    0.000000] BIOS-e820: [mem 0x000000007be69000-0x000000008fffffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed44fff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] rese=
rved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000207fffffff] usab=
le
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: ASUSTeK COMPUTER INC. Z10PA-U8 Series/Z10PA-U8 Series,=
 BIOS 3703 08/02/2018
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3492.093 MHz processor
[    0.000715] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> res=
erved
[    0.000716] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000721] last_pfn =3D 0x2080000 max_arch_pfn =3D 0x400000000
[    0.000723] MTRR default type: write-back
[    0.000724] MTRR fixed ranges enabled:
[    0.000725]   00000-9FFFF write-back
[    0.000725]   A0000-BFFFF uncachable
[    0.000726]   C0000-FFFFF write-protect
[    0.000726] MTRR variable ranges enabled:
[    0.000727]   0 base 000080000000 mask 3FFF80000000 uncachable
[    0.000728]   1 base 038000000000 mask 3FC000000000 uncachable
[    0.000728]   2 disabled
[    0.000728]   3 disabled
[    0.000729]   4 disabled
[    0.000729]   5 disabled
[    0.000729]   6 disabled
[    0.000729]   7 disabled
[    0.000730]   8 disabled
[    0.000730]   9 disabled
[    0.001227] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- W=
T
[    0.001762] x2apic: enabled by BIOS, switching to x2apic ops
[    0.001764] last_pfn =3D 0x78e7b max_arch_pfn =3D 0x400000000
[    0.001773] Using GB pages for direct mapping
[    0.001775] BRK [0x1e73801000, 0x1e73801fff] PGTABLE
[    0.001776] BRK [0x1e73802000, 0x1e73802fff] PGTABLE
[    0.001777] BRK [0x1e73803000, 0x1e73803fff] PGTABLE
[    0.001791] BRK [0x1e73804000, 0x1e73804fff] PGTABLE
[    0.001813] BRK [0x1e73805000, 0x1e73805fff] PGTABLE
[    0.001823] BRK [0x1e73806000, 0x1e73806fff] PGTABLE
[    0.001848] ACPI: Early table checksum verification disabled
[    0.001850] ACPI: RSDP 0x00000000000F0580 000024 (v02 ALASKA)
[    0.001853] ACPI: XSDT 0x000000007AFFF0A8 0000C4 (v01 ALASKA A M I    0=
1072009 AMI  00010013)
[    0.001857] ACPI: FACP 0x000000007B02BB50 00010C (v05 ALASKA A M I    0=
1072009 AMI  00010013)
[    0.001862] ACPI: DSDT 0x000000007AFFF200 02C94D (v02 ALASKA A M I    0=
1072009 INTL 20091013)
[    0.001864] ACPI: FACS 0x000000007BE67F80 000040
[    0.001866] ACPI: APIC 0x000000007B02BC60 000100 (v03 ALASKA A M I    0=
1072009 AMI  00010013)
[    0.001868] ACPI: FPDT 0x000000007B02BD60 000044 (v01 ALASKA A M I    0=
1072009 AMI  00010013)
[    0.001870] ACPI: FIDT 0x000000007B02BDA8 00009C (v01 ALASKA A M I    0=
1072009 AMI  00010013)
[    0.001872] ACPI: MCFG 0x000000007B02BE48 00003C (v01 ALASKA A M I    0=
1072009 MSFT 00000097)
[    0.001874] ACPI: EINJ 0x000000007B046EC0 000130 (v01 ALASKA A M I    0=
0000001 INTL 00000001)
[    0.001876] ACPI: UEFI 0x000000007B02BEE0 000042 (v01 ALASKA A M I    0=
1072009      00000000)
[    0.001877] ACPI: HPET 0x000000007B02BF28 000038 (v01 ALASKA A M I    0=
0000001 INTL 20091013)
[    0.001879] ACPI: MSCT 0x000000007B02BF60 000090 (v01 ALASKA A M I    0=
0000001 INTL 20091013)
[    0.001881] ACPI: SLIT 0x000000007B02BFF0 00002D (v01 ALASKA A M I    0=
0000001 INTL 20091013)
[    0.001883] ACPI: SRAT 0x000000007B02C020 001158 (v03 ALASKA A M I    0=
0000001 INTL 20091013)
[    0.001885] ACPI: WDDT 0x000000007B02D178 000040 (v01 ALASKA A M I    0=
0000000 INTL 20091013)
[    0.001887] ACPI: SSDT 0x000000007B02D1B8 01717F (v02 ALASKA PmMgt    0=
0000001 INTL 20120913)
[    0.001889] ACPI: SSDT 0x000000007B044338 002652 (v02 ALASKA SpsNm    0=
0000002 INTL 20120913)
[    0.001891] ACPI: SSDT 0x000000007B046990 000064 (v02 ALASKA SpsNvs   0=
0000002 INTL 20120913)
[    0.001893] ACPI: PRAD 0x000000007B0469F8 000102 (v02 ALASKA A M I    0=
0000002 INTL 20120913)
[    0.001895] ACPI: DMAR 0x000000007B046B00 0000B4 (v01 ALASKA A M I    0=
0000001 INTL 20091013)
[    0.001897] ACPI: HEST 0x000000007B046BB8 0000A8 (v01 ALASKA A M I    0=
0000001 INTL 00000001)
[    0.001899] ACPI: BERT 0x000000007B046C60 000030 (v01 ALASKA A M I    0=
0000001 INTL 00000001)
[    0.001901] ACPI: ERST 0x000000007B046C90 000230 (v01 ALASKA A M I    0=
0000001 INTL 00000001)
[    0.001906] ACPI: Local APIC address 0xfee00000
[    0.001907] Setting APIC routing to cluster x2apic.
[    0.001951] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.001952] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.001953] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.001953] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.001954] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.001954] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.001955] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.001955] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.001956] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.001956] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.001957] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.001957] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.001964] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.001965] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
[    0.001968] NUMA: Initialized distance table, cnt=3D1
[    0.001970] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000=
-0x207fffffff] -> [mem 0x00000000-0x207fffffff]
[    0.001973] NODE_DATA(0) allocated [mem 0x207fffd000-0x207fffefff]
[    0.002060] Zone ranges:
[    0.002061]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.002062]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.002063]   Normal   [mem 0x0000000100000000-0x000000207fffffff]
[    0.002064] Movable zone start for each node
[    0.002064] Early memory node ranges
[    0.002065]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.002066]   node   0: [mem 0x0000000000100000-0x0000000078e7afff]
[    0.002067]   node   0: [mem 0x0000000100000000-0x000000207fffffff]
[    0.002327] Zeroed struct page in unavailable ranges: 29160 pages
[    0.002328] Initmem setup node 0 [mem 0x0000000000001000-0x000000207fff=
ffff]
[    0.002330] On node 0 totalpages: 33525272
[    0.002330]   DMA zone: 64 pages used for memmap
[    0.002331]   DMA zone: 21 pages reserved
[    0.002331]   DMA zone: 3997 pages, LIFO batch:0
[    0.002384]   DMA32 zone: 7674 pages used for memmap
[    0.002385]   DMA32 zone: 491131 pages, LIFO batch:63
[    0.010976]   Normal zone: 516096 pages used for memmap
[    0.010977]   Normal zone: 33030144 pages, LIFO batch:63
[    0.420697] ACPI: PM-Timer IO Port: 0x408
[    0.420700] ACPI: Local APIC address 0xfee00000
[    0.420707] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.420707] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.420708] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.420708] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.420709] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.420710] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.420710] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.420711] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.420711] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.420712] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.420712] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.420713] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.420723] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0=
-23
[    0.420727] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 2=
4-47
[    0.420728] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.420730] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.420731] ACPI: IRQ0 used by override.
[    0.420732] ACPI: IRQ9 used by override.
[    0.420734] Using ACPI (MADT) for SMP configuration information
[    0.420735] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.420740] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.420751] [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.420754] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.490095] setup_percpu: NR_CPUS:12 nr_cpumask_bits:12 nr_cpu_ids:12 n=
r_node_ids:1
[    0.490396] percpu: Embedded 40 pages/cpu s132056 r0 d31784 u262144
[    0.490401] pcpu-alloc: s132056 r0 d31784 u262144 alloc=3D1*2097152
[    0.490402] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- =
-- -- --
[    0.490416] Built 1 zonelists, mobility grouping on.  Total pages: 3300=
1417
[    0.490417] Policy zone: Normal
[    0.490418] Kernel command line: BOOT_IMAGE=3D/vmlinuz-5.4.15 root=3D/d=
ev/sda4 ro spectre_v2_user=3Don
[    0.494611] Dentry cache hash table entries: 8388608 (order: 14, 671088=
64 bytes, linear)
[    0.496771] Inode-cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.496841] mem auto-init: stack:byref_all, heap alloc:on, heap free:on
[    0.496842] mem auto-init: clearing system memory may take some time...
[    0.501217] Calgary: detecting Calgary via BIOS EBDA area
[    0.501218] Calgary: Unable to locate Rio Grande table in EBDA - bailin=
g!
[   14.082984] Memory: 131812972K/134101088K available (12291K kernel code=
, 1400K rwdata, 1912K rodata, 1272K init, 2040K bss, 2288116K reserved, 0K=
 cma-reserved)
[   14.083090] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12,=
 Nodes=3D1
[   14.083098] Kernel/User page tables isolation: enabled
[   14.083150] rcu: Hierarchical RCU implementation.
[   14.083152] rcu: RCU calculated value of scheduler-enlistment delay is =
25 jiffies.
[   14.083162] NR_IRQS: 4352, nr_irqs: 928, preallocated irqs: 16
[   14.083378] random: get_random_bytes called from start_kernel+0x4a9/0x6=
5a with crng_init=3D0
[   14.086747] Console: colour VGA+ 80x25
[   14.098323] printk: console [tty0] enabled
[   14.098422] ACPI: Core revision 20190816
[   14.098706] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,=
 max_idle_ns: 133484882848 ns
[   14.098831] APIC: Switch to symmetric I/O mode setup
[   14.098920] DMAR: Host address width 46
[   14.099005] DMAR: DRHD base: 0x000000fbffc000 flags: 0x1
[   14.099097] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap d2078c106f0=
466 ecap f020df
[   14.099210] DMAR: RMRR base: 0x0000007db0e000 end: 0x0000007db1dfff
[   14.099300] DMAR: ATSR flags: 0x0
[   14.099385] DMAR: RHSA base: 0x000000fbffc000 proximity domain: 0x0
[   14.099476] DMAR-IR: IOAPIC id 1 under DRHD base  0xfbffc000 IOMMU 0
[   14.099567] DMAR-IR: IOAPIC id 2 under DRHD base  0xfbffc000 IOMMU 0
[   14.099658] DMAR-IR: HPET id 0 under DRHD base 0xfbffc000
[   14.099746] DMAR-IR: Queued invalidation will be enabled to support x2a=
pic and Intr-remapping.
[   14.099957] DMAR-IR: Enabled IRQ remapping in x2apic mode
[   14.100523] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
[   14.118831] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles=
: 0x325623c77eb, max_idle_ns: 440795358153 ns
[   14.118952] Calibrating delay loop (skipped), value calculated using ti=
mer frequency.. 6984.18 BogoMIPS (lpj=3D13968372)
[   14.119072] pid_max: default: 32768 minimum: 301
[   14.119181] LSM: Security Framework initializing
[   14.119271] Yama: becoming mindful.
[   14.119372] Mount-cache hash table entries: 131072 (order: 8, 1048576 b=
ytes, linear)
[   14.119487] Mountpoint-cache hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[   14.120700] *** VALIDATE tmpfs ***
[   14.120874] *** VALIDATE proc ***
[   14.120987] *** VALIDATE cgroup1 ***
[   14.121073] *** VALIDATE cgroup2 ***
[   14.121199] mce: CPU0: Thermal monitoring enabled (TM1)
[   14.121326] process: using mwait in idle threads
[   14.121415] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[   14.121505] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB =
4
[   14.121598] Spectre V1 : Mitigation: usercopy/swapgs barriers and __use=
r pointer sanitization
[   14.121713] Spectre V2 : Mitigation: Full generic retpoline
[   14.121801] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RS=
B on context switch
[   14.121914] Spectre V2 : Enabling Restricted Speculation for firmware c=
alls
[   14.122008] Spectre V2 : mitigation: Enabling always-on Indirect Branch=
 Prediction Barrier
[   14.122121] Spectre V2 : User space: Mitigation: STIBP protection
[   14.122211] Speculative Store Bypass: Mitigation: Speculative Store Byp=
ass disabled via prctl and seccomp
[   14.122329] MDS: Mitigation: Clear CPU buffers
[   14.122568] Freeing SMP alternatives memory: 24K
[   14.122982] TSC deadline timer enabled
[   14.122984] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1650 v3 @ 3.50GHz (f=
amily: 0x6, model: 0x3f, stepping: 0x2)
[   14.123154] Performance Events: PEBS fmt2+, Haswell events, 16-deep LBR=
, full-width counters, Intel PMU driver.
[   14.123286] ... version:                3
[   14.123372] ... bit width:              48
[   14.123457] ... generic registers:      4
[   14.123543] ... value mask:             0000ffffffffffff
[   14.123631] ... max period:             00007fffffffffff
[   14.123719] ... fixed-purpose events:   3
[   14.123805] ... event mask:             000000070000000f
[   14.123919] rcu: Hierarchical SRCU implementation.
[   14.124074] smp: Bringing up secondary CPUs ...
[   14.124202] x86: Booting SMP configuration:
[   14.124288] .... node  #0, CPUs:        #1
[    0.019607] random: get_random_bytes called from start_secondary+0x137/=
0x1e0 with crng_init=3D0
[   14.126473]   #2  #3  #4  #5  #6
[   14.135706] Spectre V2 : Update user space SMT mitigation: STIBP always=
-on
[   14.135706] MDS CPU bug present and SMT on, data leak possible. See htt=
ps://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more =
details.
[   14.135706]   #7  #8  #9 #10 #11
[   14.139521] smp: Brought up 1 node, 12 CPUs
[   14.139521] smpboot: Max logical packages: 1
[   14.139521] smpboot: Total of 12 processors activated (83810.23 BogoMIP=
S)
[   14.144475] devtmpfs: initialized
[   14.144475] random: get_random_bytes called from setup_net+0x52/0x260 w=
ith crng_init=3D0
[   14.144475] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffff=
ff, max_idle_ns: 7645041785100000 ns
[   14.144475] futex hash table entries: 4096 (order: 6, 262144 bytes, lin=
ear)
...


The machine is a hardened Gentoo Linux:

Linux mr-fox 5.4.15 #6 SMP Sun Jan 26 10:07:17 CET 2020 x86_64 Intel(R) Xe=
on(R) CPU E5-1650 v3 @ 3.50GHz GenuineIntel GNU/Linux

=2D-
Toralf

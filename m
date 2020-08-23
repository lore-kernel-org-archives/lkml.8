Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DE6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 13:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021A52078A
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgHWNUg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 09:20:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57641 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgHWNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 09:20:32 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1k9puK-0005Uj-W1
        for linux-kernel@vger.kernel.org; Sun, 23 Aug 2020 13:19:37 +0000
Received: by mail-pg1-f197.google.com with SMTP id m16so262720pgl.16
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 06:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R1ZG5YY8uQEL9hYOz/LO4Erd48a4lR+8I89JQ2wJGU4=;
        b=YBd5D47T2+X3wIu+Nw6h7lKW7TQsIXnB/wOBZFbvUpoqlN23/xObBPYPSYbCzwvDE1
         b3bwPyL1lr7XQ/ta4ftKz8hpq5DOA9nqIcxg5SoFDjo/hvkcIvgSg+80oTUNVMlIL4V1
         vnU0CcE1gfYivJaV1TEc7VWjnwFbC8ESaUfKdJeRfN6U68A+IGAc1IieMxazEPiQDD4T
         U26JhXcEViELhtuHOn4NFOsIoUkIgXGLq6GP1wQ2/w4SBxwOuASHjozkiF42XUqA7LUc
         ZMVfgWSB7hmlk1z1Z/eTIF5NTx+mKrm2rcXu6zZk1pxFDkX8XZeQ1XVgWLeLgmU0CxoO
         fUcA==
X-Gm-Message-State: AOAM531y9LaeY2D38ap8krDih9qSKuKmZ9AMsMWLLCRRYv9zw5UfE6hU
        fin8HRHr7wSLbZr5eeT0vlYCHdLgURRYEoB5jPijiZvjU1tqcrkKGZxDa2T+vc6f4JqDce5pe4J
        rX204sEkYJrdWpS6qMx1Dj7hfg13gVz7AlTHDf7lxJA==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr1083150pje.37.1598188772760;
        Sun, 23 Aug 2020 06:19:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYtXuhIrjVeSuWNZyWXe81mHCTUm941QXKF3e0y7sX1YwkYlV6psYh/U3FkU2gBQOTI0xJAQ==
X-Received: by 2002:a17:90a:307:: with SMTP id 7mr1083075pje.37.1598188770823;
        Sun, 23 Aug 2020 06:19:30 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id t20sm7634333pgj.27.2020.08.23.06.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2020 06:19:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200821144327.GN3354@suse.de>
Date:   Sun, 23 Aug 2020 21:19:26 +0800
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A63C3DEA-10A8-4727-A270-80A7855D8528@canonical.com>
References: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
 <20200518133209.GM8135@suse.de>
 <381D21C9-C913-4C33-A6F4-0440B5D11670@canonical.com>
 <8D375E06-A763-4B5E-9C6D-DA5EBC62530E@canonical.com>
 <CFC22DE4-E342-4F32-B758-6A690755C498@canonical.com>
 <20200821134300.GM3354@suse.de>
 <5D7A63DF-D360-4453-845C-924F4C13E3DB@canonical.com>
 <20200821144327.GN3354@suse.de>
To:     Joerg Roedel <jroedel@suse.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 21, 2020, at 22:43, Joerg Roedel <jroedel@suse.de> wrote:
> 
> On Fri, Aug 21, 2020 at 09:50:33PM +0800, Kai-Heng Feng wrote:
>> Of course, I still have the system at my side.
>> 
>> The offending commit is 92d420ec028d ("iommu/amd: Relax locking in
>> dma_ops path"), however be62dbf554c5 ("iommu/amd: Convert AMD iommu
>> driver to the dma-iommu api") removed .map_page entirely so I don't
>> know where to start.
> 
> I guess you don't see any AMD-Vi page-faults reported in dmesg, right?

Yes, nothing gets logged when the issue happens.

> That makes things more difficult. As a first step, can you please send
> me a complete dmesg after this happened? Also please boot with
> amd_iommu_dump on the kernel command line.

[    0.000000] Linux version 5.9.0-050900rc1-generic (kernel@kathleen) (gcc (Ubuntu 10.2.0-5ubuntu2) 10.2.0, GNU ld (GNU Binutils for Ubuntu) 2.35) #202008162130 SMP Sun Aug 16 21:35:23 UTC 2020
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-050900rc1-generic root=UUID=0b6ddf07-47e4-45b8-951d-5de4a1de6b96 ro amd_iommu_dump quiet splash vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000087fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000088000-0x0000000000088fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000089000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000bffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009b00000-0x0000000009c7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000009c80000-0x0000000009efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f09fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f0a000-0x000000006d560fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006d561000-0x000000006e7befff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006e7bf000-0x000000006efbefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006efbf000-0x000000006effefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000006efff000-0x000000006effffff] usable
[    0.000000] BIOS-e820: [mem 0x000000006f000000-0x00000000afffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000044f33ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x60927018-0x60936057] usable ==> usable
[    0.000000] e820: update [mem 0x60927018-0x60936057] usable ==> usable
[    0.000000] e820: update [mem 0x60919018-0x60926457] usable ==> usable
[    0.000000] e820: update [mem 0x60919018-0x60926457] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000087fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000088000-0x0000000000088fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000089000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x00000000000bffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009afffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009b00000-0x0000000009c7ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000009c80000-0x0000000009efffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f09fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000009f0a000-0x0000000060919017] usable
[    0.000000] reserve setup_data: [mem 0x0000000060919018-0x0000000060926457] usable
[    0.000000] reserve setup_data: [mem 0x0000000060926458-0x0000000060927017] usable
[    0.000000] reserve setup_data: [mem 0x0000000060927018-0x0000000060936057] usable
[    0.000000] reserve setup_data: [mem 0x0000000060936058-0x000000006d560fff] usable
[    0.000000] reserve setup_data: [mem 0x000000006d561000-0x000000006e7befff] reserved
[    0.000000] reserve setup_data: [mem 0x000000006e7bf000-0x000000006efbefff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000006efbf000-0x000000006effefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000006efff000-0x000000006effffff] usable
[    0.000000] reserve setup_data: [mem 0x000000006f000000-0x00000000afffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000044f33ffff] usable
[    0.000000] efi: EFI v2.50 by EDK II
[    0.000000] efi: TPMFinalLog=0x6efa1000 SMBIOS=0x6d957000 SMBIOS 3.0=0x6d955000 ACPI 2.0=0x6effe014 ESRT=0x6d93f298 MEMATTR=0x6b263018 TPMEventLog=0x60937018 
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Dell Inc. Latitude 5495/, BIOS 1.2.14 05/29/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1996.367 MHz processor
[    0.001251] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001252] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001257] last_pfn = 0x44f340 max_arch_pfn = 0x400000000
[    0.001262] MTRR default type: uncachable
[    0.001263] MTRR fixed ranges enabled:
[    0.001264]   00000-9FFFF write-back
[    0.001264]   A0000-BFFFF uncachable
[    0.001265]   C0000-DFFFF write-through
[    0.001265]   E0000-FFFFF uncachable
[    0.001266] MTRR variable ranges enabled:
[    0.001267]   0 base 000000000000 mask FFFF80000000 write-back
[    0.001268]   1 base 000080000000 mask FFFFE0000000 write-back
[    0.001269]   2 base 0000A0000000 mask FFFFF0000000 write-back
[    0.001269]   3 base 0000FF000000 mask FFFFFF000000 write-protect
[    0.001270]   4 disabled
[    0.001270]   5 disabled
[    0.001270]   6 disabled
[    0.001271]   7 disabled
[    0.001271] TOM2: 0000000450000000 aka 17664M
[    0.001559] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.001656] last_pfn = 0x6f000 max_arch_pfn = 0x400000000
[    0.006138] esrt: Reserving ESRT space from 0x000000006d93f298 to 0x000000006d93f2d0.
[    0.006149] check: Scanning 1 areas for low memory corruption
[    0.006160] Using GB pages for direct mapping
[    0.006740] Secure boot disabled
[    0.006741] RAMDISK: [mem 0x2f7ad000-0x32907fff]
[    0.006754] ACPI: Early table checksum verification disabled
[    0.006758] ACPI: RSDP 0x000000006EFFE014 000024 (v02 DELL  )
[    0.006761] ACPI: XSDT 0x000000006EFCC188 000114 (v01 DELL   CBX3     00000001      01000013)
[    0.006766] ACPI: FACP 0x000000006EFF3000 00010C (v05 DELL   CBX3     00000001 ACPI 00040000)
[    0.006770] ACPI: DSDT 0x000000006EFE3000 009277 (v01 DELL   CBX3     00040000 ACPI 00040000)
[    0.006773] ACPI: FACS 0x000000006EB96000 000040
[    0.006775] ACPI: SSDT 0x000000006EFF8000 005367 (v02 DELL   CBX3     00000002 ACPI 00040000)
[    0.006777] ACPI: UEFI 0x000000006EFF7000 000042 (v01 DELL   CBX3     00000002 ACPI 00040000)
[    0.006779] ACPI: SSDT 0x000000006EFF6000 0003C6 (v02 DELL   CBX3     00001000 ACPI 00040000)
[    0.006781] ACPI: TPM2 0x000000006EFF5000 000034 (v03 DELL   CBX3     00000002 ACPI 00040000)
[    0.006783] ACPI: ASF! 0x000000006EFF4000 0000A5 (v32 DELL   CBX3     00000001 ACPI 00040000)
[    0.006786] ACPI: HPET 0x000000006EFF2000 000038 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006788] ACPI: APIC 0x000000006EFF1000 00012C (v03 DELL   CBX3     00000001 ACPI 00040000)
[    0.006790] ACPI: MCFG 0x000000006EFF0000 00003C (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006792] ACPI: SPCR 0x000000006EFEF000 000050 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006794] ACPI: WDAT 0x000000006EFEE000 00017C (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006796] ACPI: WDRT 0x000000006EFED000 000047 (v01 DELL   CBX3     00000000 ACPI 00040000)
[    0.006798] ACPI: SSDT 0x000000006EFE1000 00119C (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006800] ACPI: CRAT 0x000000006EFE0000 000810 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006802] ACPI: CDIT 0x000000006EFDF000 000029 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006804] ACPI: BOOT 0x000000006EFDE000 000028 (v01 DELL   CBX3     00000002 ACPI 00040000)
[    0.006806] ACPI: VFCT 0x000000006EFD0000 00D484 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006808] ACPI: IVRS 0x000000006EFCF000 0000D0 (v02 DELL   CBX3     00000001 ACPI 00040000)
[    0.006810] ACPI: SSDT 0x000000006EFCE000 000464 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006812] ACPI: SSDT 0x000000006EFCD000 0008B6 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006814] ACPI: SSDT 0x000000006EFCA000 001280 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006816] ACPI: SSDT 0x000000006EFC9000 000B56 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006818] ACPI: SSDT 0x000000006EFC8000 000E44 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006820] ACPI: SSDT 0x000000006EFC7000 000AA4 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006822] ACPI: SSDT 0x000000006EFC6000 000B56 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006824] ACPI: SSDT 0x000000006EFC5000 000329 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006826] ACPI: SSDT 0x000000006EFC3000 001AE5 (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006828] ACPI: FPDT 0x000000006EFC2000 000044 (v01 DELL   CBX3     00000002 ACPI 00040000)
[    0.006830] ACPI: BGRT 0x000000006EFC1000 000038 (v01 DELL   CBX3     00000002 ACPI 00040000)
[    0.006832] ACPI: SSDT 0x000000006EFBF000 0010EF (v01 DELL   CBX3     00000001 ACPI 00040000)
[    0.006840] ACPI: Local APIC address 0xfee00000
[    0.006947] No NUMA configuration found
[    0.006947] Faking a node at [mem 0x0000000000000000-0x000000044f33ffff]
[    0.006956] NODE_DATA(0) allocated [mem 0x44f316000-0x44f33ffff]
[    0.007222] Zone ranges:
[    0.007223]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.007224]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.007225]   Normal   [mem 0x0000000100000000-0x000000044f33ffff]
[    0.007225]   Device   empty
[    0.007226] Movable zone start for each node
[    0.007228] Early memory node ranges
[    0.007229]   node   0: [mem 0x0000000000001000-0x0000000000087fff]
[    0.007230]   node   0: [mem 0x0000000000089000-0x000000000009efff]
[    0.007230]   node   0: [mem 0x0000000000100000-0x0000000009afffff]
[    0.007231]   node   0: [mem 0x0000000009c80000-0x0000000009efffff]
[    0.007231]   node   0: [mem 0x0000000009f0a000-0x000000006d560fff]
[    0.007232]   node   0: [mem 0x000000006efff000-0x000000006effffff]
[    0.007232]   node   0: [mem 0x0000000100000000-0x000000044f33ffff]
[    0.007343] Zeroed struct page in unavailable ranges: 14667 pages
[    0.007344] Initmem setup node 0 [mem 0x0000000000001000-0x000000044f33ffff]
[    0.007345] On node 0 totalpages: 3917493
[    0.007346]   DMA zone: 64 pages used for memmap
[    0.007346]   DMA zone: 21 pages reserved
[    0.007347]   DMA zone: 3997 pages, LIFO batch:0
[    0.007364]   DMA32 zone: 6928 pages used for memmap
[    0.007365]   DMA32 zone: 443352 pages, LIFO batch:63
[    0.010953]   Normal zone: 54221 pages used for memmap
[    0.010955]   Normal zone: 3470144 pages, LIFO batch:63
[    0.041283] ACPI: PM-Timer IO Port: 0x408
[    0.041285] ACPI: Local APIC address 0xfee00000
[    0.041292] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.041293] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.041293] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.041293] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.041294] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.041294] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.041295] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.041295] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.041295] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.041296] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.041296] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.041297] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.041297] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.041297] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.041298] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.041298] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.041319] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.041321] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.041322] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.041323] ACPI: IRQ0 used by override.
[    0.041324] ACPI: IRQ9 used by override.
[    0.041325] Using ACPI (MADT) for SMP configuration information
[    0.041326] ACPI: HPET id: 0x10228210 base: 0xfed00000
[    0.041335] e820: update [mem 0x6b2a5000-0x6b326fff] usable ==> reserved
[    0.041343] ACPI: SPCR: SPCR table version 1
[    0.041344] ACPI: SPCR: console: uart,io,0x3f8,115200
[    0.041346] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
[    0.041365] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.041367] PM: hibernation: Registered nosave memory: [mem 0x00088000-0x00088fff]
[    0.041368] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x000bffff]
[    0.041368] PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
[    0.041369] PM: hibernation: Registered nosave memory: [mem 0x09b00000-0x09c7ffff]
[    0.041370] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f09fff]
[    0.041372] PM: hibernation: Registered nosave memory: [mem 0x60919000-0x60919fff]
[    0.041373] PM: hibernation: Registered nosave memory: [mem 0x60926000-0x60926fff]
[    0.041373] PM: hibernation: Registered nosave memory: [mem 0x60927000-0x60927fff]
[    0.041374] PM: hibernation: Registered nosave memory: [mem 0x60936000-0x60936fff]
[    0.041376] PM: hibernation: Registered nosave memory: [mem 0x6b2a5000-0x6b326fff]
[    0.041377] PM: hibernation: Registered nosave memory: [mem 0x6d561000-0x6e7befff]
[    0.041377] PM: hibernation: Registered nosave memory: [mem 0x6e7bf000-0x6efbefff]
[    0.041378] PM: hibernation: Registered nosave memory: [mem 0x6efbf000-0x6effefff]
[    0.041379] PM: hibernation: Registered nosave memory: [mem 0x6f000000-0xafffffff]
[    0.041379] PM: hibernation: Registered nosave memory: [mem 0xb0000000-0xf7ffffff]
[    0.041380] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.041380] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.041381] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.041381] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
[    0.041381] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.041382] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfed7ffff]
[    0.041382] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
[    0.041383] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xfeffffff]
[    0.041383] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.041385] [mem 0xb0000000-0xf7ffffff] available for PCI devices
[    0.041386] Booting paravirtualized kernel on bare hardware
[    0.041388] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.041395] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.042180] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[    0.042188] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
[    0.042189] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.042217] Built 1 zonelists, mobility grouping on.  Total pages: 3856259
[    0.042218] Policy zone: Normal
[    0.042219] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-050900rc1-generic root=UUID=0b6ddf07-47e4-45b8-951d-5de4a1de6b96 ro amd_iommu_dump quiet splash vt.handoff=7
[    0.044118] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.045039] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.045087] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.080862] Memory: 15144124K/15669972K available (14339K kernel code, 2585K rwdata, 8688K rodata, 2640K init, 4868K bss, 525588K reserved, 0K cma-reserved)
[    0.080870] random: get_random_u64 called from kmem_cache_open+0x29/0x220 with crng_init=0
[    0.081122] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.081159] ftrace: allocating 49125 entries in 192 pages
[    0.096083] ftrace: allocated 192 pages with 2 groups
[    0.096229] rcu: Hierarchical RCU implementation.
[    0.096230] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.096231] 	Trampoline variant of Tasks RCU enabled.
[    0.096231] 	Rude variant of Tasks RCU enabled.
[    0.096231] 	Tracing variant of Tasks RCU enabled.
[    0.096232] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.096232] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.098754] NR_IRQS: 524544, nr_irqs: 552, preallocated irqs: 16
[    0.100574] random: crng done (trusting CPU's manufacturer)
[    0.100613] Console: colour dummy device 80x25
[    0.100616] printk: console [tty0] enabled
[    0.100659] ACPI: Core revision 20200717
[    0.100878] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.100908] APIC: Switch to symmetric I/O mode setup
[    0.100910] AMD-Vi: AMD-Vi: Using IVHD type 0x11
[    0.101240] AMD-Vi: AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b0 info 0000
[    0.101241] AMD-Vi: AMD-Vi:        mmio-addr: 00000000fd900000
[    0.101249] AMD-Vi: AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:01.0 flags: 00
[    0.101250] AMD-Vi: AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.6
[    0.101780] AMD-Vi: AMD-Vi:   DEV_ALIAS_RANGE		 devid: ff:00.0 flags: 00 devid_to: 00:14.4
[    0.101781] AMD-Vi: AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.7
[    0.101785] AMD-Vi: AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
[    0.101786] AMD-Vi: AMD-Vi:   DEV_SPECIAL(IOAPIC[32])		devid: 00:14.0
[    0.101786] AMD-Vi: AMD-Vi:   DEV_SPECIAL(IOAPIC[33])		devid: 00:00.1
[    0.420985] Switched APIC routing to physical flat.
[    0.421856] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.440891] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x398d8c39504, max_idle_ns: 881590433985 ns
[    0.440898] Calibrating delay loop (skipped), value calculated using timer frequency.. 3992.73 BogoMIPS (lpj=7985468)
[    0.440900] pid_max: default: 32768 minimum: 301
[    0.443503] LSM: Security Framework initializing
[    0.443515] Yama: becoming mindful.
[    0.443538] AppArmor: AppArmor initialized
[    0.443612] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.443645] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.444145] LVT offset 1 assigned for vector 0xf9
[    0.444192] LVT offset 2 assigned for vector 0xf4
[    0.444206] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.444206] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.444210] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.444211] Spectre V2 : Mitigation: Full AMD retpoline
[    0.444211] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.444213] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.444214] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.444455] Freeing SMP alternatives memory: 40K
[    0.554980] smpboot: CPU0: AMD Ryzen 5 2500U with Radeon Vega Graphics (family: 0x17, model: 0x11, stepping: 0x0)
[    0.555346] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.555352] ... version:                0
[    0.555352] ... bit width:              48
[    0.555353] ... generic registers:      6
[    0.555353] ... value mask:             0000ffffffffffff
[    0.555354] ... max period:             00007fffffffffff
[    0.555354] ... fixed-purpose events:   0
[    0.555354] ... event mask:             000000000000003f
[    0.555391] rcu: Hierarchical SRCU implementation.
[    0.555796] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.555965] smp: Bringing up secondary CPUs ...
[    0.556088] x86: Booting SMP configuration:
[    0.556088] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.571355] smp: Brought up 1 node, 8 CPUs
[    0.571355] smpboot: Max logical packages: 2
[    0.571355] smpboot: Total of 8 processors activated (31941.87 BogoMIPS)
[    0.573350] devtmpfs: initialized
[    0.573350] x86/mm: Memory block size: 128MB
[    0.573839] PM: Registering ACPI NVS region [mem 0x09f00000-0x09f09fff] (40960 bytes)
[    0.573839] PM: Registering ACPI NVS region [mem 0x6e7bf000-0x6efbefff] (8388608 bytes)
[    0.573839] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.573839] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.573839] pinctrl core: initialized pinctrl subsystem
[    0.573839] PM: RTC time: 13:08:01, date: 2020-08-23
[    0.573839] NET: Registered protocol family 16
[    0.574080] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.574304] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.574530] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.574547] audit: initializing netlink subsys (disabled)
[    0.574566] audit: type=2000 audit(1598188081.156:1): state=initialized audit_enabled=0 res=1
[    0.574566] thermal_sys: Registered thermal governor 'fair_share'
[    0.574566] thermal_sys: Registered thermal governor 'bang_bang'
[    0.574566] thermal_sys: Registered thermal governor 'step_wise'
[    0.574566] thermal_sys: Registered thermal governor 'user_space'
[    0.574566] thermal_sys: Registered thermal governor 'power_allocator'
[    0.574566] EISA bus registered
[    0.576903] cpuidle: using governor ladder
[    0.576906] cpuidle: using governor menu
[    0.576947] Simple Boot Flag at 0x44 set to 0x80
[    0.577013] ACPI: bus type PCI registered
[    0.577014] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.577102] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.577106] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.577114] PCI: Using configuration type 1 for base access
[    0.578686] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.578686] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.580999] ACPI: Added _OSI(Module Device)
[    0.580999] ACPI: Added _OSI(Processor Device)
[    0.581000] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.581000] ACPI: Added _OSI(Processor Aggregator Device)
[    0.581001] ACPI: Added _OSI(Linux-Dell-Video)
[    0.581002] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.581002] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.582398] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.592349] ACPI BIOS Error (bug): Failure creating named object [\_SB.MACO], AE_ALREADY_EXISTS (20200717/dswload2-326)
[    0.592360] fbcon: Taking over console
[    0.592365] ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20200717/psobject-220)
[    0.593377] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.597843] ACPI: EC: EC started
[    0.597844] ACPI: EC: interrupt blocked
[    0.608266] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.608268] ACPI: \_SB_.PCI0.LPC0.ECDV: Boot DSDT EC used to handle transactions
[    0.608269] ACPI: Interpreter enabled
[    0.608285] ACPI: (supports S0 S3 S4 S5)
[    0.608285] ACPI: Using IOAPIC for interrupt routing
[    0.608451] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.609088] ACPI: Enabled 4 GPEs in block 00 to 1F
[    0.609599] ACPI: Power Resource [M237] (on)
[    0.611777] ACPI: Power Resource [P0ST] (on)
[    0.611804] ACPI: Power Resource [P3ST] (on)
[    0.621153] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.621158] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.621326] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
[    0.621484] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.621496] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.621718] PCI host bridge to bus 0000:00
[    0.621720] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.621721] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.621722] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.621723] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    0.621724] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.621724] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    0.621725] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    0.621726] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.621726] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.621727] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.621728] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.621728] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.621729] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.621730] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    0.621730] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    0.621731] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xf7ffffff window]
[    0.621732] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfeafffff window]
[    0.621733] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.621748] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
[    0.621872] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
[    0.622024] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.622134] pci 0000:00:01.1: [1022:15d3] type 01 class 0x060400
[    0.622266] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.622398] pci 0000:00:01.2: [1022:15d3] type 01 class 0x060400
[    0.622526] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
[    0.622657] pci 0000:00:01.3: [1022:15d3] type 01 class 0x060400
[    0.622769] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.622900] pci 0000:00:01.4: [1022:15d3] type 01 class 0x060400
[    0.623009] pci 0000:00:01.4: PME# supported from D0 D3hot D3cold
[    0.623164] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.623271] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
[    0.623321] pci 0000:00:08.1: enabling Extended Tags
[    0.623379] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.623481] pci 0000:00:08.2: [1022:15dc] type 01 class 0x060400
[    0.623532] pci 0000:00:08.2: enabling Extended Tags
[    0.623588] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
[    0.623725] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.623877] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.624057] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
[    0.624117] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
[    0.624162] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
[    0.624206] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
[    0.624251] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
[    0.624296] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
[    0.624343] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
[    0.624388] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
[    0.624533] pci 0000:01:00.0: [1002:699f] type 00 class 0x030000
[    0.624559] pci 0000:01:00.0: reg 0x10: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.624576] pci 0000:01:00.0: reg 0x18: [mem 0xe0000000-0xe01fffff 64bit pref]
[    0.624587] pci 0000:01:00.0: reg 0x20: [io  0x2000-0x20ff]
[    0.624598] pci 0000:01:00.0: reg 0x24: [mem 0xe0d00000-0xe0d3ffff]
[    0.624609] pci 0000:01:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    0.624697] pci 0000:01:00.0: supports D1 D2
[    0.624754] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:01.1 (capable of 63.008 Gb/s with 8.0 GT/s PCIe x8 link)
[    0.624840] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.624845] pci 0000:00:01.1:   bridge window [io  0x2000-0x2fff]
[    0.624848] pci 0000:00:01.1:   bridge window [mem 0xe0d00000-0xe0dfffff]
[    0.624852] pci 0000:00:01.1:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    0.624941] pci 0000:02:00.0: [168c:003e] type 00 class 0x028000
[    0.624965] pci 0000:02:00.0: reg 0x10: [mem 0xe0400000-0xe05fffff 64bit]
[    0.625098] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.625297] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.625304] pci 0000:00:01.2:   bridge window [mem 0xe0400000-0xe05fffff]
[    0.625377] pci 0000:03:00.0: [14e4:1687] type 00 class 0x020000
[    0.625403] pci 0000:03:00.0: reg 0x10: [mem 0xe0220000-0xe022ffff 64bit pref]
[    0.625420] pci 0000:03:00.0: reg 0x18: [mem 0xe0210000-0xe021ffff 64bit pref]
[    0.625437] pci 0000:03:00.0: reg 0x20: [mem 0xe0200000-0xe020ffff 64bit pref]
[    0.625560] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.625718] pci 0000:00:01.3: PCI bridge to [bus 03]
[    0.625729] pci 0000:00:01.3:   bridge window [mem 0xe0200000-0xe02fffff 64bit pref]
[    0.626066] pci 0000:04:00.0: [10ec:525a] type 00 class 0xff0000
[    0.626089] pci 0000:04:00.0: reg 0x14: [mem 0xe0c00000-0xe0c00fff]
[    0.626200] pci 0000:04:00.0: supports D1 D2
[    0.626200] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.626594] pci 0000:00:01.4: PCI bridge to [bus 04]
[    0.626601] pci 0000:00:01.4:   bridge window [mem 0xe0c00000-0xe0cfffff]
[    0.626716] pci 0000:05:00.0: [1002:15dd] type 00 class 0x030000
[    0.626743] pci 0000:05:00.0: reg 0x10: [mem 0xb0000000-0xbfffffff 64bit pref]
[    0.626761] pci 0000:05:00.0: reg 0x18: [mem 0xc0000000-0xc01fffff 64bit pref]
[    0.626772] pci 0000:05:00.0: reg 0x20: [io  0x1000-0x10ff]
[    0.626784] pci 0000:05:00.0: reg 0x24: [mem 0xe0b00000-0xe0b7ffff]
[    0.626803] pci 0000:05:00.0: enabling Extended Tags
[    0.626818] pci 0000:05:00.0: BAR 0: assigned to efifb
[    0.626916] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.627070] pci 0000:05:00.1: [1002:15de] type 00 class 0x040300
[    0.627087] pci 0000:05:00.1: reg 0x10: [mem 0xe0b88000-0xe0b8bfff]
[    0.627140] pci 0000:05:00.1: enabling Extended Tags
[    0.627210] pci 0000:05:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.627294] pci 0000:05:00.2: [1022:15df] type 00 class 0x108000
[    0.627326] pci 0000:05:00.2: reg 0x18: [mem 0xe0a00000-0xe0afffff]
[    0.627348] pci 0000:05:00.2: reg 0x24: [mem 0xe0b8e000-0xe0b8ffff]
[    0.627365] pci 0000:05:00.2: enabling Extended Tags
[    0.627522] pci 0000:05:00.3: [1022:15e0] type 00 class 0x0c0330
[    0.627548] pci 0000:05:00.3: reg 0x10: [mem 0xe0900000-0xe09fffff 64bit]
[    0.627608] pci 0000:05:00.3: enabling Extended Tags
[    0.627685] pci 0000:05:00.3: PME# supported from D0 D3hot D3cold
[    0.627771] pci 0000:05:00.4: [1022:15e1] type 00 class 0x0c0330
[    0.627797] pci 0000:05:00.4: reg 0x10: [mem 0xe0800000-0xe08fffff 64bit]
[    0.627857] pci 0000:05:00.4: enabling Extended Tags
[    0.627934] pci 0000:05:00.4: PME# supported from D0 D3hot D3cold
[    0.628034] pci 0000:05:00.6: [1022:15e3] type 00 class 0x040300
[    0.628051] pci 0000:05:00.6: reg 0x10: [mem 0xe0b80000-0xe0b87fff]
[    0.628104] pci 0000:05:00.6: enabling Extended Tags
[    0.628174] pci 0000:05:00.6: PME# supported from D0 D3hot D3cold
[    0.628257] pci 0000:05:00.7: [1022:15e6] type 00 class 0x000000
[    0.628289] pci 0000:05:00.7: reg 0x18: [mem 0xe0700000-0xe07fffff]
[    0.628312] pci 0000:05:00.7: reg 0x24: [mem 0xe0b8c000-0xe0b8dfff]
[    0.628328] pci 0000:05:00.7: enabling Extended Tags
[    0.628553] pci 0000:00:08.1: PCI bridge to [bus 05]
[    0.628558] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.628561] pci 0000:00:08.1:   bridge window [mem 0xe0700000-0xe0bfffff]
[    0.628567] pci 0000:00:08.1:   bridge window [mem 0xb0000000-0xc01fffff 64bit pref]
[    0.628646] pci 0000:06:00.0: [1022:7901] type 00 class 0x010601
[    0.628718] pci 0000:06:00.0: reg 0x24: [mem 0xe0600000-0xe06007ff]
[    0.628737] pci 0000:06:00.0: enabling Extended Tags
[    0.628816] pci 0000:06:00.0: PME# supported from D3hot D3cold
[    0.628932] pci 0000:00:08.2: PCI bridge to [bus 06]
[    0.628940] pci 0000:00:08.2:   bridge window [mem 0xe0600000-0xe06fffff]
[    0.629479] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629564] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629628] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629710] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629785] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629845] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629904] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 6 10 11) *0, disabled.
[    0.629963] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 6 10 11) *0, disabled.
[    0.631432] ACPI: EC: interrupt unblocked
[    0.631433] ACPI: EC: event unblocked
[    0.631443] ACPI: EC: EC_CMD/EC_SC=0x934, EC_DATA=0x930
[    0.631444] ACPI: EC: GPE=0x3
[    0.631445] ACPI: \_SB_.PCI0.LPC0.ECDV: Boot DSDT EC initialization complete
[    0.631446] ACPI: \_SB_.PCI0.LPC0.ECDV: EC: Used to handle transactions and events
[    0.631512] iommu: Default domain type: Translated 
[    0.631512] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.631512] pci 0000:05:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.631512] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.631512] pci 0000:05:00.0: vgaarb: bridge control possible
[    0.631512] pci 0000:05:00.0: vgaarb: setting as boot device
[    0.631512] vgaarb: loaded
[    0.631512] SCSI subsystem initialized
[    0.631512] libata version 3.00 loaded.
[    0.631512] ACPI: bus type USB registered
[    0.631512] usbcore: registered new interface driver usbfs
[    0.631512] usbcore: registered new interface driver hub
[    0.631512] usbcore: registered new device driver usb
[    0.631512] pps_core: LinuxPPS API ver. 1 registered
[    0.631512] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.631512] PTP clock support registered
[    0.631512] EDAC MC: Ver: 3.0.0
[    0.633084] Registered efivars operations
[    0.633101] NetLabel: Initializing
[    0.633101] NetLabel:  domain hash size = 128
[    0.633101] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.633122] NetLabel:  unlabeled traffic allowed by default
[    0.633638] PCI: Using ACPI for IRQ routing
[    0.638228] PCI: pci_cache_line_size set to 64 bytes
[    0.638228] e820: reserve RAM buffer [mem 0x00088000-0x0008ffff]
[    0.638228] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.638228] e820: reserve RAM buffer [mem 0x09b00000-0x0bffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x60919018-0x63ffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x60927018-0x63ffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x6b2a5000-0x6bffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x6d561000-0x6fffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x6f000000-0x6fffffff]
[    0.638228] e820: reserve RAM buffer [mem 0x44f340000-0x44fffffff]
[    0.638228] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.638228] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.641041] clocksource: Switched to clocksource tsc-early
[    0.656390] VFS: Disk quotas dquot_6.6.0
[    0.656409] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.656535] AppArmor: AppArmor Filesystem Enabled
[    0.656573] pnp: PnP ACPI init
[    0.656796] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.656798] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.656799] system 00:00: [mem 0xfda00000-0xfdafffff] has been reserved
[    0.656804] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.657009] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.657045] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.657070] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.657109] system 00:04: [io  0x0400-0x04cf] has been reserved
[    0.657110] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.657111] system 00:04: [io  0x04d6] has been reserved
[    0.657112] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.657113] system 00:04: [io  0x0c14] has been reserved
[    0.657114] system 00:04: [io  0x0c50-0x0c52] has been reserved
[    0.657115] system 00:04: [io  0x0c6c] has been reserved
[    0.657116] system 00:04: [io  0x0c6f] has been reserved
[    0.657117] system 00:04: [io  0x0cd0-0x0cdb] has been reserved
[    0.657120] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.657196] system 00:05: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.657197] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.657201] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.659331] pnp: PnP ACPI: found 6 devices
[    0.666792] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.666877] NET: Registered protocol family 2
[    0.667074] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.667186] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.667415] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.667510] TCP: Hash tables configured (established 131072 bind 65536)
[    0.667596] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
[    0.667650] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.667705] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.667807] NET: Registered protocol family 1
[    0.667812] NET: Registered protocol family 44
[    0.667819] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    0.667831] pci 0000:00:01.2: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.667834] pci 0000:00:01.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.667854] pci 0000:00:01.2: BAR 15: assigned [mem 0xc0200000-0xc03fffff 64bit pref]
[    0.667858] pci 0000:00:01.2: BAR 13: assigned [io  0x3000-0x3fff]
[    0.667862] pci 0000:01:00.0: BAR 6: assigned [mem 0xe0d40000-0xe0d5ffff pref]
[    0.667864] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.667867] pci 0000:00:01.1:   bridge window [io  0x2000-0x2fff]
[    0.667873] pci 0000:00:01.1:   bridge window [mem 0xe0d00000-0xe0dfffff]
[    0.667877] pci 0000:00:01.1:   bridge window [mem 0xd0000000-0xe01fffff 64bit pref]
[    0.667884] pci 0000:00:01.2: PCI bridge to [bus 02]
[    0.667886] pci 0000:00:01.2:   bridge window [io  0x3000-0x3fff]
[    0.667891] pci 0000:00:01.2:   bridge window [mem 0xe0400000-0xe05fffff]
[    0.667895] pci 0000:00:01.2:   bridge window [mem 0xc0200000-0xc03fffff 64bit pref]
[    0.667902] pci 0000:00:01.3: PCI bridge to [bus 03]
[    0.667910] pci 0000:00:01.3:   bridge window [mem 0xe0200000-0xe02fffff 64bit pref]
[    0.667917] pci 0000:00:01.4: PCI bridge to [bus 04]
[    0.667922] pci 0000:00:01.4:   bridge window [mem 0xe0c00000-0xe0cfffff]
[    0.667933] pci 0000:00:08.1: PCI bridge to [bus 05]
[    0.667936] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.667941] pci 0000:00:08.1:   bridge window [mem 0xe0700000-0xe0bfffff]
[    0.667944] pci 0000:00:08.1:   bridge window [mem 0xb0000000-0xc01fffff 64bit pref]
[    0.667951] pci 0000:00:08.2: PCI bridge to [bus 06]
[    0.667956] pci 0000:00:08.2:   bridge window [mem 0xe0600000-0xe06fffff]
[    0.667967] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.667969] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.667970] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.667971] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    0.667972] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    0.667974] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    0.667975] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    0.667976] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    0.667977] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    0.667978] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    0.667979] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    0.667980] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    0.667981] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    0.667982] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    0.667983] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    0.667984] pci_bus 0000:00: resource 19 [mem 0xb0000000-0xf7ffffff window]
[    0.667985] pci_bus 0000:00: resource 20 [mem 0xfc000000-0xfeafffff window]
[    0.667987] pci_bus 0000:01: resource 0 [io  0x2000-0x2fff]
[    0.667988] pci_bus 0000:01: resource 1 [mem 0xe0d00000-0xe0dfffff]
[    0.667988] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xe01fffff 64bit pref]
[    0.667990] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.667991] pci_bus 0000:02: resource 1 [mem 0xe0400000-0xe05fffff]
[    0.667991] pci_bus 0000:02: resource 2 [mem 0xc0200000-0xc03fffff 64bit pref]
[    0.667993] pci_bus 0000:03: resource 2 [mem 0xe0200000-0xe02fffff 64bit pref]
[    0.667994] pci_bus 0000:04: resource 1 [mem 0xe0c00000-0xe0cfffff]
[    0.667995] pci_bus 0000:05: resource 0 [io  0x1000-0x1fff]
[    0.667996] pci_bus 0000:05: resource 1 [mem 0xe0700000-0xe0bfffff]
[    0.667997] pci_bus 0000:05: resource 2 [mem 0xb0000000-0xc01fffff 64bit pref]
[    0.667998] pci_bus 0000:06: resource 1 [mem 0xe0600000-0xe06fffff]
[    0.668440] pci 0000:05:00.1: D0 power state depends on 0000:05:00.0
[    0.668456] pci 0000:05:00.3: extending delay after power-on from D3hot to 20 msec
[    0.668786] pci 0000:05:00.4: extending delay after power-on from D3hot to 20 msec
[    0.668928] PCI: CLS 0 bytes, default 64
[    0.668982] Trying to unpack rootfs image as initramfs...
[    0.774490] Initramfs unpacking failed: Decoding failed
[    0.781932] Freeing initrd memory: 50540K
[    0.782015] pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
[    0.782127] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.782127] pci 0000:00:00.2: PCI INT A: not connected
[    0.782166] pci 0000:00:01.0: Adding to iommu group 0
[    0.782177] pci 0000:00:01.1: Adding to iommu group 1
[    0.782190] pci 0000:00:01.2: Adding to iommu group 2
[    0.782201] pci 0000:00:01.3: Adding to iommu group 3
[    0.782211] pci 0000:00:01.4: Adding to iommu group 4
[    0.782232] pci 0000:00:08.0: Adding to iommu group 5
[    0.782240] pci 0000:00:08.1: Adding to iommu group 5
[    0.782248] pci 0000:00:08.2: Adding to iommu group 5
[    0.782263] pci 0000:00:14.0: Adding to iommu group 6
[    0.782271] pci 0000:00:14.3: Adding to iommu group 6
[    0.782306] pci 0000:00:18.0: Adding to iommu group 7
[    0.782314] pci 0000:00:18.1: Adding to iommu group 7
[    0.782322] pci 0000:00:18.2: Adding to iommu group 7
[    0.782330] pci 0000:00:18.3: Adding to iommu group 7
[    0.782338] pci 0000:00:18.4: Adding to iommu group 7
[    0.782346] pci 0000:00:18.5: Adding to iommu group 7
[    0.782353] pci 0000:00:18.6: Adding to iommu group 7
[    0.782361] pci 0000:00:18.7: Adding to iommu group 7
[    0.782374] pci 0000:01:00.0: Adding to iommu group 8
[    0.782385] pci 0000:02:00.0: Adding to iommu group 9
[    0.782394] pci 0000:03:00.0: Adding to iommu group 10
[    0.782404] pci 0000:04:00.0: Adding to iommu group 11
[    0.782429] pci 0000:05:00.0: Adding to iommu group 5
[    0.782433] pci 0000:05:00.1: Adding to iommu group 5
[    0.782438] pci 0000:05:00.2: Adding to iommu group 5
[    0.782441] pci 0000:05:00.3: Adding to iommu group 5
[    0.782445] pci 0000:05:00.4: Adding to iommu group 5
[    0.782449] pci 0000:05:00.6: Adding to iommu group 5
[    0.782452] pci 0000:05:00.7: Adding to iommu group 5
[    0.782456] pci 0000:06:00.0: Adding to iommu group 5
[    0.784564] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.784565] pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
[    0.784566]  PPR NX GT IA GA PC GA_vAPIC
[    0.784568] AMD-Vi: Interrupt remapping enabled
[    0.784568] AMD-Vi: Virtual APIC enabled
[    0.879014] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.880014] amd_uncore: AMD NB counters detected
[    0.880018] amd_uncore: AMD LLC counters detected
[    0.880643] check: Scanning for low memory corruption every 60 seconds
[    0.881186] Initialise system trusted keyrings
[    0.881234] Key type blacklist registered
[    0.881336] workingset: timestamp_bits=36 max_order=22 bucket_order=0
[    0.882268] zbud: loaded
[    0.882493] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.882707] fuse: init (API version 7.31)
[    0.882947] integrity: Platform Keyring initialized
[    0.891712] Key type asymmetric registered
[    0.891713] Asymmetric key parser 'x509' registered
[    0.891719] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.892111] io scheduler mq-deadline registered
[    0.893113] pcieport 0000:00:01.1: PME: Signaling with IRQ 25
[    0.893201] pcieport 0000:00:01.1: AER: enabled with IRQ 25
[    0.893224] pcieport 0000:00:01.1: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.893440] pcieport 0000:00:01.2: PME: Signaling with IRQ 26
[    0.893513] pcieport 0000:00:01.2: AER: enabled with IRQ 26
[    0.893535] pcieport 0000:00:01.2: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.893755] pcieport 0000:00:01.3: PME: Signaling with IRQ 27
[    0.893836] pcieport 0000:00:01.3: AER: enabled with IRQ 27
[    0.893994] pcieport 0000:00:01.4: PME: Signaling with IRQ 28
[    0.894075] pcieport 0000:00:01.4: AER: enabled with IRQ 28
[    0.894225] pcieport 0000:00:08.1: PME: Signaling with IRQ 29
[    0.894452] pcieport 0000:00:08.2: PME: Signaling with IRQ 30
[    0.894540] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.894586] efifb: probing for efifb
[    0.895115] efifb: showing boot graphics
[    0.898375] efifb: framebuffer at 0xb0000000, using 8100k, total 8100k
[    0.898375] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.898376] efifb: scrolling: redraw
[    0.898376] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.898483] Console: switching to colour frame buffer device 240x67
[    0.901920] fb0: EFI VGA frame buffer device
[    0.902872] ACPI: AC Adapter [AC] (off-line)
[    0.902917] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input0
[    0.902944] ACPI: Lid Switch [LID0]
[    0.902963] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    0.902983] ACPI: Power Button [PBTN]
[    0.903002] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input2
[    0.903012] ACPI: Sleep Button [SBTN]
[    0.903032] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    0.903050] ACPI: Power Button [PWRF]
[    0.903113] Monitor-Mwait will be used to enter C-1 state
[    0.903122] ACPI: \_PR_.C000: Found 2 idle states
[    0.903314] ACPI: \_PR_.C001: Found 2 idle states
[    0.903410] ACPI: \_PR_.C002: Found 2 idle states
[    0.903526] ACPI: \_PR_.C003: Found 2 idle states
[    0.903632] ACPI: \_PR_.C004: Found 2 idle states
[    0.903700] ACPI: \_PR_.C005: Found 2 idle states
[    0.903792] ACPI: \_PR_.C006: Found 2 idle states
[    0.903956] ACPI: \_PR_.C007: Found 2 idle states
[    0.904360] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.925552] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.926919] battery: ACPI: Battery Slot [BAT0] (battery present)
[    0.927098] Linux agpgart interface v0.103
[    0.937400] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0xFC, rev-id 1)
[    0.993370] loop: module loaded
[    0.993737] libphy: Fixed MDIO Bus: probed
[    0.993738] tun: Universal TUN/TAP device driver, 1.6
[    0.993801] PPP generic driver version 2.4.2
[    0.993878] VFIO - User Level meta-driver version: 0.3
[    0.994020] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.994023] ehci-pci: EHCI PCI platform driver
[    0.994043] ehci-platform: EHCI generic platform driver
[    0.994059] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.994061] ohci-pci: OHCI PCI platform driver
[    0.994069] ohci-platform: OHCI generic platform driver
[    0.994074] uhci_hcd: USB Universal Host Controller Interface driver
[    0.994125] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    0.994486] i8042: Warning: Keylock active
[    0.995754] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.995758] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.995876] mousedev: PS/2 mouse device common for all mice
[    0.996020] rtc_cmos 00:01: RTC can wake from S4
[    0.996311] rtc_cmos 00:01: registered as rtc0
[    0.996438] rtc_cmos 00:01: setting system clock to 2020-08-23T13:08:01 UTC (1598188081)
[    0.996454] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.996462] i2c /dev entries driver
[    0.996519] device-mapper: uevent: version 1.0.3
[    0.996580] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[    0.996624] platform eisa.0: Probing EISA bus 0
[    0.996626] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.996629] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.996631] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.996633] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.996634] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.996636] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.996637] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.996639] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.996640] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.996642] platform eisa.0: EISA: Detected 0 cards
[    0.996944] ledtrig-cpu: registered to indicate activity on CPUs
[    0.996950] EFI Variables Facility v0.08 2004-May-17
[    0.997461] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
[    1.018587] drop_monitor: Initializing network drop monitor service
[    1.018841] NET: Registered protocol family 10
[    1.026336] Segment Routing with IPv6
[    1.026380] NET: Registered protocol family 17
[    1.026497] Key type dns_resolver registered
[    1.027584] microcode: CPU0: patch_level=0x0810100b
[    1.027595] microcode: CPU1: patch_level=0x0810100b
[    1.027600] microcode: CPU2: patch_level=0x0810100b
[    1.027612] microcode: CPU3: patch_level=0x0810100b
[    1.027631] microcode: CPU4: patch_level=0x0810100b
[    1.027643] microcode: CPU5: patch_level=0x0810100b
[    1.027665] microcode: CPU6: patch_level=0x0810100b
[    1.027675] microcode: CPU7: patch_level=0x0810100b
[    1.027768] microcode: Microcode Update Driver: v2.2.
[    1.027777] IPI shorthand broadcast: enabled
[    1.027802] sched_clock: Marking stable (709848009, 317911562)->(1031445310, -3685739)
[    1.028000] registered taskstats version 1
[    1.028020] Loading compiled-in X.509 certificates
[    1.029066] Loaded X.509 cert 'Build time autogenerated kernel key: 3c9daab68ae584d7e2886edb0eef36733d13e387'
[    1.029135] zswap: loaded using pool lzo/zbud
[    1.029379] Key type ._fscrypt registered
[    1.029380] Key type .fscrypt registered
[    1.029381] Key type fscrypt-provisioning registered
[    1.029513] Key type trusted registered
[    1.032422] Key type encrypted registered
[    1.032426] AppArmor: AppArmor sha1 policy hashing enabled
[    1.033370] integrity: Loading X.509 certificate: UEFI:db
[    1.033473] integrity: Loaded X.509 cert 'Dell Inc. UEFI DB: 5ddb772dc880660055ba0bc131886bb630a639e7'
[    1.033473] integrity: Loading X.509 certificate: UEFI:db
[    1.033529] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.033529] integrity: Loading X.509 certificate: UEFI:db
[    1.033581] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.034091] integrity: Loading X.509 certificate: UEFI:MokListRT
[    1.034146] integrity: Loaded X.509 cert 'SomeOrg: shim: a01ee84e9b37ace407961cc468c5909447878469'
[    1.034147] integrity: Loading X.509 certificate: UEFI:MokListRT
[    1.034696] integrity: Loaded X.509 cert 'Canonical Ltd. Master Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    1.043535] ima: Allocated hash algorithm: sha1
[    1.115879] ima: No architecture policies found
[    1.115895] evm: Initialising EVM extended attributes:
[    1.115896] evm: security.selinux
[    1.115897] evm: security.SMACK64
[    1.115897] evm: security.SMACK64EXEC
[    1.115897] evm: security.SMACK64TRANSMUTE
[    1.115898] evm: security.SMACK64MMAP
[    1.115898] evm: security.apparmor
[    1.115899] evm: security.ima
[    1.115899] evm: security.capability
[    1.115900] evm: HMAC attrs: 0x1
[    1.116700] PM:   Magic number: 0:185:130
[    1.116787] acpi PNP0C02:02: hash matches
[    1.116823] acpi device:05: hash matches
[    1.117543] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.118173] RAS: Correctable Errors collector initialized.
[    1.122495] Freeing unused decrypted memory: 2040K
[    1.123157] Freeing unused kernel image (initmem) memory: 2640K
[    1.123162] Write protecting the kernel read-only data: 26624k
[    1.123946] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    1.124431] Freeing unused kernel image (rodata/data gap) memory: 1552K
[    1.182941] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.182980] Run /init as init process
[    1.182983]   with arguments:
[    1.182984]     /init
[    1.182984]     splash
[    1.182985]   with environment:
[    1.182986]     HOME=/
[    1.182987]     TERM=linux
[    1.182987]     BOOT_IMAGE=/boot/vmlinuz-5.9.0-050900rc1-generic
[    1.264341] i2c_amd_mp2 0000:05:00.7: enabling device (0000 -> 0002)
[    1.264823] i2c_amd_mp2 0000:05:00.7: MP2 device registered.
[    1.270861] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.278346] acpi device:01: registered as cooling_device8
[    1.278504] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:00/LNXVIDEO:00/input/input6
[    1.279841] ACPI: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
[    1.284750] acpi device:0d: registered as cooling_device9
[    1.285502] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0a/LNXVIDEO:01/input/input7
[    1.287991] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
[    1.292711] hid: raw HID events driver (C) Jiri Kosina
[    1.299164] i2c_hid i2c-DELL0814:00: supply vdd not found, using dummy regulator
[    1.299221] i2c_hid i2c-DELL0814:00: supply vddl not found, using dummy regulator
[    1.320219] rtsx_pci 0000:04:00.0: enabling device (0000 -> 0002)
[    1.322000] xhci_hcd 0000:05:00.3: xHCI Host Controller
[    1.322011] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 1
[    1.322156] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    1.322157] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    1.322399] xhci_hcd 0000:05:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
[    1.323533] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    1.323534] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
[    1.323536] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.323539] usb usb1: Product: xHCI Host Controller
[    1.323540] usb usb1: Manufacturer: Linux 5.9.0-050900rc1-generic xhci-hcd
[    1.323542] usb usb1: SerialNumber: 0000:05:00.3
[    1.323710] hub 1-0:1.0: USB hub found
[    1.323725] hub 1-0:1.0: 4 ports detected
[    1.324119] ahci 0000:06:00.0: version 3.0
[    1.324672] ahci 0000:06:00.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x2 impl SATA mode
[    1.324675] ahci 0000:06:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part deso sadm sds 
[    1.325208] scsi host0: ahci
[    1.325282] xhci_hcd 0000:05:00.3: xHCI Host Controller
[    1.325288] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bus number 2
[    1.325292] xhci_hcd 0000:05:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    1.325353] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.325378] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
[    1.325379] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.325380] usb usb2: Product: xHCI Host Controller
[    1.325381] usb usb2: Manufacturer: Linux 5.9.0-050900rc1-generic xhci-hcd
[    1.325382] usb usb2: SerialNumber: 0000:05:00.3
[    1.325553] scsi host1: ahci
[    1.325591] hub 2-0:1.0: USB hub found
[    1.325635] hub 2-0:1.0: 4 ports detected
[    1.325665] ata1: DUMMY
[    1.325673] ata2: SATA max UDMA/133 abar m2048@0xe0600000 port 0xe0600180 irq 42
[    1.326915] xhci_hcd 0000:05:00.4: xHCI Host Controller
[    1.326921] xhci_hcd 0000:05:00.4: new USB bus registered, assigned bus number 3
[    1.327124] xhci_hcd 0000:05:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
[    1.328198] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.09
[    1.328199] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.328200] usb usb3: Product: xHCI Host Controller
[    1.328201] usb usb3: Manufacturer: Linux 5.9.0-050900rc1-generic xhci-hcd
[    1.328202] usb usb3: SerialNumber: 0000:05:00.4
[    1.328398] hub 3-0:1.0: USB hub found
[    1.328417] hub 3-0:1.0: 2 ports detected
[    1.328887] xhci_hcd 0000:05:00.4: xHCI Host Controller
[    1.328890] xhci_hcd 0000:05:00.4: new USB bus registered, assigned bus number 4
[    1.328893] xhci_hcd 0000:05:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    1.328942] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.328964] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.09
[    1.328965] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.328966] usb usb4: Product: xHCI Host Controller
[    1.328967] usb usb4: Manufacturer: Linux 5.9.0-050900rc1-generic xhci-hcd
[    1.328967] usb usb4: SerialNumber: 0000:05:00.4
[    1.329195] hub 4-0:1.0: USB hub found
[    1.329202] hub 4-0:1.0: 1 port detected
[    1.378197] input: DELL0814:00 044E:121F Mouse as /devices/platform/AMDI0011:00/i2c-0/i2c-DELL0814:00/0018:044E:121F.0001/input/input9
[    1.378379] input: DELL0814:00 044E:121F Touchpad as /devices/platform/AMDI0011:00/i2c-0/i2c-DELL0814:00/0018:044E:121F.0001/input/input10
[    1.378484] input: DELL0814:00 044E:121F as /devices/platform/AMDI0011:00/i2c-0/i2c-DELL0814:00/0018:044E:121F.0001/input/input11
[    1.378560] hid-generic 0018:044E:121F.0001: input,hidraw0: I2C HID v1.00 Mouse [DELL0814:00 044E:121F] on i2c-DELL0814:00
[    1.481089] tg3 0000:03:00.0 eth0: Tigon3 [partno(BCM95762) rev 5762100] (PCI Express) MAC address a4:4c:c8:5b:65:74
[    1.481092] tg3 0000:03:00.0 eth0: attached PHY is 5762C (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[1])
[    1.481094] tg3 0000:03:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[    1.481096] tg3 0000:03:00.0 eth0: dma_rwctrl[00000001] dma_mask[64-bit]
[    1.482671] tg3 0000:03:00.0 enp3s0: renamed from eth0
[    1.664942] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.668944] usb 3-2: new full-speed USB device number 2 using xhci_hcd
[    1.804926] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.805392] ata2.00: ATA-10: SK hynix SC311 SATA 256GB, 70000P10, max UDMA/133
[    1.805395] ata2.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.806537] ata2.00: configured for UDMA/133
[    1.806801] scsi 1:0:0:0: Direct-Access     ATA      SK hynix SC311 S 0P10 PQ: 0 ANSI: 5
[    1.807278] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.807325] sd 1:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.807328] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    1.807339] sd 1:0:0:0: [sda] Write Protect is off
[    1.807341] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.807357] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.813965] usb 1-1: New USB device found, idVendor=0424, idProduct=2514, bcdDevice= 2.23
[    1.813967] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.826902]  sda: sda1 sda2
[    1.827533] sd 1:0:0:0: [sda] Attached SCSI disk
[    1.836858] usb 3-2: New USB device found, idVendor=0a5c, idProduct=5834, bcdDevice= 1.01
[    1.836860] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.836862] usb 3-2: Product: 5880
[    1.836863] usb 3-2: Manufacturer: Broadcom Corp
[    1.836864] usb 3-2: SerialNumber: 0123456789ABCD
[    1.870478] hub 1-1:1.0: USB hub found
[    1.870705] hub 1-1:1.0: 4 ports detected
[    1.888921] tsc: Refined TSC clocksource calibration: 1997.994 MHz
[    1.888930] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x39998ee3d90, max_idle_ns: 881590680565 ns
[    1.889198] clocksource: Switched to clocksource tsc
[    1.943246] usb 2-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.965543] usb 2-1: config 1 has an invalid interface number: 12 but max is 4
[    1.965545] usb 2-1: config 1 has an invalid interface number: 13 but max is 4
[    1.965547] usb 2-1: config 1 has an invalid interface number: 13 but max is 4
[    1.965548] usb 2-1: config 1 has no interface number 1
[    1.965549] usb 2-1: config 1 has no interface number 4
[    1.966390] usb 2-1: New USB device found, idVendor=413c, idProduct=81b6, bcdDevice= 0.06
[    1.966392] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.966394] usb 2-1: Product: DW5811e Snapdragon™ X7 LTE
[    1.966396] usb 2-1: Manufacturer: Sierra Wireless, Incorporated
[    1.966397] usb 2-1: SerialNumber: LF63354941021014
[    1.992947] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[    2.053782] input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/input8
[    2.134449] systemd[1]: Inserted module 'autofs4'
[    2.191341] systemd[1]: systemd 246.2-1ubuntu1 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    2.209416] systemd[1]: Detected architecture x86-64.
[    2.224937] usb 1-1.2: new full-speed USB device number 3 using xhci_hcd
[    2.226091] systemd[1]: Set hostname to <u-Latitude-5495>.
[    2.334842] systemd[1]: /lib/systemd/system/dbus.service:12: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    2.353842] usb 1-1.2: New USB device found, idVendor=1fd2, idProduct=6004, bcdDevice= 1.00
[    2.353845] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.353848] usb 1-1.2: Product: LGDisplay Incell Touch
[    2.353850] usb 1-1.2: Manufacturer: Melfas
[    2.375001] systemd[1]: /lib/systemd/system/plymouth-start.service:17: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    2.411960] systemd[1]: /lib/systemd/system/gdm.service:30: Standard output type syslog is obsolete, automatically updating to journal. Please update your unit file, and consider removing the setting altogether.
[    2.414175] systemd[1]: Queued start job for default target Graphical Interface.
[    2.415666] systemd[1]: Created slice system-modprobe.slice.
[    2.415999] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    2.416239] systemd[1]: Created slice User and Session Slice.
[    2.416339] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    2.416589] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    2.416686] systemd[1]: Reached target User and Group Name Lookups.
[    2.416755] systemd[1]: Reached target Remote File Systems.
[    2.416791] systemd[1]: Reached target Slices.
[    2.417773] systemd[1]: Listening on Syslog Socket.
[    2.417925] systemd[1]: Listening on fsck to fsckd communication Socket.
[    2.418004] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    2.418208] systemd[1]: Listening on Journal Audit Socket.
[    2.418343] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.418471] systemd[1]: Listening on Journal Socket.
[    2.418606] systemd[1]: Listening on udev Control Socket.
[    2.418737] systemd[1]: Listening on udev Kernel Socket.
[    2.419873] systemd[1]: Mounting Huge Pages File System...
[    2.420817] systemd[1]: Mounting POSIX Message Queue File System...
[    2.422037] systemd[1]: Mounting Kernel Debug File System...
[    2.423308] systemd[1]: Mounting Kernel Trace File System...
[    2.425509] systemd[1]: Starting Journal Service...
[    2.426834] systemd[1]: Starting Set the console keyboard layout...
[    2.428348] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    2.429639] systemd[1]: Starting Load Kernel Module drm...
[    2.430563] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    2.430638] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    2.433732] systemd[1]: Starting Load Kernel Modules...
[    2.435333] systemd[1]: Starting Remount Root and Kernel File Systems...
[    2.436791] systemd[1]: Starting Coldplug All udev Devices...
[    2.438376] systemd[1]: Starting Uncomplicated firewall...
[    2.441317] systemd[1]: Mounted Huge Pages File System.
[    2.441515] systemd[1]: Mounted POSIX Message Queue File System.
[    2.441667] systemd[1]: Mounted Kernel Debug File System.
[    2.441822] systemd[1]: Mounted Kernel Trace File System.
[    2.442609] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    2.443373] systemd[1]: Finished Uncomplicated firewall.
[    2.446721] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[    2.448785] systemd[1]: modprobe@drm.service: Succeeded.
[    2.449282] systemd[1]: Finished Load Kernel Module drm.
[    2.449980] systemd[1]: Finished Remount Root and Kernel File Systems.
[    2.451485] systemd[1]: Activating swap /swapfile...
[    2.453190] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    2.453286] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    2.453957] lp: driver loaded but no devices found
[    2.454605] systemd[1]: Starting Load/Save Random Seed...
[    2.456246] systemd[1]: Starting Create System Users...
[    2.458767] ppdev: user-space parallel port driver
[    2.464877] systemd[1]: Finished Load Kernel Modules.
[    2.466527] systemd[1]: Mounting FUSE Control File System...
[    2.468061] systemd[1]: Mounting Kernel Configuration File System...
[    2.469848] systemd[1]: Starting Apply Kernel Variables...
[    2.474314] systemd[1]: Finished Load/Save Random Seed.
[    2.474642] systemd[1]: Mounted FUSE Control File System.
[    2.474838] systemd[1]: Mounted Kernel Configuration File System.
[    2.478102] systemd[1]: Finished Create System Users.
[    2.479860] systemd[1]: Starting Create Static Device Nodes in /dev...
[    2.490350] systemd[1]: Finished Apply Kernel Variables.
[    2.496205] systemd[1]: Finished Create Static Device Nodes in /dev.
[    2.498375] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    2.516559] systemd[1]: Finished Set the console keyboard layout.
[    2.516757] systemd[1]: Reached target Local File Systems (Pre).
[    2.519031] systemd[1]: Mounting Mount unit for core18, revision 1880...
[    2.520852] systemd[1]: Mounting Mount unit for core18, revision 1885...
[    2.524223] systemd[1]: Mounting Mount unit for gnome-3-34-1804, revision 36...
[    2.526414] systemd[1]: Mounting Mount unit for gtk-common-themes, revision 1506...
[    2.528413] systemd[1]: Mounting Mount unit for snap-store, revision 467...
[    2.530699] systemd[1]: Mounting Mount unit for snapd, revision 8542...
[    2.532583] systemd[1]: Mounting Mount unit for snapd, revision 8790...
[    2.540669] systemd[1]: Mounted Mount unit for core18, revision 1880.
[    2.540878] systemd[1]: Mounted Mount unit for gnome-3-34-1804, revision 36.
[    2.541057] systemd[1]: Mounted Mount unit for gtk-common-themes, revision 1506.
[    2.541213] systemd[1]: Mounted Mount unit for snap-store, revision 467.
[    2.541355] systemd[1]: Mounted Mount unit for snapd, revision 8542.
[    2.570015] systemd[1]: Finished Coldplug All udev Devices.
[    2.590529] systemd[1]: Started Rule-based Manager for Device Events and Files.
[    2.592260] systemd[1]: Starting Show Plymouth Boot Screen...
[    2.596941] usb 1-1.3: new high-speed USB device number 4 using xhci_hcd
[    2.601134] systemd[1]: Started Journal Service.
[    2.628957] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6 across:2260988k SSFS
[    2.718013] input: Melfas LGDisplay Incell Touch as /devices/pci0000:00/0000:00:08.1/0000:05:00.3/usb1/1-1/1-1.2/1-1.2:1.0/0003:1FD2:6004.0002/input/input12
[    2.718226] usb 1-1.3: New USB device found, idVendor=0c45, idProduct=6717, bcdDevice=75.24
[    2.718231] hid-generic 0003:1FD2:6004.0002: input,hidraw1: USB HID v1.11 Device [Melfas LGDisplay Incell Touch] on usb-0000:05:00.3-1.2/input0
[    2.718232] usb 1-1.3: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[    2.718235] usb 1-1.3: Product: Integrated_Webcam_HD
[    2.718237] usb 1-1.3: Manufacturer: CN0K49W1LOG0078SBE0TA01
[    2.721812] input: DELL Wireless hotkeys as /devices/virtual/input/input13
[    2.723871] hid-generic 0003:1FD2:6004.0003: hiddev0,hidraw2: USB HID v1.11 Device [Melfas LGDisplay Incell Touch] on usb-0000:05:00.3-1.2/input1
[    2.723933] usbcore: registered new interface driver usbhid
[    2.723934] usbhid: USB HID core driver
[    2.726759] smo8800 SMO8810:00: failed to obtain IRQ
[    2.726856] smo8800: probe of SMO8810:00 failed with error -22
[    2.806599] ccp 0000:05:00.2: enabling device (0000 -> 0002)
[    2.807180] ioremap error for 0x6efbc000-0x6efbe000, requested 0x2, got 0x0
[    2.808031] ucsi_acpi: probe of USBC000:00 failed with error -12
[    2.817503] ccp 0000:05:00.2: ccp enabled
[    2.817520] ccp 0000:05:00.2: psp: unable to access the device: you might be running a broken BIOS.
[    2.842470] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    2.842821] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    2.845182] usb 1-1.4: new full-speed USB device number 5 using xhci_hcd
[    2.873643] pstore: Using crash dump compression: deflate
[    2.873678] pstore: Registered efi as persistent store backend
[    2.881616] usbcore: registered new interface driver usbserial_generic
[    2.881627] usbserial: USB Serial support registered for generic
[    2.884193] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.4)
[    2.892940] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    2.901163] usbcore: registered new interface driver qcserial
[    2.901193] usbserial: USB Serial support registered for Qualcomm USB modem
[    2.901776] qcserial 2-1:1.0: Qualcomm USB modem converter detected
[    2.902088] usb 2-1: Qualcomm USB modem converter now attached to ttyUSB0
[    2.902688] usbcore: registered new interface driver cdc_ether
[    2.905632] input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input14
[    2.925528] qcserial 2-1:1.2: Qualcomm USB modem converter detected
[    2.925815] usb 2-1: Qualcomm USB modem converter now attached to ttyUSB1
[    2.957536] qcserial 2-1:1.3: Qualcomm USB modem converter detected
[    2.961588] usb 2-1: Qualcomm USB modem converter now attached to ttyUSB2
[    2.969287] usb 1-1.4: New USB device found, idVendor=0cf3, idProduct=e007, bcdDevice= 0.01
[    2.969290] usb 1-1.4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.006153] usbcore: registered new interface driver cdc_ncm
[    3.007625] dell_smm_hwmon: unable to get SMM Dell signature
[    3.012250] usbcore: registered new interface driver cdc_wdm
[    3.016665] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
[    3.016672] RAPL PMU: hw unit of domain package 2^-16 Joules
[    3.024213] [drm] amdgpu kernel modesetting enabled.
[    3.024263] vga_switcheroo: detected switching method \_SB_.PCI0.GP17.VGA_.ATPX handle
[    3.025273] ATPX version 1, functions 0x00000001
[    3.025398] ATPX Hybrid Graphics, forcing to ATPX
[    3.025598] amdgpu: Topology: Add APU node [0x0:0x0]
[    3.025758] checking generic (b0000000 7e9000) vs hw (d0000000 10000000)
[    3.025759] checking generic (b0000000 7e9000) vs hw (e0000000 200000)
[    3.025760] checking generic (b0000000 7e9000) vs hw (e0d00000 40000)
[    3.025836] amdgpu 0000:01:00.0: enabling device (0006 -> 0007)
[    3.025956] [drm] initializing kernel modesetting (POLARIS12 0x1002:0x699F 0x1028:0x0814 0xC3).
[    3.025961] amdgpu 0000:01:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
[    3.026709] [drm] register mmio base: 0xE0D00000
[    3.026710] [drm] register mmio size: 262144
[    3.026729] [drm] add ip block number 0 <vi_common>
[    3.026730] [drm] add ip block number 1 <gmc_v8_0>
[    3.026731] [drm] add ip block number 2 <tonga_ih>
[    3.026733] [drm] add ip block number 3 <gfx_v8_0>
[    3.026734] [drm] add ip block number 4 <sdma_v3_0>
[    3.026736] [drm] add ip block number 5 <powerplay>
[    3.026737] [drm] add ip block number 6 <dm>
[    3.026738] [drm] add ip block number 7 <uvd_v6_0>
[    3.026739] [drm] add ip block number 8 <vce_v3_0>
[    3.032879] cryptd: max_cpu_qlen set to 1000
[    3.038644] ath10k_pci 0000:02:00.0: enabling device (0000 -> 0002)
[    3.045603] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
[    3.045925] cdc_mbim 2-1:1.12: cdc-wdm1: USB WDM device
[    3.046194] cdc_mbim 2-1:1.12 wwan0: register 'cdc_mbim' at usb-0000:05:00.3-1, CDC MBIM, 1e:73:ac:6b:6c:67
[    3.046255] usbcore: registered new interface driver cdc_mbim
[    3.123764] mc: Linux media interface: v0.10
[    3.124758] AVX2 version of gcm_enc/dec engaged.
[    3.124762] AES CTR mode by8 optimization enabled
[    3.172647] input: DELL0814:00 044E:121F Mouse as /devices/platform/AMDI0011:00/i2c-0/i2c-DELL0814:00/0018:044E:121F.0001/input/input15
[    3.172844] input: DELL0814:00 044E:121F Touchpad as /devices/platform/AMDI0011:00/i2c-0/i2c-DELL0814:00/0018:044E:121F.0001/input/input16
[    3.172965] input: DELL0814:00 044E:121F UNKNOWN as /devices/platform/AMDI0011:00/i2c-0/i2c-DELL0814:00/0018:044E:121F.0001/input/input17
[    3.173107] hid-multitouch 0018:044E:121F.0001: input,hidraw0: I2C HID v1.00 Mouse [DELL0814:00 044E:121F] on i2c-DELL0814:00
[    3.196036] videodev: Linux video capture interface: v2.00
[    3.200675] Bluetooth: Core ver 2.22
[    3.200715] NET: Registered protocol family 31
[    3.200716] Bluetooth: HCI device and connection manager initialized
[    3.200725] Bluetooth: HCI socket layer initialized
[    3.200729] Bluetooth: L2CAP socket layer initialized
[    3.200736] Bluetooth: SCO socket layer initialized
[    3.201948] kvm: Nested Virtualization enabled
[    3.201982] SVM: kvm: Nested Paging enabled
[    3.201983] SVM: Virtual VMLOAD VMSAVE supported
[    3.201983] SVM: Virtual GIF supported
[    3.208210] MCE: In-kernel MCE decoding enabled.
[    3.211598] EDAC amd64: F17h_M10h detected (node 0).
[    3.211766] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.220118] usbcore: registered new interface driver btusb
[    3.227999] uvcvideo: Found UVC 1.00 device Integrated_Webcam_HD (0c45:6717)
[    3.234426] amdgpu: ATOM BIOS: SWBRT37647.001
[    3.234476] [drm] UVD is enabled in VM mode
[    3.234477] [drm] UVD ENC is enabled in VM mode
[    3.234483] [drm] VCE enabled in VM mode
[    3.234511] [drm] GPU posting now...
[    3.246874] uvcvideo 1-1.3:1.0: Entity type for entity Extension 4 was not initialized!
[    3.246878] uvcvideo 1-1.3:1.0: Entity type for entity Extension 3 was not initialized!
[    3.246880] uvcvideo 1-1.3:1.0: Entity type for entity Processing 2 was not initialized!
[    3.246881] uvcvideo 1-1.3:1.0: Entity type for entity Camera 1 was not initialized!
[    3.246965] input: Integrated_Webcam_HD: Integrate as /devices/pci0000:00/0000:00:08.1/0000:05:00.3/usb1/1-1/1-1.3/1-1.3:1.0/input/input18
[    3.247057] usbcore: registered new interface driver uvcvideo
[    3.247058] USB Video Class driver (1.1.1)
[    3.249307] input: Melfas LGDisplay Incell Touch as /devices/pci0000:00/0000:00:08.1/0000:05:00.3/usb1/1-1/1-1.2/1-1.2:1.0/0003:1FD2:6004.0002/input/input19
[    3.249470] hid-multitouch 0003:1FD2:6004.0002: input,hidraw1: USB HID v1.11 Device [Melfas LGDisplay Incell Touch] on usb-0000:05:00.3-1.2/input0
[    3.250341] dell_laptop: Using i8042 filter function for receiving events
[    3.264030] [drm] vm size is 64 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
[    3.265613] amdgpu 0000:01:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
[    3.265618] amdgpu 0000:01:00.0: amdgpu: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
[    3.265631] [drm] Detected VRAM RAM=2048M, BAR=256M
[    3.265633] [drm] RAM width 64bits GDDR5
[    3.265729] [TTM] Zone  kernel: Available graphics memory: 7683220 KiB
[    3.265730] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    3.265731] [TTM] Initializing pool allocator
[    3.265738] [TTM] Initializing DMA pool allocator
[    3.266213] [drm] amdgpu: 2048M of VRAM memory ready
[    3.266218] [drm] amdgpu: 3072M of GTT memory ready.
[    3.266232] [drm] GART: num cpu pages 65536, num gpu pages 65536
[    3.272352] [drm] PCIE GART of 256M enabled (table at 0x000000F400000000).
[    3.275559] [drm] Chained IB support enabled!
[    3.284044] amdgpu: hwmgr_sw_init smu backed is polaris10_smu
[    3.286195] EDAC amd64: F17h_M10h detected (node 0).
[    3.286374] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.287591] snd_hda_intel 0000:05:00.1: enabling device (0000 -> 0002)
[    3.287950] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[    3.290269] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[    3.291348] snd_hda_intel 0000:05:00.1: Handle vga_switcheroo audio client
[    3.291828] snd_hda_intel 0000:05:00.6: enabling device (0000 -> 0002)
[    3.324370] ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1028:0310
[    3.324374] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
[    3.324952] ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00140-QCARMSWPZ-1 api 6 features wowlan,ignore-otp,mfp crc32 29eb8ca1
[    3.380405] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.380446] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.380474] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.380501] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.380529] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.380556] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.380583] amdgpu: Voltage value looks like a Leakage ID but it's not patched 
[    3.393531] ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 4ac0889b
[    3.403094] [drm] DM_PPLIB: values for Engine clock
[    3.403097] [drm] DM_PPLIB:	 214000
[    3.403097] [drm] DM_PPLIB:	 551000
[    3.403098] [drm] DM_PPLIB:	 734000
[    3.403098] [drm] DM_PPLIB:	 980000
[    3.403098] [drm] DM_PPLIB:	 1046000
[    3.403099] [drm] DM_PPLIB:	 1073000
[    3.403099] [drm] DM_PPLIB:	 1124000
[    3.403101] [drm] DM_PPLIB: Validation clocks:
[    3.403101] [drm] DM_PPLIB:    engine_max_clock: 112400
[    3.403101] [drm] DM_PPLIB:    memory_max_clock: 150000
[    3.403102] [drm] DM_PPLIB:    level           : 8
[    3.403103] [drm] DM_PPLIB: values for Memory clock
[    3.403104] [drm] DM_PPLIB:	 300000
[    3.403104] [drm] DM_PPLIB:	 625000
[    3.403104] [drm] DM_PPLIB:	 1500000
[    3.403105] [drm] DM_PPLIB: Validation clocks:
[    3.403105] [drm] DM_PPLIB:    engine_max_clock: 112400
[    3.403106] [drm] DM_PPLIB:    memory_max_clock: 150000
[    3.403106] [drm] DM_PPLIB:    level           : 8
[    3.403133] [drm] Display Core initialized with v3.2.95!
[    3.410045] EDAC amd64: F17h_M10h detected (node 0).
[    3.410236] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.412994] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input20
[    3.413108] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input21
[    3.413167] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:05:00.1/sound/card0/input22
[    3.433786] [drm] UVD and UVD ENC initialized successfully.
[    3.465808] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC3246: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    3.465811] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    3.465812] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    3.465813] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    3.465814] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    3.465816] snd_hda_codec_realtek hdaudioC1D0:      Headset Mic=0x19
[    3.465818] snd_hda_codec_realtek hdaudioC1D0:      Headphone Mic=0x1a
[    3.465819] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
[    3.486905] ath10k_pci 0000:02:00.0: htt-ver 3.60 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
[    3.533669] [drm] VCE initialized successfully.
[    3.536265] kfd kfd: Allocated 3969056 bytes on gart
[    3.537624] Virtual CRAT table created for GPU
[    3.537754] amdgpu: Topology: Add dGPU node [0x699f:0x1002]
[    3.537758] kfd kfd: added device 1002:699f
[    3.537763] amdgpu 0000:01:00.0: amdgpu: SE 2, SH per SE 1, CU per SH 5, active_cu_number 8
[    3.556936] [drm] Initialized amdgpu 3.39.0 20150101 for 0000:01:00.0 on minor 0
[    3.557097] checking generic (b0000000 7e9000) vs hw (b0000000 10000000)
[    3.557098] fb0: switching to amdgpudrmfb from EFI VGA
[    3.557567] Console: switching to colour dummy device 80x25
[    3.557613] amdgpu 0000:05:00.0: vgaarb: deactivate vga console
[    3.557642] amdgpu 0000:05:00.0: enabling device (0006 -> 0007)
[    3.557770] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15DD 0x1028:0x0814 0xC4).
[    3.557775] amdgpu 0000:05:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
[    3.558541] [drm] register mmio base: 0xE0B00000
[    3.558542] [drm] register mmio size: 524288
[    3.558567] [drm] add ip block number 0 <soc15_common>
[    3.558569] [drm] add ip block number 1 <gmc_v9_0>
[    3.558570] [drm] add ip block number 2 <vega10_ih>
[    3.558572] [drm] add ip block number 3 <psp>
[    3.558573] [drm] add ip block number 4 <gfx_v9_0>
[    3.558575] [drm] add ip block number 5 <sdma_v4_0>
[    3.558576] [drm] add ip block number 6 <powerplay>
[    3.558577] [drm] add ip block number 7 <dm>
[    3.558579] [drm] add ip block number 8 <vcn_v1_0>
[    3.558924] amdgpu: ATOM BIOS: 113-RAVEN-103
[    3.559385] [drm] VCN decode is enabled in VM mode
[    3.559386] [drm] VCN encode is enabled in VM mode
[    3.559387] [drm] JPEG decode is enabled in VM mode
[    3.559397] vga_switcheroo: enabled
[    3.559448] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    3.559466] amdgpu 0000:05:00.0: amdgpu: VRAM: 1024M 0x000000F400000000 - 0x000000F43FFFFFFF (1024M used)
[    3.559468] amdgpu 0000:05:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    3.559469] amdgpu 0000:05:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    3.559474] [drm] Detected VRAM RAM=1024M, BAR=1024M
[    3.559476] [drm] RAM width 128bits DDR4
[    3.559542] [drm] amdgpu: 1024M of VRAM memory ready
[    3.559548] [drm] amdgpu: 3072M of GTT memory ready.
[    3.559551] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    3.559998] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[    3.568783] ath: EEPROM regdomain: 0x6c
[    3.568786] ath: EEPROM indicates we should expect a direct regpair map
[    3.568790] ath: Country alpha2 being used: 00
[    3.568791] ath: Regpair used: 0x6c
[    3.569206] amdgpu: hwmgr_sw_init smu backed is smu10_smu
[    3.571083] [drm] Found VCN firmware Version ENC: 1.9 DEC: 1 VEP: 0 Revision: 28
[    3.571132] [drm] PSP loading VCN firmware
[    3.574507] input: HD-Audio Generic Headphone Mic as /devices/pci0000:00/0000:00:08.1/0000:05:00.6/sound/card1/input23
[    3.575460] ath10k_pci 0000:02:00.0 wlp2s0: renamed from wlan0
[    3.593885] [drm] reserve 0x400000 from 0xf43fc00000 for PSP TMR
[    3.606631] EDAC amd64: F17h_M10h detected (node 0).
[    3.606803] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.653130] audit: type=1400 audit(1598188084.148:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=649 comm="apparmor_parser"
[    3.653140] audit: type=1400 audit(1598188084.148:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=651 comm="apparmor_parser"
[    3.653148] audit: type=1400 audit(1598188084.148:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=651 comm="apparmor_parser"
[    3.653152] audit: type=1400 audit(1598188084.148:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=646 comm="apparmor_parser"
[    3.653156] audit: type=1400 audit(1598188084.148:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=646 comm="apparmor_parser"
[    3.653159] audit: type=1400 audit(1598188084.148:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=646 comm="apparmor_parser"
[    3.655623] audit: type=1400 audit(1598188084.152:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="tcpdump" pid=643 comm="apparmor_parser"
[    3.656266] audit: type=1400 audit(1598188084.152:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine" pid=644 comm="apparmor_parser"
[    3.656272] audit: type=1400 audit(1598188084.152:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/snapd/snap-confine//mount-namespace-capture-helper" pid=644 comm="apparmor_parser"
[    3.685822] EDAC amd64: F17h_M10h detected (node 0).
[    3.685947] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.832952] amdgpu 0000:05:00.0: amdgpu: RAS: optional ras ta ucode is not available
[    3.846213] EDAC amd64: F17h_M10h detected (node 0).
[    3.846354] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.859067] [drm] kiq ring mec 2 pipe 1 q 0
[    3.859690] [drm] DM_PPLIB: values for F clock
[    3.859696] [drm] DM_PPLIB:	 400000 in kHz, 3049 in mV
[    3.859697] [drm] DM_PPLIB:	 933000 in kHz, 3724 in mV
[    3.859698] [drm] DM_PPLIB:	 1067000 in kHz, 3924 in mV
[    3.859699] [drm] DM_PPLIB:	 1200000 in kHz, 4074 in mV
[    3.859701] [drm] DM_PPLIB: values for DCF clock
[    3.859702] [drm] DM_PPLIB:	 300000 in kHz, 3049 in mV
[    3.859703] [drm] DM_PPLIB:	 600000 in kHz, 3724 in mV
[    3.859704] [drm] DM_PPLIB:	 626000 in kHz, 3924 in mV
[    3.859705] [drm] DM_PPLIB:	 654000 in kHz, 4074 in mV
[    3.860822] [drm] Display Core initialized with v3.2.95!
[    3.871407] snd_hda_intel 0000:05:00.1: bound 0000:05:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    3.926167] EDAC amd64: F17h_M10h detected (node 0).
[    3.926332] EDAC amd64: Node 0: DRAM ECC disabled.
[    3.956002] [drm] VCN decode and encode initialized successfully(under SPG Mode).
[    3.957494] kfd kfd: Allocated 3969056 bytes on gart
[    3.958183] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8d980 flags=0x0070]
[    3.958200] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8da00 flags=0x0070]
[    3.958210] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8da40 flags=0x0070]
[    3.958223] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8da80 flags=0x0070]
[    3.958236] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8dac0 flags=0x0070]
[    3.958245] amdgpu: Topology: Add dGPU node [0x699f:0x1002]
[    3.958248] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8db80 flags=0x0070]
[    3.958249] kfd kfd: added device 1002:15dd
[    3.958254] amdgpu 0000:05:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 8
[    3.958262] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8db40 flags=0x0070]
[    3.958272] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8db00 flags=0x0070]
[    3.958283] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8dbc0 flags=0x0070]
[    3.958295] ahci 0000:06:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0x423d8dc00 flags=0x0070]
[    3.960623] [drm] fb mappable at 0x70BCA000
[    3.960623] [drm] vram apper at 0x70000000
[    3.960624] [drm] size 8294400
[    3.960624] [drm] fb depth is 24
[    3.960625] [drm]    pitch is 7680
[    3.960741] fbcon: amdgpudrmfb (fb0) is primary device
[    3.988815] Console: switching to colour frame buffer device 240x67
[    3.989711] EDAC amd64: F17h_M10h detected (node 0).
[    3.989860] EDAC amd64: Node 0: DRAM ECC disabled.
[    4.009034] ata2.00: exception Emask 0x20 SAct 0x100e001 SErr 0x0 action 0x6 frozen
[    4.009035] ata2.00: irq_stat 0x20000000, host bus error
[    4.009038] ata2.00: failed command: READ FPDMA QUEUED
[    4.009042] ata2.00: cmd 60/08:00:10:10:91/00:00:14:00:00/40 tag 0 ncq dma 4096 in
                        res 40/00:c0:f0:85:55/00:00:05:00:00/40 Emask 0x20 (host bus error)
[    4.009043] ata2.00: status: { DRDY }
[    4.009045] ata2.00: failed command: READ FPDMA QUEUED
[    4.009048] ata2.00: cmd 60/00:68:c0:59:21/01:00:07:00:00/40 tag 13 ncq dma 131072 in
                        res 40/00:c0:f0:85:55/00:00:05:00:00/40 Emask 0x20 (host bus error)
[    4.009049] ata2.00: status: { DRDY }
[    4.009050] ata2.00: failed command: READ FPDMA QUEUED
[    4.009054] ata2.00: cmd 60/00:70:b8:91:c5/01:00:00:00:00/40 tag 14 ncq dma 131072 in
                        res 40/00:c0:f0:85:55/00:00:05:00:00/40 Emask 0x20 (host bus error)
[    4.009054] ata2.00: status: { DRDY }
[    4.009055] ata2.00: failed command: READ FPDMA QUEUED
[    4.009059] ata2.00: cmd 60/00:78:10:6e:47/01:00:07:00:00/40 tag 15 ncq dma 131072 in
                        res 40/00:c0:f0:85:55/00:00:05:00:00/40 Emask 0x20 (host bus error)
[    4.009060] ata2.00: status: { DRDY }
[    4.009061] ata2.00: failed command: READ FPDMA QUEUED
[    4.009064] ata2.00: cmd 60/10:c0:f0:85:55/00:00:05:00:00/40 tag 24 ncq dma 8192 in
                        res 40/00:c0:f0:85:55/00:00:05:00:00/40 Emask 0x20 (host bus error)
[    4.009065] ata2.00: status: { DRDY }
[    4.009074] ata2: hard resetting link
[    4.009874] amdgpu 0000:05:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    4.033173] amdgpu 0000:05:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[    4.033177] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    4.033179] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    4.033181] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[    4.033183] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[    4.033185] amdgpu 0000:05:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[    4.033186] amdgpu 0000:05:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[    4.033188] amdgpu 0000:05:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[    4.033189] amdgpu 0000:05:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[    4.033192] amdgpu 0000:05:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[    4.033194] amdgpu 0000:05:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[    4.033196] amdgpu 0000:05:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[    4.033198] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[    4.033200] amdgpu 0000:05:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[    4.033202] amdgpu 0000:05:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[    4.052142] [drm] Initialized amdgpu 3.39.0 20150101 for 0000:05:00.0 on minor 1
[    4.484957] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.486518] ata2.00: configured for UDMA/133
[    4.486550] sd 1:0:0:0: [sda] tag#13 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[    4.486554] sd 1:0:0:0: [sda] tag#13 Sense Key : Illegal Request [current] 
[    4.486556] sd 1:0:0:0: [sda] tag#13 Add. Sense: Unaligned write command
[    4.486559] sd 1:0:0:0: [sda] tag#13 CDB: Read(10) 28 00 07 21 59 c0 00 01 00 00
[    4.486562] blk_update_request: I/O error, dev sda, sector 119626176 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
[    4.486627] sd 1:0:0:0: [sda] tag#14 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[    4.486629] sd 1:0:0:0: [sda] tag#14 Sense Key : Illegal Request [current] 
[    4.486630] sd 1:0:0:0: [sda] tag#14 Add. Sense: Unaligned write command
[    4.486632] sd 1:0:0:0: [sda] tag#14 CDB: Read(10) 28 00 00 c5 91 b8 00 01 00 00
[    4.486633] blk_update_request: I/O error, dev sda, sector 12947896 op 0x0:(READ) flags 0x80700 phys_seg 3 prio class 0
[    4.486690] sd 1:0:0:0: [sda] tag#15 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[    4.486691] sd 1:0:0:0: [sda] tag#15 Sense Key : Illegal Request [current] 
[    4.486693] sd 1:0:0:0: [sda] tag#15 Add. Sense: Unaligned write command
[    4.486694] sd 1:0:0:0: [sda] tag#15 CDB: Read(10) 28 00 07 47 6e 10 00 01 00 00
[    4.486695] blk_update_request: I/O error, dev sda, sector 122121744 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
[    4.486748] sd 1:0:0:0: [sda] tag#24 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[    4.486749] sd 1:0:0:0: [sda] tag#24 Sense Key : Illegal Request [current] 
[    4.486751] sd 1:0:0:0: [sda] tag#24 Add. Sense: Unaligned write command
[    4.486752] sd 1:0:0:0: [sda] tag#24 CDB: Read(10) 28 00 05 55 85 f0 00 00 10 00
[    4.486754] blk_update_request: I/O error, dev sda, sector 89490928 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[    4.486799] ata2: EH complete
[    4.568710] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.568714] Bluetooth: BNEP filters: protocol multicast
[    4.568724] Bluetooth: BNEP socket layer initialized
[    4.585985] NET: Registered protocol family 38
[    7.708054] rfkill: input handler disabled
[    8.074232] tg3 0000:03:00.0 enp3s0: Link is up at 1000 Mbps, full duplex
[    8.074236] tg3 0000:03:00.0 enp3s0: Flow control is on for TX and on for RX
[    8.074237] tg3 0000:03:00.0 enp3s0: EEE is enabled
[    8.074270] IPv6: ADDRCONF(NETDEV_CHANGE): enp3s0: link becomes ready
[   10.545236] Bluetooth: RFCOMM TTY layer initialized
[   10.545246] Bluetooth: RFCOMM socket layer initialized
[   10.545272] Bluetooth: RFCOMM ver 1.11
[   10.692502] rfkill: input handler enabled
[   13.880446] rfkill: input handler disabled
[   19.857152] wlp2s0: authenticate with d8:8f:76:7c:52:a9
[   19.897501] wlp2s0: send auth to d8:8f:76:7c:52:a9 (try 1/3)
[   20.001208] wlp2s0: send auth to d8:8f:76:7c:52:a9 (try 2/3)
[   20.002227] wlp2s0: authenticated
[   20.004937] wlp2s0: associate with d8:8f:76:7c:52:a9 (try 1/3)
[   20.006462] wlp2s0: RX AssocResp from d8:8f:76:7c:52:a9 (capab=0x1011 status=0 aid=3)
[   20.009115] wlp2s0: associated
[   20.009278] ath: EEPROM regdomain: 0x809e
[   20.009280] ath: EEPROM indicates we should expect a country code
[   20.009281] ath: doing EEPROM country->regdmn map search
[   20.009282] ath: country maps to regdmn code: 0x50
[   20.009283] ath: Country alpha2 being used: TW
[   20.009284] ath: Regpair used: 0x50
[   20.009286] ath: regdomain 0x809e dynamically updated by country element
[   20.029748] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
[   20.048514] wlp2s0: Limiting TX power to 27 (27 - 0) dBm as advertised by d8:8f:76:7c:52:a9
[   78.209086] ------------[ cut here ]------------
[   78.209132] NETDEV WATCHDOG: enp3s0 (tg3): transmit queue 0 timed out
[   78.209163] WARNING: CPU: 7 PID: 0 at net/sched/sch_generic.c:442 dev_watchdog+0x25b/0x270
[   78.209166] Modules linked in: ccm rfcomm cmac algif_hash algif_skcipher af_alg bnep nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi joydev snd_hda_intel snd_intel_dspcfg uvcvideo snd_hda_codec btusb videobuf2_vmalloc snd_hda_core videobuf2_memops btrtl videobuf2_v4l2 edac_mce_amd btbcm snd_hwdep btintel videobuf2_common kvm_amd dell_laptop bluetooth videodev snd_pcm kvm crct10dif_pclmul ecdh_generic ecc ghash_clmulni_intel ledtrig_audio mc snd_seq_midi aesni_intel snd_seq_midi_event crypto_simd snd_rawmidi cryptd ath10k_pci glue_helper cdc_mbim cdc_wdm rapl ath10k_core amdgpu snd_seq cdc_ncm dell_wmi cdc_ether qcserial ath dell_smbios usbnet input_leds iommu_v2 usb_wwan gpu_sched snd_seq_device dcdbas usbserial mii mac80211 sparse_keymap serio_raw wmi_bmof hid_multitouch snd_timer ttm drm_kms_helper dell_wmi_descriptor efi_pstore cfg80211 snd cec rc_core i2c_algo_bit fb_sys_fops syscopyarea sysfillrect ucsi_acpi soundcore ccp typec_ucsi k10temp libarc
 4
[   78.209241]  sysimgblt typec dell_smo8800 dell_rbtn usbhid mac_hid sch_fq_codel parport_pc ppdev lp parport drm ip_tables x_tables autofs4 hid_generic rtsx_pci_sdmmc ahci psmouse i2c_piix4 xhci_pci libahci crc32_pclmul xhci_pci_renesas tg3 rtsx_pci i2c_hid hid wmi video i2c_amd_mp2_plat i2c_amd_mp2_pci
[   78.209277] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.9.0-050900rc1-generic #202008162130
[   78.209280] Hardware name: Dell Inc. Latitude 5495/, BIOS 1.2.14 05/29/2019
[   78.209285] RIP: 0010:dev_watchdog+0x25b/0x270
[   78.209291] Code: 85 c0 75 e5 eb 9c 4c 89 ff c6 05 9b cf 1c 01 01 e8 7a 96 fa ff 44 89 e9 4c 89 fe 48 c7 c7 b0 33 c6 b7 48 89 c2 e8 9a aa 63 ff <0f> 0b e9 7a ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f
[   78.209297] RSP: 0018:ffffb647c0344e78 EFLAGS: 00010286
[   78.209304] RAX: 0000000000000000 RBX: ffff9aa8bd97c500 RCX: 0000000000000000
[   78.209308] RDX: ffff9aa8bffe8fe0 RSI: ffff9aa8bffd8cc0 RDI: 0000000000000300
[   78.209311] RBP: ffffb647c0344ea8 R08: 0000000000000004 R09: 0000000000000576
[   78.209313] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9aa8bd97c580
[   78.209317] R13: 0000000000000000 R14: ffff9aa8bd982480 R15: ffff9aa8bd982000
[   78.209323] FS:  0000000000000000(0000) GS:ffff9aa8bffc0000(0000) knlGS:0000000000000000
[   78.209326] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.209329] CR2: 0000556136193028 CR3: 000000040d608000 CR4: 00000000003506e0
[   78.209332] Call Trace:
[   78.209336]  <IRQ>
[   78.209346]  ? pfifo_fast_enqueue+0x150/0x150
[   78.209352]  call_timer_fn+0x32/0x130
[   78.209357]  __run_timers.part.0+0x1eb/0x270
[   78.209364]  ? lapic_next_event+0x21/0x30
[   78.209369]  ? clockevents_program_event+0x8f/0xe0
[   78.209373]  run_timer_softirq+0x2a/0x50
[   78.209379]  __do_softirq+0xd0/0x2a5
[   78.209384]  asm_call_on_stack+0x12/0x20
[   78.209390]  </IRQ>
[   78.209395]  do_softirq_own_stack+0x3f/0x50
[   78.209401]  irq_exit_rcu+0x95/0xd0
[   78.209407]  sysvec_apic_timer_interrupt+0x3d/0xa0
[   78.209413]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   78.209420] RIP: 0010:cpuidle_enter_state+0xb6/0x3f0
[   78.209425] Code: 40 90 e6 48 e8 bb e5 73 ff 48 89 45 d0 0f 1f 44 00 00 31 ff e8 7b f1 73 ff 80 7d c7 00 0f 85 d1 01 00 00 fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 dd 01 00 00 49 63 d5 48 8d 04 52 48 8d 0c d5 00 00
[   78.209428] RSP: 0018:ffffb647c018fe58 EFLAGS: 00000246
[   78.209436] RAX: ffff9aa8bffec680 RBX: ffff9aa8bbda8000 RCX: 000000000000001f
[   78.209439] RDX: 0000000000000000 RSI: 000000004010731c RDI: 0000000000000000
[   78.209444] RBP: ffffb647c018fe98 R08: 00000012359f7c21 R09: 0000000000000400
[   78.209447] R10: 0000000000021f9f R11: ffff9aa8bffeb324 R12: ffffffffb8380ba0
[   78.209453] R13: 0000000000000002 R14: 0000000000000002 R15: 0000000000000000
[   78.209461]  ? cpuidle_enter_state+0xa5/0x3f0
[   78.209467]  cpuidle_enter+0x2e/0x40
[   78.209473]  cpuidle_idle_call+0x145/0x200
[   78.209479]  do_idle+0x7a/0xe0
[   78.209483]  cpu_startup_entry+0x20/0x30
[   78.209490]  start_secondary+0x90/0xa0
[   78.209498]  secondary_startup_64+0xb6/0xc0
[   78.209502] ---[ end trace dffb0c86e5614ebd ]---
[   78.209509] tg3 0000:03:00.0 enp3s0: transmit timed out, resetting
[   80.801810] tg3 0000:03:00.0 enp3s0: 0x00000000: 0x168714e4, 0x00100406, 0x02000010, 0x00000000
[   80.801841] tg3 0000:03:00.0 enp3s0: 0x00000010: 0xe022000c, 0x00000000, 0xe021000c, 0x00000000
[   80.801845] tg3 0000:03:00.0 enp3s0: 0x00000020: 0xe020000c, 0x00000000, 0x00000000, 0x08141028
[   80.801848] tg3 0000:03:00.0 enp3s0: 0x00000030: 0x00000000, 0x00000048, 0x00000000, 0x000001ff
[   80.801852] tg3 0000:03:00.0 enp3s0: 0x00000040: 0x00000000, 0x04000000, 0xc8035001, 0x16002008
[   80.801855] tg3 0000:03:00.0 enp3s0: 0x00000050: 0x00005803, 0x00000000, 0x0086a005, 0x00000000
[   80.801859] tg3 0000:03:00.0 enp3s0: 0x00000060: 0x00000000, 0x00000000, 0xf1000298, 0x01f802d1
[   80.801862] tg3 0000:03:00.0 enp3s0: 0x00000070: 0x00071010, 0xc3000600, 0x00000000, 0x00000000
[   80.801865] tg3 0000:03:00.0 enp3s0: 0x00000080: 0x168714e4, 0xc00000d0, 0x00000000, 0x00000aff
[   80.801868] tg3 0000:03:00.0 enp3s0: 0x00000090: 0x00000000, 0x00000026, 0x00000000, 0x000003cf
[   80.801871] tg3 0000:03:00.0 enp3s0: 0x000000a0: 0x8005ac11, 0x00000004, 0x00000122, 0x00020010
[   80.801875] tg3 0000:03:00.0 enp3s0: 0x000000b0: 0x10008d81, 0x00105400, 0x00475c12, 0x10120140
[   80.801882] tg3 0000:03:00.0 enp3s0: 0x000000d0: 0x0008081f, 0x00000400, 0x00000000, 0x00010001
[   80.801889] tg3 0000:03:00.0 enp3s0: 0x000000f0: 0x00000000, 0x05762100, 0x00000000, 0xffffffff
[   80.801898] tg3 0000:03:00.0 enp3s0: 0x00000100: 0x13c10001, 0x00000000, 0x00000000, 0x00062030
[   80.801905] tg3 0000:03:00.0 enp3s0: 0x00000110: 0x00000000, 0x00002000, 0x000000a0, 0x00000000
[   80.801910] tg3 0000:03:00.0 enp3s0: 0x00000130: 0x00000000, 0x00000000, 0x00000000, 0x15010003
[   80.801914] tg3 0000:03:00.0 enp3s0: 0x00000140: 0xc85b6574, 0x0000a44c, 0x00000000, 0x00000000
[   80.801917] tg3 0000:03:00.0 enp3s0: 0x00000150: 0x16010004, 0x00000000, 0x00078116, 0x00000001
[   80.801920] tg3 0000:03:00.0 enp3s0: 0x00000160: 0x1b010002, 0x00000000, 0x00000000, 0x00000000
[   80.801923] tg3 0000:03:00.0 enp3s0: 0x00000170: 0x00000000, 0x800000ff, 0x00000000, 0x00000000
[   80.801930] tg3 0000:03:00.0 enp3s0: 0x000001b0: 0x23010018, 0x10011001, 0x00000000, 0x00000000
[   80.801934] tg3 0000:03:00.0 enp3s0: 0x00000200: 0x00000000, 0x04000000, 0x00000000, 0x81000000
[   80.801938] tg3 0000:03:00.0 enp3s0: 0x00000210: 0x00000000, 0x17000000, 0x00000000, 0x2b000000
[   80.801943] tg3 0000:03:00.0 enp3s0: 0x00000260: 0x00000000, 0x00000000, 0x00000000, 0x000003cf
[   80.801947] tg3 0000:03:00.0 enp3s0: 0x00000280: 0x00000000, 0x00000aff, 0x00000000, 0x000007f7
[   80.801951] tg3 0000:03:00.0 enp3s0: 0x00000290: 0x00000000, 0x00000813, 0x00000000, 0x000007fe
[   80.801955] tg3 0000:03:00.0 enp3s0: 0x00000300: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801958] tg3 0000:03:00.0 enp3s0: 0x00000310: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801962] tg3 0000:03:00.0 enp3s0: 0x00000320: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801966] tg3 0000:03:00.0 enp3s0: 0x00000330: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801971] tg3 0000:03:00.0 enp3s0: 0x00000340: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801975] tg3 0000:03:00.0 enp3s0: 0x00000350: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801979] tg3 0000:03:00.0 enp3s0: 0x00000360: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801984] tg3 0000:03:00.0 enp3s0: 0x00000370: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801988] tg3 0000:03:00.0 enp3s0: 0x00000380: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801992] tg3 0000:03:00.0 enp3s0: 0x00000390: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.801997] tg3 0000:03:00.0 enp3s0: 0x000003a0: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.802002] tg3 0000:03:00.0 enp3s0: 0x000003b0: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.802006] tg3 0000:03:00.0 enp3s0: 0x000003c0: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.802010] tg3 0000:03:00.0 enp3s0: 0x000003d0: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.802014] tg3 0000:03:00.0 enp3s0: 0x000003e0: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.802018] tg3 0000:03:00.0 enp3s0: 0x000003f0: 0x00000000, 0x00000026, 0x00000000, 0x00000026
[   80.802022] tg3 0000:03:00.0 enp3s0: 0x00000400: 0x18e04808, 0x00400000, 0x00001000, 0x00009b00
[   80.802031] tg3 0000:03:00.0 enp3s0: 0x00000410: 0x0000a44c, 0xc85b6574, 0x0000a44c, 0xc85b6574
[   80.802037] tg3 0000:03:00.0 enp3s0: 0x00000420: 0x0000a44c, 0xc85b6574, 0x0000a44c, 0xc85b6574
[   80.802046] tg3 0000:03:00.0 enp3s0: 0x00000430: 0x00000000, 0x00000000, 0x0000012a, 0x000005f2
[   80.802053] tg3 0000:03:00.0 enp3s0: 0x00000440: 0x00000000, 0x00000000, 0x00000000, 0x082e0006
[   80.802060] tg3 0000:03:00.0 enp3s0: 0x00000450: 0x00000001, 0x00008000, 0x00000000, 0x00000112
[   80.802069] tg3 0000:03:00.0 enp3s0: 0x00000460: 0x0000000b, 0x00002620, 0x03ff0006, 0x00000000
[   80.802076] tg3 0000:03:00.0 enp3s0: 0x00000470: 0xa0000000, 0x00000000, 0x00000400, 0x50000000
[   80.802085] tg3 0000:03:00.0 enp3s0: 0x00000480: 0x42000000, 0x7fffffff, 0x06000004, 0x7fffffff
[   80.802092] tg3 0000:03:00.0 enp3s0: 0x00000500: 0x00000008, 0x00000002, 0x00000000, 0x00000000
[   80.802098] tg3 0000:03:00.0 enp3s0: 0x00000590: 0x00901001, 0x00000000, 0x00000000, 0x00000000
[   80.802102] tg3 0000:03:00.0 enp3s0: 0x00000600: 0xffffffff, 0x00f80011, 0x00000000, 0x40001f0c
[   80.802107] tg3 0000:03:00.0 enp3s0: 0x00000610: 0xffffffff, 0x00000000, 0x00000044, 0x00000000
[   80.802112] tg3 0000:03:00.0 enp3s0: 0x00000620: 0x00000040, 0x00000000, 0x00000000, 0x00000000
[   80.802116] tg3 0000:03:00.0 enp3s0: 0x00000630: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[   80.802120] tg3 0000:03:00.0 enp3s0: 0x00000640: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[   80.802125] tg3 0000:03:00.0 enp3s0: 0x00000650: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[   80.802129] tg3 0000:03:00.0 enp3s0: 0x00000660: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[   80.802133] tg3 0000:03:00.0 enp3s0: 0x00000670: 0xaa6fcb8c, 0x17828d91, 0xe68b709a, 0x8f49e46e
[   80.802137] tg3 0000:03:00.0 enp3s0: 0x00000680: 0x0122a580, 0xb1f47e2a, 0x5fc1683c, 0x0db6cfc9
[   80.802141] tg3 0000:03:00.0 enp3s0: 0x00000690: 0xd201e2b4, 0xcb1c837d, 0x00000000, 0x00000000
[   80.802147] tg3 0000:03:00.0 enp3s0: 0x000006c0: 0x00000000, 0x00000000, 0x04000000, 0x00000000
[   80.802152] tg3 0000:03:00.0 enp3s0: 0x00000800: 0x00000000, 0xffffffff, 0x00000000, 0x00000000
[   80.802156] tg3 0000:03:00.0 enp3s0: 0x00000810: 0x00000000, 0xffffffff, 0x00000000, 0x00000000
[   80.802160] tg3 0000:03:00.0 enp3s0: 0x00000820: 0x00000000, 0x00000000, 0xffffffff, 0x00000000
[   80.802164] tg3 0000:03:00.0 enp3s0: 0x00000830: 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
[   80.802168] tg3 0000:03:00.0 enp3s0: 0x00000840: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[   80.802172] tg3 0000:03:00.0 enp3s0: 0x00000850: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[   80.802176] tg3 0000:03:00.0 enp3s0: 0x00000860: 0xffffffff, 0xffffffff, 0xffffffff, 0x00000000
[   80.802181] tg3 0000:03:00.0 enp3s0: 0x000008f0: 0x00000001, 0x00000000, 0x00000000, 0x00000000
[   80.802184] tg3 0000:03:00.0 enp3s0: 0x00000900: 0x0008d22f, 0xffffffff, 0x00000000, 0x00000000
[   80.802187] tg3 0000:03:00.0 enp3s0: 0x00000910: 0x0000001b, 0xffffffff, 0x00000000, 0x00000000
[   80.802192] tg3 0000:03:00.0 enp3s0: 0x00000920: 0x00000000, 0x00000000, 0xffffffff, 0x00000000
[   80.802196] tg3 0000:03:00.0 enp3s0: 0x00000930: 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
[   80.802200] tg3 0000:03:00.0 enp3s0: 0x00000940: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[   80.802204] tg3 0000:03:00.0 enp3s0: 0x00000950: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[   80.802208] tg3 0000:03:00.0 enp3s0: 0x00000960: 0xffffffff, 0xffffffff, 0xffffffff, 0x00001bd1
[   80.802212] tg3 0000:03:00.0 enp3s0: 0x00000970: 0x0000001e, 0x00000004, 0x00000000, 0x00000000
[   80.802216] tg3 0000:03:00.0 enp3s0: 0x00000980: 0x01042732, 0x00000000, 0x00000000, 0x00002c92
[   80.802220] tg3 0000:03:00.0 enp3s0: 0x00000990: 0x00000052, 0x00000013, 0x00000000, 0x00000000
[   80.802226] tg3 0000:03:00.0 enp3s0: 0x00000c00: 0x0000000a, 0x00000000, 0x00000003, 0x00000001
[   80.802232] tg3 0000:03:00.0 enp3s0: 0x00000c10: 0x00000000, 0x00000000, 0x00000000, 0x005f0000
[   80.802239] tg3 0000:03:00.0 enp3s0: 0x00000c80: 0x00001bf3, 0x00000000, 0x00000000, 0x00000000
[   80.802247] tg3 0000:03:00.0 enp3s0: 0x00000ce0: 0xffdfd402, 0x00000000, 0x0000005f, 0x00041028
[   80.802254] tg3 0000:03:00.0 enp3s0: 0x00000cf0: 0x00000000, 0x50000026, 0x00000000, 0x00000000
[   80.802262] tg3 0000:03:00.0 enp3s0: 0x00001000: 0x00000002, 0x00000000, 0xa000c7c8, 0x00000000
[   80.802270] tg3 0000:03:00.0 enp3s0: 0x00001010: 0x00260261, 0x0000c7c8, 0x00000000, 0x00000000
[   80.802278] tg3 0000:03:00.0 enp3s0: 0x00001400: 0x00000006, 0x00000000, 0x00000000, 0x00000001
[   80.802286] tg3 0000:03:00.0 enp3s0: 0x00001440: 0x00000026, 0x00000026, 0x00000026, 0x00000026
[   80.802293] tg3 0000:03:00.0 enp3s0: 0x00001450: 0x00000026, 0x00000026, 0x00000026, 0x00000026
[   80.802297] tg3 0000:03:00.0 enp3s0: 0x00001460: 0x00000026, 0x00000026, 0x00000026, 0x00000026
[   80.802301] tg3 0000:03:00.0 enp3s0: 0x00001470: 0x00000026, 0x00000026, 0x00000026, 0x00000026
[   80.802306] tg3 0000:03:00.0 enp3s0: 0x00001800: 0x00000016, 0x00000000, 0x00000026, 0x00000000
[   80.802311] tg3 0000:03:00.0 enp3s0: 0x00001840: 0x00000000, 0x00000000, 0x00000200, 0x00000010
[   80.802315] tg3 0000:03:00.0 enp3s0: 0x00001850: 0x0000001f, 0x00000000, 0x00004250, 0x00260026
[   80.802319] tg3 0000:03:00.0 enp3s0: 0x00001860: 0x01000000, 0x00000000, 0x00000000, 0x00000000
[   80.802323] tg3 0000:03:00.0 enp3s0: 0x00001c00: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[   80.802328] tg3 0000:03:00.0 enp3s0: 0x00002000: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[   80.802332] tg3 0000:03:00.0 enp3s0: 0x00002010: 0x00000181, 0x00000001, 0x007bfffd, 0x00000000
[   80.802336] tg3 0000:03:00.0 enp3s0: 0x00002100: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802341] tg3 0000:03:00.0 enp3s0: 0x00002110: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802345] tg3 0000:03:00.0 enp3s0: 0x00002120: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802349] tg3 0000:03:00.0 enp3s0: 0x00002130: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802354] tg3 0000:03:00.0 enp3s0: 0x00002140: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802359] tg3 0000:03:00.0 enp3s0: 0x00002150: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802362] tg3 0000:03:00.0 enp3s0: 0x00002160: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802366] tg3 0000:03:00.0 enp3s0: 0x00002170: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802371] tg3 0000:03:00.0 enp3s0: 0x00002180: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802375] tg3 0000:03:00.0 enp3s0: 0x00002190: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802379] tg3 0000:03:00.0 enp3s0: 0x000021a0: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802383] tg3 0000:03:00.0 enp3s0: 0x000021b0: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802392] tg3 0000:03:00.0 enp3s0: 0x000021c0: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802398] tg3 0000:03:00.0 enp3s0: 0x000021d0: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802406] tg3 0000:03:00.0 enp3s0: 0x000021e0: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802413] tg3 0000:03:00.0 enp3s0: 0x000021f0: 0x000dff0b, 0x000c4e33, 0x00000007, 0x00000000
[   80.802420] tg3 0000:03:00.0 enp3s0: 0x00002200: 0x00002320, 0x00000000, 0x00000000, 0x00000000
[   80.802440] tg3 0000:03:00.0 enp3s0: 0x00002250: 0x000009d7, 0x00000000, 0x00000000, 0x00000000
[   80.802446] tg3 0000:03:00.0 enp3s0: 0x00002400: 0x00010012, 0x00000000, 0x00000000, 0x00000000
[   80.802450] tg3 0000:03:00.0 enp3s0: 0x00002440: 0x00000000, 0x00000000, 0x00000002, 0x00000000
[   80.802454] tg3 0000:03:00.0 enp3s0: 0x00002450: 0x00000000, 0xfffe0000, 0x08001800, 0x00006000
[   80.802459] tg3 0000:03:00.0 enp3s0: 0x00002470: 0x00000000, 0x00000313, 0x00000000, 0x00000000
[   80.802463] tg3 0000:03:00.0 enp3s0: 0x000024c0: 0x02015101, 0x00000000, 0x00000000, 0x00000000
[   80.802467] tg3 0000:03:00.0 enp3s0: 0x00002800: 0x00000006, 0x00000000, 0x00000000, 0x00000000
[   80.802472] tg3 0000:03:00.0 enp3s0: 0x00002c00: 0x00000006, 0x00000000, 0x00000000, 0x00000389
[   80.802476] tg3 0000:03:00.0 enp3s0: 0x00002c10: 0x00000000, 0x00000000, 0x00000019, 0x0000000c
[   80.802480] tg3 0000:03:00.0 enp3s0: 0x00002c20: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[   80.802484] tg3 0000:03:00.0 enp3s0: 0x00002d00: 0x00000080, 0x00000040, 0x00000000, 0x00000000
[   80.802490] tg3 0000:03:00.0 enp3s0: 0x00003000: 0x00000006, 0x00000000, 0x00000000, 0x00000389
[   80.802494] tg3 0000:03:00.0 enp3s0: 0x00003600: 0x00134400, 0x00130000, 0x00110000, 0x00000000
[   80.802498] tg3 0000:03:00.0 enp3s0: 0x00003610: 0x00131100, 0x00130000, 0x00130000, 0x00000000
[   80.802503] tg3 0000:03:00.0 enp3s0: 0x00003620: 0x80110011, 0x00000000, 0x00002004, 0x3c822080
[   80.802511] tg3 0000:03:00.0 enp3s0: 0x00003630: 0x00000000, 0x80008000, 0x00001080, 0x00000000
[   80.802517] tg3 0000:03:00.0 enp3s0: 0x00003640: 0x0000000a, 0x33f00003, 0x00000020, 0x00000019
[   80.802525] tg3 0000:03:00.0 enp3s0: 0x00003650: 0x00000171, 0x00000bff, 0x05762100, 0x00000000
[   80.802534] tg3 0000:03:00.0 enp3s0: 0x00003660: 0x00000000, 0x00000000, 0x000400a3, 0x00000202
[   80.802543] tg3 0000:03:00.0 enp3s0: 0x00003670: 0x0000002a, 0xfeffff63, 0x0000000a, 0x00000000
[   80.802547] tg3 0000:03:00.0 enp3s0: 0x000036b0: 0x001003cc, 0x07ff07ff, 0x07ff07ff, 0x01000004
[   80.802551] tg3 0000:03:00.0 enp3s0: 0x000036c0: 0xffffffff, 0x000004d1, 0x00000529, 0x0000052c
[   80.802557] tg3 0000:03:00.0 enp3s0: 0x000036d0: 0x0000019d, 0x00000000, 0x00000000, 0x00000000
[   80.802561] tg3 0000:03:00.0 enp3s0: 0x000036e0: 0x80000b19, 0xa0800799, 0x00500799, 0x00000000
[   80.802565] tg3 0000:03:00.0 enp3s0: 0x000036f0: 0x19090900, 0x13180600, 0x00000301, 0x00000001
[   80.802569] tg3 0000:03:00.0 enp3s0: 0x00003700: 0x00000000, 0x00000000, 0x00000000, 0x00001388
[   80.802576] tg3 0000:03:00.0 enp3s0: 0x00003710: 0x87fffffd, 0x00000000, 0x00000000, 0x000010dc
[   80.802585] tg3 0000:03:00.0 enp3s0: 0x00003720: 0x00000000, 0x00002040, 0x88006000, 0xa0002000
[   80.802589] tg3 0000:03:00.0 enp3s0: 0x00003750: 0x00000000, 0x00000000, 0x0000080c, 0x00000000
[   80.802593] tg3 0000:03:00.0 enp3s0: 0x00003780: 0x0000b7f9, 0x00000000, 0x00000000, 0x00000000
[   80.802598] tg3 0000:03:00.0 enp3s0: 0x00003c00: 0x00000306, 0x00000000, 0x00000000, 0x00000048
[   80.802603] tg3 0000:03:00.0 enp3s0: 0x00003c10: 0x00000000, 0x00000035, 0x00000000, 0x00000000
[   80.802608] tg3 0000:03:00.0 enp3s0: 0x00003c20: 0x00000000, 0x00000005, 0x00000000, 0x00000000
[   80.802615] tg3 0000:03:00.0 enp3s0: 0x00003c30: 0x00000000, 0x00000000, 0x00000000, 0xffffc000
[   80.802622] tg3 0000:03:00.0 enp3s0: 0x00003c40: 0x00000000, 0x00000b00, 0x00000000, 0x00000000
[   80.802626] tg3 0000:03:00.0 enp3s0: 0x00003c50: 0x00000000, 0x00000309, 0x00000000, 0x00000000
[   80.802630] tg3 0000:03:00.0 enp3s0: 0x00003c80: 0x00000aff, 0x000007f7, 0x00000813, 0x00000800
[   80.802634] tg3 0000:03:00.0 enp3s0: 0x00003cc0: 0x00000026, 0x00000000, 0x00000000, 0x00000000
[   80.802639] tg3 0000:03:00.0 enp3s0: 0x00003cd0: 0x00000000, 0x0000000f, 0x00000000, 0x00000000
[   80.802645] tg3 0000:03:00.0 enp3s0: 0x00003d00: 0x00000000, 0xffffb000, 0x00000000, 0xffffa000
[   80.802649] tg3 0000:03:00.0 enp3s0: 0x00003d10: 0x00000000, 0xffff9000, 0x00000000, 0xffff8000
[   80.802655] tg3 0000:03:00.0 enp3s0: 0x00003d80: 0x00000014, 0x00000000, 0x00000005, 0x00000000
[   80.802660] tg3 0000:03:00.0 enp3s0: 0x00003d90: 0x00000005, 0x00000000, 0x00000014, 0x00000000
[   80.802668] tg3 0000:03:00.0 enp3s0: 0x00003da0: 0x00000005, 0x00000000, 0x00000005, 0x00000000
[   80.802672] tg3 0000:03:00.0 enp3s0: 0x00003db0: 0x00000014, 0x00000000, 0x00000005, 0x00000000
[   80.802677] tg3 0000:03:00.0 enp3s0: 0x00003dc0: 0x00000005, 0x00000000, 0x00000014, 0x00000000
[   80.802684] tg3 0000:03:00.0 enp3s0: 0x00003dd0: 0x00000005, 0x00000000, 0x00000005, 0x00000000
[   80.802688] tg3 0000:03:00.0 enp3s0: 0x00004000: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[   80.802694] tg3 0000:03:00.0 enp3s0: 0x00004010: 0x00000000, 0x00233012, 0x008004f0, 0x01004c22
[   80.802701] tg3 0000:03:00.0 enp3s0: 0x00004020: 0x00000000, 0x00000010, 0x00000010, 0x00000050
[   80.802705] tg3 0000:03:00.0 enp3s0: 0x00004030: 0x00000000, 0x01084a20, 0x00248010, 0x00000002
[   80.802714] tg3 0000:03:00.0 enp3s0: 0x00004040: 0x00400000, 0x00000000, 0x00000010, 0x004c7062
[   80.802718] tg3 0000:03:00.0 enp3s0: 0x00004400: 0x00000016, 0x00000000, 0x00010000, 0x0000a000
[   80.802723] tg3 0000:03:00.0 enp3s0: 0x00004410: 0x00000000, 0x0000002a, 0x000000a0, 0x00000000
[   80.802731] tg3 0000:03:00.0 enp3s0: 0x00004420: 0x000000fd, 0x00000000, 0x00000000, 0x00000000
[   80.802735] tg3 0000:03:00.0 enp3s0: 0x00004440: 0x00000000, 0x00000000, 0x00000000, 0x0c7320ca
[   80.802742] tg3 0000:03:00.0 enp3s0: 0x00004450: 0x02580214, 0x00490035, 0x00000000, 0x00000000
[   80.802746] tg3 0000:03:00.0 enp3s0: 0x00004700: 0x00030002, 0x00100000, 0x00100010, 0x22940000
[   80.802752] tg3 0000:03:00.0 enp3s0: 0x00004710: 0xffff6230, 0x00065494, 0x00100012, 0x00000000
[   80.802758] tg3 0000:03:00.0 enp3s0: 0x00004720: 0x00000000, 0x00000010, 0xf02c0000, 0xffff6260
[   80.802762] tg3 0000:03:00.0 enp3s0: 0x00004770: 0x000c0404, 0x00000002, 0x00000010, 0x00000000
[   80.802766] tg3 0000:03:00.0 enp3s0: 0x00004800: 0x380303fe, 0x00000000, 0x00000000, 0x00000100
[   80.802770] tg3 0000:03:00.0 enp3s0: 0x00004810: 0x00000000, 0x00000009, 0x05a89f80, 0x00000000
[   80.802774] tg3 0000:03:00.0 enp3s0: 0x00004820: 0x000000a9, 0x00000000, 0x00000000, 0x00000000
[   80.802779] tg3 0000:03:00.0 enp3s0: 0x00004860: 0x000000a9, 0x11c00000, 0x001ff800, 0x5f000008
[   80.802785] tg3 0000:03:00.0 enp3s0: 0x00004870: 0x05ea0080, 0x003e1820, 0x003e1820, 0x00000000
[   80.802792] tg3 0000:03:00.0 enp3s0: 0x00004890: 0x280c0c04, 0x00305400, 0x00000000, 0x00000000
[   80.802796] tg3 0000:03:00.0 enp3s0: 0x000048a0: 0x000f0010, 0x00000000, 0x00000000, 0x00000000
[   80.802801] tg3 0000:03:00.0 enp3s0: 0x00004900: 0x18030002, 0x00000003, 0x30000000, 0x00000120
[   80.802806] tg3 0000:03:00.0 enp3s0: 0x00004910: 0x00000040, 0x00000003, 0x0000df98, 0x00000010
[   80.802810] tg3 0000:03:00.0 enp3s0: 0x00004920: 0x000000c9, 0x02638000, 0xffcff201, 0x0f000068
[   80.802817] tg3 0000:03:00.0 enp3s0: 0x00004930: 0xffdfd401, 0x0f000068, 0xff98fe01, 0x0f000068
[   80.802821] tg3 0000:03:00.0 enp3s0: 0x00004940: 0xffc18401, 0x0f000098, 0xc6c69d9d, 0x56563434
[   80.802825] tg3 0000:03:00.0 enp3s0: 0x00004950: 0xf0330000, 0xffcff268, 0xaf000000, 0xc9c700c8
[   80.802833] tg3 0000:03:00.0 enp3s0: 0x00004960: 0x00000000, 0xffdfd468, 0xaf000000, 0x40000026
[   80.802839] tg3 0000:03:00.0 enp3s0: 0x00004970: 0x00028202, 0x00205400, 0x0000001c, 0x000000ff
[   80.802843] tg3 0000:03:00.0 enp3s0: 0x00004980: 0x000000c9, 0x00000000, 0x00000000, 0x00000000
[   80.802848] tg3 0000:03:00.0 enp3s0: 0x00004990: 0x00000000, 0x00000000, 0xff98fe68, 0xaf000000
[   80.802853] tg3 0000:03:00.0 enp3s0: 0x000049a0: 0x00f000b6, 0x000000c9, 0x00000000, 0x00000000
[   80.802859] tg3 0000:03:00.0 enp3s0: 0x000049b0: 0xffd8c801, 0xffc66001, 0xff7da201, 0xffbdfe01
[   80.802863] tg3 0000:03:00.0 enp3s0: 0x000049c0: 0xffcff202, 0xffdfd402, 0xff98fe02, 0xffc18402
[   80.802869] tg3 0000:03:00.0 enp3s0: 0x000049d0: 0xffd8c802, 0xffc66002, 0xff7da202, 0xffbdfe02
[   80.802874] tg3 0000:03:00.0 enp3s0: 0x000049f0: 0xf0330000, 0xffc18498, 0xaf000000, 0x0000ffff
[   80.802881] tg3 0000:03:00.0 enp3s0: 0x00004c00: 0x200003fe, 0x00000020, 0x00000000, 0x00000000
[   80.802888] tg3 0000:03:00.0 enp3s0: 0x00004c10: 0x00000015, 0x00000000, 0x00000006, 0x00000000
[   80.802892] tg3 0000:03:00.0 enp3s0: 0x00004c20: 0x00000000, 0x00000000, 0x00000000, 0x00000006
[   80.802899] tg3 0000:03:00.0 enp3s0: 0x00004c30: 0x00000000, 0x002bfc00, 0x000000a0, 0x000000a0
[   80.802903] tg3 0000:03:00.0 enp3s0: 0x00004c40: 0x00000000, 0x07f70000, 0x07ff0813, 0x07f60afe
[   80.802907] tg3 0000:03:00.0 enp3s0: 0x00004c50: 0x07ff0812, 0x03080fff, 0xc0000000, 0xff090404
[   80.802914] tg3 0000:03:00.0 enp3s0: 0x00004c60: 0x00000020, 0x00000000, 0x00000000, 0x00000000
[   80.802919] tg3 0000:03:00.0 enp3s0: 0x00005000: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[   80.802925] tg3 0000:03:00.0 enp3s0: 0x00005010: 0x00000000, 0x00000000, 0x00000000, 0x080012c8
[   80.802932] tg3 0000:03:00.0 enp3s0: 0x00005020: 0x00021502, 0x00000000, 0x00000000, 0x40000020
[   80.802936] tg3 0000:03:00.0 enp3s0: 0x00005030: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.802942] tg3 0000:03:00.0 enp3s0: 0x00005040: 0x00000000, 0x00000000, 0x080011f0, 0x00000000
[   80.802946] tg3 0000:03:00.0 enp3s0: 0x00005080: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[   80.802952] tg3 0000:03:00.0 enp3s0: 0x00005090: 0x00000000, 0x00000000, 0x00000000, 0x080000f8
[   80.802959] tg3 0000:03:00.0 enp3s0: 0x000050a0: 0x00a42824, 0x00000000, 0x00000000, 0x40000020
[   80.802965] tg3 0000:03:00.0 enp3s0: 0x000050b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.802972] tg3 0000:03:00.0 enp3s0: 0x000050c0: 0x00000000, 0x00000000, 0x08000e1c, 0x00000000
[   80.802978] tg3 0000:03:00.0 enp3s0: 0x00005100: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[   80.802983] tg3 0000:03:00.0 enp3s0: 0x00005110: 0x00000000, 0x00000000, 0x00000000, 0x080002f8
[   80.802989] tg3 0000:03:00.0 enp3s0: 0x00005120: 0x00000000, 0x00000000, 0x00000000, 0x40000020
[   80.802995] tg3 0000:03:00.0 enp3s0: 0x00005130: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.803000] tg3 0000:03:00.0 enp3s0: 0x00005140: 0x00000000, 0x00000000, 0x080012b4, 0x00000000
[   80.803008] tg3 0000:03:00.0 enp3s0: 0x00005180: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[   80.803014] tg3 0000:03:00.0 enp3s0: 0x00005190: 0x00000000, 0x00000000, 0x00000000, 0x08000c88
[   80.803019] tg3 0000:03:00.0 enp3s0: 0x000051a0: 0x00021502, 0x00000000, 0x00000000, 0x40000020
[   80.803025] tg3 0000:03:00.0 enp3s0: 0x000051b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.803030] tg3 0000:03:00.0 enp3s0: 0x000051c0: 0x00000000, 0x00000000, 0x080011f0, 0x00000000
[   80.803036] tg3 0000:03:00.0 enp3s0: 0x00005200: 0x00000000, 0xc0000000, 0x54000003, 0x00000000
[   80.803042] tg3 0000:03:00.0 enp3s0: 0x00005210: 0x3c038000, 0x00000000, 0x00000000, 0x3c038000
[   80.803048] tg3 0000:03:00.0 enp3s0: 0x00005220: 0xc0000000, 0x00000000, 0x3c038000, 0x00000000
[   80.803055] tg3 0000:03:00.0 enp3s0: 0x00005230: 0x00000000, 0x00010000, 0x08007f58, 0x00000000
[   80.803061] tg3 0000:03:00.0 enp3s0: 0x00005240: 0xc0010000, 0x01120010, 0x00000000, 0x14830018
[   80.803067] tg3 0000:03:00.0 enp3s0: 0x00005250: 0x00000b50, 0x20000000, 0x14830018, 0x01120010
[   80.803072] tg3 0000:03:00.0 enp3s0: 0x00005260: 0x08001000, 0x14830018, 0xb49a89ab, 0x00000000
[   80.803077] tg3 0000:03:00.0 enp3s0: 0x00005270: 0xc0000000, 0x00000000, 0x00010000, 0x00000000
[   80.803082] tg3 0000:03:00.0 enp3s0: 0x00005280: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[   80.803086] tg3 0000:03:00.0 enp3s0: 0x00005290: 0x00000000, 0x00000000, 0x00000000, 0x08001024
[   80.803091] tg3 0000:03:00.0 enp3s0: 0x000052a0: 0x8c850004, 0x00000000, 0x00000000, 0x40000020
[   80.803098] tg3 0000:03:00.0 enp3s0: 0x000052b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.803102] tg3 0000:03:00.0 enp3s0: 0x000052c0: 0x00000000, 0x00000000, 0x08001510, 0x00000000
[   80.803106] tg3 0000:03:00.0 enp3s0: 0x00005300: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[   80.803112] tg3 0000:03:00.0 enp3s0: 0x00005310: 0x00000000, 0x00000000, 0x00000000, 0x08001c84
[   80.803117] tg3 0000:03:00.0 enp3s0: 0x00005320: 0x3c020018, 0x00000000, 0x00000000, 0x40000020
[   80.803121] tg3 0000:03:00.0 enp3s0: 0x00005330: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.803126] tg3 0000:03:00.0 enp3s0: 0x00005340: 0x00000000, 0x00000000, 0x08000110, 0x00000000
[   80.803133] tg3 0000:03:00.0 enp3s0: 0x00005380: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[   80.803137] tg3 0000:03:00.0 enp3s0: 0x00005390: 0x00000000, 0x00000000, 0x00000000, 0x08001204
[   80.803144] tg3 0000:03:00.0 enp3s0: 0x000053a0: 0x02308824, 0x00000000, 0x00000000, 0x40000020
[   80.803150] tg3 0000:03:00.0 enp3s0: 0x000053b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[   80.803154] tg3 0000:03:00.0 enp3s0: 0x000053c0: 0x00000000, 0x00000000, 0x08000300, 0x00000000
[   80.803161] tg3 0000:03:00.0 enp3s0: 0x00005800: 0x00000000, 0x04000000, 0x00000000, 0x81000000
[   80.803165] tg3 0000:03:00.0 enp3s0: 0x00005810: 0x00000000, 0x17000000, 0x00000000, 0x2b000000
[   80.803170] tg3 0000:03:00.0 enp3s0: 0x00005860: 0x00000000, 0x00000000, 0x00000000, 0x000003cf
[   80.803174] tg3 0000:03:00.0 enp3s0: 0x00005880: 0x00000000, 0x00000aff, 0x00000000, 0x000007f7
[   80.803180] tg3 0000:03:00.0 enp3s0: 0x00005890: 0x00000000, 0x00000813, 0x00000000, 0x000007fe
[   80.803184] tg3 0000:03:00.0 enp3s0: 0x00005900: 0x00000000, 0x00000026, 0x00000000, 0x00000000
[   80.803189] tg3 0000:03:00.0 enp3s0: 0x00005980: 0x00000026, 0x00000000, 0x00000000, 0x00000000
[   80.803195] tg3 0000:03:00.0 enp3s0: 0x00005a00: 0x000f601f, 0x00000000, 0x00010000, 0x00000000
[   80.803202] tg3 0000:03:00.0 enp3s0: 0x00006000: 0x20010082, 0x00000000, 0x00000000, 0x00000000
[   80.803209] tg3 0000:03:00.0 enp3s0: 0x00006400: 0x00000000, 0x00000000, 0x00010091, 0xc0000000
[   80.803214] tg3 0000:03:00.0 enp3s0: 0x00006410: 0x05000016, 0x05000016, 0x00000000, 0x00000000
[   80.803219] tg3 0000:03:00.0 enp3s0: 0x00006430: 0x00000000, 0x14e41687, 0x08141028, 0x10020000
[   80.803226] tg3 0000:03:00.0 enp3s0: 0x00006440: 0x0000304f, 0x000002e4, 0x00000000, 0x00000060
[   80.803230] tg3 0000:03:00.0 enp3s0: 0x000064c0: 0x00000005, 0x00000004, 0x00000122, 0x00000000
[   80.803236] tg3 0000:03:00.0 enp3s0: 0x000064d0: 0x00000040, 0x10008d81, 0x00000000, 0x00d75e12
[   80.803242] tg3 0000:03:00.0 enp3s0: 0x000064e0: 0x00000031, 0x0008001f, 0x00000000, 0x00000000
[   80.803248] tg3 0000:03:00.0 enp3s0: 0x000064f0: 0x00000002, 0x00000031, 0x00000000, 0x00000000
[   80.803254] tg3 0000:03:00.0 enp3s0: 0x00006500: 0x03e10003, 0xc85b6574, 0x0000a44c, 0x00000003
[   80.803260] tg3 0000:03:00.0 enp3s0: 0x00006510: 0x00078116, 0x0005810b, 0x00046105, 0x00000000
[   80.803265] tg3 0000:03:00.0 enp3s0: 0x00006530: 0x00000001, 0x00000000, 0x00000000, 0x00000000
[   80.803271] tg3 0000:03:00.0 enp3s0: 0x00006540: 0x0028081f, 0x0001001e, 0x00000000, 0x00000000
[   80.803276] tg3 0000:03:00.0 enp3s0: 0x00006550: 0x00000001, 0x02800000, 0x0000000f, 0x00000000
[   80.803282] tg3 0000:03:00.0 enp3s0: 0x00006560: 0x0000000f, 0x00000000, 0x00000000, 0x00000000
[   80.803289] tg3 0000:03:00.0 enp3s0: 0x000065f0: 0x00000000, 0x00000059, 0x00000000, 0x00000000
[   80.803295] tg3 0000:03:00.0 enp3s0: 0x00006800: 0x141b0034, 0x20081082, 0x00089418, 0x047fb787
[   80.803301] tg3 0000:03:00.0 enp3s0: 0x00006810: 0x01120010, 0xffffffff, 0x00000000, 0x00000040
[   80.803307] tg3 0000:03:00.0 enp3s0: 0x00006880: 0x77fff020, 0x00000040, 0x00801687, 0x00000000
[   80.803313] tg3 0000:03:00.0 enp3s0: 0x00006890: 0x00800000, 0x00000000, 0x00000000, 0x00000000
[   80.803319] tg3 0000:03:00.0 enp3s0: 0x000068a0: 0x00000000, 0x00010001, 0x00000000, 0x00000000
[   80.803325] tg3 0000:03:00.0 enp3s0: 0x000068b0: 0x00040000, 0x00000000, 0x00000000, 0x00000000
[   80.803331] tg3 0000:03:00.0 enp3s0: 0x000068c0: 0x00000044, 0x00000000, 0x00000000, 0x00000000
[   80.803335] tg3 0000:03:00.0 enp3s0: 0x000068f0: 0x00000000, 0x00000000, 0x00000000, 0x04444444
[   80.803341] tg3 0000:03:00.0 enp3s0: 0x00006900: 0x27a6f1d8, 0x162de7aa, 0x00000000, 0x00000000
[   80.803346] tg3 0000:03:00.0 enp3s0: 0x00006920: 0x00000000, 0x00000000, 0x00000001, 0x00000000
[   80.803352] tg3 0000:03:00.0 enp3s0: 0x00006c00: 0x168714e4, 0x00100406, 0x02000010, 0x00000000
[   80.803358] tg3 0000:03:00.0 enp3s0: 0x00006c10: 0xe022000c, 0x00000000, 0xe021000c, 0x00000000
[   80.803363] tg3 0000:03:00.0 enp3s0: 0x00006c20: 0xe020000c, 0x00000000, 0x00000000, 0x08141028
[   80.803371] tg3 0000:03:00.0 enp3s0: 0x00006c30: 0x00000000, 0x00000048, 0x00000000, 0x000001ff
[   80.803376] tg3 0000:03:00.0 enp3s0: 0x00006c40: 0x00000000, 0x00000000, 0xc8035001, 0x16002008
[   80.803382] tg3 0000:03:00.0 enp3s0: 0x00006c50: 0x00005803, 0x00000000, 0x0086a005, 0x00000000
[   80.803389] tg3 0000:03:00.0 enp3s0: 0x00006c60: 0x00000000, 0x00000000, 0xf1000298, 0x01f802d1
[   80.803394] tg3 0000:03:00.0 enp3s0: 0x00006c70: 0x00071010, 0xc3000600, 0x00000000, 0x00000000
[   80.803398] tg3 0000:03:00.0 enp3s0: 0x00006ca0: 0x8005ac11, 0x00000004, 0x00000122, 0x00020010
[   80.803404] tg3 0000:03:00.0 enp3s0: 0x00006cb0: 0x10008d81, 0x00105400, 0x00475c12, 0x10120140
[   80.803408] tg3 0000:03:00.0 enp3s0: 0x00006cd0: 0x0008081f, 0x00000400, 0x00000000, 0x00010001
[   80.803412] tg3 0000:03:00.0 enp3s0: 0x00006cf0: 0x00000000, 0x05762100, 0x00000000, 0x00000000
[   80.803416] tg3 0000:03:00.0 enp3s0: 0x00006d00: 0x13c10001, 0x00000000, 0x00000000, 0x00062030
[   80.803421] tg3 0000:03:00.0 enp3s0: 0x00006d10: 0x00000000, 0x00002000, 0x000000a0, 0x00000000
[   80.803427] tg3 0000:03:00.0 enp3s0: 0x00006d30: 0x00000000, 0x00000000, 0x00000000, 0x15010003
[   80.803432] tg3 0000:03:00.0 enp3s0: 0x00006d40: 0xc85b6574, 0x0000a44c, 0x00000000, 0x00000000
[   80.803438] tg3 0000:03:00.0 enp3s0: 0x00006d50: 0x16010004, 0x00000000, 0x00078116, 0x00000001
[   80.803444] tg3 0000:03:00.0 enp3s0: 0x00006d60: 0x1b010002, 0x00000000, 0x00000000, 0x00000000
[   80.803448] tg3 0000:03:00.0 enp3s0: 0x00006d70: 0x00000000, 0x800000ff, 0x00000000, 0x00000000
[   80.803452] tg3 0000:03:00.0 enp3s0: 0x00006db0: 0x23010018, 0x10011001, 0x00000000, 0x00000000
[   80.803459] tg3 0000:03:00.0 enp3s0: 0x00006e30: 0x00010017, 0x00050403, 0x00000000, 0x00000000
[   80.803464] tg3 0000:03:00.0 enp3s0: 0x00007000: 0x00000008, 0x00000000, 0x00000000, 0x00003988
[   80.803469] tg3 0000:03:00.0 enp3s0: 0x00007010: 0xa4e0cd28, 0x03808082, 0x80050020, 0x03000200
[   80.803474] tg3 0000:03:00.0 enp3s0: 0x00007020: 0x00000000, 0x00000008, 0x00000406, 0x10004000
[   80.803480] tg3 0000:03:00.0 enp3s0: 0x00007030: 0x001e0000, 0x0000398c, 0x00440030, 0x80000000
[   80.803485] tg3 0000:03:00.0 enp3s0: 0x00007500: 0x00000000, 0x00000000, 0x00000081, 0x00000000
[   80.803489] tg3 0000:03:00.0 enp3s0: 0x00007510: 0x00000000, 0xfdffefff, 0x00000000, 0x00000000
[   80.803497] tg3 0000:03:00.0 enp3s0: 0: Host status block [00000001:00000004:(0000:02da:0000):(0000:01d7)]
[   80.803503] tg3 0000:03:00.0 enp3s0: 0: NAPI info [00000004:00000004:(0026:01d7:01ff):0000:(03cf:0000:0000:0000)]
[   80.803509] tg3 0000:03:00.0 enp3s0: 1: Host status block [00000001:00000081:(0000:0000:0000):(0aff:0000)]
[   80.803516] tg3 0000:03:00.0 enp3s0: 1: NAPI info [00000081:00000081:(0000:0000:01ff):0aff:(02ff:02ff:0000:0000)]
[   80.803522] tg3 0000:03:00.0 enp3s0: 2: Host status block [00000001:00000017:(07f7:0000:0000):(0000:0000)]
[   80.803531] tg3 0000:03:00.0 enp3s0: 2: NAPI info [00000017:00000017:(0000:0000:01ff):07f7:(07f7:07f7:0000:0000)]
[   80.803537] tg3 0000:03:00.0 enp3s0: 3: Host status block [00000001:0000002b:(0000:0000:0000):(0000:0000)]
[   80.803545] tg3 0000:03:00.0 enp3s0: 3: NAPI info [0000002b:0000002b:(0000:0000:01ff):0813:(0013:0013:0000:0000)]
[   80.803552] tg3 0000:03:00.0 enp3s0: 4: Host status block [00000001:00000000:(0000:0000:07fe):(0000:0000)]
[   80.803559] tg3 0000:03:00.0 enp3s0: 4: NAPI info [00000000:00000000:(0000:0000:01ff):07fe:(07fe:07fe:0000:0000)]
[   80.845805] tg3 0000:03:00.0 enp3s0: Link is down
[   84.405304] tg3 0000:03:00.0 enp3s0: Link is up at 1000 Mbps, full duplex
[   84.405346] tg3 0000:03:00.0 enp3s0: Flow control is on for TX and on for RX
[   84.405349] tg3 0000:03:00.0 enp3s0: EEE is enabled
[  124.289052] tg3 0000:03:00.0 enp3s0: transmit timed out, resetting
[  126.881490] tg3 0000:03:00.0 enp3s0: 0x00000000: 0x168714e4, 0x00100406, 0x02000010, 0x00000000
[  126.881523] tg3 0000:03:00.0 enp3s0: 0x00000010: 0xe022000c, 0x00000000, 0xe021000c, 0x00000000
[  126.881527] tg3 0000:03:00.0 enp3s0: 0x00000020: 0xe020000c, 0x00000000, 0x00000000, 0x08141028
[  126.881531] tg3 0000:03:00.0 enp3s0: 0x00000030: 0x00000000, 0x00000048, 0x00000000, 0x000001ff
[  126.881534] tg3 0000:03:00.0 enp3s0: 0x00000040: 0x00000000, 0x4a000000, 0xc8035001, 0x16002008
[  126.881538] tg3 0000:03:00.0 enp3s0: 0x00000050: 0x00005803, 0x00000000, 0x0086a005, 0x00000000
[  126.881541] tg3 0000:03:00.0 enp3s0: 0x00000060: 0x00000000, 0x00000000, 0xf1000298, 0x01f802d1
[  126.881552] tg3 0000:03:00.0 enp3s0: 0x00000070: 0x00071010, 0xc3000600, 0x00000000, 0x00000000
[  126.881560] tg3 0000:03:00.0 enp3s0: 0x00000080: 0x168714e4, 0x800000f8, 0x00000000, 0x00000fdf
[  126.881566] tg3 0000:03:00.0 enp3s0: 0x00000090: 0x00000000, 0x00000074, 0x00000000, 0x00000079
[  126.881571] tg3 0000:03:00.0 enp3s0: 0x000000a0: 0x8005ac11, 0x00000004, 0x00000122, 0x00020010
[  126.881575] tg3 0000:03:00.0 enp3s0: 0x000000b0: 0x10008d81, 0x00105400, 0x00475c12, 0x10120140
[  126.881578] tg3 0000:03:00.0 enp3s0: 0x000000d0: 0x0008081f, 0x00000400, 0x00000000, 0x00010001
[  126.881582] tg3 0000:03:00.0 enp3s0: 0x000000f0: 0x00000000, 0x05762100, 0x00000000, 0xffffffff
[  126.881585] tg3 0000:03:00.0 enp3s0: 0x00000100: 0x13c10001, 0x00000000, 0x00000000, 0x00062030
[  126.881588] tg3 0000:03:00.0 enp3s0: 0x00000110: 0x00000000, 0x00002000, 0x000000a0, 0x00000000
[  126.881591] tg3 0000:03:00.0 enp3s0: 0x00000130: 0x00000000, 0x00000000, 0x00000000, 0x15010003
[  126.881595] tg3 0000:03:00.0 enp3s0: 0x00000140: 0xc85b6574, 0x0000a44c, 0x00000000, 0x00000000
[  126.881598] tg3 0000:03:00.0 enp3s0: 0x00000150: 0x16010004, 0x00000000, 0x00078116, 0x00000001
[  126.881601] tg3 0000:03:00.0 enp3s0: 0x00000160: 0x1b010002, 0x00000000, 0x00000000, 0x00000000
[  126.881607] tg3 0000:03:00.0 enp3s0: 0x00000170: 0x00000000, 0x800000ff, 0x00000000, 0x00000000
[  126.881610] tg3 0000:03:00.0 enp3s0: 0x000001b0: 0x23010018, 0x10011001, 0x00000000, 0x00000000
[  126.881614] tg3 0000:03:00.0 enp3s0: 0x00000200: 0x00000000, 0x4a000000, 0x00000000, 0x34000000
[  126.881617] tg3 0000:03:00.0 enp3s0: 0x00000210: 0x00000000, 0x75000000, 0x00000000, 0xa7000000
[  126.881621] tg3 0000:03:00.0 enp3s0: 0x00000220: 0x00000000, 0x99000000, 0x00000000, 0x00000000
[  126.881625] tg3 0000:03:00.0 enp3s0: 0x00000260: 0x00000000, 0x00000000, 0x00000000, 0x00000079
[  126.881628] tg3 0000:03:00.0 enp3s0: 0x00000280: 0x00000000, 0x00000fdf, 0x00000000, 0x00000fbb
[  126.881631] tg3 0000:03:00.0 enp3s0: 0x00000290: 0x00000000, 0x00000018, 0x00000000, 0x00000fff
[  126.881634] tg3 0000:03:00.0 enp3s0: 0x00000300: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881638] tg3 0000:03:00.0 enp3s0: 0x00000310: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881641] tg3 0000:03:00.0 enp3s0: 0x00000320: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881644] tg3 0000:03:00.0 enp3s0: 0x00000330: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881647] tg3 0000:03:00.0 enp3s0: 0x00000340: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881655] tg3 0000:03:00.0 enp3s0: 0x00000350: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881663] tg3 0000:03:00.0 enp3s0: 0x00000360: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881670] tg3 0000:03:00.0 enp3s0: 0x00000370: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881677] tg3 0000:03:00.0 enp3s0: 0x00000380: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881687] tg3 0000:03:00.0 enp3s0: 0x00000390: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881694] tg3 0000:03:00.0 enp3s0: 0x000003a0: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881701] tg3 0000:03:00.0 enp3s0: 0x000003b0: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881709] tg3 0000:03:00.0 enp3s0: 0x000003c0: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881713] tg3 0000:03:00.0 enp3s0: 0x000003d0: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881716] tg3 0000:03:00.0 enp3s0: 0x000003e0: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881719] tg3 0000:03:00.0 enp3s0: 0x000003f0: 0x00000000, 0x00000074, 0x00000000, 0x00000074
[  126.881722] tg3 0000:03:00.0 enp3s0: 0x00000400: 0x18e04808, 0x00400000, 0x00001000, 0x00009b00
[  126.881726] tg3 0000:03:00.0 enp3s0: 0x00000410: 0x0000a44c, 0xc85b6574, 0x0000a44c, 0xc85b6574
[  126.881729] tg3 0000:03:00.0 enp3s0: 0x00000420: 0x0000a44c, 0xc85b6574, 0x0000a44c, 0xc85b6574
[  126.881732] tg3 0000:03:00.0 enp3s0: 0x00000430: 0x00000000, 0x00000000, 0x00000099, 0x000005f2
[  126.881737] tg3 0000:03:00.0 enp3s0: 0x00000440: 0x00000000, 0x00000000, 0x00000000, 0x082e0006
[  126.881740] tg3 0000:03:00.0 enp3s0: 0x00000450: 0x00000001, 0x00008000, 0x00000000, 0x00000112
[  126.881744] tg3 0000:03:00.0 enp3s0: 0x00000460: 0x0000000b, 0x00002620, 0x03ff0006, 0x00000000
[  126.881747] tg3 0000:03:00.0 enp3s0: 0x00000470: 0xa0000000, 0x00000000, 0x00000400, 0x50000000
[  126.881750] tg3 0000:03:00.0 enp3s0: 0x00000480: 0x42000000, 0x7fffffff, 0x06000004, 0x7fffffff
[  126.881753] tg3 0000:03:00.0 enp3s0: 0x00000500: 0x00000008, 0x00000002, 0x00000000, 0x00000000
[  126.881756] tg3 0000:03:00.0 enp3s0: 0x00000590: 0x00901001, 0x00000000, 0x00000000, 0x00000000
[  126.881759] tg3 0000:03:00.0 enp3s0: 0x00000600: 0xffffffff, 0x00f80011, 0x00000000, 0x40001f0c
[  126.881763] tg3 0000:03:00.0 enp3s0: 0x00000610: 0xffffffff, 0x00000000, 0x00000044, 0x00000000
[  126.881769] tg3 0000:03:00.0 enp3s0: 0x00000620: 0x00000040, 0x00000000, 0x00000000, 0x00000000
[  126.881777] tg3 0000:03:00.0 enp3s0: 0x00000630: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[  126.881784] tg3 0000:03:00.0 enp3s0: 0x00000640: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[  126.881791] tg3 0000:03:00.0 enp3s0: 0x00000650: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[  126.881800] tg3 0000:03:00.0 enp3s0: 0x00000660: 0x01230123, 0x01230123, 0x01230123, 0x01230123
[  126.881808] tg3 0000:03:00.0 enp3s0: 0x00000670: 0xaa6fcb8c, 0x17828d91, 0xe68b709a, 0x8f49e46e
[  126.881815] tg3 0000:03:00.0 enp3s0: 0x00000680: 0x0122a580, 0xb1f47e2a, 0x5fc1683c, 0x0db6cfc9
[  126.881821] tg3 0000:03:00.0 enp3s0: 0x00000690: 0xd201e2b4, 0xcb1c837d, 0x00000000, 0x00000000
[  126.881825] tg3 0000:03:00.0 enp3s0: 0x000006c0: 0x00000000, 0x00000000, 0x04000000, 0x00000000
[  126.881829] tg3 0000:03:00.0 enp3s0: 0x00000800: 0x00000000, 0xffffffff, 0x00000000, 0x00000000
[  126.881834] tg3 0000:03:00.0 enp3s0: 0x00000810: 0x00000000, 0xffffffff, 0x00000000, 0x00000000
[  126.881838] tg3 0000:03:00.0 enp3s0: 0x00000820: 0x00000000, 0x00000000, 0xffffffff, 0x00000000
[  126.881842] tg3 0000:03:00.0 enp3s0: 0x00000830: 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
[  126.881848] tg3 0000:03:00.0 enp3s0: 0x00000840: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[  126.881851] tg3 0000:03:00.0 enp3s0: 0x00000850: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[  126.881855] tg3 0000:03:00.0 enp3s0: 0x00000860: 0xffffffff, 0xffffffff, 0xffffffff, 0x00000000
[  126.881861] tg3 0000:03:00.0 enp3s0: 0x000008f0: 0x007c0001, 0x00000000, 0x00000000, 0x00000000
[  126.881869] tg3 0000:03:00.0 enp3s0: 0x00000900: 0x000a9558, 0xffffffff, 0x00000000, 0x00000000
[  126.881876] tg3 0000:03:00.0 enp3s0: 0x00000910: 0x00000027, 0xffffffff, 0x00000000, 0x00000000
[  126.881881] tg3 0000:03:00.0 enp3s0: 0x00000920: 0x00000000, 0x00000000, 0xffffffff, 0x00000000
[  126.881885] tg3 0000:03:00.0 enp3s0: 0x00000930: 0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
[  126.881888] tg3 0000:03:00.0 enp3s0: 0x00000940: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[  126.881895] tg3 0000:03:00.0 enp3s0: 0x00000950: 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff
[  126.881899] tg3 0000:03:00.0 enp3s0: 0x00000960: 0xffffffff, 0xffffffff, 0xffffffff, 0x0000266c
[  126.881906] tg3 0000:03:00.0 enp3s0: 0x00000970: 0x00000004, 0x00000002, 0x00000000, 0x00000000
[  126.881912] tg3 0000:03:00.0 enp3s0: 0x00000980: 0x01a8079f, 0x00000000, 0x00000000, 0x00004787
[  126.881918] tg3 0000:03:00.0 enp3s0: 0x00000990: 0x00000034, 0x00000013, 0x00000000, 0x00000000
[  126.881922] tg3 0000:03:00.0 enp3s0: 0x00000c00: 0x0000000a, 0x00000000, 0x00000003, 0x00000001
[  126.881926] tg3 0000:03:00.0 enp3s0: 0x00000c10: 0x00000000, 0x00000000, 0x00000000, 0x00610000
[  126.881929] tg3 0000:03:00.0 enp3s0: 0x00000c80: 0x00002672, 0x00000000, 0x00000000, 0x00000000
[  126.881932] tg3 0000:03:00.0 enp3s0: 0x00000ce0: 0xff817002, 0x00000000, 0x00000061, 0x00041028
[  126.881936] tg3 0000:03:00.0 enp3s0: 0x00000cf0: 0x00000000, 0x50000074, 0x00000000, 0x00000000
[  126.881943] tg3 0000:03:00.0 enp3s0: 0x00001000: 0x00000002, 0x00000000, 0xa0001314, 0x00000000
[  126.881949] tg3 0000:03:00.0 enp3s0: 0x00001010: 0x00740741, 0x00001314, 0x00000000, 0x00000000
[  126.881956] tg3 0000:03:00.0 enp3s0: 0x00001400: 0x00000006, 0x00000000, 0x00000000, 0x00000001
[  126.881962] tg3 0000:03:00.0 enp3s0: 0x00001440: 0x00000074, 0x00000074, 0x00000074, 0x00000074
[  126.881966] tg3 0000:03:00.0 enp3s0: 0x00001450: 0x00000074, 0x00000074, 0x00000074, 0x00000074
[  126.881970] tg3 0000:03:00.0 enp3s0: 0x00001460: 0x00000074, 0x00000074, 0x00000074, 0x00000074
[  126.881973] tg3 0000:03:00.0 enp3s0: 0x00001470: 0x00000074, 0x00000074, 0x00000074, 0x00000074
[  126.881977] tg3 0000:03:00.0 enp3s0: 0x00001800: 0x00000016, 0x00000000, 0x00000074, 0x00000000
[  126.881983] tg3 0000:03:00.0 enp3s0: 0x00001840: 0x00000000, 0x00000000, 0x00000200, 0x00000010
[  126.881989] tg3 0000:03:00.0 enp3s0: 0x00001850: 0x0000001f, 0x00000000, 0x00004330, 0x00740074
[  126.881993] tg3 0000:03:00.0 enp3s0: 0x00001860: 0x01000000, 0x00000000, 0x00000000, 0x00000000
[  126.881999] tg3 0000:03:00.0 enp3s0: 0x00001c00: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[  126.882003] tg3 0000:03:00.0 enp3s0: 0x00002000: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[  126.882007] tg3 0000:03:00.0 enp3s0: 0x00002010: 0x00000181, 0x00000001, 0x007bfffd, 0x00000000
[  126.882012] tg3 0000:03:00.0 enp3s0: 0x00002100: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882017] tg3 0000:03:00.0 enp3s0: 0x00002110: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882023] tg3 0000:03:00.0 enp3s0: 0x00002120: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882029] tg3 0000:03:00.0 enp3s0: 0x00002130: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882035] tg3 0000:03:00.0 enp3s0: 0x00002140: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882039] tg3 0000:03:00.0 enp3s0: 0x00002150: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882044] tg3 0000:03:00.0 enp3s0: 0x00002160: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882048] tg3 0000:03:00.0 enp3s0: 0x00002170: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882052] tg3 0000:03:00.0 enp3s0: 0x00002180: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882057] tg3 0000:03:00.0 enp3s0: 0x00002190: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882060] tg3 0000:03:00.0 enp3s0: 0x000021a0: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882064] tg3 0000:03:00.0 enp3s0: 0x000021b0: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882067] tg3 0000:03:00.0 enp3s0: 0x000021c0: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882071] tg3 0000:03:00.0 enp3s0: 0x000021d0: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882076] tg3 0000:03:00.0 enp3s0: 0x000021e0: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882080] tg3 0000:03:00.0 enp3s0: 0x000021f0: 0x000ded02, 0x000c3c2a, 0x00000007, 0x00000000
[  126.882086] tg3 0000:03:00.0 enp3s0: 0x00002200: 0x00003fca, 0x00000000, 0x00000000, 0x00000000
[  126.882093] tg3 0000:03:00.0 enp3s0: 0x00002250: 0x00000804, 0x00000000, 0x00000000, 0x00000000
[  126.882101] tg3 0000:03:00.0 enp3s0: 0x00002400: 0x00010012, 0x00000000, 0x00000000, 0x00000000
[  126.882106] tg3 0000:03:00.0 enp3s0: 0x00002440: 0x00000000, 0x00000000, 0x00000002, 0x00000000
[  126.882110] tg3 0000:03:00.0 enp3s0: 0x00002450: 0x00000000, 0xfffe0000, 0x08001800, 0x00006000
[  126.882113] tg3 0000:03:00.0 enp3s0: 0x00002470: 0x00000000, 0x000007bd, 0x00000000, 0x00000000
[  126.882118] tg3 0000:03:00.0 enp3s0: 0x000024c0: 0x0201a101, 0x00000000, 0x00000000, 0x00000000
[  126.882122] tg3 0000:03:00.0 enp3s0: 0x00002800: 0x00000006, 0x00000000, 0x00000000, 0x00000000
[  126.882125] tg3 0000:03:00.0 enp3s0: 0x00002c00: 0x00000006, 0x00000000, 0x00000000, 0x00000033
[  126.882129] tg3 0000:03:00.0 enp3s0: 0x00002c10: 0x00000000, 0x00000000, 0x00000019, 0x0000000c
[  126.882135] tg3 0000:03:00.0 enp3s0: 0x00002c20: 0x00020004, 0x00000000, 0x00000000, 0x00000000
[  126.882141] tg3 0000:03:00.0 enp3s0: 0x00002d00: 0x00000080, 0x00000040, 0x00000000, 0x00000000
[  126.882149] tg3 0000:03:00.0 enp3s0: 0x00003000: 0x00000006, 0x00000000, 0x00000000, 0x00000033
[  126.882153] tg3 0000:03:00.0 enp3s0: 0x00003600: 0x00134400, 0x00130000, 0x00110000, 0x00000000
[  126.882156] tg3 0000:03:00.0 enp3s0: 0x00003610: 0x00131100, 0x00130000, 0x00130000, 0x00000000
[  126.882160] tg3 0000:03:00.0 enp3s0: 0x00003620: 0x80110011, 0x00000000, 0x00002004, 0x3c822080
[  126.882163] tg3 0000:03:00.0 enp3s0: 0x00003630: 0x00000000, 0x80008000, 0x00001080, 0x00000000
[  126.882168] tg3 0000:03:00.0 enp3s0: 0x00003640: 0x0000000a, 0x33f00003, 0x00000020, 0x00000019
[  126.882172] tg3 0000:03:00.0 enp3s0: 0x00003650: 0x00000171, 0x00000bff, 0x05762100, 0x00000000
[  126.882179] tg3 0000:03:00.0 enp3s0: 0x00003660: 0x00000000, 0x00000000, 0x000400a3, 0x00000202
[  126.882185] tg3 0000:03:00.0 enp3s0: 0x00003670: 0x0000002a, 0xfeffff63, 0x0000000a, 0x00000000
[  126.882190] tg3 0000:03:00.0 enp3s0: 0x000036b0: 0x001003cc, 0x07ff07ff, 0x07ff07ff, 0x01000004
[  126.882194] tg3 0000:03:00.0 enp3s0: 0x000036c0: 0xffffffff, 0x000004e1, 0x00000571, 0x0000055c
[  126.882197] tg3 0000:03:00.0 enp3s0: 0x000036d0: 0x0000019d, 0x00000000, 0x00000000, 0x00000000
[  126.882201] tg3 0000:03:00.0 enp3s0: 0x000036e0: 0x80000b19, 0xa0800799, 0x00500799, 0x00000000
[  126.882207] tg3 0000:03:00.0 enp3s0: 0x000036f0: 0x19090900, 0x13180600, 0x00000301, 0x00000001
[  126.882213] tg3 0000:03:00.0 enp3s0: 0x00003700: 0x00000000, 0x00000000, 0x00000000, 0x00001388
[  126.882216] tg3 0000:03:00.0 enp3s0: 0x00003710: 0x87fffffd, 0x00000000, 0x00000000, 0x000010dc
[  126.882220] tg3 0000:03:00.0 enp3s0: 0x00003720: 0x00000000, 0x00002040, 0x88006000, 0xa0002000
[  126.882226] tg3 0000:03:00.0 enp3s0: 0x00003750: 0x00000000, 0x00000000, 0x0000080c, 0x00000000
[  126.882229] tg3 0000:03:00.0 enp3s0: 0x00003780: 0x0000b7f9, 0x00000000, 0x00000000, 0x00000000
[  126.882234] tg3 0000:03:00.0 enp3s0: 0x00003c00: 0x00000306, 0x00000000, 0x00000000, 0x00000048
[  126.882241] tg3 0000:03:00.0 enp3s0: 0x00003c10: 0x00000000, 0x00000035, 0x00000000, 0x00000000
[  126.882246] tg3 0000:03:00.0 enp3s0: 0x00003c20: 0x00000000, 0x00000005, 0x00000000, 0x00000000
[  126.882250] tg3 0000:03:00.0 enp3s0: 0x00003c30: 0x00000000, 0x00000000, 0x00000000, 0xffffc000
[  126.882255] tg3 0000:03:00.0 enp3s0: 0x00003c40: 0x00000000, 0x00000b00, 0x00000000, 0x00000000
[  126.882260] tg3 0000:03:00.0 enp3s0: 0x00003c50: 0x00000000, 0x000007b3, 0x00000000, 0x00000000
[  126.882265] tg3 0000:03:00.0 enp3s0: 0x00003c80: 0x00000fdf, 0x00000fbb, 0x00000019, 0x00000000
[  126.882269] tg3 0000:03:00.0 enp3s0: 0x00003cc0: 0x00000074, 0x00000000, 0x00000000, 0x00000000
[  126.882272] tg3 0000:03:00.0 enp3s0: 0x00003cd0: 0x00000000, 0x0000000f, 0x00000000, 0x00000000
[  126.882276] tg3 0000:03:00.0 enp3s0: 0x00003d00: 0x00000000, 0xffffb000, 0x00000000, 0xffffa000
[  126.882281] tg3 0000:03:00.0 enp3s0: 0x00003d10: 0x00000000, 0xffff9000, 0x00000000, 0xffff8000
[  126.882284] tg3 0000:03:00.0 enp3s0: 0x00003d80: 0x00000014, 0x00000000, 0x00000005, 0x00000000
[  126.882291] tg3 0000:03:00.0 enp3s0: 0x00003d90: 0x00000005, 0x00000000, 0x00000014, 0x00000000
[  126.882297] tg3 0000:03:00.0 enp3s0: 0x00003da0: 0x00000005, 0x00000000, 0x00000005, 0x00000000
[  126.882301] tg3 0000:03:00.0 enp3s0: 0x00003db0: 0x00000014, 0x00000000, 0x00000005, 0x00000000
[  126.882306] tg3 0000:03:00.0 enp3s0: 0x00003dc0: 0x00000005, 0x00000000, 0x00000014, 0x00000000
[  126.882310] tg3 0000:03:00.0 enp3s0: 0x00003dd0: 0x00000005, 0x00000000, 0x00000005, 0x00000000
[  126.882313] tg3 0000:03:00.0 enp3s0: 0x00004000: 0x00000002, 0x00000000, 0x00000000, 0x00000000
[  126.882317] tg3 0000:03:00.0 enp3s0: 0x00004010: 0x00000000, 0x0022a012, 0x008004f0, 0x01006822
[  126.882324] tg3 0000:03:00.0 enp3s0: 0x00004020: 0x00000000, 0x00000010, 0x00000010, 0x00000050
[  126.882331] tg3 0000:03:00.0 enp3s0: 0x00004030: 0x00000000, 0x01086620, 0x0023f010, 0x00000002
[  126.882335] tg3 0000:03:00.0 enp3s0: 0x00004040: 0x00400000, 0x00000000, 0x00000010, 0x00413062
[  126.882338] tg3 0000:03:00.0 enp3s0: 0x00004400: 0x00000016, 0x00000000, 0x00010000, 0x0000a000
[  126.882342] tg3 0000:03:00.0 enp3s0: 0x00004410: 0x00000000, 0x0000002a, 0x000000a0, 0x00000000
[  126.882349] tg3 0000:03:00.0 enp3s0: 0x00004420: 0x000000fd, 0x00000000, 0x00000000, 0x00000000
[  126.882355] tg3 0000:03:00.0 enp3s0: 0x00004440: 0x00000000, 0x00000000, 0x00000000, 0x01305016
[  126.882359] tg3 0000:03:00.0 enp3s0: 0x00004450: 0x02580214, 0x0040002c, 0x00000000, 0x00000000
[  126.882363] tg3 0000:03:00.0 enp3s0: 0x00004700: 0x00030002, 0x00100000, 0x00100010, 0x3fb40000
[  126.882369] tg3 0000:03:00.0 enp3s0: 0x00004710: 0xffff6710, 0x00065494, 0x00100012, 0x00000000
[  126.882374] tg3 0000:03:00.0 enp3s0: 0x00004720: 0x00000000, 0x00000010, 0xf02c0000, 0xffff6740
[  126.882380] tg3 0000:03:00.0 enp3s0: 0x00004770: 0x000c0404, 0x00000002, 0x00000010, 0x00000000
[  126.882384] tg3 0000:03:00.0 enp3s0: 0x00004800: 0x380303fe, 0x00000000, 0x00000000, 0x00000100
[  126.882389] tg3 0000:03:00.0 enp3s0: 0x00004810: 0x00000000, 0x00000009, 0x05a89f80, 0x00000000
[  126.882393] tg3 0000:03:00.0 enp3s0: 0x00004820: 0x000000a9, 0x00000000, 0x00000000, 0x00000000
[  126.882399] tg3 0000:03:00.0 enp3s0: 0x00004860: 0x000000a9, 0x11c01c00, 0x001ff800, 0x61000008
[  126.882405] tg3 0000:03:00.0 enp3s0: 0x00004870: 0x05ea0080, 0x003e1820, 0x003e1820, 0x00000000
[  126.882408] tg3 0000:03:00.0 enp3s0: 0x00004890: 0x280c0c04, 0x00305400, 0x00000000, 0x00000000
[  126.882412] tg3 0000:03:00.0 enp3s0: 0x000048a0: 0x000f0010, 0x00000000, 0x00000000, 0x00000000
[  126.882415] tg3 0000:03:00.0 enp3s0: 0x00004900: 0x18030002, 0x00000003, 0x30000000, 0x00000120
[  126.882420] tg3 0000:03:00.0 enp3s0: 0x00004910: 0x00000040, 0x00000003, 0x0000df90, 0x00000000
[  126.882426] tg3 0000:03:00.0 enp3s0: 0x00004920: 0x00000015, 0x02098000, 0xff7b4001, 0x0f000068
[  126.882431] tg3 0000:03:00.0 enp3s0: 0x00004930: 0xffb62801, 0x0f000068, 0xffa47201, 0x0f000068
[  126.882435] tg3 0000:03:00.0 enp3s0: 0x00004940: 0xff817001, 0x0f000068, 0xc8c8b4b4, 0xadadd1d1
[  126.882439] tg3 0000:03:00.0 enp3s0: 0x00004950: 0xf0330000, 0xff7b4068, 0xaf000000, 0x15130014
[  126.882445] tg3 0000:03:00.0 enp3s0: 0x00004960: 0x00000000, 0xffb62868, 0xaf000000, 0x40000074
[  126.882450] tg3 0000:03:00.0 enp3s0: 0x00004970: 0x00028202, 0x00205400, 0x0000001c, 0x000000ff
[  126.882454] tg3 0000:03:00.0 enp3s0: 0x00004980: 0x00000015, 0x00000000, 0x00000000, 0x00000000
[  126.882458] tg3 0000:03:00.0 enp3s0: 0x00004990: 0x00000000, 0x00000000, 0xffa47268, 0xaf000000
[  126.882466] tg3 0000:03:00.0 enp3s0: 0x000049a0: 0x00f00024, 0x00000015, 0x00000000, 0x00000000
[  126.882469] tg3 0000:03:00.0 enp3s0: 0x000049b0: 0xffaee201, 0xff40b001, 0xffd66e01, 0xff4a2601
[  126.882473] tg3 0000:03:00.0 enp3s0: 0x000049c0: 0xff7b4002, 0xffb62802, 0xffa47202, 0xff817002
[  126.882476] tg3 0000:03:00.0 enp3s0: 0x000049d0: 0xffaee202, 0xff40b002, 0xffd66e02, 0xff4a2602
[  126.882481] tg3 0000:03:00.0 enp3s0: 0x000049f0: 0xf0330000, 0xff817068, 0xaf000000, 0x0000ffff
[  126.882489] tg3 0000:03:00.0 enp3s0: 0x00004c00: 0x200003fe, 0x00000020, 0x00000000, 0x00000000
[  126.882492] tg3 0000:03:00.0 enp3s0: 0x00004c10: 0x00000015, 0x00000000, 0x00000006, 0x00000000
[  126.882496] tg3 0000:03:00.0 enp3s0: 0x00004c20: 0x00000000, 0x00000000, 0x00000000, 0x00000006
[  126.882502] tg3 0000:03:00.0 enp3s0: 0x00004c30: 0x00000000, 0x003f7c00, 0x000000eb, 0x000000eb
[  126.882506] tg3 0000:03:00.0 enp3s0: 0x00004c40: 0x00000000, 0x0fbb0000, 0x0fff0019, 0x0fba0fde
[  126.882512] tg3 0000:03:00.0 enp3s0: 0x00004c50: 0x0fff0018, 0x07b20fff, 0xc0000000, 0xfb334a4a
[  126.882515] tg3 0000:03:00.0 enp3s0: 0x00004c60: 0x00000020, 0x00000000, 0x00000000, 0x00000000
[  126.882522] tg3 0000:03:00.0 enp3s0: 0x00005000: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[  126.882527] tg3 0000:03:00.0 enp3s0: 0x00005010: 0x00000000, 0x00000000, 0x00000000, 0x0800010c
[  126.882532] tg3 0000:03:00.0 enp3s0: 0x00005020: 0x3c034000, 0x00000000, 0x00000000, 0x40000020
[  126.882535] tg3 0000:03:00.0 enp3s0: 0x00005030: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882542] tg3 0000:03:00.0 enp3s0: 0x00005040: 0x00000000, 0x00000000, 0x08000e1c, 0x00000000
[  126.882545] tg3 0000:03:00.0 enp3s0: 0x00005080: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[  126.882551] tg3 0000:03:00.0 enp3s0: 0x00005090: 0x00000000, 0x00000000, 0x00000000, 0x080002f8
[  126.882558] tg3 0000:03:00.0 enp3s0: 0x000050a0: 0x00621024, 0x00000000, 0x00000000, 0x40000020
[  126.882562] tg3 0000:03:00.0 enp3s0: 0x000050b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882568] tg3 0000:03:00.0 enp3s0: 0x000050c0: 0x00000000, 0x00000000, 0x080012b4, 0x00000000
[  126.882573] tg3 0000:03:00.0 enp3s0: 0x00005100: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[  126.882579] tg3 0000:03:00.0 enp3s0: 0x00005110: 0x00000000, 0x00000000, 0x00000000, 0x08000c88
[  126.882583] tg3 0000:03:00.0 enp3s0: 0x00005120: 0x00021502, 0x00000000, 0x00000000, 0x40000020
[  126.882586] tg3 0000:03:00.0 enp3s0: 0x00005130: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882590] tg3 0000:03:00.0 enp3s0: 0x00005140: 0x00000000, 0x00000000, 0x080011f0, 0x00000000
[  126.882593] tg3 0000:03:00.0 enp3s0: 0x00005180: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[  126.882601] tg3 0000:03:00.0 enp3s0: 0x00005190: 0x00000000, 0x00000000, 0x00000000, 0x080000f8
[  126.882606] tg3 0000:03:00.0 enp3s0: 0x000051a0: 0x00a42824, 0x00000000, 0x00000000, 0x40000020
[  126.882610] tg3 0000:03:00.0 enp3s0: 0x000051b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882613] tg3 0000:03:00.0 enp3s0: 0x000051c0: 0x00000000, 0x00000000, 0x08000e1c, 0x00000000
[  126.882616] tg3 0000:03:00.0 enp3s0: 0x00005200: 0x54000003, 0x00000000, 0x3c038000, 0x00000000
[  126.882622] tg3 0000:03:00.0 enp3s0: 0x00005210: 0x00000000, 0x3c038000, 0xc0000000, 0x00000000
[  126.882628] tg3 0000:03:00.0 enp3s0: 0x00005220: 0x3c038000, 0x00000000, 0x08000e20, 0x00000000
[  126.882634] tg3 0000:03:00.0 enp3s0: 0x00005230: 0x00000000, 0x00000000, 0xc0010000, 0x08007f58
[  126.882638] tg3 0000:03:00.0 enp3s0: 0x00005240: 0x00000000, 0xc0010000, 0x08007f58, 0x00000000
[  126.882643] tg3 0000:03:00.0 enp3s0: 0x00005250: 0x14830018, 0x00000b50, 0x00000000, 0x14830018
[  126.882647] tg3 0000:03:00.0 enp3s0: 0x00005260: 0x01120010, 0x08007f60, 0x14830018, 0x00000000
[  126.882651] tg3 0000:03:00.0 enp3s0: 0x00005270: 0x3c822080, 0x00000000, 0xb49a89ab, 0x00010000
[  126.882654] tg3 0000:03:00.0 enp3s0: 0x00005280: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[  126.882661] tg3 0000:03:00.0 enp3s0: 0x00005290: 0x00000000, 0x00000000, 0x00000000, 0x08000f28
[  126.882669] tg3 0000:03:00.0 enp3s0: 0x000052a0: 0x0e0001bd, 0x00000000, 0x00000000, 0x40000020
[  126.882673] tg3 0000:03:00.0 enp3s0: 0x000052b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882676] tg3 0000:03:00.0 enp3s0: 0x000052c0: 0x00000000, 0x00000000, 0x080012b4, 0x00000000
[  126.882679] tg3 0000:03:00.0 enp3s0: 0x00005300: 0x00009800, 0x80000000, 0x00000000, 0x00000000
[  126.882686] tg3 0000:03:00.0 enp3s0: 0x00005310: 0x00000000, 0x00000000, 0x00000000, 0x08001204
[  126.882693] tg3 0000:03:00.0 enp3s0: 0x00005320: 0x00001021, 0x00000000, 0x00000000, 0x40000020
[  126.882696] tg3 0000:03:00.0 enp3s0: 0x00005330: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882700] tg3 0000:03:00.0 enp3s0: 0x00005340: 0x00000000, 0x00000000, 0x08000300, 0x00000000
[  126.882706] tg3 0000:03:00.0 enp3s0: 0x00005380: 0x00009800, 0x80004000, 0x00000000, 0x00000000
[  126.882709] tg3 0000:03:00.0 enp3s0: 0x00005390: 0x00000000, 0x00000000, 0x00000000, 0x08000e38
[  126.882716] tg3 0000:03:00.0 enp3s0: 0x000053a0: 0x34844521, 0x00000000, 0x00000000, 0x40000020
[  126.882720] tg3 0000:03:00.0 enp3s0: 0x000053b0: 0x00000000, 0x00000025, 0x00000000, 0x00000000
[  126.882723] tg3 0000:03:00.0 enp3s0: 0x000053c0: 0x00000000, 0x00000000, 0x08001c86, 0x00000000
[  126.882727] tg3 0000:03:00.0 enp3s0: 0x00005800: 0x00000000, 0x4a000000, 0x00000000, 0x34000000
[  126.882732] tg3 0000:03:00.0 enp3s0: 0x00005810: 0x00000000, 0x75000000, 0x00000000, 0xa7000000
[  126.882740] tg3 0000:03:00.0 enp3s0: 0x00005820: 0x00000000, 0x99000000, 0x00000000, 0x00000000
[  126.882744] tg3 0000:03:00.0 enp3s0: 0x00005860: 0x00000000, 0x00000000, 0x00000000, 0x00000079
[  126.882747] tg3 0000:03:00.0 enp3s0: 0x00005880: 0x00000000, 0x00000fdf, 0x00000000, 0x00000fbb
[  126.882753] tg3 0000:03:00.0 enp3s0: 0x00005890: 0x00000000, 0x00000018, 0x00000000, 0x00000fff
[  126.882759] tg3 0000:03:00.0 enp3s0: 0x00005900: 0x00000000, 0x00000074, 0x00000000, 0x00000000
[  126.882765] tg3 0000:03:00.0 enp3s0: 0x00005980: 0x00000074, 0x00000000, 0x00000000, 0x00000000
[  126.882768] tg3 0000:03:00.0 enp3s0: 0x00005a00: 0x000f601f, 0x00000000, 0x00010000, 0x00000000
[  126.882772] tg3 0000:03:00.0 enp3s0: 0x00006000: 0x20010082, 0x00000000, 0x00000000, 0x00000000
[  126.882776] tg3 0000:03:00.0 enp3s0: 0x00006400: 0x00000000, 0x00000000, 0x00010091, 0xc0000000
[  126.882784] tg3 0000:03:00.0 enp3s0: 0x00006410: 0x05000016, 0x05000016, 0x00000000, 0x00000000
[  126.882788] tg3 0000:03:00.0 enp3s0: 0x00006430: 0x00000000, 0x14e41687, 0x08141028, 0x10020000
[  126.882792] tg3 0000:03:00.0 enp3s0: 0x00006440: 0x0000304f, 0x000002e4, 0x00000000, 0x00000060
[  126.882798] tg3 0000:03:00.0 enp3s0: 0x000064c0: 0x00000005, 0x00000004, 0x00000122, 0x00000000
[  126.882802] tg3 0000:03:00.0 enp3s0: 0x000064d0: 0x00000040, 0x10008d81, 0x00000000, 0x00d75e12
[  126.882810] tg3 0000:03:00.0 enp3s0: 0x000064e0: 0x00000031, 0x0008001f, 0x00000000, 0x00000000
[  126.882813] tg3 0000:03:00.0 enp3s0: 0x000064f0: 0x00000002, 0x00000031, 0x00000000, 0x00000000
[  126.882819] tg3 0000:03:00.0 enp3s0: 0x00006500: 0x03e10003, 0xc85b6574, 0x0000a44c, 0x00000003
[  126.882823] tg3 0000:03:00.0 enp3s0: 0x00006510: 0x00078116, 0x0005810b, 0x00046105, 0x00000000
[  126.882830] tg3 0000:03:00.0 enp3s0: 0x00006530: 0x00000001, 0x00000000, 0x00000000, 0x00000000
[  126.882835] tg3 0000:03:00.0 enp3s0: 0x00006540: 0x0028081f, 0x0001001e, 0x00000000, 0x00000000
[  126.882839] tg3 0000:03:00.0 enp3s0: 0x00006550: 0x00000001, 0x02800000, 0x0000000f, 0x00000000
[  126.882843] tg3 0000:03:00.0 enp3s0: 0x00006560: 0x0000000f, 0x00000000, 0x00000000, 0x00000000
[  126.882847] tg3 0000:03:00.0 enp3s0: 0x000065f0: 0x00000000, 0x00000059, 0x00000000, 0x00000000
[  126.882855] tg3 0000:03:00.0 enp3s0: 0x00006800: 0x141b0034, 0x20081082, 0x00089418, 0x02b60225
[  126.882859] tg3 0000:03:00.0 enp3s0: 0x00006810: 0x01120010, 0xffffffff, 0x00000000, 0x00000040
[  126.882866] tg3 0000:03:00.0 enp3s0: 0x00006880: 0x77fff020, 0x00000040, 0x00801687, 0x00000000
[  126.882871] tg3 0000:03:00.0 enp3s0: 0x00006890: 0x00800000, 0x00000000, 0x00000000, 0x00000000
[  126.882877] tg3 0000:03:00.0 enp3s0: 0x000068a0: 0x00000000, 0x00010001, 0x00000000, 0x00000000
[  126.882880] tg3 0000:03:00.0 enp3s0: 0x000068b0: 0x00040000, 0x00000000, 0x00000000, 0x00000000
[  126.882884] tg3 0000:03:00.0 enp3s0: 0x000068c0: 0x00000044, 0x00000000, 0x00000000, 0x00000000
[  126.882888] tg3 0000:03:00.0 enp3s0: 0x000068f0: 0x00000000, 0x00000000, 0x00000000, 0x04444444
[  126.882895] tg3 0000:03:00.0 enp3s0: 0x00006900: 0xe09534f0, 0x162de7b4, 0x00000000, 0x00000000
[  126.882901] tg3 0000:03:00.0 enp3s0: 0x00006920: 0x00000000, 0x00000000, 0x00000001, 0x00000000
[  126.882905] tg3 0000:03:00.0 enp3s0: 0x00006c00: 0x168714e4, 0x00100406, 0x02000010, 0x00000000
[  126.882908] tg3 0000:03:00.0 enp3s0: 0x00006c10: 0xe022000c, 0x00000000, 0xe021000c, 0x00000000
[  126.882912] tg3 0000:03:00.0 enp3s0: 0x00006c20: 0xe020000c, 0x00000000, 0x00000000, 0x08141028
[  126.882915] tg3 0000:03:00.0 enp3s0: 0x00006c30: 0x00000000, 0x00000048, 0x00000000, 0x000001ff
[  126.882919] tg3 0000:03:00.0 enp3s0: 0x00006c40: 0x00000000, 0x00000000, 0xc8035001, 0x16002008
[  126.882927] tg3 0000:03:00.0 enp3s0: 0x00006c50: 0x00005803, 0x00000000, 0x0086a005, 0x00000000
[  126.882933] tg3 0000:03:00.0 enp3s0: 0x00006c60: 0x00000000, 0x00000000, 0xf1000298, 0x01f802d1
[  126.882936] tg3 0000:03:00.0 enp3s0: 0x00006c70: 0x00071010, 0xc3000600, 0x00000000, 0x00000000
[  126.882940] tg3 0000:03:00.0 enp3s0: 0x00006ca0: 0x8005ac11, 0x00000004, 0x00000122, 0x00020010
[  126.882944] tg3 0000:03:00.0 enp3s0: 0x00006cb0: 0x10008d81, 0x00105400, 0x00475c12, 0x10120140
[  126.882949] tg3 0000:03:00.0 enp3s0: 0x00006cd0: 0x0008081f, 0x00000400, 0x00000000, 0x00010001
[  126.882953] tg3 0000:03:00.0 enp3s0: 0x00006cf0: 0x00000000, 0x05762100, 0x00000000, 0x00000000
[  126.882957] tg3 0000:03:00.0 enp3s0: 0x00006d00: 0x13c10001, 0x00000000, 0x00000000, 0x00062030
[  126.882964] tg3 0000:03:00.0 enp3s0: 0x00006d10: 0x00000000, 0x00002000, 0x000000a0, 0x00000000
[  126.882971] tg3 0000:03:00.0 enp3s0: 0x00006d30: 0x00000000, 0x00000000, 0x00000000, 0x15010003
[  126.882975] tg3 0000:03:00.0 enp3s0: 0x00006d40: 0xc85b6574, 0x0000a44c, 0x00000000, 0x00000000
[  126.882978] tg3 0000:03:00.0 enp3s0: 0x00006d50: 0x16010004, 0x00000000, 0x00078116, 0x00000001
[  126.882982] tg3 0000:03:00.0 enp3s0: 0x00006d60: 0x1b010002, 0x00000000, 0x00000000, 0x00000000
[  126.882985] tg3 0000:03:00.0 enp3s0: 0x00006d70: 0x00000000, 0x800000ff, 0x00000000, 0x00000000
[  126.882993] tg3 0000:03:00.0 enp3s0: 0x00006db0: 0x23010018, 0x10011001, 0x00000000, 0x00000000
[  126.882999] tg3 0000:03:00.0 enp3s0: 0x00006e30: 0x00010017, 0x00050403, 0x00000000, 0x00000000
[  126.883003] tg3 0000:03:00.0 enp3s0: 0x00007000: 0x00000008, 0x00000000, 0x00000000, 0x00003988
[  126.883006] tg3 0000:03:00.0 enp3s0: 0x00007010: 0xa4e0cd28, 0x03808082, 0x80050020, 0x03000200
[  126.883011] tg3 0000:03:00.0 enp3s0: 0x00007020: 0x00000000, 0x00000008, 0x00000406, 0x10004000
[  126.883019] tg3 0000:03:00.0 enp3s0: 0x00007030: 0x001e0000, 0x0000398c, 0x00440030, 0x80000000
[  126.883022] tg3 0000:03:00.0 enp3s0: 0x00007500: 0x00000000, 0x00000000, 0x00000081, 0x00000000
[  126.883027] tg3 0000:03:00.0 enp3s0: 0x00007510: 0x00000000, 0xfdffefff, 0x00000000, 0x00000000
[  126.883037] tg3 0000:03:00.0 enp3s0: 0: Host status block [00000001:0000004a:(0000:077b:0000):(0000:003b)]
[  126.883046] tg3 0000:03:00.0 enp3s0: 0: NAPI info [0000004a:0000004a:(0074:003b:01ff):0000:(0079:0000:0000:0000)]
[  126.883050] tg3 0000:03:00.0 enp3s0: 1: Host status block [00000001:00000034:(0000:0000:0000):(0fdf:0000)]
[  126.883055] tg3 0000:03:00.0 enp3s0: 1: NAPI info [00000034:00000034:(0000:0000:01ff):0fdf:(07df:07df:0000:0000)]
[  126.883064] tg3 0000:03:00.0 enp3s0: 2: Host status block [00000001:00000075:(0fbb:0000:0000):(0000:0000)]
[  126.883069] tg3 0000:03:00.0 enp3s0: 2: NAPI info [00000075:00000075:(0000:0000:01ff):0fbb:(07bb:07bb:0000:0000)]
[  126.883073] tg3 0000:03:00.0 enp3s0: 3: Host status block [00000001:000000a7:(0000:0000:0000):(0000:0000)]
[  126.883077] tg3 0000:03:00.0 enp3s0: 3: NAPI info [000000a7:000000a7:(0000:0000:01ff):0018:(0018:0018:0000:0000)]
[  126.883084] tg3 0000:03:00.0 enp3s0: 4: Host status block [00000001:00000099:(0000:0000:0fff):(0000:0000)]
[  126.883091] tg3 0000:03:00.0 enp3s0: 4: NAPI info [00000099:00000099:(0000:0000:01ff):0fff:(07ff:07ff:0000:0000)]
[  126.925389] tg3 0000:03:00.0 enp3s0: Link is down
[  130.566989] tg3 0000:03:00.0 enp3s0: Link is up at 1000 Mbps, full duplex
[  130.566992] tg3 0000:03:00.0 enp3s0: Flow control is on for TX and on for RX
[  130.566993] tg3 0000:03:00.0 enp3s0: EEE is enabled


> 
> Regards,
> 
> 	Joerg


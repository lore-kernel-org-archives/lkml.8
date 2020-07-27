Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E457C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DEE20786
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H1UhVyIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgG0WsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgG0WsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:48:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90A4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:48:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so16401925wrl.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=bU2x+bjiVDE1+D/qA0fpklR2FuNEA42mCS+xTb/iWyE=;
        b=H1UhVyIfJQLUuGM28jK+1gcTPPiXRXPRDPDZjz6bU3rfTb+bHwFls3BUuSJnEDrExG
         GyYLlcDAhTzwORMifBrWcpZsAIat8isuO0wBtSzLDbMezd/Ij/3veKZupcGVx6LdAcRP
         ycNnmxYaof0OJA2L0zuw0u5Hlp+98o3TMHfBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bU2x+bjiVDE1+D/qA0fpklR2FuNEA42mCS+xTb/iWyE=;
        b=fb6bl5kPwS9d1w8H/D1TqEMG6vPkMTXgrbaDfQyBlGuOsE+7+qgcHwIprf3fOiEMX5
         mpgvXmOMppk+xVioepFH3bJ4PY5c+tjAYsgZWy4+BB+rQyVXRFqpsEv9BMqZGdhwbWm6
         EjhpMHYo0UtzVYXQrEpdbwqBsFPS7ugzWm6+V9yKPeVw55OcbM2n4Fjwf+ZMZ+C+TNck
         ktXIEQBao6k7Oru/DWANyGQSf2WehMTO/s5bm15cvhysTykyyR0zxUomfwYjiDaUtdAJ
         Zd1rgeyK1cBE0HqNXYXJWGSJlSfDTj0RNh6wNJ4lldsYHVUs3vCmxaOweVbzHrvZ3D+k
         ExLQ==
X-Gm-Message-State: AOAM530JjHmyC7ycLCYQwdmtjWiICFYL4wHzQOHP48FDRiBhwXNOqhZl
        u+vF5VIiGEKtLE+P3cObn4ZAQOQpZBr8GD0Nql0AJY3l7n/TPHzxtirsSbX7ydaDfc9OizMwdLL
        Ox2rrcNqnwXr6xGWDsLVijAQK3iIu6BkwRv3C5npAtoqBdTxQPhUUN68yy80YSBbisu0iUBJ/wb
        szI4Vyf4pO
X-Google-Smtp-Source: ABdhPJz6OE76/IuL6l8zMOBAQkDOvpoF5SvRzSnB/qYmyBFiEk+/4vjha5vQZ9cb70AHSWGJnbPoDg==
X-Received: by 2002:adf:9f12:: with SMTP id l18mr21743332wrf.35.1595890086697;
        Mon, 27 Jul 2020 15:48:06 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g126sm1326930wme.16.2020.07.27.15.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 15:48:06 -0700 (PDT)
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
To:     Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de, x86@kernel.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
 <87h7tsbs1n.fsf@nanos.tec.linutronix.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <e0ce41cd-9149-e43e-f4ca-e75503cb82e3@broadcom.com>
Date:   Mon, 27 Jul 2020 15:48:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7tsbs1n.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bios now updated to latest.  Same kernel panic issue.  Log below.

I think it is related to power cycling quickly.
Should APIC work if PC power cycled in a few seconds or is that the problem?


On 2020-07-27 1:51 p.m., Thomas Gleixner wrote:
> Scott,
>
> Scott Branden <scott.branden@broadcom.com> writes:
>
>> Occasionally I get the following Kernel panic on boot.  This is
>> running on the latest kernel but have seen it previously as well.
>> "Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with
>> apic=debug and send a report."
>>
>> I don't know who I am support to send a report to.  But here is the log with apic=debug
>> [    0.006000] ENABLING IO-APIC IRQs
>> [    0.007000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>> [    0.007000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
>> [    0.007000] ...trying to set up timer (IRQ0) through the 8259A ...
>> [    0.007000] ..... (found apic 0 pin 2) ...
>> [    0.007000] ....... failed.
>> [    0.007000] ...trying to set up timer as Virtual Wire IRQ...
>> [    0.007000] ..... failed.
>> [    0.007000] ...trying to set up timer as ExtINT IRQ...
>> [    0.007000] ..... failed :(.
>> [    0.007000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
> Nothing which rings a bell. Can you please provide a boot log from a
> successful boot with apic=debug on the command line?
>
> Also you might check whether there are BIOS updates for this board. The
> early Ryzen BIOSes had some rough edges.
Same issue with latest BIOS:
Loading /bzImage... ok
[    0.000000] Linux version 5.8.0-rc6 (oe-user@oe-host) (x86_64-poky-linux-gcc (GCC) 10.1.0, GNU ld (GNU Binutils) 2.34.0.20200220) #1 SMP Sat Jul 25 03:55:25 UTC 2020
[    0.000000] Command line: BOOT_IMAGE=/bzImage ima_policy=tcb apic=debug ip=dhcp raid=noautodetect console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfs/vxc,hard,tcp,intr,v3 rootwait nfsrootdebug
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfefff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009bff000-0x0000000009ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000a210000-0x00000000ca47ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca480000-0x00000000ca7acfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca7ad000-0x00000000ca8fcfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000ca8fd000-0x00000000cafb4fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cafb5000-0x00000000cbbfefff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cbbff000-0x00000000ccffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd400000-0x00000000fd5fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042f37ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000042f380000-0x000000042fffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: System manufacturer System Product Name/PRIME X570-P, BIOS 2407 07/01/2020
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] last_pfn = 0x42f380 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT 
[    0.000000] last_pfn = 0xcd000 max_arch_pfn = 0x400000000
[    0.000000] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.000000] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.000000] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.000000] Scan for SMP in [mem 0x0009d400-0x0009d7ff]
[    0.000000] check: Scanning 1 areas for low memory corruption
[    0.000000] Using GB pages for direct mapping
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000CA8FB728 0000BC (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.000000] ACPI: FACP 0x00000000CA8EC000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CA8DF000 00C38D (v02 ALASKA A M I    01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000CAF98000 000040
[    0.000000] ACPI: SSDT 0x00000000CA8F2000 008C98 (v02 AMD    AmdTable 00000002 MSFT 04000000)
[    0.000000] ACPI: SSDT 0x00000000CA8EE000 003A78 (v01 AMD    AMD AOD  00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000CA8ED000 0000C8 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.000000] ACPI: FIDT 0x00000000CA8DE000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: WSMT 0x00000000CA8D8000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000CA8DC000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
[    0.000000] ACPI: HPET 0x00000000CA8DB000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
[    0.000000] ACPI: SSDT 0x00000000CA8DA000 000024 (v01 AMD    BIXBY    00001000 INTL 20120913)
[    0.000000] ACPI: WPBT 0x00000000CA7FF000 00003C (v01 ALASKA A M I    00000001 ASUS 00000001)
[    0.000000] ACPI: IVRS 0x00000000CA7FE000 0000D0 (v02 AMD    AmdTable 00000001 AMD  00000000)
[    0.000000] ACPI: PCCT 0x00000000CA7FD000 00006E (v02 AMD    AmdTable 00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000CA7FA000 002F29 (v02 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000CA7F9000 000B58 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x00000000CA7F8000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000CA7F7000 00052C (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: SSDT 0x00000000CA7F3000 003282 (v01 AMD    AmdTable 00000001 INTL 20120913)
[    0.000000] ACPI: APIC 0x00000000CA7F1000 00015E (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CA7F0000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
[    0.000000] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000042f37ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x42f37c000-0x42f37ffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000042f37ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000009bfefff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.000000]   node   0: [mem 0x000000000a210000-0x00000000ca47ffff]
[    0.000000]   node   0: [mem 0x00000000cbbff000-0x00000000ccffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000042f37ffff]
[    0.000000] Zeroed struct page in unavailable ranges: 22644 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000042f37ffff]
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
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x09bff000-0x09ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xca480000-0xca7acfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xca7ad000-0xca8fcfff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xca8fd000-0xcafb4fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xcafb5000-0xcbbfefff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xcd000000-0xcfffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xefffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfd1fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd200000-0xfd2fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd300000-0xfd3fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd400000-0xfd5fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfd600000-0xfe9fffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfea00000-0xfea0ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfea10000-0xfeb7ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfecfffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed3ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfed90000-0xfedc1fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfedc2000-0xfedcffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfedd0000-0xfedd3fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfedd4000-0xfedd5fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xfedd6000-0xfeffffff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] [mem 0xd0000000-0xefffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:32 nr_node_ids:1
[    0.000000] percpu: Embedded 52 pages/cpu s172760 r8192 d32040 u262144
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 4106455
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/bzImage ima_policy=tcb apic=debug ip=dhcp raid=noautodetect console=ttyS0,115200 root=/dev/nfs nfsroot=192.168.1.100:/nfs/vxc,hard,tcp,intr,v3 rootwait nfsrg
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 16292300K/16686640K available (16388K kernel code, 1982K rwdata, 4144K rodata, 1604K init, 1484K bss, 394340K reserved, 0K cma-reserved)
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
[    0.005000] ENABLING IO-APIC IRQs
[    0.006000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.006000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[    0.006000] ...trying to set up timer (IRQ0) through the 8259A ...
[    0.006000] ..... (found apic 0 pin 2) ...
[    0.006000] ....... failed.
[    0.006000] ...trying to set up timer as Virtual Wire IRQ...
[    0.006000] ..... failed.
[    0.006000] ...trying to set up timer as ExtINT IRQ...
[    0.006000] ..... failed :(.
[    0.006000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
[    0.006000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0-rc6 #1
[    0.006000] Hardware name: System manufacturer System Product Name/PRIME X570-P, BIOS 2407 07/01/2020
[    0.006000] Call Trace:
[    0.006000]  dump_stack+0x78/0xa0
[    0.006000]  panic+0x100/0x2c6
[    0.006000]  setup_IO_APIC+0x826/0x86a
[    0.006000]  ? clear_IO_APIC_pin+0x173/0x240
[    0.006000]  x86_late_time_init+0x20/0x30
[    0.006000]  start_kernel+0x478/0x531
[    0.006000]  secondary_startup_64+0xb6/0xc0
[    0.006000] ---[ end Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option. ]---

>
> Thanks,
>
>         tglx
>


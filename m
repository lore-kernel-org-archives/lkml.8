Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96245C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7659420678
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFBMSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:18:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:18:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77F39AE72;
        Tue,  2 Jun 2020 12:18:31 +0000 (UTC)
Subject: Re: [LKP] Re: 28307d938f ("percpu: make pcpu_alloc() aware of current
 gfp .."): BUG: kernel reboot-without-warning in boot stage
To:     Li Zhijian <zhijianx.li@intel.com>,
        kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Linus, Torvalds," <torvalds@linux-foundation.org>
References: <5ed0b6ea.QaEVKYBGHpcVDpW8%lkp@intel.com>
 <21fb7dbf-1fd2-cfcb-860e-c342ae0c310e@suse.com>
 <a1e41149-a3b3-4a19-7001-9b47d8b66555@intel.com>
From:   Filipe Manana <fdmanana@suse.com>
Message-ID: <0405917f-dc4f-f32c-0aeb-043742fc4d6e@suse.com>
Date:   Tue, 2 Jun 2020 13:18:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a1e41149-a3b3-4a19-7001-9b47d8b66555@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/20 05:37, Li Zhijian wrote:
> Hi Filipe,
> 
> LKP checked blow dmesg as the indicator in this problem
> 
>>> [    0.144174] RAMDISK: [mem 0x7fa2e000-0x7fffffff]
>>> [    0.144559] ACPI: Early table checksum verification disabled
>>> [    0.144985] ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
>>> [    0.145424] ACPI: RSDT 0x00000000BFFE15C9 000030 (v01 BOCHS 
>>> BXPCRSDT 00000001 BXPC 00000001)
>>> [    0.146051] ACPI: FACP 0x00000000BFFE149D 000074 (v01 BOCHS 
>>> BXPCFACP 00000001 BXPC 00000001)
>>> BUG: kernel reboot-without-warning in boot stage
>>>
> 
> And i have reproduced it with script in attachment. this issue is gone
> when i reverted this commit 28307d938f
> 
> Please note that
> - i reproduced it with kernel compiled by gcc-5
> - i failed to reproduce it in kernel compiled by gcc-7 so far

Odd.
Here I tested with:

$ gcc --version
gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.

> 
> :~/1787$ ./reproduce.sh obj/arch/x86/boot/bzImage
> qemu-system-x86_64 -enable-kvm -cpu Haswell,+smep,+smap -kernel
> obj/arch/x86/boot/bzImage -m 8192 -smp 2 -device e1000,netdev=net0
> -netdev user,id=net0,hostfwd=tcp::32032-:22 -boot order=nc -no-reboot
> -watchdog i6300esb -watchdog-action debug -rtc base=localtime -serial
> stdio -display none -monitor null -append root=/dev/ram0
> hung_task_panic=1 debug apic=debug sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on
> panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2
> prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err
> ignore_loglevel console=tty0 earlyprintk=ttyS0,115200
> console=ttyS0,115200 vga=normal rw rcuperf.shutdown=0 watchdog_thresh=60
> early console in setup code
> Wrong EFI loader signature.
> early console in extract_kernel
> input_data: 0x0000000006f752d8
> input_len: 0x000000000130dd3c
> output: 0x0000000001000000
> output_len: 0x0000000007200a48
> kernel_total_size: 0x0000000006826000
> needed_size: 0x0000000007400000
> trampoline_32bit: 0x000000000009d000
> 
> Decompressing Linux... Parsing ELF... done.
> Booting the kernel.
> [    0.000000] Linux version 5.7.0-rc4-00168-g28307d938fb2
> (lizhijian@shao2-debian) (gcc version 5.5.0 20171010 (Debian 5.5.0-12),
> GNU ld (GNU Binutils for Debian) 2.34) #2 SMP PREEMPT Tue Jun 2 11:23:59
> CST 2020
> [    0.000000] Command line: root=/dev/ram0 hung_task_panic=1 debug
> apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100
> net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1
> nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0
> drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0
> earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw
> rcuperf.shutdown=0 watchdog_thresh=60
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
> point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]: 256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832
> bytes, using 'standard' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]
> usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff]
> usable
> [    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff]
> usable
> [    0.000000] printk: debug: ignoring loglevel setting.
> [    0.000000] printk: bootconsole [earlyser0] enabled
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.12.0-1 04/01/2014
> [    0.000000] Hypervisor detected: KVM
> [    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
> [    0.000002] kvm-clock: cpu 0, msr 7601001, primary cpu clock
> [    0.000002] kvm-clock: using sched offset of 2661499940 cycles
> [    0.000603] clocksource: kvm-clock: mask: 0xffffffffffffffff
> max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
> [    0.002261] tsc: Detected 3407.998 MHz processor
> [    0.005351] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.005986] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.006535] last_pfn = 0x240000 max_arch_pfn = 0x400000000
> [    0.007091] MTRR default type: write-back
> [    0.007477] MTRR fixed ranges enabled:
> [    0.007845]   00000-9FFFF write-back
> [    0.008191]   A0000-BFFFF uncachable
> [    0.008536]   C0000-FFFFF write-protect
> [    0.008906] MTRR variable ranges enabled:
> [    0.009293]   0 base 00C0000000 mask FFC0000000 uncachable
> [    0.009818]   1 disabled
> [    0.010064]   2 disabled
> [    0.010314]   3 disabled
> [    0.010561]   4 disabled
> [    0.010822]   5 disabled
> [    0.011072]   6 disabled
> [    0.011325]   7 disabled
> [    0.011602] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP UC- WT
> [    0.012313] last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
> [    0.013294] check: Scanning 1 areas for low memory corruption
> [    0.013898] BRK [0x07801000, 0x07801fff] PGTABLE
> [    0.014358] BRK [0x07802000, 0x07802fff] PGTABLE
> [    0.014822] BRK [0x07803000, 0x07803fff] PGTABLE
> [    0.015626] BRK [0x07804000, 0x07804fff] PGTABLE
> [    0.016099] BRK [0x07805000, 0x07805fff] PGTABLE
> [    0.016773] BRK [0x07806000, 0x07806fff] PGTABLE
> [    0.106782] ACPI: Early table checksum verification disabled
> [    0.107352] ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
> [    0.107949] ACPI: RSDT 0x00000000BFFE15C9 000030 (v01 BOCHS BXPCRSDT
> 00000001 BXPC 00000001)
> [    0.108766] ACPI: FACP 0x00000000BFFE149D 000074 (v01 BOCHS BXPCFACP
> 00000001 BXPC 00000001)
> [    0.109649] ACPI: DSDT 0x00000000BFFE0040 00145D (v01 BOCHS BXPCDSDT
> 00000001 BXPC 00000001)
> lizhijian@shao2-debian:~/1787$
> 
> 
> 
>> Weird, what you are getting is the following warning from lock torture:
> 
> warning from lock torture could be not related to this commit in this case.
> 
> 
> Thanks
> Zhijian
> 
> 

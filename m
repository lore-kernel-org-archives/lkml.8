Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6087C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714A821741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hM1Brt6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBEEZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 23:25:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36476 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727832AbgBEEZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580876739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPYeINJcSEb9OxI9Tg/MrqgbxFJZqD+BmVcIHq1IpEk=;
        b=hM1Brt6gyyTuBXoIA3LvY7Js4VSnfYCrJ16gop3bs+4grvv9kdO5TLI4Bj7rFT5wxW22kR
        5V+lSL+47LFzbQaztg/86wBkUK1PjTv0YocsKpO5+EHoZ8qq55PUoc8EqgHJOfWgfzMMfa
        ILARowziQAG9HP5T/kp3dmWnYmIDGUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-meaUciuVMpKPq4XJJisUCA-1; Tue, 04 Feb 2020 23:25:30 -0500
X-MC-Unique: meaUciuVMpKPq4XJJisUCA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60BE91081FA5;
        Wed,  5 Feb 2020 04:25:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E809212C;
        Wed,  5 Feb 2020 04:25:19 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
Date:   Wed, 5 Feb 2020 12:25:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200128161948.8524-1-john.ogness@linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------EF6EB99EA426AEC28C572523"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------EF6EB99EA426AEC28C572523
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi, John Ogness

Thank you for improving the patch series and making great efforts.

I'm not sure if I missed anything else. Or are there any other related patches to be applied?

After applying this patch series, NMI watchdog detected a hard lockup, which caused that kernel can not boot, please refer to
the following call trace. And I put the complete kernel log in the attachment.

Test machine: 
Intel Platform: Grantley-R Wildcat Pass CPU: Broadwell-EP, B0
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
65536 MB memory, 800 GB disk space

kernel: v5.5-rc7
commit: def9d2780727 ("Linux 5.5-rc7")

......
[  OK  ] Started udev Coldplug all Devices.
[   42.110978] NMI watchdog: Watchdog detected hard LOCKUP on cpu 15
[   42.110978] Modules linked in: ip_tables xfs libcrc32c sr_mod cdrom sd_mod sg mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_vram_helper drm_ttm_helper ttm ahci libahci ixgbe drm crc32c_intel libata mdio dca i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod
[   42.110986] CPU: 15 PID: 1395 Comm: systemd-journal Not tainted 5.5.0-rc7+ #4
[   42.110986] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.6024.071720181717 07/17/2018
[   42.110987] RIP: 0010:native_queued_spin_lock_slowpath+0x5d/0x1c0
[   42.110988] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 47 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b 07 <84> c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 81 fe 00 01 00 00 75
[   42.110988] RSP: 0018:ffffbbe207a7bc48 EFLAGS: 00000002
[   42.110989] RAX: 0000000000f80101 RBX: ffffffffa1576e80 RCX: 0000000000000000
[   42.110990] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa1e95660
[   42.110990] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000b
[   42.110991] R10: ffffa075df5dcf80 R11: ffffffffa0ebfda0 R12: ffffffffa1e95660
[   42.110991] R13: ffffffffa1e97680 R14: ffffffffa17197a0 R15: 0000000000000047
[   42.110991] FS:  00007f7c5642a980(0000) GS:ffffa075df5c0000(0000) knlGS:0000000000000000
[   42.110992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.110992] CR2: 00007ffe95f4c4c0 CR3: 000000084fbfc004 CR4: 00000000003606e0
[   42.110993] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.110993] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.110993] Call Trace:
[   42.110993]  _raw_spin_lock+0x1a/0x20
[   42.110994]  console_unlock+0x9e/0x450
[   42.110994]  bust_spinlocks+0x16/0x30
[   42.110994]  oops_end+0x33/0xc0
[   42.110995]  general_protection+0x32/0x40
[   42.110995] RIP: 0010:copy_data+0xf2/0x1e0
[   42.110995] Code: eb 08 49 83 c4 08 0f 84 8e 00 00 00 4c 89 74 24 08 4c 89 cd 41 89 d6 44 89 44 24 04 49 39 db 0f 87 c6 00 00 00 4d 85 c9 74 43 <41> c7 01 00 00 00 00 48 85 db 74 37 4c 89 e7 48 89 da 41 bf 01 00
[   42.110996] RSP: 0018:ffffbbe207a7bd80 EFLAGS: 00010002
[   42.110996] RAX: ffffa075d44ca000 RBX: 00000000000000a8 RCX: fffffffffff000b0
[   42.110997] RDX: 00000000000000a8 RSI: 00000fffffffff01 RDI: ffffffffa1456e00
[   42.110997] RBP: 0801364600307073 R08: 0000000000002000 R09: 0801364600307073
[   42.110997] R10: fffffffffff00000 R11: 00000000000000a8 R12: ffffffffa1e98330
[   42.110998] R13: 00000000d7efbe00 R14: 00000000000000a8 R15: 00000000ffffc000
[   42.110998]  _prb_read_valid+0xd8/0x190
[   42.110998]  prb_read_valid+0x15/0x20
[   42.110999]  devkmsg_read+0x9d/0x2a0
[   42.110999]  vfs_read+0x91/0x140
[   42.110999]  ksys_read+0x59/0xd0
[   42.111000]  do_syscall_64+0x55/0x1b0
[   42.111000]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.111000] RIP: 0033:0x7f7c55740b62
[   42.111001] Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 e6 d8 20 00 85 c0 75 12 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
[   42.111001] RSP: 002b:00007ffe95f4c4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   42.111002] RAX: ffffffffffffffda RBX: 00007ffe95f4e500 RCX: 00007f7c55740b62
[   42.111002] RDX: 0000000000002000 RSI: 00007ffe95f4c4b0 RDI: 0000000000000008
[   42.111002] RBP: 0000000000000000 R08: 0000000000000100 R09: 0000000000000003
[   42.111003] R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffe95f4c4b0
[   42.111003] R13: 00007ffe95f4e910 R14: 0000000000000000 R15: 0000000000000000
[   42.111003] Kernel panic - not syncing: Hard LOCKUP
[   42.111004] Shutting down cpus with NMI
[   42.111004] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   42.111005] general protection fault: 0000 [#1] SMP PTI
[   42.111005] CPU: 15 PID: 1395 Comm: systemd-journal Not tainted 5.5.0-rc7+ #4
[   42.111005] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B.01.01.6024.071720181717 07/17/2018
[   42.111006] RIP: 0010:copy_data+0xf2/0x1e0
[   42.111006] Code: eb 08 49 83 c4 08 0f 84 8e 00 00 00 4c 89 74 24 08 4c 89 cd 41 89 d6 44 89 44 24 04 49 39 db 0f 87 c6 00 00 00 4d 85 c9 74 43 <41> c7 01 00 00 00 00 48 85 db 74 37 4c 89 e7 48 89 da 41 bf 01 00
[   42.111007] RSP: 0018:ffffbbe207a7bd80 EFLAGS: 00010002
[   42.111007] RAX: ffffa075d44ca000 RBX: 00000000000000a8 RCX: fffffffffff000b0
[   42.111008] RDX: 00000000000000a8 RSI: 00000fffffffff01 RDI: ffffffffa1456e00
[   42.111008] RBP: 0801364600307073 R08: 0000000000002000 R09: 0801364600307073
[   42.111008] R10: fffffffffff00000 R11: 00000000000000a8 R12: ffffffffa1e98330
[   42.111009] R13: 00000000d7efbe00 R14: 00000000000000a8 R15: 00000000ffffc000
[   42.111009] FS:  00007f7c5642a980(0000) GS:ffffa075df5c0000(0000) knlGS:0000000000000000
[   42.111010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.111010] CR2: 00007ffe95f4c4c0 CR3: 000000084fbfc004 CR4: 00000000003606e0
[   42.111011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   42.111011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   42.111012] Call Trace:
[   42.111012]  _prb_read_valid+0xd8/0x190
[   42.111012]  prb_read_valid+0x15/0x20
[   42.111013]  devkmsg_read+0x9d/0x2a0
[   42.111013]  vfs_read+0x91/0x140
[   42.111013]  ksys_read+0x59/0xd0
[   42.111014]  do_syscall_64+0x55/0x1b0
[   42.111014]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.111014] RIP: 0033:0x7f7c55740b62
[   42.111015] Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 e6 d8 20 00 85 c0 75 12 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
[   42.111015] RSP: 002b:00007ffe95f4c4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   42.111016] RAX: ffffffffffffffda RBX: 00007ffe95f4e500 RCX: 00007f7c55740b62
[   42.111016] RDX: 0000000000002000 RSI: 00007ffe95f4c4b0 RDI: 0000000000000008
[   42.111017] RBP: 0000000000000000 R08: 0000000000000100 R09: 0000000000000003
[   42.111017] R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffe95f4c4b0
[   42.111017] R13: 00007ffe95f4e910 R14: 0000000000000000 R15: 0000000000000000
[   42.111017] Modules linked in: ip_tables xfs libcrc32c sr_mod cdrom sd_mod sg mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_vram_helper drm_ttm_helper ttm ahci libahci ixgbe drm crc32c_intel libata mdio dca i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod
---hang---


Thanks.
Lianbo

> Hello,
> 
> After several RFC series [0][1][2][3][4], here is the first set of
> patches to rework the printk subsystem. This first set of patches
> only replace the existing ringbuffer implementation. No locking is
> removed. No semantics/behavior of printk are changed.
> 
> The VMCOREINFO is updated, which will require changes to the
> external crash [5] tool. I will be preparing a patch to add support
> for the new VMCOREINFO.
> 
> This series is in line with the agreements [6] made at the meeting
> during LPC2019 in Lisbon, with 1 exception: support for dictionaries
> will _not_ be discontinued [7]. Dictionaries are stored in a separate
> buffer so that they cannot interfere with the human-readable buffer.
> 
> John Ogness
> 
> [0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
> [1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
> [2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
> [3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de
> [4] https://lkml.kernel.org/r/20191128015235.12940-1-john.ogness@linutronix.de
> [5] https://github.com/crash-utility/crash
> [6] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
> [7] https://lkml.kernel.org/r/20191007120134.ciywr3wale4gxa6v@pathway.suse.cz
> 
> John Ogness (2):
>   printk: add lockless buffer
>   printk: use the lockless ringbuffer
> 
>  include/linux/kmsg_dump.h         |    2 -
>  kernel/printk/Makefile            |    1 +
>  kernel/printk/printk.c            |  836 +++++++++---------
>  kernel/printk/printk_ringbuffer.c | 1370 +++++++++++++++++++++++++++++
>  kernel/printk/printk_ringbuffer.h |  328 +++++++
>  5 files changed, 2114 insertions(+), 423 deletions(-)
>  create mode 100644 kernel/printk/printk_ringbuffer.c
>  create mode 100644 kernel/printk/printk_ringbuffer.h
> 

--------------EF6EB99EA426AEC28C572523
Content-Type: text/x-log;
 name="kernel-5.5.0-rc7.log"
Content-Disposition: attachment;
 filename="kernel-5.5.0-rc7.log"
Content-Transfer-Encoding: quoted-printable

[    0.000000] Linux version 5.5.0-rc7+ (root@intel-wildcatpass-07) (gcc =
version 8.3.1 20191121 (GCC)) #4 SMP Tue Feb 4 05:14:30 EST 2020
[    0.000000] Command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.5.0-rc7+=
 root=3D/dev/mapper/intel--wildcatpass--07-root ro crashkernel=3D512M res=
ume=3D/dev/mapper/intel--wildcatpass--07-swap rd.lvm.lv=3Dintel-wildcatpa=
ss-07/root rd.lvm.lv=3Dintel-wildcatpass-07/swap console=3DttyS0,115200n8=
1
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 =
bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009b3ff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000000009b400-0x000000000009ffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000079f9ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000079fa0000-0x000000007ac4ffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000007ac50000-0x000000007b67ffff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x000000007b680000-0x000000007b7ccfff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x000000007b7cd000-0x000000007b7fffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000007b800000-0x000000008fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000ff400000-0x00000000ffffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107fffffff] usa=
ble
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Intel Corporation S2600WTT/S2600WTT, BIOS SE5C610.86B=
.01.01.6024.071720181717 07/17/2018
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2194.914 MHz processor
[    0.001575] last_pfn =3D 0x1080000 max_arch_pfn =3D 0x400000000
[    0.002262] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
[    0.003249] last_pfn =3D 0x7b800 max_arch_pfn =3D 0x400000000
[    0.011951] found SMP MP-table at [mem 0x000fd850-0x000fd85f]
[    0.012008] kexec: Reserving the low 1M of memory for crashkernel
[    0.012012] Using GB pages for direct mapping
[    0.012120] RAMDISK: [mem 0x2e1ce000-0x330defff]
[    0.012125] ACPI: Early table checksum verification disabled
[    0.012127] ACPI: RSDP 0x00000000000F0460 000024 (v02 INTEL )
[    0.012132] ACPI: XSDT 0x000000007B7CB0E8 0000C4 (v01 INTEL  S2600WT  =
00000000 INTL 01000013)
[    0.012137] ACPI: FACP 0x000000007B7CA000 0000F4 (v04 INTEL  S2600WT  =
00000000 INTL 20091013)
[    0.012143] ACPI: DSDT 0x000000007B78F000 032DA6 (v02 INTEL  S2600WT  =
00000003 INTL 20091013)
[    0.012146] ACPI: FACS 0x000000007B619000 000040
[    0.012150] ACPI: HPET 0x000000007B7C9000 000038 (v01 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012153] ACPI: APIC 0x000000007B7C8000 000AFC (v03 INTEL  S2600WT  =
00000000 INTL 20091013)
[    0.012157] ACPI: MCFG 0x000000007B7C7000 00003C (v01 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012160] ACPI: MSCT 0x000000007B7C6000 000090 (v01 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012163] ACPI: SLIT 0x000000007B7C5000 00006C (v01 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012167] ACPI: SRAT 0x000000007B7C4000 000AB0 (v03 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012170] ACPI: SPMI 0x000000007B7C3000 000041 (v05 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012174] ACPI: WDDT 0x000000007B7C2000 000040 (v01 INTEL  S2600WT  =
00000000 INTL 20091013)
[    0.012177] ACPI: NITR 0x000000007B6A4000 000071 (v02 INTEL  S2600WT  =
00000001 INTL 20091013)
[    0.012181] ACPI: PRAD 0x000000007B69F000 000102 (v02 INTEL  SpsPrAgg =
00000002 INTL 20130328)
[    0.012184] ACPI: UEFI 0x000000007B674000 000042 (v01 INTEL  S2600WT  =
00000002 INTL 01000013)
[    0.012188] ACPI: SSDT 0x000000007B6A5000 0E96B0 (v02 INTEL  S2600WT  =
00004000 INTL 20130328)
[    0.012191] ACPI: SSDT 0x000000007B6A1000 002679 (v02 INTEL  S2600WT  =
00000002 INTL 20130328)
[    0.012195] ACPI: SSDT 0x000000007B6A0000 000064 (v02 INTEL  S2600WT  =
00000002 INTL 20130328)
[    0.012198] ACPI: HEST 0x000000007B69E000 0000A8 (v01 INTEL  S2600WT  =
00000001 INTL 00000001)
[    0.012202] ACPI: BERT 0x000000007B69D000 000030 (v01 INTEL  S2600WT  =
00000001 INTL 00000001)
[    0.012205] ACPI: ERST 0x000000007B69C000 000230 (v01 INTEL  S2600WT  =
00000001 INTL 00000001)
[    0.012209] ACPI: EINJ 0x000000007B69B000 000130 (v01 INTEL  S2600WT  =
00000001 INTL 00000001)
[    0.012212] ACPI: SPCR 0x000000007B69A000 000050 (v01 INTEL  S2600WT  =
00000000 INTL 00000000)
[    0.012248] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.012250] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.012251] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.012252] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.012253] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.012254] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.012255] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.012256] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.012257] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.012258] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.012259] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.012261] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.012262] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.012263] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.012264] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.012265] SRAT: PXM 0 -> APIC 0x28 -> Node 0
[    0.012266] SRAT: PXM 0 -> APIC 0x2a -> Node 0
[    0.012267] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    0.012268] SRAT: PXM 0 -> APIC 0x32 -> Node 0
[    0.012269] SRAT: PXM 0 -> APIC 0x34 -> Node 0
[    0.012270] SRAT: PXM 0 -> APIC 0x36 -> Node 0
[    0.012271] SRAT: PXM 0 -> APIC 0x38 -> Node 0
[    0.012273] SRAT: PXM 1 -> APIC 0x40 -> Node 1
[    0.012274] SRAT: PXM 1 -> APIC 0x42 -> Node 1
[    0.012275] SRAT: PXM 1 -> APIC 0x44 -> Node 1
[    0.012276] SRAT: PXM 1 -> APIC 0x46 -> Node 1
[    0.012277] SRAT: PXM 1 -> APIC 0x48 -> Node 1
[    0.012278] SRAT: PXM 1 -> APIC 0x4a -> Node 1
[    0.012279] SRAT: PXM 1 -> APIC 0x50 -> Node 1
[    0.012280] SRAT: PXM 1 -> APIC 0x52 -> Node 1
[    0.012282] SRAT: PXM 1 -> APIC 0x54 -> Node 1
[    0.012283] SRAT: PXM 1 -> APIC 0x56 -> Node 1
[    0.012284] SRAT: PXM 1 -> APIC 0x58 -> Node 1
[    0.012285] SRAT: PXM 1 -> APIC 0x60 -> Node 1
[    0.012286] SRAT: PXM 1 -> APIC 0x62 -> Node 1
[    0.012287] SRAT: PXM 1 -> APIC 0x64 -> Node 1
[    0.012288] SRAT: PXM 1 -> APIC 0x66 -> Node 1
[    0.012289] SRAT: PXM 1 -> APIC 0x68 -> Node 1
[    0.012290] SRAT: PXM 1 -> APIC 0x6a -> Node 1
[    0.012291] SRAT: PXM 1 -> APIC 0x70 -> Node 1
[    0.012293] SRAT: PXM 1 -> APIC 0x72 -> Node 1
[    0.012294] SRAT: PXM 1 -> APIC 0x74 -> Node 1
[    0.012295] SRAT: PXM 1 -> APIC 0x76 -> Node 1
[    0.012296] SRAT: PXM 1 -> APIC 0x78 -> Node 1
[    0.012297] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.012298] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.012299] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.012301] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.012302] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.012303] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.012304] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.012305] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.012306] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.012307] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.012308] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.012309] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.012310] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.012311] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.012312] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.012314] SRAT: PXM 0 -> APIC 0x29 -> Node 0
[    0.012315] SRAT: PXM 0 -> APIC 0x2b -> Node 0
[    0.012316] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    0.012317] SRAT: PXM 0 -> APIC 0x33 -> Node 0
[    0.012318] SRAT: PXM 0 -> APIC 0x35 -> Node 0
[    0.012319] SRAT: PXM 0 -> APIC 0x37 -> Node 0
[    0.012320] SRAT: PXM 0 -> APIC 0x39 -> Node 0
[    0.012321] SRAT: PXM 1 -> APIC 0x41 -> Node 1
[    0.012322] SRAT: PXM 1 -> APIC 0x43 -> Node 1
[    0.012323] SRAT: PXM 1 -> APIC 0x45 -> Node 1
[    0.012324] SRAT: PXM 1 -> APIC 0x47 -> Node 1
[    0.012325] SRAT: PXM 1 -> APIC 0x49 -> Node 1
[    0.012326] SRAT: PXM 1 -> APIC 0x4b -> Node 1
[    0.012328] SRAT: PXM 1 -> APIC 0x51 -> Node 1
[    0.012329] SRAT: PXM 1 -> APIC 0x53 -> Node 1
[    0.012330] SRAT: PXM 1 -> APIC 0x55 -> Node 1
[    0.012331] SRAT: PXM 1 -> APIC 0x57 -> Node 1
[    0.012332] SRAT: PXM 1 -> APIC 0x59 -> Node 1
[    0.012333] SRAT: PXM 1 -> APIC 0x61 -> Node 1
[    0.012334] SRAT: PXM 1 -> APIC 0x63 -> Node 1
[    0.012335] SRAT: PXM 1 -> APIC 0x65 -> Node 1
[    0.012336] SRAT: PXM 1 -> APIC 0x67 -> Node 1
[    0.012337] SRAT: PXM 1 -> APIC 0x69 -> Node 1
[    0.012338] SRAT: PXM 1 -> APIC 0x6b -> Node 1
[    0.012339] SRAT: PXM 1 -> APIC 0x71 -> Node 1
[    0.012340] SRAT: PXM 1 -> APIC 0x73 -> Node 1
[    0.012342] SRAT: PXM 1 -> APIC 0x75 -> Node 1
[    0.012343] SRAT: PXM 1 -> APIC 0x77 -> Node 1
[    0.012344] SRAT: PXM 1 -> APIC 0x79 -> Node 1
[    0.012347] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.012349] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x87fffffff]
[    0.012350] ACPI: SRAT: Node 1 PXM 1 [mem 0x880000000-0x107fffffff]
[    0.012360] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x10000000=
0-0x87fffffff] -> [mem 0x00000000-0x87fffffff]
[    0.012371] NODE_DATA(0) allocated [mem 0x87ffd6000-0x87fffffff]
[    0.012408] NODE_DATA(1) allocated [mem 0x107ffd5000-0x107fffefff]
[    0.012598] Reserving 512MB of memory at 1424MB for crashkernel (Syste=
m RAM: 65439MB)
[    0.012674] Zone ranges:
[    0.012676]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.012677]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.012679]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
[    0.012681]   Device   empty
[    0.012682] Movable zone start for each node
[    0.012686] Early memory node ranges
[    0.012688]   node   0: [mem 0x0000000000001000-0x000000000009afff]
[    0.012689]   node   0: [mem 0x0000000000100000-0x0000000079f9ffff]
[    0.012691]   node   0: [mem 0x000000007b7cd000-0x000000007b7fffff]
[    0.012692]   node   0: [mem 0x0000000100000000-0x000000087fffffff]
[    0.012695]   node   1: [mem 0x0000000880000000-0x000000107fffffff]
[    0.013116] Zeroed struct page in unavailable ranges: 24723 pages
[    0.013117] Initmem setup node 0 [mem 0x0000000000001000-0x000000087ff=
fffff]
[    0.027686] Initmem setup node 1 [mem 0x0000000880000000-0x000000107ff=
fffff]
[    0.028566] ACPI: PM-Timer IO Port: 0x408
[    0.028590] ACPI: LAPIC_NMI (acpi_id[0x00] high level lint[0x1])
[    0.028592] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.028593] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.028594] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.028595] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.028596] ACPI: LAPIC_NMI (acpi_id[0x05] high level lint[0x1])
[    0.028598] ACPI: LAPIC_NMI (acpi_id[0x06] high level lint[0x1])
[    0.028599] ACPI: LAPIC_NMI (acpi_id[0x07] high level lint[0x1])
[    0.028600] ACPI: LAPIC_NMI (acpi_id[0x08] high level lint[0x1])
[    0.028602] ACPI: LAPIC_NMI (acpi_id[0x09] high level lint[0x1])
[    0.028603] ACPI: LAPIC_NMI (acpi_id[0x0a] high level lint[0x1])
[    0.028604] ACPI: LAPIC_NMI (acpi_id[0x0b] high level lint[0x1])
[    0.028605] ACPI: LAPIC_NMI (acpi_id[0x0c] high level lint[0x1])
[    0.028606] ACPI: LAPIC_NMI (acpi_id[0x0d] high level lint[0x1])
[    0.028608] ACPI: LAPIC_NMI (acpi_id[0x0e] high level lint[0x1])
[    0.028609] ACPI: LAPIC_NMI (acpi_id[0x0f] high level lint[0x1])
[    0.028610] ACPI: LAPIC_NMI (acpi_id[0x10] high level lint[0x1])
[    0.028611] ACPI: LAPIC_NMI (acpi_id[0x11] high level lint[0x1])
[    0.028612] ACPI: LAPIC_NMI (acpi_id[0x12] high level lint[0x1])
[    0.028613] ACPI: LAPIC_NMI (acpi_id[0x13] high level lint[0x1])
[    0.028614] ACPI: LAPIC_NMI (acpi_id[0x14] high level lint[0x1])
[    0.028616] ACPI: LAPIC_NMI (acpi_id[0x15] high level lint[0x1])
[    0.028617] ACPI: LAPIC_NMI (acpi_id[0x16] high level lint[0x1])
[    0.028618] ACPI: LAPIC_NMI (acpi_id[0x17] high level lint[0x1])
[    0.028619] ACPI: LAPIC_NMI (acpi_id[0x18] high level lint[0x1])
[    0.028620] ACPI: LAPIC_NMI (acpi_id[0x19] high level lint[0x1])
[    0.028621] ACPI: LAPIC_NMI (acpi_id[0x1a] high level lint[0x1])
[    0.028623] ACPI: LAPIC_NMI (acpi_id[0x1b] high level lint[0x1])
[    0.028624] ACPI: LAPIC_NMI (acpi_id[0x1c] high level lint[0x1])
[    0.028625] ACPI: LAPIC_NMI (acpi_id[0x1d] high level lint[0x1])
[    0.028626] ACPI: LAPIC_NMI (acpi_id[0x1e] high level lint[0x1])
[    0.028627] ACPI: LAPIC_NMI (acpi_id[0x1f] high level lint[0x1])
[    0.028629] ACPI: LAPIC_NMI (acpi_id[0x20] high level lint[0x1])
[    0.028630] ACPI: LAPIC_NMI (acpi_id[0x21] high level lint[0x1])
[    0.028631] ACPI: LAPIC_NMI (acpi_id[0x22] high level lint[0x1])
[    0.028632] ACPI: LAPIC_NMI (acpi_id[0x23] high level lint[0x1])
[    0.028633] ACPI: LAPIC_NMI (acpi_id[0x24] high level lint[0x1])
[    0.028634] ACPI: LAPIC_NMI (acpi_id[0x25] high level lint[0x1])
[    0.028636] ACPI: LAPIC_NMI (acpi_id[0x26] high level lint[0x1])
[    0.028637] ACPI: LAPIC_NMI (acpi_id[0x27] high level lint[0x1])
[    0.028638] ACPI: LAPIC_NMI (acpi_id[0x28] high level lint[0x1])
[    0.028639] ACPI: LAPIC_NMI (acpi_id[0x29] high level lint[0x1])
[    0.028640] ACPI: LAPIC_NMI (acpi_id[0x2a] high level lint[0x1])
[    0.028641] ACPI: LAPIC_NMI (acpi_id[0x2b] high level lint[0x1])
[    0.028642] ACPI: LAPIC_NMI (acpi_id[0x2c] high level lint[0x1])
[    0.028644] ACPI: LAPIC_NMI (acpi_id[0x2d] high level lint[0x1])
[    0.028645] ACPI: LAPIC_NMI (acpi_id[0x2e] high level lint[0x1])
[    0.028646] ACPI: LAPIC_NMI (acpi_id[0x2f] high level lint[0x1])
[    0.028647] ACPI: LAPIC_NMI (acpi_id[0x30] high level lint[0x1])
[    0.028648] ACPI: LAPIC_NMI (acpi_id[0x31] high level lint[0x1])
[    0.028649] ACPI: LAPIC_NMI (acpi_id[0x32] high level lint[0x1])
[    0.028650] ACPI: LAPIC_NMI (acpi_id[0x33] high level lint[0x1])
[    0.028651] ACPI: LAPIC_NMI (acpi_id[0x34] high level lint[0x1])
[    0.028653] ACPI: LAPIC_NMI (acpi_id[0x35] high level lint[0x1])
[    0.028654] ACPI: LAPIC_NMI (acpi_id[0x36] high level lint[0x1])
[    0.028655] ACPI: LAPIC_NMI (acpi_id[0x37] high level lint[0x1])
[    0.028656] ACPI: LAPIC_NMI (acpi_id[0x38] high level lint[0x1])
[    0.028657] ACPI: LAPIC_NMI (acpi_id[0x39] high level lint[0x1])
[    0.028658] ACPI: LAPIC_NMI (acpi_id[0x3a] high level lint[0x1])
[    0.028660] ACPI: LAPIC_NMI (acpi_id[0x3b] high level lint[0x1])
[    0.028661] ACPI: LAPIC_NMI (acpi_id[0x3c] high level lint[0x1])
[    0.028662] ACPI: LAPIC_NMI (acpi_id[0x3d] high level lint[0x1])
[    0.028663] ACPI: LAPIC_NMI (acpi_id[0x3e] high level lint[0x1])
[    0.028665] ACPI: LAPIC_NMI (acpi_id[0x3f] high level lint[0x1])
[    0.028666] ACPI: LAPIC_NMI (acpi_id[0x40] high level lint[0x1])
[    0.028667] ACPI: LAPIC_NMI (acpi_id[0x41] high level lint[0x1])
[    0.028668] ACPI: LAPIC_NMI (acpi_id[0x42] high level lint[0x1])
[    0.028670] ACPI: LAPIC_NMI (acpi_id[0x43] high level lint[0x1])
[    0.028671] ACPI: LAPIC_NMI (acpi_id[0x44] high level lint[0x1])
[    0.028672] ACPI: LAPIC_NMI (acpi_id[0x45] high level lint[0x1])
[    0.028673] ACPI: LAPIC_NMI (acpi_id[0x46] high level lint[0x1])
[    0.028674] ACPI: LAPIC_NMI (acpi_id[0x47] high level lint[0x1])
[    0.028675] ACPI: LAPIC_NMI (acpi_id[0x48] high level lint[0x1])
[    0.028676] ACPI: LAPIC_NMI (acpi_id[0x49] high level lint[0x1])
[    0.028677] ACPI: LAPIC_NMI (acpi_id[0x4a] high level lint[0x1])
[    0.028679] ACPI: LAPIC_NMI (acpi_id[0x4b] high level lint[0x1])
[    0.028680] ACPI: LAPIC_NMI (acpi_id[0x4c] high level lint[0x1])
[    0.028681] ACPI: LAPIC_NMI (acpi_id[0x4d] high level lint[0x1])
[    0.028682] ACPI: LAPIC_NMI (acpi_id[0x4e] high level lint[0x1])
[    0.028683] ACPI: LAPIC_NMI (acpi_id[0x4f] high level lint[0x1])
[    0.028684] ACPI: LAPIC_NMI (acpi_id[0x50] high level lint[0x1])
[    0.028685] ACPI: LAPIC_NMI (acpi_id[0x51] high level lint[0x1])
[    0.028687] ACPI: LAPIC_NMI (acpi_id[0x52] high level lint[0x1])
[    0.028688] ACPI: LAPIC_NMI (acpi_id[0x53] high level lint[0x1])
[    0.028689] ACPI: LAPIC_NMI (acpi_id[0x54] high level lint[0x1])
[    0.028690] ACPI: LAPIC_NMI (acpi_id[0x55] high level lint[0x1])
[    0.028691] ACPI: LAPIC_NMI (acpi_id[0x56] high level lint[0x1])
[    0.028692] ACPI: LAPIC_NMI (acpi_id[0x57] high level lint[0x1])
[    0.028694] ACPI: LAPIC_NMI (acpi_id[0x58] high level lint[0x1])
[    0.028695] ACPI: LAPIC_NMI (acpi_id[0x59] high level lint[0x1])
[    0.028696] ACPI: LAPIC_NMI (acpi_id[0x5a] high level lint[0x1])
[    0.028697] ACPI: LAPIC_NMI (acpi_id[0x5b] high level lint[0x1])
[    0.028698] ACPI: LAPIC_NMI (acpi_id[0x5c] high level lint[0x1])
[    0.028700] ACPI: LAPIC_NMI (acpi_id[0x5d] high level lint[0x1])
[    0.028701] ACPI: LAPIC_NMI (acpi_id[0x5e] high level lint[0x1])
[    0.028702] ACPI: LAPIC_NMI (acpi_id[0x5f] high level lint[0x1])
[    0.028703] ACPI: LAPIC_NMI (acpi_id[0x60] high level lint[0x1])
[    0.028704] ACPI: LAPIC_NMI (acpi_id[0x61] high level lint[0x1])
[    0.028705] ACPI: LAPIC_NMI (acpi_id[0x62] high level lint[0x1])
[    0.028706] ACPI: LAPIC_NMI (acpi_id[0x63] high level lint[0x1])
[    0.028707] ACPI: LAPIC_NMI (acpi_id[0x64] high level lint[0x1])
[    0.028709] ACPI: LAPIC_NMI (acpi_id[0x65] high level lint[0x1])
[    0.028710] ACPI: LAPIC_NMI (acpi_id[0x66] high level lint[0x1])
[    0.028711] ACPI: LAPIC_NMI (acpi_id[0x67] high level lint[0x1])
[    0.028712] ACPI: LAPIC_NMI (acpi_id[0x68] high level lint[0x1])
[    0.028713] ACPI: LAPIC_NMI (acpi_id[0x69] high level lint[0x1])
[    0.028714] ACPI: LAPIC_NMI (acpi_id[0x6a] high level lint[0x1])
[    0.028715] ACPI: LAPIC_NMI (acpi_id[0x6b] high level lint[0x1])
[    0.028717] ACPI: LAPIC_NMI (acpi_id[0x6c] high level lint[0x1])
[    0.028718] ACPI: LAPIC_NMI (acpi_id[0x6d] high level lint[0x1])
[    0.028719] ACPI: LAPIC_NMI (acpi_id[0x6e] high level lint[0x1])
[    0.028720] ACPI: LAPIC_NMI (acpi_id[0x6f] high level lint[0x1])
[    0.028721] ACPI: LAPIC_NMI (acpi_id[0x70] high level lint[0x1])
[    0.028722] ACPI: LAPIC_NMI (acpi_id[0x71] high level lint[0x1])
[    0.028723] ACPI: LAPIC_NMI (acpi_id[0x72] high level lint[0x1])
[    0.028724] ACPI: LAPIC_NMI (acpi_id[0x73] high level lint[0x1])
[    0.028726] ACPI: LAPIC_NMI (acpi_id[0x74] high level lint[0x1])
[    0.028727] ACPI: LAPIC_NMI (acpi_id[0x75] high level lint[0x1])
[    0.028728] ACPI: LAPIC_NMI (acpi_id[0x76] high level lint[0x1])
[    0.028729] ACPI: LAPIC_NMI (acpi_id[0x77] high level lint[0x1])
[    0.028730] ACPI: LAPIC_NMI (acpi_id[0x78] high level lint[0x1])
[    0.028731] ACPI: LAPIC_NMI (acpi_id[0x79] high level lint[0x1])
[    0.028733] ACPI: LAPIC_NMI (acpi_id[0x7a] high level lint[0x1])
[    0.028734] ACPI: LAPIC_NMI (acpi_id[0x7b] high level lint[0x1])
[    0.028735] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.028736] ACPI: LAPIC_NMI (acpi_id[0x7c] high level lint[0x1])
[    0.028737] ACPI: LAPIC_NMI (acpi_id[0x7d] high level lint[0x1])
[    0.028739] ACPI: LAPIC_NMI (acpi_id[0x7e] high level lint[0x1])
[    0.028740] ACPI: LAPIC_NMI (acpi_id[0x7f] high level lint[0x1])
[    0.028741] ACPI: LAPIC_NMI (acpi_id[0x80] high level lint[0x1])
[    0.028742] ACPI: LAPIC_NMI (acpi_id[0x81] high level lint[0x1])
[    0.028743] ACPI: LAPIC_NMI (acpi_id[0x82] high level lint[0x1])
[    0.028744] ACPI: LAPIC_NMI (acpi_id[0x83] high level lint[0x1])
[    0.028745] ACPI: LAPIC_NMI (acpi_id[0x84] high level lint[0x1])
[    0.028747] ACPI: LAPIC_NMI (acpi_id[0x85] high level lint[0x1])
[    0.028748] ACPI: LAPIC_NMI (acpi_id[0x86] high level lint[0x1])
[    0.028749] ACPI: LAPIC_NMI (acpi_id[0x87] high level lint[0x1])
[    0.028750] ACPI: LAPIC_NMI (acpi_id[0x88] high level lint[0x1])
[    0.028751] ACPI: LAPIC_NMI (acpi_id[0x89] high level lint[0x1])
[    0.028752] ACPI: LAPIC_NMI (acpi_id[0x8a] high level lint[0x1])
[    0.028753] ACPI: LAPIC_NMI (acpi_id[0x8b] high level lint[0x1])
[    0.028754] ACPI: LAPIC_NMI (acpi_id[0x8c] high level lint[0x1])
[    0.028756] ACPI: LAPIC_NMI (acpi_id[0x8d] high level lint[0x1])
[    0.028757] ACPI: LAPIC_NMI (acpi_id[0x8f] high level lint[0x1])
[    0.028758] ACPI: LAPIC_NMI (acpi_id[0x90] high level lint[0x1])
[    0.028759] ACPI: LAPIC_NMI (acpi_id[0x91] high level lint[0x1])
[    0.028761] ACPI: LAPIC_NMI (acpi_id[0x92] high level lint[0x1])
[    0.028762] ACPI: LAPIC_NMI (acpi_id[0x93] high level lint[0x1])
[    0.028763] ACPI: LAPIC_NMI (acpi_id[0x94] high level lint[0x1])
[    0.028764] ACPI: LAPIC_NMI (acpi_id[0x95] high level lint[0x1])
[    0.028765] ACPI: LAPIC_NMI (acpi_id[0x96] high level lint[0x1])
[    0.028767] ACPI: LAPIC_NMI (acpi_id[0x97] high level lint[0x1])
[    0.028768] ACPI: LAPIC_NMI (acpi_id[0x98] high level lint[0x1])
[    0.028769] ACPI: LAPIC_NMI (acpi_id[0x99] high level lint[0x1])
[    0.028770] ACPI: LAPIC_NMI (acpi_id[0x9a] high level lint[0x1])
[    0.028771] ACPI: LAPIC_NMI (acpi_id[0x9b] high level lint[0x1])
[    0.028772] ACPI: LAPIC_NMI (acpi_id[0x9c] high level lint[0x1])
[    0.028773] ACPI: LAPIC_NMI (acpi_id[0x9d] high level lint[0x1])
[    0.028775] ACPI: LAPIC_NMI (acpi_id[0x9e] high level lint[0x1])
[    0.028776] ACPI: LAPIC_NMI (acpi_id[0x9f] high level lint[0x1])
[    0.028777] ACPI: LAPIC_NMI (acpi_id[0xa0] high level lint[0x1])
[    0.028778] ACPI: LAPIC_NMI (acpi_id[0xa1] high level lint[0x1])
[    0.028779] ACPI: LAPIC_NMI (acpi_id[0xa2] high level lint[0x1])
[    0.028780] ACPI: LAPIC_NMI (acpi_id[0xa3] high level lint[0x1])
[    0.028781] ACPI: LAPIC_NMI (acpi_id[0xa4] high level lint[0x1])
[    0.028782] ACPI: LAPIC_NMI (acpi_id[0xa5] high level lint[0x1])
[    0.028784] ACPI: LAPIC_NMI (acpi_id[0xa6] high level lint[0x1])
[    0.028785] ACPI: LAPIC_NMI (acpi_id[0xa7] high level lint[0x1])
[    0.028786] ACPI: LAPIC_NMI (acpi_id[0xa8] high level lint[0x1])
[    0.028787] ACPI: LAPIC_NMI (acpi_id[0xa9] high level lint[0x1])
[    0.028788] ACPI: LAPIC_NMI (acpi_id[0xaa] high level lint[0x1])
[    0.028789] ACPI: LAPIC_NMI (acpi_id[0xab] high level lint[0x1])
[    0.028790] ACPI: LAPIC_NMI (acpi_id[0xac] high level lint[0x1])
[    0.028792] ACPI: LAPIC_NMI (acpi_id[0xad] high level lint[0x1])
[    0.028793] ACPI: LAPIC_NMI (acpi_id[0xae] high level lint[0x1])
[    0.028794] ACPI: LAPIC_NMI (acpi_id[0xaf] high level lint[0x1])
[    0.028795] ACPI: LAPIC_NMI (acpi_id[0xb0] high level lint[0x1])
[    0.028796] ACPI: LAPIC_NMI (acpi_id[0xb1] high level lint[0x1])
[    0.028797] ACPI: LAPIC_NMI (acpi_id[0xb2] high level lint[0x1])
[    0.028798] ACPI: LAPIC_NMI (acpi_id[0xb3] high level lint[0x1])
[    0.028799] ACPI: LAPIC_NMI (acpi_id[0xb4] high level lint[0x1])
[    0.028801] ACPI: LAPIC_NMI (acpi_id[0xb5] high level lint[0x1])
[    0.028802] ACPI: LAPIC_NMI (acpi_id[0xb6] high level lint[0x1])
[    0.028803] ACPI: LAPIC_NMI (acpi_id[0xb7] high level lint[0x1])
[    0.028804] ACPI: LAPIC_NMI (acpi_id[0xb8] high level lint[0x1])
[    0.028805] ACPI: LAPIC_NMI (acpi_id[0xb9] high level lint[0x1])
[    0.028806] ACPI: LAPIC_NMI (acpi_id[0xba] high level lint[0x1])
[    0.028808] ACPI: LAPIC_NMI (acpi_id[0xbb] high level lint[0x1])
[    0.028809] ACPI: LAPIC_NMI (acpi_id[0xbc] high level lint[0x1])
[    0.028810] ACPI: LAPIC_NMI (acpi_id[0xbd] high level lint[0x1])
[    0.028811] ACPI: LAPIC_NMI (acpi_id[0xbe] high level lint[0x1])
[    0.028812] ACPI: LAPIC_NMI (acpi_id[0xbf] high level lint[0x1])
[    0.028823] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI =
0-23
[    0.028828] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI =
24-47
[    0.028833] IOAPIC[2]: apic_id 10, version 32, address 0xfec40000, GSI=
 48-71
[    0.028838] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.028840] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.028848] Using ACPI (MADT) for SMP configuration information
[    0.028850] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.028854] ACPI: SPCR: SPCR table version 1
[    0.028856] ACPI: SPCR: console: uart,io,0x3f8,115200
[    0.028859] smpboot: Allowing 88 CPUs, 0 hotplug CPUs
[    0.028876] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.028878] PM: Registered nosave memory: [mem 0x0009b000-0x0009bfff]
[    0.028879] PM: Registered nosave memory: [mem 0x0009c000-0x0009ffff]
[    0.028880] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.028881] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.028883] PM: Registered nosave memory: [mem 0x79fa0000-0x7ac4ffff]
[    0.028885] PM: Registered nosave memory: [mem 0x7ac50000-0x7b67ffff]
[    0.028886] PM: Registered nosave memory: [mem 0x7b680000-0x7b7ccfff]
[    0.028888] PM: Registered nosave memory: [mem 0x7b800000-0x8fffffff]
[    0.028889] PM: Registered nosave memory: [mem 0x90000000-0xfed1bfff]
[    0.028890] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.028891] PM: Registered nosave memory: [mem 0xfed20000-0xff3fffff]
[    0.028893] PM: Registered nosave memory: [mem 0xff400000-0xffffffff]
[    0.028895] [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.028896] Booting paravirtualized kernel on bare hardware
[    0.028899] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.142569] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:88 nr_cpu_ids:8=
8 nr_node_ids:2
[    0.149960] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
[    0.150054] Built 2 zonelists, mobility grouping on.  Total pages: 164=
90579
[    0.150056] Policy zone: Normal
[    0.150058] Kernel command line: BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-5.5=
.0-rc7+ root=3D/dev/mapper/intel--wildcatpass--07-root ro crashkernel=3D5=
12M resume=3D/dev/mapper/intel--wildcatpass--07-swap rd.lvm.lv=3Dintel-wi=
ldcatpass-07/root rd.lvm.lv=3Dintel-wildcatpass-07/swap console=3DttyS0,1=
15200n81
[    0.151328] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.195160] Memory: 1589000K/67009972K available (12292K kernel code, =
3223K rwdata, 4424K rodata, 2404K init, 7028K bss, 1777460K reserved, 0K =
cma-reserved)
[    0.195916] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D88=
, Nodes=3D2
[    0.195957] Kernel/User page tables isolation: enabled
[    0.196026] ftrace: allocating 37861 entries in 148 pages
[    0.212037] ftrace: allocated 148 pages with 3 groups
[    0.212776] rcu: Hierarchical RCU implementation.
[    0.212778] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_i=
ds=3D88.
[    0.212780] rcu: RCU calculated value of scheduler-enlistment delay is=
 100 jiffies.
[    0.212782] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D88
[    0.217070] NR_IRQS: 524544, nr_irqs: 1944, preallocated irqs: 16
[    0.217472] random: get_random_bytes called from start_kernel+0x365/0x=
53f with crng_init=3D0
[    0.223825] Console: colour VGA+ 80x25
[    2.948034] printk: console [ttyS0] enabled
[    2.952820] mempolicy: Enabling automatic NUMA balancing. Configure wi=
th numa_balancing=3D or the kernel.numa_balancing sysctl
[    2.965342] ACPI: Core revision 20191018
[    2.970907] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 133484882848 ns
[    2.981793] APIC: Switch to symmetric I/O mode setup
[    2.987465] x2apic: IRQ remapping doesn't support X2APIC mode
[    2.993957] Switched APIC routing to physical flat.
[    2.999997] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    3.010809] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x1fa36e579bf, max_idle_ns: 440795269840 ns
[    3.022555] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 4389.82 BogoMIPS (lpj=3D2194914)
[    3.023555] pid_max: default: 90112 minimum: 704
[    3.024728] LSM: Security Framework initializing
[    3.025582] Yama: becoming mindful.
[    3.026577] SELinux:  Initializing.
[    3.044018] Dentry cache hash table entries: 8388608 (order: 14, 67108=
864 bytes, vmalloc)
[    3.053158] Inode-cache hash table entries: 4194304 (order: 13, 335544=
32 bytes, vmalloc)
[    3.053889] Mount-cache hash table entries: 131072 (order: 8, 1048576 =
bytes, vmalloc)
[    3.054831] Mountpoint-cache hash table entries: 131072 (order: 8, 104=
8576 bytes, vmalloc)
[    3.057105] mce: CPU0: Thermal monitoring enabled (TM1)
[    3.057613] process: using mwait in idle threads
[    3.058558] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    3.059554] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    3.060557] Spectre V1 : Mitigation: usercopy/swapgs barriers and __us=
er pointer sanitization
[    3.061556] Spectre V2 : Mitigation: Full generic retpoline
[    3.062554] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on context switch
[    3.063554] Spectre V2 : Enabling Restricted Speculation for firmware =
calls
[    3.064556] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
[    3.065554] Spectre V2 : User space: Mitigation: STIBP via seccomp and=
 prctl
[    3.066554] Speculative Store Bypass: Vulnerable
[    3.067557] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    3.068554] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    3.070647] Freeing SMP alternatives memory: 32K
[    3.073741] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz (=
family: 0x6, model: 0x4f, stepping: 0x1)
[    3.074823] Performance Events: PEBS fmt2+, Broadwell events, 16-deep =
LBR, full-width counters, Intel PMU driver.
[    3.075556] ... version:                3
[    3.076555] ... bit width:              48
[    3.077555] ... generic registers:      4
[    3.078555] ... value mask:             0000ffffffffffff
[    3.079555] ... max period:             00007fffffffffff
[    3.080555] ... fixed-purpose events:   3
[    3.081555] ... event mask:             000000070000000f
[    3.082667] rcu: Hierarchical SRCU implementation.
[    3.093552] NMI watchdog: Enabled. Permanently consumes one hw-PMU cou=
nter.
[    3.094788] smp: Bringing up secondary CPUs ...
[    3.095642] x86: Booting SMP configuration:
[    3.096556] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8=
  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21
[    3.150556] .... node  #1, CPUs:   #22
[    2.797134] smpboot: CPU 22 Converting physical 0 to logical die 1
[    3.226695]  #23 #24 #25 #26 #27 #28 #29 #30 #31 #32 #33 #34 #35 #36 #=
37 #38 #39 #40 #41 #42 #43
[    3.287556] .... node  #0, CPUs:   #44
[    3.288760] MDS CPU bug present and SMT on, data leak possible. See ht=
tps://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for mor=
e details.
[    3.290556] TAA CPU bug present and SMT on, data leak possible. See ht=
tps://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.=
html for more details.
[    3.291718]  #45 #46 #47 #48 #49 #50 #51 #52 #53 #54 #55 #56 #57 #58 #=
59 #60 #61 #62 #63 #64 #65
[    3.347557] .... node  #1, CPUs:   #66 #67 #68 #69 #70 #71 #72 #73 #74=
 #75 #76 #77 #78 #79 #80 #81 #82 #83 #84 #85 #86 #87
[    3.408760] smp: Brought up 2 nodes, 88 CPUs
[    3.410556] smpboot: Max logical packages: 2
[    3.411559] smpboot: Total of 88 processors activated (386613.74 BogoM=
IPS)
[    3.564568] node 0 initialised, 7688738 pages in 149ms
[    3.575570] node 1 initialised, 8222140 pages in 160ms
[    3.583666] devtmpfs: initialized
[    3.586641] x86/mm: Memory block size: 2048MB
[    3.592601] PM: Registering ACPI NVS region [mem 0x7ac50000-0x7b67ffff=
] (10682368 bytes)
[    3.602577] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446275000 ns
[    3.612647] futex hash table entries: 32768 (order: 9, 2097152 bytes, =
vmalloc)
[    3.622514] pinctrl core: initialized pinctrl subsystem
[    3.627598] thermal_sys: Registered thermal governor 'fair_share'
[    3.627599] thermal_sys: Registered thermal governor 'bang_bang'
[    3.634556] thermal_sys: Registered thermal governor 'step_wise'
[    3.641556] thermal_sys: Registered thermal governor 'user_space'
[    3.648864] NET: Registered protocol family 16
[    3.660691] audit: initializing netlink subsys (disabled)
[    3.666589] audit: type=3D2000 audit(1580801596.653:1): state=3Dinitia=
lized audit_enabled=3D0 res=3D1
[    3.675560] cpuidle: using governor menu
[    3.680664] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
[    3.689557] ACPI: bus type PCI registered
[    3.693556] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    3.700762] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x800000=
00-0x8fffffff] (base 0x80000000)
[    3.711598] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E=
820
[    3.719573] PCI: Using configuration type 1 for base access
[    3.732804] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pag=
es
[    3.739560] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    3.787708] cryptd: max_cpu_qlen set to 1000
[    3.804763] ACPI: Added _OSI(Module Device)
[    3.809557] ACPI: Added _OSI(Processor Device)
[    3.814556] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.819555] ACPI: Added _OSI(Processor Aggregator Device)
[    3.825556] ACPI: Added _OSI(Linux-Dell-Video)
[    3.830555] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    3.836555] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    3.985794] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    4.008810] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    4.020553] ACPI: Dynamic OEM Table Load:
[    4.065460] ACPI: Interpreter enabled
[    4.069569] ACPI: (supports S0 S5)
[    4.073556] ACPI: Using IOAPIC for interrupt routing
[    4.078626] HEST: Table parsing has been initialized.
[    4.084559] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[    4.095551] ACPI: Enabled 6 GPEs in block 00 to 3F
[    4.139162] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    4.146561] acpi PNP0A03:02: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
[    4.158562] acpi PNP0A03:02: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
[    4.167414] acpi PNP0A03:02: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
[    4.176556] acpi PNP0A03:02: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    4.185601] PCI host bridge to bus 0000:ff
[    4.189556] pci_bus 0000:ff: Unknown NUMA node; performance will be re=
duced
[    4.197557] pci_bus 0000:ff: root bus resource [bus ff]
[    4.203567] pci 0000:ff:08.0: [8086:6f80] type 00 class 0x088000
[    4.209635] pci 0000:ff:08.2: [8086:6f32] type 00 class 0x110100
[    4.216606] pci 0000:ff:08.3: [8086:6f83] type 00 class 0x088000
[    4.223622] pci 0000:ff:09.0: [8086:6f90] type 00 class 0x088000
[    4.230604] pci 0000:ff:09.2: [8086:6f33] type 00 class 0x110100
[    4.236603] pci 0000:ff:09.3: [8086:6f93] type 00 class 0x088000
[    4.243616] pci 0000:ff:0b.0: [8086:6f81] type 00 class 0x088000
[    4.250600] pci 0000:ff:0b.1: [8086:6f36] type 00 class 0x110100
[    4.257605] pci 0000:ff:0b.2: [8086:6f37] type 00 class 0x110100
[    4.263604] pci 0000:ff:0b.3: [8086:6f76] type 00 class 0x088000
[    4.270610] pci 0000:ff:0c.0: [8086:6fe0] type 00 class 0x088000
[    4.277601] pci 0000:ff:0c.1: [8086:6fe1] type 00 class 0x088000
[    4.284601] pci 0000:ff:0c.2: [8086:6fe2] type 00 class 0x088000
[    4.290600] pci 0000:ff:0c.3: [8086:6fe3] type 00 class 0x088000
[    4.297600] pci 0000:ff:0c.4: [8086:6fe4] type 00 class 0x088000
[    4.304600] pci 0000:ff:0c.5: [8086:6fe5] type 00 class 0x088000
[    4.310602] pci 0000:ff:0c.6: [8086:6fe6] type 00 class 0x088000
[    4.317605] pci 0000:ff:0c.7: [8086:6fe7] type 00 class 0x088000
[    4.324601] pci 0000:ff:0d.0: [8086:6fe8] type 00 class 0x088000
[    4.331607] pci 0000:ff:0d.1: [8086:6fe9] type 00 class 0x088000
[    4.337606] pci 0000:ff:0d.2: [8086:6fea] type 00 class 0x088000
[    4.344602] pci 0000:ff:0d.3: [8086:6feb] type 00 class 0x088000
[    4.351601] pci 0000:ff:0d.4: [8086:6fec] type 00 class 0x088000
[    4.357602] pci 0000:ff:0d.5: [8086:6fed] type 00 class 0x088000
[    4.364605] pci 0000:ff:0d.6: [8086:6fee] type 00 class 0x088000
[    4.371602] pci 0000:ff:0d.7: [8086:6fef] type 00 class 0x088000
[    4.378603] pci 0000:ff:0e.0: [8086:6ff0] type 00 class 0x088000
[    4.384602] pci 0000:ff:0e.1: [8086:6ff1] type 00 class 0x088000
[    4.391604] pci 0000:ff:0e.2: [8086:6ff2] type 00 class 0xffffff
[    4.398602] pci 0000:ff:0e.3: [8086:6ff3] type 00 class 0xffffff
[    4.405602] pci 0000:ff:0e.4: [8086:6ff4] type 00 class 0xffffff
[    4.411603] pci 0000:ff:0e.5: [8086:6ff5] type 00 class 0xffffff
[    4.418608] pci 0000:ff:0f.0: [8086:6ff8] type 00 class 0x088000
[    4.425606] pci 0000:ff:0f.1: [8086:6ff9] type 00 class 0x088000
[    4.431603] pci 0000:ff:0f.2: [8086:6ffa] type 00 class 0x088000
[    4.438602] pci 0000:ff:0f.3: [8086:6ffb] type 00 class 0x088000
[    4.445603] pci 0000:ff:0f.4: [8086:6ffc] type 00 class 0x088000
[    4.452603] pci 0000:ff:0f.5: [8086:6ffd] type 00 class 0x088000
[    4.458603] pci 0000:ff:0f.6: [8086:6ffe] type 00 class 0x088000
[    4.465604] pci 0000:ff:10.0: [8086:6f1d] type 00 class 0x088000
[    4.472605] pci 0000:ff:10.1: [8086:6f34] type 00 class 0x110100
[    4.479609] pci 0000:ff:10.5: [8086:6f1e] type 00 class 0x088000
[    4.485601] pci 0000:ff:10.6: [8086:6f7d] type 00 class 0x110100
[    4.492601] pci 0000:ff:10.7: [8086:6f1f] type 00 class 0x088000
[    4.499601] pci 0000:ff:12.0: [8086:6fa0] type 00 class 0x088000
[    4.506590] pci 0000:ff:12.1: [8086:6f30] type 00 class 0x110100
[    4.512604] pci 0000:ff:12.4: [8086:6f60] type 00 class 0x088000
[    4.519593] pci 0000:ff:12.5: [8086:6f38] type 00 class 0x110100
[    4.526609] pci 0000:ff:13.0: [8086:6fa8] type 00 class 0x088000
[    4.532641] pci 0000:ff:13.1: [8086:6f71] type 00 class 0x088000
[    4.539616] pci 0000:ff:13.2: [8086:6faa] type 00 class 0x088000
[    4.546617] pci 0000:ff:13.3: [8086:6fab] type 00 class 0x088000
[    4.553621] pci 0000:ff:13.6: [8086:6fae] type 00 class 0x088000
[    4.559604] pci 0000:ff:13.7: [8086:6faf] type 00 class 0x088000
[    4.566606] pci 0000:ff:14.0: [8086:6fb0] type 00 class 0x088000
[    4.573622] pci 0000:ff:14.1: [8086:6fb1] type 00 class 0x088000
[    4.580617] pci 0000:ff:14.2: [8086:6fb2] type 00 class 0x088000
[    4.586620] pci 0000:ff:14.3: [8086:6fb3] type 00 class 0x088000
[    4.593615] pci 0000:ff:14.4: [8086:6fbc] type 00 class 0x088000
[    4.600604] pci 0000:ff:14.5: [8086:6fbd] type 00 class 0x088000
[    4.607605] pci 0000:ff:14.6: [8086:6fbe] type 00 class 0x088000
[    4.613603] pci 0000:ff:14.7: [8086:6fbf] type 00 class 0x088000
[    4.620607] pci 0000:ff:16.0: [8086:6f68] type 00 class 0x088000
[    4.627642] pci 0000:ff:16.1: [8086:6f79] type 00 class 0x088000
[    4.634618] pci 0000:ff:16.2: [8086:6f6a] type 00 class 0x088000
[    4.640621] pci 0000:ff:16.3: [8086:6f6b] type 00 class 0x088000
[    4.647618] pci 0000:ff:16.6: [8086:6f6e] type 00 class 0x088000
[    4.654604] pci 0000:ff:16.7: [8086:6f6f] type 00 class 0x088000
[    4.660606] pci 0000:ff:17.0: [8086:6fd0] type 00 class 0x088000
[    4.667643] pci 0000:ff:17.1: [8086:6fd1] type 00 class 0x088000
[    4.674617] pci 0000:ff:17.2: [8086:6fd2] type 00 class 0x088000
[    4.681618] pci 0000:ff:17.3: [8086:6fd3] type 00 class 0x088000
[    4.687617] pci 0000:ff:17.4: [8086:6fb8] type 00 class 0x088000
[    4.694609] pci 0000:ff:17.5: [8086:6fb9] type 00 class 0x088000
[    4.701603] pci 0000:ff:17.6: [8086:6fba] type 00 class 0x088000
[    4.708604] pci 0000:ff:17.7: [8086:6fbb] type 00 class 0x088000
[    4.714616] pci 0000:ff:1e.0: [8086:6f98] type 00 class 0x088000
[    4.721602] pci 0000:ff:1e.1: [8086:6f99] type 00 class 0x088000
[    4.728602] pci 0000:ff:1e.2: [8086:6f9a] type 00 class 0x088000
[    4.735608] pci 0000:ff:1e.3: [8086:6fc0] type 00 class 0x088000
[    4.741592] pci 0000:ff:1e.4: [8086:6f9c] type 00 class 0x088000
[    4.748609] pci 0000:ff:1f.0: [8086:6f88] type 00 class 0x088000
[    4.755604] pci 0000:ff:1f.2: [8086:6f8a] type 00 class 0x088000
[    4.761700] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    4.768558] acpi PNP0A03:03: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
[    4.779073] acpi PNP0A03:03: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
[    4.788417] acpi PNP0A03:03: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
[    4.797557] acpi PNP0A03:03: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    4.806598] PCI host bridge to bus 0000:7f
[    4.810556] pci_bus 0000:7f: Unknown NUMA node; performance will be re=
duced
[    4.818556] pci_bus 0000:7f: root bus resource [bus 7f]
[    4.824565] pci 0000:7f:08.0: [8086:6f80] type 00 class 0x088000
[    4.831614] pci 0000:7f:08.2: [8086:6f32] type 00 class 0x110100
[    4.837612] pci 0000:7f:08.3: [8086:6f83] type 00 class 0x088000
[    4.844625] pci 0000:7f:09.0: [8086:6f90] type 00 class 0x088000
[    4.851609] pci 0000:7f:09.2: [8086:6f33] type 00 class 0x110100
[    4.858612] pci 0000:7f:09.3: [8086:6f93] type 00 class 0x088000
[    4.864629] pci 0000:7f:0b.0: [8086:6f81] type 00 class 0x088000
[    4.871607] pci 0000:7f:0b.1: [8086:6f36] type 00 class 0x110100
[    4.878605] pci 0000:7f:0b.2: [8086:6f37] type 00 class 0x110100
[    4.884605] pci 0000:7f:0b.3: [8086:6f76] type 00 class 0x088000
[    4.891609] pci 0000:7f:0c.0: [8086:6fe0] type 00 class 0x088000
[    4.898606] pci 0000:7f:0c.1: [8086:6fe1] type 00 class 0x088000
[    4.905607] pci 0000:7f:0c.2: [8086:6fe2] type 00 class 0x088000
[    4.911610] pci 0000:7f:0c.3: [8086:6fe3] type 00 class 0x088000
[    4.918608] pci 0000:7f:0c.4: [8086:6fe4] type 00 class 0x088000
[    4.925606] pci 0000:7f:0c.5: [8086:6fe5] type 00 class 0x088000
[    4.932609] pci 0000:7f:0c.6: [8086:6fe6] type 00 class 0x088000
[    4.938607] pci 0000:7f:0c.7: [8086:6fe7] type 00 class 0x088000
[    4.945608] pci 0000:7f:0d.0: [8086:6fe8] type 00 class 0x088000
[    4.952606] pci 0000:7f:0d.1: [8086:6fe9] type 00 class 0x088000
[    4.959615] pci 0000:7f:0d.2: [8086:6fea] type 00 class 0x088000
[    4.965626] pci 0000:7f:0d.3: [8086:6feb] type 00 class 0x088000
[    4.972608] pci 0000:7f:0d.4: [8086:6fec] type 00 class 0x088000
[    4.979611] pci 0000:7f:0d.5: [8086:6fed] type 00 class 0x088000
[    4.985608] pci 0000:7f:0d.6: [8086:6fee] type 00 class 0x088000
[    4.992607] pci 0000:7f:0d.7: [8086:6fef] type 00 class 0x088000
[    4.999608] pci 0000:7f:0e.0: [8086:6ff0] type 00 class 0x088000
[    5.006607] pci 0000:7f:0e.1: [8086:6ff1] type 00 class 0x088000
[    5.012607] pci 0000:7f:0e.2: [8086:6ff2] type 00 class 0xffffff
[    5.019610] pci 0000:7f:0e.3: [8086:6ff3] type 00 class 0xffffff
[    5.026615] pci 0000:7f:0e.4: [8086:6ff4] type 00 class 0xffffff
[    5.033609] pci 0000:7f:0e.5: [8086:6ff5] type 00 class 0xffffff
[    5.039611] pci 0000:7f:0f.0: [8086:6ff8] type 00 class 0x088000
[    5.046607] pci 0000:7f:0f.1: [8086:6ff9] type 00 class 0x088000
[    5.053608] pci 0000:7f:0f.2: [8086:6ffa] type 00 class 0x088000
[    5.060608] pci 0000:7f:0f.3: [8086:6ffb] type 00 class 0x088000
[    5.066609] pci 0000:7f:0f.4: [8086:6ffc] type 00 class 0x088000
[    5.073617] pci 0000:7f:0f.5: [8086:6ffd] type 00 class 0x088000
[    5.080609] pci 0000:7f:0f.6: [8086:6ffe] type 00 class 0x088000
[    5.087612] pci 0000:7f:10.0: [8086:6f1d] type 00 class 0x088000
[    5.093608] pci 0000:7f:10.1: [8086:6f34] type 00 class 0x110100
[    5.100611] pci 0000:7f:10.5: [8086:6f1e] type 00 class 0x088000
[    5.107607] pci 0000:7f:10.6: [8086:6f7d] type 00 class 0x110100
[    5.113606] pci 0000:7f:10.7: [8086:6f1f] type 00 class 0x088000
[    5.120607] pci 0000:7f:12.0: [8086:6fa0] type 00 class 0x088000
[    5.127596] pci 0000:7f:12.1: [8086:6f30] type 00 class 0x110100
[    5.134614] pci 0000:7f:12.4: [8086:6f60] type 00 class 0x088000
[    5.140594] pci 0000:7f:12.5: [8086:6f38] type 00 class 0x110100
[    5.147618] pci 0000:7f:13.0: [8086:6fa8] type 00 class 0x088000
[    5.154654] pci 0000:7f:13.1: [8086:6f71] type 00 class 0x088000
[    5.161630] pci 0000:7f:13.2: [8086:6faa] type 00 class 0x088000
[    5.167628] pci 0000:7f:13.3: [8086:6fab] type 00 class 0x088000
[    5.174628] pci 0000:7f:13.6: [8086:6fae] type 00 class 0x088000
[    5.181618] pci 0000:7f:13.7: [8086:6faf] type 00 class 0x088000
[    5.188613] pci 0000:7f:14.0: [8086:6fb0] type 00 class 0x088000
[    5.194628] pci 0000:7f:14.1: [8086:6fb1] type 00 class 0x088000
[    5.201629] pci 0000:7f:14.2: [8086:6fb2] type 00 class 0x088000
[    5.208627] pci 0000:7f:14.3: [8086:6fb3] type 00 class 0x088000
[    5.215626] pci 0000:7f:14.4: [8086:6fbc] type 00 class 0x088000
[    5.221611] pci 0000:7f:14.5: [8086:6fbd] type 00 class 0x088000
[    5.228611] pci 0000:7f:14.6: [8086:6fbe] type 00 class 0x088000
[    5.235613] pci 0000:7f:14.7: [8086:6fbf] type 00 class 0x088000
[    5.242621] pci 0000:7f:16.0: [8086:6f68] type 00 class 0x088000
[    5.248655] pci 0000:7f:16.1: [8086:6f79] type 00 class 0x088000
[    5.255635] pci 0000:7f:16.2: [8086:6f6a] type 00 class 0x088000
[    5.262629] pci 0000:7f:16.3: [8086:6f6b] type 00 class 0x088000
[    5.269630] pci 0000:7f:16.6: [8086:6f6e] type 00 class 0x088000
[    5.275613] pci 0000:7f:16.7: [8086:6f6f] type 00 class 0x088000
[    5.282614] pci 0000:7f:17.0: [8086:6fd0] type 00 class 0x088000
[    5.289657] pci 0000:7f:17.1: [8086:6fd1] type 00 class 0x088000
[    5.296631] pci 0000:7f:17.2: [8086:6fd2] type 00 class 0x088000
[    5.302630] pci 0000:7f:17.3: [8086:6fd3] type 00 class 0x088000
[    5.309633] pci 0000:7f:17.4: [8086:6fb8] type 00 class 0x088000
[    5.316612] pci 0000:7f:17.5: [8086:6fb9] type 00 class 0x088000
[    5.323612] pci 0000:7f:17.6: [8086:6fba] type 00 class 0x088000
[    5.329613] pci 0000:7f:17.7: [8086:6fbb] type 00 class 0x088000
[    5.336625] pci 0000:7f:1e.0: [8086:6f98] type 00 class 0x088000
[    5.343611] pci 0000:7f:1e.1: [8086:6f99] type 00 class 0x088000
[    5.350609] pci 0000:7f:1e.2: [8086:6f9a] type 00 class 0x088000
[    5.356611] pci 0000:7f:1e.3: [8086:6fc0] type 00 class 0x088000
[    5.363596] pci 0000:7f:1e.4: [8086:6f9c] type 00 class 0x088000
[    5.370615] pci 0000:7f:1f.0: [8086:6f88] type 00 class 0x088000
[    5.377610] pci 0000:7f:1f.2: [8086:6f8a] type 00 class 0x088000
[    5.401517] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    5.408560] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
[    5.419056] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
[    5.428417] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
[    5.436556] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    5.446866] PCI host bridge to bus 0000:00
[    5.450558] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wind=
ow]
[    5.458556] pci_bus 0000:00: root bus resource [io  0x1000-0x7fff wind=
ow]
[    5.465556] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
[    5.474556] pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffb=
fff window]
[    5.482556] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x3=
83fffffffff window]
[    5.491556] pci_bus 0000:00: root bus resource [bus 00-7e]
[    5.497564] pci 0000:00:00.0: [8086:6f00] type 00 class 0x060000
[    5.504737] pci 0000:00:01.0: [8086:6f02] type 01 class 0x060400
[    5.511625] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    5.518710] pci 0000:00:02.0: [8086:6f04] type 01 class 0x060400
[    5.525623] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    5.531698] pci 0000:00:02.2: [8086:6f06] type 01 class 0x060400
[    5.538623] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    5.545696] pci 0000:00:03.0: [8086:6f08] type 01 class 0x060400
[    5.552622] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    5.559700] pci 0000:00:04.0: [8086:6f20] type 00 class 0x088000
[    5.566570] pci 0000:00:04.0: reg 0x10: [mem 0x383ffff2c000-0x383ffff2=
ffff 64bit]
[    5.574708] pci 0000:00:04.1: [8086:6f21] type 00 class 0x088000
[    5.581568] pci 0000:00:04.1: reg 0x10: [mem 0x383ffff28000-0x383ffff2=
bfff 64bit]
[    5.589704] pci 0000:00:04.2: [8086:6f22] type 00 class 0x088000
[    5.596568] pci 0000:00:04.2: reg 0x10: [mem 0x383ffff24000-0x383ffff2=
7fff 64bit]
[    5.604700] pci 0000:00:04.3: [8086:6f23] type 00 class 0x088000
[    5.611568] pci 0000:00:04.3: reg 0x10: [mem 0x383ffff20000-0x383ffff2=
3fff 64bit]
[    5.619705] pci 0000:00:04.4: [8086:6f24] type 00 class 0x088000
[    5.626568] pci 0000:00:04.4: reg 0x10: [mem 0x383ffff1c000-0x383ffff1=
ffff 64bit]
[    5.635706] pci 0000:00:04.5: [8086:6f25] type 00 class 0x088000
[    5.641568] pci 0000:00:04.5: reg 0x10: [mem 0x383ffff18000-0x383ffff1=
bfff 64bit]
[    5.650701] pci 0000:00:04.6: [8086:6f26] type 00 class 0x088000
[    5.657568] pci 0000:00:04.6: reg 0x10: [mem 0x383ffff14000-0x383ffff1=
7fff 64bit]
[    5.665707] pci 0000:00:04.7: [8086:6f27] type 00 class 0x088000
[    5.672570] pci 0000:00:04.7: reg 0x10: [mem 0x383ffff10000-0x383ffff1=
3fff 64bit]
[    5.680690] pci 0000:00:05.0: [8086:6f28] type 00 class 0x088000
[    5.687696] pci 0000:00:05.1: [8086:6f29] type 00 class 0x088000
[    5.694710] pci 0000:00:05.2: [8086:6f2a] type 00 class 0x088000
[    5.701682] pci 0000:00:05.4: [8086:6f2c] type 00 class 0x080020
[    5.707565] pci 0000:00:05.4: reg 0x10: [mem 0x91d06000-0x91d06fff]
[    5.714697] pci 0000:00:11.0: [8086:8d7c] type 00 class 0xff0000
[    5.721763] pci 0000:00:11.1: [8086:8d7d] type 00 class 0x0c0500
[    5.728576] pci 0000:00:11.1: reg 0x10: [mem 0x91d05000-0x91d05fff]
[    5.735588] pci 0000:00:11.1: reg 0x20: [io  0x3060-0x307f]
[    5.741737] pci 0000:00:11.4: [8086:8d62] type 00 class 0x010601
[    5.748576] pci 0000:00:11.4: reg 0x10: [io  0x3098-0x309f]
[    5.755563] pci 0000:00:11.4: reg 0x14: [io  0x30cc-0x30cf]
[    5.761563] pci 0000:00:11.4: reg 0x18: [io  0x3090-0x3097]
[    5.767563] pci 0000:00:11.4: reg 0x1c: [io  0x30c8-0x30cb]
[    5.773563] pci 0000:00:11.4: reg 0x20: [io  0x3020-0x303f]
[    5.779563] pci 0000:00:11.4: reg 0x24: [mem 0x91d00000-0x91d007ff]
[    5.786600] pci 0000:00:11.4: PME# supported from D3hot
[    5.792670] pci 0000:00:14.0: [8086:8d31] type 00 class 0x0c0330
[    5.799576] pci 0000:00:14.0: reg 0x10: [mem 0x383ffff00000-0x383ffff0=
ffff 64bit]
[    5.807618] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    5.814665] pci 0000:00:16.0: [8086:8d3a] type 00 class 0x078000
[    5.821577] pci 0000:00:16.0: reg 0x10: [mem 0x383ffff33000-0x383ffff3=
300f 64bit]
[    5.829620] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    5.836659] pci 0000:00:16.1: [8086:8d3b] type 00 class 0x078000
[    5.843576] pci 0000:00:16.1: reg 0x10: [mem 0x383ffff32000-0x383ffff3=
200f 64bit]
[    5.851619] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    5.858672] pci 0000:00:1a.0: [8086:8d2d] type 00 class 0x0c0320
[    5.865577] pci 0000:00:1a.0: reg 0x10: [mem 0x91d02000-0x91d023ff]
[    5.872641] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    5.878681] pci 0000:00:1c.0: [8086:8d10] type 01 class 0x060400
[    5.885640] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    5.892707] pci 0000:00:1c.3: [8086:8d16] type 01 class 0x060400
[    5.899641] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    5.906701] pci 0000:00:1d.0: [8086:8d26] type 00 class 0x0c0320
[    5.913577] pci 0000:00:1d.0: reg 0x10: [mem 0x91d01000-0x91d013ff]
[    5.920642] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    5.926672] pci 0000:00:1f.0: [8086:8d44] type 00 class 0x060100
[    5.933773] pci 0000:00:1f.2: [8086:8d02] type 00 class 0x010601
[    5.940572] pci 0000:00:1f.2: reg 0x10: [io  0x30c0-0x30c7]
[    5.946562] pci 0000:00:1f.2: reg 0x14: [io  0x30dc-0x30df]
[    5.953562] pci 0000:00:1f.2: reg 0x18: [io  0x30b8-0x30bf]
[    5.959561] pci 0000:00:1f.2: reg 0x1c: [io  0x30d8-0x30db]
[    5.965562] pci 0000:00:1f.2: reg 0x20: [io  0x3040-0x305f]
[    5.971562] pci 0000:00:1f.2: reg 0x24: [mem 0x91d04000-0x91d047ff]
[    5.978593] pci 0000:00:1f.2: PME# supported from D3hot
[    5.984678] pci 0000:00:1f.3: [8086:8d22] type 00 class 0x0c0500
[    5.991573] pci 0000:00:1f.3: reg 0x10: [mem 0x383ffff31000-0x383ffff3=
10ff 64bit]
[    5.999575] pci 0000:00:1f.3: reg 0x20: [io  0x3000-0x301f]
[    6.005851] pci 0000:00:01.0: PCI bridge to [bus 01]
[    6.011715] pci 0000:00:02.0: PCI bridge to [bus 02]
[    6.017729] pci 0000:03:00.0: [8086:1528] type 00 class 0x020000
[    6.024576] pci 0000:03:00.0: reg 0x10: [mem 0x383fffc00000-0x383fffdf=
ffff 64bit pref]
[    6.033576] pci 0000:03:00.0: reg 0x18: [io  0x2020-0x203f]
[    6.039571] pci 0000:03:00.0: reg 0x20: [mem 0x383fffe04000-0x383fffe0=
7fff 64bit pref]
[    6.048618] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    6.054579] pci 0000:03:00.0: reg 0x184: [mem 0x91900000-0x91903fff 64=
bit]
[    6.062557] pci 0000:03:00.0: VF(n) BAR0 space: [mem 0x91900000-0x919f=
ffff 64bit] (contains BAR0 for 64 VFs)
[    6.073568] pci 0000:03:00.0: reg 0x190: [mem 0x91a00000-0x91a03fff 64=
bit]
[    6.081556] pci 0000:03:00.0: VF(n) BAR3 space: [mem 0x91a00000-0x91af=
ffff 64bit] (contains BAR3 for 64 VFs)
[    6.092775] pci 0000:03:00.1: [8086:1528] type 00 class 0x020000
[    6.098576] pci 0000:03:00.1: reg 0x10: [mem 0x383fffa00000-0x383fffbf=
ffff 64bit pref]
[    6.107562] pci 0000:03:00.1: reg 0x18: [io  0x2000-0x201f]
[    6.114570] pci 0000:03:00.1: reg 0x20: [mem 0x383fffe00000-0x383fffe0=
3fff 64bit pref]
[    6.122617] pci 0000:03:00.1: PME# supported from D0 D3hot D3cold
[    6.129575] pci 0000:03:00.1: reg 0x184: [mem 0x91b00000-0x91b03fff 64=
bit]
[    6.137556] pci 0000:03:00.1: VF(n) BAR0 space: [mem 0x91b00000-0x91bf=
ffff 64bit] (contains BAR0 for 64 VFs)
[    6.148569] pci 0000:03:00.1: reg 0x190: [mem 0x91c00000-0x91c03fff 64=
bit]
[    6.155556] pci 0000:03:00.1: VF(n) BAR3 space: [mem 0x91c00000-0x91cf=
ffff 64bit] (contains BAR3 for 64 VFs)
[    6.166775] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    6.172557] pci 0000:00:02.2:   bridge window [io  0x2000-0x2fff]
[    6.179557] pci 0000:00:02.2:   bridge window [mem 0x91900000-0x91cfff=
ff]
[    6.187558] pci 0000:00:02.2:   bridge window [mem 0x383fffa00000-0x38=
3fffefffff 64bit pref]
[    6.196706] pci 0000:00:03.0: PCI bridge to [bus 05]
[    6.202603] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    6.207621] pci 0000:07:00.0: [102b:0522] type 00 class 0x030000
[    6.214589] pci 0000:07:00.0: reg 0x10: [mem 0x90000000-0x90ffffff pre=
f]
[    6.222569] pci 0000:07:00.0: reg 0x14: [mem 0x91800000-0x91803fff]
[    6.229569] pci 0000:07:00.0: reg 0x18: [mem 0x91000000-0x917fffff]
[    6.236610] pci 0000:07:00.0: reg 0x30: [mem 0xffff0000-0xffffffff pre=
f]
[    6.243754] pci 0000:00:1c.3: PCI bridge to [bus 07]
[    6.249560] pci 0000:00:1c.3:   bridge window [mem 0x91000000-0x918fff=
ff]
[    6.256560] pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x90ffff=
ff 64bit pref]
[    6.265969] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 1=
2 14 15)
[    6.273600] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 1=
2 14 15)
[    6.281601] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 1=
2 14 15)
[    6.290598] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 1=
2 14 15)
[    6.298596] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11 1=
2 14 15)
[    6.306597] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12=
 14 15) *0, disabled.
[    6.315596] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12=
 14 15) *0, disabled.
[    6.324596] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12=
 14 15) *0, disabled.
[    6.334830] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    6.341559] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
[    6.352054] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotp=
lug AER LTR]
[    6.361403] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PC=
IeCapability]
[    6.369556] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    6.378741] PCI host bridge to bus 0000:80
[    6.383557] pci_bus 0000:80: root bus resource [io  0x8000-0xffff wind=
ow]
[    6.391556] pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffb=
fff window]
[    6.399556] pci_bus 0000:80: root bus resource [mem 0x384000000000-0x3=
87fffffffff window]
[    6.408556] pci_bus 0000:80: root bus resource [bus 80-fe]
[    6.414567] pci 0000:80:04.0: [8086:6f20] type 00 class 0x088000
[    6.421567] pci 0000:80:04.0: reg 0x10: [mem 0x387ffff1c000-0x387ffff1=
ffff 64bit]
[    6.429678] pci 0000:80:04.1: [8086:6f21] type 00 class 0x088000
[    6.436577] pci 0000:80:04.1: reg 0x10: [mem 0x387ffff18000-0x387ffff1=
bfff 64bit]
[    6.444684] pci 0000:80:04.2: [8086:6f22] type 00 class 0x088000
[    6.451566] pci 0000:80:04.2: reg 0x10: [mem 0x387ffff14000-0x387ffff1=
7fff 64bit]
[    6.459679] pci 0000:80:04.3: [8086:6f23] type 00 class 0x088000
[    6.466566] pci 0000:80:04.3: reg 0x10: [mem 0x387ffff10000-0x387ffff1=
3fff 64bit]
[    6.475666] pci 0000:80:04.4: [8086:6f24] type 00 class 0x088000
[    6.481566] pci 0000:80:04.4: reg 0x10: [mem 0x387ffff0c000-0x387ffff0=
ffff 64bit]
[    6.490669] pci 0000:80:04.5: [8086:6f25] type 00 class 0x088000
[    6.496566] pci 0000:80:04.5: reg 0x10: [mem 0x387ffff08000-0x387ffff0=
bfff 64bit]
[    6.505665] pci 0000:80:04.6: [8086:6f26] type 00 class 0x088000
[    6.512566] pci 0000:80:04.6: reg 0x10: [mem 0x387ffff04000-0x387ffff0=
7fff 64bit]
[    6.520663] pci 0000:80:04.7: [8086:6f27] type 00 class 0x088000
[    6.527566] pci 0000:80:04.7: reg 0x10: [mem 0x387ffff00000-0x387ffff0=
3fff 64bit]
[    6.535662] pci 0000:80:05.0: [8086:6f28] type 00 class 0x088000
[    6.542674] pci 0000:80:05.1: [8086:6f29] type 00 class 0x088000
[    6.549680] pci 0000:80:05.2: [8086:6f2a] type 00 class 0x088000
[    6.555653] pci 0000:80:05.4: [8086:6f2c] type 00 class 0x080020
[    6.562564] pci 0000:80:05.4: reg 0x10: [mem 0xc8000000-0xc8000fff]
[    6.570975] iommu: Default domain type: Passthrough=20
[    6.576617] pci 0000:07:00.0: vgaarb: setting as boot VGA device
[    6.577553] pci 0000:07:00.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dio+mem,locks=3Dnone
[    6.592561] pci 0000:07:00.0: vgaarb: bridge control possible
[    6.598555] vgaarb: loaded
[    6.601754] SCSI subsystem initialized
[    6.606576] ACPI: bus type USB registered
[    6.610576] usbcore: registered new interface driver usbfs
[    6.616562] usbcore: registered new interface driver hub
[    6.623595] usbcore: registered new device driver usb
[    6.628593] pps_core: LinuxPPS API ver. 1 registered
[    6.634555] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
[    6.644558] PTP clock support registered
[    6.649698] EDAC MC: Ver: 3.0.0
[    6.652833] PCI: Using ACPI for IRQ routing
[    6.662434] NetLabel: Initializing
[    6.666556] NetLabel:  domain hash size =3D 128
[    6.671555] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    6.677578] NetLabel:  unlabeled traffic allowed by default
[    6.683610] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    6.690557] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    6.699706] clocksource: Switched to clocksource tsc-early
[    6.725538] VFS: Disk quotas dquot_6.6.0
[    6.729976] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[    6.737765] pnp: PnP ACPI init
[    6.742088] system 00:01: [io  0x0500-0x053f] has been reserved
[    6.748699] system 00:01: [io  0x0400-0x047f] has been reserved
[    6.755307] system 00:01: [io  0x0540-0x057f] has been reserved
[    6.761915] system 00:01: [io  0x0600-0x061f] has been reserved
[    6.768524] system 00:01: [io  0x0ca0-0x0ca5] could not be reserved
[    6.775511] system 00:01: [io  0x0880-0x0883] has been reserved
[    6.782118] system 00:01: [io  0x0800-0x081f] has been reserved
[    6.788728] system 00:01: [mem 0xfed1c000-0xfed3ffff] could not be res=
erved
[    6.796499] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserve=
d
[    6.803885] system 00:01: [mem 0xff000000-0xffffffff] could not be res=
erved
[    6.811656] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserve=
d
[    6.819041] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserve=
d
[    6.826429] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserve=
d
[    6.833813] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserve=
d
[    6.841758] pnp: PnP ACPI: found 4 devices
[    6.852973] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
[    6.862914] pci 0000:07:00.0: can't claim BAR 6 [mem 0xffff0000-0xffff=
ffff pref]: no compatible bridge window
[    6.874024] pci 0000:00:01.0: PCI bridge to [bus 01]
[    6.879572] pci 0000:00:02.0: PCI bridge to [bus 02]
[    6.885120] pci 0000:00:02.2: PCI bridge to [bus 03-04]
[    6.890956] pci 0000:00:02.2:   bridge window [io  0x2000-0x2fff]
[    6.897761] pci 0000:00:02.2:   bridge window [mem 0x91900000-0x91cfff=
ff]
[    6.905342] pci 0000:00:02.2:   bridge window [mem 0x383fffa00000-0x38=
3fffefffff 64bit pref]
[    6.914767] pci 0000:00:03.0: PCI bridge to [bus 05]
[    6.920318] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    6.925871] pci 0000:07:00.0: BAR 6: assigned [mem 0x91810000-0x9181ff=
ff pref]
[    6.933937] pci 0000:00:1c.3: PCI bridge to [bus 07]
[    6.939482] pci 0000:00:1c.3:   bridge window [mem 0x91000000-0x918fff=
ff]
[    6.947063] pci 0000:00:1c.3:   bridge window [mem 0x90000000-0x90ffff=
ff 64bit pref]
[    6.955715] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    6.962614] pci_bus 0000:00: resource 5 [io  0x1000-0x7fff window]
[    6.969507] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    6.977186] pci_bus 0000:00: resource 7 [mem 0x90000000-0xc7ffbfff win=
dow]
[    6.984864] pci_bus 0000:00: resource 8 [mem 0x380000000000-0x383fffff=
ffff window]
[    6.993317] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    6.999540] pci_bus 0000:03: resource 1 [mem 0x91900000-0x91cfffff]
[    7.006539] pci_bus 0000:03: resource 2 [mem 0x383fffa00000-0x383fffef=
ffff 64bit pref]
[    7.015380] pci_bus 0000:07: resource 1 [mem 0x91000000-0x918fffff]
[    7.022379] pci_bus 0000:07: resource 2 [mem 0x90000000-0x90ffffff 64b=
it pref]
[    7.030560] pci_bus 0000:80: resource 4 [io  0x8000-0xffff window]
[    7.037457] pci_bus 0000:80: resource 5 [mem 0xc8000000-0xfbffbfff win=
dow]
[    7.045135] pci_bus 0000:80: resource 6 [mem 0x384000000000-0x387fffff=
ffff window]
[    7.053767] NET: Registered protocol family 2
[    7.059309] tcp_listen_portaddr_hash hash table entries: 32768 (order:=
 7, 524288 bytes, vmalloc)
[    7.069368] TCP established hash table entries: 524288 (order: 10, 419=
4304 bytes, vmalloc)
[    7.079382] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s, vmalloc)
[    7.087926] TCP: Hash tables configured (established 524288 bind 65536=
)
[    7.095590] UDP hash table entries: 32768 (order: 8, 1048576 bytes, vm=
alloc)
[    7.103689] UDP-Lite hash table entries: 32768 (order: 8, 1048576 byte=
s, vmalloc)
[    7.112625] NET: Registered protocol family 1
[    7.117492] NET: Registered protocol family 44
[    7.147669] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x643 took 2=
2276 usecs
[    7.178682] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x643 took 2=
2202 usecs
[    7.186969] pci 0000:07:00.0: Video device with shadowed ROM at [mem 0=
x000c0000-0x000dffff]
[    7.196318] PCI: CLS 32 bytes, default 64
[    7.200876] Trying to unpack rootfs image as initramfs...
[    8.737963] Freeing initrd memory: 80964K
[    8.742474] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    8.749672] software IO TLB: mapped [mem 0x55000000-0x59000000] (64MB)
[    8.784367] Initialise system trusted keyrings
[    8.789343] Key type blacklist registered
[    8.793892] workingset: timestamp_bits=3D36 max_order=3D24 bucket_orde=
r=3D0
[    8.803008] zbud: loaded
[    8.806668] Platform Keyring initialized
[    8.816772] NET: Registered protocol family 38
[    8.821736] Key type asymmetric registered
[    8.826308] Asymmetric key parser 'x509' registered
[    8.831760] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 246)
[    8.840237] io scheduler mq-deadline registered
[    8.845294] io scheduler kyber registered
[    8.849809] io scheduler bfq registered
[    8.854926] atomic64_test: passed for x86-64 platform with CX8 and wit=
h SSE
[    8.863140] pcieport 0000:00:01.0: PME: Signaling with IRQ 25
[    8.869934] pcieport 0000:00:02.0: PME: Signaling with IRQ 26
[    8.876611] pcieport 0000:00:02.2: PME: Signaling with IRQ 27
[    8.883265] pcieport 0000:00:03.0: PME: Signaling with IRQ 28
[    8.889964] pcieport 0000:00:1c.0: PME: Signaling with IRQ 29
[    8.896616] pcieport 0000:00:1c.3: PME: Signaling with IRQ 30
[    8.903428] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
[    8.916907] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input0
[    8.925257] ACPI: Power Button [PWRF]
[    9.037946] ERST: Error Record Serialization Table (ERST) support is i=
nitialized.
[    9.046303] pstore: Registered erst as persistent store backend
[    9.054016] GHES: APEI firmware first mode is enabled by APEI bit and =
WHEA _OSC.
[    9.062481] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    9.090168] 00:02: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
[    9.119058] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200=
) is a 16550A
[    9.127963] Non-volatile memory driver v1.3
[    9.142241] rdac: device handler registered
[    9.147030] hp_sw: device handler registered
[    9.151800] emc: device handler registered
[    9.156664] alua: device handler registered
[    9.161435] libphy: Fixed MDIO Bus: probed
[    9.166236] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    9.173531] ehci-pci: EHCI PCI platform driver
[    9.178819] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    9.184761] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bu=
s number 1
[    9.193034] ehci-pci 0000:00:1a.0: debug port 2
[    9.202016] ehci-pci 0000:00:1a.0: cache line size of 32 is not suppor=
ted
[    9.209605] ehci-pci 0000:00:1a.0: irq 18, io mem 0x91d02000
[    9.222618] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    9.229089] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.05
[    9.238307] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    9.246370] usb usb1: Product: EHCI Host Controller
[    9.251813] usb usb1: Manufacturer: Linux 5.5.0-rc7+ ehci_hcd
[    9.258227] usb usb1: SerialNumber: 0000:00:1a.0
[    9.263551] hub 1-0:1.0: USB hub found
[    9.267743] hub 1-0:1.0: 2 ports detected
[    9.272522] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    9.278456] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bu=
s number 2
[    9.286723] ehci-pci 0000:00:1d.0: debug port 2
[    9.295676] ehci-pci 0000:00:1d.0: cache line size of 32 is not suppor=
ted
[    9.303260] ehci-pci 0000:00:1d.0: irq 18, io mem 0x91d01000
[    9.316627] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    9.323096] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.05
[    9.332323] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    9.340376] usb usb2: Product: EHCI Host Controller
[    9.345819] usb usb2: Manufacturer: Linux 5.5.0-rc7+ ehci_hcd
[    9.352233] usb usb2: SerialNumber: 0000:00:1d.0
[    9.357531] hub 2-0:1.0: USB hub found
[    9.361721] hub 2-0:1.0: 2 ports detected
[    9.366346] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    9.373253] ohci-pci: OHCI PCI platform driver
[    9.378250] uhci_hcd: USB Universal Host Controller Interface driver
[    9.385523] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    9.391456] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bu=
s number 3
[    9.400791] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0=
x100 quirks 0x0000000000009810
[    9.410993] xhci_hcd 0000:00:14.0: cache line size of 32 is not suppor=
ted
[    9.418801] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.05
[    9.428028] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    9.436083] usb usb3: Product: xHCI Host Controller
[    9.441519] usb usb3: Manufacturer: Linux 5.5.0-rc7+ xhci-hcd
[    9.447932] usb usb3: SerialNumber: 0000:00:14.0
[    9.453256] hub 3-0:1.0: USB hub found
[    9.457461] hub 3-0:1.0: 15 ports detected
[    9.463961] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    9.469871] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bu=
s number 4
[    9.478132] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    9.485160] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.05
[    9.494387] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[    9.502442] usb usb4: Product: xHCI Host Controller
[    9.507886] usb usb4: Manufacturer: Linux 5.5.0-rc7+ xhci-hcd
[    9.514300] usb usb4: SerialNumber: 0000:00:14.0
[    9.519626] hub 4-0:1.0: USB hub found
[    9.523824] hub 4-0:1.0: 6 ports detected
[    9.529250] usbcore: registered new interface driver usbserial_generic
[    9.536544] usbserial: USB Serial support registered for generic
[    9.543313] i8042: PNP: No PS/2 controller found.
[    9.548667] mousedev: PS/2 mouse device common for all mice
[    9.555054] rtc_cmos 00:00: RTC can wake from S4
[    9.560421] rtc_cmos 00:00: registered as rtc0
[    9.565396] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvr=
am, hpet irqs
[    9.573958] intel_pstate: Intel P-state driver initializing
[    9.592479] hid: raw HID events driver (C) Jiri Kosina
[    9.598278] usbcore: registered new interface driver usbhid
[    9.604500] usbhid: USB HID core driver
[    9.608972] drop_monitor: Initializing network drop monitor service
[    9.616054] Initializing XFRM netlink socket
[    9.621027] NET: Registered protocol family 10
[    9.626700] Segment Routing with IPv6
[    9.630800] NET: Registered protocol family 17
[    9.632589] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    9.635932] mpls_gso: MPLS GSO support
[    9.657141] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
800a, bcdDevice=3D 0.05
[    9.658134] microcode: sig=3D0x406f1, pf=3D0x1, revision=3D0xb00002a
[    9.670472] B device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
[    9.673006] hub 1-1:1.0: USB hub found
[    9.673084] hub 1-1:1.0: 6 ports detected
[    9.694597] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    9.707110] AVX2 version of gcm_enc/dec engaged.
[    9.709261] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
8002, bcdDevice=3D 0.05
[    9.712264] AES CTR mode by8 optimization enabled
[    9.726638] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[    9.734892] hub 2-1:1.0: USB hub found
[    9.739254] hub 2-1:1.0: 8 ports detected
[    9.744506] sched_clock: Marking stable (6948364463, 2796134314)->(102=
06753075, -462254298)
[    9.754019] registered taskstats version 1
[    9.758605] Loading compiled-in X.509 certificates
[    9.764599] tsc: Refined TSC clocksource calibration: 2194.917 MHz
[    9.771520] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1=
fa37107ca2, max_idle_ns: 440795258165 ns
[    9.782892] clocksource: Switched to clocksource tsc
[    9.786614] usb 3-9: new full-speed USB device number 2 using xhci_hcd
[    9.791003] Loaded X.503057087611c75a5378a4281'
[    9.806921] zswap: loaded using pool lzo/zbud
[    9.811993] pstore: Using crash dump compression: deflate
[    9.824249] Key type big_key registered
[    9.831466] Key type encrypted registered
[    9.835950] ima: No TPM chip found, activating TPM-bypass!
[    9.842077] ima: Allocated hash algorithm: sha1
[    9.847139] ima: No architecture policies found
[    9.852208] evm: Initialising EVM extended attributes:
[    9.857941] evm: security.selinux
[    9.861639] evm: security.ima
[    9.864949] evm: security.capability
[    9.868937] evm: HMAC attrs: 0x1
[    9.873491] rtc_cmos 00:00: setting system clock to 2020-02-04T07:33:2=
6 UTC (1580801606)
[    9.889849] Freeing unused decrypted memory: 2040K
[    9.896311] Freeing unused kernel image (initmem) memory: 2404K
[    9.906661] Write protecting the kernel read-only dat04] Freeing unuse=
d kernel image (text/rodata gap) memory: 2040K
[    9.922559] F1720K
[    9.93[    9.948544] usb 3-9: New USB device found, idVendor=3D046b, i=
dProduct=3Dff10, bcdDevice=3D 1.00
[   10.000427] usb 3-9: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D3
[   10.000428] usb 3-9: Product: Virtual Keyboard and Mouse
[   10.000429] usb 3-9: Manufacturer: American Megatrends Inc.
[   10.000430] usb 3-9: SerialNumber: serial
[   10.001987] input: American Megatrends Inc. Virtual Keyboard and Mouse=
 as /devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.0/0003:046B:FF10.0001=
/input/input1
[   10.002153] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1=
.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb=
-0000:00:14.0-9/input0
[   10.002864] input: American Megatrends Inc. Virtual Keyboard and Mouse=
 as /devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9:1.1/0003:046B:FF10.0002=
/input/input2
[   10.002964] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1=
.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-00=
00:00:14.0-9/input1
[   10.089083] systemd[1]: systemd 239 running in system mode. (+PAM +AUD=
IT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 d=
efault-hierarchy=3Dlegacy)
[   10.127672] systemd[1]: Detected architecture x86-64.
[   10.133317] systemd[1]: Running in initial RAM disk.

Welcome to Red Hat Enterprise Linux 8.2 Beta (Ootpa) dracut-049-60.git201=
91129.el8 (Initramfs)!

[   10.159684] systemd[1]: Set hostname to <intel-wildcatpass-07>.
[   10.210372] random: systemd: uninitialized urandom read (16 bytes read=
)
[   10.217830] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[   10.231678] random: systemd: uninitialized urandom read (16 bytes read=
)
[   10.239074] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[   10.249667] random: systemd: uninitialized urandom read (16 bytes read=
)
[   10.257059] systemd[1]: Reached target Timers.
[  OK  ] Reached target Timers.
[   10.267628] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[   10.278710] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[   10.293304] systemd[1]: Starting Setup Virtual Console...
         Starting Setup Virtual Console...
         Starting Create list of required st=E2=80=A6ce nodes for the cur=
rent kernel...
         Starting Apply Kernel Variables...
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Created slice system-systemd\x2dhibernate\x2dresume.slice.
[  OK  ] Started Hardware RNG Entropy Gatherer Daemon.
[  OK  ] Listening on Journal Socket (/dev/log).
         Starting Journal Service...
[  OK  ] Reached target Sockets.
[  OK  ] Started Setup Virtual Console.
[  OK  ] Started Create list of required sta=E2=80=A6vice nodes for the c=
urrent kernel.
[  OK  ] Started Apply Kernel Variables.
         Starting Create Static Device Nodes in /dev...
         Starting dracut cmdline hook...
[  OK  ] Started Create Static Device Nodes in /dev.
[  OK  ] Started dracut cmdline hook.
         Starting dracut pre-udev hook...
[   10.560243] device-mapper: uevent: version 1.0.3
[   10.565489] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialise=
d
[  OK  ] Started dracut pre-udev hook.
         Starting udev Kernel Device Manager...
[  OK  ] Started Journal Service.
[  OK  ] Started udev Kernel Device Manager.
         Starting udev Coldplug all Devices...
         Mounting Kernel Configuration File System...
[  OK  ] Mounted Kernel Configuration File System.
[  OK  ] Started udev Coldplug all Devices.
         Starting Show Plymouth Boot Screen...
[   10.942415] dca service started, version 1.12.1
         Starting dracut initqueue hook...
[  OK  ] Started Show Plymouth Boot Screen.
[  OK  ] Started Forward Password Requests to Plymouth Directory Watch.
[  OK  ] Reached target Paths.
[   11.050149] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - ve=
rsion 5.1.0-k
[   11.058700] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   11.090777] ahci 0000:00:11.4: AHCI 0001.0300 32 slots 4 ports 6 Gbps =
0xf impl SATA mode
[   11.099816] ahci 0000:00:11.4: flags: 64bit ncq led clo pio slum part =
ems apst=20
[   11.120979] scsi host0: ahci
[   11.121138] scsi host1: ahci
[   11.121255] scsi host2: ahci
[   11.121367] scsi host3: ahci
[   11.121432] ata1: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00=
100 irq 33
[   11.121434] ata2: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00=
180 irq 33
[   11.121436] ata3: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00=
200 irq 33
[   11.121438] ata4: SATA max UDMA/133 abar m2048@0x91d00000 port 0x91d00=
280 irq 33
[   11.121811] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps =
0x3f impl SATA mode
[   11.121813] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part =
ems apst=20
[   11.140089] scsi host4: ahci
[   11.140199] scsi host5: ahci
[   11.140306] scsi host6: ahci
[   11.140416] scsi host7: ahci
[   11.140554] scsi host8: ahci
[   11.140679] scsi host9: ahci
[   11.140730] ata5: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04=
100 irq 34
[   11.140733] ata6: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04=
180 irq 34
[   11.140735] ata7: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04=
200 irq 34
[   11.140738] ata8: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04=
280 irq 34
[   11.140739] ata9: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d04=
300 irq 34
[   11.140741] ata10: SATA max UDMA/133 abar m2048@0x91d04000 port 0x91d0=
4380 irq 34
[   11.178283] mgag200 0000:07:00.0: vgaarb: deactivate vga console
[   11.287181] Console: switching to colour dummy device 80x25
[   11.308567] [TTM] Zone  kernel: Available graphics memory: 32660860 Ki=
B
[   11.315968] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   11.323253] [TTM] Initializing pool allocator
[   11.328177] [TTM] Initializing DMA pool allocator
[   11.363241] fbcon: mgag200drmfb (fb0) is primary device
[   11.386469] ixgbe 0000:03:00.0: Multiqueue Enabled: Rx Queue count =3D=
 63, Tx Queue count =3D 63 XDP Queue count =3D 0
[   11.426151] ata4: SATA link down (SStatus 0 SControl 300)
[   11.426479] ata2: SATA link down (SStatus 0 SControl 300)
[   11.426713] ata1: SATA link down (SStatus 0 SControl 300)
[   11.426729] ata3: SATA link down (SStatus 0 SControl 300)
[   11.452783] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   11.453883] ata8: SATA link down (SStatus 0 SControl 300)
[   11.454549] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   11.455126] ata6: SATA link down (SStatus 0 SControl 300)
[   11.456200] ata7: SATA link down (SStatus 0 SControl 300)
[   11.456866] ata10: SATA link down (SStatus 0 SControl 300)
[   11.457490] ata9.00: ATAPI: DV-W28S-A, 9.2A, max UDMA/100
[   11.457888] ata5.00: ATA-9: INTEL SSDSC2BA800G3, 5DV10270, max UDMA/13=
3
[   11.457917] ata5.00: 1562824368 sectors, multi 1: LBA48 NCQ (depth 32)
[   11.458454] ata5.00: configured for UDMA/133
[   11.458746] scsi 4:0:0:0: Direct-Access     ATA      INTEL SSDSC2BA80 =
0270 PQ: 0 ANSI: 5
[   11.459796] ata9.00: configured for UDMA/100
[   11.460708] scsi 8:0:0:0: CD-ROM            TEAC     DV-W28S-A        =
9.2A PQ: 0 ANSI: 5
[   11.464025] scsi 4:0:0:0: Attached scsi generic sg0 type 0
[   11.468842] ata5.00: Enabling discard_zeroes_data
[   11.468945] sd 4:0:0:0: [sda] 1562824368 512-byte logical blocks: (800=
 GB/745 GiB)
[   11.468947] sd 4:0:0:0: [sda] 4096-byte physical blocks
[   11.468972] sd 4:0:0:0: [sda] Write Protect is off
[   11.469021] sd 4:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[   11.483838] ata5.00: Enabling discard_zeroes_data
[   11.484459]  sda: sda1 sda2
[   11.485545] ata5.00: Enabling discard_zeroes_data
[   11.485621] scsi 8:0:0:0: Attached scsi generic sg1 type 5
[   11.485887] sd 4:0:0:0: [sda] Attached SCSI disk
[   11.487566] ixgbe 0000:03:00.0: 32.000 Gb/s available PCIe bandwidth (=
5 GT/s x8 link)
[   11.511560] ixgbe 0000:03:00.0: MAC: 3, PHY: 0, PBA No: 000000-000
[   11.511561] ixgbe 0000:03:00.0: 00:1e:67:d3:27:b0
[   11.516591] sr 8:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram =
cd/rw xa/form2 cdda tray
[   11.516592] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.566563] Console: switching to colour frame buffer device 128x48
[   11.705611] ixgbe 0000:03:00.0: Intel(R) 10 Gigabit Network Connection
[   11.705633] libphy: ixgbe-mdio: probed
[   11.717780] random: fast init done
[   11.867816] mgag200 0000:07:00.0: fb0: mgag200drmfb frame buffer devic=
e
[   11.922915] [drm] Initialized mgag200 1.0.0 20110418 for 0000:07:00.0 =
on minor 0
[   12.186351] ixgbe 0000:03:00.1: Multiqueue Enabled: Rx Queue count =3D=
 63, Tx Queue count =3D 63 XDP Queue count =3D 0
[   12.258351] random: crng init done
[   12.262151] random: 7 urandom warning(s) missed due to ratelimiting
[   12.281564] ixgbe 0000:03:00.1: 32.000 Gb/s available PCIe bandwidth (=
5 GT/s x8 link)
[   12.313558] ixgbe 0000:03:00.1: MAC: 3, PHY: 0, PBA No: 000000-000
[   12.320453] ixgbe 0000:03:00.1: 00:1e:67:d3:27:b1
[   12.471572] ixgbe 0000:03:00.1: Intel(R) 10 Gigabit Network Connection
[   12.478899] libphy: ixgbe-mdio: probed
[   12.484687] ixgbe 0000:03:00.0 eno1: renamed from eth0
[   12.495966] ixgbe 0000:03:00.1 eno2: renamed from eth1
[  OK  ] Found device /dev/mapper/intel--wildcatpass--07-root.
[  OK  ] Reached target Initrd Root Device.
[  OK  ] Found device /dev/mapper/intel--wildcatpass--07-swap.
         Starting Resume from hibernation us=E2=80=A6hel_intel--wildcatpa=
ss--07-swap...
[  OK  ] Started Resume from hibernation usi=E2=80=A6/intel--wildcatpass-=
-07-swap.
[  OK  ] Reached target Local File Systems (Pre).
[  OK  ] Reached target Local File Systems.
         Starting Create Volatile Files and Directories...
[  OK  ] Started Create Volatile Files and Directories.
[  OK  ] Reached target System Initialization.
[  OK  ] Reached target Basic System.
[  OK  ] Started dracut initqueue hook.
[  OK  ] Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems.
         Starting File System Check on /dev/=E2=80=A6intel--wildcatpass--=
07-root...
[  OK  ] Started File System Check on /dev/m=E2=80=A6/intel--wildcatpass-=
-07-root.
         Mounting /sysroot...
[   12.975718] SGI XFS with ACLs, security attributes, quota, no debug en=
abled
[   12.987138] XFS (dm-0): Mounting V5 Filesystem
[   13.008174] XFS (dm-0): Ending clean mount
[  OK  ] Mounted /sysroot.
[  OK  ] Reached target Initrd Root File System.
         Starting Reload Configuration from the Real Root...
[  OK  ] Started Reload Configuration from the Real Root.
[  OK  ] Reached target Initrd File Systems.
[  OK  ] Reached target Initrd Default Target.
         Starting dracut pre-pivot and cleanup hook...
[  OK  ] Started dracut pre-pivot and cleanup hook.
         Starting Cleaning Up and Shutting Down Daemons...
[  OK  ] Stopped target Timers.
[  OK  ] Stopped dracut pre-pivot and cleanup hook.
[  OK  ] Stopped target Remote File Systems.
         Starting Setup Virtual Console...
         Starting Plymouth switch root service...
[  OK  ] Stopped target Initrd Default Target.
[  OK  ] Stopped target Initrd Root Device.
[  OK  ] Stopped target Basic System.
[  OK  ] Stopped target System Initialization.
[  OK  ] Stopped Apply Kernel Variables.
[  OK  ] Stopped target Swap.
[  OK  ] Stopped Create Volatile Files and Directories.
[  OK  ] Stopped target Local File Systems.
[  OK  ] Stopped target Local File Systems (Pre).
[  OK  ] Stopped target Sock[   13.321682] systemd-journald[816]: Receive=
d SIGTERM from PID 1 (systemd).
ets.
[  OK  ] Stopped target Paths.
[  OK  ] Stopped target Slices.
         Stopping udev Kernel Device Manager...
[  OK  ] Stopped ta[   13.347698] printk: systemd: 19 output lines suppre=
ssed due to ratelimiting
rget Remote File Systems (Pre).
[  OK  ] Stopped dracut initqueue hook.
[  OK  ] Stopped udev Coldplug all Devices.
[  OK  ] Started Cleaning Up and Shutting Down Daemons.
[  OK  ] Stopped udev Kernel Device Manager.
         Stopping Hardware RNG Entropy Gatherer D[   13.386747] audit: ty=
pe=3D1404 audit(1580801610.013:2): enforcing=3D1 old_enforcing=3D0 auid=3D=
4294967295 ses=3D4294967295 enabled=3D1 old-enabled=3D1 lsm=3Dselinux res=
=3D1
aemon...
[  OK  ] Stopped Create Static Device Nodes in /dev.
[  OK  ] Stopped Create list of required sta=E2=80=A6vice nodes for the c=
urrent kernel.
[  OK  ] Stopped dracut pre-udev hook.
[  OK  ] Stopped dracut cmdline hook.
[  OK  ] Closed udev Control Socket.
[  OK  ] Closed udev Kernel Socket.
         Starting Cleanup udevd DB...
[  OK  ] Stopped Hardware RNG Entropy Gatherer Daemon.
[  OK  ] Started Plymouth switch root service.
[  OK  ] Started Cleanup udevd DB.
[  OK  ] Started Setup Virtual Console.
[  OK  ] Reached target Switch Root.
         Starting Switch Root...
[   13.762409] SELinux:  Permission watch in class filesystem not defined=
 in policy.
[   13.770767] SELinux:  Permission watch in class file not defined in po=
licy.
[   13.778535] SELinux:  Permission watch_mount in class file not defined=
 in policy.
[   13.786886] SELinux:  Permission watch_sb in class file not defined in=
 policy.
[   13.794947] SELinux:  Permission watch_with_perm in class file not def=
ined in policy.
[   13.803686] SELinux:  Permission watch_reads in class file not defined=
 in policy.
[   13.812043] SELinux:  Permission watch in class dir not defined in pol=
icy.
[   13.819713] SELinux:  Permission watch_mount in class dir not defined =
in policy.
[   13.827967] SELinux:  Permission watch_sb in class dir not defined in =
policy.
[   13.835928] SELinux:  Permission watch_with_perm in class dir not defi=
ned in policy.
[   13.844571] SELinux:  Permission watch_reads in class dir not defined =
in policy.
[   13.852831] SELinux:  Permission watch in class lnk_file not defined i=
n policy.
[   13.860994] SELinux:  Permission watch_mount in class lnk_file not def=
ined in policy.
[   13.869733] SELinux:  Permission watch_sb in class lnk_file not define=
d in policy.
[   13.878181] SELinux:  Permission watch_with_perm in class lnk_file not=
 defined in policy.
[   13.887308] SELinux:  Permission watch_reads in class lnk_file not def=
ined in policy.
[   13.896051] SELinux:  Permission watch in class chr_file not defined i=
n policy.
[   13.904210] SELinux:  Permission watch_mount in class chr_file not def=
ined in policy.
[   13.912950] SELinux:  Permission watch_sb in class chr_file not define=
d in policy.
[   13.921397] SELinux:  Permission watch_with_perm in class chr_file not=
 defined in policy.
[   13.930524] SELinux:  Permission watch_reads in class chr_file not def=
ined in policy.
[   13.939266] SELinux:  Permission watch in class blk_file not defined i=
n policy.
[   13.947413] SELinux:  Permission watch_mount in class blk_file not def=
ined in policy.
[   13.956154] SELinux:  Permission watch_sb in class blk_file not define=
d in policy.
[   13.964604] SELinux:  Permission watch_with_perm in class blk_file not=
 defined in policy.
[   13.973731] SELinux:  Permission watch_reads in class blk_file not def=
ined in policy.
[   13.982474] SELinux:  Permission watch in class sock_file not defined =
in policy.
[   13.990728] SELinux:  Permission watch_mount in class sock_file not de=
fined in policy.
[   13.999564] SELinux:  Permission watch_sb in class sock_file not defin=
ed in policy.
[   14.008109] SELinux:  Permission watch_with_perm in class sock_file no=
t defined in policy.
[   14.017333] SELinux:  Permission watch_reads in class sock_file not de=
fined in policy.
[   14.026170] SELinux:  Permission watch in class fifo_file not defined =
in policy.
[   14.034426] SELinux:  Permission watch_mount in class fifo_file not de=
fined in policy.
[   14.043262] SELinux:  Permission watch_sb in class fifo_file not defin=
ed in policy.
[   14.051807] SELinux:  Permission watch_with_perm in class fifo_file no=
t defined in policy.
[   14.061031] SELinux:  Permission watch_reads in class fifo_file not de=
fined in policy.
[   14.069980] SELinux:  Class perf_event not defined in policy.
[   14.076394] SELinux: the above unknown classes and permissions will be=
 allowed
[   14.084457] SELinux:  policy capability network_peer_controls=3D1
[   14.091060] SELinux:  policy capability open_perms=3D1
[   14.096598] SELinux:  policy capability extended_socket_class=3D1
[   14.103201] SELinux:  policy capability always_check_network=3D0
[   14.109708] SELinux:  policy capability cgroup_seclabel=3D1
[   14.115730] SELinux:  policy capability nnp_nosuid_transition=3D1
[   14.148654] audit: type=3D1403 audit(1580801610.775:3): auid=3D4294967=
295 ses=3D4294967295 lsm=3Dselinux res=3D1
[   14.150117] systemd[1]: Successfully loaded SELinux policy in 764.203m=
s.
[   14.171887] systemd[1]: RTC configured in localtime, applying delta of=
 -300 minutes to system time.
[   14.238225] systemd[1]: Relabelled /dev, /run and /sys/fs/cgroup in 39=
.372ms.
[   14.247754] systemd[1]: systemd 239 running in system mode. (+PAM +AUD=
IT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 d=
efault-hierarchy=3Dlegacy)
[   14.286717] systemd[1]: Detected architecture x86-64.

Welcome to [[   14.293510] systemd[1]: Set hostname to <intel-wildcatpass=
-07>.
0;31mRed Hat Enterprise Linux 8.2 Beta (Ootpa)!

[   14.405714] systemd[1]: Stopped Switch Root.
[  OK  [[   14.410848] systemd[1]: systemd-journald.service: Service has =
no hold-off time (RestartSec=3D0), scheduling restart.
0m] Stopped Swit[   14.423860] systemd[1]: systemd-journald.service: Sche=
duled restart job, restart counter is at 1.
ch Root.
[   14.435337] systemd[1]: Stopped Journal Service.
[  OK  [[   14.442387] systemd[1]: Starting Journal Service...
0m] Stopped Jour[   14.449215] systemd[1]: Created slice system-getty.sli=
ce.
nal Service.
 [   14.457412] systemd[1]: Starting Create list of required static devic=
e nodes for the current kernel...
        Starting Journal Service...
[  OK  ] Created slice system-getty.slice.
         Starting Create list of required st=E2=80=A6ce nodes for the cur=
rent kernel...
[  OK  ] Set up automount Arbitrary Executab=E2=80=A6rmat[   14.491624] x=
fs filesystem being remounted at / supports timestamps until 2038 (0x7fff=
ffff)
s File System Automount Point.
[  OK  [   14.505614] Adding 32993276k swap on /dev/mapper/intel--wildcat=
pass--07-swap.  Priority:-2 extents:1 across:32993276k SSFS
[0m] Listening on initctl Compatibility Named Pipe.
[  OK  ] Stopped target Switch Root.
[  OK  ] Listening on Process Core Dump Socket.
         Starting Setup Virtual Console...
         Mounting Huge Pages File System...
[  OK  ] Created slice system-serial\x2dgetty.slice.
[  OK  ] Listening on Device-mapper event daemon FIFOs.
[  OK  ] Listening on LVM2 poll daemon socket.
[  OK  ] Listening on udev Kernel Socket.
[  OK  ] Stopped File System Check on Root Device.
         Starting Remount Root and Kernel File Systems...
[  OK  ] Stopped target Initrd File Systems.
[  OK  ] Reached target Remote File Systems.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Reached target Paths.
         Mounting POSIX Message Queue File System...
[  OK  ] Created slice system-sshd\x2dkeygen.slice.
[  OK  ] Reached target Local Encrypted Volumes.
         Mounting Kernel Debug File System...
[  OK  ] Stopped target Initrd Root File System.
         Activating swap /dev/mapper/intel--wildcatpass--07-swap...
[  OK  ] Listening on udev Control Socket.
         Starting udev Coldplug all Devices...
[  OK  ] Created slice User and Session Slice.
[  OK  ] Reached target Slices.
         Starting Apply Kernel Variables...
         Starting Read and set NIS domainname from /etc/sysconfig/network=
...
         Starting Monitoring of LVM2 mirrors=E2=80=A6ng dmeventd or progr=
ess polling...
[  OK  ] Started Create list of required sta=E2=80=A6vice nodes for the c=
urrent kernel.
[  OK  ] Mounted Huge Pages File System.
[  OK  ] Started Remount Root and Kernel File Systems.
[  OK  ] Mounted POSIX Message Queue File System.
[  OK  ] Mounted Kernel Debug File System.
[  OK  ] Activated swap /dev/mapper/intel--wildcatpass--07-swap.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Read and set NIS domainname from /etc/sysconfig/network.
[  OK  ] Reached target Swap.
         Starting Load/Save Random Seed...
         Starting Create Static Device Nodes in /dev...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Started Setup Virtual Console.
[  OK  ] Started udev Coldplug all Devices.
[   42.110978] NMI watchdog: Watchdog detected hard LOCKUP on cpu 15
[   42.110978] Modules linked in: ip_tables xfs libcrc32c sr_mod cdrom sd=
_mod sg mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_f=
ops drm_vram_helper drm_ttm_helper ttm ahci libahci ixgbe drm crc32c_inte=
l libata mdio dca i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod
[   42.110986] CPU: 15 PID: 1395 Comm: systemd-journal Not tainted 5.5.0-=
rc7+ #4
[   42.110986] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS S=
E5C610.86B.01.01.6024.071720181717 07/17/2018
[   42.110987] RIP: 0010:native_queued_spin_lock_slowpath+0x5d/0x1c0
[   42.110988] Code: 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 3=
0 e4 09 d0 a9 00 01 ff ff 75 47 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 8b 07=
 <84> c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 81 fe 00 01 00 00 75
[   42.110988] RSP: 0018:ffffbbe207a7bc48 EFLAGS: 00000002
[   42.110989] RAX: 0000000000f80101 RBX: ffffffffa1576e80 RCX: 000000000=
0000000
[   42.110990] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffa=
1e95660
[   42.110990] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
000000b
[   42.110991] R10: ffffa075df5dcf80 R11: ffffffffa0ebfda0 R12: ffffffffa=
1e95660
[   42.110991] R13: ffffffffa1e97680 R14: ffffffffa17197a0 R15: 000000000=
0000047
[   42.110991] FS:  00007f7c5642a980(0000) GS:ffffa075df5c0000(0000) knlG=
S:0000000000000000
[   42.110992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.110992] CR2: 00007ffe95f4c4c0 CR3: 000000084fbfc004 CR4: 000000000=
03606e0
[   42.110993] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[   42.110993] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[   42.110993] Call Trace:
[   42.110993]  _raw_spin_lock+0x1a/0x20
[   42.110994]  console_unlock+0x9e/0x450
[   42.110994]  bust_spinlocks+0x16/0x30
[   42.110994]  oops_end+0x33/0xc0
[   42.110995]  general_protection+0x32/0x40
[   42.110995] RIP: 0010:copy_data+0xf2/0x1e0
[   42.110995] Code: eb 08 49 83 c4 08 0f 84 8e 00 00 00 4c 89 74 24 08 4=
c 89 cd 41 89 d6 44 89 44 24 04 49 39 db 0f 87 c6 00 00 00 4d 85 c9 74 43=
 <41> c7 01 00 00 00 00 48 85 db 74 37 4c 89 e7 48 89 da 41 bf 01 00
[   42.110996] RSP: 0018:ffffbbe207a7bd80 EFLAGS: 00010002
[   42.110996] RAX: ffffa075d44ca000 RBX: 00000000000000a8 RCX: fffffffff=
ff000b0
[   42.110997] RDX: 00000000000000a8 RSI: 00000fffffffff01 RDI: ffffffffa=
1456e00
[   42.110997] RBP: 0801364600307073 R08: 0000000000002000 R09: 080136460=
0307073
[   42.110997] R10: fffffffffff00000 R11: 00000000000000a8 R12: ffffffffa=
1e98330
[   42.110998] R13: 00000000d7efbe00 R14: 00000000000000a8 R15: 00000000f=
fffc000
[   42.110998]  _prb_read_valid+0xd8/0x190
[   42.110998]  prb_read_valid+0x15/0x20
[   42.110999]  devkmsg_read+0x9d/0x2a0
[   42.110999]  vfs_read+0x91/0x140
[   42.110999]  ksys_read+0x59/0xd0
[   42.111000]  do_syscall_64+0x55/0x1b0
[   42.111000]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.111000] RIP: 0033:0x7f7c55740b62
[   42.111001] Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0=
f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 e6 d8 20 00 85 c0 75 12 31 c0 0f 05=
 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
[   42.111001] RSP: 002b:00007ffe95f4c4a8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000000
[   42.111002] RAX: ffffffffffffffda RBX: 00007ffe95f4e500 RCX: 00007f7c5=
5740b62
[   42.111002] RDX: 0000000000002000 RSI: 00007ffe95f4c4b0 RDI: 000000000=
0000008
[   42.111002] RBP: 0000000000000000 R08: 0000000000000100 R09: 000000000=
0000003
[   42.111003] R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffe9=
5f4c4b0
[   42.111003] R13: 00007ffe95f4e910 R14: 0000000000000000 R15: 000000000=
0000000
[   42.111003] Kernel panic - not syncing: Hard LOCKUP
[   42.111004] Shutting down cpus with NMI
[   42.111004] Kernel Offset: 0x1f000000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
[   42.111005] general protection fault: 0000 [#1] SMP PTI
[   42.111005] CPU: 15 PID: 1395 Comm: systemd-journal Not tainted 5.5.0-=
rc7+ #4
[   42.111005] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS S=
E5C610.86B.01.01.6024.071720181717 07/17/2018
[   42.111006] RIP: 0010:copy_data+0xf2/0x1e0
[   42.111006] Code: eb 08 49 83 c4 08 0f 84 8e 00 00 00 4c 89 74 24 08 4=
c 89 cd 41 89 d6 44 89 44 24 04 49 39 db 0f 87 c6 00 00 00 4d 85 c9 74 43=
 <41> c7 01 00 00 00 00 48 85 db 74 37 4c 89 e7 48 89 da 41 bf 01 00
[   42.111007] RSP: 0018:ffffbbe207a7bd80 EFLAGS: 00010002
[   42.111007] RAX: ffffa075d44ca000 RBX: 00000000000000a8 RCX: fffffffff=
ff000b0
[   42.111008] RDX: 00000000000000a8 RSI: 00000fffffffff01 RDI: ffffffffa=
1456e00
[   42.111008] RBP: 0801364600307073 R08: 0000000000002000 R09: 080136460=
0307073
[   42.111008] R10: fffffffffff00000 R11: 00000000000000a8 R12: ffffffffa=
1e98330
[   42.111009] R13: 00000000d7efbe00 R14: 00000000000000a8 R15: 00000000f=
fffc000
[   42.111009] FS:  00007f7c5642a980(0000) GS:ffffa075df5c0000(0000) knlG=
S:0000000000000000
[   42.111010] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.111010] CR2: 00007ffe95f4c4c0 CR3: 000000084fbfc004 CR4: 000000000=
03606e0
[   42.111011] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
[   42.111011] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
[   42.111012] Call Trace:
[   42.111012]  _prb_read_valid+0xd8/0x190
[   42.111012]  prb_read_valid+0x15/0x20
[   42.111013]  devkmsg_read+0x9d/0x2a0
[   42.111013]  vfs_read+0x91/0x140
[   42.111013]  ksys_read+0x59/0xd0
[   42.111014]  do_syscall_64+0x55/0x1b0
[   42.111014]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   42.111014] RIP: 0033:0x7f7c55740b62
[   42.111015] Code: 94 20 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b6 0=
f 1f 80 00 00 00 00 f3 0f 1e fa 8b 05 e6 d8 20 00 85 c0 75 12 31 c0 0f 05=
 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89
[   42.111015] RSP: 002b:00007ffe95f4c4a8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000000
[   42.111016] RAX: ffffffffffffffda RBX: 00007ffe95f4e500 RCX: 00007f7c5=
5740b62
[   42.111016] RDX: 0000000000002000 RSI: 00007ffe95f4c4b0 RDI: 000000000=
0000008
[   42.111017] RBP: 0000000000000000 R08: 0000000000000100 R09: 000000000=
0000003
[   42.111017] R10: 0000000000000100 R11: 0000000000000246 R12: 00007ffe9=
5f4c4b0
[   42.111017] R13: 00007ffe95f4e910 R14: 0000000000000000 R15: 000000000=
0000000
[   42.111017] Modules linked in: ip_tables xfs libcrc32c sr_mod cdrom sd=
_mod sg mgag200 drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_f=
ops drm_vram_helper drm_ttm_helper ttm ahci libahci ixgbe drm crc32c_inte=
l libata mdio dca i2c_algo_bit wmi dm_mirror dm_region_hash dm_log dm_mod

--------------EF6EB99EA426AEC28C572523--


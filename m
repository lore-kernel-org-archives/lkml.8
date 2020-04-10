Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3FEC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF6D2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNT17xUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJTv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:51:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45440 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJTv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:51:59 -0400
Received: by mail-io1-f65.google.com with SMTP id i19so2826722ioh.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QeIu0nBH2w6lmp41iXG53bGhVpbraC4KJVd4JGc3z+I=;
        b=bNT17xUuUKeGG3lFwb8tjYEUCdXSphISqnjWiU9319OOU8IcuESv9kCf1EXThaLVyh
         QSc7zrm33Wb3/7dSH+GL1miEk1CyU54yTYWtcQA/nFVwTb4gXtUG5GI7apVD2xDBIybv
         K7hwiVUoE2G+LwDrHZLiNHVFtP3vmn/kWStldyWEpeKF+Ljwo8XFyKb5wMwgWuRNcHxC
         AOfQlYNANPNaKJUeIYJ/tNNKTDfxIIpGVRySK8l7ACd4b4Krns0bxwg2UhJcybrcD38T
         ny+Gx0y/oHHBD+bVHzNEbB1enRxEkIblGvjsnK/Vv38Nz3yBW5BSiPE+0WIdRpSH6D/N
         DmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QeIu0nBH2w6lmp41iXG53bGhVpbraC4KJVd4JGc3z+I=;
        b=UWdI9jlS5nRBHfR8mdmWRbiw6iVvOSE27DwuL7ovHCfRrrzSLCpZCMKIZ6lA3vMXJX
         MOLWYboiETPj23q89hVcmWkbVoBXUMfaIeMszPlc56gRZ6Pg+eqAsXHgtvY5Ebw3t51k
         qQ2bjsHacV0JqXCTahJdpWbgxtf0kLYQqgmWm5vFxK7SIdyuW/bXmB4nh2YYOqjY8z/0
         q79Nvq/7sJvtEUmrPCpnZyOFhZ3pxGT5XUapBnDC5SJpWYFEsXTarPFSGI3Y+PdmFS7a
         erTMBO1Rfsg0T9aEM2ltz5pyft0KtnA1TCg0QpusvUeg7UuH90OHVyS7yQX1ZcJ+ItpU
         uixw==
X-Gm-Message-State: AGi0PuZQg2bHenvnDGWHUf0vdonkh0WAdnQa/Tl3FZ4OWErvUZLYe1qJ
        iSUDxnwWVH6U9KV21dbC7Qr34DdYWc5R3WWWHHs=
X-Google-Smtp-Source: APiQypKTmZIwDBIGnT34zKo1s9IZHsvMPjtJMNZTaCve4AomuVNGvWzeRoxR7ceokDyX4Il8xJTBmbygQd1sUQ2BPek=
X-Received: by 2002:a02:603:: with SMTP id 3mr6105672jav.132.1586548318795;
 Fri, 10 Apr 2020 12:51:58 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 11 Apr 2020 00:51:48 +0500
Message-ID: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
Subject: BUG: kernel NULL pointer dereference, address: 0000000000000026 after
 switching to 5.7 kernel
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.
After upgrade kernel to 5.7 I see every boot in kernel log following
error messages:

[    2.569513] [drm] Found UVD firmware ENC: 1.2 DEC: .43 Family ID: 19
[    2.569538] [drm] PSP loading UVD firmware
[    2.570038] BUG: kernel NULL pointer dereference, address: 0000000000000026
[    2.570045] #PF: supervisor read access in kernel mode
[    2.570050] #PF: error_code(0x0000) - not-present page
[    2.570055] PGD 0 P4D 0
[    2.570060] Oops: 0000 [#1] SMP NOPTI
[    2.570065] CPU: 5 PID: 667 Comm: uvd_enc_1.1 Not tainted
5.7.0-0.rc0.git6.1.2.fc33.x86_64 #1
[    2.570072] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 1405 11/19/2019
[    2.570085] RIP: 0010:__kthread_should_park+0x5/0x30
[    2.570090] Code: 00 e9 fe fe ff ff e8 ca 3a 08 00 e9 49 fe ff ff
48 89 df e8 dd 38 08 00 84 c0 0f 84 6a ff ff ff e9 a6 fe ff ff 0f 1f
44 00 00 <f6> 47 26 20 74 12 48 8b 87 88 09 00 00 48 8b 00 48 c1 e8 02
83 e0
[    2.570103] RSP: 0018:ffffad8141723e50 EFLAGS: 00010246
[    2.570107] RAX: 7fffffffffffffff RBX: ffff8a8d1d116ed8 RCX: 0000000000000000
[    2.570112] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
[    2.570116] RBP: ffff8a8d28c11300 R08: 0000000000000000 R09: 0000000000000000
[    2.570120] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a8d1d152e40
[    2.570125] R13: ffff8a8d1d117280 R14: ffff8a8d1d116ed8 R15: ffff8a8d1ca68000
[    2.570131] FS:  0000000000000000(0000) GS:ffff8a8d3aa00000(0000)
knlGS:0000000000000000
[    2.570137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.570142] CR2: 0000000000000026 CR3: 00000007e3dc6000 CR4: 00000000003406e0
[    2.570147] Call Trace:
[    2.570157]  drm_sched_get_cleanup_job+0x42/0x130 [gpu_sched]
[    2.570166]  drm_sched_main+0x6f/0x530 [gpu_sched]
[    2.570173]  ? lockdep_hardirqs_on+0x11e/0x1b0
[    2.570179]  ? drm_sched_get_cleanup_job+0x130/0x130 [gpu_sched]
[    2.570185]  kthread+0x131/0x150
[    2.570189]  ? __kthread_bind_mask+0x60/0x60
[    2.570196]  ret_from_fork+0x27/0x50
[    2.570203] Modules linked in: fjes(-) amdgpu(+) amd_iommu_v2
gpu_sched ttm drm_kms_helper drm crc32c_intel igb nvme nvme_core dca
i2c_algo_bit wmi pinctrl_amd br_netfilter bridge stp llc fuse
[    2.570223] CR2: 0000000000000026
[    2.570228] ---[ end trace 80c25d326e1e0d7c ]---
[    2.570233] RIP: 0010:__kthread_should_park+0x5/0x30
[    2.570238] Code: 00 e9 fe fe ff ff e8 ca 3a 08 00 e9 49 fe ff ff
48 89 df e8 dd 38 08 00 84 c0 0f 84 6a ff ff ff e9 a6 fe ff ff 0f 1f
44 00 00 <f6> 47 26 20 74 12 48 8b 87 88 09 00 00 48 8b 00 48 c1 e8 02
83 e0
[    2.570250] RSP: 0018:ffffad8141723e50 EFLAGS: 00010246
[    2.570255] RAX: 7fffffffffffffff RBX: ffff8a8d1d116ed8 RCX: 0000000000000000
[    2.570260] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
[    2.570265] RBP: ffff8a8d28c11300 R08: 0000000000000000 R09: 0000000000000000
[    2.570271] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a8d1d152e40
[    2.570276] R13: ffff8a8d1d117280 R14: ffff8a8d1d116ed8 R15: ffff8a8d1ca68000
[    2.570281] FS:  0000000000000000(0000) GS:ffff8a8d3aa00000(0000)
knlGS:0000000000000000
[    2.570287] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.570292] CR2: 0000000000000026 CR3: 00000007e3dc6000 CR4: 00000000003406e0
[    2.570299] BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:49
[    2.570306] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
667, name: uvd_enc_1.1
[    2.570311] INFO: lockdep is turned off.
[    2.570315] irq event stamp: 14
[    2.570319] hardirqs last  enabled at (13): [<ffffffffb1b8c976>]
_raw_spin_unlock_irqrestore+0x46/0x60
[    2.570330] hardirqs last disabled at (14): [<ffffffffb1004932>]
trace_hardirqs_off_thunk+0x1a/0x1c
[    2.570338] softirqs last  enabled at (0): [<ffffffffb10e04f6>]
copy_process+0x706/0x1bc0
[    2.570345] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    2.570351] CPU: 5 PID: 667 Comm: uvd_enc_1.1 Tainted: G      D
      5.7.0-0.rc0.git6.1.2.fc33.x86_64 #1
[    2.570358] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 1405 11/19/2019
[    2.570365] Call Trace:
[    2.570373]  dump_stack+0x8b/0xc8
[    2.570380]  ___might_sleep.cold+0xb6/0xc6
[    2.570385]  exit_signals+0x1c/0x2d0
[    2.570390]  do_exit+0xb1/0xc30
[    2.570395]  ? kthread+0x131/0x150
[    2.570400]  rewind_stack_do_exit+0x17/0x20
[    2.570559] [drm] Found VCE firmware Version: 57.6 Binary ID: 4
[    2.570572] [drm] PSP loading VCE firmware
[    3.146462] [drm] reserve 0x400000 from 0x83fe800000 for PSP TMR

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux __kthread_should_park+0x5
__kthread_should_park+0x5/0x30:
to_kthread at kernel/kthread.c:75
(inlined by) __kthread_should_park at kernel/kthread.c:109

I think this issue related to amdgpu driver.
Can anyone look into it?

Thanks.

Full kernel log here:
https://pastebin.com/RrSp6KYL

--
Best Regards,
Mike Gavrilov.

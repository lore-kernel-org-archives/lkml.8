Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93D92067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGII7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:59:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:41734 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGII7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:59:19 -0400
Received: by mail-io1-f69.google.com with SMTP id n3so856735iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 01:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LGqLODc4HGQ5xzNFpLq0IH0ZYBFoMrEw5ZuA1wUgMck=;
        b=QD3jwqMyrJDtGQtfAAI/TmSeZlzetr8p5eiBcLObiyskKqfMsqClwWsL7q8KFqS+jM
         V7ZMyoAb8VRScwiVFTlZK1U79RXc1lZF4PpKlG+3KWFgjO0JRILBoZ8ISZ+fi37RW2Gf
         +rZlWo8705FOMzDyb+3K/E/gGcFdpnFX7t2wuDzy/y4oeFAzsOX17m3nzm2waJooi/gD
         /+vgjmJoGFYZHHdT3kBGX7ZcI8m0oVCUdE4OIf1UZGaLrKetz5ATWOD4NV9Q0MXCByqa
         LO4bZq0yYkM/t+W+Fe+jGKMmGvJgFzI8D4epMvLB7+F38UKCKpR8vIACeilHSLs5FKEH
         lf2Q==
X-Gm-Message-State: AOAM530fAlL2sHF5ke360eAYNfpuwdIG0r3BIV2Ap/q8g1Z062AxXdlH
        w2qkZhtGihE7QHp/FPQ2FEhtzEzmaa47QFhjnKUjADiOViJq
X-Google-Smtp-Source: ABdhPJxNHGo6m3Iiw/201KlTC4qcTluFpu2sbu9PyrxOirwyMtJkIfnAsi4iRRiseiCwLotvOU6IAZ+dGd2QXzyR7SLNa/LeTirm
MIME-Version: 1.0
X-Received: by 2002:a6b:4409:: with SMTP id r9mr40481641ioa.158.1594285157558;
 Thu, 09 Jul 2020 01:59:17 -0700 (PDT)
Date:   Thu, 09 Jul 2020 01:59:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007cad8705a9fe70b6@google.com>
Subject: KASAN: use-after-free Read in delete_and_unsubscribe_port (2)
From:   syzbot <syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11561e7b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=1a54a94bd32716796edd
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1a54a94bd32716796edd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in list_empty include/linux/list.h:282 [inline]
BUG: KASAN: use-after-free in delete_and_unsubscribe_port+0x420/0x4f0 sound/core/seq/seq_ports.c:530
Read of size 8 at addr ffff88809533de50 by task syz-executor.0/29034

CPU: 0 PID: 29034 Comm: syz-executor.0 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 list_empty include/linux/list.h:282 [inline]
 delete_and_unsubscribe_port+0x420/0x4f0 sound/core/seq/seq_ports.c:530
 snd_seq_port_disconnect+0x433/0x5c0 sound/core/seq/seq_ports.c:610
 snd_seq_ioctl_unsubscribe_port+0x1fc/0x400 sound/core/seq/seq_clientmgr.c:1525
 snd_seq_ioctl+0x202/0x3e0 sound/core/seq/seq_clientmgr.c:2157
 snd_seq_ioctl_compat+0xdc/0x2d0 sound/core/seq/seq_compat.c:109
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:847
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:403
 __do_fast_syscall_32 arch/x86/entry/common.c:448 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:474
 entry_SYSENTER_compat+0x6d/0x7c arch/x86/entry/entry_64_compat.S:138
RIP: 0023:0xf7ff0569
Code: Bad RIP value.
RSP: 002b:00000000f5deb0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000040505331
RDX: 0000000020000200 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 29030:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x14f/0x2d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 snd_seq_port_connect+0x5d/0x520 sound/core/seq/seq_ports.c:553
 snd_seq_ioctl_subscribe_port+0x1fc/0x400 sound/core/seq/seq_clientmgr.c:1484
 snd_seq_ioctl+0x202/0x3e0 sound/core/seq/seq_clientmgr.c:2157
 snd_seq_ioctl_compat+0xdc/0x2d0 sound/core/seq/seq_compat.c:109
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:847
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:403
 __do_fast_syscall_32 arch/x86/entry/common.c:448 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:474
 entry_SYSENTER_compat+0x6d/0x7c arch/x86/entry/entry_64_compat.S:138

Freed by task 29035:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 snd_seq_port_disconnect+0x4c1/0x5c0 sound/core/seq/seq_ports.c:614
 snd_seq_ioctl_unsubscribe_port+0x1fc/0x400 sound/core/seq/seq_clientmgr.c:1525
 snd_seq_ioctl+0x202/0x3e0 sound/core/seq/seq_clientmgr.c:2157
 snd_seq_ioctl_compat+0xdc/0x2d0 sound/core/seq/seq_compat.c:109
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:847
 do_syscall_32_irqs_on+0x3f/0x60 arch/x86/entry/common.c:403
 __do_fast_syscall_32 arch/x86/entry/common.c:448 [inline]
 do_fast_syscall_32+0x7f/0x120 arch/x86/entry/common.c:474
 entry_SYSENTER_compat+0x6d/0x7c arch/x86/entry/entry_64_compat.S:138

The buggy address belongs to the object at ffff88809533de00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 80 bytes inside of
 128-byte region [ffff88809533de00, ffff88809533de80)
The buggy address belongs to the page:
page:ffffea000254cf40 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88809533d100
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00029c2e48 ffffea0002257d48 ffff8880aa000700
raw: ffff88809533d100 ffff88809533d000 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809533dd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809533dd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88809533de00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                 ^
 ffff88809533de80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88809533df00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

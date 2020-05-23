Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3636C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 14:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C072072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 14:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgEWOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 10:37:16 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55580 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgEWOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 10:37:16 -0400
Received: by mail-il1-f197.google.com with SMTP id x20so11198692ilj.22
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 07:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JTLjpJotlBYtj20lijo2JeDWAKa3e3dTd3xmvcIoBYI=;
        b=IjxFIacvEjs3bfta60rStmhKdNdG6yCXDZdPa60KBZ17ELnAAbKuGOXrR6aINXnqBB
         SkkmDzBUAb0PylG2SzGQSl4pJz3PFY4SKfXmd7lKaR23lLC8Etn9Y1U/F1ZfuXGOF/U7
         dcmc2+nJOW8My8R3AxlvttD6t5ZM0bKOzgbLZXEMUngYXXy0ArIyR7XtWsPgFcNru9Id
         Q2cIoHXXmzh/P4/cYaTQeCCuLFTWIwauLRKAGvz16qTiUwrPpiYMCM3PBZpAeoGx4AM2
         9vSh6CQONuL4jbZ+pIcHLI70JoM6XwJ7dP8+eQZCRYGaUdNyzIpsE31+l1KFkRoCIwVN
         h35A==
X-Gm-Message-State: AOAM532oqp6HihNUv3jG81Jx2Y6iS/P7mu4urMIpM4QQcIPq9m+FC053
        ssLs/BHyAbxThiEtARNDH84CRAJ6cHfMo8NDDmz96BBBmbYG
X-Google-Smtp-Source: ABdhPJzmXUW14Bq0SeNAnekAkCASeu/xxBnvKP50jWRGrH4tFotHPrcng9yJ87dXkQYDYPw46RgWRPAWYc5S7kx6l/IAKI/LhPqv
MIME-Version: 1.0
X-Received: by 2002:a02:6649:: with SMTP id l9mr12136458jaf.94.1590244634684;
 Sat, 23 May 2020 07:37:14 -0700 (PDT)
Date:   Sat, 23 May 2020 07:37:14 -0700
In-Reply-To: <000000000000ba47b705a6443a0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e6f7b05a651ae10@google.com>
Subject: Re: KASAN: use-after-free Read in uif_close
From:   syzbot <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c11d28ab Add linux-next specific files for 20200522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=158d1baa100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
dashboard link: https://syzkaller.appspot.com/bug?extid=0ce97ea45b008ba3b8bd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b23f06100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111b0172100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com

ubi0: detaching mtd0
==================================================================
BUG: KASAN: use-after-free in uif_close+0x15e/0x190 drivers/mtd/ubi/build.c:502
Read of size 4 at addr ffff8880a6ff09e8 by task syz-executor247/8078

CPU: 1 PID: 8078 Comm: syz-executor247 Not tainted 5.7.0-rc6-next-20200522-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 uif_close+0x15e/0x190 drivers/mtd/ubi/build.c:502
 ubi_detach_mtd_dev+0x226/0x432 drivers/mtd/ubi/build.c:1110
 ctrl_cdev_ioctl+0x1bf/0x2b0 drivers/mtd/ubi/cdev.c:1068
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x44af69
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f48c29a8ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e7a08 RCX: 000000000044af69
RDX: 000000000076006e RSI: 0000000040046f41 RDI: 0000000000000003
RBP: 00000000006e7a00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e7a0c
R13: 00007ffe9ed2c70f R14: 00007f48c29a99c0 R15: 20c49ba5e353f7cf

Allocated by task 8070:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 ubi_attach_mtd_dev+0x2e7/0x27c0 drivers/mtd/ubi/build.c:901
 ctrl_cdev_ioctl+0x229/0x2b0 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 8078:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 device_release+0x71/0x200 drivers/base/core.c:1541
 kobject_cleanup lib/kobject.c:701 [inline]
 kobject_release lib/kobject.c:732 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x2f0 lib/kobject.c:749
 cdev_device_del+0x69/0x80 fs/char_dev.c:575
 uif_close+0xea/0x190 drivers/mtd/ubi/build.c:501
 ubi_detach_mtd_dev+0x226/0x432 drivers/mtd/ubi/build.c:1110
 ctrl_cdev_ioctl+0x1bf/0x2b0 drivers/mtd/ubi/cdev.c:1068
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff8880a6ff0000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2536 bytes inside of
 8192-byte region [ffff8880a6ff0000, ffff8880a6ff2000)
The buggy address belongs to the page:
page:ffffea00029bfc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea00029bfc00 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0002382708 ffffea00028eb008 ffff8880aa0021c0
raw: 0000000000000000 ffff8880a6ff0000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a6ff0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a6ff0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880a6ff0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff8880a6ff0a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a6ff0a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


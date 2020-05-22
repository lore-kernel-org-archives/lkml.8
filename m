Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C8DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F2A207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgEVWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:34:19 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39697 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:34:19 -0400
Received: by mail-io1-f70.google.com with SMTP id d10so8284924iod.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EmYxmb/2U/RTfwJJW/3aPZNZUUDia3Ov8JpdgmvmdCY=;
        b=HjwN8XOD/2lnQx9euypUIqquUunvzSMQWgeTlosi2F1/U8vBMNl3ooJJ/We84i8CHU
         WnWq5OJ/Cmj+rO8ghcBcqrwK/G115JcPxGpZfknl+k/M04HE3+KDnjLfsU9VrkGGnCVn
         8f8kUGht1pieazrHFle6PUEP/vi0nLoxZVV4EsF6wBMz3ZSONYQn6amdD1yl12ut6hL3
         fXN7Q+lNjthVYrlQgPnXdtBCta6vo7KERml1SzNEO16WgwKzFr3APwop2bMlP4UypIgS
         oXg1Bm6e5dLIvUtqZbEI4Uxp2Qi55D/6ewWQ/4kOWqcQ/pl6RJ0Di9TBXmYfKhECLcwx
         OFbg==
X-Gm-Message-State: AOAM5322HwGUnodyA39B9gJWnfW/wEMPZqx/Ia7O5UwIEnAtphZzuybO
        CQJ2YTrdEcPAINNN49xvNO15H5eX1Z80kWxMUwV4JWbIcQD2
X-Google-Smtp-Source: ABdhPJwVI3flKwNkODBtZnDXhXTNdA9AAqawT88DmykccDomzO7SI1EgmdzxV2BXnwYG3a/m2AKt34E4AegarawB7pNZATH3KQdt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f4e:: with SMTP id y14mr15622360ilj.165.1590186856825;
 Fri, 22 May 2020 15:34:16 -0700 (PDT)
Date:   Fri, 22 May 2020 15:34:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba47b705a6443a0d@google.com>
Subject: KASAN: use-after-free Read in uif_close
From:   syzbot <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c11d28ab Add linux-next specific files for 20200522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1089b706100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
dashboard link: https://syzkaller.appspot.com/bug?extid=0ce97ea45b008ba3b8bd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15044ee2100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com

ubi0: attaching mtd0
ubi0: scanning is finished
ubi0: empty MTD device detected
ubi0 error: ubi_attach_mtd_dev: cannot spawn "ubi_bgt0d", error -4
==================================================================
BUG: KASAN: use-after-free in uif_close+0x15e/0x190 drivers/mtd/ubi/build.c:502
Read of size 4 at addr ffff888097fe49e8 by task syz-executor.0/7033

CPU: 0 PID: 7033 Comm: syz-executor.0 Not tainted 5.7.0-rc6-next-20200522-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 uif_close+0x15e/0x190 drivers/mtd/ubi/build.c:502
 ubi_attach_mtd_dev+0x157e/0x27c0 drivers/mtd/ubi/build.c:1036
 ctrl_cdev_ioctl+0x229/0x2b0 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca29
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd94dd97c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e1080 RCX: 000000000045ca29
RDX: 0000000000742508 RSI: 0000000040186f40 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000209 R14: 00000000004c44c1 R15: 00007fd94dd986d4

Allocated by task 7033:
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

Freed by task 7033:
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
 ubi_attach_mtd_dev+0x157e/0x27c0 drivers/mtd/ubi/build.c:1036
 ctrl_cdev_ioctl+0x229/0x2b0 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888097fe4000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 2536 bytes inside of
 8192-byte region [ffff888097fe4000, ffff888097fe6000)
The buggy address belongs to the page:
page:ffffea00025ff900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea00025ff900 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea000267f108 ffffea0002460708 ffff8880aa0021c0
raw: 0000000000000000 ffff888097fe4000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097fe4880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097fe4900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888097fe4980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888097fe4a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888097fe4a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

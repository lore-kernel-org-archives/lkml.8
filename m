Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30379C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AD0221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgHGMTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:19:20 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:37654 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgHGMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:19:17 -0400
Received: by mail-il1-f198.google.com with SMTP id k69so1390509ilg.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 05:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lTtdC+vCkszF8sYUSIwFc5FRid7eCFAUZQejKiH4rZ4=;
        b=fqdtft7V6CNxROZtlyBUvK0wlqNFmFk1uMKrs0VFOMjez1KJvXzbMgWSKNJuMlZyij
         J4pwcB+OWIMdqQnAXkhHDz/WFMJ06A6pj8g0uVZTb7NoLK69ENNyIYGY9BSa3/vzmIqj
         FIB+8P1zPCBda+d7PWP+SqdWx5SU5GOeJ9WT8YQ8g0SYfe9EDcktI5ueSlq09LXoQDbc
         xGcq6ElynmWXVwbWpTkJShroNJnOZ9KUSBhplz7N4qCihTuCQsvNEH2U4VMyEWSiKjIH
         ayyFU2sWpwFP1jngXB3inSThjidEBlwDCDUnhNt8eqCIl2Fo8ZXZtIEq2F8bzSdoovNR
         Zr0Q==
X-Gm-Message-State: AOAM530DLgu8uUN8WoEeCqD/KE12km3IL0cYG2rgZ75S/5aeIarzwenf
        wW1mZd4qOw67hW1+fWOi9tczHPVDCrX4aSUQ5BUBo10gAO2n
X-Google-Smtp-Source: ABdhPJzi0MVNUkZtYsJ4KYJoCAoCWdPB8jH+AwlKoJIupbnYoEVZqJInqSVTShxc4KiyI5iqyUfm9JEEpOaFkFEv3AnE2MiCj5kH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:bc2:: with SMTP id g2mr4666407jad.21.1596802756269;
 Fri, 07 Aug 2020 05:19:16 -0700 (PDT)
Date:   Fri, 07 Aug 2020 05:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000105ec205ac489d59@google.com>
Subject: KASAN: use-after-free Read in service_outstanding_interrupt
From:   syzbot <syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7b4ea945 Revert "x86/mm/64: Do not sync vmalloc/ioremap ma..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=108adf32900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72a84c46d0c668c
dashboard link: https://syzkaller.appspot.com/bug?extid=9e04e2df4a32fb661daf
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e04e2df4a32fb661daf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in usb_submit_urb+0x10c4/0x13e0 drivers/usb/core/urb.c:368
Read of size 4 at addr ffff8881caa52018 by task syz-executor.3/13922

CPU: 1 PID: 13922 Comm: syz-executor.3 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 print_address_description.constprop.0+0x1a/0x210 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x37/0x7c mm/kasan/report.c:530
 usb_submit_urb+0x10c4/0x13e0 drivers/usb/core/urb.c:368
 service_outstanding_interrupt.part.0+0x5f/0xa0 drivers/usb/class/cdc-wdm.c:463
 service_outstanding_interrupt drivers/usb/class/cdc-wdm.c:458 [inline]
 wdm_read+0x9a0/0xbd0 drivers/usb/class/cdc-wdm.c:576
 vfs_read+0x1df/0x520 fs/read_write.c:479
 ksys_read+0x12d/0x250 fs/read_write.c:607
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ce79
Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8d2099fc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000000252c0 RCX: 000000000045ce79
RDX: 00000000000000f2 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007ffd66f595ff R14: 00007f8d209a09c0 R15: 000000000118bf2c

Allocated by task 4524:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 usb_alloc_dev+0x51/0xf67 drivers/usb/core/usb.c:582
 hub_port_connect drivers/usb/core/hub.c:5114 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1dff/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 5477:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x116/0x160 mm/kasan/common.c:455
 slab_free_hook mm/slub.c:1474 [inline]
 slab_free_freelist_hook+0x53/0x140 mm/slub.c:1507
 slab_free mm/slub.c:3072 [inline]
 kfree+0xbc/0x2c0 mm/slub.c:4052
 device_release+0x71/0x200 drivers/base/core.c:1800
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:752
 put_device+0x1b/0x30 drivers/base/core.c:3029
 hub_port_connect drivers/usb/core/hub.c:5059 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1c93/0x4390 drivers/usb/core/hub.c:5576
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff8881caa52000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 24 bytes inside of
 2048-byte region [ffff8881caa52000, ffff8881caa52800)
The buggy address belongs to the page:
page:ffffea00072a9400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea00072a9400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 0000000000000000 0000000100000001 ffff8881da00c000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8881caa51f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8881caa51f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881caa52000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8881caa52080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8881caa52100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

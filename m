Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B8EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036A5207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgHUGJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:09:25 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40671 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:09:22 -0400
Received: by mail-il1-f200.google.com with SMTP id z5so756846ilp.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XsjeG8B0bLdPoJ/l3L9k6xJ8IluM+CnkVSyhaPmRmkE=;
        b=tOygUANwxTE8jEWNdq5z0OF+elDDyh1AzPrp7ZTJcAk7zsM7+xkLeAzdk6cNQdGoSR
         lEeNN0/FuKf36UrZuNGG3T4nvZg8sKbQpOaVSPAUSUHUA38Ux+P20MF4q7wyw8xLgUII
         pqRku1xyaBGbbG7zeEUty4l9bJBAJs9LNYwevz0JR+6a6k7rpqx2OLL3wwpIuejW2V2z
         WSWkcE0DHN8awQDhxO0DTQrhnqt0gF41TXXOM/n/Z7w07RZHYQYoGFnyNN+KaN3FncAl
         4UM0gqdfp/QrtvQkRnQ31KhFwe8d/VJGBCapIfxFK7DxOVzr/N0V/IKE9uLSvBq66N4r
         zesQ==
X-Gm-Message-State: AOAM530xgjHhCkasWwB0QYeNSFaaWBW0PGGMqXVtJ9ue7ZYX3AD2afKl
        dRYaUg0bFS+HdBhi0oXpz0RT3KIjRlGn22FXDE4AE8Q4RJAi
X-Google-Smtp-Source: ABdhPJwDtKgU3dnjoil2snozHFn0iOOJIbjC8oBbaavnTjJDwkBcEOhFKNky0HTMps3hc4D10uxSwQqAY7gnQREZ9tKRDGwhwy1/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d4f:: with SMTP id d15mr1177740jak.119.1597990161149;
 Thu, 20 Aug 2020 23:09:21 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8f42805ad5d136c@google.com>
Subject: KASAN: use-after-free Write in vcs_read
From:   syzbot <syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    605cbf3d Add linux-next specific files for 20200820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=157e75ce900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61d44f28687f508
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1f53726c3bd11180cb
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
BUG: KASAN: use-after-free in vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
Write of size 2 at addr ffff8880a8014000 by task syz-executor.5/16936

CPU: 1 PID: 16936 Comm: syz-executor.5 Not tainted 5.9.0-rc1-next-20200820-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
 vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
 vfs_read+0x1df/0x5a0 fs/read_write.c:479
 ksys_read+0x12d/0x250 fs/read_write.c:607
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d4d9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa15c60dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000025ec0 RCX: 000000000045d4d9
RDX: 0000000000002020 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffd27ec646f R14: 00007fa15c60e9c0 R15: 000000000118cf4c

Allocated by task 5:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:517 [inline]
 slab_alloc_node mm/slab.c:3254 [inline]
 kmem_cache_alloc_node+0x136/0x3f0 mm/slab.c:3574
 __alloc_skb+0x71/0x550 net/core/skbuff.c:198
 alloc_skb include/linux/skbuff.h:1085 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:501 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:558 [inline]
 nsim_dev_trap_report_work+0x2b2/0xbe0 drivers/net/netdevsim/dev.c:599
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 5:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:622
 __kfree_skb net/core/skbuff.c:679 [inline]
 consume_skb net/core/skbuff.c:837 [inline]
 consume_skb+0xcf/0x160 net/core/skbuff.c:831
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:574 [inline]
 nsim_dev_trap_report_work+0x889/0xbe0 drivers/net/netdevsim/dev.c:599
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff8880a8014000
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 0 bytes inside of
 224-byte region [ffff8880a8014000, ffff8880a80140e0)
The buggy address belongs to the page:
page:00000000a263cd02 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa8014
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000277a2c8 ffffea0002551888 ffff8880a9050d00
raw: 0000000000000000 ffff8880a8014000 000000010000000c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a8013f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a8013f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880a8014000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880a8014080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880a8014100: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

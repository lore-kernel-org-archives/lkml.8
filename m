Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1210C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876B7206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 21:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgHHV1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 17:27:17 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56306 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgHHV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 17:27:16 -0400
Received: by mail-io1-f69.google.com with SMTP id k10so4354262ioh.22
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 14:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IADNMrokZmxOUKia7Uum9r4PEiRU6p/oiYSUbRzW15k=;
        b=oZY4ouezWoXv5O3VK8aJK6H5EwG4jd6uTp1eG8AUkacV9P0MKeYgynOyF9vRNXOG25
         Nc0Y6uqod1akFN4f06FUduT4Fq5a/8Xikr5BGYgClBjNKwQqIk70OFTBJpv/cCoYi4vq
         ibcNzw8o9RbIYItcvxGU+AqiLGIJJ2nfx7ws5hOBqf3ulKua1AZ+CSvBSPUzrStJgnwV
         v0iXeUEJWfCAVdzYiFkqQIOWxPEjqb9uYpD7g/mIhV6yOjx9VXos1KxDATMCkzTx8OAv
         VPmxSR47lhTaO6GIiklB1OPWuFKBqozA67iGJvDAC63mNuwabT/uDD+hhRnTzTaufEIj
         uNew==
X-Gm-Message-State: AOAM533KFwnH0TmmK3ibjP9IFEfEWK5ewQjzqFop8fBnXjo1F1awD/Ac
        tgYo2GrNLu7J8hUuPKu/UnUkpI2O5WjrKiGXgWgcYIyFX0zB
X-Google-Smtp-Source: ABdhPJwi//OPGAqjzWtcAVqRFu+q32nwkVhlurk0BWqeIBfa0Ekl0+QoU8oNh+cSdWS3Pxj6iDOfUcGVs6UiB/m7Cr7fogCDrGei
MIME-Version: 1.0
X-Received: by 2002:a92:c7d0:: with SMTP id g16mr10954289ilk.101.1596922035608;
 Sat, 08 Aug 2020 14:27:15 -0700 (PDT)
Date:   Sat, 08 Aug 2020 14:27:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aaa4a905ac646223@google.com>
Subject: KASAN: use-after-free Read in __queue_work (3)
From:   syzbot <syzbot+77e5e02c6c81136cdaff@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127a8d66900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=77e5e02c6c81136cdaff
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e36a4900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77e5e02c6c81136cdaff@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __queue_work+0xc6c/0xf20 kernel/workqueue.c:1412
Read of size 4 at addr ffff88809f1ab9c0 by task syz-executor.3/16144

CPU: 0 PID: 16144 Comm: syz-executor.3 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 __queue_work+0xc6c/0xf20 kernel/workqueue.c:1412
 queue_work_on+0x18b/0x200 kernel/workqueue.c:1518
 queue_work include/linux/workqueue.h:507 [inline]
 req_run+0x2c5/0x4a0 net/bluetooth/hci_request.c:90
 hci_req_run_skb net/bluetooth/hci_request.c:102 [inline]
 __hci_req_sync+0x1dd/0x830 net/bluetooth/hci_request.c:215
 hci_req_sync+0x8a/0xc0 net/bluetooth/hci_request.c:282
 hci_dev_cmd+0x5b3/0x950 net/bluetooth/hci_core.c:2011
 hci_sock_ioctl+0x3fa/0x800 net/bluetooth/hci_sock.c:1053
 sock_do_ioctl+0xcb/0x2d0 net/socket.c:1048
 sock_ioctl+0x3b8/0x730 net/socket.c:1199
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cce9
Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f18d49bfc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000001d300 RCX: 000000000045cce9
RDX: 0000000020000000 RSI: 00000000400448de RDI: 0000000000000004
RBP: 000000000078c080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c04c
R13: 00007ffc84a6ab1f R14: 00007f18d49c09c0 R15: 000000000078c04c

Allocated by task 9187:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x17a/0x340 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 alloc_workqueue+0x166/0xe50 kernel/workqueue.c:4265
 hci_register_dev+0x1b5/0x930 net/bluetooth/hci_core.c:3509
 __vhci_create_device+0x2ac/0x5b0 drivers/bluetooth/hci_vhci.c:124
 vhci_create_device drivers/bluetooth/hci_vhci.c:148 [inline]
 vhci_open_timeout+0x38/0x50 drivers/bluetooth/hci_vhci.c:305
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Freed by task 16170:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 rcu_do_batch kernel/rcu/tree.c:2427 [inline]
 rcu_core+0x5c7/0x1190 kernel/rcu/tree.c:2655
 __do_softirq+0x2de/0xa24 kernel/softirq.c:298

The buggy address belongs to the object at ffff88809f1ab800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 448 bytes inside of
 1024-byte region [ffff88809f1ab800, ffff88809f1abc00)
The buggy address belongs to the page:
page:ffffea00027c6ac0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00028becc8 ffffea00028ddbc8 ffff8880aa000c40
raw: 0000000000000000 ffff88809f1ab000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809f1ab880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809f1ab900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88809f1ab980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88809f1aba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809f1aba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

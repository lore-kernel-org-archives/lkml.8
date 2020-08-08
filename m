Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83BE420866
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgHHG4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 02:56:20 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:32842 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHHG4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 02:56:20 -0400
Received: by mail-io1-f70.google.com with SMTP id a12so3328134ioo.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 23:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PU7yqFGMVKvrXPZB8XKknR7zBk1zUbYuGJQogoX3Viw=;
        b=T3NOeBsuwHXEdjlTy7G5hWl+2ovM0KQlBKrkCjNxMKfphBd0pLinCL3YuTZ29jAiJ2
         3MmXczhonzjNEVXAqwcMlygqQf6Ayr3BGtnBVy/Vft0LOvDpvszC9wBkL1cdCiH3+5U1
         dMvc/bycYazY8fKGTpdRgOwVziNbjw+qJ6sGQY2jSoUYIWFVXENOajdtRmuwtvhM/TM9
         tF+bMvc6wRUiZWufZFfrqP0xsRf6HD7lxQoRaAKZ5pCiAMAsT5/G1VlpMCVWZCUmgFsD
         6CilahO3j3GmWQhP30tc+DXzOkhf6Htz2osWQnYcVHAjUs/SozLA8+iAIgqCOX9NIPOe
         hQBg==
X-Gm-Message-State: AOAM531eRNLU8Uge3UiGgw+AFnFOcvqk/TiNA/PEuON1E4RSSSY4kIQI
        3/UL7nG+2XGi2zIep3R4nXVehrzXcJTdZTubbBa6PqO0CLaW
X-Google-Smtp-Source: ABdhPJwJok0tKX3N0EHJGvBinV+En+9WTSlTMOoK1f6SpNiSfFRIgFTy9mPXiPsajTS50wvhAhBbI7r0W5Cds9T3Fm+RoOsiWPtN
MIME-Version: 1.0
X-Received: by 2002:a92:5e9c:: with SMTP id f28mr8288344ilg.302.1596869778665;
 Fri, 07 Aug 2020 23:56:18 -0700 (PDT)
Date:   Fri, 07 Aug 2020 23:56:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e8fb4b05ac58372e@google.com>
Subject: KASAN: use-after-free Read in hci_get_auth_info
From:   syzbot <syzbot+13010b6a10bbd82cc79c@syzkaller.appspotmail.com>
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

HEAD commit:    d6efb3ac Merge tag 'tty-5.9-rc1' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ad2134900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ec43e42a83feae
dashboard link: https://syzkaller.appspot.com/bug?extid=13010b6a10bbd82cc79c
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fd9bc6900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13010b6a10bbd82cc79c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __mutex_waiter_is_first kernel/locking/mutex.c:200 [inline]
BUG: KASAN: use-after-free in __mutex_lock_common+0x12cd/0x2fc0 kernel/locking/mutex.c:1040
Read of size 8 at addr ffff88808e668060 by task syz-executor.4/19584

CPU: 0 PID: 19584 Comm: syz-executor.4 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 __mutex_waiter_is_first kernel/locking/mutex.c:200 [inline]
 __mutex_lock_common+0x12cd/0x2fc0 kernel/locking/mutex.c:1040
 __mutex_lock kernel/locking/mutex.c:1103 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
 hci_get_auth_info+0x69/0x3a0 net/bluetooth/hci_conn.c:1689
 hci_sock_bound_ioctl net/bluetooth/hci_sock.c:957 [inline]
 hci_sock_ioctl+0x5ae/0x750 net/bluetooth/hci_sock.c:1060
 sock_do_ioctl+0x7b/0x260 net/socket.c:1047
 sock_ioctl+0x4aa/0x690 net/socket.c:1198
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:760
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ccd9
Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f113a564c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000001d300 RCX: 000000000045ccd9
RDX: 0000000020000000 RSI: 00000000800448d7 RDI: 0000000000000005
RBP: 000000000078bf40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007ffd62ea93af R14: 00007f113a5659c0 R15: 000000000078bf0c

Allocated by task 6822:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 hci_alloc_dev+0x4c/0x1aa0 net/bluetooth/hci_core.c:3543
 __vhci_create_device drivers/bluetooth/hci_vhci.c:99 [inline]
 vhci_create_device+0x113/0x520 drivers/bluetooth/hci_vhci.c:148
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 9965:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 bt_host_release+0x18/0x20 net/bluetooth/hci_sysfs.c:86
 device_release+0x70/0x1a0 drivers/base/core.c:1796
 kobject_cleanup lib/kobject.c:704 [inline]
 kobject_release lib/kobject.c:735 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1a0/0x2c0 lib/kobject.c:752
 vhci_release+0x7b/0xc0 drivers/bluetooth/hci_vhci.c:341
 __fput+0x2f0/0x750 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0x5f3/0x1f20 kernel/exit.c:806
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:914
 __ia32_sys_exit_group+0x0/0x40 kernel/exit.c:912
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:912
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88808e668000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 96 bytes inside of
 8192-byte region [ffff88808e668000, ffff88808e66a000)
The buggy address belongs to the page:
page:ffffea0002399a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea0002399a00 order:2 compound_mapcount:0 compound_pincount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea000217a208 ffffea0001e6c008 ffff8880aa4021c0
raw: 0000000000000000 ffff88808e668000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808e667f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88808e667f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88808e668000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88808e668080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808e668100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

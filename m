Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06507C3F2D5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3A3246C2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCATNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:13:30 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:57174 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgCATNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:13:16 -0500
Received: by mail-il1-f197.google.com with SMTP id p67so9035118ili.23
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 11:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+hocJy3Djvzm+AC/AMDQI2B713JAwjXco/Pm4CAYZIg=;
        b=rfaWXuSgCbxsyiUrJqZdK7IucpiS6s7ZvcE8xofbjgGISFvSbddeUxTthrnJbFVeuc
         nKT2clBtcumGP6RX/LcWJWQbEnQOl0YTwDakFmHAXlFGlf8SadNB+xulFhjdWRrdli1L
         ech1PvTXeILX0V0ZR+64UXX4hThTDl/exxIAkg586810USg7fhKRN8YjL+mNCVd+MYMj
         nYT1t76hHOLRInE/e8R+GV8OGwJ8ch4dCzK2sKv0XKdNHkq2AURcmFQUxmpWW3JHqmIs
         FhNuV0AGPm2BNik6Zw0+Fv6l3ceYAnfF+04utQrQAgvM0m51xJVGWmQlUhoiopzJzV/7
         NDOQ==
X-Gm-Message-State: ANhLgQ3J2H+MF2+b8G+EdMfp3eVbRtJSHsgmRXLpgWbWth0KEG0B9Gg6
        loCUqPmaSaE/YR0LoOxYW3ufZqSRpQtbC771f5/BtNRjqVO2
X-Google-Smtp-Source: ADFU+vsoYgtQeW5DywQIWtvquyes8I6k0R/lSRXPBH1Say5Gy+frw6R18r60p+p0KdWkGCZgJ5c/kVdvYa+xI0el3jcLnLldqYJv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:34c:: with SMTP id x12mr1482598jap.80.1583089995896;
 Sun, 01 Mar 2020 11:13:15 -0800 (PST)
Date:   Sun, 01 Mar 2020 11:13:15 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da6059059fcfdcf9@google.com>
Subject: KASAN: use-after-free Read in skb_release_data (2)
From:   syzbot <syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a1d8f9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=a66a7c2e996797bb4acb
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c25a81e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a66a7c2e996797bb4acb@syzkaller.appspotmail.com

Bluetooth: Invalid header checksum
==================================================================
BUG: KASAN: use-after-free in skb_release_data+0x7bf/0x8c0 net/core/skbuff.c:603
Read of size 1 at addr ffff8880a3a31ec2 by task syz-executor.4/12769

CPU: 0 PID: 12769 Comm: syz-executor.4 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:374
 __kasan_report+0x149/0x1c0 mm/kasan/report.c:506
 kasan_report+0x26/0x50 mm/kasan/common.c:641
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 skb_release_data+0x7bf/0x8c0 net/core/skbuff.c:603
 skb_release_all net/core/skbuff.c:664 [inline]
 __kfree_skb+0x59/0x1c0 net/core/skbuff.c:678
 kfree_skb+0x76/0x110 net/core/skbuff.c:696
 h5_reset_rx drivers/bluetooth/hci_h5.c:531 [inline]
 h5_rx_3wire_hdr+0x18d/0x5f0 drivers/bluetooth/hci_h5.c:441
 h5_recv+0x207/0x650 drivers/bluetooth/hci_h5.c:564
 hci_uart_tty_receive+0x16b/0x470 drivers/bluetooth/hci_ldisc.c:613
 tiocsti drivers/tty/tty_io.c:2200 [inline]
 tty_ioctl+0xd5d/0x15c0 drivers/tty/tty_io.c:2576
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
 __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c479
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff8bad55f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000001d7b914 RCX: 000000000045c479
RDX: 00000000200000c0 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000583 R14: 00000000004c7d91 R15: 000000000076bf2c

Allocated by task 21:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:515
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 __do_kmalloc_node mm/slab.c:3616 [inline]
 __kmalloc_node_track_caller+0x4d/0x60 mm/slab.c:3630
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0xe8/0x500 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1081 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:341 [inline]
 h5_rx_pkt_start+0xda/0x2d0 drivers/bluetooth/hci_h5.c:475
 h5_recv+0x207/0x650 drivers/bluetooth/hci_h5.c:564
 hci_uart_tty_receive+0x16b/0x470 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
 tty_port_default_receive_buf+0x82/0xb0 drivers/tty/tty_port.c:38
 receive_buf drivers/tty/tty_buffer.c:481 [inline]
 flush_to_ldisc+0x328/0x550 drivers/tty/tty_buffer.c:533
 process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 21:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10d/0x220 mm/slab.c:3757
 skb_free_head net/core/skbuff.c:590 [inline]
 skb_release_data+0x72f/0x8c0 net/core/skbuff.c:610
 skb_release_all net/core/skbuff.c:664 [inline]
 __kfree_skb+0x59/0x1c0 net/core/skbuff.c:678
 kfree_skb+0x76/0x110 net/core/skbuff.c:696
 h5_reset_rx drivers/bluetooth/hci_h5.c:531 [inline]
 h5_rx_3wire_hdr+0x18d/0x5f0 drivers/bluetooth/hci_h5.c:441
 h5_recv+0x207/0x650 drivers/bluetooth/hci_h5.c:564
 hci_uart_tty_receive+0x16b/0x470 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x12f/0x170 drivers/tty/tty_buffer.c:465
 tty_port_default_receive_buf+0x82/0xb0 drivers/tty/tty_port.c:38
 receive_buf drivers/tty/tty_buffer.c:481 [inline]
 flush_to_ldisc+0x328/0x550 drivers/tty/tty_buffer.c:533
 process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880a3a30000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 7874 bytes inside of
 8192-byte region [ffff8880a3a30000, ffff8880a3a32000)
The buggy address belongs to the page:
page:ffffea00028e8c00 refcount:1 mapcount:0 mapping:ffff8880aa4021c0 index:0x0 compound_mapcount: 0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0001f4e908 ffffea0001f10108 ffff8880aa4021c0
raw: 0000000000000000 ffff8880a3a30000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a3a31d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a3a31e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880a3a31e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880a3a31f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a3a31f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

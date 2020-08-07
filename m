Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD16AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB45221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHGQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:47:28 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:45883 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGQrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:47:21 -0400
Received: by mail-il1-f199.google.com with SMTP id 65so1948610ilb.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0KluU1RLnMxS1ahAPUCEJr4pkzAjGYdf2Vdm5OzbWDw=;
        b=Xn+J8WuLSDPgGyRi02zCSH0LL7hIxbmhvGasgTuoWR6J2R5aj5VVYABsjPRBmU8fHH
         idnl7Pu6IROIDlRr6sCvnFrQ6TKNRkfn0cX7NhpZIRc1NLjr2+jEYVmEiIj5iIyUv4/E
         cywXIOUiARf9VsBBpFICexhVFz+a5BzuPQxcl3u3PR9kJLDr+5uSK97hJmZyZg0U5hGW
         CddEdu7Uttzs6dtA+fdC9l8G0ze4gsLtwo0hplitdIDyWYx2gFHuGhJepu1zpClohyl5
         i8dV5Nj6Wel39nyJXqC5pgUtCQfhT2u27CvtalUudspAA67vS78PN7MPt1Hftr+QsyCj
         aARQ==
X-Gm-Message-State: AOAM531STeegYR3fQt/dbOiBJ5+jPfyptFFE28Q1HMQ89Q0lwSwMWcB4
        jVfq7ViKO6JPiJhsA1QKVbDiChbDD8tcI8R0iBENmgGafq6Q
X-Google-Smtp-Source: ABdhPJy9gDQ/dkV++l/KRRJAxkJGXdXcLdeHJuNBVEFVACUkRdhcTN7YCwWftXQkzglwjGrANSNUIt/g0+1iB6jCOGo0sPn0LESo
MIME-Version: 1.0
X-Received: by 2002:a92:bada:: with SMTP id t87mr5533456ill.112.1596818840712;
 Fri, 07 Aug 2020 09:47:20 -0700 (PDT)
Date:   Fri, 07 Aug 2020 09:47:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c57f2d05ac4c5b8e@google.com>
Subject: BUG: corrupted list in kobject_add_internal
From:   syzbot <syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com>
To:     abhishekpandit@chromium.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5a30a789 Merge tag 'x86-urgent-2020-08-02' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1660c858900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=dd768a260f7358adbaf9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b73afc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124893a4900000

The issue was bisected to:

commit 4f40afc6c76451daff7d0dcfc8a3d113ccf65bfc
Author: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed Mar 11 15:54:01 2020 +0000

    Bluetooth: Handle BR/EDR devices during suspend

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11cb1e0a900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13cb1e0a900000
console output: https://syzkaller.appspot.com/x/log.txt?x=15cb1e0a900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd768a260f7358adbaf9@syzkaller.appspotmail.com
Fixes: 4f40afc6c764 ("Bluetooth: Handle BR/EDR devices during suspend")

debugfs: Directory '200' with parent 'hci0' already present!
list_add double add: new=ffff88808e9b6418, prev=ffff88808e9b6418, next=ffff8880a973ef00.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:29!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6882 Comm: kworker/u5:1 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_rx_work
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 57 ff ff ff 4c 89 e1 48 c7 c7 20 92 93 88 e8 b1 f1 c1 fd 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 60 93 93 88 e8 9a f1 c1 fd <0f> 0b 48 89 f1 48 c7 c7 e0 92 93 88 4c 89 e6 e8 86 f1 c1 fd 0f 0b
RSP: 0018:ffffc90001777830 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff8880a973ef00 RCX: 0000000000000000
RDX: ffff888094f1c200 RSI: ffffffff815d4ef7 RDI: fffff520002eeef8
RBP: ffff88808e9b6418 R08: 0000000000000058 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a973ef00
R13: ffff888087315270 R14: ffff88808e9b6430 R15: ffff88808e9b6418
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdcd6db747 CR3: 000000009ba09000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_add include/linux/list.h:67 [inline]
 list_add_tail include/linux/list.h:100 [inline]
 kobj_kset_join lib/kobject.c:196 [inline]
 kobject_add_internal+0x18d/0x940 lib/kobject.c:246
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 device_add+0x35a/0x1be0 drivers/base/core.c:2633
 hci_conn_add_sysfs+0x84/0xe0 net/bluetooth/hci_sysfs.c:53
 hci_conn_complete_evt net/bluetooth/hci_event.c:2607 [inline]
 hci_event_packet+0xe0b/0x86f5 net/bluetooth/hci_event.c:6033
 hci_rx_work+0x22e/0xb10 net/bluetooth/hci_core.c:4705
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Modules linked in:
---[ end trace b1bcc552c32d25e9 ]---
RIP: 0010:__list_add_valid.cold+0x26/0x3c lib/list_debug.c:29
Code: 57 ff ff ff 4c 89 e1 48 c7 c7 20 92 93 88 e8 b1 f1 c1 fd 0f 0b 48 89 f2 4c 89 e1 48 89 ee 48 c7 c7 60 93 93 88 e8 9a f1 c1 fd <0f> 0b 48 89 f1 48 c7 c7 e0 92 93 88 4c 89 e6 e8 86 f1 c1 fd 0f 0b
RSP: 0018:ffffc90001777830 EFLAGS: 00010282
RAX: 0000000000000058 RBX: ffff8880a973ef00 RCX: 0000000000000000
RDX: ffff888094f1c200 RSI: ffffffff815d4ef7 RDI: fffff520002eeef8
RBP: ffff88808e9b6418 R08: 0000000000000058 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a973ef00
R13: ffff888087315270 R14: ffff88808e9b6430 R15: ffff88808e9b6418
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdcd6db747 CR3: 0000000009a79000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

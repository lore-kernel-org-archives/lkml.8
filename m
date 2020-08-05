Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86892C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A5F22D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHERAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:00:25 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:44772 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgHEQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:57:44 -0400
Received: by mail-il1-f198.google.com with SMTP id y82so26271918ilk.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vD/veeEc05bcXlG0e+JSfe9O59TwwwUvH3Hr6H/SIyA=;
        b=DT4ShEHPi6FH6QoYLd3QL9v5ycy4OPhG8zz34atxEDEb98d8T0mS5Q1SDdtQ23O1DX
         jM3R7SJ9PTZPwXe27H+cbdMgDAI+bt4n2eU74g5vIlb4f0mJu+N02Og3kLlDpw/ArJaR
         JJuCQpk0lYgHzMYu7M/BjrEzQGQIYudZLL78O1+6LOi6hxaX2KkRaGgmiAdNY/Y5OZc5
         GbHHhXOqUmdln5OkaGJQ7Fw+L/yLWS+2pAhmkPqh5or9uOZFjKRC7mZVqQl4DYQiwqcW
         YqOaRUXHHZ1hrIsnx6O1gDFkoQTDPDKvUts4dulzYsKfp8wyesntu+V/5EwP4zKqDcts
         WlvQ==
X-Gm-Message-State: AOAM531FE9Yz5A8blOLvGLKmVD1+Mkyc4CEdAZ9VMs9n64DTAMFB1Nj3
        XwRwtlHxR2GiBQWY87FPQtowl9MjMkxuL7KPxafZksfhiGxQ
X-Google-Smtp-Source: ABdhPJyCIyEAmTjH3mqmhkj1F6rTlvWQHvwfZk6hoXyQVk34+x2BOvU/JDLR5tpGpsL3ZeWGnfdbt0fxmuRIfqVtucp3aBL6viaF
MIME-Version: 1.0
X-Received: by 2002:a92:dcc6:: with SMTP id b6mr4591063ilr.147.1596642980561;
 Wed, 05 Aug 2020 08:56:20 -0700 (PDT)
Date:   Wed, 05 Aug 2020 08:56:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b087a705ac2369dd@google.com>
Subject: INFO: trying to register non-static key in l2cap_chan_del
From:   syzbot <syzbot+abfc0f5e668d4099af73@syzkaller.appspotmail.com>
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

HEAD commit:    442489c2 Merge tag 'timers-core-2020-08-04' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15aa9494900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=669b4bedb6478222
dashboard link: https://syzkaller.appspot.com/bug?extid=abfc0f5e668d4099af73
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+abfc0f5e668d4099af73@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0xf9/0x5640 kernel/locking/lockdep.c:4305
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3070
 l2cap_sock_teardown_cb+0x88/0x400 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:824
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 32376067 P4D 32376067 PUD 9356f067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90000e17b60 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88808d94c000 RCX: ffffffff8723aa4f
RDX: 1ffff11005e48c8c RSI: ffffffff8723ac9c RDI: ffff88802f246000
RBP: 0000000000000005 R08: 0000000000000001 R09: ffff88802f246067
R10: 0000000000000009 R11: 0000000000000001 R12: 000000000000006f
R13: ffff88802f246000 R14: 0000000000000000 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000094fa9000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 l2cap_sock_teardown_cb+0x374/0x400 net/bluetooth/l2cap_sock.c:1547
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:824
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Modules linked in:
CR2: 0000000000000000
---[ end trace 661471e896caece1 ]---
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ffffc90000e17b60 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88808d94c000 RCX: ffffffff8723aa4f
RDX: 1ffff11005e48c8c RSI: ffffffff8723ac9c RDI: ffff88802f246000
RBP: 0000000000000005 R08: 0000000000000001 R09: ffff88802f246067
R10: 0000000000000009 R11: 0000000000000001 R12: 000000000000006f
R13: ffff88802f246000 R14: 0000000000000000 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000094fa9000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

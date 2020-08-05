Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57245C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1DC206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHEQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:23:53 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199]:50931 "EHLO
        mail-pl1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHEQWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:22:34 -0400
Received: by mail-pl1-f199.google.com with SMTP id k1so20636356plk.17
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=avna9i89Ds5+HlHIO0jP2gsy42y6k6d4i5A6G0eC9Zg=;
        b=cqiM6zXyb+4Y0idhAMPqo7HcGO4hyqvt7OzGEpFJUh2I6sNqurFnRMyV67iZHMncCv
         +AK+de0vFOcX5K5kL1fgFCEoXkxnQHaFpanozovQSdq8qQ/fgn/BOHzOgraoy+DsYQ/3
         xE3qIXHbEiz2xRuIFuhCH6gyD4QbV+6ooqMxp4njlEoQSH2BILfLpFSltI6BMnqJ2B/d
         GUg0/Py/GhkhWTE1dkII7OSzk8fMg2D5+3c0C9g+WNf9w4ZTX0zeAaes+88ZArcg+1Be
         y1K01rKeStpEzdgpuiOQBqjCyf397o80OgVy5FOD1C9C6610s+Dep5ztcn5hcJy/G9OP
         fjRw==
X-Gm-Message-State: AOAM533uMsdOvKkPch/xZLPQ1GwMQfdB6xw0x6foBlgGbndwW0LLpzto
        iC4+PblzBYm5YE5IH/V2dp4iKIfA12UE7Qu6fEETD3+KIfKl
X-Google-Smtp-Source: ABdhPJyx4yEzfPaYCDRlqOY3SOtYmFn8sbh8/x3+5nlNm2RDYZA9WGMYMn0ZKb0xJk3/Mq74bCnR7H5fZMI1spSxNxHREkmBWCcD
MIME-Version: 1.0
X-Received: by 2002:a05:6602:24c2:: with SMTP id h2mr4088770ioe.198.1596643761947;
 Wed, 05 Aug 2020 09:09:21 -0700 (PDT)
Date:   Wed, 05 Aug 2020 09:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000438c6705ac23983f@google.com>
Subject: BUG: unable to handle kernel paging request in lock_sock_nested
From:   syzbot <syzbot+3ea58ce4ad976e46ca65@syzkaller.appspotmail.com>
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

HEAD commit:    ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=141a4c1a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ea58ce4ad976e46ca65
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ea58ce4ad976e46ca65@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbfff32980d2
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 21ffe5067 P4D 21ffe5067 PUD 21ffe4067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 19427 Comm: kworker/0:15 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:91 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:108 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:134 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:165 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:183 [inline]
RIP: 0010:check_memory_region+0xdb/0x180 mm/kasan/generic.c:192
Code: 80 38 00 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 48 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 <80> 38 00 74 f2 eb d4 41 bc 08 00 00 00 48 89 ea 45 29 dc 4d 8d 1c
RSP: 0018:ffffc90001ed78c0 EFLAGS: 00010082
RAX: fffffbfff32980d2 RBX: fffffbfff32980d3 RCX: ffffffff8159b005
RDX: fffffbfff32980d3 RSI: 0000000000000008 RDI: ffffffff994c0690
RBP: fffffbfff32980d2 R08: 0000000000000000 R09: ffffffff994c0697
R10: fffffbfff32980d2 R11: 0000000000000000 R12: ffff88806a3fc380
R13: ffff88806a3fcd12 R14: 0000000000000000 R15: ffff88806a3fcc50
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff32980d2 CR3: 000000009cb24000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 instrument_atomic_read include/linux/instrumented.h:56 [inline]
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 __lock_acquire+0x1025/0x56e0 kernel/locking/lockdep.c:4350
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:4959
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:358 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3049
 l2cap_sock_teardown_cb+0x88/0x400 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:824
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Modules linked in:
CR2: fffffbfff32980d2
---[ end trace 74995b61ea36495b ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:91 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:108 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:134 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:165 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:183 [inline]
RIP: 0010:check_memory_region+0xdb/0x180 mm/kasan/generic.c:192
Code: 80 38 00 74 f2 48 89 c2 b8 01 00 00 00 48 85 d2 75 56 5b 5d 41 5c c3 48 85 d2 74 5e 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 50 <80> 38 00 74 f2 eb d4 41 bc 08 00 00 00 48 89 ea 45 29 dc 4d 8d 1c
RSP: 0018:ffffc90001ed78c0 EFLAGS: 00010082
RAX: fffffbfff32980d2 RBX: fffffbfff32980d3 RCX: ffffffff8159b005
RDX: fffffbfff32980d3 RSI: 0000000000000008 RDI: ffffffff994c0690
RBP: fffffbfff32980d2 R08: 0000000000000000 R09: ffffffff994c0697
R10: fffffbfff32980d2 R11: 0000000000000000 R12: ffff88806a3fc380
R13: ffff88806a3fcd12 R14: 0000000000000000 R15: ffff88806a3fcc50
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff32980d2 CR3: 000000009cb24000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

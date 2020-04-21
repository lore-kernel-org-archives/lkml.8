Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BFC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423D5206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDUThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:37:14 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34595 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:37:13 -0400
Received: by mail-io1-f70.google.com with SMTP id v12so2643110iol.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MwPEHj4vQxs1Z0E1gm3wXX1VvXcVgbb9DXLJn/e0IlE=;
        b=sl5aY512xn3vBS402cGApWPJEMfig4SKZrBbQ5Ktk1k+/rAVJYMSbEc3LA3s8QwcO/
         sxezY8qXg6Qsr5Lf2aVfrIUuEjG9q3E7qS6cCIEK7k4QrU6SVN0/Z8tWlnXIPGZpcrRz
         Ylj3yNGb4iYqM9dDmRn3yvzV2JATzMblFudSEP+yNgQJAYnxCrua4nXLomIMycWF673b
         E/5PCMdE9ljitgmmMmBV4jsa8vGvmMFNgVaVPs5uhDRl5HSmG9sFTcFQPYBsb9ku+osg
         6KAVhMWYNA8++q+hfMdv0gbmUZ5cGhRhFMiu1oImuXKiPovi2Wgc9EVIuPll/n4otpjl
         JqIQ==
X-Gm-Message-State: AGi0PubdjwXlmoTMPjDUNUkCmwHjBvipgFbwRP7U8/d8liU9EENxEf4Z
        uc4tVezXq6TCcgM5Ajb+j973sC/EK1hoBl/srz9Jv8rH9hqY
X-Google-Smtp-Source: APiQypJTqhSYXeLNxhSTMFXt87JBVwcLhVY0xsE0JWwo0GL7KAaqw/TJmW3enLDMtxsZ2W9zLnBUrzERT3C7wiuoKJ55CgxmxQL0
MIME-Version: 1.0
X-Received: by 2002:a02:7611:: with SMTP id z17mr21898566jab.42.1587497832829;
 Tue, 21 Apr 2020 12:37:12 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:37:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068568305a3d2242e@google.com>
Subject: general protection fault in wait_consider_task
From:   syzbot <syzbot+c3b604da907fb0eb2466@syzkaller.appspotmail.com>
To:     christian@brauner.io, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7a56db02 Merge tag 'nfs-for-5.7-3' of git://git.linux-nfs...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122bb0bbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11f10cc27c63cade
dashboard link: https://syzkaller.appspot.com/bug?extid=c3b604da907fb0eb2466
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c3b604da907fb0eb2466@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc00000000e4: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000720-0x0000000000000727]
CPU: 0 PID: 7171 Comm: syz-executor.1 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:same_thread_group include/linux/sched/signal.h:671 [inline]
RIP: 0010:ptrace_reparented include/linux/ptrace.h:99 [inline]
RIP: 0010:wait_consider_task+0x2069/0x2ec0 kernel/exit.c:1291
Code: 04 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 88 9f 6a 00 48 8b 1b 48 81 c5 20 07 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 68 9f 6a 00 48 8b 6d 00 48 81 c3
RSP: 0018:ffffc90002537b98 EFLAGS: 00010206
RAX: 00000000000000e4 RBX: 0000000000000000 RCX: ffff888083f30180
RDX: 0000000000000000 RSI: 0000000000000707 RDI: ffff88800010e4e8
RBP: 0000000000000720 R08: ffffffff814682c3 R09: ffffffff8146810c
R10: ffff888083f30180 R11: 0000000000000002 R12: ffffc90002537dc8
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00000000027e8940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000071a138 CR3: 0000000083edc000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_wait_thread kernel/exit.c:1368 [inline]
 do_wait+0x2c1/0x6a0 kernel/exit.c:1439
 kernel_wait4+0x1d1/0x2c0 kernel/exit.c:1611
 __do_sys_wait4 kernel/exit.c:1623 [inline]
 __se_sys_wait4 kernel/exit.c:1619 [inline]
 __x64_sys_wait4+0xc3/0x150 kernel/exit.c:1619
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4166ca
Code: 0f 83 6a 18 00 00 c3 66 0f 1f 84 00 00 00 00 00 8b 05 ce 1d 87 00 85 c0 75 36 45 31 d2 48 63 d2 48 63 ff b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 d4 ff ff ff f7
RSP: 002b:00007ffd29b96bc8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 000000000007c311 RCX: 00000000004166ca
RDX: 0000000040000001 RSI: 00007ffd29b96c00 RDI: ffffffffffffffff
RBP: 0000000000000b96 R08: 0000000000000001 R09: 00000000027e8940
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000d
R13: 00007ffd29b96c00 R14: 000000000007c284 R15: 00007ffd29b96c10
Modules linked in:
---[ end trace 319c15280f37aacf ]---
RIP: 0010:same_thread_group include/linux/sched/signal.h:671 [inline]
RIP: 0010:ptrace_reparented include/linux/ptrace.h:99 [inline]
RIP: 0010:wait_consider_task+0x2069/0x2ec0 kernel/exit.c:1291
Code: 04 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 88 9f 6a 00 48 8b 1b 48 81 c5 20 07 00 00 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 68 9f 6a 00 48 8b 6d 00 48 81 c3
RSP: 0018:ffffc90002537b98 EFLAGS: 00010206
RAX: 00000000000000e4 RBX: 0000000000000000 RCX: ffff888083f30180
RDX: 0000000000000000 RSI: 0000000000000707 RDI: ffff88800010e4e8
RBP: 0000000000000720 R08: ffffffff814682c3 R09: ffffffff8146810c
R10: ffff888083f30180 R11: 0000000000000002 R12: ffffc90002537dc8
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  00000000027e8940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000071a138 CR3: 0000000083edc000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

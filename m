Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7037AC38A2B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FBD221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 06:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDRGoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 02:44:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:33536 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgDRGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 02:44:15 -0400
Received: by mail-il1-f199.google.com with SMTP id l18so4813671ilg.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ju0UyNHzm8Bxnt/XyLuQ0hyMzA9hpJAW3BaCNcJ4ArM=;
        b=pQR/80IrPtS8WZs3AKInDeOy1gNpZ7Nk4eGW4iLW/wBTju6TIOuguGwWLDe45E6umd
         n74+1X3+hkhOwVV5VVxrd35U7/lQGJ8Oz/CM1JyDxpCDm+1wLPlWAI/CUvqSXpIoVOR9
         mlJZJKnSlGktgLVWvtzmrjrKDpUPQFh3VygMafyESjwfALb9DzF3jRdsfkmaU/igtKkR
         5XAzpU/N6DVuIXKqJO+/BwprZjnc2hLlkHr+wLk/j/tdicRMUfCJrS30CYDpWuN0i+dP
         C0Km/SO0v553FKnvpoSgtvhGPZU5ZKexB5+JD4gEeGwA2Nqmf2Bq5CXY4/Kg4Ok1YpqL
         y8Gw==
X-Gm-Message-State: AGi0PuY0731R1aQqnWlus+U7Qao60SFjeegHU1Au9jITssjhypelkn6o
        4Bi7LxcCtK256pjw7Ah5ShKB0jni0ynwytUweHOYlMB1vQJ5
X-Google-Smtp-Source: APiQypKLjqiahVpx7Ssk+DzJg3tnzwqCO8ZGkJ4yIyyU8M19id4dsEYzaiAe+mpnwnxq7/wezasK2+7SZ5P5R+GnoF4bJ34PHCSK
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e03:: with SMTP id a3mr387477ilk.239.1587192254704;
 Fri, 17 Apr 2020 23:44:14 -0700 (PDT)
Date:   Fri, 17 Apr 2020 23:44:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008832a805a38afe44@google.com>
Subject: general protection fault in mm_update_next_owner (2)
From:   syzbot <syzbot+a0f91e07da410c63b9c3@syzkaller.appspotmail.com>
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

HEAD commit:    8f3d9f35 Linux 5.7-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119a1c07e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
dashboard link: https://syzkaller.appspot.com/bug?extid=a0f91e07da410c63b9c3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a0f91e07da410c63b9c3@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xf1918d9191919193: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x8c8c8c8c8c8c8c98-0x8c8c8c8c8c8c8c9f]
CPU: 0 PID: 933 Comm: syz-executor.0 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:mm_update_next_owner+0x49b/0x7a0 kernel/exit.c:385
Code: 48 8d bd 48 03 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 f4 02 00 00 48 8b ad 48 03 00 00 4c 8d 7d 10 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 cb 02 00 00 48 8b 45 10 48 8d a8 68 fa ff ff 49
RSP: 0018:ffffc90018517d20 EFLAGS: 00010a07
RAX: 1191919191919193 RBX: dffffc0000000000 RCX: ffffffff81459ed3
RDX: 0000000000000000 RSI: ffffffff81459ee1 RDI: ffff88800013e8e0
RBP: 8c8c8c8c8c8c8c8c R08: ffff8882123f0580 R09: fffffbfff1301219
R10: ffffffff898090c3 R11: fffffbfff1301218 R12: ffff88809552f800
R13: ffff88800013e1c0 R14: 0000000000000000 R15: 8c8c8c8c8c8c8c9c
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 000000020b913000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 exit_mm kernel/exit.c:478 [inline]
 do_exit+0xa49/0x2dd0 kernel/exit.c:782
 do_group_exit+0x125/0x340 kernel/exit.c:893
 __do_sys_exit_group kernel/exit.c:904 [inline]
 __se_sys_exit_group kernel/exit.c:902 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:902
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd4c670f58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 000000000045c889
RDX: 0000000000416421 RSI: fffffffffffffff7 RDI: 0000000000000000
RBP: 0000000000000000 R08: 01ffffffffffffff R09: 00007ffd4c670fb0
R10: 00000000007702b0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd4c670fb0 R14: 0000000000000000 R15: 00007ffd4c670fc0
Modules linked in:
---[ end trace 30f7c81df55d5d82 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:mm_update_next_owner+0x49b/0x7a0 kernel/exit.c:385
Code: 48 8d bd 48 03 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 f4 02 00 00 48 8b ad 48 03 00 00 4c 8d 7d 10 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 cb 02 00 00 48 8b 45 10 48 8d a8 68 fa ff ff 49
RSP: 0018:ffffc90018517d20 EFLAGS: 00010a07
RAX: 1191919191919193 RBX: dffffc0000000000 RCX: ffffffff81459ed3
RDX: 0000000000000000 RSI: ffffffff81459ee1 RDI: ffff88800013e8e0
RBP: 8c8c8c8c8c8c8c8c R08: ffff8882123f0580 R09: fffffbfff1301219
R10: ffffffff898090c3 R11: fffffbfff1301218 R12: ffff88809552f800
R13: ffff88800013e1c0 R14: 0000000000000000 R15: 8c8c8c8c8c8c8c9c
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 000000020b913000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

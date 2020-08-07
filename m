Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466142086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHGVQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:16:26 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39693 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGVQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:16:25 -0400
Received: by mail-io1-f70.google.com with SMTP id v10so2561876iot.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=V/ye5q3zVEuEmk6UgKiiIHke6oMmhX9ZWEGicRQ0Rto=;
        b=t8gE9QLIZ1nt4KMrLc8PefBLqqpL1LwYx6sajfqC9/4NKYIwtzP56+TSktzaEjSCHG
         fOZfwHyG9im3HXZ7FBQv0TWzhBNla34wWsOvbxw50u4q+2QbwsN3lu45mGv534G/fERH
         FNT6eaJpcFbf0maPrE+YRfJqYJ9EFdFbCOfRLku7FePYE87GkqEOaGlb/Y1WHbwg1UvH
         YI77m47G1H8BiaOucRk1CfC7ke+In+w38FWpCBC0YSInlyNQs1x5u0B+8sb1+Kl2Mxc6
         rAhGCpUtwsWmwMziHDKKBGHfIJsD9w6b6tzUq7UpqLoIHhdGXPHmoxxaXNDuthqFtBvO
         FOaw==
X-Gm-Message-State: AOAM531S9XVsjPNNLqphLhCuzhZHeKxKYng1ikue+NgwqEe32FNFmLJN
        48wcv6F9rYLhHIhFfQZBFhjBH6ER0sl0CMPYAUzZbRCnQj9m
X-Google-Smtp-Source: ABdhPJw4romYBK1Z+dvO46jBp8soCsB3ThWVIPk1PwYP4o+yLiyarrCr/PxiuMUi9FWDd2MSbKJ9KS6kozKB86Nq6uPjNsNhPxMc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1611:: with SMTP id x17mr6741244jas.99.1596834984654;
 Fri, 07 Aug 2020 14:16:24 -0700 (PDT)
Date:   Fri, 07 Aug 2020 14:16:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000067ab705ac501e5f@google.com>
Subject: kernel BUG at kernel/fork.c:LINE!
From:   syzbot <syzbot+3776ecd80aac504e6085@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        christian@kellner.me, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1194d90a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18bb86f2e4ebfda2
dashboard link: https://syzkaller.appspot.com/bug?extid=3776ecd80aac504e6085
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3776ecd80aac504e6085@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at kernel/fork.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5239 Comm: syz-executor.1 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:account_kernel_stack+0x297/0x320 kernel/fork.c:390
Code: 89 e2 be 23 00 00 00 48 89 ef c1 e2 05 e8 81 9e 75 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 ae c9 2f 00 e8 a9 c9 2f 00 <0f> 0b e8 f2 50 6f 00 e9 d2 fd ff ff e8 98 c9 2f 00 48 c7 c6 20 24
RSP: 0018:ffffc90015e4f850 EFLAGS: 00010216
RAX: 00000000000001f4 RBX: 0000000000000000 RCX: ffffc90017983000
RDX: 0000000000040000 RSI: ffffffff81445327 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880a2ef9663
R10: 0000000000000008 R11: 0000000000000000 R12: ffffffffffffffff
R13: ffff8880001b2280 R14: ffff88809e4fa840 R15: 0000000000000000
FS:  00007f7f035e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fd30000 CR3: 000000009b747000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 release_task_stack kernel/fork.c:447 [inline]
 put_task_stack+0xc4/0x230 kernel/fork.c:459
 finish_task_switch+0x52a/0x750 kernel/sched/core.c:3649
 context_switch kernel/sched/core.c:3781 [inline]
 __schedule+0x8ed/0x21e0 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 freezable_schedule include/linux/freezer.h:172 [inline]
 futex_wait_queue_me+0x2a7/0x570 kernel/futex.c:2588
 futex_wait+0x1df/0x560 kernel/futex.c:2690
 do_futex+0x15b/0x1a60 kernel/futex.c:3749
 __do_sys_futex kernel/futex.c:3810 [inline]
 __se_sys_futex kernel/futex.c:3778 [inline]
 __x64_sys_futex+0x378/0x4e0 kernel/futex.c:3778
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45ccd9
Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7f035e4cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000000078bfa8 RCX: 000000000045ccd9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000078bfa8
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bfac
R13: 00007fff896cb67f R14: 00007f7f035e59c0 R15: 000000000078bfac
Modules linked in:
---[ end trace ff14b6c5822b8142 ]---
RIP: 0010:account_kernel_stack+0x297/0x320 kernel/fork.c:390
Code: 89 e2 be 23 00 00 00 48 89 ef c1 e2 05 e8 81 9e 75 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 ae c9 2f 00 e8 a9 c9 2f 00 <0f> 0b e8 f2 50 6f 00 e9 d2 fd ff ff e8 98 c9 2f 00 48 c7 c6 20 24
RSP: 0018:ffffc90015e4f850 EFLAGS: 00010216
RAX: 00000000000001f4 RBX: 0000000000000000 RCX: ffffc90017983000
RDX: 0000000000040000 RSI: ffffffff81445327 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880a2ef9663
R10: 0000000000000008 R11: 0000000000000000 R12: ffffffffffffffff
R13: ffff8880001b2280 R14: ffff88809e4fa840 R15: 0000000000000000
FS:  00007f7f035e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fd30000 CR3: 000000009b747000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

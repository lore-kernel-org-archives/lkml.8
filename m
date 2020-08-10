Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C36DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617BC23136
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgHJPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:37:25 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39759 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgHJPhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:37:19 -0400
Received: by mail-il1-f200.google.com with SMTP id i66so8131957ile.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vgKXH4WJ5mL8jBHkC4QRYXqac1PdnedowUxx7rlEsuM=;
        b=BdTAcyAO2sMSO9NX6lGEO9+xq6O1OXo2QvIEhs24TX6tCBiH2MtWRZfYrs3oVVBCtu
         XFiHXaj6yqIUTnUpstXq7z3JfCsZsW48US/VDIsU0dRiTjFJd8UYGhfbapqM8OEC/V52
         OG3o4LFFpvQDFbciz50LUSZVxHeGk4pvHLAIt9/zu7E7kV4hX0W0zNZySstFB9/Z4p/Y
         Jhpxcgaax3wtkTpkvmzbhLj5DZ/co75uDEbtFqgUxQHuWz9Mk3J05EVGqQpf5h78dLPV
         fvxQDWofXWaKF78ellsHuYqKaz7LHrQ1DRNLDjXz8EjYjMOxjTzN5oziCujDQ7jfpdWB
         sXcQ==
X-Gm-Message-State: AOAM5306lRyBT581RjR36PT/WTCURT7S6IfPCAUMrTtYKSXqyyD8+im0
        c9CI94e2Fv+Urb2ISi7uT2KMfvF65mOMLf3ROoob9JZih2Is
X-Google-Smtp-Source: ABdhPJwD0PYJDlH/aA+YionM4F0yS0UeZ+HmBNJlwl9iWQ+7lRzbMHmYr6o24OoWR3/2wrpeUcHk4LmvarRQkZICd8vhhm4wa+T7
MIME-Version: 1.0
X-Received: by 2002:a92:c7ae:: with SMTP id f14mr19137037ilk.39.1597073838340;
 Mon, 10 Aug 2020 08:37:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:37:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d07f9605ac87ba9e@google.com>
Subject: possible deadlock in io_queue_linked_timeout
From:   syzbot <syzbot+d4586d3028284ff8a0be@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    06a81c1c Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fbac1c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf68a13f867fd1b4
dashboard link: https://syzkaller.appspot.com/bug?extid=d4586d3028284ff8a0be
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1362024e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1672fd34900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4586d3028284ff8a0be@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.8.0-syzkaller #0 Not tainted
--------------------------------------------
syz-executor880/6847 is trying to acquire lock:
ffff8880a19214d8 (&ctx->completion_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
ffff8880a19214d8 (&ctx->completion_lock){....}-{2:2}, at: io_queue_linked_timeout+0x4c/0x200 fs/io_uring.c:5928

but task is already holding lock:
ffff8880a19214d8 (&ctx->completion_lock){....}-{2:2}, at: io_cqring_overflow_flush+0x814/0xaa0 fs/io_uring.c:1333

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ctx->completion_lock);
  lock(&ctx->completion_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor880/6847:
 #0: ffff8880a19214d8 (&ctx->completion_lock){....}-{2:2}, at: io_cqring_overflow_flush+0x814/0xaa0 fs/io_uring.c:1333

stack backtrace:
CPU: 1 PID: 6847 Comm: syz-executor880 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_deadlock_bug kernel/locking/lockdep.c:2391 [inline]
 check_deadlock kernel/locking/lockdep.c:2432 [inline]
 validate_chain kernel/locking/lockdep.c:3202 [inline]
 __lock_acquire.cold+0x115/0x396 kernel/locking/lockdep.c:4426
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x5b/0x80 kernel/locking/spinlock.c:167
 spin_lock_irq include/linux/spinlock.h:379 [inline]
 io_queue_linked_timeout+0x4c/0x200 fs/io_uring.c:5928
 __io_queue_async_work+0x1f8/0x4c0 fs/io_uring.c:1192
 __io_queue_deferred fs/io_uring.c:1237 [inline]
 io_commit_cqring+0x456/0x7a0 fs/io_uring.c:1265
 io_cqring_overflow_flush+0x5b8/0xaa0 fs/io_uring.c:1359
 io_ring_ctx_wait_and_kill+0x30e/0x600 fs/io_uring.c:7808
 io_uring_release+0x3e/0x50 fs/io_uring.c:7829
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb7d/0x29f0 kernel/exit.c:806
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43f598
Code: Bad RIP value.
RSP: 002b:00007ffd3a4fbaa8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043f598
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004beda8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d11a0 R14: 0000000000000000 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

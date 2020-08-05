Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F607C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE5321744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgHEHTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:19:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:53946 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgHEHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:19:17 -0400
Received: by mail-il1-f198.google.com with SMTP id v13so19251219ila.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wF3UY0YQWKMbkrNh/DziM3pU9MCBg/u9elqEKmJT0tg=;
        b=QihjfhsoXhPNe9R6htb0fysw9zeZX8IdWx2DTbIVQXOBBnsN2V9+FrbDXgo/awftWW
         kheKVR7ZIsqKymvfEbwZj6sFdnu3dgEMt+kk0bOQqluUI64lzMM+IDv8pFhx3r5BmWtt
         2BQiumgp6CS/weojNEfDQi2kH4VWngC40iih6epP8Wu7utDhx/WnmoML7p+35KcBq3Ey
         7oOy1hEnVJqJU84m3G52tppxb7BbBThUKFoBS6u4Hww7LVkt11SrDMnufZiWVDmurwEN
         7dwdw8zwJDWIGeiDqc8g2im2o3Ved7JdEN8nvHx0rSoh9OgJuhCaCXen+fokwdo3GxHQ
         nikw==
X-Gm-Message-State: AOAM531+g6FJrsPQukuwQ4nx5D4ZN0iHcVBVyyrebYJFsPvczxuHYqCx
        nBVlIy34ebrDGMp5rZL8sP1eF35Hhds/DtZwyvI+2FfQxYmT
X-Google-Smtp-Source: ABdhPJzcZtJo9iP2ruSsjoMxVlQE/kRlZlzvnkbNCGgqkQFpiuu9yQGgpcbUoVTeN1qiqOp/80SkZTkEx5lIUK14grEjs+v24pCe
MIME-Version: 1.0
X-Received: by 2002:a6b:7610:: with SMTP id g16mr1991011iom.115.1596611956346;
 Wed, 05 Aug 2020 00:19:16 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080940e05ac1c301e@google.com>
Subject: upstream test error: WARNING in do_epoll_wait
From:   syzbot <syzbot+4429670d8213f5f26352@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4f30a60a Merge tag 'close-range-v5.9' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c5a7da900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bdd9944dedf0f16
dashboard link: https://syzkaller.appspot.com/bug?extid=4429670d8213f5f26352
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4429670d8213f5f26352@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8728 at fs/eventpoll.c:1828 ep_poll fs/eventpoll.c:1828 [inline]
WARNING: CPU: 1 PID: 8728 at fs/eventpoll.c:1828 do_epoll_wait+0x337/0x920 fs/eventpoll.c:2333
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8728 Comm: syz-fuzzer Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x16e/0x25d lib/dump_stack.c:118
 panic+0x20c/0x69a kernel/panic.c:231
 __warn+0x211/0x240 kernel/panic.c:600
 report_bug+0x153/0x1d0 lib/bug.c:198
 handle_bug+0x4d/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x70 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:547
RIP: 0010:ep_poll fs/eventpoll.c:1828 [inline]
RIP: 0010:do_epoll_wait+0x337/0x920 fs/eventpoll.c:2333
Code: 41 be 01 00 00 00 31 c0 48 89 44 24 20 45 31 e4 e9 7f 01 00 00 e8 59 ab c6 ff 41 bc f2 ff ff ff e9 c8 03 00 00 e8 49 ab c6 ff <0f> 0b e9 58 fe ff ff 49 bf ff ff ff ff ff ff ff 7f e9 f0 fe ff ff
RSP: 0018:ffffc90000e1fe28 EFLAGS: 00010293
RAX: ffffffff81856297 RBX: ffff888120fafa00 RCX: ffff88811e196400
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff818560d8 R09: 0000ffff88619eb7
R10: 0000ffffffffffff R11: 0000000000000000 R12: 00007ffffffff000
R13: 0000000000000080 R14: 0000000000000001 R15: 0000000000000003
 __do_sys_epoll_pwait fs/eventpoll.c:2364 [inline]
 __se_sys_epoll_pwait fs/eventpoll.c:2350 [inline]
 __x64_sys_epoll_pwait+0x92/0x150 fs/eventpoll.c:2350
 do_syscall_64+0x6a/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x469240
Code: 0f 05 89 44 24 20 c3 cc cc cc 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 44 8b 54 24 1c 49 c7 c0 00 00 00 00 b8 19 01 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc cc cc cc cc cc cc cc 8b 7c 24 08 48 c7
RSP: 002b:000000c00004b7f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000119
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000469240
RDX: 0000000000000080 RSI: 000000c00004b840 RDI: 0000000000000003
RBP: 000000c00004be40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000003
R13: 000000c00009cc00 R14: 000000c00032c180 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D14C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AEE20675
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgC1TeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:34:16 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40178 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1TeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:34:15 -0400
Received: by mail-io1-f71.google.com with SMTP id z207so12043947iof.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 12:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4Os1MQqVuaKZJ0/BSQ1InJnVUdjOicbnDIstLCvCWnA=;
        b=CdOwQfLWuKfufCWhmAbKdZmVcut5NkUixZeWkUusFlS6xeBbB9Yx1X0I7zuMowa6GJ
         zpG91Uk9kZYh9knNKDCi+Blsuf7P6xjjDJ4CGG72z1df6pkBRHgxSmzf5idLYoyIvGTR
         QpWIQFQXkaYov0fTINIvaD/kNrIoGDqzps8HRAr16olv1mMSOpnXKeS99rs0C+dhR0Ip
         DCUdhGft0SqjSU7G/jmsS5lquREH7YZtPFZ2REKhEsmArJ6rqn+u+4CEFLBRkM3ZVwpm
         /JU0om68MmxSiHcY5CNhsXHB4S3xy+ZNp9xEMK1H30VB+iVqNIK2xyLraYOwpF7hgBob
         FACw==
X-Gm-Message-State: ANhLgQ3bEqkt3TcFTotBA8speV3ZSYuS5Z/ENYPOnLD/Vm3RQXw5V4Cv
        Fdt6TOV6Sv5oXfZBXaMtRk9HsJGXdMWWFBZkwM1L4vukaU19
X-Google-Smtp-Source: ADFU+vsIsXLgbI69/vNR4Nu3B0uA4LMKFeIF5T4v0xmTaXDHRSy8yoAiq7xfpRPEKXf3x7pwt46Yp4d0bgC7qJg34w3kqDkFY6/n
MIME-Version: 1.0
X-Received: by 2002:a92:cad2:: with SMTP id m18mr4909534ilq.8.1585424054487;
 Sat, 28 Mar 2020 12:34:14 -0700 (PDT)
Date:   Sat, 28 Mar 2020 12:34:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000960ee605a1ef4d4e@google.com>
Subject: general protection fault in do_syscall_64
From:   syzbot <syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69c5eea3 Merge branch 'parisc-5.6-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d3517be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ac76c43beddbd9
dashboard link: https://syzkaller.appspot.com/bug?extid=f9b2c53f55a9270fc778
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15059d05e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e5d5a3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f9b2c53f55a9270fc778@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0x1ffffffff1215a85: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7207 Comm: syz-executor045 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:do_syscall_64+0x5f/0x1b0 arch/x86/entry/common.c:289
Code: 48 c7 c7 28 d4 0a 89 e8 bf 5d b0 00 48 83 3d af 5b 0a 08 00 0f 84 58 01 00 00 fb 66 0f 1f 44 00 00 65 48 8b 1c 25 c0 1d 02 00 <48> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001617f28 EFLAGS: 00010282
RAX: 1ffffffff1215a85 RBX: ffff888095530380 RCX: ffff888095530380
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888095530bc4
RBP: 0000000000000000 R08: ffffffff817a2210 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
R13: dffffc0000000000 R14: ffffc90001617f58 R15: 0000000000000000
FS:  0000000001333880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87bf9aae78 CR3: 00000000a6a3f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4454e1
Code: 75 14 b8 23 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 64 1f fc ff c3 48 83 ec 08 e8 9a 42 00 00 48 89 04 24 b8 23 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 e3 42 00 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffd72d164b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000023
RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00000000004454e1
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd72d164c0
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffd72d164e0 R11: 0000000000000293 R12: 0000000000000000
R13: 00000000006dbc2c R14: 000000000000000a R15: 0000000000000000
Modules linked in:
---[ end trace 3da67f82bf6bae14 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:do_syscall_64+0x5f/0x1b0 arch/x86/entry/common.c:289
Code: 48 c7 c7 28 d4 0a 89 e8 bf 5d b0 00 48 83 3d af 5b 0a 08 00 0f 84 58 01 00 00 fb 66 0f 1f 44 00 00 65 48 8b 1c 25 c0 1d 02 00 <48> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001617f28 EFLAGS: 00010282
RAX: 1ffffffff1215a85 RBX: ffff888095530380 RCX: ffff888095530380
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff888095530bc4
RBP: 0000000000000000 R08: ffffffff817a2210 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000023
R13: dffffc0000000000 R14: ffffc90001617f58 R15: 0000000000000000
FS:  0000000001333880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87bf9aae78 CR3: 00000000a6a3f000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

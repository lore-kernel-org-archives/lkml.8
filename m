Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64DBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0E820870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 13:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgCDNFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:05:13 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:52747 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgCDNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:05:13 -0500
Received: by mail-il1-f197.google.com with SMTP id d2so1330974ilf.19
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 05:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Czz7rgum7/L7+4HMs+7TnQ38o1eJc5E8CEn7vJGv6Vs=;
        b=lnN1S200TH8UI20kPiS4QMzJMAOvKei9dVmc9KJoaVm47loRA+sM0WHkMFOShnT209
         JnQyY02CyitukSXNcTX4QQlMnDb8MRiyN9YNEeGDM4tSYmZsmfz8rHqN7sNwnKmxQkYK
         HslFO4qODdMTtszmGywozG+nuHhkMpeSTTShUfRB3FvDHCZCkShKFdi8mWFQfIry8OE0
         sxzHGnq2EobfVbyhlv8xQ1/brfiBourUURhdSjKas5X2Gww4DSQbux0Q+bkSRK2Pl7Yg
         dPoAU5CPKcY9wb1n+lhb1lpIh8xGwTY3RfHk7xt5Nm/5EmzYz6LPdgmKCQ5xqmssRyZp
         UTjw==
X-Gm-Message-State: ANhLgQ11QMkzlyiGAjrJ4M/D0vOk6fMycnuV6eYcR5ZbNF+4zQPNS/za
        NA4CDCOg+Tr44DEs5cRR6/dSzbO0/g68n4R1Us66kScle8iL
X-Google-Smtp-Source: ADFU+vu1NPRP/5ciJYIv3k8/c9GsV9hKRSP0DJON+1fkuNyPCMjgPXFsBOyeaDit6IfVKBAWiEJQKV6eXl7BsEl3Lw5EHGlgE7WI
MIME-Version: 1.0
X-Received: by 2002:a02:90d0:: with SMTP id c16mr2663415jag.22.1583327112844;
 Wed, 04 Mar 2020 05:05:12 -0800 (PST)
Date:   Wed, 04 Mar 2020 05:05:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fdbd605a00712b1@google.com>
Subject: WARNING: locking bug in finish_lock_switch
From:   syzbot <syzbot+91e3de3393c461e632ee@syzkaller.appspotmail.com>
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

syzbot found the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cc8331e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=91e3de3393c461e632ee
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158b72c3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+91e3de3393c461e632ee@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 10050 at kernel/locking/lockdep.c:167 hlock_class kernel/locking/lockdep.c:167 [inline]
WARNING: CPU: 1 PID: 10050 at kernel/locking/lockdep.c:167 __lock_acquire+0x18b8/0x1bc0 kernel/locking/lockdep.c:3950
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 10050 Comm: syz-executor.0 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 panic+0x264/0x7a9 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1b6/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 do_error_trap+0xcf/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
RIP: 0010:__lock_acquire+0x18b8/0x1bc0 kernel/locking/lockdep.c:3950
Code: 08 00 0f 85 f5 f0 ff ff 45 31 f6 48 c7 c7 bd aa e3 88 48 c7 c6 76 6b e8 88 31 c0 e8 72 e8 ec ff 48 bf 00 00 00 00 00 fc ff df <0f> 0b e9 a4 f2 ff ff 45 31 f6 e9 92 f2 ff ff 48 c7 c1 c4 ea 69 89
RSP: 0018:ffffc900052a77b0 EFLAGS: 00010046
RAX: 6d156fc8d8732800 RBX: 00000000000008fb RCX: ffff88808d76c240
RDX: 0000000040000000 RSI: 0000000000000001 RDI: dffffc0000000000
RBP: ffffc900052a7910 R08: ffffffff817cb4ba R09: fffffbfff125af8f
R10: fffffbfff125af8f R11: 0000000000000000 R12: 3476ca37373763a9
R13: ffff88808d76cad0 R14: 0000000000000000 R15: ffff88808d76c240
 lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
 finish_lock_switch+0x25/0x40 kernel/sched/core.c:3118
 finish_task_switch+0x24f/0x550 kernel/sched/core.c:3219
 context_switch kernel/sched/core.c:3383 [inline]
 __schedule+0x887/0xcd0 kernel/sched/core.c:4080
 preempt_schedule_irq+0xca/0x150 kernel/sched/core.c:4337
 retint_kernel+0x1b/0x2b
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752 [inline]
RIP: 0010:lock_acquire+0x1ae/0x250 kernel/locking/lockdep.c:4487
Code: c1 e8 03 42 80 3c 30 00 74 0c 48 c7 c7 10 d3 2a 89 e8 56 67 58 00 48 83 3d 6e 07 cf 07 00 0f 84 9c 00 00 00 48 8b 7d c0 57 9d <0f> 1f 44 00 00 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d c3 44 89
RSP: 0018:ffffc900052a7ba8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff1255a62 RBX: 0000000000000000 RCX: ffffffff815cb150
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 0000000000000282
RBP: ffffc900052a7c00 R08: dffffc0000000000 R09: fffffbfff1384111
R10: fffffbfff1384111 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8880a3fd1928
 flush_workqueue+0x10a/0x1820 kernel/workqueue.c:2775
 hci_dev_open+0x21d/0x2e0 net/bluetooth/hci_core.c:1626
 hci_sock_bind+0x1620/0x1b10 net/bluetooth/hci_sock.c:1200
 __sys_bind+0x2bd/0x3a0 net/socket.c:1662
 __do_sys_bind net/socket.c:1673 [inline]
 __se_sys_bind net/socket.c:1671 [inline]
 __x64_sys_bind+0x7a/0x90 net/socket.c:1671
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f46d8bebc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00007f46d8bec6d4 RCX: 000000000045c449
RDX: 0000000000000006 RSI: 00000000200007c0 RDI: 0000000000000005
RBP: 000000000076c060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000002c R14: 00000000004c28c9 R15: 000000000076c06c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

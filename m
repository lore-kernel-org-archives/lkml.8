Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09AEC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 07:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA952073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 07:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgGSHmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 03:42:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:51630 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSHmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 03:42:22 -0400
Received: by mail-il1-f197.google.com with SMTP id s137so8611926ilc.18
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 00:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UPZBBjL/vPO2IAd7aTimT2AvqSPX5PH8pbVdUR9j7L8=;
        b=enUQB2yjrzQY0gWhRNnfZ64DXxxdlTl0kYbHe5mCsrkGBesPXZLthKi9lxng1LQxO2
         bmYKTT75Q2IxrQxMbPFKGZPcMNd9t0u2m4w1FSXpyt774KlVZehnCj1WH2yX3dDGidsW
         7/TaeQXde8D4NGTUnKyF9d5gfcIY4ztIDqfojni3U/D+e9B7TJBRKK6LlQT2zGCfcytB
         LfXrzL5T6JfPUo34LeWUDng9lQFwM5btwfd/6350XXtonEi+cvlg5n2DVQRkP57B0slZ
         d8e3/7jDt2l+x+F8UvXq0BAlSK/nJ+xjM5x3UAUvIsqiICm0qBKfqofxdJ0YGmRl/HZX
         4sbQ==
X-Gm-Message-State: AOAM5301KY/PZnWxIl2O7W1dyutd/vVBlQ9G00MmLsmHpqU+QlHy0S8H
        20ftUDsyBK+Gg10HirTaM4elGklrT7DEB4VFhPadJNMdRCzs
X-Google-Smtp-Source: ABdhPJwbRLbebPKUoZYkIM22frFcduiUI8UQsa0J9jOpJzT8ZhO9iWPFzHxYIZGMi9Xycm2FKtZhY0B07RCVFLnB4n+boNrTU/el
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138f:: with SMTP id d15mr16385178ilo.63.1595144541128;
 Sun, 19 Jul 2020 00:42:21 -0700 (PDT)
Date:   Sun, 19 Jul 2020 00:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd4f7305aac6870d@google.com>
Subject: WARNING in do_syscall_64
From:   syzbot <syzbot+29454675f5fe94137999@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dca4cf100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e944500a36bc4d55
dashboard link: https://syzkaller.appspot.com/bug?extid=29454675f5fe94137999
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29454675f5fe94137999@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!irqs_disabled())
WARNING: CPU: 0 PID: 7015 at kernel/locking/lockdep.c:3745 lockdep_hardirqs_off+0x8f/0xa0 kernel/locking/lockdep.c:3745
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7015 Comm: syz-executor.2 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:542
RIP: 0010:lockdep_hardirqs_off+0x8f/0xa0 kernel/locking/lockdep.c:3745
Code: 41 5e c3 e8 c3 07 00 00 85 c0 74 f3 83 3d ac e1 6f 01 00 75 ea 48 c7 c7 26 0a 07 89 48 c7 c6 46 9a 08 89 31 c0 e8 e1 c3 28 f9 <0f> 0b eb d1 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 41 57 41 56
RSP: 0018:ffffc90004957f20 EFLAGS: 00010246
RAX: 516cfadac3d71d00 RBX: ffff8880611fe500 RCX: ffff8880611fe500
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: 0000000000000000 R08: ffffffff817a2fd0 R09: fffffbfff129cee5
R10: fffffbfff129cee5 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff88400078 R15: ffffc90004957f58
 enter_from_user_mode arch/x86/entry/common.c:100 [inline]
 do_syscall_64+0x18/0xe0 arch/x86/entry/common.c:374
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45f9ea
Code: Bad RIP value.
RSP: 002b:00007ffd3fa384e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 000000000002d52f RCX: 000000000045f9ea
RDX: 0000000000000000 RSI: 00007ffd3fa384f0 RDI: 0000000000000001
RBP: 00000000000000c9 R08: 0000000000000001 R09: 0000000002ca9940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000009
R13: 00007ffd3fa38550 R14: 000000000002d505 R15: 00007ffd3fa38560
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA24C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 05:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DB32070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 05:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgCGFhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 00:37:12 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:40170 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGFhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 00:37:12 -0500
Received: by mail-io1-f71.google.com with SMTP id m24so2952088iol.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 21:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eYtk3rQEQHCx97BmdiVJM4sE2ubHvgbTjthfSQssYOk=;
        b=uaoYg3CxTnu2+7b2pB4uvXr6Y/7a4T2+dJvBPJnVw+u0S2Gr5UqKw2n9ssP19m/314
         1hLbowSGYXDrSEgEdaL6r8FUOo/O935r201G5PI7yyfnZvrnwwPqqzRzZAVGalBdOLkY
         cns3UMZ5fSrGbDLccLdgN8czxeaT5oPEM3OPx7QTV0VRihLWwiaCPP/DHXXEEjaCSF/G
         virAikc/v9lHxehXN5rszSOhpSZWHFWmnkiCuBPbAg4Yv8udvzMdSQZpMbU9xfUoKV22
         YPV4DLT7kVewSlQXvDiaeKoa13lBRFqA/ALS9WK/kSi5l0HSes0PL3mWtrj6f5fA61zS
         GlIg==
X-Gm-Message-State: ANhLgQ1YQ2eO968ImCcE3ms5zukaGbPTzKv1Dy9KocOM37Cya4KP3PrC
        mv0WW0BRFSJCrUcCcAxqEhCAZ5LI8vmgxAwMnLMrLbwZfaGN
X-Google-Smtp-Source: ADFU+vsnEVQxnDRCZnfjAcza9jyxAXlBqnr7xycVfA41Ci9jJ/E1lGWx3ETO5q28bSyYgHJxSRFXfFlexndfPU4YpDO/lQJhIHEN
MIME-Version: 1.0
X-Received: by 2002:a5e:9e45:: with SMTP id j5mr5814160ioq.179.1583559431284;
 Fri, 06 Mar 2020 21:37:11 -0800 (PST)
Date:   Fri, 06 Mar 2020 21:37:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061ed2e05a03d2949@google.com>
Subject: WARNING: locking bug in process_one_work
From:   syzbot <syzbot+5396b943a2f03ed3d510@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155d3529e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=5396b943a2f03ed3d510
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5396b943a2f03ed3d510@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2895 at kernel/locking/lockdep.c:840 look_up_lock_class+0x1ac/0x2a0 kernel/locking/lockdep.c:839
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2895 Comm: kworker/0:41 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: rcu_gp srcu_invoke_callbacks
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
RIP: 0010:look_up_lock_class+0x1ac/0x2a0 kernel/locking/lockdep.c:839
Code: 57 00 4c 3b 33 74 7d 48 8b 45 c8 42 80 3c 28 00 48 8b 5d d0 74 08 48 89 df e8 00 9c 57 00 48 c7 c0 30 08 a0 89 48 39 03 74 5a <0f> 0b eb 56 e8 8b 0e 41 02 45 31 e4 48 c7 c7 4f 3f e5 88 44 89 fe
RSP: 0018:ffffc90008f3fa10 EFLAGS: 00010002
RAX: ffffffff89a00830 RBX: ffffc90008f3fd78 RCX: ffffc90008f3fd78
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90008f3fd78
RBP: ffffc90008f3fa48 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff12d372d R11: 0000000000000000 R12: ffffffff89c2f670
R13: dffffc0000000000 R14: ffffffff88e58667 R15: 0000000000000000
 register_lock_class+0x99/0xeb0 kernel/locking/lockdep.c:1184
 __lock_acquire+0x116/0x1bc0 kernel/locking/lockdep.c:3836
 lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
 process_one_work+0x7c8/0x10f0 kernel/workqueue.c:2240
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

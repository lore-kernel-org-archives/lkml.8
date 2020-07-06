Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317DAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 186A52074D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgGFKrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:47:19 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54813 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgGFKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:47:16 -0400
Received: by mail-io1-f70.google.com with SMTP id q207so700355iod.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bV1o04mIYzfoK13kKj71WduMIZc/Fisa+x2TYp0LHDo=;
        b=O1NSYCvZUj/jn5oYFfZCN/WU79M47TLMjB4Ph8FPBuuwOFtCNkWKcgja/eIZ0S0img
         YusvtUZCT0e6vXbGHq+fBiaKCz7lYFzM0L+SdpMhSHSqkZvWQqeJXIFy4b3Mqe45ZeKC
         maCCCx6fJVrVi5yG+8MOBvBpGbuxInpU3sOR7+GHxsU42P9c9gu7c94668FTK0cez6Hf
         hWgaoNeMufpS54Kdp+Tokg35y+4xp33T7g9Rl4KCYyhRzxNwyay3gaCZA6nhfsD4iZoW
         qi82+wiAQE+tV/m+wxMIMB6eMYv3/eb5vgv1sB6A9Aszt7nzSGPaDaJUETIptYmWKJV2
         dcYA==
X-Gm-Message-State: AOAM5325QSkT3IOWP6QzlD3YvLHQFZYrk07qb/DTLu0uDOKjaQXLrBhc
        eqezGrlZzsFKX502heDuyk/E5XKcJfCBz+hcfRB6CMK6PhV0
X-Google-Smtp-Source: ABdhPJxGHDXWd93bm5fuKZthng2Z6tzSk1u1TborWWVLClMTLZ309wxlsSsEAZCXltyNJEXWQEs6++aXJsQTmt9K+wyFEVA4j1UH
MIME-Version: 1.0
X-Received: by 2002:a5e:8d15:: with SMTP id m21mr25229706ioj.60.1594032435591;
 Mon, 06 Jul 2020 03:47:15 -0700 (PDT)
Date:   Mon, 06 Jul 2020 03:47:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000157f8105a9c399b9@google.com>
Subject: WARNING in trace_hardirqs_off_thunk
From:   syzbot <syzbot+d135d81280f93e6e9d4b@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14180d35100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=d135d81280f93e6e9d4b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d135d81280f93e6e9d4b@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!irqs_disabled())
WARNING: CPU: 0 PID: 7117 at kernel/locking/lockdep.c:3745 lockdep_hardirqs_off+0x1ac/0x2f0 kernel/locking/lockdep.c:3745
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7117 Comm: syz-executor.3 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:105 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:197
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:216
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:lockdep_hardirqs_off+0x1ac/0x2f0 kernel/locking/lockdep.c:3745
Code: 42 8a 04 20 84 c0 0f 85 2a 01 00 00 83 3d 0f 9f 56 01 00 75 cd 48 c7 c7 c6 44 e6 88 48 c7 c6 6b d4 e7 88 31 c0 e8 e4 8a 30 f9 <0f> 0b eb b4 48 c7 c1 70 7d 6c 89 80 e1 07 80 c1 03 38 c1 0f 8c 71
RSP: 0018:ffffc90005587ed0 EFLAGS: 00010246
RAX: f9f4096c7a9c0100 RBX: ffff8880676c6b4c RCX: ffff8880676c6280
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000286
RBP: ffffc90005587f48 R08: ffffffff817a4660 R09: fffffbfff125cd89
R10: fffffbfff125cd89 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff81006f10 R15: ffff8880676c6280
 trace_hardirqs_off_thunk+0x1a/0x1c arch/x86/entry/thunk_64.S:42
 entry_SYSCALL_64_after_hwframe+0x3e/0xb3
RIP: 0033:0x45f89a
Code: 25 18 00 00 00 00 74 01 f0 48 0f b1 3d cf a5 84 00 48 39 c2 75 da f3 c3 0f 1f 84 00 00 00 00 00 48 63 ff b8 e4 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 c7 c2 d4 ff ff ff f7
RSP: 002b:00007fff40af3258 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 000000000009eeef RCX: 000000000045f89a
RDX: 0000000000000000 RSI: 00007fff40af3260 RDI: 0000000000000001
RBP: 00000000000008bc R08: 0000000000000001 R09: 00000000015d8940
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000a
R13: 00007fff40af32c0 R14: 000000000009ee34 R15: 00007fff40af32d0
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

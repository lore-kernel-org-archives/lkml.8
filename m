Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E583C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1484206E9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgIJVur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:50:47 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41655 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730761AbgIJMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:23 -0400
Received: by mail-io1-f72.google.com with SMTP id j4so4173361iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 05:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VwrlinUd9kcwoUzQiQFmPRuCi3c6IG53KKTkPvCrpzw=;
        b=N6ACfaWO6/d9rDx+tTSEcGaeTwktEn1MJ0Q0m8z5WEbxa7ZkCEHgofStW6Ulm81Ee1
         YjSGBVEF8KU60h6bDx5QzKnkPhCG7sPKi91+JrcUUt9h/W6k9EjsyG1tsZ8fD4BDiNMx
         fhfrwHyEzcFvap8rAHn9SM8NF74A3xpapwVghYIa0L/6pyB5eknB5jHjz8IX9zVdwX6/
         68xbRiXbiC0ht+cF/WWaYUXS15V3LOvZuy2AT0e6W8XQ2z/kZBYkWSpm/HFKhTR+BaUf
         iBKkySzvXzA3evgbY3WVR0G8fd1lhPvx89b9xe1/KgtkxNI5J4BZzWI6ivCbWKBYw71i
         XRBQ==
X-Gm-Message-State: AOAM530aEBKQHgV/z5PQ/ZhjyQ7pPGCTQ+vs6gGuwp7mfB1yNtsXp7Md
        cD0IE10lzT4Z5ETs8rYULB2JnBwm6JCGd/zPv9HeT1iUH2Ln
X-Google-Smtp-Source: ABdhPJyjTYvh1M3ybPxkFS58uNVt6Y64hVVYzYW7pgEStSABBQd+BfOcqLa5rX1BCN4hHSH1erBwZ1TTwM4QYfGq6hWE7lc4nO1t
MIME-Version: 1.0
X-Received: by 2002:a92:d07:: with SMTP id 7mr4985339iln.243.1599741499410;
 Thu, 10 Sep 2020 05:38:19 -0700 (PDT)
Date:   Thu, 10 Sep 2020 05:38:19 -0700
In-Reply-To: <000000000000a74731059f545387@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce0feb05aef4d7a1@google.com>
Subject: Re: WARNING in tracepoint_probe_register_prio (4)
From:   syzbot <syzbot+1b2f76c6fb6f549f728b@syzkaller.appspotmail.com>
To:     allison@lohutok.net, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@polymtl.ca, mingo@elte.hu,
        netdev@vger.kernel.org, rfontana@redhat.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ab2b7d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f5c353182ed6199
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2f76c6fb6f549f728b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145c4735900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d31621900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b2f76c6fb6f549f728b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6978 at kernel/tracepoint.c:243 func_add kernel/tracepoint.c:147 [inline]
WARNING: CPU: 1 PID: 6978 at kernel/tracepoint.c:243 tracepoint_add_func kernel/tracepoint.c:241 [inline]
WARNING: CPU: 1 PID: 6978 at kernel/tracepoint.c:243 tracepoint_probe_register_prio+0x4ac/0x590 kernel/tracepoint.c:315
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6978 Comm: syz-executor432 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 panic+0x2c0/0x800 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:tracepoint_add_func kernel/tracepoint.c:147 [inline]
RIP: 0010:tracepoint_probe_register_prio+0x4ac/0x590 kernel/tracepoint.c:315
Code: 48 89 df e8 16 b2 1f 00 89 c5 31 ff 89 c6 e8 1b 7c fe ff 85 ed 7e 1a e8 02 78 fe ff eb 20 e8 fb 77 fe ff 49 c7 c7 ef ff ff ff <0f> 0b 44 89 fd eb 4f e8 e8 77 fe ff 48 89 df e8 30 b8 1f 00 31 ed
RSP: 0018:ffffc900055a7c38 EFLAGS: 00010293
RAX: ffffffff81768595 RBX: dffffc0000000000 RCX: ffff88808d43e1c0
RDX: 0000000000000000 RSI: 000000000000000a RDI: 000000000000000a
RBP: ffff88809d603660 R08: ffffffff8176831e R09: fffffbfff13164de
R10: fffffbfff13164de R11: 0000000000000000 R12: 000000000000000a
R13: 0000000000000003 R14: 00000000ffffffff R15: ffffffffffffffef
 bpf_raw_tracepoint_open kernel/bpf/syscall.c:2741 [inline]
 __do_sys_bpf+0x63ae/0x11060 kernel/bpf/syscall.c:4220
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446bd9
Code: e8 8c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6d31c3eda8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446bd9
RDX: 0000000000000010 RSI: 00000000200001c0 RDI: 0000000000000011
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 0000000020000100 R14: 00000000004aebc0 R15: 0000000000000064
Kernel Offset: disabled
Rebooting in 86400 seconds..


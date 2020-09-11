Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99CFC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F10221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgIKKjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:39:24 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:50737 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgIKKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:39:21 -0400
Received: by mail-il1-f206.google.com with SMTP id l8so6733262ilo.17
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nZI2CaiomncGgmG7TL1T+3Np/Oje3tkGaTOLDbcEoU8=;
        b=a4mJ32/Zx+qf/dcVYDoIL2cjjEjh4b3CNurJ9gknaWDA+kCjYi27hJAjqXQXGgaKyj
         QsUr3qyDUyl+Zf9mJ2dqeMk5nUPbcj+fgC0gYOjpEaJ6dkz/s8XdrGvgFbjJogbBYKrc
         DZUT7GpFd7YhOVXrUiejHFQ/5efLNS8xTtn8gpN+8ttyZ8qc8IJgrT35ZCwij/TCD/yj
         KFuZbw+eIecEbjEOMaAe/hKNOm3Sun9851wISBpjzkw+zghVArTnbwEQrJfGg743k1tf
         kjDUdTH43uhDMCCsPWUg5O6Qa97Z02g64bPuw2Y6wJc07UHWTkU5dTiphECovllk6kVz
         LIoQ==
X-Gm-Message-State: AOAM531svczujd7bJ6opue9IkRHNJOn8iHPWlWITLMkngBgfCzUrwjbC
        NfKQhDhUlgZxLh+lnvdXRqqfEueckSdLqgLdrXt49rHIS9Nb
X-Google-Smtp-Source: ABdhPJye5TJWUK0tUyG3lqHlLZ+RlCIjGYb1QewDJ03kc+0j4oNHPzwkftT/npnJ7vndi7oQ7aP2dlcigNyq/EbdG0ijpYI5QLdS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13aa:: with SMTP id h10mr1193745ilo.212.1599820759865;
 Fri, 11 Sep 2020 03:39:19 -0700 (PDT)
Date:   Fri, 11 Sep 2020 03:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018a47605af074c7d@google.com>
Subject: WARNING in syscall_exit_to_user_mode
From:   syzbot <syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f4d51dff Linux 5.9-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a4e7cd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=7ffc7214b893651d52b8
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122d7335900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cea1a5900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=162247cd900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=152247cd900000
console output: https://syzkaller.appspot.com/x/log.txt?x=112247cd900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ffc7214b893651d52b8@syzkaller.appspotmail.com

------------[ cut here ]------------
syscall 56 left IRQs disabled
WARNING: CPU: 1 PID: 31467 at kernel/entry/common.c:245 syscall_exit_to_user_mode_prepare kernel/entry/common.c:245 [inline]
WARNING: CPU: 1 PID: 31467 at kernel/entry/common.c:245 syscall_exit_to_user_mode+0xc1/0x2e0 kernel/entry/common.c:263
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 31467 Comm: syz-executor465 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:syscall_exit_to_user_mode_prepare kernel/entry/common.c:245 [inline]
RIP: 0010:syscall_exit_to_user_mode+0xc1/0x2e0 kernel/entry/common.c:263
Code: 58 00 48 8b 7c 24 20 5b 5d 41 5c 41 5d e9 97 f7 ff ff e8 72 88 85 f9 eb c6 0f 0b 48 63 f6 48 c7 c7 50 a9 6a 89 e8 61 c8 50 f9 <0f> 0b e8 b8 8e 85 f9 48 83 3d 28 b6 c1 01 00 0f 84 7d 01 00 00 fb
RSP: 0018:ffffc90003f27f30 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000004000 RCX: 0000000000000000
RDX: ffff8880a2ec6480 RSI: ffffffff815db9a7 RDI: fffff520007e4fd8
RBP: ffffc90003f27f58 R08: 0000000000000000 R09: ffffffff89bcb4a3
R10: 00000000000007db R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:287
RIP: 0033:0x44da49
Code: ff 48 85 f6 0f 84 a7 dc fb ff 48 83 ee 10 48 89 4e 08 48 89 3e 48 89 d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85 c0 0f 8c 7e dc fb ff 74 01 c3 31 ed 48 f7 c7 00 00 01 00 75
RSP: 002b:00007f7349191db0 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00007f7349192700 RCX: 000000000044da49
RDX: 00007f73491929d0 RSI: 00007f7349191db0 RDI: 00000000003d0f00
RBP: 00007ffe9e518280 R08: 00007f7349192700 R09: 00007f7349192700
R10: 00007f73491929d0 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffe9e5181df R14: 00007f73491929c0 R15: 20c49ba5e353f7cf
Kernel Offset: disabled


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

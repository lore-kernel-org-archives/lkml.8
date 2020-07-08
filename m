Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F22C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58530206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgGHPNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:13:23 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:46084 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbgGHPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:13:23 -0400
Received: by mail-il1-f197.google.com with SMTP id d8so29899438ilc.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JPrAZE13XbxfP4Dh4gTpYVzCyDE4dFsVbnCtahWy+aw=;
        b=uVgH3ALZEJ/4qbYwnVyCi7Tmf6Ax2ZRQ+dIvIHTt13ZcuKSOEhnHOAxE3C9y5Uel2N
         Jh9f4rR0GT4MokICUbxhfhsJVO94w1EoHObFdSmGp6VtxENM+pFG5anzLSha65rjXEEa
         HEib5zyesD2vzTfhrl5TgeJszAvrK/BhWuJ+nK00hV3m5MxILlD2AUXqmgqwXhb+nUPF
         0L/T72hfSATnsodSMWHMPUzjVKfOLxIv7g3AFA9JtyVbDUDIEEfBTbOzGP3jM74Unu78
         aue8hY0zbtfXXh6PADB1mpGmzW9Z6YFL0ubT6z/yWUJQdKDjN0eCy6pKsT53rLoxKuo0
         hqPA==
X-Gm-Message-State: AOAM530IOIOiq9XN2Oapp7l4KPvrqyylQXVTTwKGT6xanqmMKHDDuXfw
        0UzzbUDuZWojQMY0wFuq+S5bJcNjx+bKRZyzo5a9W9mpr9xa
X-Google-Smtp-Source: ABdhPJwLs8GNZszrCPaYrYSnRkJ/jOyLPBsnXyR47bonFsb33x8uKH+SBDaoQd2ErW21xjnW5DrRhVho/CXcPbUk4pnpaOOk+Yg3
MIME-Version: 1.0
X-Received: by 2002:a92:a1cf:: with SMTP id b76mr39602724ill.128.1594221202647;
 Wed, 08 Jul 2020 08:13:22 -0700 (PDT)
Date:   Wed, 08 Jul 2020 08:13:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a342c05a9ef8cb9@google.com>
Subject: WARNING in idtentry_exit_cond_rcu
From:   syzbot <syzbot+0889df9502bc0f112b31@syzkaller.appspotmail.com>
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

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1740a283100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=0889df9502bc0f112b31
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d93ccb100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0889df9502bc0f112b31@syzkaller.appspotmail.com

------------[ cut here ]------------
IRQs not disabled as expected
WARNING: CPU: 0 PID: 7045 at arch/x86/entry/common.c:645 idtentry_exit_cond_rcu+0x91/0xf0 arch/x86/entry/common.c:645
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7045 Comm: syz-executor.0 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:idtentry_exit_cond_rcu+0x91/0xf0 arch/x86/entry/common.c:645
Code: 8b 80 88 08 00 00 85 c0 74 b4 80 3d 42 18 c5 02 00 75 ab 48 c7 c7 88 93 65 89 89 74 24 04 c6 05 2e 18 c5 02 01 e8 d1 96 60 f9 <0f> 0b 8b 74 24 04 eb 8c 48 83 c4 08 48 89 ef 5d e9 4a fc ff ff e8
RSP: 0018:ffffc90002317f40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880a0e00400 RSI: ffffffff815d4f87 RDI: fffff52000462fda
RBP: ffffc90002317f58 R08: 0000000000000001 R09: ffff8880ae6318e7
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff880009d8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 asm_exc_alignment_check+0x1e/0x30 arch/x86/include/asm/idtentry.h:560
RIP: 0033:0x2000020c
Code: Bad RIP value.
RSP: 002b:00007f388e3adc78 EFLAGS: 00254e02
RAX: 00000000000000e6 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000009400 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

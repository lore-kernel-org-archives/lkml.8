Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C07C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351F6206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2NOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:14:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:34026 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2NOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:14:16 -0400
Received: by mail-il1-f200.google.com with SMTP id d8so2271633ilo.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Odu2vmo2H/2OP4FVixkR1Mn2xWqCB7hkcPW7fYlyey8=;
        b=MGl3L2jCuzxZ7qBdM81NBZr1ltoGK77RcFeZ7N+9cTycICXAUZO82Zorq/SYdehSHs
         eHAxAkkoSfoGipvE5FnNszAUH/dc//OILVZmeVPKb1FCthJHulq0+4ZC6IR7PzFP7K+S
         xezA2oCbBWW2Gy8cMJTCBX8IR50EyD+Cr55k+zzRmhmNhJbHhZwHRMFjCpVY1qS0XBaM
         6bDZ4FniabphIcST/yFIXGc9k8LuCEso0LbaNXiMx4+Xzgldqq5tIvrmdw2iXWebQ+0G
         VMGhxAnmwyYj+1IjpS13YbwzH8m5I0a2/ZXtNLip/FdCfTgi6VZq40NNnWn55O13oBME
         q8Og==
X-Gm-Message-State: AOAM531Aj1bBbaqBLdNHhapH9DXdsilVjIjKJP1AqYsDSa0Gel2sj2Yu
        zYF7TEN561fWfZETfElLB97422X0O40N1gpBnf29SHswSA/K
X-Google-Smtp-Source: ABdhPJwqBkMJTUPeLBD29TbrRIJ9NyLvfb2BENrCsymb9r3dElAVt/UjzyTiyAfuoWGSOmKtQSQHUDB4ZNRalDXviPckNSQAMjBf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:591:: with SMTP id c17mr6751087ils.155.1590758055493;
 Fri, 29 May 2020 06:14:15 -0700 (PDT)
Date:   Fri, 29 May 2020 06:14:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2474c05a6c938fe@google.com>
Subject: PANIC: double fault in fixup_bad_iret
From:   syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7b4cb0a4 Add linux-next specific files for 20200525
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15dc34ba100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
dashboard link: https://syzkaller.appspot.com/bug?extid=dc1fa714cb070b184db5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14678626100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1017ef06100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com

traps: PANIC: double fault, error_code: 0x0
double fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7280 Comm: syz-executor776 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:fixup_bad_iret+0x24/0x170 arch/x86/kernel/traps.c:665
Code: eb cb 0f 1f 40 00 41 55 49 bd 00 00 00 00 00 fc ff df 41 54 55 48 89 fd 48 c7 c7 80 8a 25 88 53 48 81 ec 40 01 00 00 48 89 e3 <48> c7 04 24 b3 8a b5 41 48 c7 44 24 08 bf d3 49 89 48 c1 eb 03 48
RSP: 0018:fffffe0000001fb8 EFLAGS: 00010086
RAX: fffffffffffffff7 RBX: fffffe0000001fb8 RCX: ffffffff87e00d57
RDX: 0000000000000000 RSI: ffffffff87e009c8 RDI: ffffffff88258a80
RBP: fffffe0000002120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001f65880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffe0000001fa8 CR3: 00000000a02aa000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <ENTRY_TRAMPOLINE>
 error_entry+0xb8/0xc0 arch/x86/entry/entry_64.S:1375
RIP: 0010:native_irq_return_iret+0x0/0x2
Code: 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4 08 e9 10 00 00 00 90 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 f6 44 24 20 04 75 02 <48> cf 57 0f 01 f8 0f 1f 00 65 48 8b 3c 25 00 b0 01 00 48 89 07 48
RSP: 0018:fffffe00000021d8 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
RAX: fffffffffffffff7 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
RIP: 0033:0x3bfd19e0df38d197
Code: Bad RIP value.
RSP: 002b:00007fffaaa547c8 EFLAGS: 00000346 </ENTRY_TRAMPOLINE>
Modules linked in:
---[ end trace d6561a908e3835a1 ]---
RIP: 0010:fixup_bad_iret+0x24/0x170 arch/x86/kernel/traps.c:665
Code: eb cb 0f 1f 40 00 41 55 49 bd 00 00 00 00 00 fc ff df 41 54 55 48 89 fd 48 c7 c7 80 8a 25 88 53 48 81 ec 40 01 00 00 48 89 e3 <48> c7 04 24 b3 8a b5 41 48 c7 44 24 08 bf d3 49 89 48 c1 eb 03 48
RSP: 0018:fffffe0000001fb8 EFLAGS: 00010086
RAX: fffffffffffffff7 RBX: fffffe0000001fb8 RCX: ffffffff87e00d57
RDX: 0000000000000000 RSI: ffffffff87e009c8 RDI: ffffffff88258a80
RBP: fffffe0000002120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000001f65880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffe0000001fa8 CR3: 00000000a02aa000 CR4: 00000000001406f0
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

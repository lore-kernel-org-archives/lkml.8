Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F2AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EE6206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGIJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:45:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52220 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGIJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:45:21 -0400
Received: by mail-il1-f198.google.com with SMTP id s137so900863ilc.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oLKGElfUNJ8ohVHuma0T7moqJ7X4ZlGuJjco+f1OcMI=;
        b=sWGNMaLWyip/uLHhMaWW5Z0ZSyWXaC1pizI3Eq5aag5ako/HbF49QyKzlLV8HNIYog
         kPQoLO4yulPqKmW9s3Y2P63eDSkmncu0Wtcq4Jptja6i06WGSfMA5Y90hFeboqDQEzVo
         JtIy/lF+pU2/kkRKHMN3ZlqfFyPGFogB637JUa+LMx97sVk9g8lYAnsvLAgxOVQuxE6H
         FDcdJT3Q70ZEnJu75kHBOtGyPh29vbcNGjlXl0PTdVHyXGN8JPYe3fRqplUDcfqqN48O
         p3Bykgq+KffbWagkE1h0gTEYihrWYnsCtpjja7OX3n4PoqhQ5RGioqPkIt3f+ps31ppq
         rJuA==
X-Gm-Message-State: AOAM533RdI4ASrpGPUFls8VCMWpFc3IM8TAqon3c7WXVvRGHY+mKwTQI
        BHR+rEIJnP8SxK42w3vIFWOvfYZ18MBolVBYI8C5+XKE0BX9
X-Google-Smtp-Source: ABdhPJxiJLLQYeRg3Nwupczld6I6/f+eHT4G1RUz5KWLRZnBhPT8EBaCRzLRRL/SvTgleHqT0vEJpv4k9KzhlbDs71NiuSa6iO75
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f0f:: with SMTP id q15mr41784349iow.23.1594287920390;
 Thu, 09 Jul 2020 02:45:20 -0700 (PDT)
Date:   Thu, 09 Jul 2020 02:45:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a265205a9ff15e3@google.com>
Subject: BUG: stack guard page was hit in mark_held_locks
From:   syzbot <syzbot+c66218bec77a89793c66@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1051ee8f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=c66218bec77a89793c66
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c66218bec77a89793c66@syzkaller.appspotmail.com

BUG: stack guard page was hit at 00000000d2019c30 (stack is 0000000006f487e0..0000000048f31ef3)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7063 Comm: syz-executor.3 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mark_held_locks+0xa/0xe0 kernel/locking/lockdep.c:3593
Code: 8a e8 6a dd 59 00 e9 db f1 ff ff 48 c7 c7 a0 51 92 8c e8 59 dd 59 00 e9 02 f2 ff ff 0f 1f 40 00 48 b8 00 00 00 00 00 fc ff df <41> 56 41 55 41 54 49 89 fc 48 81 c7 d0 08 00 00 48 89 fa 55 89 f5
RSP: 0018:ffffc90004cc0000 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88805638c240
RBP: ffff88805638c240 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff81340ba2 R14: 0000000000000200 R15: ffff88808fe4e780
FS:  00000000025e3940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90004cbfff8 CR3: 0000000056360000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:3627 [inline]
 lockdep_hardirqs_on_prepare+0x1bc/0x590 kernel/locking/lockdep.c:3686
 trace_hardirqs_on+0x5f/0x220 kernel/trace/trace_preemptirq.c:49
 do_user_addr_fault+0x792/0xd00 arch/x86/mm/fault.c:1196
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc01a8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc016f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc0338 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc02ff
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc04c8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc048f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc0658 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc061f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc07e8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc07af
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc0978 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc093f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90004cc0b08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff839880cb RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83af6ae0 R09: ffffc90004cc0acf
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88808fe4e780
 search_module_extables+0xce/0x100 kernel/module.c:4422
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 do_user_addr_fault+0xa59/0xd00 arch/x86/mm/fault.c:1237
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <
Lost 1355 message(s)!
---[ end trace 445352104cff919d ]---
RIP: 0010:mark_held_locks+0xa/0xe0 kernel/locking/lockdep.c:3593
Code: 8a e8 6a dd 59 00 e9 db f1 ff ff 48 c7 c7 a0 51 92 8c e8 59 dd 59 00 e9 02 f2 ff ff 0f 1f 40 00 48 b8 00 00 00 00 00 fc ff df <41> 56 41 55 41 54 49 89 fc 48 81 c7 d0 08 00 00 48 89 fa 55 89 f5
RSP: 0018:ffffc90004cc0000 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff88805638c240 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88805638c240
RBP: ffff88805638c240 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff81340ba2 R14: 0000000000000200 R15: ffff88808fe4e780
FS:  00000000025e3940(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90004cbfff8 CR3: 0000000056360000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

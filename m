Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C32C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32A02065F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGKHKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 03:10:24 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52146 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgGKHKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 03:10:23 -0400
Received: by mail-io1-f70.google.com with SMTP id l1so4992231ioh.18
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 00:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=h3Vk3eXrn0y01MLjSo8olxdAopheGwFN2NEb7CEvUTw=;
        b=bfzxFud139/dlayeqV1JU3x5xbk6177LvHmjRlC1wzsabY2GIu9kb7FWlEv4WzJ8y5
         /sED2AVZk/T3mFNwPFIDRLyHDJKiHDSrDOkhLy+xkqK5GrSox2AorVLsPL9TTTankJll
         yRV+2QGoqekXvG+dXDDPhN/113TBPhRMKUbxZ9Bc6ZLPmEifxOylimJ3iV21DxtohB17
         EvNgz9pL0oEJafVBqHbfuZDfzPiVQvJjTxk9maWpbsQQUT0FcoXwmSBfwiT7Bol4CusQ
         8TkRy6bl0udaoljhDNaIw7iLzptgyW7CCEmZXhSAw4+J6jeztHhXa+PlnUm3xK79Msg+
         fMEQ==
X-Gm-Message-State: AOAM5321zsquL5KrjGNsndRnvKao8qk8r4diMs2mqzlA2GvhN9dv8Drr
        ePaBBsSehEZzzuFTTt0jE3qF5mCYqONydGxF4bugvijekaVZ
X-Google-Smtp-Source: ABdhPJzax6znZAv2hvNDOtRdoAjHgnVFFNQyqkh990TTAPygXRT+/CoBEwQynS0a+/LtcCb7rmCdEGVuz0xUTKURH9cQT1ZzwQsM
MIME-Version: 1.0
X-Received: by 2002:a02:a909:: with SMTP id n9mr76315786jam.70.1594451422409;
 Sat, 11 Jul 2020 00:10:22 -0700 (PDT)
Date:   Sat, 11 Jul 2020 00:10:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4fd8105aa252630@google.com>
Subject: BUG: stack guard page was hit in fixup_exception
From:   syzbot <syzbot+3370f8260246b965fefd@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    42f82040 Merge tag 'drm-fixes-2020-07-10' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d80333100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=3370f8260246b965fefd
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3370f8260246b965fefd@syzkaller.appspotmail.com

BUG: stack guard page was hit at 000000004cbdbd91 (stack is 00000000e7fa34ab..000000001a32f95e)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 11649 Comm: kworker/u4:5 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
RIP: 0010:fixup_exception+0x0/0xca arch/x86/mm/extable.c:143
Code: 5d 41 5c c3 e8 b1 9f 3f 00 45 31 e4 5b 44 89 e0 5d 41 5c c3 48 89 ef e8 9e f8 7e 00 eb c7 66 90 66 2e 0f 1f 84 00 00 00 00 00 <41> 57 49 89 cf 41 56 49 89 d6 41 55 41 89 f5 41 54 49 89 fc 55 53
RSP: 0018:ffffc90001810000 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900018102a0 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 000000000000000e RDI: ffffc90001810218
RBP: ffffc90001810218 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 000000000000000b R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000180fff8 CR3: 000000008749d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900018102c8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc900018105d0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83968d3b RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad6dc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4425
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900018105f8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90001810900 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83968d3b RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad6dc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4425
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001810928 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90001810c30 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83968d3b RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad6dc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4425
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001810c58 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90001810f60 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83968d3b RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad6dc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4425
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001810f88 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90001811290 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83968d3b RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad6dc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4425
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900018112b8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc900018115c0 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83968d3b RDI: 0000000000000001
RBP: ffffffff810078f7 R08: ffffffff83ad6dc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000e R14: 0000000000000002 R15: 0000000000000000
 search_module_extables+0xce/0x100 kernel/module.c:4425
 search_exception_tables+0x42/0x50 kernel/extable.c:59
 fixup_exception+0x4b/0xca arch/x86/mm/extable.c:161
 no_context+0xe7/0x9f0 arch/x86/mm/fault.c:599
 __bad_area_nosemaphore+0xa9/0x480 arch/x86/mm/fault.c:789
 do_user_addr_fault+0x783/0xd00 arch/x86/mm/fault.c:1171
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:preempt_schedule_thunk+0x0/0x18 arch/x86/entry/thunk_64.S:40
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 
Lost 823 message(s)!
---[ end trace 7175130f674c1b3d ]---
RIP: 0010:fixup_exception+0x0/0xca arch/x86/mm/extable.c:143
Code: 5d 41 5c c3 e8 b1 9f 3f 00 45 31 e4 5b 44 89 e0 5d 41 5c c3 48 89 ef e8 9e f8 7e 00 eb c7 66 90 66 2e 0f 1f 84 00 00 00 00 00 <41> 57 49 89 cf 41 56 49 89 d6 41 55 41 89 f5 41 54 49 89 fc 55 53
RSP: 0018:ffffc90001810000 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc900018102a0 RCX: 0000000000000000
RDX: 0000000000000002 RSI: 000000000000000e RDI: ffffc90001810218
RBP: ffffc90001810218 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000002 R14: 000000000000000b R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc9000180fff8 CR3: 000000008749d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

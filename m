Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A51C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF3E21744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHEHTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:19:30 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:36796 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHEHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:19:17 -0400
Received: by mail-il1-f200.google.com with SMTP id o191so30184630ila.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9zzmNFtymA/Mrwa80yme/uxSqfhfknKi9YCHKjd/jqY=;
        b=eodqbF0E961kyy7rfSGQmKL0GVGkM1W6GyWJZ8GLfJTs7bV/QO0WwT6d2Iynvqkc3K
         6g6L3HS0uhXiP1lsa9MsPTAU8XpxByLpTemp1X1Nq5y7rWW/8uul8mcV+uLnbqwyxeJN
         FU/0xywEjKD/nOf/o1hWZcbewUaM9wFhgdJLmLMN6+KRm9cpJTiiS47Pbimhm2Hs6G73
         RWb8pBY7/FW4v54vj/YsEwWDryE8BhEIgR0eSIylwHAhzfBU1z+aTZlLRsohOIyhfiSR
         loI6YS26BJ6NNTYQfQii7+tsj/oVDtNHaj6aalf29bjlYM0l6KpBbzVSMAuBZ050kK2P
         2nqg==
X-Gm-Message-State: AOAM5318e1gFhjRC0mTSc0ndlt+aSwuVV8GL/N31V5vO3Lzmhem354Cj
        QSF+dRLb9Zh2x+U+0nWrhe7k8GDxILTbXbp9znkk0fPlpwQV
X-Google-Smtp-Source: ABdhPJx9FjDcydLQD0k/hlo/1Ern28Gh+EHpO/heYMcoXVbCneCBF8trXFt2PiJhZIhtrFficel+VX1qHKBEp+6809y2t1zzC2X7
MIME-Version: 1.0
X-Received: by 2002:a92:48dd:: with SMTP id j90mr2633962ilg.75.1596611956613;
 Wed, 05 Aug 2020 00:19:16 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084a83605ac1c302e@google.com>
Subject: upstream test error: WARNING in flush_tlb_mm_range
From:   syzbot <syzbot+0338e3cdaaea6cc59e92@syzkaller.appspotmail.com>
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

syzbot found the following issue on:

HEAD commit:    442489c2 Merge tag 'timers-core-2020-08-04' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1563e7ca900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25e437ac2202c1c3
dashboard link: https://syzkaller.appspot.com/bug?extid=0338e3cdaaea6cc59e92
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0338e3cdaaea6cc59e92@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5077 at arch/x86/mm/tlb.c:936 flush_tlb_mm_range+0x182/0x1a0 arch/x86/mm/tlb.c:946
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 5077 Comm: systemd-udevd Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x16e/0x25d lib/dump_stack.c:118
 panic+0x20c/0x69a kernel/panic.c:231
 __warn+0x211/0x240 kernel/panic.c:600
 report_bug+0x153/0x1d0 lib/bug.c:198
 handle_bug+0x4d/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x70 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:547
RIP: 0010:flush_tlb_mm_range+0x182/0x1a0 arch/x86/mm/tlb.c:946
Code: 01 00 00 00 e8 5f 00 16 00 65 8b 05 b4 0f e0 7e 85 c0 74 0f 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 07 f0 de ff eb ea <0f> 0b 48 83 3d 84 3a ea 06 00 0f 85 5b ff ff ff 0f 0b 0f 0b 0f 0b
RSP: 0000:ffffc90000e23c08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888124284cc0 RCX: ffff88812c12ce40
RDX: 00007f85bc6c4000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 00007f85bc6c4000 R08: 0000000000000000 R09: 00008881240d0a6f
R10: 0000ffffffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000c R14: 00007f85bc6c3000 R15: 0000000000000373
 flush_tlb_page arch/x86/include/asm/tlbflush.h:235 [inline]
 ptep_clear_flush+0xb3/0xd0 mm/pgtable-generic.c:97
 wp_page_copy+0x7b0/0x1360 mm/memory.c:2713
 do_wp_page+0x9de/0xd40 arch/x86/include/asm/atomic.h:95
 handle_pte_fault mm/memory.c:4243 [inline]
 __handle_mm_fault mm/memory.c:4357 [inline]
 handle_mm_fault+0x173d/0x1980 mm/memory.c:4394
 do_user_addr_fault+0x3a0/0x820 arch/x86/mm/fault.c:1295
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xbf/0x210 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:549
RIP: 0033:0x7f85bc39c1f7
Code: 25 10 00 00 00 48 3b 15 6f 75 32 00 74 46 be 01 00 00 00 31 c0 83 3d 17 a5 32 00 00 74 0c f0 0f b1 35 4d 75 32 00 75 0b eb 23 <0f> b1 35 42 75 32 00 74 1a 48 8d 3d 39 75 32 00 48 81 ec 80 00 00
RSP: 002b:00007ffc677521c0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00005622f70bf120 RCX: 00005622f70bf210
RDX: 00007f85bd5908c0 RSI: 0000000000000001 RDI: 00007ffc677521c0
RBP: 0000000000000001 R08: 00007f85bc6bdf00 R09: 0000000000000230
R10: b8a2bbf99842869b R11: 00007f85bc485184 R12: 00005622f58cc68a
R13: 0000000000000001 R14: 00005622f70d1260 R15: 00007ffc677523c0
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

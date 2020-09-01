Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F9C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012ED206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 07:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIAHSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 03:18:23 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:52950 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 03:18:22 -0400
Received: by mail-il1-f200.google.com with SMTP id m1so198778iln.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=J2oWNmTzZACNYarqluKtYNMoTJKNCnqXx3X25DlWDMU=;
        b=M0W8m+Q3KK6POFYEDOW3LiD9wuD4r3LWA4zZCQt99rso1l+cSglyKM9SNKDzfX8kbf
         bkF5tYJ2NVNJThP1vxzHLrsDF1J+2OQ+yxiSyNH2ew1es6VUyL/XuX5145UXzBuN8I9v
         XKjmhvrFASs1LeLI6XWGSRIqNNBGLWXV4gpDItk5ae5/wk5HfMjv0zjQKDRDjR7FBfJr
         jCXRnHckDVDxAyvcXhCwzB3+Zz7xUcgd92qJxxqbS7tNfSFW8n1Vs1OmRnA9gqZ/BXM8
         zUT6E+7Ug8a1lFldgXYEmWQ4Xx2tqzJatLNa+RVrxy8s5l94B/jOo24k37g2gFi0CNN6
         tgaQ==
X-Gm-Message-State: AOAM5320yeTTBwkBz6CwVUEtJ40KVeMsXyR6Xw6h+SHHYHg/yQrWMoAX
        +mULRbHjflI416m7kzAyshPXHBByr/m8yQPinLXgq9VhmMgr
X-Google-Smtp-Source: ABdhPJyumOjdLkLDvR3CMMPTxauO5Ud9XIwGy2s4zq/PfEyP9XDGb9hMf0EstRtqQwQ3YsT89DxcnaYjulRUoc8PZ4wJllpcWREH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:587:: with SMTP id a7mr173464jar.72.1598944701027;
 Tue, 01 Sep 2020 00:18:21 -0700 (PDT)
Date:   Tue, 01 Sep 2020 00:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb98fd05ae3b521e@google.com>
Subject: WARNING in trace_hardirqs_on
From:   syzbot <syzbot+b5f7b2c028d621a3cbdd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140de7e5900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=b5f7b2c028d621a3cbdd
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5f7b2c028d621a3cbdd@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
WARNING: CPU: 1 PID: 6411 at kernel/locking/lockdep.c:3691 lockdep_hardirqs_on_prepare+0x2ea/0x6a0 kernel/locking/lockdep.c:3691
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6411 Comm: syz-executor.4 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:lockdep_hardirqs_on_prepare+0x2ea/0x6a0 kernel/locking/lockdep.c:3691
Code: 84 c0 0f 85 69 03 00 00 83 3d 49 99 35 08 00 0f 85 22 02 00 00 48 c7 c7 ae ff 07 89 48 c7 c6 6b 93 09 89 31 c0 e8 a6 f2 ec ff <0f> 0b e9 06 02 00 00 48 c7 c1 b4 43 8f 89 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90000da8b48 EFLAGS: 00010046
RAX: 63a6bc1783a10b00 RBX: ffff88809766ed24 RCX: ffff88809766e440
RDX: 0000000000010002 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888048cccc58 R08: ffffffff817ac004 R09: fffffbfff129f8f5
R10: fffffbfff129f8f5 R11: 0000000000000000 R12: dffffc0000000000
R13: dffffc0000000000 R14: 1ffff11012ecdda4 R15: ffff88809766e440
 trace_hardirqs_on+0x6f/0x80 kernel/trace/trace_preemptirq.c:49
 __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
 _raw_spin_unlock_irq+0x1f/0x80 kernel/locking/spinlock.c:199
 spin_unlock_irq include/linux/spinlock.h:404 [inline]
 io_queue_linked_timeout fs/io_uring.c:6075 [inline]
 io_wq_submit_work+0x29b/0x580 fs/io_uring.c:5899
 io_run_cancel fs/io-wq.c:781 [inline]
 io_wqe_cancel_pending_work fs/io-wq.c:944 [inline]
 io_wq_cancel_cb+0x3b4/0x940 fs/io-wq.c:981
 io_async_cancel_one fs/io_uring.c:5300 [inline]
 io_async_find_and_cancel+0x5c/0x6e0 fs/io_uring.c:5323
 io_link_timeout_fn+0x45a/0x600 fs/io_uring.c:6046
 __run_hrtimer kernel/time/hrtimer.c:1524 [inline]
 __hrtimer_run_queues+0x47f/0x930 kernel/time/hrtimer.c:1588
 hrtimer_interrupt+0x373/0xd60 kernel/time/hrtimer.c:1650
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0xf0/0x260 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0x94/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:169 [inline]
RIP: 0010:_raw_spin_unlock_irq+0x57/0x80 kernel/locking/spinlock.c:199
Code: 00 00 00 00 fc ff df 80 3c 08 00 74 0c 48 c7 c7 c8 17 4d 89 e8 ca 05 88 f9 48 83 3d 2a 4b 20 01 00 74 25 fb 66 0f 1f 44 00 00 <bf> 01 00 00 00 e8 df 05 24 f9 65 8b 05 54 31 d5 77 85 c0 74 02 5b
RSP: 0018:ffffc90016f9fbc8 EFLAGS: 00000286
RAX: 1ffffffff129a2f9 RBX: ffff8880a96324c0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff882ccc6f
RBP: 0000000000000001 R08: dffffc0000000000 R09: fffffbfff167dab5
R10: fffffbfff167dab5 R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff92002df3fbd R14: ffff88809a1c0e9c R15: ffff88809a1c0e40
 spin_unlock_irq include/linux/spinlock.h:404 [inline]
 io_submit_flush_completions+0x3fd/0x450 fs/io_uring.c:1465
 io_submit_state_end fs/io_uring.c:6282 [inline]
 io_submit_sqes+0x1fbc/0x25b0 fs/io_uring.c:6478
 __do_sys_io_uring_enter fs/io_uring.c:8250 [inline]
 __se_sys_io_uring_enter+0x1af/0x1300 fs/io_uring.c:8209
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff7a9d6cc78 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000008240 RCX: 000000000045d5b9
RDX: 0000000000000000 RSI: 000000000000450c RDI: 0000000000000005
RBP: 000000000118d038 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 00007ffd5bd185ef R14: 00007ff7a9d6d9c0 R15: 000000000118cfec
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

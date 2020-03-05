Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF35C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B99420842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgCECPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:15:13 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:42639 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCECPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:15:13 -0500
Received: by mail-il1-f197.google.com with SMTP id 142so3343544ilc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 18:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KosNoMY9v17iDXcHTJBpDff1UGW+eB08bYAxxRTDr4w=;
        b=jnxomXQw8wZFQgUglDXnrrVtMU24n76RMm8Nscdp4mmXj27E8DA0KQmBqP+RCYJGes
         1gotNtUmxf6zdioXYUNL8q1YKM9UpNP2ajszJllnqQh9E1ec0ZL7MNxUkpWKKqWymvLr
         i8/+818pXrrBbqcV9d4aIq71rnolHK1klZZcl4rpZjTAUIRF3adxMTnKMnIKU+rZgmuE
         h2uqu2SH+AWDGHkHMUOtF3q4hCBYz3c3e/we8D7GTn8/omQ5didezItMS5MdKSx9t4ST
         4dqYggkGiuihZ2l6tOWEcyyuY6fUw/fqtSGb900WxNUqEWd9k9vse228Mm6lDSwCTKY3
         E+Uw==
X-Gm-Message-State: ANhLgQ3Aonm/p045i4TxLLeq4iGJXfbWd8tyWxAlK9wAylJPEfrOt7qQ
        GXtFqF+L8vsC3ItVW7z/Hb682d1b9F+qgr79uxb9Jrx1JaK5
X-Google-Smtp-Source: ADFU+vsYJrUQjDBgJFlBKDBKJz9xhrZVbcp0HALhImbeGn7/IPIYMCJhCT9mv2aPc0njJ/aGptKhckCzS56BX425CN+2WQBvwOZ5
MIME-Version: 1.0
X-Received: by 2002:a92:1310:: with SMTP id 16mr6027477ilt.45.1583374512443;
 Wed, 04 Mar 2020 18:15:12 -0800 (PST)
Date:   Wed, 04 Mar 2020 18:15:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c66c305a0121be1@google.com>
Subject: BUG: sleeping function called from invalid context in do_page_fault
From:   syzbot <syzbot+7f59c1e54e5ce4d95cf7@syzkaller.appspotmail.com>
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

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c2fd29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=7f59c1e54e5ce4d95cf7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7f59c1e54e5ce4d95cf7@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1400
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 4262, name: udevd
1 lock held by udevd/4262:
 #0: ffff888093e19518 (&mm->mmap_sem#2){++++}, at: do_user_addr_fault arch/x86/mm/fault.c:1383 [inline]
 #0: ffff888093e19518 (&mm->mmap_sem#2){++++}, at: do_page_fault+0x34b/0x12e1 arch/x86/mm/fault.c:1517
irq event stamp: 5474812
hardirqs last  enabled at (5474811): [<ffffffff81b3e158>] kmem_cache_free+0x98/0x320 mm/slab.c:3695
hardirqs last disabled at (5474812): [<ffffffff8100a81a>] syscall_return_slowpath arch/x86/entry/common.c:277 [inline]
hardirqs last disabled at (5474812): [<ffffffff8100a81a>] do_syscall_64+0x20a/0x790 arch/x86/entry/common.c:304
softirqs last  enabled at (5473952): [<ffffffff882006cd>] __do_softirq+0x6cd/0x98c kernel/softirq.c:319
softirqs last disabled at (5473911): [<ffffffff8147908b>] invoke_softirq kernel/softirq.c:373 [inline]
softirqs last disabled at (5473911): [<ffffffff8147908b>] irq_exit+0x19b/0x1e0 kernel/softirq.c:413
CPU: 1 PID: 4262 Comm: udevd Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 ___might_sleep.cold+0x1fb/0x23e kernel/sched/core.c:6798
 __might_sleep+0x95/0x190 kernel/sched/core.c:6751
 do_user_addr_fault arch/x86/mm/fault.c:1400 [inline]
 do_page_fault+0x378/0x12e1 arch/x86/mm/fault.c:1517
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:prepare_exit_to_usermode arch/x86/entry/common.c:189 [inline]
RIP: 0010:syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
RIP: 0010:do_syscall_64+0x2c9/0x790 arch/x86/entry/common.c:304
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc900015d7f20 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888093e16640 RCX: ffffffff8100a857
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc900015d7f48 R08: ffff888093e16640 R09: ffffed10127c2cc9
R10: ffffed10127c2cc8 R11: ffff888093e16647 R12: ffffc900015d7f58
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

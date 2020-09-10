Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF65C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCDE21D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgIJJn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:43:56 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:38709 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIJJnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:43:23 -0400
Received: by mail-io1-f80.google.com with SMTP id e21so3924604iod.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 02:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZVRi8rjz3/qt+k/6SDbI5aRnPUH8LZniKzlR1GEkLI8=;
        b=oe8xFPM1Ya5WNfHBAetYWBZ1OzP/VOjCiXeD7FTzzZDodLZJ42m79jU3EAiXui4ZDg
         ErV1339cp9bNfhRcgCSv257TMcOBDOL5V0X4OpwKWNbDb7RlxgmGmLVbVtY+VNnmmMQq
         XICNPp8faOVNTUsy+kMZ5Z1vRyVKfhudhbuXF9obGpn9oqBLDSQrmwEkUgHO7i0AsSTU
         WIvGy6gAwa7c89jPzENw6SZY5juZg7OlIGsKok0gUBByvEQ/b9rviFthuUBwvbb26+rU
         RNgCfis0YYENlz/zTqusO6rN64hkF/GeTRC65GZC7TMzZcm7kJlNHv6gw+iizPNVvY2a
         C7nQ==
X-Gm-Message-State: AOAM530xtncAs2loRvFHG9nDfBCdAnxesPNHbf+Ud8AQENTdCG5Ff4XO
        VKQ+z958H115brXOwicIYZlOXFhQFMpYqSH3KZ2MyqOaQ70L
X-Google-Smtp-Source: ABdhPJxZQf9abdj2nuyeh/ORXYeZOsBnyCgzS5uibcATuwLOrqXTG1VGkGdqqfU+haJViNXxo4NMj570uKfgP/LMIkPNW7IuIaz9
MIME-Version: 1.0
X-Received: by 2002:a92:c98c:: with SMTP id y12mr7011938iln.272.1599731002162;
 Thu, 10 Sep 2020 02:43:22 -0700 (PDT)
Date:   Thu, 10 Sep 2020 02:43:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ec83b05aef2661e@google.com>
Subject: BUG: stack guard page was hit in trace_hardirqs_off
From:   syzbot <syzbot+d634da63c815bcfe7cd7@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    34d4ddd3 Merge tag 'linux-kselftest-5.9-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1354ce29900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9075b36a6ae26c9
dashboard link: https://syzkaller.appspot.com/bug?extid=d634da63c815bcfe7cd7
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d634da63c815bcfe7cd7@syzkaller.appspotmail.com

BUG: stack guard page was hit at 0000000081fa4d7f (stack is 000000008ed0f837..0000000020f72952)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 23783 Comm: syz-executor.5 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:trace_hardirqs_off+0x8/0x210 kernel/trace/trace_preemptirq.c:76
Code: 1e 45 3a 00 e9 33 ff ff ff 48 89 df e8 11 45 3a 00 e9 fe fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55 53 <e8> f3 3e fa ff 48 8b 7c 24 28 e8 09 90 7a 06 65 8b 1d 62 f9 88 7e
RSP: 0018:ffffc900181e8000 EFLAGS: 00010046
RAX: ffff88803dad05c0 RBX: 0000000000000000 RCX: ffffc900139ec000
RDX: 0000000000040000 RSI: ffffffff81341b7f RDI: ffffc900181e8068
RBP: ffffc900181e8068 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:00000000f5570b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc900181e7ff8 CR3: 000000003af1b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 irqentry_enter+0x1d/0x50 kernel/entry/common.c:342
 exc_page_fault+0x49/0x190 arch/x86/mm/fault.c:1479
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e8110 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e8118 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e8400 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e8408 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e86f0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e86f8 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e89e0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e89e8 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e8cd0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e8cd8 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e8fc0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e8fc8 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e92b0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e92b8 R08: 0000000000000000 R09: ffffffff8ab26b8f
R10: fffffbfff1564d71 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 rcu_read_unlock_sched_notrace include/linux/rcupdate.h:772 [inline]
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x3f0/0xae0 kernel/locking/lockdep.c:4980
 down_read_trylock kernel/locking/rwsem.c:1520 [inline]
 down_read_trylock+0x193/0x350 kernel/locking/rwsem.c:1515
 mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 do_user_addr_fault+0x25e/0xbf0 arch/x86/mm/fault.c:1313
 handle_page_fault arch/x86/mm/fault.c:1429 [inline]
 exc_page_fault+0xa8/0x190 arch/x86/mm/fault.c:1482
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:preempt_schedule_notrace_thunk+0x5/0x31 arch/x86/entry/thunk_64.S:41
Code: 00 48 8d a0 58 ff ff ff e8 e9 04 46 00 55 48 89 e5 57 56 52 51 50 41 50 41 51 41 52 41 53 e8 a3 d5 f5 06 eb 18 55 48 89 e5 57 <00> 70 07 00 00 77 00 00 41 52 41 53 e8 eb d5 f5 06 eb 00 41 5b 41
RSP: 0018:ffffc900181e95a0 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1308b20
RDX: dffffc0000000000 RSI: ffffffff89bd6980 RDI: 0000000000000082
RBP: ffffc900181e95a8 R08:
Lost 683 message(s)!
---[ end trace 02af37d385ae66aa ]---
RIP: 0010:trace_hardirqs_off+0x8/0x210 kernel/trace/trace_preemptirq.c:76
Code: 1e 45 3a 00 e9 33 ff ff ff 48 89 df e8 11 45 3a 00 e9 fe fe ff ff 66 90 66 2e 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55 53 <e8> f3 3e fa ff 48 8b 7c 24 28 e8 09 90 7a 06 65 8b 1d 62 f9 88 7e
RSP: 0018:ffffc900181e8000 EFLAGS: 00010046
RAX: ffff88803dad05c0 RBX: 0000000000000000 RCX: ffffc900139ec000
RDX: 0000000000040000 RSI: ffffffff81341b7f RDI: ffffc900181e8068
RBP: ffffc900181e8068 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000002 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0063) knlGS:00000000f5570b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffffc900181e7ff8 CR3: 000000003af1b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

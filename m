Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F20C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA8D20747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgDHKIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:08:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:32930 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgDHKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:08:14 -0400
Received: by mail-io1-f72.google.com with SMTP id i142so5394024ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 03:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sDE8UAXixJE4mIwim/uHNDvmz/DBy3TiHFyh8gBD/yA=;
        b=k0kG/buqz4VEOrySCuz/SCVYwRiPlwO5t0diER9ZGrShIW2sVySibHAzCI5cSB7ixw
         ezAjArHxFqpkCRtfIHI05Geyhyg0Y3fPKtwlczK2SjcGdspExocvqup4bGXt9krdPp/0
         02mlwX3bU+TGFoQ/z0aY9pgbGh3eLcAdMXVW7Q01Wuw5fNk3/hhzn8UIFi6Gemt23UK0
         xG5ROk4/AN9xiJK5+jgUrgaBzecmNGd8eZOgkxJCSUVpFn9aFwplmuxmtmtGENAb4rck
         3XRPPjj4aWlXjtaQdmU1jgzHLwHLkIWqMT7MS4kCsGTXOGss/ve2MVRld8oYPR/C/cUl
         7TkQ==
X-Gm-Message-State: AGi0PuaHL3INNQQLKHALdg39anhC30KrecKoCbqlyc9hxhx1TbNylU4e
        nyFX+Nd7x3GPRtdkLHBbY7YliN1j9BpwUNTSTjbEMAtRONER
X-Google-Smtp-Source: APiQypLTCuFCej5URU9/T8PVO7bV2QMVhF3uPZdkwIG68T3wT8WH6lJEiKJhRmm1w3+d0VZPvESyf8d11TUJKQviQObbkUW29eUp
MIME-Version: 1.0
X-Received: by 2002:a92:5b17:: with SMTP id p23mr6952646ilb.121.1586340491839;
 Wed, 08 Apr 2020 03:08:11 -0700 (PDT)
Date:   Wed, 08 Apr 2020 03:08:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008250f105a2c4ade1@google.com>
Subject: general protection fault in get_futex_key
From:   syzbot <syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        dvhart@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterx@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    763dede1 Merge tag 'for-linus-5.7-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136a055de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
dashboard link: https://syzkaller.appspot.com/bug?extid=a95c7753605c9d219466
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1578287de00000

The bug was bisected to:

commit 4426e945df588f2878affddf88a51259200f7e29
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Apr 2 04:08:49 2020 +0000

    mm/gup: allow VM_FAULT_RETRY for multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1707878fe00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1487878fe00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1087878fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a95c7753605c9d219466@syzkaller.appspotmail.com
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 8869 Comm: syz-executor.1 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:174 [inline]
RIP: 0010:get_futex_key+0x2cd/0x1670 kernel/futex.c:574
Code: 0b 00 31 ff 89 ee e8 e2 81 0b 00 85 ed 0f 88 65 10 00 00 e8 65 80 0b 00 4c 8b 74 24 60 49 8d 46 08 48 89 44 24 10 48 c1 e8 03 <80> 3c 18 00 0f 85 5d 11 00 00 4d 8b 66 08 31 ff 4c 89 f5 4d 89 e5
RSP: 0018:ffffc90005be78f0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: dffffc0000000000 RCX: ffffffff8167b0fe
RDX: 0000000000000000 RSI: ffffffff8167b10b RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff8880a15185c0 R09: ffffed10142a30b9
R10: ffff8880a15185c7 R11: ffffed10142a30b8 R12: ffffc90005be7950
R13: 0000000000000000 R14: 0000000000000008 R15: 000000002000c000
FS:  00007fe0f408b700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0f4006db8 CR3: 00000000930c4000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 futex_lock_pi+0x19b/0x840 kernel/futex.c:2823
 do_futex+0xa14/0x1ad0 kernel/futex.c:3821
 __do_sys_futex kernel/futex.c:3869 [inline]
 __se_sys_futex kernel/futex.c:3837 [inline]
 __x64_sys_futex+0x376/0x4f0 kernel/futex.c:3837
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe0f408ac78 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fe0f408b6d4 RCX: 000000000045c889
RDX: 0000000000000000 RSI: 0000800000000006 RDI: 000000002000cffc
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000000e8 R14: 00000000004c3730 R15: 000000000076bf0c
Modules linked in:
---[ end trace d1f294da398e534e ]---
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:compound_head include/linux/page-flags.h:174 [inline]
RIP: 0010:get_futex_key+0x2cd/0x1670 kernel/futex.c:574
Code: 0b 00 31 ff 89 ee e8 e2 81 0b 00 85 ed 0f 88 65 10 00 00 e8 65 80 0b 00 4c 8b 74 24 60 49 8d 46 08 48 89 44 24 10 48 c1 e8 03 <80> 3c 18 00 0f 85 5d 11 00 00 4d 8b 66 08 31 ff 4c 89 f5 4d 89 e5
RSP: 0018:ffffc90005be78f0 EFLAGS: 00010202
RAX: 0000000000000002 RBX: dffffc0000000000 RCX: ffffffff8167b0fe
RDX: 0000000000000000 RSI: ffffffff8167b10b RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff8880a15185c0 R09: ffffed10142a30b9
R10: ffff8880a15185c7 R11: ffffed10142a30b8 R12: ffffc90005be7950
R13: 0000000000000000 R14: 0000000000000008 R15: 000000002000c000
FS:  00007fe0f408b700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37738be000 CR3: 00000000930c4000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

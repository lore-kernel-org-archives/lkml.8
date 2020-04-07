Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC2EC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAEB2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgDGUQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:16:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51170 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgDGUQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:16:13 -0400
Received: by mail-il1-f198.google.com with SMTP id c9so4437972ill.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=w1JdwZ4JTK2zSFzQ0+SLaEq0GpOjTdWhLLcQfpdtjGc=;
        b=B65tVB48g7vlMyiClS0woKvXHjA6oim2hhfbwXqCIH45XIS0FYkyM+xwvhCxyBSo07
         NHChrSVLlA025QF1qOEd8GMqjo5oSjlLomHy0laxuiZFS3G/i4XLuLdzsOEGipTf0PS5
         s/cHYBY0Dc69eRWnks2BozVwMBw4Bp9kRQoloHYxuyHmCBXBpqc9kGLaESY4wtRG2vdy
         svoKDCWw1UqrCoT4EbJlZQpfL2CMlgO/7uFSj0oYk5Gh1HEq17E4uAyCLZnYK3totFQS
         CamfLOU8tKeHG+UMgQlI05/kW4DWzBOgXNLKwCaqOX0XL2tIWuItfxLRvJSIAyjvgW6Z
         /x8g==
X-Gm-Message-State: AGi0PubMT1IF2A9WjtS4rgvWY7nPw26bOQzWzWQqMTG59Lz45tbEfHKE
        +GImC6HKCLWvz0zYIFGG/3Wrv11mOK4FgsLgfqe3iz60UTyd
X-Google-Smtp-Source: APiQypL1eqW6t1zwOt7p93wu/ZHxWxgjH5FONjXCECWPw7Wgj3k5CWMqKvMJkAZIHkQVgN/RktRUFxKfCJLlbZ0UoG5HvNt/cEd8
MIME-Version: 1.0
X-Received: by 2002:a02:2b11:: with SMTP id h17mr3539418jaa.140.1586290571459;
 Tue, 07 Apr 2020 13:16:11 -0700 (PDT)
Date:   Tue, 07 Apr 2020 13:16:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005c65d05a2b90e70@google.com>
Subject: WARNING: bad unlock balance in __get_user_pages_remote
From:   syzbot <syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169498ede00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
dashboard link: https://syzkaller.appspot.com/bug?extid=a8c70b7f3579fc0587dc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a41543e00000

The bug was bisected to:

commit 71335f37c5e8ec9225285206f7f875057b9737ad
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Apr 2 04:08:53 2020 +0000

    mm/gup: allow to react to fatal signals

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17dba9b3e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=143ba9b3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=103ba9b3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a8c70b7f3579fc0587dc@syzkaller.appspotmail.com
Fixes: 71335f37c5e8 ("mm/gup: allow to react to fatal signals")

=====================================
WARNING: bad unlock balance detected!
5.6.0-syzkaller #0 Not tainted
-------------------------------------
syz-executor.0/8429 is trying to release lock (&mm->mmap_sem) at:
[<ffffffff819fbf60>] __get_user_pages_locked mm/gup.c:1366 [inline]
[<ffffffff819fbf60>] __get_user_pages_remote mm/gup.c:1831 [inline]
[<ffffffff819fbf60>] __get_user_pages_remote+0x540/0x740 mm/gup.c:1806
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz-executor.0/8429.

stack backtrace:
CPU: 0 PID: 8429 Comm: syz-executor.0 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __lock_release kernel/locking/lockdep.c:4633 [inline]
 lock_release+0x586/0x800 kernel/locking/lockdep.c:4941
 up_read+0x79/0x750 kernel/locking/rwsem.c:1573
 __get_user_pages_locked mm/gup.c:1366 [inline]
 __get_user_pages_remote mm/gup.c:1831 [inline]
 __get_user_pages_remote+0x540/0x740 mm/gup.c:1806
 pin_user_pages_remote+0x67/0xa0 mm/gup.c:2897
 process_vm_rw_single_vec mm/process_vm_access.c:108 [inline]
 process_vm_rw_core.isra.0+0x423/0x940 mm/process_vm_access.c:218
 process_vm_rw+0x21f/0x240 mm/process_vm_access.c:286
 __do_sys_process_vm_writev mm/process_vm_access.c:308 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __x64_sys_process_vm_writev+0xdf/0x1b0 mm/process_vm_access.c:303
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c879
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa1008bac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000137
RAX: ffffffffffffffda RBX: 00007fa1008bb6d4 RCX: 000000000045c879
RDX: 0000000000000001 RSI: 0000000020c22000 RDI: 0000000000000009
RBP: 000000000076bf00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000020c22fa0 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000085d R14: 00000000004cb1ee R15: 000000000076bf0c
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff888094028338, owner = 0x3, curr 0xffff888093cbc500, list empty
WARNING: CPU: 0 PID: 8429 at kernel/locking/rwsem.c:1435 __up_read kernel/locking/rwsem.c:1435 [inline]
WARNING: CPU: 0 PID: 8429 at kernel/locking/rwsem.c:1435 up_read+0x5f9/0x750 kernel/locking/rwsem.c:1574


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

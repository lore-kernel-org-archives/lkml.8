Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDF3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443A1207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDHBhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:37:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36852 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgDHBhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:37:17 -0400
Received: by mail-il1-f198.google.com with SMTP id e5so5297909ilg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iTgwp6BguOdJAZ/PeO1dtbonSopyEraPaAZfeMz81ms=;
        b=VFrsVh3zjtZUFquheLlUomAu/u0CKfcL9Vt/b2+H5jyvcIxMMaMF0UjrkeA+78dshH
         sG/uYRh4zX60bBHJJZo5aptDZeBG5FuaHwif8gYH0TV/zWUeI7ajig9rGK/kgs+bOmJF
         pj2KXtU3zt6un5PGEE+sRA6avUlYCe5k3Ykj9fRYAOaXr8aoeX085yB2Ia4EQ0Efx37i
         wL1CHC5+qRqlNoVMsDcFDLNXGiwaAWJROPo31WJazkuEmRJLZsn2YMlR5zc7gaxR7DQM
         CHRBRyWnmdvcjbOX+OFCtIIbz42wyM7sTYxKU5WlSg9KqzizVfdfzjDWuOiugzChsD1g
         Rjlg==
X-Gm-Message-State: AGi0PuZP8FzuAWbNyWwfNl3QG0jZtZcWD1I/BCyui3wiQTiYup4fxXSo
        qjcHYgg1NCCh12aiFGcYy9ZL4n9IN1Mtg31Yx0wgu2j4OtK4
X-Google-Smtp-Source: APiQypJoZ+PLIMyU+FBlf/9o4hbRkZbgCiJpClZPLiVFx5BXXXgRP+Xs4zPCgzyN+hW9Ww8pJkEV2/pevvcAba6PfBQUlo7EPwTK
MIME-Version: 1.0
X-Received: by 2002:a92:8659:: with SMTP id g86mr5656827ild.267.1586309835938;
 Tue, 07 Apr 2020 18:37:15 -0700 (PDT)
Date:   Tue, 07 Apr 2020 18:37:15 -0700
In-Reply-To: <00000000000005c65d05a2b90e70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046629905a2bd8acc@google.com>
Subject: Re: WARNING: bad unlock balance in __get_user_pages_remote
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    763dede1 Merge tag 'for-linus-5.7-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17731b0be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
dashboard link: https://syzkaller.appspot.com/bug?extid=a8c70b7f3579fc0587dc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135855cde00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149ea07de00000

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
syz-executor151/7052 is trying to release lock (&mm->mmap_sem) at:
[<ffffffff819fbf60>] __get_user_pages_locked mm/gup.c:1366 [inline]
[<ffffffff819fbf60>] __get_user_pages_remote mm/gup.c:1831 [inline]
[<ffffffff819fbf60>] __get_user_pages_remote+0x540/0x740 mm/gup.c:1806
but there are no more locks to release!

other info that might help us debug this:
no locks held by syz-executor151/7052.

stack backtrace:
CPU: 0 PID: 7052 Comm: syz-executor151 Not tainted 5.6.0-syzkaller #0
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
 compat_process_vm_rw+0x21f/0x240 mm/process_vm_access.c:343
 __do_compat_sys_process_vm_writev mm/process_vm_access.c:370 [inline]
 __se_compat_sys_process_vm_writev mm/process_vm_access.c:363 [inline]
 __ia32_compat_sys_process_vm_writev+0xdc/0x1b0 mm/process_vm_access.c:363
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(tmp < 0): count = 0xffffffffffffff00, magic = 0xffff88809e2392f8, owner = 0x3, curr 0xffff88809a6c6240, list empty
WARNING: CPU: 1 PID: 7052 at kernel/locking/rwsem.c:1435 __up_read kernel/locking/rwsem.c:1435 [inline]
WARNING: CPU: 1 PID: 7052 at kernel/locking/rwsem.c:1435 up_read+0x5f9/0x750 kernel/locking/rwsem.c:1574


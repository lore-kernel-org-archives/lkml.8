Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6413AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA25206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGWWDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:03:24 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48659 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgGWWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:03:24 -0400
Received: by mail-il1-f198.google.com with SMTP id x7so2401142ilq.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 15:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3R4v7a0s+fXHhfnujss39gumau1Flr8GA0VzFpChpiE=;
        b=pKPbI6ls75sCJ30YCxlbHS8v6M9vz+6ZdI35e4+kY00w0UDtdW2V6min0+V5rZCEcj
         oYEo/8l7IqRVCk964raxWVh/OPlSmd/GrK8WqGlzf49o9hDX2BKNdG+OZUYLSfXXNHcp
         g1vt4s44hI1pPYh5p5ExjmrBuzKi5ucKclPDDrg0qjRyv809ITWcOGP/B6q+wTvBGBaB
         ZYMuazc/eKH7hEMYBDgF3E9ik5qTxn2femAPtIDAESptvYmUHVr8VvG3sgNiMY/wdE54
         6AqVAnzpqjEPFvsu3NJiHEsOQ/YSjf5IZkkfyN2scSqa/b5p8fyFCqEJs/JGzKd1KCpU
         33zw==
X-Gm-Message-State: AOAM532JGL/hMC1XTQMOW1clb3s/O2nudVvAJHaVBjQnvXs+TobrXfWN
        OP9fIavqEDO7C3BhYRPT62piKz6oRtimFdgGaoh0uF9VDZr7
X-Google-Smtp-Source: ABdhPJyBMvQ6j5vVkHzGepxwiQ+2lKqVm9VkpnnEk+gAlZ0PLAjzrxly6DbiGZxmCaXRrseePK/b1ke+7kiEHaa9tWy7DUTaAMDv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:118:: with SMTP id x24mr7346678jao.48.1595541803314;
 Thu, 23 Jul 2020 15:03:23 -0700 (PDT)
Date:   Thu, 23 Jul 2020 15:03:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069316005ab2306cc@google.com>
Subject: WARNING in ptrace_stop
From:   syzbot <syzbot+e7a125aff38791d8cb65@syzkaller.appspotmail.com>
To:     christian@brauner.io, davej@codemonkey.org.uk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        liuzhiqiang26@huawei.com, oleg@redhat.com,
        paul.gortmaker@windriver.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92188b41 Merge tag 'perf-tools-fixes-2020-07-19' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173963eb100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a160d1053fc89af5
dashboard link: https://syzkaller.appspot.com/bug?extid=e7a125aff38791d8cb65
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178d6017100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688add7100000

The issue was bisected to:

commit dbfb089d360b1cc623c51a2c7cf9b99eff78e0e7
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Fri Jul 3 10:40:33 2020 +0000

    sched: Fix loadavg accounting race

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e3af6f100000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e3af6f100000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e3af6f100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7a125aff38791d8cb65@syzkaller.appspotmail.com
Fixes: dbfb089d360b ("sched: Fix loadavg accounting race")

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=8 set at [<00000000076362f5>] ptrace_stop+0x0/0x9e0 kernel/signal.c:2054
WARNING: CPU: 1 PID: 17054 at kernel/sched/core.c:6883 __might_sleep+0x135/0x190 kernel/sched/core.c:6883
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17054 Comm: syz-executor692 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:__might_sleep+0x135/0x190 kernel/sched/core.c:6883
Code: 65 48 8b 1c 25 00 ff 01 00 48 8d 7b 10 48 89 fe 48 c1 ee 03 80 3c 06 00 75 2b 48 8b 73 10 48 c7 c7 a0 3f 4b 88 e8 2d 1a f5 ff <0f> 0b e9 46 ff ff ff e8 3f 40 63 00 e9 29 ff ff ff e8 35 40 63 00
RSP: 0018:ffffc9000df87c78 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888095b30000 RCX: 0000000000000000
RDX: ffff888095b30000 RSI: ffffffff815d4eb7 RDI: fffff52001bf0f81
RBP: ffffffff884ab220 R08: 0000000000000001 R09: ffff8880ae7318e7
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000039
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888095b30488
 try_to_freeze_unsafe include/linux/freezer.h:57 [inline]
 try_to_freeze include/linux/freezer.h:67 [inline]
 freezer_count include/linux/freezer.h:128 [inline]
 freezable_schedule include/linux/freezer.h:173 [inline]
 ptrace_stop+0x4e2/0x9e0 kernel/signal.c:2215
 ptrace_signal kernel/signal.c:2490 [inline]
 get_signal+0xddc/0x1ee0 kernel/signal.c:2639
 do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop arch/x86/entry/common.c:235 [inline]
 __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441729
Code: Bad RIP value.
RSP: 002b:00007ffd1cbad2b8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 0000000000441729
RDX: 0000000080000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000017df84 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402420
R13: 00000000004024b0 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

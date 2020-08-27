Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE93C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D490720786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgH0H7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:36 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40258 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgH0H6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:58:16 -0400
Received: by mail-il1-f199.google.com with SMTP id z5so3600681ilp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hQQsbVV5DfwwY5C17HqiQeKaMF+p/UJ2oy2T9wCo46c=;
        b=L7CVCluUcXwHUCkybnX3Wa3Eohr9oj6zseJstsLWMBkcUp1E1oWuwawKDYRvkgeabW
         NLzVGzA8OMceIc4HdHvY2j3rdJcFiVmYllEb6KvQhk/80EuTUphpAtwiriKu4HDTNqYU
         KExG12PQ7xP0jFxGesErNvZoAk/1AyFhmT29FiIKESxD0YatDhZKxYFWf5xheSQN1NA6
         rwHNzM9hSfopDRWzPYHSdwe1AlNG+m9nMSjnF3lH2iVqZ/ccZGlIJCv3gH8OS+ip0qBF
         UQ/aMXfjNXci+UEMZG8z/zyb3UuPSgDOJncARdw5XzgEqx+kHsiueRKM3XBCbFMg+9ht
         IyFQ==
X-Gm-Message-State: AOAM531xoreOxabeyTJd3EBRmerSbnJ0HcX3qEsMUzdrZibZeWsP47CL
        4SIS6UqQJvaAQZrgirnVUECf0E5/PTd8Xo6DvPUAPF4H3maz
X-Google-Smtp-Source: ABdhPJzGeDwVWj3dpjeTIT+FiInDIT2gBGRlYXk3lc0O7o26ZMeM4q3Hcna5bvcRYc5FckZXtI2yWdI4t4Jm8W0U/5B141qWw9ye
MIME-Version: 1.0
X-Received: by 2002:a92:6a0c:: with SMTP id f12mr15351925ilc.213.1598515095022;
 Thu, 27 Aug 2020 00:58:15 -0700 (PDT)
Date:   Thu, 27 Aug 2020 00:58:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068340d05add74c29@google.com>
Subject: WARNING: ODEBUG bug in get_signal
From:   syzbot <syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-kernel@vger.kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1566d8fe900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=e3cf8f93cf86936710db
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13236eb6900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 7108 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7108 Comm: syz-executor.0 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
Code: dd e0 26 94 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd e0 26 94 88 48 c7 c7 40 1c 94 88 e8 d2 36 a6 fd <0f> 0b 83 05 93 4f 13 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc900068a7b80 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888090f64140 RSI: ffffffff815dafc7 RDI: fffff52000d14f62
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae720f8b
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89bd6780
R13: 0000000000000000 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
 debug_check_no_obj_freed+0x301/0x41c lib/debugobjects.c:998
 kmem_cache_free.part.0+0x16d/0x1f0 mm/slab.c:3692
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 get_signal+0xd89/0x1f00 kernel/signal.c:2561
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x15d/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 __do_fast_syscall_32+0x63/0x80 arch/x86/entry/common.c:127
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f05549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f76ff0cc EFLAGS: 00000296 ORIG_RAX: 00000000000000ff
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000001
RDX: 0000000000000006 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

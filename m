Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B2C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 10:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED9F2078D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 10:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIEKTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 06:19:18 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:40297 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIEKTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 06:19:17 -0400
Received: by mail-il1-f206.google.com with SMTP id g188so6616292ilh.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 03:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GWAPgDl1Yp+MfyidDl3LA075MQZh10s6UdDj+bD6ovY=;
        b=ZYXytYgGdFaD4j0il2HwZ3uJBfzrj32u3+SLUVWZ/56z3XplrENWXiFdumoCIYFkeq
         zp6Y5zUPdDCF7FEnP55r81CnsHn/05Gtk8SCxcaEMtbMOp7w10VXDOX8b/LA6NAITZ7G
         BEb6eI4y/ODJgsVl4BKR8lT2otnccch41yqQaKn9F4rOYXaJPV+fP8CTlWd2aDl3XX7C
         yMstxaYOngM4aDIsxO+3JlsDSkwKjr7Zs8T28WZfcK9Ro16Kx53ny6CG4ITV3lEE7tCj
         UozgoW+mU+MH3ww0VyS8kBgqw34oPWZ2MEVPdrMBZT4++vO5xCdDmw+lx1+qLBGfORyG
         q3Rw==
X-Gm-Message-State: AOAM5300z2cpXCDHIVa9n3C5uDrmj7ADlkDsDJrxbkdiVXuOFpXC7kd0
        DarE5+bBqQ+0kwJncCsqiJQib0+i7BEAANkou200BKqXPj3w
X-Google-Smtp-Source: ABdhPJwv+ztP8SU4QKZLmiry/mgsvq5+A6E0DaTBE+e8UOTh9rljjXQoMn+E+sb7S0OoX/BAPLHIPFpL/WYaQbk0Q5trh1MhAXor
MIME-Version: 1.0
X-Received: by 2002:a02:c8c8:: with SMTP id q8mr11605456jao.46.1599301156234;
 Sat, 05 Sep 2020 03:19:16 -0700 (PDT)
Date:   Sat, 05 Sep 2020 03:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e6a0b05ae8e5179@google.com>
Subject: INFO: trying to register non-static key in unmap_page_range
From:   syzbot <syzbot+1c2be5d844dee3f85c32@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b51594df Merge tag 'docs-5.9-3' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148e7656900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=1c2be5d844dee3f85c32
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c2be5d844dee3f85c32@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 21186 Comm: syz-executor.1 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0xf9/0x5570 kernel/locking/lockdep.c:4305
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 zap_pte_range mm/memory.c:1049 [inline]
 zap_pmd_range mm/memory.c:1195 [inline]
 zap_pud_range mm/memory.c:1224 [inline]
 zap_p4d_range mm/memory.c:1245 [inline]
 unmap_page_range+0xa74/0x2b20 mm/memory.c:1266
 unmap_single_vma+0x198/0x300 mm/memory.c:1311
 unmap_vmas+0x168/0x2e0 mm/memory.c:1343
 exit_mmap+0x2b1/0x530 mm/mmap.c:3183
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007ff293e13c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: 0000000000001000 RBX: 0000000000038900 RCX: 000000000045d5b9
RDX: 0000000000001058 RSI: 0000000020001440 RDI: 0000000000000004
RBP: 000000000118d020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 000000000169fb6f R14: 00007ff293e149c0 R15: 000000000118cfec


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

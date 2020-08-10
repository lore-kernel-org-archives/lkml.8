Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13192070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgHJLg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:36:27 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38106 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgHJLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:36:26 -0400
Received: by mail-io1-f69.google.com with SMTP id e73so909918iof.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 04:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TIxOf1Tf6BsOdnD/hs/2ERCEHWfwJ12vftxSvMX9nNo=;
        b=U0IgdNS9grEJpZ3iZ1tN99YNVAOcl8yy3pWnva7oPgF2fFYMeI3YQ4HpCxn1bLduja
         HfzzrO9ueBwtO25MLHs/kcAZ7p4qh8PCvx/agCRGrGHixNkzhAhUouBMsrlXyGijSXKx
         Oc/xKMwJPopy527ZposTXI4KP09nPhLWvBQfEAsWV54qMyBjaNxL5bBuL2slU7QXG2dn
         fi8bkHcq2GLwkdvWRJXnAI+NNA3HHvRvrM7MLMq1sSyxwDA+JW/FpPkHp2lSb4BnUKNb
         LJdIV+tCi1yz+1uVxcBy1f11040MchoOQdL+qYP9WMgdn+ePXayDhzzebo77FkdQmc4p
         qRJQ==
X-Gm-Message-State: AOAM533hDOp6/DLrvkEXlqKBLkm/lsKsphOYd1TGfE3cU7bRJFiFpX1r
        7KT/R17tpem2/OVRHPuTYduzJHNGU8+561K2hKuMKxU/sTrA
X-Google-Smtp-Source: ABdhPJzKsuv+jSFxCNAg+dPQCFRhFehVFF1ufCqQZ5+mFzkf/2ms76No9uqdMJ54t7ZFfpR2SuIbcL6Su5JC+mISTp49KobtgLw8
MIME-Version: 1.0
X-Received: by 2002:a92:98c8:: with SMTP id a69mr2396270ill.0.1597059385300;
 Mon, 10 Aug 2020 04:36:25 -0700 (PDT)
Date:   Mon, 10 Aug 2020 04:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000589ccd05ac845d6e@google.com>
Subject: WARNING in slab_pre_alloc_hook
From:   syzbot <syzbot+c2c3302f9c601a4b1be2@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    449dc8c9 Merge tag 'for-v5.9' of git://git.kernel.org/pub/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16581652900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ef84fa8ee48e528
dashboard link: https://syzkaller.appspot.com/bug?extid=c2c3302f9c601a4b1be2
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e8de34900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1244eb62900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2c3302f9c601a4b1be2@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at [<00000000370c7c68>] prepare_to_wait+0xb1/0x2a0 kernel/sched/wait.c:247
WARNING: CPU: 1 PID: 340 at kernel/sched/core.c:7253 __might_sleep+0x135/0x190 kernel/sched/core.c:7253
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 340 Comm: syz-executor677 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:231
 __warn.cold+0x20/0x50 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x41/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:__might_sleep+0x135/0x190 kernel/sched/core.c:7253
Code: 65 48 8b 1c 25 40 ef 01 00 48 8d 7b 10 48 89 fe 48 c1 ee 03 80 3c 06 00 75 2b 48 8b 73 10 48 c7 c7 e0 9e 06 86 e8 ed 12 f6 ff <0f> 0b e9 46 ff ff ff e8 1f b2 4b 00 e9 29 ff ff ff e8 15 b2 4b 00
RSP: 0018:ffff8881cdb77a28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8881c6458000 RCX: 0000000000000000
RDX: ffff8881c6458000 RSI: ffffffff8129ec93 RDI: ffffed1039b6ef37
RBP: ffffffff86fdade2 R08: 0000000000000001 R09: ffff8881db32f54f
R10: 0000000000000000 R11: 0000000030343354 R12: 00000000000001f2
R13: 0000000000000000 R14: 0000000000000068 R15: ffffffff83c1b1aa
 slab_pre_alloc_hook.constprop.0+0xea/0x200 mm/slab.h:498
 slab_alloc_node mm/slub.c:2816 [inline]
 slab_alloc mm/slub.c:2900 [inline]
 kmem_cache_alloc_trace+0x46/0x220 mm/slub.c:2917
 kmalloc include/linux/slab.h:554 [inline]
 dummy_urb_enqueue+0x7a/0x880 drivers/usb/gadget/udc/dummy_hcd.c:1251
 usb_hcd_submit_urb+0x2b2/0x22d0 drivers/usb/core/hcd.c:1547
 usb_submit_urb+0xb4e/0x13e0 drivers/usb/core/urb.c:570
 yurex_write+0x3ea/0x820 drivers/usb/misc/yurex.c:495
 vfs_write+0x2b0/0x730 fs/read_write.c:576
 ksys_write+0x12d/0x250 fs/read_write.c:631
 do_syscall_64+0x2d/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444809
Code: e8 bc af 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b d7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc4c2b1358 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444809
RDX: 00000000000000cb RSI: 0000000020000300 RDI: 0000000000000004
RBP: 00000000006cf018 R08: 000000000000000f R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402430
R13: 00000000004024c0 R14: 0000000000000000 R15: 0000000000000000
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

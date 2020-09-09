Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2349C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 705A621556
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIIATU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:19:20 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:40054 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgIIATS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 20:19:18 -0400
Received: by mail-il1-f205.google.com with SMTP id g188so767396ilh.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 17:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3hFNhuwHSPIPBIOlcnTYPFJp9i+qgW8XJEWKfOsjOz4=;
        b=EiwMjwSz1g9DLfv3gNATO6bY9YFggMXGAxiR1IOdEdhstAg9Rku2gyzKOVzr+aD5yp
         +zNjPWGNhWyWdw9y3+zG/jlf0VNzGZGUbqUncQoJSRSOxatNHdET8ZaiGP7eTY9Db3is
         Y/Tu3I0pA5CdhcbYJaoMhPR4TYh/tJtP6CkUtn7wfCtp4Np0qL37fViilet/1esdGdMS
         feUTqpdlfRyboT6+xCEavZ8pipqIOOHAzHYQ7G8Z+y+BNBj5BC0Oe8WXRedO+D2dPpeQ
         mjqox12TQJDSNByz6yOSp1JRtanVpMa+ePIEbOYJOpx1lvc6hImuHXoWgh4CZsZWI+qh
         zV7A==
X-Gm-Message-State: AOAM532p6+nmCpEBafxs5F0i7NfSyLzliu60LPt6ImykmBopNRmRHm4G
        AzPPmIHu4f/fV+pfBQWnqTL1BOBM4vRIJhiNnWvg7uxXPDHv
X-Google-Smtp-Source: ABdhPJxXX65q1CaKSofPWywleeOKt1VSBDbfouD7Lzok6jAVFzEklQ1/DOIQS8Ditfql8KFQA7dFTaIjT+90+gazisgiaqLPe+tw
MIME-Version: 1.0
X-Received: by 2002:a92:5bda:: with SMTP id c87mr1359737ilg.202.1599610757280;
 Tue, 08 Sep 2020 17:19:17 -0700 (PDT)
Date:   Tue, 08 Sep 2020 17:19:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7793505aed666dc@google.com>
Subject: general protection fault in unlink_file_vma
From:   syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1166cb5d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=c5d5a51dcbb558ca0cb5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11901e95900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f56195900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1205faed900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1105faed900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1605faed900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x00777770000001d8-0x00777770000001df]
CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:unlink_file_vma+0x57/0xb0 mm/mmap.c:164
Code: 4c 8b a5 a0 00 00 00 4d 85 e4 74 4e e8 92 d7 cd ff 49 8d bc 24 d8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3d 4d 8b b4 24 d8 01 00 00 4d 8d 6e 78 4c 89 ef e8
RSP: 0018:ffffc9000ac0f9b0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88800010ceb0 RCX: ffffffff81592421
RDX: 000eeeee0000003b RSI: ffffffff81a6736e RDI: 00777770000001d8
RBP: ffff88800010ceb0 R08: 0000000000000001 R09: ffff88801291a50f
R10: ffffed10025234a1 R11: 0000000000000001 R12: 0077777000000000
R13: 00007f1eea0da000 R14: 00007f1eea0d9000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1eea11a9d0 CR3: 000000000007e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_pgtables+0x1b3/0x2f0 mm/memory.c:415
 exit_mmap+0x2c0/0x530 mm/mmap.c:3184
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
RIP: 0033:0x446ad9
Code: Bad RIP value.
RSP: 002b:00007f1eea0f8d18 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00000000006dbc58 RCX: 0000000000446ad9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00000000006dbc58
RBP: 00000000006dbc50 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007f1eea0f8d20 R14: 00007f1eea0f8d20 R15: 20c49ba5e353f7cf
Modules linked in:
---[ end trace 22e4d2773b69c9b0 ]---
RIP: 0010:unlink_file_vma+0x57/0xb0 mm/mmap.c:164
Code: 4c 8b a5 a0 00 00 00 4d 85 e4 74 4e e8 92 d7 cd ff 49 8d bc 24 d8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3d 4d 8b b4 24 d8 01 00 00 4d 8d 6e 78 4c 89 ef e8
RSP: 0018:ffffc9000ac0f9b0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88800010ceb0 RCX: ffffffff81592421
RDX: 000eeeee0000003b RSI: ffffffff81a6736e RDI: 00777770000001d8
RBP: ffff88800010ceb0 R08: 0000000000000001 R09: ffff88801291a50f
R10: ffffed10025234a1 R11: 0000000000000001 R12: 0077777000000000
R13: 00007f1eea0da000 R14: 00007f1eea0d9000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1eea11a9d0 CR3: 000000000007e000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

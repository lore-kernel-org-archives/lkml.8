Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E4C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5343A207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgGMHDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:03:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33882 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:03:18 -0400
Received: by mail-il1-f197.google.com with SMTP id y3so8980037ily.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 00:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KD15X37m756ZChXtUhrOQbYYuakKjDsUF1XkjQP+5KM=;
        b=X43TX/1oCt+NXCdPjUKcTEwfvg5ILEkvF0qxBE/qszB1OBV1OnvJnK4iF2HAK6ZAWn
         lhrye6nbSjIP5jt+oMKH0ItD5/1lGKN4yelu70vXWpZUvxZhozyPhAv+Gg2zmfszhNFa
         chBy3Mg++RPSCoWIaTIHnyDl8a2+RIhju65ABD28c31axpmFL3anWc8NGsEOiEcNtIr7
         7f8ePZvcXR4OWKF/2L493p2vMapJ6GkcLQky/wfTs/6vIVxTLRWa/EbQWyI4QxhbNOQI
         9sn9j3B4ry+I5fGXfkRPx3QRxgbCFPCkGlUkALFuCZ+23tGRfa+qOApdhphHf1tgI98P
         s8VA==
X-Gm-Message-State: AOAM531oTQlewqMLhTt1RZj00mnkJxYcGxHnjmhNKxIju0M/cCbNUkaF
        +FG95H3Fvo1tc8c+bXYe/8NiRMAq5Dx1cu4XGNgl1JLZfqBH
X-Google-Smtp-Source: ABdhPJzop0Dy3ZGGkSXYIfaSOmUyzQVlKE4OVcZsK749AG3YpsJSMEsEvcagNK/OogHlBTRBce2bBll2UnZrLFBvmJm3hPMl6pnG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c21:: with SMTP id q1mr13551490ilg.28.1594623797742;
 Mon, 13 Jul 2020 00:03:17 -0700 (PDT)
Date:   Mon, 13 Jul 2020 00:03:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003d32b05aa4d493c@google.com>
Subject: WARNING in __kernel_read
From:   syzbot <syzbot+d012ca3f813739c37c25@syzkaller.appspotmail.com>
To:     hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a581387e Merge tag 'io_uring-5.8-2020-07-10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e730eb100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66ad203c2bb6d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=d012ca3f813739c37c25
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e0222b100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162a004f100000

The bug was bisected to:

commit 6209dd9132e8ea5545cffc84483841e88ea8cc5b
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri May 8 07:00:28 2020 +0000

    fs: implement kernel_read using __kernel_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152d91fb100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172d91fb100000
console output: https://syzkaller.appspot.com/x/log.txt?x=132d91fb100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d012ca3f813739c37c25@syzkaller.appspotmail.com
Fixes: 6209dd9132e8 ("fs: implement kernel_read using __kernel_read")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5 at fs/read_write.c:427 __kernel_read+0x41d/0x4d0 fs/read_write.c:427
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.8.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events p9_read_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:542
RIP: 0010:__kernel_read+0x41d/0x4d0 fs/read_write.c:427
Code: fd ff ff e8 75 19 b6 ff 45 31 c9 45 31 c0 b9 01 00 00 00 4c 89 f2 89 ee 4c 89 ef e8 5d 22 12 00 e9 46 ff ff ff e8 53 19 b6 ff <0f> 0b 49 c7 c4 ea ff ff ff e9 11 fe ff ff 4c 89 f7 e8 2d 76 f5 ff
RSP: 0018:ffffc90000cbfbc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880a9786ac0 RCX: ffffffff81bd9ac4
RDX: ffff8880a95a2140 RSI: ffffffff81bd9e3d RDI: 0000000000000005
RBP: ffff888096bc8060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffffffff1829bdd R12: 00000000081d801e
R13: ffffc90000cbfc98 R14: ffff8880a9786b44 R15: 0000000000000007
 kernel_read+0x52/0x70 fs/read_write.c:457
 p9_fd_read net/9p/trans_fd.c:263 [inline]
 p9_read_work+0x2ac/0xff0 net/9p/trans_fd.c:298
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

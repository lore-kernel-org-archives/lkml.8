Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5980E22B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHDShW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:37:22 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:51831 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHDShV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:37:21 -0400
Received: by mail-il1-f198.google.com with SMTP id c84so7299751ila.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bhNxCbYIiHdcxFtB1HTGVZeALlo8/4Mcpz/5QGpL8oM=;
        b=VhrBn799SGtATv/4R1mhIxLHVmjn0Y23t3XzyIYa/NRW6LpGYvMh0b2ldTHE4Qi6g4
         64zmRmI7vksbu6Mqz9XkZQYzwoWZkEWU6pckqLXj9KgkwIbK7HNOzyAoySPHiNZ19zbR
         xa6f6aXzEz0Ca2ekkCqYj2iR7z0Sy/jnCLj2N4rnMCkNEs8B37bLjKg+9y8cbj2hNBKL
         Z9Hpkvea2D4U3OsUdJ+pRW25OwhLx7tUSQ7CpqT3mZbzy4oca4SnsfPLpFRkKgV/zxYh
         RbFxn/wskc8j4GfbZbXX7s7RiJJ9v3L9MBNOQQk5ZnuBtWiB5gbkwnNhNuvOnU704utS
         fFaA==
X-Gm-Message-State: AOAM530TSVSLdAmMFHIfSPtGrBaUrR95z0gFx3UDiGihr03dyh6F3C1n
        C8uxA+BS0fachCfngJnAVolK5nxCz63C5xXL8SsW8NhtjPZO
X-Google-Smtp-Source: ABdhPJym6JWui/90G5OTJXqB2mSj1vcSzqN2zWrDMz1DCTmYkIJALzo2mfl5g2P/Fx4d/Rvq/npLFbS65fLNoE0x+MCSNOL36/L1
MIME-Version: 1.0
X-Received: by 2002:a5d:8744:: with SMTP id k4mr6420164iol.149.1596566240901;
 Tue, 04 Aug 2020 11:37:20 -0700 (PDT)
Date:   Tue, 04 Aug 2020 11:37:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a63c5f05ac118b29@google.com>
Subject: WARNING: ODEBUG bug in netdev_run_todo
From:   syzbot <syzbot+f9484b345f41843fc9a9@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d7403a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76cacb0fe58c4a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=f9484b345f41843fc9a9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1733e03a900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9484b345f41843fc9a9@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x80 arch/x86/include/asm/paravirt.h:770
WARNING: CPU: 0 PID: 6856 at lib/debugobjects.c:488 debug_print_object lib/debugobjects.c:485 [inline]
WARNING: CPU: 0 PID: 6856 at lib/debugobjects.c:488 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
WARNING: CPU: 0 PID: 6856 at lib/debugobjects.c:488 debug_check_no_obj_freed+0x45c/0x640 lib/debugobjects.c:998
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6856 Comm: kworker/u4:0 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:547
RIP: 0010:debug_print_object lib/debugobjects.c:485 [inline]
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
RIP: 0010:debug_check_no_obj_freed+0x45c/0x640 lib/debugobjects.c:998
Code: 74 08 4c 89 f7 e8 04 ce 12 fe 4d 8b 06 48 c7 c7 5f d3 14 89 48 c7 c6 f6 b1 12 89 48 89 da 89 e9 4d 89 f9 31 c0 e8 94 60 a5 fd <0f> 0b 48 ba 00 00 00 00 00 fc ff df ff 05 0e 8f ec 05 48 8b 5c 24
RSP: 0018:ffffc90001867a10 EFLAGS: 00010046
RAX: 480b12f763965400 RBX: ffffffff8918d390 RCX: ffff8880a7904580
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815e07c9 R09: ffffed1015d041c3
R10: ffffed1015d041c3 R11: 0000000000000000 R12: ffff888090ed4474
R13: ffffffff8ba62fe0 R14: ffffffff894eeca0 R15: ffffffff814c72d0
 kfree+0xfc/0x220 mm/slab.c:3756
 device_release+0x70/0x1a0 drivers/base/core.c:1575
 kobject_cleanup lib/kobject.c:693 [inline]
 kobject_release lib/kobject.c:722 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x15b/0x220 lib/kobject.c:739
 netdev_run_todo+0xb17/0xc90 net/core/dev.c:9797
 default_device_exit_batch+0x66a/0x6b0 net/core/dev.c:10597
 ops_exit_list net/core/net_namespace.c:189 [inline]
 cleanup_net+0x79c/0xba0 net/core/net_namespace.c:603
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
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

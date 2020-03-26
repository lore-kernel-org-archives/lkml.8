Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E44C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0453020719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgCZCYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:24:14 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45216 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgCZCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:24:13 -0400
Received: by mail-il1-f200.google.com with SMTP id p15so3947429ils.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 19:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SjP3ZWohidOk4VBAV6+GsmZ4385gJW3ruGw8Pm0jJ+g=;
        b=UsTlSJ/7LSVBKuIApBtSa6G8JJzE/HX+x2JWTSFy1KBB+SD/HSfztMYhsDP31/4krz
         Li7sfRlfQ3Q53KSeLT5FoCQD/w+e2v2RdCTZofkFH1dCEPvqLcsTeT6B6AnZnaS0BXtM
         bZnD+16+TOlagaZ3fHU1IniBo7fjAK2RmKqU5h0rL4DNDhBbakElOdQKvCE2/QK1vD8u
         eL+YLhqsoqkIAagVrF0h9v5sV9jv3pGzChKiwd5Q4UNs1ao4WwambtIsQpOW/yaESpw4
         2NQtYU2O9HD1Y9Gq95ZB/hkzITVBuyJO+ia8WGsbfHyvAtOpVvsio5RiuTxgwbr8v/9m
         jkKg==
X-Gm-Message-State: ANhLgQ2FGjjsTL5L7vjVj6mp4SLTIVmmwIhdjsjjl9o8bCtyxi1nmYk+
        nlJ5OtooEKHNsFaJmhn8tNhvabTZlXFempMoS7OckQtsgKhY
X-Google-Smtp-Source: ADFU+vs+7FNMIImcWRQYSL85l2e94sds7PPqNyGPwE1KtJq+ptRWMF8MUKYz+UzH4Crd2yzl2pUsilvnB8zt0ryf2Apfp8DpXWWG
MIME-Version: 1.0
X-Received: by 2002:a02:5ec2:: with SMTP id h185mr5609432jab.2.1585189451425;
 Wed, 25 Mar 2020 19:24:11 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:24:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000276fa005a1b8aeb5@google.com>
Subject: kernel panic: stack is corrupted in mpol_to_str
From:   syzbot <syzbot+b636fe4123f39f69c35b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e2cf67f6 Merge tag 'zonefs-5.6-rc7' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1217e987e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90791b5aec4dc636
dashboard link: https://syzkaller.appspot.com/bug?extid=b636fe4123f39f69c35b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16773d8de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1309b523e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b636fe4123f39f69c35b@syzkaller.appspotmail.com

Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: mpol_to_str+0x3ec/0x3f0 mm/mempolicy.c:2962
CPU: 1 PID: 1 Comm: systemd Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __stack_chk_fail+0x1c/0x20 kernel/panic.c:667
 mpol_to_str+0x3ec/0x3f0 mm/mempolicy.c:2962
 shmem_show_mpol mm/shmem.c:1406 [inline]
 shmem_show_options+0x3d9/0x4c0 mm/shmem.c:3609
 show_mountinfo+0x68d/0x790 fs/proc_namespace.c:187
 seq_read+0x9df/0xd20 fs/seq_file.c:268
 __vfs_read+0xa7/0x6f0 fs/read_write.c:425
 vfs_read+0x1c0/0x3f0 fs/read_write.c:461
 ksys_read+0x115/0x220 fs/read_write.c:587
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f83e3f3f92d
Code: 2d 2c 00 00 75 10 b8 00 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 de 9b 01 00 48 89 04 24 b8 00 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 27 9c 01 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffe6d4b18c0 EFLAGS: 00000293 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055840db5f6d0 RCX: 00007f83e3f3f92d
RDX: 0000000000000400 RSI: 000055840db5f900 RDI: 000000000000002b
RBP: 0000000000000d68 R08: 00007f83e5975500 R09: 00000000000000e0
R10: 000055840db5fce2 R11: 0000000000000293 R12: 00007f83e41fa440
R13: 00007f83e41f9900 R14: 000000000000001e R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

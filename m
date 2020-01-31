Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB53CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB8820CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgAaSPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:15:14 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:41261 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgAaSPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:15:13 -0500
Received: by mail-io1-f72.google.com with SMTP id z201so4702716iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EtfgqjvamVcUzscAKz2pX3HiHwy6oEdFj5wF22iueeo=;
        b=RRL1vXT2c4BH8dDfWFA6NIiGBJKeZknh94nQLJNg8NuQALBlYD9DDaDgDwEfaQ9CkL
         I3nydO8l6n4Z5E4CDVpO4gKlEwB2RhOSSHLK8X3WWSbMUrKpEQQ9jRosGE3JNZ53VvUl
         /E1SyaPzPPk/58rwrTD6ERAdlyXMoKAL/FbZZ1csUB2sUPZi3Pw13bp2IABwaB082+la
         cLt7ivWbJCsRqzmYbz8Ywl3HpC1Ch8SkOMTFN8vq5lUat14z7CVe5TMHdsTKYc+3/sxW
         2M/Y7guiZ8IO587H5H7Ki64gDvopTIaCTDQ4MXdtoumLd989RbTs/GOmduaNHW3ItnQb
         4RqA==
X-Gm-Message-State: APjAAAXQlviHjyO8IzjHKCbtNTaEwE+DV9xjv7/50yRWuLC10vfAczMm
        Oe1mCdQLjOgUYgs5yr+9AkqN8HyaETYpEiLMPlUGoMgsXvPQ
X-Google-Smtp-Source: APXvYqwaXOQNtr9ntbGLV2ag144bWsaUaXz+272JZZFU6/7J/VJj73WxByvVe3kCFiQ7AoxsKxn9ngH83fMOiIR2pZZGi5pJ1tK8
MIME-Version: 1.0
X-Received: by 2002:a5d:8448:: with SMTP id w8mr9699271ior.161.1580494512649;
 Fri, 31 Jan 2020 10:15:12 -0800 (PST)
Date:   Fri, 31 Jan 2020 10:15:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fef96d059d738dae@google.com>
Subject: WARNING: ODEBUG bug in process_one_work
From:   syzbot <syzbot+9affe13ceff50439d1be@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    39bed42d Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f498d9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2646535f8818ae25
dashboard link: https://syzkaller.appspot.com/bug?extid=9affe13ceff50439d1be
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9affe13ceff50439d1be@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: xprt_init_autodisconnect+0x0/0x160 net/sunrpc/xprt.c:1311
WARNING: CPU: 0 PID: 3067 at lib/debugobjects.c:485 debug_print_object+0x168/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 3067 Comm: kworker/0:57 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events kfree_rcu_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x3e kernel/panic.c:582
 report_bug+0x289/0x300 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:176 [inline]
 fixup_bug arch/x86/kernel/traps.c:171 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:269
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:288
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:debug_print_object+0x168/0x250 lib/debugobjects.c:485
Code: dd c0 74 91 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 00 00 00 48 8b 14 dd c0 74 91 88 48 c7 c7 20 6a 91 88 e8 17 ed a3 fd <0f> 0b 83 05 93 05 02 07 01 48 83 c4 20 5b 41 5c 41 5d 41 5e 5d c3
RSP: 0018:ffffc90008c1fbe0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e9806 RDI: fffff52001183f6e
RBP: ffffc90008c1fc20 R08: ffff88809e54c000 R09: ffffed1015d045c9
R10: ffffed1015d045c8 R11: ffff8880ae822e43 R12: 0000000000000001
R13: ffffffff89bb6760 R14: ffffffff816474a0 R15: ffff8880a839b9a0
 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
 debug_check_no_obj_freed+0x2d6/0x441 lib/debugobjects.c:998
 kfree+0xf8/0x2c0 mm/slab.c:3756
 kfree_rcu_work+0x145/0x230 kernel/rcu/tree.c:2761
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

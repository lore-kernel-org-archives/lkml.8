Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74618C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C3B20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgGJQoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:44:22 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47824 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgGJQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:44:22 -0400
Received: by mail-io1-f70.google.com with SMTP id s15so3951844iow.14
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VkWBimuMW8LfXvxvxg1C7asVbWSZFSw1leNLTE9Azsc=;
        b=lRYkasLnNJPMI/aHeJBjILl0Q02Ic7jGukr40BFYjc0SJ+DxyDw2ZV/73M4aQculNq
         2yaOVxJfxiJK4Q8yQHLy3LUdaaeYUI9xWVuNuIr5gGUZjqI3cnDvRnr1ry4VJylW9M22
         1KiIdef25Zn+E0gI/PndNUA285fjmtTApEfD3eY7nfleJZtMWdzjO0JNDlgFYC9WYL1t
         D5/JlVZ4nK3FdAc7F9IYipz8amht0Vk25I1H79vWSWNdXyL2cIj38hcCDDjkv2Niy3Gl
         VtIGox0OQ6Dc9I7h4nBK0WMSV9pxHHKVyDGO7UWgD+q3kfHkz17NyVDIhehSDnb1EQMM
         TvzA==
X-Gm-Message-State: AOAM530HGxZ9qXX24xtWkmrJE4X5hf1TpAmin2a/W76IjnUFaVBsQaJM
        xybugjT2i5/3n2fSF9oeSFj+vreoq0cJIrv0Zy1qWPP5J8O8
X-Google-Smtp-Source: ABdhPJzhNR4HR3NlOZEonl9yrFEnPo5OVu2MPdxbLp7PueG9CU6JgVvE1paTy8ZQFK/E4zcgJcgi6nFRPPJH5m8gEQo6a7iRiQ4h
MIME-Version: 1.0
X-Received: by 2002:a6b:bc41:: with SMTP id m62mr45978156iof.95.1594399461367;
 Fri, 10 Jul 2020 09:44:21 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:44:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008668d305aa190d58@google.com>
Subject: WARNING in kmem_cache_free_bulk
From:   syzbot <syzbot+c07ac923fbf6351f6063@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14258fe3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=c07ac923fbf6351f6063
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c07ac923fbf6351f6063@syzkaller.appspotmail.com

------------[ cut here ]------------
virt_to_cache: Object is not a Slab page!
WARNING: CPU: 1 PID: 8538 at mm/slab.h:475 virt_to_cache mm/slab.h:475 [inline]
WARNING: CPU: 1 PID: 8538 at mm/slab.h:475 cache_from_obj mm/slab.h:522 [inline]
WARNING: CPU: 1 PID: 8538 at mm/slab.h:475 cache_from_obj mm/slab.h:506 [inline]
WARNING: CPU: 1 PID: 8538 at mm/slab.h:475 kmem_cache_free_bulk+0x23e/0x290 mm/slab.c:3713
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8538 Comm: kworker/1:2 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events kfree_rcu_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:563
RIP: 0010:virt_to_cache mm/slab.h:475 [inline]
RIP: 0010:cache_from_obj mm/slab.h:522 [inline]
RIP: 0010:cache_from_obj mm/slab.h:506 [inline]
RIP: 0010:kmem_cache_free_bulk+0x23e/0x290 mm/slab.c:3713
Code: fe ff ff 80 3d 96 a0 f6 08 00 0f 85 6d fe ff ff 48 c7 c6 e0 f1 55 88 48 c7 c7 08 18 69 89 c6 05 7b a0 f6 08 01 e8 d4 1d 92 ff <0f> 0b e9 4c fe ff ff 48 8b 47 08 48 c7 c6 d0 17 69 89 48 8d 50 ff
RSP: 0018:ffffc90004617c78 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888092772580 RSI: ffffffff815d4f87 RDI: fffff520008c2f81
RBP: ffff888000000000 R08: 0000000000000001 R09: ffff8880ae720fcb
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880ae7253b0 R14: ffff888000152008 R15: 0000000000000000
 kfree_bulk include/linux/slab.h:412 [inline]
 kfree_rcu_work+0x1a1/0x470 kernel/rcu/tree.c:3069
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

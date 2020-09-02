Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6DDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0F2208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIBSS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:18:26 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40583 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:18:22 -0400
Received: by mail-io1-f70.google.com with SMTP id f8so327040iow.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cK3CWKmoLTK8XtOV6ppK2kthnvGS5AXhqjGaJqo+KkA=;
        b=eZouro58NSwt92Rg66kQ+hJIGm4zw352qNNIqUNvmhhu1lASWD3Rge+JWvd1Vr4+W5
         F5VN/eZEsMJ3bW1jKc/Jgh0+U5ZihOZT6CIRhxb6nYG9Lm+NlgV4saiHJKqcbDCnDQSN
         36B4vs3o/mWo/WynsRuVVklVq794/1s3rpTd3Dje7LyQinzuJe0m3UdMz3/IichoYssE
         xJ6zDkNgzD6zPSoohvuPxa3MLKcWxgjRZ6pJLoNaeJ59v+1JZELUCE94b3wVc5t0O1no
         CzWVHVAzAy1B+wmCorrI7B8MKF+I+SW75YlRWMiR8u6H4pkV8YlmrZm3UB2WncZsjA/B
         FL7A==
X-Gm-Message-State: AOAM531np3z7vv55nWTE6wNMKq49YIW3Tg4pJKVpWydFLrJrdKQfJWfG
        xAu+8x5hlobYUrloQd/wcGhIv/nlplHBLE9g28usDuFrV2t3
X-Google-Smtp-Source: ABdhPJwRj3WGWI0ggBxZa82Ttr2hrMkMffTNT5rFzBnzuRcK3elghESc34kdHqR433BDavBXprWMY/7saEkS7GDUqZW6HdjGPR8q
MIME-Version: 1.0
X-Received: by 2002:a5d:9d5a:: with SMTP id k26mr4349958iok.207.1599070701107;
 Wed, 02 Sep 2020 11:18:21 -0700 (PDT)
Date:   Wed, 02 Sep 2020 11:18:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c3dac05ae58a990@google.com>
Subject: WARNING: ODEBUG bug in process_one_work (2)
From:   syzbot <syzbot+91923aae0b157bd6c0c5@syzkaller.appspotmail.com>
To:     elver@google.com, linux-kernel@vger.kernel.org,
        miaoqinglang@huawei.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d41ead6 Merge tag 'block-5.9-2020-08-28' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1196ce61900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=91923aae0b157bd6c0c5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b1cbb6900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91923aae0b157bd6c0c5@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: xprt_init_autodisconnect+0x0/0x150 include/linux/refcount.h:274
WARNING: CPU: 1 PID: 8854 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8854 Comm: kworker/1:10 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events kfree_rcu_work
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
Code: dd a0 26 94 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd a0 26 94 88 48 c7 c7 00 1c 94 88 e8 52 38 a6 fd <0f> 0b 83 05 53 4f 13 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc9000b68fb28 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880a216c300 RSI: ffffffff815dafc7 RDI: fffff520016d1f57
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae720f8b
R10: 0000000000000000 R11: 0000000035383854 R12: ffffffff89be2ea0
R13: ffffffff81638450 R14: dead000000000100 R15: dffffc0000000000
 __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
 debug_check_no_obj_freed+0x301/0x41c lib/debugobjects.c:998
 kmem_cache_free_bulk+0x9e/0x190 mm/slab.c:3718
 kfree_bulk include/linux/slab.h:411 [inline]
 kfree_rcu_work+0x506/0x8c0 kernel/rcu/tree.c:3150
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
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

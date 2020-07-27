Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F49DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061B320719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgG0RhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:37:25 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45321 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgG0RhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:37:24 -0400
Received: by mail-io1-f69.google.com with SMTP id p17so8766049iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=luBsnytwWNJwACq4vbB9UK5VfUTfOaDSrjQjfmgB0MU=;
        b=shdONtNc8+1PbglamjJFBP0j0WS/4oiae7IBZDBVdipqswiFjLcUJo3XdLqjmwXvoI
         4Es8Yg11eDBQ7VXpTxC/XeFRXTjSoFHQsOM6BayvzEm4PGlYo6fOwWeEkj38OGk0fUmL
         QtNH4MZkK/X7ke1it3bnHO/1xVetJ41rZbSfTrlCU63ujqsQpboyNtc/7j6xmwloSIau
         k85nA0oEjt/CaTrVXJOsAxFQWOAw4Yeoqbv2ELwe4wgrxVdTPX9chpCBCBnH9Jx81fS7
         k8Bok4oKSgeBoBLUh2XC7S27v8IiK+YmbzA2LX8eifVvJLPZHPhzIeiFUIKpSfgn6GFR
         Yvog==
X-Gm-Message-State: AOAM533P54zKlAOPwfBBmsjgzzLNKVYzJj98M86mcUeAughmVXfaHdAO
        sRSjy+iHHasyVHcOT+xujfEn9sFBCiXrmV1L83oz4DRKqqMf
X-Google-Smtp-Source: ABdhPJzIn9q6VG1lVe8VZwfUIyj6cfxC8xLkfRrihpYyzsogso/bzRlI/909qNfOP+v00PI4wdW9vjKckQ6NkdRkfauGxaJ84Ty4
MIME-Version: 1.0
X-Received: by 2002:a92:18b:: with SMTP id 133mr25380271ilb.101.1595871443952;
 Mon, 27 Jul 2020 10:37:23 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:37:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000862c0305ab6fc661@google.com>
Subject: WARNING: ODEBUG bug in delete_node
From:   syzbot <syzbot+062ee7c41cfd844a3a9a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e9a523ff Add linux-next specific files for 20200727
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ad9108900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbc23e6202df3d0
dashboard link: https://syzkaller.appspot.com/bug?extid=062ee7c41cfd844a3a9a
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+062ee7c41cfd844a3a9a@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 1 PID: 16220 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 16220 Comm: syz-executor.0 Not tainted 5.8.0-rc7-next-20200727-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:545
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
Code: dd a0 12 94 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd a0 12 94 88 48 c7 c7 00 08 94 88 e8 e2 87 a6 fd <0f> 0b 83 05 13 a1 1a 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc900065e7958 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8880a1a18280 RSI: ffffffff815d93b7 RDI: fffff52000cbcf1d
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae7318a7
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89c52a00
R13: 0000000000000000 R14: 1ffff92000cbcf36 R15: ffffffff89c52a00
 debug_object_activate+0x2da/0x3e0 lib/debugobjects.c:652
 debug_object_activate+0x337/0x3e0 lib/debugobjects.c:682
 debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]
 __call_rcu kernel/rcu/tree.c:2869 [inline]
 call_rcu+0x2c/0x7e0 kernel/rcu/tree.c:2957
 radix_tree_node_free lib/radix-tree.c:309 [inline]
 delete_node+0xe5/0x8a0 lib/radix-tree.c:572
 __radix_tree_delete+0x190/0x370 lib/radix-tree.c:1378
 radix_tree_delete_item+0xe7/0x230 lib/radix-tree.c:1429
 mnt_free_id fs/namespace.c:131 [inline]
 cleanup_mnt+0x3db/0x500 fs/namespace.c:1140
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb7d/0x29f0 kernel/exit.c:806
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c369
Code: Bad RIP value.
RSP: 002b:00007fff0e2003e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000016 RCX: 000000000045c369
RDX: 0000000000415e00 RSI: 0000000000ca85f0 RDI: 0000000000000043
RBP: 00000000004d0de8 R08: 000000000000000c R09: 0000000000000000
R10: 00000000023fc940 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000744ca0
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

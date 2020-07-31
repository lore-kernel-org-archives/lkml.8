Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9271DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A2B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgGaDNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:13:31 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:34558 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbgGaDNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:13:24 -0400
Received: by mail-il1-f199.google.com with SMTP id o1so13336357ilk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/pC2jX1hCFTSa0XcmmFAvUUMdwWwZxAez1TyfC9ev/c=;
        b=VcNFHGUjQUNSK+cD66Gvm/pjd7Q+/lfMjhX/gwAQCXFWI2Udt6VWxQnF3GxeEts33y
         CXkHqO++fKbFHjFIJOGR3g4f+jSDbyG60gusazySygRBzGq0t5I86FRzSAr6scbX0MMt
         sajtU04Qc0p9a/wFWFOYqjdao6GFK6K1vWtPbbw9dO1U5EbER5ufA/Myk0bpRMBtZJBl
         0dtNcDOfVOAs3A0x+7u+Pmw0sqmBzqGHt95vkNnnZw8BQGWJXUT3+r9O8H+phD34nkoX
         2UqvRkEj5tOVW0UazkkBWzZV1imJ0la+cC5DXWof4adVLtYyoQyxqEPeNt8AgrU0Cdr2
         tofw==
X-Gm-Message-State: AOAM532zMiG5VWCuVo1x9C+DQs2aeXkcc+YsXiGsgVP/2SXehnc5dtWf
        VkqlkYRBuDS8OdMDNw9cj+yjCGc0bnyeYxNDxqfxvC/LNOEM
X-Google-Smtp-Source: ABdhPJw/Ch8WWG2O2qDM/9Jc5exVf6rgoPHKV5c9rE7Zq499OYcDuWvWDwZhuYN+Oj75uDd9AC4/tt54t2GmMmtveNwvxWia5tHP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:381:: with SMTP id f1mr1631261iov.193.1596165203333;
 Thu, 30 Jul 2020 20:13:23 -0700 (PDT)
Date:   Thu, 30 Jul 2020 20:13:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f298fc05abb42b70@google.com>
Subject: WARNING: ODEBUG bug in cancel_delayed_work
From:   syzbot <syzbot+338f014a98367a08a114@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    27a2145d ibmvnic: Fix IRQ mapping disposal in error path
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=14277848900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca6448d2af2ba351
dashboard link: https://syzkaller.appspot.com/bug?extid=338f014a98367a08a114
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168aec04900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11148e5c900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+338f014a98367a08a114@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
WARNING: CPU: 0 PID: 6858 at lib/debugobjects.c:485 debug_print_object+0x160/0x250 lib/debugobjects.c:485
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6858 Comm: syz-executor296 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x13/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:debug_print_object+0x160/0x250 lib/debugobjects.c:485
Code: dd a0 9f 93 88 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bf 00 00 00 48 8b 14 dd a0 9f 93 88 48 c7 c7 00 95 93 88 e8 b2 ae a9 fd <0f> 0b 83 05 db 0b 14 07 01 48 83 c4 20 5b 5d 41 5c 41 5d c3 48 89
RSP: 0018:ffffc9000168f578 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff888096dec4c0 RSI: ffffffff815d4ef7 RDI: fffff520002d1ea1
RBP: 0000000000000001 R08: 0000000000000001 R09: ffff8880ae620fcb
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff89bcc540
R13: ffffffff81630df0 R14: ffff888095382200 R15: 1ffff920002d1eba
 debug_object_assert_init lib/debugobjects.c:870 [inline]
 debug_object_assert_init+0x1f4/0x2e0 lib/debugobjects.c:841
 debug_timer_assert_init kernel/time/timer.c:736 [inline]
 debug_assert_init kernel/time/timer.c:781 [inline]
 del_timer+0x6d/0x110 kernel/time/timer.c:1207
 try_to_grab_pending kernel/workqueue.c:1249 [inline]
 __cancel_work kernel/workqueue.c:3221 [inline]
 cancel_delayed_work+0xe0/0x450 kernel/workqueue.c:3250
 l2cap_clear_timer include/net/bluetooth/l2cap.h:879 [inline]
 l2cap_chan_del+0x541/0x1300 net/bluetooth/l2cap_core.c:661
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:824
 l2cap_sock_shutdown+0x3b8/0xe90 net/bluetooth/l2cap_sock.c:1339
 l2cap_sock_release+0x63/0x1d0 net/bluetooth/l2cap_sock.c:1382
 __sock_release+0xcd/0x280 net/socket.c:605
 sock_close+0x18/0x20 net/socket.c:1278
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0xb72/0x2a40 kernel/exit.c:805
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x40b/0x1ee0 kernel/signal.c:2743
 do_signal+0x82/0x2520 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop arch/x86/entry/common.c:235 [inline]
 __prepare_exit_to_usermode+0x156/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446d69
Code: Bad RIP value.
RSP: 002b:00007ffc69898b98 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 0000000000000003 RCX: 0000000000446d69
RDX: 000000000000000e RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007ffc69898bd0 R08: 0000000000000000 R09: 00000000000000ff
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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

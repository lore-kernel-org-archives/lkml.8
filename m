Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F95C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B555206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGYREQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:04:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37688 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYREQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:04:16 -0400
Received: by mail-io1-f70.google.com with SMTP id 63so8490630ioy.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 10:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y/HlUNrKfgID0KWgDK/w/v+LPsx39sOOmu9UIWms2Xs=;
        b=jpQzTYQdKl6qhYEi/YMSt3Dtb5/aANAN8eE+ijY9x8GD1gjiqtYZkd1Cx+vmWU1KLr
         i4+98hmdpUnCU+/8nTzSFmnClzWdxxYphmJpMKi2aV0X36mtmhfkmfzaT2/b3DI4CjbW
         vErnk+qRqQcxYyWCVF/o5fOiIKrBK08Os+VatL2NjUzKKZjb2voM4rlBTwV3m25CymGd
         6pUA5wSg96akWRilupYczcHjLfjWP9l4OCguSU/amYTpou9I8LzFdkZxR8fgOeq78P4c
         1FTQUERBh0pt8BHm3/P6gL8KYOtBPtqMsf8mnFh4UQeY9Zzwsmi8PDT9nCfQwMOWu7ah
         mJvw==
X-Gm-Message-State: AOAM533oi/zP9iBn+rrzQFOMCvjgBo5NW7X9WRkVdXk2m842z96iHBn/
        XMmd4GK9AdqN9Z/rIWY+KtyqOEdDu9DL6OhUU10D8HO9PxVR
X-Google-Smtp-Source: ABdhPJxKhmPIerSdcjzxkII3vvJG6gsAKaAr3rQVNjq50Kjh9eVPrI75AG7oN0UfaGZrAUEzIFh0JvzLjAF5WwZz3jsRU9ER0ih4
MIME-Version: 1.0
X-Received: by 2002:a92:db01:: with SMTP id b1mr15330750iln.249.1595696655474;
 Sat, 25 Jul 2020 10:04:15 -0700 (PDT)
Date:   Sat, 25 Jul 2020 10:04:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051a79d05ab471440@google.com>
Subject: WARNING in delete_node (2)
From:   syzbot <syzbot+6324a37c93030377021f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    de2e69cf Add linux-next specific files for 20200721
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13645cef100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a18f913b3827a63a
dashboard link: https://syzkaller.appspot.com/bug?extid=6324a37c93030377021f
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6324a37c93030377021f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 17410 at lib/radix-tree.c:571 delete_node+0x1e7/0x8a0 lib/radix-tree.c:571
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 17410 Comm: syz-executor.5 Not tainted 5.8.0-rc6-next-20200721-syzkaller #0
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
RIP: 0010:delete_node+0x1e7/0x8a0 lib/radix-tree.c:571
Code: e2 48 c7 43 48 00 00 00 00 48 c1 ea 03 42 80 3c 2a 00 0f 85 bb 05 00 00 48 8b 55 18 49 39 d4 0f 84 8b 03 00 00 e8 e9 6c c3 fd <0f> 0b 48 c7 c6 d0 a6 b0 83 4c 89 e7 e8 b8 d7 b0 fd 4d 85 f6 0f 85
RSP: 0018:ffffc900078afd08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffffff89d2df00 RCX: ffffc90013fcd000
RDX: 0000000000040000 RSI: ffffffff83b0d377 RDI: ffff8880a9c90842
RBP: ffff88808a91ab40 R08: 0000000000000000 R09: ffff8880a9c90a6f
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88808a91ab58
R13: dffffc0000000000 R14: ffff8880a9c90840 R15: 000000000000000a
 __radix_tree_delete+0x190/0x370 lib/radix-tree.c:1378
 radix_tree_delete_item+0xe7/0x230 lib/radix-tree.c:1429
 mnt_free_id fs/namespace.c:131 [inline]
 cleanup_mnt+0x3db/0x500 fs/namespace.c:1140
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x199/0x1c0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1f9
Code: Bad RIP value.
RSP: 002b:00007fe40341bc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffe4 RBX: 000000000001fa40 RCX: 000000000045c1f9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000020000080
RBP: 000000000078bf50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000005010 R11: 0000000000000246 R12: 000000000078bf0c
R13: 00007ffc20fd1c9f R14: 00007fe40341c9c0 R15: 000000000078bf0c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

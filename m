Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415FC2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGMCYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:24:17 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45057 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMCYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:24:16 -0400
Received: by mail-il1-f200.google.com with SMTP id c1so8563286ilk.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 19:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oeDO3uGOlGXCY3ZqE1/B/SxjjNdp+6TXbFewQjpCefw=;
        b=gBNYmtHTYkIjzfz10p2yaxygEm3IuEUHOvqUqdU8NLJ5Lmix+HisWFq/R9s5bjisnV
         /Ly207fl/bVBNy8MnFErw0iMOhmfmxcH5E57Y3iQzW2MdzaJmVHkNzbtJBURBkrmmZBf
         qDBaq8CGjS3ktae3EtVSpvpgLwi5m2LjIf2c7UZZ08ChCjw+8oFI0OSJR0UWKOoyY9DU
         5oj1T2TGx1WjuDscE/bXrVhH2qQoZZ5x6iXWT0+1zcr3SOJMJjY6TW4X38dU1AEaQs7d
         8epCh08rBl6HyvJqDiut7XsTqvkKCfRH1t+SitRpFA3Z6YIF6QlA8bc+bp1XbHzXk6ML
         zEEg==
X-Gm-Message-State: AOAM53208ewHWkHkF5rrinRm6GQ8Nfp/Oj0Rymfk+yOTf3HKjgq0cI3k
        cjjTmkF/lfYzHi/0W7Uqbaab/lEZMnTDpNyULN0+G8Ga8m8Z
X-Google-Smtp-Source: ABdhPJxRfVkxi74W5tf9BM+cl+c0WkhO3ZD1Gj8UUT++sqELpJ0xxRFyOqGRMEVMAJfZrykDKadxtB6k6oIeE2W8sjCkgYoqqHmJ
MIME-Version: 1.0
X-Received: by 2002:a02:b897:: with SMTP id p23mr7141821jam.32.1594607055648;
 Sun, 12 Jul 2020 19:24:15 -0700 (PDT)
Date:   Sun, 12 Jul 2020 19:24:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bbb6705aa49635a@google.com>
Subject: KASAN: use-after-free Read in userfaultfd_release (2)
From:   syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89032636 Add linux-next specific files for 20200708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1028732f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=75867c44841cb6373570
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c4c8db100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cbb68f100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in userfaultfd_release+0x57f/0x5f0 fs/userfaultfd.c:879
Read of size 8 at addr ffff88809b09af88 by task syz-executor902/6813

CPU: 0 PID: 6813 Comm: syz-executor902 Not tainted 5.8.0-rc4-next-20200708-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 userfaultfd_release+0x57f/0x5f0 fs/userfaultfd.c:879
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x1e9/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4401f9
Code: Bad RIP value.
RSP: 002b:00007ffdd722dfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000143
RAX: ffffffffffffffe8 RBX: 00000000004002c8 RCX: 00000000004401f9
RDX: 00000000004401f9 RSI: 0000000000400aa0 RDI: 0000000000000000
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a00
R13: 0000000000401a90 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6813:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:536 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x148/0x550 mm/slab.c:3482
 __do_sys_userfaultfd+0x96/0x4b0 fs/userfaultfd.c:2026
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6813:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 __do_sys_userfaultfd+0x3cf/0x4b0 fs/userfaultfd.c:2061
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88809b09ae00
 which belongs to the cache userfaultfd_ctx_cache of size 408
The buggy address is located 392 bytes inside of
 408-byte region [ffff88809b09ae00, ffff88809b09af98)
The buggy address belongs to the page:
page:ffffea00026c2680 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880a03d5dc0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffff8880a3de5d50 ffff8880a3de5d50 ffff888219701b00
raw: ffff8880a03d5dc0 ffff88809b09a000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809b09ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809b09af00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88809b09af80: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff88809b09b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809b09b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

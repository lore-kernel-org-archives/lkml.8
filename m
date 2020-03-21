Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77D9C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BF62072C
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgCUKKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:10:17 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48472 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgCUKKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:10:17 -0400
Received: by mail-il1-f199.google.com with SMTP id c12so7472556ilo.15
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 03:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AFbaONcpUV2icWkxrxyohFWXKPQbYUuTA5fHHbMkaJs=;
        b=c3HVBoIHqHkMxZHbGr8j3Cno95NnKhTuae1ibKW/0+WQSYTNU10/lqPk9QvstkovPA
         q43OoLVROx8IfHG9sJez4nw8mZJHaBJjeQgImpXIvpGG+z5UCQTwmzYDSGr2heiJ0Wt8
         sG+Ed0xU86DJH5e0wu8bie4GuegAjZCIJ8TUr3SiTnqT/QY67qzRCT60kV1b4xQ8egNA
         wBZkLAg0C+TxGXspJ1Ntq8j9xuvQS/bGRaDgw1xXz4m3IXHbFHoV8JN6bHpeRb8obqzh
         F2sIVPzwxHONoMf5S1NmhvqrM7BzKgw4ezoKg5H1ZA7VlZPjd6XdOZqcbJq1y3w0mx0n
         oHGw==
X-Gm-Message-State: ANhLgQ3I4feoBOydke8fgabUKS8KtnmROnHUWPP/XZbzh4pUel31oIu7
        tId7BinhsdOdbv2HvOAIYujt4wOtujWlqIHsqQwEJ+Coc14D
X-Google-Smtp-Source: ADFU+vtKhR4UfvOUt5rrFxZRHcDxUnc2g/wx+geIy3GzWLhekALJYp1KgHmek8r7SNCYcxDauSti8IWVllpBpP/kKpQ+KfLQQbSz
MIME-Version: 1.0
X-Received: by 2002:a5d:8582:: with SMTP id f2mr11395604ioj.18.1584785416512;
 Sat, 21 Mar 2020 03:10:16 -0700 (PDT)
Date:   Sat, 21 Mar 2020 03:10:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbeaf705a15a9b30@google.com>
Subject: KASAN: null-ptr-deref Write in get_block
From:   syzbot <syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com>
To:     aeb@cwi.nl, danarag@gmail.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fb33c651 Linux 5.6-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157d4b45e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f894bd92023de02
dashboard link: https://syzkaller.appspot.com/bug?extid=4a88b2b9dc280f47baf4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127acd55e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f82345e00000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10e8d8d3e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12e8d8d3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14e8d8d3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:55 [inline]
BUG: KASAN: null-ptr-deref in trylock_buffer include/linux/buffer_head.h:359 [inline]
BUG: KASAN: null-ptr-deref in lock_buffer include/linux/buffer_head.h:365 [inline]
BUG: KASAN: null-ptr-deref in alloc_branch fs/minix/itree_common.c:88 [inline]
BUG: KASAN: null-ptr-deref in get_block+0x657/0x1380 fs/minix/itree_common.c:191
Write of size 8 at addr 0000000000000000 by task syz-executor110/9537

CPU: 0 PID: 9537 Comm: syz-executor110 Not tainted 5.6.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x32 mm/kasan/report.c:510
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x128/0x190 mm/kasan/generic.c:192
 test_and_set_bit_lock include/asm-generic/bitops/instrumented-lock.h:55 [inline]
 trylock_buffer include/linux/buffer_head.h:359 [inline]
 lock_buffer include/linux/buffer_head.h:365 [inline]
 alloc_branch fs/minix/itree_common.c:88 [inline]
 get_block+0x657/0x1380 fs/minix/itree_common.c:191
 minix_get_block+0xe5/0x110 fs/minix/inode.c:376
 __block_write_begin_int+0x490/0x1b00 fs/buffer.c:2008
 __block_write_begin fs/buffer.c:2058 [inline]
 block_write_begin+0x58/0x2e0 fs/buffer.c:2117
 minix_write_begin+0x35/0xe0 fs/minix/inode.c:412
 generic_perform_write+0x20a/0x4e0 mm/filemap.c:3287
 __generic_file_write_iter+0x24c/0x610 mm/filemap.c:3416
 generic_file_write_iter+0x3f0/0x62d mm/filemap.c:3448
 call_write_iter include/linux/fs.h:1902 [inline]
 new_sync_write+0x49c/0x700 fs/read_write.c:483
 __vfs_write+0xc9/0x100 fs/read_write.c:496
 vfs_write+0x262/0x5c0 fs/read_write.c:558
 ksys_write+0x127/0x250 fs/read_write.c:611
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44b389
Code: fd ca fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 cb ca fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4e9f99ace8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006ddc38 RCX: 000000000044b389
RDX: 000000000000fdef RSI: 00000000200004c0 RDI: 0000000000000005
RBP: 00000000006ddc30 R08: 0000000000000012 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc3c
R13: 00007ffcd0e441ef R14: 00007f4e9f99b9c0 R15: 0000000000000001
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

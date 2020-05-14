Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54F62065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgENQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:14:15 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33110 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgENQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:14:14 -0400
Received: by mail-io1-f70.google.com with SMTP id w4so2865531iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CKY4NV3ic/vtHx2ZbfUs/ydBAqtITJta48OgIONkqlA=;
        b=RBaI41VE/9Ycw+icL5t/GvqleIBTLBhAwa58hmfsWZoEBIVljt7OS8f6d8M/r0jMjk
         AqCXGiY54kq4iFhwDZuS3JQSlCNQdYWMMF+r2EoKpo7Bq4C/aVasjGh3KpLwq20WQDUN
         lFXrOnBuIt8ijveQN3gA6Xb3CFOOsVjZMRZtnumnkR8csp6gfk5swSzbNV9HbQYfbQCq
         twb6iRyezhBRsdAfa/hZfmJNYPoiL4RPeRJnZKbBgsUc/4/vcu5Dz5ReJMVdws+kOWU/
         k96KKyVA7IzTiMJU17KvvdCFyX9lieIFiwA/ylTpCf0ZXnkLIm0aP0bvU2YqTI/mDMEx
         OYEw==
X-Gm-Message-State: AOAM532u3ba3ZqGI7P3vMAnMqEJXEm0HnxI8Aqlvl1nUEq6dDRSkcFL/
        6YAnJ8jED3llxBI1IrKSlXiQRlsFKbscRyRL+5B4eeGQiR66
X-Google-Smtp-Source: ABdhPJz1PpiCD2WfKbmBwKNHmknDKCun6ZSzNYM2L+BYajS0Xo6DFt0eYz4HQgKZlwyObKQzSfAq6CFTdzyeMnYhwuywhyv1F7LO
MIME-Version: 1.0
X-Received: by 2002:a6b:7319:: with SMTP id e25mr4767304ioh.193.1589472853748;
 Thu, 14 May 2020 09:14:13 -0700 (PDT)
Date:   Thu, 14 May 2020 09:14:13 -0700
In-Reply-To: <0000000000004af71905a50c973a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3f28c05a59dfc3e@google.com>
Subject: Re: KASAN: use-after-free Write in get_block
From:   syzbot <syzbot+c7d9ec7a1a7272dd71b3@syzkaller.appspotmail.com>
To:     aeb@cwi.nl, akpm@linux-foundation.org, danarag@gmail.com,
        deepa.kernel@gmail.com, gregkh@linuxfoundation.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=148bf748100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=c7d9ec7a1a7272dd71b3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10844a8c100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17978806100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135471e4100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10d471e4100000
console output: https://syzkaller.appspot.com/x/log.txt?x=175471e4100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c7d9ec7a1a7272dd71b3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in alloc_branch fs/minix/itree_common.c:92 [inline]
BUG: KASAN: use-after-free in get_block+0x1202/0x1380 fs/minix/itree_common.c:191
Write of size 2 at addr ffff88808ae27ba4 by task syz-executor461/7083

CPU: 0 PID: 7083 Comm: syz-executor461 Not tainted 5.7.0-rc1-next-20200415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 alloc_branch fs/minix/itree_common.c:92 [inline]
 get_block+0x1202/0x1380 fs/minix/itree_common.c:191
 minix_get_block+0xe5/0x110 fs/minix/inode.c:376
 __block_write_begin_int+0x490/0x1b00 fs/buffer.c:2039
 __block_write_begin fs/buffer.c:2089 [inline]
 block_write_begin+0x58/0x2e0 fs/buffer.c:2148
 minix_write_begin+0x35/0xe0 fs/minix/inode.c:412
 generic_perform_write+0x20a/0x4e0 mm/filemap.c:3308
 __generic_file_write_iter+0x24c/0x610 mm/filemap.c:3437
 generic_file_write_iter+0x3f3/0x630 mm/filemap.c:3469
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write+0x4a2/0x700 fs/read_write.c:484
 __vfs_write+0xc9/0x100 fs/read_write.c:497
 __kernel_write+0x11c/0x3a0 fs/read_write.c:516
 do_acct_process+0xcdc/0x10e0 kernel/acct.c:522
 acct_pin_kill+0x29/0xf0 kernel/acct.c:174
 pin_kill+0x175/0x7c0 fs/fs_pin.c:44
 mnt_pin_kill+0x6c/0x1c0 fs/fs_pin.c:81
 cleanup_mnt+0x3c4/0x4b0 fs/namespace.c:1092
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0xb53/0x2e10 kernel/exit.c:795
 do_group_exit+0x125/0x340 kernel/exit.c:893
 __do_sys_exit_group kernel/exit.c:904 [inline]
 __se_sys_exit_group kernel/exit.c:902 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:902
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x44b9e8
Code: Bad RIP value.
RSP: 002b:00007fff686f4e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000044b9e8
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004d0a10 R08: 00000000000000e7 R09: ffffffffffffffd4
R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006ea9a0 R14: 0000000000000000 R15: 00007fff686f62d0

The buggy address belongs to the page:
page:ffffea00022b89c0 refcount:0 mapcount:0 mapping:00000000722a657b index:0x1
flags: 0xfffe0000000000()
raw: 00fffe0000000000 ffffea00022b1448 ffffea000231b808 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808ae27a80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88808ae27b00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88808ae27b80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                               ^
 ffff88808ae27c00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88808ae27c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


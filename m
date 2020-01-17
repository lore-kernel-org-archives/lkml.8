Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA282C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C531E20730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAQGpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:45:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48886 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgAQGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:45:11 -0500
Received: by mail-il1-f199.google.com with SMTP id u14so18043878ilq.15
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 22:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ALoOrIWozL+7PLCcGhdyW5y50eCbmJ6yl03zW3710zk=;
        b=pfGtirgmlaDUkg74tKhKq7Brc861KQ+akvCynHwF6QZijOkW51naHuPoBOd7n0YKUD
         ESY1tE0AL8ppvtSM7Go23glx0IoFpYhKGptv0pieim7+VLYa383jX3E7ATPWbkr46SD3
         rHl7xrt89NDxO1cQCm3hiPJ0WMPpVnSBBA2ae7CH25UITprODHYZWMLIECW+L0wAO+p1
         qYx6gxaL9ATCHjOkv9Em0QVkss3q+a4Nj8QVDtw0msxL5pubxkTUeeTRm2d6oQouWVQd
         4N9XGLrWxn4aQv5Xa7ryRYjB+zryKGoe8edlDplkun8knANFYrU7bM9GiY0L6fKOPQsU
         e6Ug==
X-Gm-Message-State: APjAAAXaIbCYFvSYg/7ILKMa0C16rUXip8OdKTUOcVezwLpqIM5TfIJQ
        U3vHkyurD8U2YclFS39Hg+5Ppk7siIC2el0qEcZLqXcaougT
X-Google-Smtp-Source: APXvYqx7cLsfbkr4tyHg0yBuh+Y7mfDrXeXDvyvI806pApG8VLr6QRUQBtIB1yUYwA6ZJYsma6GMsTQKy8JR2FZqPF/P2HbYS2Ht
MIME-Version: 1.0
X-Received: by 2002:a02:2a08:: with SMTP id w8mr32302555jaw.86.1579243509817;
 Thu, 16 Jan 2020 22:45:09 -0800 (PST)
Date:   Thu, 16 Jan 2020 22:45:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006aa78f059c5048c1@google.com>
Subject: KASAN: use-after-free Read in __locks_wake_up_blocks
From:   syzbot <syzbot+922689db06e57b69c240@syzkaller.appspotmail.com>
To:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f5ae2ea6 Fix built-in early-load Intel microcode alignment
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c103aee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=922689db06e57b69c240
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+922689db06e57b69c240@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __wake_up_common+0x5d7/0x610  
kernel/sched/wait.c:81
Read of size 8 at addr ffff88808e074888 by task syz-executor.0/20572

CPU: 1 PID: 20572 Comm: syz-executor.0 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
  __wake_up_common+0x5d7/0x610 kernel/sched/wait.c:81
  __wake_up_common_lock+0xea/0x150 kernel/sched/wait.c:123
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  __locks_wake_up_blocks+0x120/0x180 fs/locks.c:742
  locks_delete_block+0x73/0xf0 fs/locks.c:773
  flock_lock_inode_wait fs/locks.c:2143 [inline]
  locks_lock_inode_wait+0x16b/0x3f0 fs/locks.c:2162
  locks_lock_file_wait include/linux/fs.h:1328 [inline]
  __do_sys_flock fs/locks.c:2225 [inline]
  __se_sys_flock fs/locks.c:2188 [inline]
  __x64_sys_flock+0x30c/0x370 fs/locks.c:2188
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45aff9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb6469d4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000049
RAX: ffffffffffffffda RBX: 00007fb6469d56d4 RCX: 000000000045aff9
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000000c6 R14: 00000000004c1bff R15: 000000000075bf2c

Allocated by task 20575:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:521
  slab_post_alloc_hook mm/slab.h:584 [inline]
  slab_alloc mm/slab.c:3320 [inline]
  kmem_cache_alloc+0x121/0x710 mm/slab.c:3484
  kmem_cache_zalloc include/linux/slab.h:660 [inline]
  locks_alloc_lock+0x1d/0x1d0 fs/locks.c:346
  flock_make_lock+0x241/0x2b0 fs/locks.c:487
  __do_sys_flock fs/locks.c:2207 [inline]
  __se_sys_flock fs/locks.c:2188 [inline]
  __x64_sys_flock+0xd5/0x370 fs/locks.c:2188
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 20575:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kmem_cache_free+0x86/0x320 mm/slab.c:3694
  locks_free_lock fs/locks.c:383 [inline]
  __do_sys_flock fs/locks.c:2228 [inline]
  __se_sys_flock fs/locks.c:2188 [inline]
  __x64_sys_flock+0x23b/0x370 fs/locks.c:2188
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88808e0747f0
  which belongs to the cache file_lock_cache of size 264
The buggy address is located 152 bytes inside of
  264-byte region [ffff88808e0747f0, ffff88808e0748f8)
The buggy address belongs to the page:
page:ffffea0002381d00 refcount:1 mapcount:0 mapping:ffff8880a9932700  
index:0xffff88808e074a80
raw: 00fffe0000000200 ffffea00025f86c8 ffffea0002585ac8 ffff8880a9932700
raw: ffff88808e074a80 ffff88808e074040 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88808e074780: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fb fb
  ffff88808e074800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88808e074880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
                       ^
  ffff88808e074900: fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb fb
  ffff88808e074980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

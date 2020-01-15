Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352EC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2E524671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAOCYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:24:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:37543 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAOCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:24:12 -0500
Received: by mail-il1-f197.google.com with SMTP id l13so12244139ilj.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 18:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WWeIVacI2D2WuDru2g29CeiiplPuUAJpWZIYSVpkKCQ=;
        b=bSI3oV23xcKuWiLeI23hJ9rMdWCGE0ZjVjgBZ7ewEKIn4TMJGzCFzPQt346X2z9Sp7
         C7ExahybRG2mBx9+jsOxDq3/Z40b3wKBRKWGXwrORKPpdNuQZVqJ5J6g82tDGwcVbAZv
         Yxy4ir84gyrQlnv8N6M5BUcM7Kzxedh5P9Weo/Gd+P8g3kUXtSQ13HsahO+FfeF+fKGX
         Ilj3k7gy3PIrZ+j6Q9Dx31E7GEVyaUo8G/zGG4QqbwCoYmBgOUHzmnfXZ6SvS/uT0lS/
         QgSnO4WFNRW0PnCnry0Lxo1op775IudeJKLV4vJju+xiXGj+G5keTWz/NxHLi90MMFpT
         3j2g==
X-Gm-Message-State: APjAAAXdSZ/p1kawEtm5rLzV70Vuik5jLgudKRTEBD3jEKW9ICajmv8g
        /87yRb/LVejOnANnoBarDFZYQFI1eXeZg6tSACDgNLSnn/cW
X-Google-Smtp-Source: APXvYqw/lO+JlywzaQIlBYkwUgl6VbintehziaazrfG8XejF74PUFi0g24E3NRH4x/RT32xK02m5t+qzwnanGN/EePBUaU6e5H+M
MIME-Version: 1.0
X-Received: by 2002:a92:d781:: with SMTP id d1mr1490827iln.30.1579055051342;
 Tue, 14 Jan 2020 18:24:11 -0800 (PST)
Date:   Tue, 14 Jan 2020 18:24:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a8b8f059c24672a@google.com>
Subject: KASAN: slab-out-of-bounds Write in mpol_parse_str
From:   syzbot <syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, yang.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e69ec487 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143045c6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=e64a13c5369a194d67df
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ddc8d1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15851c85e00000

The bug was bisected to:

commit 626c3920aeb4575f53c96b0d4ad4e651a21cbb66
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Sep 9 00:28:06 2019 +0000

     shmem_parse_one(): switch to use of fs_parse()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1643b3fee00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1543b3fee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1143b3fee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
Fixes: 626c3920aeb4 ("shmem_parse_one(): switch to use of fs_parse()")

==================================================================
BUG: KASAN: slab-out-of-bounds in mpol_parse_str+0x87b/0xa50  
mm/mempolicy.c:2922
Write of size 1 at addr ffff8880a4513abf by task syz-executor950/9591

CPU: 0 PID: 9591 Comm: syz-executor950 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_store1_noabort+0x17/0x20 mm/kasan/generic_report.c:137
  mpol_parse_str+0x87b/0xa50 mm/mempolicy.c:2922
  shmem_parse_one+0x71e/0xa40 mm/shmem.c:3472
  vfs_parse_fs_param+0x2ca/0x540 fs/fs_context.c:145
  vfs_parse_fs_string+0x105/0x170 fs/fs_context.c:188
  shmem_parse_options+0x168/0x250 mm/shmem.c:3522
  parse_monolithic_mount_data+0x69/0x90 fs/fs_context.c:704
  do_new_mount fs/namespace.c:2818 [inline]
  do_mount+0x1310/0x1b50 fs/namespace.c:3142
  __do_sys_mount fs/namespace.c:3351 [inline]
  __se_sys_mount fs/namespace.c:3328 [inline]
  __x64_sys_mount+0x192/0x230 fs/namespace.c:3328
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a9a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 7d ae fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5a ae fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007fffb59b03c8 EFLAGS: 00000297 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffb59b03d0 RCX: 0000000000446a9a
RDX: 00007fffb59b03d0 RSI: 00000000200000c0 RDI: 00007fffb59b03f0
RBP: 0000000000000003 R08: 00007fffb59b0430 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000297 R12: 00007fffb59b0430
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9564:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  tomoyo_add_entry security/tomoyo/common.c:2031 [inline]
  tomoyo_supervisor+0xd3e/0xef0 security/tomoyo/common.c:2103
  tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
  tomoyo_path_permission security/tomoyo/file.c:587 [inline]
  tomoyo_path_permission+0x263/0x360 security/tomoyo/file.c:573
  tomoyo_path_perm+0x318/0x430 security/tomoyo/file.c:838
  tomoyo_inode_getattr+0x1d/0x30 security/tomoyo/tomoyo.c:129
  security_inode_getattr+0xf2/0x150 security/security.c:1222
  vfs_getattr+0x25/0x70 fs/stat.c:115
  vfs_statx_fd+0x71/0xc0 fs/stat.c:145
  vfs_fstat include/linux/fs.h:3265 [inline]
  __do_sys_newfstat+0x9b/0x120 fs/stat.c:378
  __se_sys_newfstat fs/stat.c:375 [inline]
  __x64_sys_newfstat+0x54/0x80 fs/stat.c:375
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9564:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  tomoyo_add_entry security/tomoyo/common.c:2045 [inline]
  tomoyo_supervisor+0xc2c/0xef0 security/tomoyo/common.c:2103
  tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
  tomoyo_path_permission security/tomoyo/file.c:587 [inline]
  tomoyo_path_permission+0x263/0x360 security/tomoyo/file.c:573
  tomoyo_path_perm+0x318/0x430 security/tomoyo/file.c:838
  tomoyo_inode_getattr+0x1d/0x30 security/tomoyo/tomoyo.c:129
  security_inode_getattr+0xf2/0x150 security/security.c:1222
  vfs_getattr+0x25/0x70 fs/stat.c:115
  vfs_statx_fd+0x71/0xc0 fs/stat.c:145
  vfs_fstat include/linux/fs.h:3265 [inline]
  __do_sys_newfstat+0x9b/0x120 fs/stat.c:378
  __se_sys_newfstat fs/stat.c:375 [inline]
  __x64_sys_newfstat+0x54/0x80 fs/stat.c:375
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a4513a80
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 31 bytes to the right of
  32-byte region [ffff8880a4513a80, ffff8880a4513aa0)
The buggy address belongs to the page:
page:ffffea00029144c0 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff8880a4513fc1
raw: 00fffe0000000200 ffffea0002a2e388 ffffea0002581cc8 ffff8880aa4001c0
raw: ffff8880a4513fc1 ffff8880a4513000 0000000100000028 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a4513980: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8880a4513a00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
> ffff8880a4513a80: fb fb fb fb fc fc fc fc 00 05 fc fc fc fc fc fc
                                         ^
  ffff8880a4513b00: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff8880a4513b80: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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

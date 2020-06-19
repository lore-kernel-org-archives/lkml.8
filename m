Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB10C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B8D207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgFSFsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:48:15 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44794 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFSFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:48:14 -0400
Received: by mail-io1-f72.google.com with SMTP id v14so5939501iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=F1iFEVTnJM7VtnU/WKTFvYYYzihsyhayjjFqm4xQ7sw=;
        b=o3MqxKzH1zuRnqfmOUQ2Q+jMw8UW1/PDz4WxtqDP/zwT6DRt1qJXui+Cpr0IHkF1yi
         EKsZgOG/GLOBl/Uwo1P+yQ/tpkSwbaElcNPIVvlyvxCWBrH7E4+ovoJqjtEv8AFP/AeC
         KE2hsF/Rvcltq4fh2TEdomzs90FtBRy6E33c0W/5b1jCBO7sge4bzsVz5qDzsq3pnabw
         AANKhQNhzVu0EGbJACjUpXXppJb+YcnYtx8v9pVfVVuRBDxz6RCTHq2vvhWBNUdMJUvl
         KOOr6CYNf0CFYvCBm6d/Vh0Dfg+g2MvZ0X8ri/HXChnllex14DPGOYf1mtHPBz7W8+5u
         Om2Q==
X-Gm-Message-State: AOAM530/YZi5xnUVwc7dtXolmEd28xY8G28p7mNSaqkavjofBff3tK/B
        0XDTMaEzsOnLqI6zxY9VctwaoRvM0beKXpRQOZRMpUB1StdK
X-Google-Smtp-Source: ABdhPJz6LP9cAsji3gkOO9GMUnWOu94LW1rdoit8FT329hoB2ZPcfd8E050slkxRsHbotexpbnZWl24KBfJqR2rJAEwH6T+X/wV9
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2295:: with SMTP id d21mr2616123iod.0.1592545693570;
 Thu, 18 Jun 2020 22:48:13 -0700 (PDT)
Date:   Thu, 18 Jun 2020 22:48:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a991a05a86970bb@google.com>
Subject: KASAN: use-after-free Read in dev_uevent
From:   syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169fa049100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=348b571beb5eeb70a582
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dev_uevent+0x30a/0x580 drivers/base/core.c:1486
Read of size 8 at addr ffff888098662098 by task systemd-udevd/29958

CPU: 0 PID: 29958 Comm: systemd-udevd Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 dev_uevent+0x30a/0x580 drivers/base/core.c:1486
 uevent_show+0x1b2/0x2f0 drivers/base/core.c:1557
 dev_attr_show+0x50/0xc0 drivers/base/core.c:1261
 sysfs_kf_seq_show+0x30e/0x4e0 fs/sysfs/file.c:60
 seq_read+0x41a/0xce0 fs/seq_file.c:208
 __vfs_read+0x9c/0x6d0 fs/read_write.c:426
 vfs_read+0x1c4/0x400 fs/read_write.c:462
 ksys_read+0x11b/0x220 fs/read_write.c:588
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7f28fc677910
Code: b6 fe ff ff 48 8d 3d 0f be 08 00 48 83 ec 08 e8 06 db 01 00 66 0f 1f 44 00 00 83 3d f9 2d 2c 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 de 9b 01 00 48 89 04 24
RSP: 002b:00007ffe3053dd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00005562a17eb920 RCX: 00007f28fc677910
RDX: 0000000000001000 RSI: 00005562a17fe8c0 RDI: 0000000000000007
RBP: 00007f28fc932440 R08: 00007f28fc9361e8 R09: 0000000000001010
R10: 00005562a17eb920 R11: 0000000000000246 R12: 0000000000001000
R13: 0000000000000d68 R14: 00005562a17fe8c0 R15: 00007f28fc931900

Allocated by task 29904:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 dev_new drivers/usb/gadget/legacy/raw_gadget.c:182 [inline]
 raw_open+0x87/0x500 drivers/usb/gadget/legacy/raw_gadget.c:372
 misc_open+0x346/0x3c0 drivers/char/misc.c:141
 chrdev_open+0x498/0x580 fs/char_dev.c:414
 do_dentry_open+0x808/0x1020 fs/open.c:828
 do_open fs/namei.c:3229 [inline]
 path_openat+0x2790/0x38b0 fs/namei.c:3346
 do_filp_open+0x191/0x3a0 fs/namei.c:3373
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 ksys_open include/linux/syscalls.h:1388 [inline]
 __do_sys_open fs/open.c:1201 [inline]
 __se_sys_open fs/open.c:1199 [inline]
 __x64_sys_open+0x1af/0x1e0 fs/open.c:1199
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 29956:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 raw_release+0x130/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:411
 __fput+0x2ed/0x750 fs/file_table.c:281
 task_work_run+0x147/0x1d0 kernel/task_work.c:123
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x5ef/0x1f80 kernel/exit.c:806
 do_group_exit+0x15e/0x2c0 kernel/exit.c:904
 get_signal+0x13cf/0x1d60 kernel/signal.c:2739
 do_signal+0x33/0x610 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop arch/x86/entry/common.c:161 [inline]
 prepare_exit_to_usermode+0x32a/0x600 arch/x86/entry/common.c:196
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888098662000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 152 bytes inside of
 4096-byte region [ffff888098662000, ffff888098663000)
The buggy address belongs to the page:
page:ffffea0002619880 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 head:ffffea0002619880 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea00021d0908 ffffea0002a5a808 ffff8880aa402000
raw: 0000000000000000 ffff888098662000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888098661f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888098662000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888098662080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888098662100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888098662180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

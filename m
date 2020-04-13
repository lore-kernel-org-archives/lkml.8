Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E48C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C07B20732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgDMINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgDMILL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:11:11 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E3C00860B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:11:10 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a15so9874427ild.14
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jkRD3ZLCGbnan/OLqHZy5Z7Id1+L0JF7pFHOJuXWPhg=;
        b=RpSb3xM0+NEutg5nzXbO27WsZxfQZdHkwOGOmLZyTI06s8n9Stl3Yi2Suv11USrkl0
         owdzrtfjlMfQAfqV8BS4CmMvj5KVZ6lpeFWJEMrAJRIcemQ5px42yoo6MQQ1cfx/PMAq
         STglUcEdSUZZvtb2EJDdGO1fd6h5e7EkEKJ+cV0RVoPXsIMr8HPmHGja4F3dksivKWm6
         xxShRd1MDPoFaE/lVXWMCQ1HOLJDQ5VEUQCtL9liUPBs+Oi0t5Eqcsh6kiyawflYq3Se
         7+XPhtOojLu/gPQMNPTCP1vgDfXAZhb+Yhsm9CCFt5VlKyKU83JYIuQgAGLh89ig7GBO
         IDKw==
X-Gm-Message-State: AGi0PubO5hRbjVNc1uUC9ImsfDw+xeFhInEqv46rW+k2TPijePsDAgms
        bIhatcuBBtu4xJC2fPMhQBoLulxMF91mjrkubefl2q1yOf0K
X-Google-Smtp-Source: APiQypLfmW8Gz/2+IzV0DfXYXUiT489hPKS6/y+oTe8VDMFmIXSrDsXgDJxH6AcKDUigDQQJjQezYrJchYMOc4VL4SS0+3V/qR0M
MIME-Version: 1.0
X-Received: by 2002:a6b:650f:: with SMTP id z15mr4529166iob.162.1586765470304;
 Mon, 13 Apr 2020 01:11:10 -0700 (PDT)
Date:   Mon, 13 Apr 2020 01:11:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003311fd05a327a060@google.com>
Subject: KASAN: slab-out-of-bounds Read in gfn_to_memslot
From:   syzbot <syzbot+2e0179e5185bcd5b9440@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4f8a3cc1 Merge tag 'x86-urgent-2020-04-12' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=104b9407e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bfbde87e8e65624
dashboard link: https://syzkaller.appspot.com/bug?extid=2e0179e5185bcd5b9440
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e78c7de00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cf613fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e0179e5185bcd5b9440@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in search_memslots include/linux/kvm_host.h:1051 [inline]
BUG: KASAN: slab-out-of-bounds in __gfn_to_memslot include/linux/kvm_host.h:1063 [inline]
BUG: KASAN: slab-out-of-bounds in gfn_to_memslot+0x275/0x470 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1597
Read of size 8 at addr ffff888097b31468 by task syz-executor165/9960

CPU: 0 PID: 9960 Comm: syz-executor165 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:382
 __kasan_report+0x103/0x1a0 mm/kasan/report.c:511
 kasan_report+0x4d/0x80 mm/kasan/common.c:625

Allocated by task 9966:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc+0x114/0x160 mm/kasan/common.c:495
 kmalloc_node include/linux/slab.h:578 [inline]
 kvmalloc_node+0x81/0x100 mm/util.c:574
 kvmalloc include/linux/mm.h:757 [inline]
 kvzalloc include/linux/mm.h:765 [inline]
 kvm_dup_memslots arch/x86/kvm/../../../virt/kvm/kvm_main.c:1101 [inline]
 kvm_set_memslot+0x124/0x15b0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1118
 __kvm_set_memory_region+0x1388/0x16c0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1300
 kvm_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1321 [inline]
 kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1333 [inline]
 kvm_vm_ioctl+0x930/0x2530 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3604
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:770
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 8700:
 save_stack mm/kasan/common.c:49 [inline]
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0x125/0x190 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 kvm_free_memslots arch/x86/kvm/../../../virt/kvm/kvm_main.c:601 [inline]
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:810 [inline]
 kvm_put_kvm+0xa8d/0xcb0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:828
 kvm_vm_release+0x42/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:851
 __fput+0x2ed/0x750 fs/file_table.c:280
 task_work_run+0x147/0x1d0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:165 [inline]
 prepare_exit_to_usermode+0x48e/0x600 arch/x86/entry/common.c:196
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff888097b31000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1128 bytes inside of
 2048-byte region [ffff888097b31000, ffff888097b31800)
The buggy address belongs to the page:
page:ffffea00025ecc40 refcount:1 mapcount:0 mapping:00000000499db978 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00029ef288 ffffea0002a34408 ffff8880aa400e00
raw: 0000000000000000 ffff888097b31000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888097b31300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888097b31380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888097b31400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
                                                          ^
 ffff888097b31480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888097b31500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

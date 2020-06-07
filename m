Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A66C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 09:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594512065C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 09:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFGJKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 05:10:19 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:55586 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFGJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 05:10:18 -0400
Received: by mail-il1-f198.google.com with SMTP id l20so9365599ilk.22
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 02:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ui/zAEDfK90KrltMW5xg+UzIIlbJSijIM/qfQmLPS5s=;
        b=ESE0GojERnzyVBEhB2xfwDjN3Zo9arVika//prqMfHSPwjZDPtI0aooZUFC/yoWViz
         BJCaGasNE29vAcM+G7KekogFvXqCFzUEjTNXZFWgIZTlag2H+16LImLiwWWHjHsxaqkD
         byhhNI/qxJzQ9z65y/IKuYPs1OsO9sYgpx+1nXKbCUem9vSiwnpP14l9hRsiD/jyYgC2
         PevFTaZpeRM42eXkMpZVOuEX3zG9iHwDC1HjM5swjWJ3t32SBXm+jiumBJELbC1bEO/V
         EozihD9mTFKucFNFSYWWE+gN0kaU+88lFP6oss2+k+UF0VjtZamSrUyiGXRzGLubg5Xl
         ODoA==
X-Gm-Message-State: AOAM532EYIyWGB9E+/85RtIybn1PeeOxr/O0BwJeza7BlxceXgj87jpU
        NbLkB3sTIq6YcOsbDF1IjzNIhnN+g+TEt5KFscs5qHdwEPGM
X-Google-Smtp-Source: ABdhPJw0e3NJwysfxMm6yR80gJYmJSMsrKxAo1PuB7fK3kPaZDupYG5BtoZOTOk+9TWGFgP8dt8M4cb7uLDBt1xasEE0iAKb/a4M
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d05:: with SMTP id q5mr16196892jaj.2.1591521017199;
 Sun, 07 Jun 2020 02:10:17 -0700 (PDT)
Date:   Sun, 07 Jun 2020 02:10:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2105b05a77adc57@google.com>
Subject: KASAN: use-after-free Write in start_creating
From:   syzbot <syzbot+ee19362d7c0417910752@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1441c9de100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=ee19362d7c0417910752
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ee19362d7c0417910752@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic64_set include/asm-generic/atomic-instrumented.h:854 [inline]
BUG: KASAN: use-after-free in atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
BUG: KASAN: use-after-free in rwsem_set_owner kernel/locking/rwsem.c:176 [inline]
BUG: KASAN: use-after-free in __down_write kernel/locking/rwsem.c:1391 [inline]
BUG: KASAN: use-after-free in down_write+0xdb/0x150 kernel/locking/rwsem.c:1532
Write of size 8 at addr ffff8880277496e8 by task syz-executor.3/17503

CPU: 1 PID: 17503 Comm: syz-executor.3 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:192
 atomic64_set include/asm-generic/atomic-instrumented.h:854 [inline]
 atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 rwsem_set_owner kernel/locking/rwsem.c:176 [inline]
 __down_write kernel/locking/rwsem.c:1391 [inline]
 down_write+0xdb/0x150 kernel/locking/rwsem.c:1532
 inode_lock include/linux/fs.h:799 [inline]
 start_creating+0xa8/0x250 fs/debugfs/inode.c:334
 __debugfs_create_file+0x62/0x400 fs/debugfs/inode.c:383
 kvm_arch_create_vcpu_debugfs+0x52/0x200 arch/x86/kvm/debugfs.c:48
 kvm_create_vcpu_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:3012 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3089 [inline]
 kvm_vm_ioctl+0x1c0b/0x2440 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3617
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca69
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f40f5451c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e7400 RCX: 000000000045ca69
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000005
RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000396 R14: 00000000004c6306 R15: 00007f40f54526d4

Allocated by task 17503:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 alloc_inode+0x164/0x1e0 fs/inode.c:234
 new_inode_pseudo+0x14/0xe0 fs/inode.c:928
 new_inode+0x1b/0x40 fs/inode.c:957
 debugfs_get_inode+0x1a/0x130 fs/debugfs/inode.c:67
 debugfs_create_dir+0x71/0x390 fs/debugfs/inode.c:544
 kvm_create_vcpu_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:3009 [inline]
 kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3089 [inline]
 kvm_vm_ioctl+0x1bd8/0x2440 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3617
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 2478:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kmem_cache_free+0x7f/0x320 mm/slab.c:3694
 i_callback+0x3f/0x70 fs/inode.c:221
 rcu_do_batch kernel/rcu/tree.c:2396 [inline]
 rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2623
 __do_softirq+0x26c/0x9f7 kernel/softirq.c:292

The buggy address belongs to the object at ffff888027749600
 which belongs to the cache inode_cache of size 1024
The buggy address is located 232 bytes inside of
 1024-byte region [ffff888027749600, ffff888027749a00)
The buggy address belongs to the page:
page:ffffea00009dd240 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888027749ffd
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0001412e48 ffffea00009db2c8 ffff8880aa201380
raw: ffff888027749ffd ffff888027749180 0000000100000003 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888027749580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027749600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027749680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888027749700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027749780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

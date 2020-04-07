Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3221C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575122074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgDGUGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:06:12 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:45237 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:06:12 -0400
Received: by mail-io1-f70.google.com with SMTP id g5so4073686ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 13:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CVr7biC8Q8ny8xqTK4oQ01HriXCO42SFK+8VQ4yBLaI=;
        b=bXgUbyEH+GsBFZ2m8xzwtFCoOzWtzI4P1Auv/TryRI+Sb1XocBo4tB+zO7tbfm/MlS
         41A+V5CbvjtZb0d7O21aW3J2oy8H3G900wP9qqHwrUgOxoTA6EepZg5VoXCJiCXgF4dL
         mrKOwg2UQvKmU/7kEEPFaVRV/hrTzE0ZlnJJV9CSgthjaL/SmBa6RYdvpIC7YTrSaYQL
         oIypJ3hjRUTodXtcs41M3qd7kRDqsr99rrmAy6HkNPAOLJ+6LqhOA9AkCrcfcWTnQUQD
         aviLgHOJEjguPYacu/6TZiTi8z4lfBQ0bupYn00khvrmyGCm/XzGYk0bC356NOO00/jM
         fsFQ==
X-Gm-Message-State: AGi0PuZfjUyWPShgzCQof+d1XQLUnKNZC5xMfckXRSGx8GotMrqYo/pb
        TwB1pF/zrEF9v0M2fZQYBOWOxhMMR04kxHsKeyAxX9U1OXq3
X-Google-Smtp-Source: APiQypLEmiJvkFyQVu85AAY7FU55UCjQdGuUhUhepwDKQKKhIiRSzLmMTBTr1d/QJCbZoIYVEwSXdx8WYAuarFwiy81M8MjFOCZ/
MIME-Version: 1.0
X-Received: by 2002:a02:b891:: with SMTP id p17mr3509083jam.124.1586289971178;
 Tue, 07 Apr 2020 13:06:11 -0700 (PDT)
Date:   Tue, 07 Apr 2020 13:06:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e2e5905a2b8ea2c@google.com>
Subject: KASAN: slab-out-of-bounds Read in kvm_read_guest_page
From:   syzbot <syzbot+a65b3f8eec6b27650a25@syzkaller.appspotmail.com>
To:     christoffer.dall@arm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, pbonzini@redhat.com,
        peterx@redhat.com, sean.j.christopherson@intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e40efbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
dashboard link: https://syzkaller.appspot.com/bug?extid=a65b3f8eec6b27650a25
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14869db7e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d2731fe00000

The bug was bisected to:

commit 36947254e5f981aeeedab1c7dfa35fc34d330e80
Author: Sean Christopherson <sean.j.christopherson@intel.com>
Date:   Tue Feb 18 21:07:32 2020 +0000

    KVM: Dynamically size memslot array based on number of used slots

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a24a5de00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12a24a5de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a24a5de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a65b3f8eec6b27650a25@syzkaller.appspotmail.com
Fixes: 36947254e5f9 ("KVM: Dynamically size memslot array based on number of used slots")

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
==================================================================
BUG: KASAN: slab-out-of-bounds in search_memslots include/linux/kvm_host.h:1051 [inline]
BUG: KASAN: slab-out-of-bounds in __gfn_to_memslot include/linux/kvm_host.h:1063 [inline]
BUG: KASAN: slab-out-of-bounds in gfn_to_memslot arch/x86/kvm/../../../virt/kvm/kvm_main.c:1597 [inline]
BUG: KASAN: slab-out-of-bounds in kvm_read_guest_page+0x4b5/0x4d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2261
Read of size 8 at addr ffff8880953fd468 by task syz-executor431/6995

CPU: 1 PID: 6995 Comm: syz-executor431 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:503
 kasan_report+0x33/0x50 mm/kasan/common.c:648
 search_memslots include/linux/kvm_host.h:1051 [inline]
 __gfn_to_memslot include/linux/kvm_host.h:1063 [inline]
 gfn_to_memslot arch/x86/kvm/../../../virt/kvm/kvm_main.c:1597 [inline]
 kvm_read_guest_page+0x4b5/0x4d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2261
 kvm_read_guest+0x51/0xd0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2284
 kvm_write_wall_clock arch/x86/kvm/x86.c:1721 [inline]
 kvm_set_msr_common+0xdf3/0x27c0 arch/x86/kvm/x86.c:2851
 vmx_set_msr+0xa83/0x26a0 arch/x86/kvm/vmx/vmx.c:2183
 __kvm_set_msr+0x15f/0x2d0 arch/x86/kvm/x86.c:1504
 __msr_io arch/x86/kvm/x86.c:3262 [inline]
 msr_io+0x173/0x290 arch/x86/kvm/x86.c:3298
 kvm_arch_vcpu_ioctl+0x1004/0x2c20 arch/x86/kvm/x86.c:4355
 kvm_vcpu_ioctl+0x866/0xe60 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3291
 kvm_vcpu_compat_ioctl+0x1ab/0x350 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3334
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:808 [inline]
 __ia32_compat_sys_ioctl+0x23d/0x2b0 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Allocated by task 6995:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:518 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:491
 kmalloc_node include/linux/slab.h:578 [inline]
 kvmalloc_node+0x61/0xf0 mm/util.c:574
 kvmalloc include/linux/mm.h:733 [inline]
 kvzalloc include/linux/mm.h:741 [inline]
 kvm_dup_memslots arch/x86/kvm/../../../virt/kvm/kvm_main.c:1101 [inline]
 kvm_set_memslot+0x115/0x1530 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1118
 __kvm_set_memory_region+0xcf7/0x1320 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1300
 kvm_set_memory_region+0x29/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1321
 kvm_vm_ioctl_set_memory_region arch/x86/kvm/../../../virt/kvm/kvm_main.c:1333 [inline]
 kvm_vm_ioctl+0x678/0x23e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3604
 kvm_vm_compat_ioctl+0x125/0x240 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3798
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:808 [inline]
 __ia32_compat_sys_ioctl+0x23d/0x2b0 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff8880953fd000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1128 bytes inside of
 2048-byte region [ffff8880953fd000, ffff8880953fd800)
The buggy address belongs to the page:
page:ffffea000254ff40 refcount:1 mapcount:0 mapping:00000000f2d13e61 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000290dd48 ffffea00029c98c8 ffff8880aa000e00
raw: 0000000000000000 ffff8880953fd000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880953fd300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880953fd380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880953fd400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
                                                          ^
 ffff8880953fd480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880953fd500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

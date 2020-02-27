Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB476C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7E2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgB0M3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:29:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:47610 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgB0M3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:29:13 -0500
Received: by mail-il1-f197.google.com with SMTP id k9so5332099ilq.14
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1hX9CnkAqsuVvMgH1/WJuPzQQnN3E6gvf1fVgRirFOQ=;
        b=Z+2h8n8ss6ggelHmPiE0VNSx9Ayn4TV/wFmBl2J8auek+DsPEExJYDbh2SZsCbuilh
         Noscu8LyJwP68fUlWMx5lBMSnY6x3N67UoxK4JectQJYoSTX1fABDZttQaak1FfN+smm
         31EhMD1tItErJHKcVk5Ecy8edy9YnKDw5p7slLWPO4tKKIn0ePSwcgbOv8WZusvh5qZK
         Gr3Tk03vzeBpTzCCKtUF1dZzeJtCNvcDU3FSEeVLKMti+bco0jSrWQjR6TB46E3HoESK
         QdsIRyyzNZOchZdCnuU54FsYlEuEeNZZGl1VpYyUsn89QCOjOXC76AZX0+PiwKrMXZVm
         yayA==
X-Gm-Message-State: APjAAAUSQzCjOanDXjqJljl9ki4jj8+iv+ObDZHLu3ZTCrdYmU3dItN6
        BrNnHpwbJHtS87XVkIg8JoI5ZEZK/2xrVN07PtDxcXYq8kGh
X-Google-Smtp-Source: APXvYqy2cbyRCVx6pgnHIddl+EsluBv98oYhGkdBItuVg2NDvX15HwBIZpdgnT2XXIeRZkUCf+KR0A/y4Wppws8m7hiwHMgft47M
MIME-Version: 1.0
X-Received: by 2002:a6b:410d:: with SMTP id n13mr4342393ioa.101.1582806553037;
 Thu, 27 Feb 2020 04:29:13 -0800 (PST)
Date:   Thu, 27 Feb 2020 04:29:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000579488059f8dde90@google.com>
Subject: KASAN: use-after-free Read in _vm_unmap_aliases
From:   syzbot <syzbot+98ec99a260552bb0d36d@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    54dedb5b Merge tag 'for-linus-5.6-rc3-tag' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fd4265e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
dashboard link: https://syzkaller.appspot.com/bug?extid=98ec99a260552bb0d36d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98ec99a260552bb0d36d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in _vm_unmap_aliases mm/vmalloc.c:1728 [inline]
BUG: KASAN: use-after-free in _vm_unmap_aliases+0x442/0x480 mm/vmalloc.c:1711
Read of size 8 at addr ffff8880a800c4e0 by task syz-executor.2/12001

CPU: 1 PID: 12001 Comm: syz-executor.2 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 _vm_unmap_aliases mm/vmalloc.c:1728 [inline]
 _vm_unmap_aliases+0x442/0x480 mm/vmalloc.c:1711
 vm_unmap_aliases+0x19/0x20 mm/vmalloc.c:1769
 change_page_attr_set_clr+0x22e/0x840 arch/x86/mm/pat/set_memory.c:1720
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1777 [inline]
 set_memory_ro+0x7b/0xa0 arch/x86/mm/pat/set_memory.c:1910
 bpf_jit_binary_lock_ro include/linux/filter.h:797 [inline]
 bpf_int_jit_compile+0xebd/0x12ce arch/x86/net/bpf_jit_comp.c:1807
 bpf_prog_select_runtime+0x4b9/0x850 kernel/bpf/core.c:1799
 bpf_migrate_filter net/core/filter.c:1275 [inline]
 bpf_prepare_filter net/core/filter.c:1323 [inline]
 bpf_prepare_filter+0x977/0xd60 net/core/filter.c:1289
 __get_filter+0x212/0x2c0 net/core/filter.c:1492
 sk_attach_filter+0x1e/0xa0 net/core/filter.c:1507
 sock_setsockopt+0x1f66/0x22d0 net/core/sock.c:999
 __sys_setsockopt+0x440/0x4c0 net/socket.c:2126
 __do_sys_setsockopt net/socket.c:2146 [inline]
 __se_sys_setsockopt net/socket.c:2143 [inline]
 __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2143
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c429
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f65946fdc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f65946fe6d4 RCX: 000000000045c429
RDX: 000000000000001a RSI: 0000000000000001 RDI: 0000000000000004
RBP: 000000000076bf20 R08: 0000000000000010 R09: 0000000000000000
R10: 0000000020000480 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000a4f R14: 00000000004ccb47 R15: 000000000076bf2c

Allocated by task 12001:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:523
 slab_post_alloc_hook mm/slab.h:584 [inline]
 slab_alloc_node mm/slab.c:3263 [inline]
 kmem_cache_alloc_node+0x138/0x740 mm/slab.c:3575
 alloc_vmap_area+0x147/0x2080 mm/vmalloc.c:1116
 new_vmap_block mm/vmalloc.c:1514 [inline]
 vb_alloc mm/vmalloc.c:1662 [inline]
 vm_map_ram+0x554/0xc60 mm/vmalloc.c:1828
 ion_heap_clear_pages+0x2b/0x70 drivers/staging/android/ion/ion_heap.c:102
 ion_heap_sglist_zero+0x210/0x270 drivers/staging/android/ion/ion_heap.c:123
 ion_heap_buffer_zero+0xf5/0x150 drivers/staging/android/ion/ion_heap.c:145
 ion_system_heap_free+0x1eb/0x250 drivers/staging/android/ion/ion_system_heap.c:163
 ion_buffer_destroy+0x159/0x2d0 drivers/staging/android/ion/ion.c:93
 _ion_heap_freelist_drain+0x304/0x480 drivers/staging/android/ion/ion_heap.c:201
 ion_heap_freelist_drain+0x20/0x30 drivers/staging/android/ion/ion_heap.c:211
 ion_buffer_create drivers/staging/android/ion/ion.c:56 [inline]
 ion_alloc drivers/staging/android/ion/ion.c:369 [inline]
 ion_ioctl+0x9e3/0xd20 drivers/staging/android/ion/ion.c:495
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x123/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 2692:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kmem_cache_free+0x86/0x320 mm/slab.c:3694
 merge_or_add_vmap_area mm/vmalloc.c:733 [inline]
 __purge_vmap_area_lazy+0xf3b/0x1ef0 mm/vmalloc.c:1325
 _vm_unmap_aliases mm/vmalloc.c:1746 [inline]
 _vm_unmap_aliases+0x396/0x480 mm/vmalloc.c:1711
 vm_remove_mappings mm/vmalloc.c:2279 [inline]
 __vunmap+0x4a1/0x950 mm/vmalloc.c:2306
 __vfree+0x41/0xd0 mm/vmalloc.c:2363
 vfree+0x5f/0x90 mm/vmalloc.c:2393
 module_memfree+0x17/0x30
 bpf_jit_free_exec+0x16/0x20
 bpf_jit_free+0xc9/0x1c0
 bpf_prog_free_deferred+0x333/0x450 kernel/bpf/core.c:2089
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff8880a800c4e0
 which belongs to the cache vmap_area of size 64
The buggy address is located 0 bytes inside of
 64-byte region [ffff8880a800c4e0, ffff8880a800c520)
The buggy address belongs to the page:
page:ffffea0002a00300 refcount:1 mapcount:0 mapping:ffff8880aa412e00 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000280f0c8 ffffea00029f9f88 ffff8880aa412e00
raw: 0000000000000000 ffff8880a800c000 000000010000002a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a800c380: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
 ffff8880a800c400: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8880a800c480: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
                                                       ^
 ffff8880a800c500: fb fb fb fb fc fc fc fc fb fb fb fb fb fb fb fb
 ffff8880a800c580: fc fc fc fc fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

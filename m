Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8C3C2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C943218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgIHHhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:37:42 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:42874 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgIHHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:37:22 -0400
Received: by mail-il1-f207.google.com with SMTP id f67so11429342ilf.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pvUpq/ObMmVwXiLGMlBpVNBtOI8dv6BvyLH9KNZA9N0=;
        b=n9byARDZ7LTYwT9DhSUbO+m5/46SmcYj8sB63CxnHQufyRhSgdwh3EI7apQ/t/9Lbs
         Kxv/Hh+CwUf0e4Ei+p9zQWCzfUNwsH1qkvClti/4KKKsIs0uVsxI0lBNcQCA61dDtKc6
         tiQbWM8V4Yc4ThbWikGeeVdbP+Sm6dRLyijBsHo8fJCAhgDp85Zug98UhYnD3REd1itl
         QL/pjg6tP3mIIgpPbTz34UFU2m1FLZHbQiYj+vVMGvZkOpfcxL2SexJHV3oPP4EllmI5
         lzhwF78MXMfDUnYdLKZ31/3igvZAGifOPz6rqKwPH68CrXpSfMRnoK1buL36oRBJqtDt
         lv/g==
X-Gm-Message-State: AOAM532dVMmhPiQ5dC60ORNrP+NNlbWletmA3G+ke2eZPDYxNRxDPAa7
        +8yWAJGFHawm16CESrg9IxJrIph9RycZnHftZKu5t/3Uwpps
X-Google-Smtp-Source: ABdhPJyNd3NSua6L8GQ3Q4Q8tWC6ODQQfJOaxS5tGm3VR7clNd2DPJ0QiFKZyvKPPWEUd8uO/TS8mzvVmvKHSg+loASz3Bbsrduy
MIME-Version: 1.0
X-Received: by 2002:a92:d482:: with SMTP id p2mr22776410ilg.9.1599550640600;
 Tue, 08 Sep 2020 00:37:20 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:37:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbbbcf05aec86741@google.com>
Subject: KASAN: slab-out-of-bounds Write in usb_hcd_poll_rh_status (2)
From:   syzbot <syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andreyknvl@google.com,
        dvyukov@google.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.szyprowski@samsung.com, noring@nocrew.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b51594df Merge tag 'docs-5.9-3' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149d38ae900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6a2b06f131ab9849f
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae6a2b06f131ab9849f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: slab-out-of-bounds in usb_hcd_poll_rh_status+0x376/0x780 drivers/usb/core/hcd.c:775
Write of size 2 at addr ffff88809f5ef480 by task syz-executor.4/6857

CPU: 1 PID: 6857 Comm: syz-executor.4 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x39/0x60 mm/kasan/common.c:106
 memcpy include/linux/string.h:406 [inline]
 usb_hcd_poll_rh_status+0x376/0x780 drivers/usb/core/hcd.c:775
 call_timer_fn+0x1ac/0x760 kernel/time/timer.c:1413
 expire_timers kernel/time/timer.c:1458 [inline]
 __run_timers.part.0+0x67c/0xaa0 kernel/time/timer.c:1755
 __run_timers kernel/time/timer.c:1736 [inline]
 run_timer_softirq+0xae/0x1a0 kernel/time/timer.c:1768
 __do_softirq+0x1f7/0xa91 kernel/softirq.c:298
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 do_softirq_own_stack+0x9d/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:393 [inline]
 __irq_exit_rcu kernel/softirq.c:423 [inline]
 irq_exit_rcu+0x235/0x280 kernel/softirq.c:435
 sysvec_apic_timer_interrupt+0x51/0xf0 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:581
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:770 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x4d/0x90 kernel/locking/spinlock.c:191
Code: 48 c7 c0 48 3c b6 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 3c 48 83 3d 12 f5 bf 01 00 74 29 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 f4 6d 59 f9 65 8b 05 2d b7 0b 78
RSP: 0018:ffffc90004e0f740 EFLAGS: 00000282
RAX: 1ffffffff136c789 RBX: 0000000000000282 RCX: 1ffffffff1563f69
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000282
RBP: ffffffff8cc156b8 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888037a37270
R13: 1ffff920009c1efa R14: ffffffff8cc156b8 R15: ffffffff8cc156b0
 __debug_object_init+0x401/0xce0 lib/debugobjects.c:580
 debug_object_init lib/debugobjects.c:595 [inline]
 debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:681
 debug_rcu_head_queue kernel/rcu/rcu.h:176 [inline]
 __call_rcu kernel/rcu/tree.c:2880 [inline]
 call_rcu+0x2c/0x7b0 kernel/rcu/tree.c:2968
 destroy_inode+0x129/0x1b0 fs/inode.c:287
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 proc_invalidate_siblings_dcache+0x28d/0x600 fs/proc/inode.c:160
 release_task+0xc63/0x14d0 kernel/exit.c:221
 wait_task_zombie kernel/exit.c:1088 [inline]
 wait_consider_task+0x2fb3/0x3b20 kernel/exit.c:1315
 do_wait_thread kernel/exit.c:1378 [inline]
 do_wait+0x36a/0x9e0 kernel/exit.c:1449
 kernel_wait4+0x14c/0x260 kernel/exit.c:1621
 __do_sys_wait4+0x13f/0x150 kernel/exit.c:1649
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4171fb
Code: 54 55 41 89 d4 53 48 89 f5 89 fb 48 83 ec 10 e8 1b f9 ff ff 45 31 d2 41 89 c0 49 63 d4 48 89 ee 48 63 fb b8 3d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 19 44 89 c7 89 44 24 0c e8 51 f9 ff ff 8b 44
RSP: 002b:00007ffff8e9d6c0 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00000000004171fb
RDX: 0000000040000001 RSI: 00007ffff8e9d720 RDI: ffffffffffffffff
RBP: 00007ffff8e9d720 R08: 0000000000000000 R09: 000000000267c940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000040000001
R13: 00007ffff8e9d720 R14: 000000000012605c R15: 00007ffff8e9d730

Allocated by task 31714:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3655 [inline]
 __kmalloc+0x1b0/0x310 mm/slab.c:3664
 kmalloc include/linux/slab.h:559 [inline]
 proc_do_submiturb+0x29a3/0x34d0 drivers/usb/core/devio.c:1733
 proc_submiturb drivers/usb/core/devio.c:1892 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2588 [inline]
 usbdev_ioctl+0x682/0x3360 drivers/usb/core/devio.c:2708
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88809f5ef480
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff88809f5ef480, ffff88809f5ef4a0)
The buggy address belongs to the page:
page:00000000686f7d13 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88809f5effc1 pfn:0x9f5ef
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00029f1e08 ffffea0002684648 ffff8880aa040100
raw: ffff88809f5effc1 ffff88809f5ef000 000000010000003b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809f5ef380: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88809f5ef400: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff88809f5ef480: 01 fc fc fc fc fc fc fc 00 00 00 fc fc fc fc fc
                   ^
 ffff88809f5ef500: fa fb fb fb fc fc fc fc 00 00 fc fc fc fc fc fc
 ffff88809f5ef580: 00 00 fc fc fc fc fc fc 00 00 fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

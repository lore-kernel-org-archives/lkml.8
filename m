Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0517BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC4A2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHUA1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:27:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48280 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUA1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:27:15 -0400
Received: by mail-io1-f70.google.com with SMTP id k10so44131iow.15
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 17:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5m5kdsQS1UuVjSBB6gdS1S0aUbyc8j9RG73oipEn5Ks=;
        b=BpG4tW3J/A+zRwolJwLcuwzB/PNwylJsVBAlaosbIxhzFbZgcJQYc/Sz59qTjAAbgQ
         3tUSvecqLiz0T4N/8VRMoeyCBzSjDEvP+U5BdOSDffH12o5KQafHryKNo9en7IPcnrWy
         BEHJlfLPAQnJ9G6ig8grHJdbvesg48iqigOyzRx6vMxRfTXb1ixe5HNc50/eda2k10tt
         FORwXgdOgPt+hnZX7Pju8JjxRX33vxo1Ywk7dyjLghL8CP30dWnEcNci+Gyh6j7kktq0
         4mo5eDkhrKAJYuiwzbnxYlndCywtG1kK7EMevGqeKpq9xV51uBNHzDHANe4WttsIF4z/
         IF8g==
X-Gm-Message-State: AOAM533YKM1hLE2ZQmF2jACuAtGX4QRdHWkQ8dYQZpVKYCwRx1ZO1o0e
        QLUG2ISTZmizRPOee9c4qz4JwvOjuswqMlkz8cmfDP02JYrj
X-Google-Smtp-Source: ABdhPJwqCTnqdZQ1vfYGnY3mVFDjkEwtNZnJaVyGsA7+J28LsWuXyPGXlp/grZWAzY2+jx73Ob5ywUDtihu/kYZCtjCPNPxxslLr
MIME-Version: 1.0
X-Received: by 2002:a92:d403:: with SMTP id q3mr472818ilm.158.1597969633655;
 Thu, 20 Aug 2020 17:27:13 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:27:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006040a805ad584c37@google.com>
Subject: KASAN: slab-out-of-bounds Write in vcs_read
From:   syzbot <syzbot+6d6e5b894ac34506362f@syzkaller.appspotmail.com>
To:     bp@alien8.de, gregkh@linuxfoundation.org, hpa@zytor.com,
        jirislaby@kernel.org, jslaby@suse.com, jslaby@suse.cz,
        linux-kernel@vger.kernel.org, mingo@redhat.com, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    605cbf3d Add linux-next specific files for 20200820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163dc80e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61d44f28687f508
dashboard link: https://syzkaller.appspot.com/bug?extid=6d6e5b894ac34506362f
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bf6791900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14019672900000

The issue was bisected to:

commit b1c32fcfadf5593ab7a63261cc8a5747c36e627e
Author: Jiri Slaby <jslaby@suse.cz>
Date:   Tue Aug 18 08:57:05 2020 +0000

    vc_screen: extract vcs_read_buf_header

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1070fe7e900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1270fe7e900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1470fe7e900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d6e5b894ac34506362f@syzkaller.appspotmail.com
Fixes: b1c32fcfadf5 ("vc_screen: extract vcs_read_buf_header")

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KASAN: slab-out-of-bounds in vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
BUG: KASAN: slab-out-of-bounds in vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
Write of size 2 at addr ffff8880a47ef000 by task syz-executor776/6833

CPU: 0 PID: 6833 Comm: syz-executor776 Not tainted 5.9.0-rc1-next-20200820-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
 vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
 vfs_read+0x1df/0x5a0 fs/read_write.c:479
 ksys_read+0x12d/0x250 fs/read_write.c:607
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440bb9
Code: 26 02 00 85 c0 b8 00 00 00 00 48 0f 44 c3 5b c3 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b 0f fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffed959bbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440bb9
RDX: 0000000000002020 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007ffed959bc00 R08: 0000000120080522 R09: 0000000120080522
R10: 0000000120080522 R11: 0000000000000246 R12: 0000000000401fe0
R13: 0000000000402070 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 1:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:517 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x138/0x3a0 mm/slab.c:3482
 kmem_cache_zalloc include/linux/slab.h:656 [inline]
 __alloc_file+0x21/0x350 fs/file_table.c:101
 alloc_empty_file+0x6d/0x170 fs/file_table.c:151
 path_openat+0xe3/0x2730 fs/namei.c:3354
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_open fs/open.c:1192 [inline]
 __se_sys_open fs/open.c:1188 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1188
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 16:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 rcu_do_batch kernel/rcu/tree.c:2474 [inline]
 rcu_core+0x5df/0x11e0 kernel/rcu/tree.c:2709
 __do_softirq+0x2de/0xa24 kernel/softirq.c:298

Last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2951 [inline]
 call_rcu+0x14f/0x7f0 kernel/rcu/tree.c:3025
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:139 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:166
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:241
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_record_aux_stack+0x82/0xb0 mm/kasan/generic.c:346
 __call_rcu kernel/rcu/tree.c:2951 [inline]
 call_rcu+0x14f/0x7f0 kernel/rcu/tree.c:3025
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:139 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:166
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:241
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a47ef0c0
 which belongs to the cache filp of size 488
The buggy address is located 192 bytes to the left of
 488-byte region [ffff8880a47ef0c0, ffff8880a47ef2a8)
The buggy address belongs to the page:
page:00000000717406a1 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa47ef
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00025060c8 ffffea00027ea248 ffff88821bc47b00
raw: 0000000000000000 ffff8880a47ef0c0 0000000100000006 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a47eef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a47eef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880a47ef000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880a47ef080: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff8880a47ef100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

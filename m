Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECECC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 01:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB222075D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 01:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDBFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 21:05:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39204 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDBFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 21:05:19 -0400
Received: by mail-il1-f197.google.com with SMTP id f66so17448229ilh.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 18:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gyimrFW8N8HurghzvlumW87t4rscz22JH1NcatkYUsQ=;
        b=ruQKzCyp9BRL1ZVKOTREg5RzmF+ImuWPFCP3+hjxKuSh5x1z2hCk3g0bOL+XyfNbNs
         te3nepBys0rDYtox+lEey38bLTQDxAm8pb6LzeCjFhxEsSoIwdEzeLDrBafwIJ+ntpqx
         /ViwGaI6iPFpfwijQxauUcsEQVOnB2x6YVx51DLnbfho/tC0OtRtWTpAow/MNtcPPU0I
         IPxpFCgCT1Z2cFpNjTzpBEKdxA3r2ZlzXQuU8N58NhspqV8+xJo4ItOD6P/61ok63o34
         caaXdl2wd6fZZzt8DSh+PJH6BXYUMs5lcH8f5gKgl+H4KdepJ2TyM63ZXXKf5RguxF3T
         PYoA==
X-Gm-Message-State: AOAM530+lrHLz9SczRccS4GiizQwc9reWHnZPwsmeMfnRg4Qf75JY9k3
        W1hbrdD4p7ebbcl+DooXRy5QzJFZj7IWPXYicxjN5fCAwk2G
X-Google-Smtp-Source: ABdhPJxRhAcQkrwYGgxpeJjnSl4wQUw5TqClf6gGEKNbkcvgoYpvHTixRe5DxK9nH0mLlakxM1DWfYbL7iIImUurdPl+25HksYGf
MIME-Version: 1.0
X-Received: by 2002:a5d:9a97:: with SMTP id c23mr15177776iom.179.1593824718548;
 Fri, 03 Jul 2020 18:05:18 -0700 (PDT)
Date:   Fri, 03 Jul 2020 18:05:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ef21705a9933cf3@google.com>
Subject: KASAN: out-of-bounds Read in csd_lock_record
From:   syzbot <syzbot+98af0465c818c8b093e9@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17667097100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=98af0465c818c8b093e9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16def937100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1324dc83100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98af0465c818c8b093e9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in csd_lock_record+0xcb/0xe0 kernel/smp.c:118
Read of size 8 at addr ffffc90001677830 by task syz-executor014/30713

CPU: 0 PID: 30713 Comm: syz-executor014 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 csd_lock_record+0xcb/0xe0 kernel/smp.c:118
 flush_smp_call_function_queue+0x285/0x730 kernel/smp.c:391
 __sysvec_call_function_single+0x98/0x490 arch/x86/kernel/smp.c:248
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_call_function_single+0xe0/0x120 arch/x86/kernel/smp.c:243
 asm_sysvec_call_function_single+0x12/0x20 arch/x86/include/asm/idtentry.h:604
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:qlink_free mm/kasan/quarantine.c:151 [inline]
RIP: 0010:qlist_free_all+0xfc/0x140 mm/kasan/quarantine.c:167
Code: 50 08 48 8d 4a ff 83 e2 01 48 0f 45 c1 4c 8b 70 18 e9 40 ff ff ff e8 c3 27 c6 ff 48 83 3d eb 55 01 08 00 74 36 4c 89 ff 57 9d <0f> 1f 44 00 00 4d 85 e4 75 9e 49 c7 45 08 00 00 00 00 49 c7 45 00
RSP: 0018:ffffc90005537ad8 EFLAGS: 00000282
RAX: 0000000000000c29 RBX: ffff888090e0da80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880a2fa9780
R13: ffffc90005537b10 R14: ffff8880aa00fc00 R15: 0000000000000282
 quarantine_reduce+0x17e/0x200 mm/kasan/quarantine.c:260
 __kasan_kmalloc.constprop.0+0x9e/0xd0 mm/kasan/common.c:475
 slab_post_alloc_hook mm/slab.h:535 [inline]
 slab_alloc mm/slab.c:3316 [inline]
 kmem_cache_alloc+0x148/0x550 mm/slab.c:3486
 __d_alloc+0x2a/0x920 fs/dcache.c:1709
 d_alloc_pseudo+0x19/0x70 fs/dcache.c:1838
 alloc_file_pseudo+0xc6/0x250 fs/file_table.c:226
 anon_inode_getfile fs/anon_inodes.c:91 [inline]
 anon_inode_getfile+0xc8/0x1f0 fs/anon_inodes.c:74
 anon_inode_getfd+0x4c/0xa0 fs/anon_inodes.c:136
 bpf_map_new_fd kernel/bpf/syscall.c:686 [inline]
 bpf_map_new_fd kernel/bpf/syscall.c:678 [inline]
 map_create kernel/bpf/syscall.c:872 [inline]
 __do_sys_bpf+0xe6d/0x4b10 kernel/bpf/syscall.c:4094
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:367
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447e79
Code: Bad RIP value.
RSP: 002b:00007f0e1d49fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000006e39e8 RCX: 0000000000447e79
RDX: 000000000000003c RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00000000006e39e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e39ec
R13: 00007fff7cf05b0f R14: 00007f0e1d4a09c0 R15: 0000000000000000


Memory state around the buggy address:
 ffffc90001677700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001677780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90001677800: f1 f1 f1 f1 00 00 00 00 f3 f3 f3 f3 00 00 00 00
                                     ^
 ffffc90001677880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001677900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13CBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0420888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbgEZVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:13:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:35370 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388900AbgEZVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:13:20 -0400
Received: by mail-io1-f72.google.com with SMTP id j23so7616494iok.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=d/opsyg6P68qUcmF2AaQjfQXGJfYKMSmkiH5N83ZilM=;
        b=BjWJP9XLamgzHZUBlzGCYO9ogFgjh0E8m/dja5EZgSwTfsfke9MiWb0DatBDd21MVn
         Bpt7WE2o4jW8ABlWtFyfryYL0fu3Ki5NxSmh6bYu4dqrqk4nwKj49CuxUDwpaJxF50Nv
         WjwfQDUPnmlKUvM65eFvFYyxGKOEl3zAO1n/5nDG1/1AxFRsXp11vNduCXa7TDPEOYCy
         +2GpiE3RAq9S9w6iimI23cfG4TPy22/2GYyTP5D4RN0bSbOY5Ugfr/4xNP5+H/rQa+W6
         UcOD32Z+8K0pUa4eIIXm+CAoFgipgWrvhZ53PLMVSVYahtliCwMbsxchhgqNAh5nSGcq
         +TMA==
X-Gm-Message-State: AOAM532Iq8wERwXy1sW5Q9RumS7QifOCkbFoLw+8jiyMxT5CFztIFtMg
        ZoMU/wgDKqYF6CyKvAspw+CGvEcKiCb3kSGleQ1bd8L2IWVe
X-Google-Smtp-Source: ABdhPJw1CiAGcwNbK5PD98mpmirqOzvmYCD2NlVZHOGc8x6miwhS76cn/jW9cCyA2fxosgwjc01toO44LzxERZgTaz7eyKVp/f5t
MIME-Version: 1.0
X-Received: by 2002:a92:5e07:: with SMTP id s7mr268955ilb.266.1590527599532;
 Tue, 26 May 2020 14:13:19 -0700 (PDT)
Date:   Tue, 26 May 2020 14:13:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000935ffd05a6939060@google.com>
Subject: kernel BUG at arch/x86/kvm/mmu/mmu.c:LINE! (2)
From:   syzbot <syzbot+904752567107eefb728c@syzkaller.appspotmail.com>
To:     bp@alien8.de, eesposit@redhat.com, gregkh@linuxfoundation.org,
        hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rafael@kernel.org,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c11d28ab Add linux-next specific files for 20200522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=153b5016100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
dashboard link: https://syzkaller.appspot.com/bug?extid=904752567107eefb728c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11510cba100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129301e2100000

The bug was bisected to:

commit 63d04348371b7ea4a134bcf47c79763d969e9168
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Mar 31 22:42:22 2020 +0000

    KVM: x86: move kvm_create_vcpu_debugfs after last failure point

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1226e8ee100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1126e8ee100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1626e8ee100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+904752567107eefb728c@syzkaller.appspotmail.com
Fixes: 63d04348371b ("KVM: x86: move kvm_create_vcpu_debugfs after last failure point")

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
------------[ cut here ]------------
kernel BUG at arch/x86/kvm/mmu/mmu.c:3722!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6784 Comm: syz-executor805 Not tainted 5.7.0-rc6-next-20200522-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mmu_alloc_direct_roots arch/x86/kvm/mmu/mmu.c:3722 [inline]
RIP: 0010:mmu_alloc_roots arch/x86/kvm/mmu/mmu.c:3822 [inline]
RIP: 0010:kvm_mmu_load+0xbfa/0xe00 arch/x86/kvm/mmu/mmu.c:5155
Code: 9c 5f 99 00 48 8b 44 24 08 e9 cf f5 ff ff e8 5d 5f 99 00 e9 b7 f4 ff ff 4c 89 f7 e8 80 5f 99 00 e9 78 f4 ff ff e8 16 4c 5a 00 <0f> 0b 48 89 df e8 6c 5f 99 00 e9 7e f8 ff ff e8 62 5f 99 00 e9 c4
RSP: 0018:ffffc90000f77b10 EFLAGS: 00010293
RAX: ffff8880a1348340 RBX: 0000000000000000 RCX: ffffffff81195061
RDX: 0000000000000000 RSI: ffffffff81195b4a RDI: 0000000000000001
RBP: ffff888095110040 R08: ffff8880a1348340 R09: ffffed1015cc717c
R10: ffff8880ae638bdb R11: ffffed1015cc717b R12: 0000000000000000
R13: 0000000000000001 R14: ffff888095110458 R15: 0000000000000000
FS:  0000000002160880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3dffa2010 CR3: 000000008fb39000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kvm_mmu_reload arch/x86/kvm/mmu.h:81 [inline]
 vcpu_enter_guest arch/x86/kvm/x86.c:8385 [inline]
 vcpu_run arch/x86/kvm/x86.c:8596 [inline]
 kvm_arch_vcpu_ioctl_run+0x4022/0x6920 arch/x86/kvm/x86.c:8819
 kvm_vcpu_ioctl+0x46a/0xe20 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3149
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4401f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffedfd41fc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401f9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401a80
R13: 0000000000401b10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 2d2ab0eef7b13e8d ]---
RIP: 0010:mmu_alloc_direct_roots arch/x86/kvm/mmu/mmu.c:3722 [inline]
RIP: 0010:mmu_alloc_roots arch/x86/kvm/mmu/mmu.c:3822 [inline]
RIP: 0010:kvm_mmu_load+0xbfa/0xe00 arch/x86/kvm/mmu/mmu.c:5155
Code: 9c 5f 99 00 48 8b 44 24 08 e9 cf f5 ff ff e8 5d 5f 99 00 e9 b7 f4 ff ff 4c 89 f7 e8 80 5f 99 00 e9 78 f4 ff ff e8 16 4c 5a 00 <0f> 0b 48 89 df e8 6c 5f 99 00 e9 7e f8 ff ff e8 62 5f 99 00 e9 c4
RSP: 0018:ffffc90000f77b10 EFLAGS: 00010293
RAX: ffff8880a1348340 RBX: 0000000000000000 RCX: ffffffff81195061
RDX: 0000000000000000 RSI: ffffffff81195b4a RDI: 0000000000000001
RBP: ffff888095110040 R08: ffff8880a1348340 R09: ffffed1015cc717c
R10: ffff8880ae638bdb R11: ffffed1015cc717b R12: 0000000000000000
R13: 0000000000000001 R14: ffff888095110458 R15: 0000000000000000
FS:  0000000002160880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3dffa6000 CR3: 000000008fb39000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

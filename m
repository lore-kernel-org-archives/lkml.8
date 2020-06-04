Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35978C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B586206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgFDM3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:29:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50661 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFDM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:29:19 -0400
Received: by mail-io1-f69.google.com with SMTP id n123so3475687iod.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AlbwxFjbm5yCx3OpeR1Nb/B11dfQbBr/ymx+9x3yl64=;
        b=LKlCQBIEtLG66bA8yYQyHDwHeeEQEDM3UYAF0BXyV28Y/zNWqt8oy7Y0XmYWiH1Bc+
         j1DXMZI5j5H64RnlTAJDKSJUkqlyFG4cBeoL3DfAtah/dILl1g5ztkMAsJ45oDglHuB0
         mcRgsfzYzMwkXb/Zbir/HWvePfBrL2oTSfLfQPN0JjShiqMJx6PFF16R0fFnvboK3LZi
         ScWtXAUATlDrhP6MFZvYfMHoeCm/XNrWqqoz6CHsSIKYK6JfaDknOLMzcbcF8NWyATj1
         2gMg7E0joOPyT+NEyzgPI1aWOSN4gT3vD4fxeKJpGM2PBI7K1JUynB2AYNAfQYXTbj4M
         3/8A==
X-Gm-Message-State: AOAM5302CYc3PzM38V2LKhIt+Ba+Ahc3WT3pxalLieTk11uBs/tfFJCc
        W+v3Gv9PqCdvVVylEWRtkubn0tyOmxjI9WvhPEKIsZPpiybO
X-Google-Smtp-Source: ABdhPJxCg+KiGlDvT6Kps3y2XwgvWBZll6RroUacEE2le0Jc3whUVavrgHcKzDVoi70xsKFiII2tEHcW9NYwTX/pFJS6mI+pwT8b
MIME-Version: 1.0
X-Received: by 2002:a5d:914d:: with SMTP id y13mr3867437ioq.48.1591273758129;
 Thu, 04 Jun 2020 05:29:18 -0700 (PDT)
Date:   Thu, 04 Jun 2020 05:29:18 -0700
In-Reply-To: <000000000000e8226505a69ab3c7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001803d305a7414b66@google.com>
Subject: Re: general protection fault in start_creating
From:   syzbot <syzbot+705f4401d5a93a59b87d@syzkaller.appspotmail.com>
To:     eesposit@redhat.com, gregkh@linuxfoundation.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    cb8e59cc Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170f49de100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a16ddbc78955e3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=705f4401d5a93a59b87d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1367410e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e07e0e100000

The bug was bisected to:

commit 63d04348371b7ea4a134bcf47c79763d969e9168
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Mar 31 22:42:22 2020 +0000

    KVM: x86: move kvm_create_vcpu_debugfs after last failure point

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1366069a100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10e6069a100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1766069a100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+705f4401d5a93a59b87d@syzkaller.appspotmail.com
Fixes: 63d04348371b ("KVM: x86: move kvm_create_vcpu_debugfs after last failure point")

general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
CPU: 0 PID: 19367 Comm: syz-executor088 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xe1b/0x4a70 kernel/locking/lockdep.c:4250
Code: 91 0a 41 be 01 00 00 00 0f 86 ce 0b 00 00 89 05 4b 9a 91 0a e9 c3 0b 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 d2 48 c1 ea 03 <80> 3c 02 00 0f 85 57 2e 00 00 49 81 3a c0 74 c0 8b 0f 84 b0 f2 ff
RSP: 0018:ffffc90004b477b8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000150 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8880a77c2200 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9f3c6e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d5bb0 CR3: 00000000821f9000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4959
 down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
 inode_lock include/linux/fs.h:799 [inline]
 start_creating+0xa8/0x250 fs/debugfs/inode.c:334
 __debugfs_create_file+0x62/0x400 fs/debugfs/inode.c:383
 kvm_arch_create_vcpu_debugfs+0x9f/0x200 arch/x86/kvm/debugfs.c:52
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
RIP: 0033:0x44e5d9
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b 05 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9f3c6e4ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006eaa08 RCX: 000000000044e5d9
RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
RBP: 00000000006eaa00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006eaa0c
R13: 00007ffe67678f9f R14: 00007f9f3c6e59c0 R15: 20c49ba5e353f7cf
Modules linked in:
---[ end trace b7d92d5fd0bd5c5f ]---
RIP: 0010:__lock_acquire+0xe1b/0x4a70 kernel/locking/lockdep.c:4250
Code: 91 0a 41 be 01 00 00 00 0f 86 ce 0b 00 00 89 05 4b 9a 91 0a e9 c3 0b 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 d2 48 c1 ea 03 <80> 3c 02 00 0f 85 57 2e 00 00 49 81 3a c0 74 c0 8b 0f 84 b0 f2 ff
RSP: 0018:ffffc90004b477b8 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000150 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8880a77c2200 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f9f3c6e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004d5bb0 CR3: 00000000821f9000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


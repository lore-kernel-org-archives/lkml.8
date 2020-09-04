Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F774C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD328206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgIDITY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:19:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55288 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbgIDITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:19:15 -0400
Received: by mail-io1-f72.google.com with SMTP id o18so3866204ioa.21
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 01:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bwSXulhCcQyV7AuhlU82y6Tsm3g1/PCAC2F+fcBSu6k=;
        b=tE2pApEJLhYDQVfLSqBZpVxvAjGOjDoQrr/wI83xftcNnsLE5j/ExVdY/E0Zs7jmec
         srF0tKi/g5kpb+fM9H882+/BXeaWkFytT5uy1RtB8eV+sqb6X6pAxD9qatO6VbJqwtQx
         eFQWKQFYjA3cCeZ0bzBgrMbAG7ox6VF5tlynLVnTuZXqjxe6oURhGlQlZ/qu4HkNtJUw
         nT25NTNFClWSw7VYfDKKOXoGlP3xrYZjY2SruV8HAbIpiJ7+4JIwV5r9re+VgJZdNQrE
         PPP9gPY6oH2708xBNLlyWieunH88k4bSBW7F03V+R/sOsVQ/wb5951hOqx7bVWAhCQtf
         y/UQ==
X-Gm-Message-State: AOAM531O2Xrdf3w+Nv0uLO+xQwPjf8vxSyDu9QDwBZIjDbP4Un9i+sd2
        6NmysAavimmCJgIGfGKzaRALNOIVIoX9sVcSUSMy9veABMgb
X-Google-Smtp-Source: ABdhPJwemv9fiQCfkmqcEXv56wSBlE1yLeO2BIXik60Xhsi2PmbmHJogsvQhAOkU4efkdDLnFjcjfVCH6J9V+SniXgEsDtxHCfiy
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48f:: with SMTP id y15mr6717077iov.177.1599207554224;
 Fri, 04 Sep 2020 01:19:14 -0700 (PDT)
Date:   Fri, 04 Sep 2020 01:19:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031163605ae78866f@google.com>
Subject: WARNING in handle_desc (2)
From:   syzbot <syzbot+6157aa3cd948b7a811ab@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1483ac85900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=6157aa3cd948b7a811ab
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6157aa3cd948b7a811ab@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 32353 at arch/x86/kvm/vmx/vmx.c:4965 handle_desc+0x5a/0x70 arch/x86/kvm/vmx/vmx.c:4965
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 32353 Comm: syz-executor.4 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:handle_desc+0x5a/0x70 arch/x86/kvm/vmx/vmx.c:4965
Code: ff 81 e3 00 08 00 00 48 89 de e8 91 c5 59 00 48 85 db 74 11 e8 e7 c8 59 00 48 89 ef 5b 31 f6 5d e9 db 87 f4 ff e8 d6 c8 59 00 <0f> 0b eb e6 e8 1d db 99 00 eb c3 90 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc90017d67b98 EFLAGS: 00010216
RAX: 00000000000033f4 RBX: 0000000000000000 RCX: ffffc90010d96000
RDX: 0000000000040000 RSI: ffffffff811a822a RDI: 0000000000000007
RBP: ffff8880973d83c0 R08: 0000000000000000 R09: ffffffff8c5f1ac7
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff811a81d0
R13: ffff8880973d83f8 R14: 000000000000002e R15: 0000000000000000
 vmx_handle_exit+0x293/0x14c0 arch/x86/kvm/vmx/vmx.c:6118
 vcpu_enter_guest+0x18f4/0x3c20 arch/x86/kvm/x86.c:8638
 vcpu_run arch/x86/kvm/x86.c:8703 [inline]
 kvm_arch_vcpu_ioctl_run+0x440/0x1780 arch/x86/kvm/x86.c:8920
 kvm_vcpu_ioctl+0x467/0xdf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3230
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f925f9c9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000011880 RCX: 000000000045d5b9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
RBP: 000000000118cf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffc7b03146f R14: 00007f925f9ca9c0 R15: 000000000118cf4c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

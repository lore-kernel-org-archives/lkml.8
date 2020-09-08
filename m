Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4353C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFF0218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgIHHd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:33:29 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:51673 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgIHHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:33:20 -0400
Received: by mail-il1-f206.google.com with SMTP id i80so487866ild.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Qdoy1fNxR3DbTJRTFFfZS+5ZeYZDGPLwqlgNTZKWLDU=;
        b=R+U3Dl2jro8DBzboTEdG/IHlua+7hz/unXV1quFEafATRc9ccYlScM1h6qxONLqYIn
         h3kkdYfLjy+GlZQ7bCCi4C7h3plsnFjBIzqvJflnKqmwLJy4jHQwWX0RdKm0MGXIeX4x
         97BatmX7Fd4jxzV95VbyKSEJEaYopp/IcumReW8L36LKrrg6PrRcsl5DJESlnqmHTmgH
         UZig8L8iQCv+++MxmOX++3+GT5rEVVOkZHMBx104sp6EFsR7YGjCS7kxKBiMHvBunvF2
         KKyLN6f4+96UG1mZaXkqYESkN7dE3nsg7aI94y50IkrbA4inhoU66N8SbbDmS/MY6eqq
         gbUg==
X-Gm-Message-State: AOAM530FqWUVIpH0K7qXNaX+BgTsu0ku6c+rKDO3FDzWk/w/H2gZ4i2Z
        LUUSILZS0qMG+oSVwOZs+OqcwV0BDkQH9HdvBIA9KynHaaZW
X-Google-Smtp-Source: ABdhPJzNnCpdH5w3DalyoAVHVYiUvdBRPjrYY6mrYRfFNWcBJhzvqUZZ8/+vQ61IuBKCzHHHj+BeITDmjqvKk0tmzVW3q0rM4zcb
MIME-Version: 1.0
X-Received: by 2002:a92:2905:: with SMTP id l5mr21982823ilg.80.1599550399534;
 Tue, 08 Sep 2020 00:33:19 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:33:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d5b5905aec85912@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in kvm_vm_worker_thread
From:   syzbot <syzbot+e4a6c438918d1db4e4fc@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d432fe900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=e4a6c438918d1db4e4fc
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4a6c438918d1db4e4fc@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 5d428067 P4D 5d428067 PUD 5d429067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7418 Comm: kvm-nx-lpage-re Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:kvm_vm_worker_thread+0xe9/0x270 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4912
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 37 01 00 00 48 8b 7b 08 4c 89 ee e8 23 99 67 00 31 ff 41 89 c4 89 c6 e8 a7 4b 6d 00 <00> 00 00 0f 85 97 31 02 00 e8 19 4f 6d 00 48 8b 54 24 08 48 b8 00
RSP: 0018:ffffc90012097ed0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90011e87cf8 RCX: ffffffff8106efe9
RDX: 0000000000000000 RSI: ffff88804c02e040 RDI: 0000000000000005
RBP: ffffc90011e87d08 R08: 0000000000000001 R09: ffffffff89bfd407
R10: 0000000000000000 R11: 0000000000000160 R12: 0000000000000000
R13: ffff88804c02e040 R14: ffffc90012081000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000005d427000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
CR2: 0000000000000000
---[ end trace 7a7affa1f4a7d557 ]---
RIP: 0010:kvm_vm_worker_thread+0xe9/0x270 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4912
Code: 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 37 01 00 00 48 8b 7b 08 4c 89 ee e8 23 99 67 00 31 ff 41 89 c4 89 c6 e8 a7 4b 6d 00 <00> 00 00 0f 85 97 31 02 00 e8 19 4f 6d 00 48 8b 54 24 08 48 b8 00
RSP: 0018:ffffc90012097ed0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90011e87cf8 RCX: ffffffff8106efe9
RDX: 0000000000000000 RSI: ffff88804c02e040 RDI: 0000000000000005
RBP: ffffc90011e87d08 R08: 0000000000000001 R09: ffffffff89bfd407
R10: 0000000000000000 R11: 0000000000000160 R12: 0000000000000000
R13: ffff88804c02e040 R14: ffffc90012081000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000005d427000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

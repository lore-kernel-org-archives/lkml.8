Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69635C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5060320657
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGQPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:09:22 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45780 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:09:20 -0400
Received: by mail-il1-f197.google.com with SMTP id c1so5526148ilk.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 08:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DMQelLSCLN2Z5Aolsqy2qPFWN9ytn2E9cawm1MaJLTM=;
        b=iFjRZ3uUC6oMu/iIPmdJVqHPg/4Y6tJBJNeoXpPV6i/55/YvSB2C+Q/O9eXUbeVF2a
         0XyeU2YixoabTm50rlsb7LCOoEidMNVXiuSco55ZYbMNPAc5BBYao+tIbsEvv50H4Gkt
         VQQdXVAEU5j2r5LlS6uIGP+ZynmQ1vEYRZ/UcM4xyEtaB70X0oj310iK/ttXr+JREus0
         NZndplOd2MtkMwTowKW3Dg51hDiAB7cW7nmmBwjceKx6+hXzmjNFvtg7UsQv8mBrRc20
         KsGZiiQzQDF+i34TWxj+eto2MLRDKVbW0Eb+DiURsN3DuyQrcWxRrbQhV3XCXnlfQYts
         82GA==
X-Gm-Message-State: AOAM531NhWCM+7xBaeYLYI83H4KyXsA9EdWNc7no1s6VbvtB1Byf8UXk
        m62dgTRC6FXYTBnXl4KLE5DgjtFA7NRmSn9RjkORSNC43OXD
X-Google-Smtp-Source: ABdhPJxdK9CP/ueGblX2ivXKqlkWGHPrz3zTKUdjaM401THZNsTqXVxTeoZZUak/BPSK2zMyHI2o3TsQE9+fNSK7xiEiDDYp0iYQ
MIME-Version: 1.0
X-Received: by 2002:a92:77d1:: with SMTP id s200mr9643060ilc.191.1594998559339;
 Fri, 17 Jul 2020 08:09:19 -0700 (PDT)
Date:   Fri, 17 Jul 2020 08:09:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bfd6b05aaa48a56@google.com>
Subject: BUG: unable to handle kernel paging request in mm_update_next_owner
From:   syzbot <syzbot+5597653669c062e8a248@syzkaller.appspotmail.com>
To:     christian@brauner.io, ebiederm@xmission.com, jannh@google.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    88825726 Merge tag 'drm-fixes-2020-07-17-1' of git://anong..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d663cf100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a160d1053fc89af5
dashboard link: https://syzkaller.appspot.com/bug?extid=5597653669c062e8a248
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5597653669c062e8a248@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffffffe90
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 9a7c067 P4D 9a7c067 PUD 9a7e067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 26181 Comm: syz-executor.4 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mm_update_next_owner+0x515/0x7a0 kernel/exit.c:389
Code: 68 fa ff ff 49 39 c7 0f 84 eb fe ff ff e8 83 98 2d 00 48 8d 85 28 04 00 00 48 89 c2 48 c1 ea 03 80 3c 1a 00 0f 85 96 01 00 00 <4c> 8b b5 28 04 00 00 4d 39 e6 75 95 49 89 c5 e9 65 fc ff ff e8 52
RSP: 0018:ffffc90019be7d50 EFLAGS: 00010246
RAX: fffffffffffffe90 RBX: dffffc0000000000 RCX: ffffffff814620df
RDX: 1fffffffffffffd2 RSI: ffffffff8146217d RDI: ffff8880372f49e0
RBP: fffffffffffffa68 R08: 0000000000000001 R09: ffffffff89a09083
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88805c658a00
R13: ffff8880372f42c0 R14: 0000000000000000 R15: ffff88800019e890
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffe90 CR3: 00000000576cc000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 exit_mm kernel/exit.c:481 [inline]
 do_exit+0xa87/0x2a40 kernel/exit.c:792
 do_group_exit+0x125/0x310 kernel/exit.c:903
 __do_sys_exit_group kernel/exit.c:914 [inline]
 __se_sys_exit_group kernel/exit.c:912 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:912
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1d9
Code: Bad RIP value.
RSP: 002b:0000000000c9fd88 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 000000000045c1d9
RDX: 0000000000415d51 RSI: fffffffffffffff7 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000c942d34e R09: 0000000000c9fde0
R10: ffffffff812a7080 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000c9fde0 R14: 0000000000000000 R15: 0000000000c9fdf0
Modules linked in:
CR2: fffffffffffffe90
---[ end trace 28612e5f10c9de90 ]---
RIP: 0010:mm_update_next_owner+0x515/0x7a0 kernel/exit.c:389
Code: 68 fa ff ff 49 39 c7 0f 84 eb fe ff ff e8 83 98 2d 00 48 8d 85 28 04 00 00 48 89 c2 48 c1 ea 03 80 3c 1a 00 0f 85 96 01 00 00 <4c> 8b b5 28 04 00 00 4d 39 e6 75 95 49 89 c5 e9 65 fc ff ff e8 52
RSP: 0018:ffffc90019be7d50 EFLAGS: 00010246
RAX: fffffffffffffe90 RBX: dffffc0000000000 RCX: ffffffff814620df
RDX: 1fffffffffffffd2 RSI: ffffffff8146217d RDI: ffff8880372f49e0
RBP: fffffffffffffa68 R08: 0000000000000001 R09: ffffffff89a09083
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88805c658a00
R13: ffff8880372f42c0 R14: 0000000000000000 R15: ffff88800019e890
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffe90 CR3: 00000000576cc000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

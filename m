Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCECC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB0920709
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 21:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGSVKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:10:21 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:33235 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 17:10:20 -0400
Received: by mail-il1-f197.google.com with SMTP id c1so9695590ilr.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 14:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GPXPL0QrcLLR3IfANdJ9Ye483437Ba1TA5d0wAWXbIg=;
        b=Kvs2V2ZsM4XWhqnAV/AZmaSwFiD1OIofrjldMo3nfxqhS1dwt1I481sNJm7PNXpKS/
         /x4PqeYUwC95jwaEFTBpkgQnXC5NvaCkvJLJcqtqVmWMdQzRMv9vx0VaI45IzLEGSOHM
         doXmJ6del4DN3xkPLucZAF2WZlNDuUkqH6F4IGYzobBZ6XQVravwkqrMrxbYU/m8ue/K
         wUosBqXWmuMfomfPKJbUb6lZXZ0mTDvBZOzy+ILyTTkIbiT0jLKAtU6VqsCHvaYypwyV
         LmSqZSTE0WltLnmzMQ6Hp8IyaJ/eo96K54SRPJI5HLDiKX+Z4USo8ytTR4kZRt1HuW01
         9myg==
X-Gm-Message-State: AOAM531Yx0boNnZqKL+mMa5qBZTFZ5x/WllABA+gs77wCp9Qic3DEfdO
        wXvXn65dQn+ZB000odn+PBzoGkPGDZswaezq/GhB7PNNOYOI
X-Google-Smtp-Source: ABdhPJyHeHUs8qTudlJebjDYkVDlBF7g1rS/bPpB2rZKtfdnFt9k+GcU9aKZNfrUeMNcqrXBbGtcLcqcdtMQWoFxRuilMMyexZ7G
MIME-Version: 1.0
X-Received: by 2002:a92:d24a:: with SMTP id v10mr20817625ilg.224.1595193019871;
 Sun, 19 Jul 2020 14:10:19 -0700 (PDT)
Date:   Sun, 19 Jul 2020 14:10:19 -0700
In-Reply-To: <000000000000bc4fd705a6e090e2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c38cd05aad1d13f@google.com>
Subject: Re: kernel BUG at include/linux/swapops.h:LINE!
From:   syzbot <syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4c43049f Add linux-next specific files for 20200716
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12c56087100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c76d72659687242
dashboard link: https://syzkaller.appspot.com/bug?extid=c48f34012b06c4ac67dd
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344abeb100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c48f34012b06c4ac67dd@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/swapops.h:197!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 19938 Comm: syz-executor.2 Not tainted 5.8.0-rc5-next-20200716-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
RIP: 0010:pmd_migration_entry_wait+0x493/0x520 mm/migrate.c:368
Code: 4d 8d 66 ff e9 1f fe ff ff e8 b9 c4 be ff 49 8d 5f ff e9 58 fe ff ff e8 ab c4 be ff 4d 8d 66 ff e9 a9 fe ff ff e8 9d c4 be ff <0f> 0b e8 96 c4 be ff 0f 0b e8 8f c4 be ff 4c 8d 65 ff eb a7 48 89
RSP: 0018:ffffc9001095fb70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81b56a24
RDX: ffff888092022240 RSI: ffffffff81b56b43 RDI: 0000000000000001
RBP: ffffea0008468080 R08: 0000000000000000 R09: ffffea0008468087
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0008468080
R13: ffff888015d2e0c0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f55eb477700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000021ad87000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __handle_mm_fault mm/memory.c:4349 [inline]
 handle_mm_fault+0x23cf/0x45e0 mm/memory.c:4465
 do_user_addr_fault+0x598/0xbf0 arch/x86/mm/fault.c:1294
 handle_page_fault arch/x86/mm/fault.c:1351 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1404
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0010:copy_user_generic_unrolled+0x89/0xc0 arch/x86/lib/copy_user_64.S:91
Code: 38 4c 89 47 20 4c 89 4f 28 4c 89 57 30 4c 89 5f 38 48 8d 76 40 48 8d 7f 40 ff c9 75 b6 89 d1 83 e2 07 c1 e9 03 74 12 4c 8b 06 <4c> 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 d2 74 10 89 d1 8a
RSP: 0018:ffffc9001095fe48 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000020000080 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffc9001095fea8 RDI: 0000000020000080
RBP: ffffc9001095fea8 R08: 0000000400000003 R09: ffffc9001095feaf
R10: fffff5200212bfd5 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000020000088 R14: 00007ffffffff000 R15: 0000000000000000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:74 [inline]
 _copy_to_user+0x11e/0x160 lib/usercopy.c:30
 copy_to_user include/linux/uaccess.h:168 [inline]
 do_pipe2+0x128/0x1b0 fs/pipe.c:1014
 __do_sys_pipe fs/pipe.c:1035 [inline]
 __se_sys_pipe fs/pipe.c:1033 [inline]
 __x64_sys_pipe+0x2f/0x40 fs/pipe.c:1033
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c1d9
Code: Bad RIP value.
RSP: 002b:00007f55eb476c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000016
RAX: ffffffffffffffda RBX: 0000000000022ac0 RCX: 000000000045c1d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 000000000078c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078c04c
R13: 00007ffcfc120ecf R14: 00007f55eb4779c0 R15: 000000000078c04c
Modules linked in:
---[ end trace ea73d933d66ff0d4 ]---
RIP: 0010:migration_entry_to_page include/linux/swapops.h:197 [inline]
RIP: 0010:migration_entry_to_page include/linux/swapops.h:190 [inline]
RIP: 0010:pmd_migration_entry_wait+0x493/0x520 mm/migrate.c:368
Code: 4d 8d 66 ff e9 1f fe ff ff e8 b9 c4 be ff 49 8d 5f ff e9 58 fe ff ff e8 ab c4 be ff 4d 8d 66 ff e9 a9 fe ff ff e8 9d c4 be ff <0f> 0b e8 96 c4 be ff 0f 0b e8 8f c4 be ff 4c 8d 65 ff eb a7 48 89
RSP: 0018:ffffc9001095fb70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff81b56a24
RDX: ffff888092022240 RSI: ffffffff81b56b43 RDI: 0000000000000001
RBP: ffffea0008468080 R08: 0000000000000000 R09: ffffea0008468087
R10: 0000000000000000 R11: 0000000000000000 R12: ffffea0008468080
R13: ffff888015d2e0c0 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f55eb477700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 000000021ad87000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


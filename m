Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5A920702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHUGKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:10:36 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:33796 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgHUGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:10:23 -0400
Received: by mail-il1-f199.google.com with SMTP id p10so771078ile.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bwIyHpBXlz89+XKQ2tXFKJh+Ai+1kzfysfyo1EuoWWs=;
        b=I/PJ4JUB+S/8Ccz7rmD38YiPMs3ycGE/xuhXCW+5CcZfoAyFG0Z9Wc60zHB3iELppB
         2tBIrKnVbpJaVDdaSVQprN5oSvoKxoWVzcdUW0To4OAeoK3JLxVVcVxbU5gJ+jeow3bP
         NmfrLkfH0e8o/iM68VPk4LuoH48uU6SOh6Qj6+s0+dkSB8kk6o687P5JFwuG+jVmsz5D
         dbnR6Aw+Zrdhgvn5B4G6OcDCnEShuAm+zx4wOZ9M1X/Dmg6+xgMpeCQU/oGQvDHYL+d2
         WfX1M8KB93NtlUN0nWzlx+AEAIT/zsHZSBOFVAN0j1NzpxSFUZqSRA6dMSYHBJu7U7lQ
         BCvg==
X-Gm-Message-State: AOAM530vl2s66qlgOUmixXPPieYIhjtzhUj8Em2q3J+XB5ZpK827TZBI
        Jif5d8O5SMJF+522VV/fYRKncOhy04nF2z6gA6hg4k+o+Ok+
X-Google-Smtp-Source: ABdhPJzs7kJxPjHj/hYFomSnuL9Fjhw1pVAvpI1wzOuf158cQcg7XvLiK5/VF6Ebjfy7Vpvd8ATnLnf/i8W4dPBa0FbFmOaXV1eC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ee:: with SMTP id w14mr1423488ilj.4.1597990222039;
 Thu, 20 Aug 2020 23:10:22 -0700 (PDT)
Date:   Thu, 20 Aug 2020 23:10:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a0f4f05ad5d1743@google.com>
Subject: general protection fault in map_vdso_randomized
From:   syzbot <syzbot+6719f65e8a293105edcc@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4b6c093e Merge tag 'block-5.9-2020-08-14' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179f99f6900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a98b778f5fca0653
dashboard link: https://syzkaller.appspot.com/bug?extid=6719f65e8a293105edcc
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6719f65e8a293105edcc@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 27621 Comm: modprobe Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:map_vdso_randomized+0x64/0x160 arch/x86/entry/vdso/vma.c:364
Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00 65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc9000ab57c10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88804e0963c0 RCX: 1ffffffff1080a60
RDX: 0000000000006000 RSI: 0000000000000001 RDI: ffff88804e0967e8
RBP: ffff88801459b000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000160 R12: ffffffff884052e0
R13: ffff8880a69cf950 R14: 00007faba47c2c20 R15: ffff8880a5cb4400
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faba49e6fc0 CR3: 0000000031b89000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 load_elf_binary+0x22d4/0x47c0 fs/binfmt_elf.c:1221
 search_binary_handler fs/exec.c:1819 [inline]
 exec_binprm fs/exec.c:1860 [inline]
 bprm_execve+0x936/0x1b10 fs/exec.c:1931
 kernel_execve+0x370/0x460 fs/exec.c:2080
 call_usermodehelper_exec_async+0x27a/0x500 kernel/umh.c:101
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace f344c46c1e164ddf ]---
RIP: 0010:map_vdso_randomized+0x64/0x160 arch/x86/entry/vdso/vma.c:364
Code: 00 fc ff df 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 eb 00 00 00 65 48 8b 1c 25 c0 fe 01 00 48 8d bb 28 04 00 00 41 2b 54 24 20 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc9000ab57c10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff88804e0963c0 RCX: 1ffffffff1080a60
RDX: 0000000000006000 RSI: 0000000000000001 RDI: ffff88804e0967e8
RBP: ffff88801459b000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000160 R12: ffffffff884052e0
R13: ffff8880a69cf950 R14: 00007faba47c2c20 R15: ffff8880a5cb4400
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc99314e38 CR3: 0000000031b89000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

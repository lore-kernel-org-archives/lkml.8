Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37466C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174FC2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG1FEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:04:21 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:51263 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG1FEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:04:21 -0400
Received: by mail-il1-f200.google.com with SMTP id y8so4709232ilq.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aUaGerJpeJhZut6YlBfD/XVnA8cxyphVdRCWG7jM4E8=;
        b=pxyYFJJmLeNSy4gtE9OF5ASQ6uKDTmrJ1yNC8xIj7ND09u08PdDLHRQzP39ur5aS2i
         pjY//7g4H7A40lbod6B8g5FMGds+c/QeENnS+nv0GdDLJxrTjKdtMYyZ2fwZGczSmlJa
         8V+W4JCC0akrltfnadSTWKCVHLc29ghbC69JoTWfoeunfkj5ShlKujPNe0cZ1P5T1ha3
         8hH7PAiBBFz+iVlxyt3vR3P0AwQW121+RenCzdT5C47dtvn4P2UZ3BMWqDQawsw7HksA
         VmfuC4AKXxrHJMbgOvVucC7Su+7d9kIKUBNL9Wx2d0VN0sr6hwdqNmcfnSx5t2ZwMrGt
         4vdg==
X-Gm-Message-State: AOAM5322zJEP3nePqVoiQMg3LxmE5H8N//HCvdx96xK/JQaBmF3RBiLd
        qaZyl5yrCtKNj2py10UM6SoetOFN2MGml9yssa8X7asGt6QG
X-Google-Smtp-Source: ABdhPJyaKOxvha8atUjGOigRpZGvLVVWsxwJym1stuff/XD9MLbsBi9PW9JuPeBJwpOwZf7nE9UIMx87T2hygmg4pS/l2ShvXFcM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8b:: with SMTP id v11mr13478628jao.122.1595912660288;
 Mon, 27 Jul 2020 22:04:20 -0700 (PDT)
Date:   Mon, 27 Jul 2020 22:04:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000358a3d05ab795fe1@google.com>
Subject: BUG: unable to handle kernel paging request in x86_pmu_event_init
From:   syzbot <syzbot+c01c3ea720877d228202@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d15be546 Merge tag 'media/v5.8-3' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16380317100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3bc31881f1ae8a7
dashboard link: https://syzkaller.appspot.com/bug?extid=c01c3ea720877d228202
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125be09c900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115ce01f100000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122b8228900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112b8228900000
console output: https://syzkaller.appspot.com/x/log.txt?x=162b8228900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c01c3ea720877d228202@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffe8
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 947c067 P4D 947c067 PUD 947e067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3889 Comm: systemd-udevd Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:x86_pmu_initialized arch/x86/events/core.c:297 [inline]
RIP: 0010:__x86_pmu_event_init arch/x86/events/core.c:594 [inline]
RIP: 0010:x86_pmu_event_init+0x95/0xac0 arch/x86/events/core.c:2140
Code: e8 30 5a 73 00 48 83 3d d8 cc 8b 08 00 75 1e e8 21 5a 73 00 bd ed ff ff ff e9 2a 07 00 00 e8 12 5a 73 00 48 83 3d ba cc 8b 08 <00> 74 e2 e8 43 7b ff ff 89 c5 31 ff 89 c6 e8 08 5e 73 00 85 ed 74
RSP: 0018:ffffc90001577f10 EFLAGS: 00010097
RAX: 0000000000000286 RBX: 0000000000004100 RCX: 2920ecf39a0bcf00
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffc90001577f58
RBP: 0000000000000000 R08: ffffffff814dec5e R09: ffffed1012f42c69
R10: ffffed1012f42c69 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90001577f58 R15: ffff8880a1c40080
FS:  00007f1b1fd358c0(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffe8 CR3: 00000000a26b6000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
Modules linked in:
CR2: ffffffffffffffe8
---[ end trace b1f79b2301ebd5ee ]---
RIP: 0010:x86_pmu_initialized arch/x86/events/core.c:297 [inline]
RIP: 0010:__x86_pmu_event_init arch/x86/events/core.c:594 [inline]
RIP: 0010:x86_pmu_event_init+0x95/0xac0 arch/x86/events/core.c:2140
Code: e8 30 5a 73 00 48 83 3d d8 cc 8b 08 00 75 1e e8 21 5a 73 00 bd ed ff ff ff e9 2a 07 00 00 e8 12 5a 73 00 48 83 3d ba cc 8b 08 <00> 74 e2 e8 43 7b ff ff 89 c5 31 ff 89 c6 e8 08 5e 73 00 85 ed 74
RSP: 0018:ffffc90001577f10 EFLAGS: 00010097
RAX: 0000000000000286 RBX: 0000000000004100 RCX: 2920ecf39a0bcf00
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffc90001577f58
RBP: 0000000000000000 R08: ffffffff814dec5e R09: ffffed1012f42c69
R10: ffffed1012f42c69 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90001577f58 R15: ffff8880a1c40080
FS:  00007f1b1fd358c0(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffe8 CR3: 00000000a26b6000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

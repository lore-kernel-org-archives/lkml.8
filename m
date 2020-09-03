Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA3DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0320C20758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 02:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgICCsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 22:48:21 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56371 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgICCsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:48:21 -0400
Received: by mail-il1-f199.google.com with SMTP id w82so1219925ila.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 19:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rBL3bWJ770w5+rKgjWbVHAlekloDjKTJ10BiBusqwbo=;
        b=m2JJJUpyIhcmI+XdU/xFV6UZGFBdIIb7GGkZi0nmaYhNXyrdzAAKn4Uw6h2Uq3pWxa
         D3kmZnjU2lCy1I6/zlMUDQhmFenvqSK39mwbZDy3roprGU+zne9QmGX4A+G6wtMomgNN
         JjSGquhbxfEJCr+BRZBxictSUtDsLUEqaxYJjvC4YzE1LGiMsiwSMV6zpsWm4DBOcuPH
         qfR3n/juwyRm1YKxmUn1ZGlTq2fj4D0IIWi8L2tzGzcI5yjQRn5ZLe3qVdP+YxdvsmwS
         KUJDEz7Wf2Yv7L4ODLZXpCl/6RCBry6KCfHV5t16YtcmSwO+nKwFP66JpxSvAsGaGweE
         QZ5Q==
X-Gm-Message-State: AOAM532lja8/SRLXfhqVrnL3PY7a0SsvXm0gsjiYjxYTEJG+shP96uKm
        AhGbSNRuX8XIhon8iSvdDhTEZOi3bF85i3XNHzvzUEcs/3cB
X-Google-Smtp-Source: ABdhPJzv10QtaoXFC2pn0QjjJfPKlYbXOBRcDbo4j7/EvDxgGM6HQSc52V4ftq3hKOFQBxkXXmU8ogkFRSouOku7TBZJm9F6H6cB
MIME-Version: 1.0
X-Received: by 2002:a5d:9051:: with SMTP id v17mr1198574ioq.88.1599101299894;
 Wed, 02 Sep 2020 19:48:19 -0700 (PDT)
Date:   Wed, 02 Sep 2020 19:48:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0ae3005ae5fc85e@google.com>
Subject: BUG: sleeping function called from invalid context in vdso_join_timens
From:   syzbot <syzbot+49f84b6782afe2a2b20e@syzkaller.appspotmail.com>
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

HEAD commit:    4d41ead6 Merge tag 'block-5.9-2020-08-28' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174adf49900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=49f84b6782afe2a2b20e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49f84b6782afe2a2b20e@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1491
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 479, name: syz-executor.3
INFO: lockdep is turned off.
irq event stamp: 845
hardirqs last  enabled at (845): [<ffffffff882cebdf>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (845): [<ffffffff882cebdf>] _raw_spin_unlock_irqrestore+0x6f/0xd0 kernel/locking/spinlock.c:191
hardirqs last disabled at (844): [<ffffffff882cea28>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (844): [<ffffffff882cea28>] _raw_spin_lock_irqsave+0x78/0xc0 kernel/locking/spinlock.c:159
softirqs last  enabled at (662): [<ffffffff88400f2f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
softirqs last disabled at (653): [<ffffffff88400f2f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
Preemption disabled at:
[<ffffffff882c3253>] preempt_schedule_irq+0x93/0x150 kernel/sched/core.c:4783
CPU: 1 PID: 479 Comm: syz-executor.3 Tainted: G      D           5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 ___might_sleep+0x3c0/0x570 kernel/sched/core.c:7299
 down_read+0x17/0x50 kernel/locking/rwsem.c:1491
 mmap_read_lock include/linux/mmap_lock.h:46 [inline]
 vdso_join_timens+0x46/0x120 arch/x86/entry/vdso/vma.c:147
kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffff8880ae936310
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0011) - permissions violation
PGD c401067 P4D c401067 PUD 21ffff067 PMD 80000000ae8001e3 
Oops: 0011 [#2] PREEMPT SMP KASAN
CPU: 1 PID: 479 Comm: syz-executor.3 Tainted: G      D W         5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

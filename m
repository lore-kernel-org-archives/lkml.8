Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C4C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2757C218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgIHHce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:32:34 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:47558 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgIHHcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:32:23 -0400
Received: by mail-io1-f79.google.com with SMTP id a15so9179334ioc.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Is3sKluxmo/Sgyis/64QgcAteh9E7NYmVlcCgIbI76A=;
        b=Wsh+bQXXq/te4vRBdd5Q+hoxxb5TzskmBOyBTuDPSxL1Ql534XgzDUrD+xA1HlfZS9
         36F+yXQSU838UTKPtRUMf9QE23RkOVi1bfbzhfhkXxE221V3KYUABSM97mmReFPkpeKM
         Ci5GTi+g9/m3yWuvoA7Zmg8fLVodi9dCIWNhUVG5Z5nvN1AKYjAxymyGAnF9CR9PZEcv
         U6J+4j021y+AgLVjr785/L2p7RWZ0CQC6bmFVmNfXzwZwaSuugx54DDQXdbI9zbonyR1
         ZreLL9aTX6sa8vHZgI4YRQC6O1sSMq97Y8ifdFL8iB4r4LjRzDJE56jQGuVhnfbZuDct
         FgQg==
X-Gm-Message-State: AOAM5333te1SEdBCsXVvNAL0SAC6s+Mx0vNAVh1M0zC0u69Lfqp75lxU
        sSCoPQc1J2mLPx0rH71/GQJrrfXwpWPEy1Oy3T1Dn83+BYy5
X-Google-Smtp-Source: ABdhPJwehF8qBd34Td1pqDCsc9b55sQOW2TUpmPUth121FvqphHKiBAoTrQl0J/HGbqivvEOqFQc6l4jL26O/Bt7mnUPTA1rr8m+
MIME-Version: 1.0
X-Received: by 2002:a92:1fd6:: with SMTP id f83mr22289717ilf.261.1599550342667;
 Tue, 08 Sep 2020 00:32:22 -0700 (PDT)
Date:   Tue, 08 Sep 2020 00:32:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9a36005aec8556d@google.com>
Subject: WARNING: locking bug in unmap_page_range
From:   syzbot <syzbot+a3ab428a038913cb91a7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b765a32a Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147272c9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=a3ab428a038913cb91a7
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3ab428a038913cb91a7@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 12877 at kernel/locking/lockdep.c:183 hlock_class kernel/locking/lockdep.c:183 [inline]
WARNING: CPU: 0 PID: 12877 at kernel/locking/lockdep.c:183 hlock_class kernel/locking/lockdep.c:172 [inline]
WARNING: CPU: 0 PID: 12877 at kernel/locking/lockdep.c:183 check_wait_context kernel/locking/lockdep.c:4100 [inline]
WARNING: CPU: 0 PID: 12877 at kernel/locking/lockdep.c:183 __lock_acquire+0x155f/0x5570 kernel/locking/lockdep.c:4376
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12877 Comm: syz-executor.5 Not tainted 5.9.0-rc3-syzkaller #0
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
RIP: 0010:hlock_class kernel/locking/lockdep.c:183 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:172 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4100 [inline]
RIP: 0010:__lock_acquire+0x155f/0x5570 kernel/locking/lockdep.c:4376
Code: d2 0f 85 62 2f 00 00 44 8b 15 85 52 58 09 45 85 d2 0f 85 da fa ff ff 48 c7 c6 60 ad 4b 88 48 c7 c7 20 a8 4b 88 e8 f3 36 eb ff <0f> 0b e9 c0 fa ff ff e8 25 a4 99 06 85 c0 0f 84 fd fa ff ff 48 c7
RSP: 0018:ffffc90009b3f538 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: ffff888028c78200 RSI: ffffffff815db9a7 RDI: fffff52001367e99
RBP: ffff888028c78ae8 R08: 0000000000000000 R09: ffffffff89bcb4a3
R10: 00000000000021c7 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000000017c0 R14: ffff888028c78200 R15: 0000000000040000
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:354 [inline]
 zap_pte_range mm/memory.c:1049 [inline]
 zap_pmd_range mm/memory.c:1195 [inline]
 zap_pud_range mm/memory.c:1224 [inline]
 zap_p4d_range mm/memory.c:1245 [inline]
 unmap_page_range+0xa74/0x2b20 mm/memory.c:1266
 unmap_single_vma+0x198/0x300 mm/memory.c:1311
 unmap_vmas+0x168/0x2e0 mm/memory.c:1343
 exit_mmap+0x2b1/0x530 mm/mmap.c:3183
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007fdc658b0c78 EFLAGS: 00000246 ORIG_RAX: 000000000000013d
RAX: 0000000000000000 RBX: 0000000000027440 RCX: 000000000045d5b9
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 000000000118d020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
R13: 000000000169fb6f R14: 00007fdc658b19c0 R15: 000000000118cfec
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

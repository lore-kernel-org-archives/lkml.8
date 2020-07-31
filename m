Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1400DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0B52245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbgGaQyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:54:23 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40859 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732912AbgGaQyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:54:22 -0400
Received: by mail-io1-f69.google.com with SMTP id t22so12144949iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 09:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eBgrKQgetDK1Zn56OoxluDo5PjxwfEKYs/QHbyKlBBU=;
        b=i7HRU1JaXS4I43ZiclnImc3FHsQOf8bor5usCojCf/ymIHT5RuvbYs0sW0DUVNpKo+
         3fMJmZr0ocTGLfpk8qj95QqYNxn5qaKsJbXipXnRbDdFePN6dQo7ZnKJgq/1OmSgH0NM
         hzdFDKhqCMhU4oa6jy9nC4XYWzDlWPRmtK5+4eB238zM2vcZpoCDbCe1i3PtW9yxzIJo
         V0LRxgmL6AIepxeLKWB0dciuthrbFTcj1WONfxpcLJWYqekc2MKdfMv59Jb726sIrRsi
         UP+UySIqMloB+nrXc4Xm7pAT3T9rfDsxSkOI1fxKeWL1vfjQ9ZWsAsnVxCkc5eNLatUy
         YhxQ==
X-Gm-Message-State: AOAM531GBYCoZ6n6fH+bRCdcj4X6SjvWBg9d8Rz2PS4vbXONH5u7tCK2
        IG3nMABpb4NblqedHo8rjGPoINznPW1637wI64pZ4CxAXlJx
X-Google-Smtp-Source: ABdhPJzaSTz1SnrId/zd7MDfvEa0UoNTFZIqjC7NL6DP4uHj4qPo6tHc/AEzuVgOLgtWDRneKBwcdzLIwXNrIx4b6bAPYqH4N/qD
MIME-Version: 1.0
X-Received: by 2002:a92:874a:: with SMTP id d10mr4688320ilm.273.1596214461567;
 Fri, 31 Jul 2020 09:54:21 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f796a105abbfa33d@google.com>
Subject: INFO: trying to register non-static key in skb_queue_purge
From:   syzbot <syzbot+99efc1c133eff186721a@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    83bdc727 random32: remove net_rand_state from the latent e..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11088204900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=99efc1c133eff186721a
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12429014900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12dbc404900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+99efc1c133eff186721a@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 6819 Comm: syz-executor370 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 register_lock_class+0xf06/0x1520 kernel/locking/lockdep.c:893
 __lock_acquire+0x102/0x2c30 kernel/locking/lockdep.c:4259
 lock_acquire+0x160/0x720 kernel/locking/lockdep.c:4959
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x9e/0xc0 kernel/locking/spinlock.c:159
 skb_dequeue net/core/skbuff.c:3038 [inline]
 skb_queue_purge+0x2e/0x1c0 net/core/skbuff.c:3076
 l2cap_conn_del+0x3de/0x650 net/bluetooth/l2cap_core.c:1890
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1355 [inline]
 hci_conn_hash_flush+0x127/0x200 net/bluetooth/hci_conn.c:1536
 hci_dev_do_close+0xb7b/0x1040 net/bluetooth/hci_core.c:1761
 hci_unregister_dev+0x16d/0x1590 net/bluetooth/hci_core.c:3606
 vhci_release+0x73/0xc0 drivers/bluetooth/hci_vhci.c:340
 __fput+0x2f0/0x750 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0x601/0x1f80 kernel/exit.c:805
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:914
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:912
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:912
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x444fe8
Code: Bad RIP value.
RSP: 002b:00007ffe95cf39a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000444fe8
RDX: 0000000000000001 RSI: 000000000000003c RDI: 0000000000000001
RBP: 00000000004cce10 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 00007fa6b64e3700 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006e0200 R14: 00000000011eb850 R15: 0000000000000001


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

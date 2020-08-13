Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212C620829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMFYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:24:21 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40381 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgHMFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:24:20 -0400
Received: by mail-io1-f69.google.com with SMTP id t22so3299303iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MIGAdD8AV/NC1BP8vlLnD+v3sHhkKr3057HeKchSrxM=;
        b=BXQ2cSXuFW+JpQ/WIZu8Z0wqejIOLa8L72XAPxPIwNoi7UHgkIexEbdfll6LX1+OI2
         88VJkpZ5Sn8NHOO/PrMXm/akICjLHA/JyhQEtLjYHkILJWZUrVdHahenteHIPb/+E3UT
         IRJDTgWOzW0ZhwskwcpQvk163RJJg2gkEduA80bI1jgI1DEqBsMD9bYsCkHPMYvSkCcF
         AEZPIakyeNLNyo9lKCUbwncYSMQwCeH0zHwEdVSb7Cx9EmpsGefBXCNR/ApHr6TCbbYV
         a6yttfCcycjCQ4elgC5AlTWznyxtVPb2lTCEqX1stsryYmM4HtSPyQKuWCwn2E3QXHfw
         oSnw==
X-Gm-Message-State: AOAM530oQj6rfxw5hzb6IhF8tEZl/BjbrpfqU6Y2v7a9rRGSKbP1tISy
        A4DT64BPxapwXRIukCz5kKQqEEOzc/9rYRpXIOYBmq5da9Tx
X-Google-Smtp-Source: ABdhPJxe/Y534Kujvl7uJwA40M2Jd7ICtQOtb+65Yk6LhxvJf9iNcev7hCxUSV5nArY+7yR3D+MdMzCJp8K5VbfJa70QRQfGBks0
MIME-Version: 1.0
X-Received: by 2002:a92:d9d1:: with SMTP id n17mr2940649ilq.182.1597296259060;
 Wed, 12 Aug 2020 22:24:19 -0700 (PDT)
Date:   Wed, 12 Aug 2020 22:24:19 -0700
In-Reply-To: <00000000000042af6205ac444172@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f5a1105acbb8483@google.com>
Subject: Re: WARNING: locking bug in l2cap_chan_del
From:   syzbot <syzbot+01d7fc00b2a0419d01cc@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    06a7a37b ipv4: tunnel: fix compilation on ARCH=um
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=115caa16900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bb894f55faf8242
dashboard link: https://syzkaller.appspot.com/bug?extid=01d7fc00b2a0419d01cc
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fb564a900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01d7fc00b2a0419d01cc@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5 at kernel/locking/lockdep.c:183 hlock_class kernel/locking/lockdep.c:183 [inline]
WARNING: CPU: 0 PID: 5 at kernel/locking/lockdep.c:183 hlock_class kernel/locking/lockdep.c:172 [inline]
WARNING: CPU: 0 PID: 5 at kernel/locking/lockdep.c:183 check_wait_context kernel/locking/lockdep.c:4100 [inline]
WARNING: CPU: 0 PID: 5 at kernel/locking/lockdep.c:183 __lock_acquire+0x1674/0x5640 kernel/locking/lockdep.c:4376
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:hlock_class kernel/locking/lockdep.c:183 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:172 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4100 [inline]
RIP: 0010:__lock_acquire+0x1674/0x5640 kernel/locking/lockdep.c:4376
Code: d2 0f 85 f1 36 00 00 44 8b 15 f0 8e 57 09 45 85 d2 0f 85 1c fa ff ff 48 c7 c6 80 af 4b 88 48 c7 c7 80 aa 4b 88 e8 ce 36 eb ff <0f> 0b e9 02 fa ff ff c7 44 24 38 fe ff ff ff 41 bf 01 00 00 00 c7
RSP: 0018:ffffc90000cbf8e0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: ffff8880a95a2140 RSI: ffffffff815d8eb7 RDI: fffff52000197f0e
RBP: ffff8880a95a2ab0 R08: 0000000000000000 R09: ffffffff89bcb3c3
R10: 00000000000007d2 R11: 0000000000000001 R12: 0000000000000000
R13: 00000000000019a1 R14: ffff8880a95a2140 R15: 0000000000040000
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
 _raw_spin_lock_bh+0x2f/0x40 kernel/locking/spinlock.c:175
 spin_lock_bh include/linux/spinlock.h:359 [inline]
 lock_sock_nested+0x3b/0x110 net/core/sock.c:3040
 l2cap_sock_teardown_cb+0x88/0x400 net/bluetooth/l2cap_sock.c:1520
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:823
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2C5C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53592177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHHJqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 05:46:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36925 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgHHJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 05:46:22 -0400
Received: by mail-io1-f69.google.com with SMTP id f6so3503109ioa.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 02:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mgd7GqjjHZbKTVg1oMh8UpWpxgZW/6tvB9gNkmYnfYE=;
        b=cK7FheJ39xWcwEVC957D5yiV9hylL/NewuLtqzXWtsQXqoV68ABfzNYmJgZ4nVgxdV
         ysBT7TE0A+y/FZ9/9UZluI/y8pm+XdKCNCBJrr+7X4xVvYD8EbyZyfx45N9/riMo4oxh
         NYAuCKW6cOUB83NS7WLpQR32R1/RbAqk1/LsEQWhHepTIjssLnXDGRPCVfy4PnWGare1
         XcXHty8sSSCNxN3qPShFVatF6IZqD1VvDwUO0+Jzpfg6NPQH4cQMHH+7o0i0r7eBN76T
         EvOuUSaMChbAzhbujjk4FnnPXjKRIONE1a7xpTI8abx9p2d+Ny7K/D92jYEq8Q6ZHalP
         zy5g==
X-Gm-Message-State: AOAM533C06D1ZqEjOT85eAJTPUgBLV8ckVY5VOSvu8zOuqY5v9j76Xqw
        IbiMR4DfIJiWyPap39cafge9vt/4H8dTh9dgSqKhDFc8nIoV
X-Google-Smtp-Source: ABdhPJzW8/kOTaphgcikkhZB1BACCXuyS9i2Q48y8/n1Uc0jg23uS5/J2KZB4W9dkahJKWLM4/ndHDDc3MSj9hj88H1XQl04F5BJ
MIME-Version: 1.0
X-Received: by 2002:a6b:3e04:: with SMTP id l4mr8449851ioa.206.1596879981392;
 Sat, 08 Aug 2020 02:46:21 -0700 (PDT)
Date:   Sat, 08 Aug 2020 02:46:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a389a05ac5a9864@google.com>
Subject: KASAN: null-ptr-deref Write in l2cap_chan_put
From:   syzbot <syzbot+452e9465a3b2817fa4c2@syzkaller.appspotmail.com>
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

HEAD commit:    5631c5e0 Merge tag 'xfs-5.9-merge-7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c21934900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afba7c06f91e56eb
dashboard link: https://syzkaller.appspot.com/bug?extid=452e9465a3b2817fa4c2
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131e96aa900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+452e9465a3b2817fa4c2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_write include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
BUG: KASAN: null-ptr-deref in refcount_sub_and_test include/linux/refcount.h:266 [inline]
BUG: KASAN: null-ptr-deref in refcount_dec_and_test include/linux/refcount.h:294 [inline]
BUG: KASAN: null-ptr-deref in kref_put include/linux/kref.h:64 [inline]
BUG: KASAN: null-ptr-deref in l2cap_chan_put+0x28/0x230 net/bluetooth/l2cap_core.c:502
Write of size 4 at addr 0000000000000018 by task kworker/0:1/7077

CPU: 0 PID: 7077 Comm: kworker/0:1 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 __kasan_report mm/kasan/report.c:517 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
 refcount_sub_and_test include/linux/refcount.h:266 [inline]
 refcount_dec_and_test include/linux/refcount.h:294 [inline]
 kref_put include/linux/kref.h:64 [inline]
 l2cap_chan_put+0x28/0x230 net/bluetooth/l2cap_core.c:502
 l2cap_sock_kill+0xbd/0x180 net/bluetooth/l2cap_sock.c:1217
 l2cap_chan_timeout+0x1c1/0x450 net/bluetooth/l2cap_core.c:438
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7077 Comm: kworker/0:1 Tainted: G    B             5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 end_report+0x4d/0x53 mm/kasan/report.c:104
 __kasan_report mm/kasan/report.c:520 [inline]
 kasan_report.cold+0xd/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
 refcount_sub_and_test include/linux/refcount.h:266 [inline]
 refcount_dec_and_test include/linux/refcount.h:294 [inline]
 kref_put include/linux/kref.h:64 [inline]
 l2cap_chan_put+0x28/0x230 net/bluetooth/l2cap_core.c:502
 l2cap_sock_kill+0xbd/0x180 net/bluetooth/l2cap_sock.c:1217
 l2cap_chan_timeout+0x1c1/0x450 net/bluetooth/l2cap_core.c:438
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

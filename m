Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832DAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67481206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHASzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:55:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:48454 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHASzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:55:21 -0400
Received: by mail-il1-f199.google.com with SMTP id w23so13813389ila.15
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qQIA2QYUDlIkIkoCeDn3ShR5eJP9B1EyOlqL+wH8+eg=;
        b=pzp1pI0kKf2/MUyHbkq46UUbVMjqryz6tEfJtQqcF0WK6uagK+9rPHvgHVZkL0N1MC
         mh0zQlAFRr+LLayG8zMvsMZ/51U7Lco6x+SdnIFeQu1uwXDha0vf0Tfh9uOJSclcKLfo
         Vzz84yzkH1W9E6Obo7bjSSttnvuqpMOEnT6WaMr9G7u/Nsj3ivBYk9znlP7h1rFEuv//
         5cjJqXz7fBe5t6UIE7YsR//uo68gk+gwn/Nht1Fla5ycDhmLM7OapjsFyrV0rnzfCgUC
         PBcR5DNa5H55Nc+J18KC+lnGpVpc6o0YHrE0lNRRGUygxWZNAajjnl1IHlnyoVy8QLOg
         CkUQ==
X-Gm-Message-State: AOAM531AVfTxbiBvRFLvF8sdvCO9BnnziFot450cAZzwkFAAJkO5wmIO
        QBYA7vWVTszfknvCD7DcPHdB4eKSD5dsbGcd+HdIdoLLmSkv
X-Google-Smtp-Source: ABdhPJyAnxuWi0Ar7UbGU8cFxZxOdqtZIrd/H1i1Lo4eIUgzWQ+QRZgqjc2PIeKovrr2D9XmJyB9FwIQP4/m6yOXch6deouJO2cF
MIME-Version: 1.0
X-Received: by 2002:a92:ad01:: with SMTP id w1mr10198997ilh.301.1596308120160;
 Sat, 01 Aug 2020 11:55:20 -0700 (PDT)
Date:   Sat, 01 Aug 2020 11:55:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007450a405abd572a8@google.com>
Subject: WARNING in hci_conn_timeout
From:   syzbot <syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com>
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

HEAD commit:    7dc6fd0f Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a70832900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f781d4900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116a0c14900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6953 at net/bluetooth/hci_conn.c:412 hci_conn_timeout+0x20f/0x290 net/bluetooth/hci_conn.c:412
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6953 Comm: kworker/u5:2 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_conn_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:hci_conn_timeout+0x20f/0x290 net/bluetooth/hci_conn.c:412
Code: c7 50 4d 8d 89 e8 71 d0 5f fa 48 8b 35 6a 7c 39 02 bf 40 00 00 00 4c 89 f2 5b 41 5c 41 5e 41 5f e9 46 69 f8 f9 e8 61 c1 20 fa <0f> 0b e9 5c fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 1a fe ff
RSP: 0018:ffffc90001577cc8 EFLAGS: 00010293
RAX: ffffffff8753d0ff RBX: 00000000ffffffff RCX: ffff888092948440
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffff8880a9b7b008 R08: ffffffff8753cf3b R09: ffffed1010da5003
R10: ffffed1010da5003 R11: 0000000000000000 R12: ffff8880a7290d00
R13: ffff8880a7290d18 R14: ffff888086d28128 R15: dffffc0000000000
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
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

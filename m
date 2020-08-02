Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04587C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00292072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHBO6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:58:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54456 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHBO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:58:16 -0400
Received: by mail-io1-f69.google.com with SMTP id z25so17006410ioh.21
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 07:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rP8qFuAIj5PA4GqYTY6invSs7s5chTKGJL4gZOv9MdY=;
        b=OiR7vCLZEtQZTRHOUS3WFsyxGFAWS6LesFlhfd5vkUiUcEO/Drew24MXEzpqqnowL5
         Uibn1cx6eXPgMu/GmQ+BU/MEkxO/LOvT1nZaS8zLCgKF/49yS7EKgx8MOqORSuhrk5bv
         Tidulk/IRLMnjReqqnwrZHA8W7HpFudx9qSpplCnhavxZoJM9cQpId5CvTgGvk7jTTre
         tSN/63QvYtpRh0I9tUbqdd9Noi/Aeg1ONXjJmn6+RSErRHPN4K+u74OQop+2zJXtqm9i
         5hFZi5qjbb72xX/mVbvg+xFxjLCJE4fEK8C2MIICVJf0yUhYs3732LAWF/SrmW9TVI20
         4jsA==
X-Gm-Message-State: AOAM533pT+t4t7F4I1FTSSGx5Hj+xaMZS7Pvdzjn0RQpk3wUSJBVuk0U
        TjDlMBk5MAgl6ZvXLYXo2MZSrr6oD1yqh1Q8c5zFr1nJIZ+X
X-Google-Smtp-Source: ABdhPJx9ALeHovUaCpJtg/QHit8tfWWHnVJ9RsvBsueoJYR9kZOfzHYl19tkkKfuQ3rlXOOSq2JcbkvVksIk0rI4isSp62iyhVn9
MIME-Version: 1.0
X-Received: by 2002:a92:9116:: with SMTP id t22mr4949412ild.305.1596380295789;
 Sun, 02 Aug 2020 07:58:15 -0700 (PDT)
Date:   Sun, 02 Aug 2020 07:58:15 -0700
In-Reply-To: <0000000000008b9e0705a38afe52@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075030605abe640e5@google.com>
Subject: Re: WARNING: refcount bug in do_enable_set
From:   syzbot <syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hdanton@sina.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1194935c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9900a1e1b3c9c96a77
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b7ddca900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126dcf6c900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 2540 at lib/refcount.c:28 refcount_warn_saturate+0x15b/0x1a0 lib/refcount.c:28
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 2540 Comm: kworker/1:8 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events do_enable_set
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:540
RIP: 0010:refcount_warn_saturate+0x15b/0x1a0 lib/refcount.c:28
Code: c7 8a af 14 89 31 c0 e8 b3 f2 a8 fd 0f 0b eb 85 e8 2a 32 d7 fd c6 05 a4 d9 eb 05 01 48 c7 c7 b6 af 14 89 31 c0 e8 95 f2 a8 fd <0f> 0b e9 64 ff ff ff e8 09 32 d7 fd c6 05 84 d9 eb 05 01 48 c7 c7
RSP: 0018:ffffc90007d27c48 EFLAGS: 00010246
RAX: adb9104953f59b00 RBX: 0000000000000003 RCX: ffff8880a02d0540
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff815dd389 R09: ffffed1015d262c0
R10: ffffed1015d262c0 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880a0259118 R14: dffffc0000000000 R15: ffff8880ae9350c0
 do_enable_set+0x66e/0x900 net/bluetooth/6lowpan.c:1083
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled
Rebooting in 86400 seconds..


Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF55C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A99206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390341AbgFYH3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:29:18 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48037 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390279AbgFYH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:29:15 -0400
Received: by mail-io1-f72.google.com with SMTP id s15so425952iow.14
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Rr3qq/rO0TMWfLKXr+bYIqo0FipXkeSM+Sri80qu96I=;
        b=ccCxVQXrFn+BhtOmSgJDaX0wsEFf+A36ij92B31Dw2tsSUWKkqET96ocUukzpKKIOS
         cSvgx/FMBY62y9N9Sk06WzfUIEreHHXXi/lTR2WMqsvtREpepLnah7oS1H2nLoIWZ3p1
         4wDHY1nlyyDEfu19fNXpLR7FRWHc4O2WfZvtLHCBuDNewIUWdQv5avu/3ZEEKX+mSANy
         HqM7v0t4tEdnD7bwo5BJNPpoe/0iS8VR2a9gTHFlkPzIH3Jm0bb24KQCbz2ClJNy6B0T
         konI+iFM3KCFlm6ZkQKlmVoMojSCpRAbRFOXDhBr7Iui5lfAxKK1TWa0HApNW9hwkM2X
         8jzQ==
X-Gm-Message-State: AOAM533nEfWc6SHtAS3WuV9Y7xDGxnp8dWKvSJ7G+75cJLC/teqMs4TC
        MLtwvAlmojBt2Eqhx8W6pEGPsZ0NDJaCZAnbRLJCUY7c7C7j
X-Google-Smtp-Source: ABdhPJxlPXdHE4Cg6jElTtV4bVa5rRYy9My+f6o3c0k50rdP6vsMi41IDfOKnwBpkduhyLwxmHXD2fPllxUaHjgq8+1a17btPZo5
MIME-Version: 1.0
X-Received: by 2002:a92:cd10:: with SMTP id z16mr4594576iln.77.1593070155207;
 Thu, 25 Jun 2020 00:29:15 -0700 (PDT)
Date:   Thu, 25 Jun 2020 00:29:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b41c6405a8e38c6d@google.com>
Subject: WARNING: suspicious RCU usage in qrtr_ns_worker
From:   syzbot <syzbot+0f84f6eed90503da72fc@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123db429100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=0f84f6eed90503da72fc
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1521944d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1298d245100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0f84f6eed90503da72fc@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.7.0-syzkaller #0 Not tainted
-----------------------------
include/linux/radix-tree.h:176 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by kworker/u4:1/21:
 #0: ffff88821b097938 ((wq_completion)qrtr_ns_handler){+.+.}-{0:0}, at: spin_unlock_irq include/linux/spinlock.h:403 [inline]
 #0: ffff88821b097938 ((wq_completion)qrtr_ns_handler){+.+.}-{0:0}, at: process_one_work+0x6df/0xfd0 kernel/workqueue.c:2241
 #1: ffffc90000dd7d80 ((work_completion)(&qrtr_ns.work)){+.+.}-{0:0}, at: process_one_work+0x71e/0xfd0 kernel/workqueue.c:2243

stack backtrace:
CPU: 0 PID: 21 Comm: kworker/u4:1 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: qrtr_ns_handler qrtr_ns_worker
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 radix_tree_deref_slot include/linux/radix-tree.h:176 [inline]
 ctrl_cmd_new_lookup net/qrtr/ns.c:558 [inline]
 qrtr_ns_worker+0x2aff/0x4500 net/qrtr/ns.c:674
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

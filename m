Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9AFC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A370520702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 15:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgBVPIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 10:08:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33678 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbgBVPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 10:08:12 -0500
Received: by mail-il1-f197.google.com with SMTP id s9so5984501ilk.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 07:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mgUjHs4g9bSaFC5XPvo9JG4ciHdYePxlQqjSBI/frtc=;
        b=ZOsr/4pelhl24lHbBHdlyXCgGA5OTwMFUlCSdAmhhHcn0ssrI+OO08RF8t45WT/tR+
         n0GpTcqKV/pTIRuktLeeaIX2sM9apfcyBGk5EGOEhuckEZ2GuQq7T/G31v1elbmDVE+P
         747sDBgYQxUIC2f1dUbrA70fWwv6OCN4VIfjdEBVw9BFRouvDKTsjw5jM3GKdM1KCMk2
         u4iTKjVk4yNY4JZuFWY5O5um+5sabB1LkmR1YqymaW7Q3KqL9mz44hg8yUnnfaspHg/l
         /wqVlBQD3zK72vzmfozSWzfppzo7chp0iHzCiDkbYRUDxGZ8b0KNNzcJ22yPSoJ9pl0x
         J04A==
X-Gm-Message-State: APjAAAWosV9EezHEZZfSs3SQWvGXZf1eJXbdF569IjWqAiJ1KA02t/yU
        HgLdIkWsiPGVOvQCXuHF2A/0DK5yISrs4zWLiOQxlY1W6IDj
X-Google-Smtp-Source: APXvYqzQ9v3Jv/j+mdzsfcplavver9uu7MnultdBhWVRk1X95/5PxqZRz8vbVu8k7B0bZB7tDzEqLuXzaQLP6vbQFAXORhVQIVhm
MIME-Version: 1.0
X-Received: by 2002:a92:af4b:: with SMTP id n72mr45268383ili.288.1582384091534;
 Sat, 22 Feb 2020 07:08:11 -0800 (PST)
Date:   Sat, 22 Feb 2020 07:08:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acd115059f2b8188@google.com>
Subject: BUG: sleeping function called from invalid context in
 lock_sock_nested (2)
From:   syzbot <syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, daniel@zonque.org, davem@davemloft.net,
        devicetree@vger.kernel.org, jdelvare@suse.com,
        john.fastabend@gmail.com, kafai@fb.com, kuba@kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, mark.rutland@arm.com, netdev@vger.kernel.org,
        robh+dt@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0a44cac8 Merge tag 'dma-mapping-5.6' of git://git.infradea..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152eba29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61f2164c515c07f
dashboard link: https://syzkaller.appspot.com/bug?extid=a5df189917e79d5e59c9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117a0931e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d8c109e00000

The bug was bisected to:

commit 5ac6badc5aa057ceb1d50c93326a81db6e89ad2f
Author: Daniel Mack <daniel@zonque.org>
Date:   Thu Jul 11 12:45:03 2019 +0000

    device-tree: bindinds: add NXP PCT2075 as compatible device to LM75

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15924629e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17924629e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13924629e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a5df189917e79d5e59c9@syzkaller.appspotmail.com
Fixes: 5ac6badc5aa0 ("device-tree: bindinds: add NXP PCT2075 as compatible device to LM75")

BUG: sleeping function called from invalid context at net/core/sock.c:2935
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2687, name: kworker/1:3
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff867b39c7>] sock_hash_free+0xd7/0x460 net/core/sock_map.c:869
CPU: 1 PID: 2687 Comm: kworker/1:3 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events bpf_map_free_deferred
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 ___might_sleep+0x449/0x5e0 kernel/sched/core.c:6798
 __might_sleep+0x8f/0x100 kernel/sched/core.c:6751
 lock_sock_nested+0x36/0x120 net/core/sock.c:2935
 lock_sock include/net/sock.h:1516 [inline]
 sock_hash_free+0x200/0x460 net/core/sock_map.c:872
 bpf_map_free_deferred+0xb2/0x110 kernel/bpf/syscall.c:474
 process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

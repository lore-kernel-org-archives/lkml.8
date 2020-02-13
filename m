Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEC1C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42935222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgBMShP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:37:15 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46557 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBMShP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:37:15 -0500
Received: by mail-il1-f200.google.com with SMTP id a2so5428427ill.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+zEG83XJ2KD3tG6iswUl3A3tfv53W4BSz1ckWVsUsPQ=;
        b=aC9FjPqQ0eLeYXe+xqsP87KeKJpupQ5kVMfBaZtj/bXBBi2zw5dBxWPO4uHIul49TN
         stnY9+G1nsWhHwVeu0vR49uVX06WMY0DmHDHhfOudA6+o925Nb1pWvhg4j5EE0hg0B6c
         PCNf/GPx6J64uGAdDZf7i46R3N9CGo68J8MfU9OVW/OJatQAzujLuyKL90t1ElxCxIpz
         +1ah3MfhxUKNgWJIAoKouWk1qRxP+tZI9lo+p0m64YFDzodUrcXmMe+/M4kaF1LhMTvN
         38MLs6aEbpoZ0N7ZkU8E1cS8fY7u12QnCOgbLLQgpotGQ1sMvlcVzEcG2BJKtt5zJcZC
         YFGQ==
X-Gm-Message-State: APjAAAWeSHgOnf5vhtT3VqGHltWjyReuAQ4A9mFd3nrB06jp+rt8/Dkn
        ylRf7Qi2X3mf6NNwKeNT53h8o9QTQ/l4gTWYMTrh6iyXeotR
X-Google-Smtp-Source: APXvYqwpDr8WMrelfAhfG71WD/hHH/92X9e6sc5SsUElMtH1a9tCOfese5BRwU3d5gC8zWRS/1p1mb+RvBAuRPBPZ2UIUfOBbFXM
MIME-Version: 1.0
X-Received: by 2002:a92:5d03:: with SMTP id r3mr16292873ilb.278.1581619034415;
 Thu, 13 Feb 2020 10:37:14 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:37:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b76960059e7960fc@google.com>
Subject: memory leak in kcm_sendmsg
From:   syzbot <syzbot+b039f5699bd82e1fb011@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        jslaby@suse.cz, kafai@fb.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willy@infradead.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f2850dd5 Merge tag 'kbuild-fixes-v5.6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b6e2a1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2802e33434f4f863
dashboard link: https://syzkaller.appspot.com/bug?extid=b039f5699bd82e1fb011
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1036aae6e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a48aa1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b039f5699bd82e1fb011@syzkaller.appspotmail.com

executing program
executing program
BUG: memory leak
unreferenced object 0xffff88812166aa00 (size 224):
  comm "syz-executor252", pid 7098, jiffies 4294946073 (age 7.970s)
  hex dump (first 32 bytes):
    00 5f 7e 21 81 88 ff ff 00 00 00 00 00 00 00 00  ._~!............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000344c790c>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
    [<00000000344c790c>] slab_post_alloc_hook mm/slab.h:586 [inline]
    [<00000000344c790c>] slab_alloc_node mm/slab.c:3263 [inline]
    [<00000000344c790c>] kmem_cache_alloc_node+0x163/0x2f0 mm/slab.c:3575
    [<0000000055638a6a>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
    [<00000000e5df7d05>] alloc_skb include/linux/skbuff.h:1051 [inline]
    [<00000000e5df7d05>] kcm_sendmsg+0x63e/0xa6b net/kcm/kcmsock.c:969
    [<000000001a13b16a>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000001a13b16a>] sock_sendmsg+0x54/0x70 net/socket.c:672
    [<0000000051101f49>] ____sys_sendmsg+0x123/0x300 net/socket.c:2343
    [<000000002286b08d>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2397
    [<0000000027623508>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2487
    [<00000000a5d459c2>] __do_sys_sendmmsg net/socket.c:2516 [inline]
    [<00000000a5d459c2>] __se_sys_sendmmsg net/socket.c:2513 [inline]
    [<00000000a5d459c2>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2513
    [<00000000345a6e04>] do_syscall_64+0x73/0x220 arch/x86/entry/common.c:294
    [<00000000e4a592cb>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888123b6fa00 (size 512):
  comm "syz-executor252", pid 7098, jiffies 4294946073 (age 7.970s)
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 02 42 01 0a 80 00 42 86 dd  ..33....B....B..
    60 00 00 00 00 10 3a ff fe 80 00 00 00 00 00 00  `.....:.........
  backtrace:
    [<000000003f7d57be>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
    [<000000003f7d57be>] slab_post_alloc_hook mm/slab.h:586 [inline]
    [<000000003f7d57be>] slab_alloc_node mm/slab.c:3263 [inline]
    [<000000003f7d57be>] kmem_cache_alloc_node_trace+0x161/0x2f0 mm/slab.c:3593
    [<000000007b27008a>] __do_kmalloc_node mm/slab.c:3615 [inline]
    [<000000007b27008a>] __kmalloc_node_track_caller+0x38/0x50 mm/slab.c:3630
    [<00000000b67c7fa9>] __kmalloc_reserve.isra.0+0x40/0xb0 net/core/skbuff.c:142
    [<0000000084d25a21>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:210
    [<00000000e5df7d05>] alloc_skb include/linux/skbuff.h:1051 [inline]
    [<00000000e5df7d05>] kcm_sendmsg+0x63e/0xa6b net/kcm/kcmsock.c:969
    [<000000001a13b16a>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000001a13b16a>] sock_sendmsg+0x54/0x70 net/socket.c:672
    [<0000000051101f49>] ____sys_sendmsg+0x123/0x300 net/socket.c:2343
    [<000000002286b08d>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2397
    [<0000000027623508>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2487
    [<00000000a5d459c2>] __do_sys_sendmmsg net/socket.c:2516 [inline]
    [<00000000a5d459c2>] __se_sys_sendmmsg net/socket.c:2513 [inline]
    [<00000000a5d459c2>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2513
    [<00000000345a6e04>] do_syscall_64+0x73/0x220 arch/x86/entry/common.c:294
    [<00000000e4a592cb>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff8881217e5f00 (size 224):
  comm "syz-executor252", pid 7098, jiffies 4294946073 (age 7.970s)
  hex dump (first 32 bytes):
    00 5e 7e 21 81 88 ff ff 00 00 00 00 00 00 00 00  .^~!............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000344c790c>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
    [<00000000344c790c>] slab_post_alloc_hook mm/slab.h:586 [inline]
    [<00000000344c790c>] slab_alloc_node mm/slab.c:3263 [inline]
    [<00000000344c790c>] kmem_cache_alloc_node+0x163/0x2f0 mm/slab.c:3575
    [<0000000055638a6a>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:198
    [<00000000e5df7d05>] alloc_skb include/linux/skbuff.h:1051 [inline]
    [<00000000e5df7d05>] kcm_sendmsg+0x63e/0xa6b net/kcm/kcmsock.c:969
    [<000000001a13b16a>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000001a13b16a>] sock_sendmsg+0x54/0x70 net/socket.c:672
    [<0000000051101f49>] ____sys_sendmsg+0x123/0x300 net/socket.c:2343
    [<000000002286b08d>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2397
    [<0000000027623508>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2487
    [<00000000a5d459c2>] __do_sys_sendmmsg net/socket.c:2516 [inline]
    [<00000000a5d459c2>] __se_sys_sendmmsg net/socket.c:2513 [inline]
    [<00000000a5d459c2>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2513
    [<00000000345a6e04>] do_syscall_64+0x73/0x220 arch/x86/entry/common.c:294
    [<00000000e4a592cb>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812084ae00 (size 512):
  comm "syz-executor252", pid 7098, jiffies 4294946073 (age 7.970s)
  hex dump (first 32 bytes):
    a3 0f 00 00 00 00 00 00 40 00 00 00 00 00 00 00  ........@.......
    40 00 40 00 00 00 00 00 40 00 40 00 00 00 00 00  @.@.....@.@.....
  backtrace:
    [<000000003f7d57be>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
    [<000000003f7d57be>] slab_post_alloc_hook mm/slab.h:586 [inline]
    [<000000003f7d57be>] slab_alloc_node mm/slab.c:3263 [inline]
    [<000000003f7d57be>] kmem_cache_alloc_node_trace+0x161/0x2f0 mm/slab.c:3593
    [<000000007b27008a>] __do_kmalloc_node mm/slab.c:3615 [inline]
    [<000000007b27008a>] __kmalloc_node_track_caller+0x38/0x50 mm/slab.c:3630
    [<00000000b67c7fa9>] __kmalloc_reserve.isra.0+0x40/0xb0 net/core/skbuff.c:142
    [<0000000084d25a21>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:210
    [<00000000e5df7d05>] alloc_skb include/linux/skbuff.h:1051 [inline]
    [<00000000e5df7d05>] kcm_sendmsg+0x63e/0xa6b net/kcm/kcmsock.c:969
    [<000000001a13b16a>] sock_sendmsg_nosec net/socket.c:652 [inline]
    [<000000001a13b16a>] sock_sendmsg+0x54/0x70 net/socket.c:672
    [<0000000051101f49>] ____sys_sendmsg+0x123/0x300 net/socket.c:2343
    [<000000002286b08d>] ___sys_sendmsg+0x8a/0xd0 net/socket.c:2397
    [<0000000027623508>] __sys_sendmmsg+0xf4/0x270 net/socket.c:2487
    [<00000000a5d459c2>] __do_sys_sendmmsg net/socket.c:2516 [inline]
    [<00000000a5d459c2>] __se_sys_sendmmsg net/socket.c:2513 [inline]
    [<00000000a5d459c2>] __x64_sys_sendmmsg+0x28/0x30 net/socket.c:2513
    [<00000000345a6e04>] do_syscall_64+0x73/0x220 arch/x86/entry/common.c:294
    [<00000000e4a592cb>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

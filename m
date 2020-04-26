Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60769C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FF62070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgDZKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:48:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35781 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgDZKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:48:15 -0400
Received: by mail-il1-f199.google.com with SMTP id r5so16412446ilq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 03:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cja73Q9x3T0qZ2w6wqeSwJDFi7S8FlBRPPFD5tjghlM=;
        b=Owq9J0WmlE0I1GcdxQx5qT9xTBkvOXNs3U8LP/wFBuFdTGSw0dUFqIrqsvFSC/yNUu
         IRU7qF231fFcV9362gDgc8Mta1otPjSMfxMD+7mSQrPw9bcZN2UjwqafkFZ6XscDbIEn
         oJLAB77abshn5iG25ii6dBxXmdy2g+6Al1gjCkXYSbJDY/3f+KaRCqNn91MUJ8z+840C
         xhK3aTENebWjn4KDp+W6WbxAzLLHs8BtIDdn1sDcjZ5q6qDjzSJLmGIpkiCG8rZophY4
         2B2NpAg0OjygQ/G6H+e81U+0S74e328m67t26Nt4uHpkGoujOSzuq015fkXn5Nu3e2E3
         GAZg==
X-Gm-Message-State: AGi0PuZ8yUCAVUVobLHT2AKfVcm9lwBHZ1BilTsGqQph/W4At6EuXq1E
        wtb+Tx+VFZWkHEog72RYzPoXYYSyJcsjP3Up6RJorv5t4DIj
X-Google-Smtp-Source: APiQypJQccB0tZIECXflUdtADEHvbAS1csm6I84mtEBHpi5aAsjJ45LgeZSr3mlxFeMtSKvZNnkwreUYr0Icmv0awkqyobVrWiu4
MIME-Version: 1.0
X-Received: by 2002:a92:d186:: with SMTP id z6mr16032847ilz.119.1587898094759;
 Sun, 26 Apr 2020 03:48:14 -0700 (PDT)
Date:   Sun, 26 Apr 2020 03:48:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0b6be05a42f555e@google.com>
Subject: KMSAN: uninit-value in bpf_skb_load_helper_32
From:   syzbot <syzbot+ae94def68efda6a4be52@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, glider@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9535d09e page_alloc: drop a call to kmsan_split_page()
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=105fa39be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5915107b3106aaa
dashboard link: https://syzkaller.appspot.com/bug?extid=ae94def68efda6a4be52
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17314f58100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ae94def68efda6a4be52@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
BUG: KMSAN: uninit-value in __fswab32 include/uapi/linux/swab.h:60 [inline]
BUG: KMSAN: uninit-value in __swab32p include/uapi/linux/swab.h:189 [inline]
BUG: KMSAN: uninit-value in __be32_to_cpup include/uapi/linux/byteorder/little_endian.h:82 [inline]
BUG: KMSAN: uninit-value in get_unaligned_be32 include/linux/unaligned/access_ok.h:30 [inline]
BUG: KMSAN: uninit-value in ____bpf_skb_load_helper_32 net/core/filter.c:246 [inline]
BUG: KMSAN: uninit-value in bpf_skb_load_helper_32+0x18b/0x2d0 net/core/filter.c:232
CPU: 0 PID: 10091 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 __arch_swab32 arch/x86/include/uapi/asm/swab.h:10 [inline]
 __fswab32 include/uapi/linux/swab.h:60 [inline]
 __swab32p include/uapi/linux/swab.h:189 [inline]
 __be32_to_cpup include/uapi/linux/byteorder/little_endian.h:82 [inline]
 get_unaligned_be32 include/linux/unaligned/access_ok.h:30 [inline]
 ____bpf_skb_load_helper_32 net/core/filter.c:246 [inline]
 bpf_skb_load_helper_32+0x18b/0x2d0 net/core/filter.c:232

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2801 [inline]
 __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4420
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1081 [inline]
 netlink_dump+0x26b/0x1ab0 net/netlink/af_netlink.c:2219
 netlink_recvmsg+0xe88/0x1910 net/netlink/af_netlink.c:2001
 ____sys_recvmsg+0x1173/0x1240 net/socket.c:886
 ___sys_recvmsg net/socket.c:2610 [inline]
 do_recvmmsg+0x6f3/0x1eb0 net/socket.c:2708
 __sys_recvmmsg net/socket.c:2789 [inline]
 __do_sys_recvmmsg net/socket.c:2810 [inline]
 __se_sys_recvmmsg+0x25d/0x350 net/socket.c:2803
 __x64_sys_recvmmsg+0x62/0x80 net/socket.c:2803
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

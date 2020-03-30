Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59528C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3651420732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgC3PVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:21:17 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:50773 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgC3PVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:21:16 -0400
Received: by mail-il1-f199.google.com with SMTP id c9so3933206ill.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KToPExNm6RqCbkRxV4jl0trns6uhFAwDCNgSd+zMEPs=;
        b=bgUaavlLnQxUMOJ34Lxj6/3pohpGk65CpxY8i7lVkylOOUPcvLkiaRY/rXj/xAGKPr
         xPTxOWD26rQFOR7RpU97I9nDkkcCcQGfntsfTcvNark0O86llWDUbOkmgOLoiDlMRQan
         vcD6kE9maKo4Jlk5P9mczhVQP8aQpBOQ1zM6VGL6Y6khTc5XKG9jewUgcWTBSDTmd+o0
         ZcUMeda08ahZ2LWaztLws41msWqxWY2IX2io6hFCuSd5PCVJJ7jltT3tlnPzWe4y6xvJ
         POGc2fE6zs5CnGNsAxSGfV0P7+0K0XMHX/Xtf7gCCVVmADl5iaWE0/olnC4JElHkt6G/
         E0QA==
X-Gm-Message-State: ANhLgQ1JGVjQ+8IExgGXWUwfcZkjM+WsmuGPr+xB3prBnlgdkePUcH2E
        n585c16GtWQTgbnMmOi9d9UNJQtzTKbfulO15rLjXULdU96C
X-Google-Smtp-Source: ADFU+vuvRYbW9PNV/q8MLTEHWdAD4ho5LHLs9FI6is/xjztOUo844KhUO8SuovCKxjeg8nBRxi2ZRLcOAt/OOBoIbJgvi9PUz4M6
MIME-Version: 1.0
X-Received: by 2002:a92:5e55:: with SMTP id s82mr10788385ilb.62.1585581675754;
 Mon, 30 Mar 2020 08:21:15 -0700 (PDT)
Date:   Mon, 30 Mar 2020 08:21:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bf24905a21400b9@google.com>
Subject: KMSAN: uninit-value in do_dccp_getsockopt
From:   syzbot <syzbot+de5579bd3a5d86b1e863@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dccp@vger.kernel.org, gerrit@erg.abdn.ac.uk,
        glider@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c95d0c95 kmsan: block: skip bio block merging logic for KM..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=153677bbe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7811db4cc444a7f6
dashboard link: https://syzkaller.appspot.com/bug?extid=de5579bd3a5d86b1e863
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de5579bd3a5d86b1e863@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ccid_hc_rx_getsockopt net/dccp/ccids/../ccid.h:246 [inline]
BUG: KMSAN: uninit-value in do_dccp_getsockopt+0x1851/0x1e10 net/dccp/proto.c:671
CPU: 1 PID: 28577 Comm: syz-executor.1 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 ccid_hc_rx_getsockopt net/dccp/ccids/../ccid.h:246 [inline]
 do_dccp_getsockopt+0x1851/0x1e10 net/dccp/proto.c:671
 dccp_getsockopt+0xfd/0x200 net/dccp/proto.c:694
 sock_common_getsockopt+0x13f/0x180 net/core/sock.c:3111
 __sys_getsockopt+0x533/0x7b0 net/socket.c:2177
 __do_sys_getsockopt net/socket.c:2192 [inline]
 __se_sys_getsockopt+0xe1/0x100 net/socket.c:2189
 __x64_sys_getsockopt+0x62/0x80 net/socket.c:2189
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f60866cdc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 00007f60866ce6d4 RCX: 000000000045c849
RDX: 00000000000000a9 RSI: 000000000000010d RDI: 0000000000000004
RBP: 000000000076bf00 R08: 00000000200000c0 R09: 0000000000000000
R10: 0000000020000140 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000174 R14: 00000000004c3f3e R15: 000000000076bf0c

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2801 [inline]
 slab_alloc mm/slub.c:2810 [inline]
 kmem_cache_alloc+0x711/0xd70 mm/slub.c:2815
 ccid_new+0x1da/0x680 net/dccp/ccid.c:148
 dccp_hdlr_ccid+0x9f/0x260 net/dccp/feat.c:39
 __dccp_feat_activate net/dccp/feat.c:339 [inline]
 dccp_feat_activate_values+0x5e9/0x1660 net/dccp/feat.c:1537
 dccp_rcv_request_sent_state_process net/dccp/input.c:468 [inline]
 dccp_rcv_state_process+0x1a6d/0x2320 net/dccp/input.c:676
 dccp_v4_do_rcv+0x221/0x330 net/dccp/ipv4.c:684
 sk_backlog_rcv include/net/sock.h:963 [inline]
 __release_sock+0x2a3/0x5c0 net/core/sock.c:2440
 release_sock+0x99/0x2a0 net/core/sock.c:2956
 inet_wait_for_connect net/ipv4/af_inet.c:588 [inline]
 __inet_stream_connect+0xb05/0x1340 net/ipv4/af_inet.c:680
 inet_stream_connect+0x101/0x180 net/ipv4/af_inet.c:719
 __sys_connect_file net/socket.c:1859 [inline]
 __sys_connect+0x6f7/0x770 net/socket.c:1876
 __do_sys_connect net/socket.c:1887 [inline]
 __se_sys_connect+0x8d/0xb0 net/socket.c:1884
 __x64_sys_connect+0x4a/0x70 net/socket.c:1884
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

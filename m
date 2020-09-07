Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7A8C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA7D821897
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIGVTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:19:20 -0400
Received: from mail-io1-f78.google.com ([209.85.166.78]:38525 "EHLO
        mail-io1-f78.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgIGVTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:19:16 -0400
Received: by mail-io1-f78.google.com with SMTP id e21so8564433iod.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 14:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PFTIS3gFr82ETlwYgwe1VRJ6YkDRdoRxI2tj6LLCPgo=;
        b=iU8D+g7nVGfMfXa+RPXh/B/lWPkMX+SOZacRLnL/prnxBtSsZJk5wAlQFiUG/N1GHq
         gNUxK15wREPzsUf9r/2imv7xCfQK1Rb4udLeu3YMeR1yzPjXIfcvF9MS2qLmPnPW0XVv
         gHVUe3Dx116swwJZz+w5Nmf03JJ9eCiJUqD/3Oygdl/isac0P4sXsyMQduNLlOWb6uvH
         vvvfkScocYSPRK0K23yys4svL8WIQ+FAyI/zmc6BFfY5cdvhokML3RDpkugTbKTYD9y8
         PYJZRo35La5ObNkdNLneG9T9ifrd49xIgz0gQk97TyEiO2ALnPXtp5l2cMK0dRLiLU1c
         WuTw==
X-Gm-Message-State: AOAM5307FrrReeFVOFKAvqKMmncFqJz7MXnYPb4NKXjoQsBSkLJvtXKW
        G30ToCFSPTJwnNtYXOnH2kIaXS22TNTSMQEo+Zg2cZzbYFUP
X-Google-Smtp-Source: ABdhPJzptOXBHLwhGfFOSxFTtsWYVyJSiXHkMhLKYHZxhmxB51hK+7wGP5yMlnSDPzgICWv9Si2kcVXscSLWnpxxI2G8+jWU9jgJ
MIME-Version: 1.0
X-Received: by 2002:a92:d601:: with SMTP id w1mr20668148ilm.251.1599513555227;
 Mon, 07 Sep 2020 14:19:15 -0700 (PDT)
Date:   Mon, 07 Sep 2020 14:19:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045d89d05aebfc579@google.com>
Subject: WARNING: locking bug in __atomic_notifier_call_chain
From:   syzbot <syzbot+ff42f38fc7fac3423b16@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a8205e31 Merge tag 'io_uring-5.9-2020-09-06' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f5880d900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b0e48dac62b2233
dashboard link: https://syzkaller.appspot.com/bug?extid=ff42f38fc7fac3423b16
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17734d95900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167c90dd900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13982159900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10582159900000
console output: https://syzkaller.appspot.com/x/log.txt?x=17982159900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff42f38fc7fac3423b16@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(chain_key != INITIAL_CHAIN_KEY)
WARNING: CPU: 0 PID: 10424 at kernel/locking/lockdep.c:4404 __lock_acquire+0x1a0f/0x5570 kernel/locking/lockdep.c:4404
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 10424 Comm:  Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:__lock_acquire+0x1a0f/0x5570 kernel/locking/lockdep.c:4404
Code: d2 0f 85 d1 2f 00 00 44 8b 3d d5 81 58 09 45 85 ff 0f 85 73 f3 ff ff 48 c7 c6 00 d4 4b 88 48 c7 c7 20 a8 4b 88 e8 43 32 eb ff <0f> 0b e9 5c f3 ff ff 48 c7 c2 60 31 97 8c 48 b8 00 00 00 00 00 fc
RSP: 0018:ffffc900055472e0 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000007000000 RCX: 0000000000000000
RDX: ffff888000132000 RSI: ffffffff815db9a7 RDI: fffff52000aa8e4e
RBP: ffff8880001328e8 R08: 0000000000000000 R09: ffffffff89bcb4a3
R10: 00000000000005a3 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888000132000 R15: 0000000000000000
 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
 rcu_lock_acquire include/linux/rcupdate.h:241 [inline]
 rcu_read_lock include/linux/rcupdate.h:634 [inline]
 __atomic_notifier_call_chain+0x48/0x180 kernel/notifier.c:172
 notify_write drivers/tty/vt/vt.c:264 [inline]
 cr drivers/tty/vt/vt.c:1517 [inline]
 vc_con_write_normal drivers/tty/vt/vt.c:2805 [inline]
 do_con_write+0xed5/0x1d70 drivers/tty/vt/vt.c:2910
 con_write+0x22/0xb0 drivers/tty/vt/vt.c:3250
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x3ce/0xf80 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x4d9/0x870 drivers/tty/tty_io.c:1046
 __kernel_write+0x199/0x570 fs/read_write.c:528
 write_pipe_buf+0x153/0x1f0 fs/splice.c:799
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x3dc/0x830 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 default_file_splice_write fs/splice.c:811 [inline]
 do_splice_from fs/splice.c:847 [inline]
 direct_splice_actor+0x228/0x2f0 fs/splice.c:1016
 splice_direct_to_actor+0x38c/0x980 fs/splice.c:971
 do_splice_direct+0x1b3/0x280 fs/splice.c:1059
 do_sendfile+0x55f/0xd40 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1587
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446ac9
Code: Bad RIP value.
RSP: 002b:00007f7bb7b3cd18 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 0000000000446ac9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00000000006dbc50 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 0800000080004103 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007f7bb7b3cd20 R14: 00007f7bb7b3cd20 R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

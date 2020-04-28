Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9CCC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0BE220661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgD1E6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:58:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39710 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD1E6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:58:14 -0400
Received: by mail-il1-f197.google.com with SMTP id c11so13769027ilr.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jDxTq18iQLRP71qk5eZAXRKfx5I/e7pacfifgvLqqOY=;
        b=eCqDl+Q6oxJQp1Dzq2UtZSTmZ46tZSWWrE6vauHZFSwekKDuSbxymzZ+1SRuX6xse0
         oF8iyFhvocm4VHtj36kIhBtkwnTXuYdNU0qXJgcPEinrczwz/wNcS05/gz7XS5SqYH3M
         AJgolZJHNiZdAa9T1pDhgTG9ZpFiwDpHGOrGFdNlsaXWI5Iuagxw8aDM74/wlYZNWk4/
         z8X/AAMXYieowiOJQ+5CfyqqXUYHU7Equ1LKuL8FW6lxoh9yAiTKe4hcew28hjto4aC+
         3ugMPIedZMJTU7E95Sgrys8FMtO5sjvqbRgjvjLSS1g8l1BAm9s1iEH9LhpFbarorSaY
         bOTQ==
X-Gm-Message-State: AGi0PuY0COwFXX33Fja62Rbr+oUxKonCIbCZh2JzxaqjZSJRtzamljdp
        9Eyn3ReT/Q+Wk4nKqbvPo2vwtysVcdIMgTx0SGQkCKTFYYo9
X-Google-Smtp-Source: APiQypKO9qT/WbPujDkprL5mYneQXm6Kg8tQh8e3bmDL4h64jSR4p3haxuo0qZycTXhbhCbPjGczxXFFh3CIJ4A2NyTkzmECUpH3
MIME-Version: 1.0
X-Received: by 2002:a5d:8c81:: with SMTP id g1mr8512085ion.197.1588049893648;
 Mon, 27 Apr 2020 21:58:13 -0700 (PDT)
Date:   Mon, 27 Apr 2020 21:58:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbf17205a452ad4f@google.com>
Subject: net test error: KASAN: null-ptr-deref Write in x25_disconnect
From:   syzbot <syzbot+6db548b615e5aeefdce2@syzkaller.appspotmail.com>
To:     andrew.hendry@gmail.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tanxin.ctf@gmail.com, tglx@linutronix.de, xiyuyang19@fudan.edu.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    37255e7a Merge tag 'batadv-net-for-davem-20200427' of git:..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=12b2e5d8100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7a70e992f2f9b68
dashboard link: https://syzkaller.appspot.com/bug?extid=6db548b615e5aeefdce2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6db548b615e5aeefdce2@syzkaller.appspotmail.com

can: request_module (can-proto-0) failed.
can: request_module (can-proto-0) failed.
can: request_module (can-proto-0) failed.
==================================================================
BUG: KASAN: null-ptr-deref in atomic_fetch_sub include/asm-generic/atomic-instrumented.h:199 [inline]
BUG: KASAN: null-ptr-deref in refcount_sub_and_test include/linux/refcount.h:266 [inline]
BUG: KASAN: null-ptr-deref in refcount_dec_and_test include/linux/refcount.h:294 [inline]
BUG: KASAN: null-ptr-deref in x25_neigh_put include/net/x25.h:253 [inline]
BUG: KASAN: null-ptr-deref in x25_disconnect+0x253/0x370 net/x25/x25_subr.c:361
Write of size 4 at addr 00000000000000d8 by task syz-fuzzer/7147

CPU: 0 PID: 7147 Comm: syz-fuzzer Not tainted 5.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x4d mm/kasan/report.c:515
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 atomic_fetch_sub include/asm-generic/atomic-instrumented.h:199 [inline]
 refcount_sub_and_test include/linux/refcount.h:266 [inline]
 refcount_dec_and_test include/linux/refcount.h:294 [inline]
 x25_neigh_put include/net/x25.h:253 [inline]
 x25_disconnect+0x253/0x370 net/x25/x25_subr.c:361
 x25_release+0x345/0x420 net/x25/af_x25.c:665
 __sock_release+0xcd/0x280 net/socket.c:605
 sock_close+0x18/0x20 net/socket.c:1283
 __fput+0x33e/0x880 fs/file_table.c:280
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x4afb40
Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
RSP: 002b:000000c0001e94f8 EFLAGS: 00000216 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000000c00002c000 RCX: 00000000004afb40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000c0001e9538 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000216 R12: ffffffffffffffff
R13: 0000000000000164 R14: 0000000000000163 R15: 0000000000000200
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

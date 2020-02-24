Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA7BC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494A420838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBXPuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:50:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:37160 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgBXPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:50:13 -0500
Received: by mail-il1-f197.google.com with SMTP id z79so19128716ilf.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0SPr26mI+Ln+VEGi2ZBkQ06IkHYjWyiRTey+U7CAMzI=;
        b=OmqfdA/yTh4TFhKvNOOsY+7qTOSkpNDKRFn7rHwQqsKfySftW14Y1IvaN0M9IoLBBF
         5DRJoVN2Wy+QE8L1p92Xk/tntdw3tBeuN/eum0wvDwCttdOJsy0MpZLES/a7L8B+GrnO
         NvTXtB3pldGzAwq3RR0DRVC7ZqYP2ZL8tGDQ7kJwL7QPtcf5LKkOX3uHRdVhv9TSwFWF
         cj6gIPk7fz2YCwIygR0yUdwV4U5XmlLOGfsd4I2TocMbQflWYwxR1z4/u6CMZfyaAFRM
         dJ/zAQmCvcJ1cwMFmD0E7QJyTKGqwcUJIDpJh/l0nDr16NYy9OcQjOKNFsuvMvqKP+xk
         wh0Q==
X-Gm-Message-State: APjAAAU9E1szVUUP9myI3OGLFUTTJ/vZ1VwV9i3iIlUwf+G2No1UeTFe
        3d0OezdzpPyaQSxlLUW2XllGmpD7fmZjAVQe8zuZjsml1Drj
X-Google-Smtp-Source: APXvYqw8l+W5ul1p0y8OZ7F3acv+6dm6McJK460la8gPyOWNNrGQ8+HpzuwTA3I8Sjoe3TrlWO955kYHB2Gd+qamKrawFaqXHjCj
MIME-Version: 1.0
X-Received: by 2002:a6b:9188:: with SMTP id t130mr48740603iod.215.1582559413092;
 Mon, 24 Feb 2020 07:50:13 -0800 (PST)
Date:   Mon, 24 Feb 2020 07:50:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a74731059f545387@google.com>
Subject: WARNING in tracepoint_probe_register_prio (4)
From:   syzbot <syzbot+1b2f76c6fb6f549f728b@syzkaller.appspotmail.com>
To:     allison@lohutok.net, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    50089780 selftests/bpf: Fix build of sockmap_ktls.c
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13087de9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=768cc3d3e277cc16
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2f76c6fb6f549f728b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1b2f76c6fb6f549f728b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 25402 at kernel/tracepoint.c:243 tracepoint_add_func kernel/tracepoint.c:243 [inline]
WARNING: CPU: 1 PID: 25402 at kernel/tracepoint.c:243 tracepoint_probe_register_prio+0x217/0x790 kernel/tracepoint.c:315
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 25402 Comm: syz-executor.3 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x3e kernel/panic.c:582
 report_bug+0x289/0x300 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:tracepoint_add_func kernel/tracepoint.c:243 [inline]
RIP: 0010:tracepoint_probe_register_prio+0x217/0x790 kernel/tracepoint.c:315
Code: 48 89 f8 48 c1 e8 03 80 3c 08 00 0f 85 bf 04 00 00 48 8b 45 b8 49 3b 45 08 0f 85 21 ff ff ff 41 bd ef ff ff ff e8 d9 7b fe ff <0f> 0b e8 d2 7b fe ff 48 c7 c7 e0 5d be 89 e8 16 52 78 06 44 89 e8
RSP: 0018:ffffc90001617a68 EFLAGS: 00010212
RAX: 0000000000040000 RBX: ffffffff8aa13ec0 RCX: ffffc9001009d000
RDX: 000000000000191d RSI: ffffffff81771237 RDI: ffff888090ad3d30
RBP: ffffc90001617ac0 R08: ffff88809ae4e600 R09: fffffbfff137cbbd
R10: ffffc90001617a58 R11: ffffffff89be5de7 R12: ffff888090ad3d10
R13: 00000000ffffffef R14: 00000000ffffffff R15: ffffffff81505c80
 tracepoint_probe_register+0x2b/0x40 kernel/tracepoint.c:335
 trace_event_reg+0x299/0x350 kernel/trace/trace_events.c:301
 perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
 perf_trace_event_init+0x564/0x9c0 kernel/trace/trace_event_perf.c:204
 perf_trace_init+0x189/0x250 kernel/trace/trace_event_perf.c:228
 perf_tp_event_init+0xa6/0x120 kernel/events/core.c:9020
 perf_try_init_event+0x135/0x590 kernel/events/core.c:10471
 perf_init_event kernel/events/core.c:10523 [inline]
 perf_event_alloc.part.0+0x158f/0x3710 kernel/events/core.c:10803
 perf_event_alloc kernel/events/core.c:11170 [inline]
 __do_sys_perf_event_open+0x6f6/0x2c00 kernel/events/core.c:11286
 __se_sys_perf_event_open kernel/events/core.c:11160 [inline]
 __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:11160
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c449
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5cb81c1c78 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f5cb81c26d4 RCX: 000000000045c449
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000002025c000
RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000812 R14: 00000000004ca890 R15: 000000000076bfcc
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

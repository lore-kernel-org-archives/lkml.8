Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DCBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 03:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC1020758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 03:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgERDMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 23:12:21 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:54610 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgERDMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 23:12:21 -0400
Received: by mail-io1-f70.google.com with SMTP id t23so7487334iog.21
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 20:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CAsDS7ZIgusWr675bltnlikqaEpJeccBYtHQhstg4Ic=;
        b=aI3GL71LsFYfdQ0DkHDYZqiC0ZtyrFVYfgH4B3Zq21riIUEv/7aTwor2EuE+oAtN03
         n2Igi74HFvJ2TmrIHlnWUA3BQRp6AEsny5gPgsRUoU+BUKbumufnpzDCzpgfMS+UOwkH
         fdlx/ExChp9XZgYMIiTTPmxGirjHHkjtbf3NpmAZcBNQ/kWa7ZKV2yyoxfmG/excaEXO
         Vdo7A0E+dtGx3vBYxJnoHW1dS5oPXOHOmHGUhS1WCc/fk9GVxlxLJ2c0AZ6L4kyGHnHX
         LTBS785xThoRjO0HetW6jdfBRtER5mHVpRw9tWGZUa6/CTzXvCgCQNPqBhTR9S4yIsh9
         riSA==
X-Gm-Message-State: AOAM530EOwvYYFvyDKJu8O85UGTWVrA00L/fdmsN45rVm1KGrUOUtAwh
        2UX08aDzEKOOj7psXanWPnLc4ERikUdKZ10YiFizZdkl9L6G
X-Google-Smtp-Source: ABdhPJyK2qLknPz//aJAU2TRbiB9Ss/X223242JI7yptearMkyTLWIEipJILHaxT6vZdqEsNMzTeqMYHboGXUPeSrjtOWyAxJc9P
MIME-Version: 1.0
X-Received: by 2002:a02:a11c:: with SMTP id f28mr14094576jag.22.1589771539493;
 Sun, 17 May 2020 20:12:19 -0700 (PDT)
Date:   Sun, 17 May 2020 20:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2b80305a5e387d7@google.com>
Subject: WARNING in get_probe_ref
From:   syzbot <syzbot+8672dcb9d10011c0a160@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    24085f70 Merge tag 'trace-v5.7-rc4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117087fa100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efdde85c3af536b5
dashboard link: https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c09dc100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178fa32c100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8672dcb9d10011c0a160@syzkaller.appspotmail.com

RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000002003033
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402f60
R13: 0000000000402ff0 R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7052 at kernel/trace/blktrace.c:1115 blk_register_tracepoints kernel/trace/blktrace.c:1115 [inline]
WARNING: CPU: 0 PID: 7052 at kernel/trace/blktrace.c:1115 get_probe_ref+0x327/0x3e0 kernel/trace/blktrace.c:324
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7052 Comm: syz-executor149 Not tainted 5.7.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:blk_register_tracepoints kernel/trace/blktrace.c:1115 [inline]
RIP: 0010:get_probe_ref+0x327/0x3e0 kernel/trace/blktrace.c:324
Code: 8a e8 3d d3 fb ff 31 ff 89 c3 89 c6 e8 62 56 fa ff 85 db 0f 84 1e fd ff ff e8 e5 54 fa ff 0f 0b e9 12 fd ff ff e8 d9 54 fa ff <0f> 0b e9 45 fd ff ff e8 cd 54 fa ff 0f 0b e9 66 fd ff ff e8 c1 54
RSP: 0018:ffffc900016a7b88 EFLAGS: 00010293
RAX: ffff8880953ba600 RBX: 00000000fffffff4 RCX: ffffffff8178dbdb
RDX: 0000000000000000 RSI: ffffffff8178de97 RDI: 0000000000000005
RBP: ffff8880a4640700 R08: ffff8880953ba600 R09: fffffbfff133f1c1
R10: ffffffff899f8e07 R11: fffffbfff133f1c0 R12: ffff8880a019d100
R13: ffff888089d24a10 R14: 0000000000000000 R15: ffff8880a4640730
 do_blk_trace_setup+0x7d3/0xb30 kernel/trace/blktrace.c:550
 __blk_trace_setup+0xca/0x180 kernel/trace/blktrace.c:571
 blk_trace_setup+0x43/0x60 kernel/trace/blktrace.c:589
 sg_ioctl_common+0x2f8/0x2720 drivers/scsi/sg.c:1120
 sg_ioctl+0x8f/0x120 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x445ca9
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b ce fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff1c9ef988 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff1c9ef990 RCX: 0000000000445ca9
RDX: 0000000020000140 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000002003033
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402f60
R13: 0000000000402ff0 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

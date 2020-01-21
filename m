Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C015C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4805920704
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAUX4J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:56:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44795 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:56:09 -0500
Received: by mail-il1-f199.google.com with SMTP id h87so3429898ild.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=FP19rMCZrA8aEYztsjM0/NcqndOiX+PGABvAiUHnfqc=;
        b=hAuZ6HzYytj83JBpQNb8biS7OrDiG72ARoWmobFg0jjM3+ykqjd4ZEw4O+Mv1yTeJk
         oDEUOgHKTubVGg2FC5tiOL0Uyz8+Sc9Nw/XUXvVXPeR2xltUPBBAsq68hYSDZscLONAl
         gcRtOvQ9kHhknj3Xjrsu9Bcqj1Wj2L70PUKBimijKMRwkOjFrx6fbX9TWPAtYfNpwYg0
         ynyIBCWEq7SV32EPv1mgKflX/eMDLiMXk0/5wSp3JJRNMKzBjW19disAkJR8P6Bdu5xh
         +XsjjyQx5edaCjIZkyD0IDhweMWXauzQDh7E5yI+8h768W2wZ3gvwdTAagG3EM6FzvdA
         lXrA==
X-Gm-Message-State: APjAAAVm68W1JHQxr20BFqiXxZYYhZqwEz9yi3Mm27Xh14li3hv4iiMF
        A66NXuoNa0l2y4rMR3vtV57YRUZmrGAImzHIMThTPXVgyyMi
X-Google-Smtp-Source: APXvYqymwTKfclatTuAPFNQc//9Mq4Cfj0YLxr8Id5jOR9C12eseDN6UMCR/SfcMmBZfnlnza7ruT/x8kczjuGhPyumIcvUsEo6K
MIME-Version: 1.0
X-Received: by 2002:a6b:731a:: with SMTP id e26mr4920571ioh.254.1579650968613;
 Tue, 21 Jan 2020 15:56:08 -0800 (PST)
Date:   Tue, 21 Jan 2020 15:56:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da7a79059caf2656@google.com>
Subject: WARNING in __proc_create (2)
From:   syzbot <syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d96d875e Merge tag 'fixes_for_v5.5-rc8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b7b80de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=b904ba7c947a37b4b291
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c96185e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f859c9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b904ba7c947a37b4b291@syzkaller.appspotmail.com

------------[ cut here ]------------
name '��/]uwo,"�c�ac�����[�$�5x~�s�&�tw}���z�cp('
WARNING: CPU: 0 PID: 3489 at fs/proc/generic.c:178 __xlate_proc_name fs/proc/generic.c:178 [inline]
WARNING: CPU: 0 PID: 3489 at fs/proc/generic.c:178 xlate_proc_name fs/proc/generic.c:194 [inline]
WARNING: CPU: 0 PID: 3489 at fs/proc/generic.c:178 __proc_create+0x25a/0xb60 fs/proc/generic.c:387
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 3489 Comm: kworker/0:8 Not tainted 5.5.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 panic+0x264/0x7a9 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1b6/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 do_error_trap+0xda/0x440 arch/x86/kernel/traps.c:267
 do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:__xlate_proc_name fs/proc/generic.c:178 [inline]
RIP: 0010:xlate_proc_name fs/proc/generic.c:194 [inline]
RIP: 0010:__proc_create+0x25a/0xb60 fs/proc/generic.c:387
Code: 07 00 00 49 89 c6 e8 f5 48 94 ff e9 56 fe ff ff e8 eb 48 94 ff 48 8b 75 b8 45 31 ed 48 c7 c7 39 52 e1 88 31 c0 e8 36 55 66 ff <0f> 0b 48 c7 c7 88 43 11 89 e8 08 de 1a 06 e9 bc 00 00 00 e8 be 48
RSP: 0018:ffffc9000b617a90 EFLAGS: 00010246
RAX: d5e5b65e165c9c00 RBX: 0000000000000005 RCX: ffff88809bb3e140
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000b617b00 R08: ffffffff815f9d24 R09: fffffbfff13cd11e
R10: fffffbfff13cd11e R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
 proc_mkdir_data+0x8b/0x150 fs/proc/generic.c:473
 proc_net_mkdir include/linux/proc_fs.h:139 [inline]
 afs_proc_cell_setup+0x9d/0x150 fs/afs/proc.c:610
 afs_activate_cell fs/afs/cell.c:591 [inline]
 afs_manage_cell+0x750/0x1500 fs/afs/cell.c:673
 process_one_work+0x7f5/0x10d0 kernel/workqueue.c:2264
 worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
 kthread+0x332/0x350 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
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

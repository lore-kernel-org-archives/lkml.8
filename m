Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E17AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D821A208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEHJ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:28:14 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49018 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgEHJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:28:13 -0400
Received: by mail-io1-f72.google.com with SMTP id p1so1267326iof.15
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=M45NYhiOkDhNVXzn+E9veIWDhXY5Tgcs9GMRd88d/wA=;
        b=Es/98GmbmDfkuI7aluVh3icN02ZqtOwpH40Wy5dWZAj7eR7vSnC0/1fnBCSe8HBeDA
         QZrQ1nAX5fEjulkrREKBZlyakyPmh6WFgrKDUnPzkpHlQhJiCQe095tkLPH2b0Q+v3YT
         Nl5eowjwSZ8iRHRKPANRmWcGwyxqFEJu5sIi/iz+2PgCdSa5/Trfo/7ZfVb0eEbZWreb
         T99HsG4H3yDXZlxpuTMFmhXEJaDReG9/3hOroONFC+upRWsLyoCwTev6ruoGmDwhJLpv
         s9V7vLwPdlearjidemp9clT2kjsYtmvXrLowNYt+L9F1Yg6KGo5L1Sa/JVXgVhxQ6RdJ
         KP4Q==
X-Gm-Message-State: AGi0PuYyui5q5uTuYcAzzXEBeXhVZTccr+s7T1hQO5YcNz+l1gDEAvqs
        og8S9Jeo1TXdfHIRpedjxcikeAuA/WOQT1jG/ZAiKEcoi/u/
X-Google-Smtp-Source: APiQypKt+590tOHdh0r3kO47FiNs0JpumYuqScz3lsN3PuoZSq+8b+AqcFgbgo30VfZAIU/DW3QKUlTCrSxi98Vb5/8Pqkx8xUIh
MIME-Version: 1.0
X-Received: by 2002:a92:2411:: with SMTP id k17mr1907949ilk.138.1588930092814;
 Fri, 08 May 2020 02:28:12 -0700 (PDT)
Date:   Fri, 08 May 2020 02:28:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c15b0c05a51f9d8c@google.com>
Subject: KASAN: user-memory-access Read in do_con_trol
From:   syzbot <syzbot+c5c252a500b90d63e07f@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org, nico@fluxnic.net,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3c40cdb0 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14733d6c100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0212dbee046bc1f
dashboard link: https://syzkaller.appspot.com/bug?extid=c5c252a500b90d63e07f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c5c252a500b90d63e07f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in memcpy include/linux/string.h:381 [inline]
BUG: KASAN: user-memory-access in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: user-memory-access in delete_char drivers/tty/vt/vt.c:853 [inline]
BUG: KASAN: user-memory-access in csi_P drivers/tty/vt/vt.c:2008 [inline]
BUG: KASAN: user-memory-access in do_con_trol+0x364/0x5d00 drivers/tty/vt/vt.c:2402
Read of size 398 at addr 00000000fffffe82 by task syz-executor.5/11995

CPU: 1 PID: 11995 Comm: syz-executor.5 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 __kasan_report.cold+0x5/0x4d mm/kasan/report.c:515
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 check_memory_region_inline mm/kasan/generic.c:187 [inline]
 check_memory_region+0x141/0x190 mm/kasan/generic.c:193
 memcpy+0x20/0x60 mm/kasan/common.c:106
 memcpy include/linux/string.h:381 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 delete_char drivers/tty/vt/vt.c:853 [inline]
 csi_P drivers/tty/vt/vt.c:2008 [inline]
 do_con_trol+0x364/0x5d00 drivers/tty/vt/vt.c:2402
 do_con_write.part.0+0xf34/0x1dc0 drivers/tty/vt/vt.c:2818
 do_con_write drivers/tty/vt/vt.c:2588 [inline]
 con_write+0x41/0xe0 drivers/tty/vt/vt.c:3154
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x3f0/0xf90 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x495/0x800 drivers/tty/tty_io.c:1046
 __vfs_write+0x76/0x100 fs/read_write.c:495
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x12d/0x250 fs/read_write.c:612
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c829
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe8c3dc7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000050c660 RCX: 000000000045c829
RDX: 0000000000000320 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000cea R14: 00000000004cf16f R15: 00007fe8c3dc86d4
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

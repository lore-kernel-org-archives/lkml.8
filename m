Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA713C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D099E2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgHVERX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:17:23 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39919 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgHVERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:17:22 -0400
Received: by mail-il1-f197.google.com with SMTP id i66so2796260ile.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M0A2TpQMGIAZuK7E9ejd89o2KGRDiCUliGdbVXaZX8w=;
        b=IesukoAGdUgmtvTr+9SYCjQMTbelaxHqRGhp0lliKq36b0HIFcVnUsH82RJwt1xE6b
         xGVX/Gv+G6XhWvm2k6kkui5OVr4Nqd4Gx+X8VrEu4FrviiCxcTeeoOrahUMACIyBhi/8
         KycuA4i/ow9C/8DyZ0AwuMGNh0PsKNTXuSsaFdJWGAeAzcq0tRuE9qEC4SjWo4l776nk
         4+wVBZ8cJBkzmNkCKhQTZUcA9u6icjAUxjc0eEr6kps4afU5Ie1RxvH0ZW+bwhbgKp/I
         XojzsXgs6bau+Dr9CpJI6otsblEOHfW5YWcaTqFHE1KuwWJ8UuxT3PBEdSqPKzo2eN9g
         CTSA==
X-Gm-Message-State: AOAM533JmTdDitrt2f07u0whZMsK/gklykpO3089Trku/JelzSs3ZPG/
        wLCpJqgdC77lLRxqgksfrZN8ZtxPPY5R7cmq4tOyGNU2cEun
X-Google-Smtp-Source: ABdhPJxm9rRM3bX8xphfAlh0Y255hGLZm0G5ZJZ8nOYXspIdQJlvK9RlCIsZnXgtcnZeavfHotAMbvvyEOb0SZbp+YrkHju2eyPZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:de4:: with SMTP id m4mr4481823ilj.156.1598069841130;
 Fri, 21 Aug 2020 21:17:21 -0700 (PDT)
Date:   Fri, 21 Aug 2020 21:17:21 -0700
In-Reply-To: <000000000000e8f42805ad5d136c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034fc2105ad6fa1ba@google.com>
Subject: Re: KASAN: use-after-free Write in vcs_read
From:   syzbot <syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    494d311a Add linux-next specific files for 20200821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12454db1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61d44f28687f508
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1f53726c3bd11180cb
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16704b7e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588a046900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
BUG: KASAN: use-after-free in vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
Write of size 2 at addr ffff888093948000 by task syz-executor760/6850

CPU: 0 PID: 6850 Comm: syz-executor760 Not tainted 5.9.0-rc1-next-20200821-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 vcs_read_buf drivers/tty/vt/vc_screen.c:357 [inline]
 vcs_read+0xaa7/0xb40 drivers/tty/vt/vc_screen.c:449
 do_loop_readv_writev fs/read_write.c:734 [inline]
 do_loop_readv_writev fs/read_write.c:721 [inline]
 do_iter_read+0x48e/0x6e0 fs/read_write.c:955
 vfs_readv+0xe5/0x150 fs/read_write.c:1073
 do_preadv fs/read_write.c:1165 [inline]
 __do_sys_preadv fs/read_write.c:1215 [inline]
 __se_sys_preadv fs/read_write.c:1210 [inline]
 __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441259
Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 1b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffb3e6b7d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441259
RDX: 0000000000000006 RSI: 0000000020001b00 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000402000
R13: 0000000000402090 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:000000006b61c24f refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x93948
flags: 0xfffe0000000000()
raw: 00fffe0000000000 ffffea00029cd508 ffffea00024f3848 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffff7f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888093947f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888093947f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888093948000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888093948080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888093948100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


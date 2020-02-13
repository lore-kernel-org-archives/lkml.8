Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897D6C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF14206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgBMQ5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:57:13 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:48020 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgBMQ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:57:13 -0500
Received: by mail-io1-f71.google.com with SMTP id 13so4651525iof.14
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 08:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C24idpA4a3f8u60jOu7IvjaLcash/yizX9Szs+IG6V4=;
        b=qojIDpui8w2jmuI1sMih19VEGcMXi/PTcoyHPg8PiDNdCH8jvJKISn8DSp8QQadIfP
         6jRSwyjnLNdoQqs6vhFAt8MKU4i55pUlImjXO3lxObN3UqSSRqDcGz1KrS4Z0PUQ+nrX
         9zqk3V775wFOoTBjStL0khVU4vbVYm0QXhwRPAbzCMtp2vLhWeiFFUMlOTUQcPnTpXW/
         D6uawfaumIqGZ7+MqTJNzj4Ct+OlB5XSsjhuTYtxIh/vbrDPsUICuBNhivZiAlwajBVs
         oc0p1lBZdtnSiaTk7iiOEjs7bpszW7nvGBQKD+h6Zy8h1cdSeYQFiHoFGndIQ7redZGe
         cVZg==
X-Gm-Message-State: APjAAAVFb6A6nNfdmVRowtvhMRK0Gf+YDNvRzNBtaUyHZnGDqMZ5URt2
        mcrlYtJgV6N90XAeNZFG8esuhvjlScuyDdyavNlEGWCByLMJ
X-Google-Smtp-Source: APXvYqxpwVAQZkfvsZAQ39jsYrOBUdW89qK/cHZ757RK94MPdh86cFGQT2Ggu3JBScY+HnoqhHsS/RgW2vbOrCHQP86sLbeQ3zmJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2345:: with SMTP id r5mr20997196iot.156.1581613032630;
 Thu, 13 Feb 2020 08:57:12 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:57:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb6fa1059e77fa6e@google.com>
Subject: KASAN: null-ptr-deref Read in do_con_write
From:   syzbot <syzbot+4b25dd89f2c5d49296d2@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        ghalat@redhat.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        okash.khawaja@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f2850dd5 Merge tag 'kbuild-fixes-v5.6' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122f97a5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6780df5a5f208964
dashboard link: https://syzkaller.appspot.com/bug?extid=4b25dd89f2c5d49296d2
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b29701e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c8fc09e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4b25dd89f2c5d49296d2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: null-ptr-deref in delete_char drivers/tty/vt/vt.c:852 [inline]
BUG: KASAN: null-ptr-deref in csi_P drivers/tty/vt/vt.c:1985 [inline]
BUG: KASAN: null-ptr-deref in do_con_trol drivers/tty/vt/vt.c:2379 [inline]
BUG: KASAN: null-ptr-deref in do_con_write+0x94d2/0xf360 drivers/tty/vt/vt.c:2797
Read of size 4294967294 at addr 0000000000000012 by task syz-executor662/8804

CPU: 0 PID: 8804 Comm: syz-executor662 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 __kasan_report+0x167/0x1c0 mm/kasan/report.c:510
 kasan_report+0x26/0x50 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:182 [inline]
 check_memory_region+0x2b6/0x2f0 mm/kasan/generic.c:192
 memcpy+0x28/0x60 mm/kasan/common.c:127
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 delete_char drivers/tty/vt/vt.c:852 [inline]
 csi_P drivers/tty/vt/vt.c:1985 [inline]
 do_con_trol drivers/tty/vt/vt.c:2379 [inline]
 do_con_write+0x94d2/0xf360 drivers/tty/vt/vt.c:2797
 con_write+0x25/0x40 drivers/tty/vt/vt.c:3135
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0xd0c/0x1200 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046
 __vfs_write+0xb8/0x740 fs/read_write.c:494
 vfs_write+0x270/0x580 fs/read_write.c:558
 ksys_write+0x117/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:620
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffb1720718 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

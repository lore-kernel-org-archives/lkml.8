Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CACB216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgIHKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:18:45 -0400
Received: from mail-il1-f208.google.com ([209.85.166.208]:39785 "EHLO
        mail-il1-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbgIHKSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:18:21 -0400
Received: by mail-il1-f208.google.com with SMTP id v17so4551860ilg.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 03:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0bSWlbsyi2aDsVDomNbcpNgOSd5Rg8Cy9nvCtewW0AM=;
        b=m2fOgkKPVXU9mh1W3Vyv9jtVd2hZZfWbAIqBqOXqbFoKN5oCUfiHfg8svoCKI0zhmt
         HagD+5nwH0BLIJWE0uIgWhc13WU27aKSZ80FVsGcz+TA5Sb2RjoAkqEM1u8FMn15rlG1
         TA9yRJc4wHNP2wKUsYelQIBHDruvoP3NUdSaypZAbVVYDFDlm32BYBjwnANwOefDtFU3
         cQid92EGRme/u/6v6giHLJ62SUICS2VxQYAh0gTPGFv+0NouFxrO6FcRP/BAkC5W83aw
         VhELhtalx6jnjJViOruOpkPkQiMLPh1qs3VnnM4pmewk1NuPHCggJhzv5EQM+l1OMo0v
         RKsA==
X-Gm-Message-State: AOAM532QmZ3JHehonlJPgqMjOccRBR6hZ/OUmcbE5Vr7mvWnAtPBS8HG
        SO/T5vE304tZ9ksNjbPQMKYjZ70XXMBlYAIJgn4XLoTjnh0O
X-Google-Smtp-Source: ABdhPJwMlsgrHN6/6ENIqOM32foFO1wE4CKHB1fozmz5vwpDTJyhuN8bdbNalnHJ5NBHnbPiR38Fu2iWO5mrGH/zjM6RNwyiML7+
MIME-Version: 1.0
X-Received: by 2002:a02:1142:: with SMTP id 63mr23466142jaf.73.1599560300476;
 Tue, 08 Sep 2020 03:18:20 -0700 (PDT)
Date:   Tue, 08 Sep 2020 03:18:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081bfe405aecaa78e@google.com>
Subject: KASAN: unknown-crash Write in do_con_write
From:   syzbot <syzbot+f182cd6b3b3fa5319c78@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f4d51dff Linux 5.9-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1655cb35900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f5c353182ed6199
dashboard link: https://syzkaller.appspot.com/bug?extid=f182cd6b3b3fa5319c78
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d7617d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154ebbcd900000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10891c29900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12891c29900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14891c29900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f182cd6b3b3fa5319c78@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: unknown-crash in notify_write drivers/tty/vt/vt.c:263 [inline]
BUG: KASAN: unknown-crash in cr drivers/tty/vt/vt.c:1517 [inline]
BUG: KASAN: unknown-crash in vc_con_write_normal drivers/tty/vt/vt.c:2805 [inline]
BUG: KASAN: unknown-crash in do_con_write+0x1270/0xd580 drivers/tty/vt/vt.c:2910
Write of size 8 at addr ffffc9000aa1f7a0 by task syz-executor240/10440

CPU: 1 PID: 10440 Comm: syz-executor240 Not tainted 5.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1d6/0x29e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 notify_write drivers/tty/vt/vt.c:263 [inline]
 cr drivers/tty/vt/vt.c:1517 [inline]
 vc_con_write_normal drivers/tty/vt/vt.c:2805 [inline]
 do_con_write+0x1270/0xd580 drivers/tty/vt/vt.c:2910
 con_write+0x20/0x40 drivers/tty/vt/vt.c:3250
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0xcbf/0x1170 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x593/0x940 drivers/tty/tty_io.c:1046
 __kernel_write+0x1ac/0xac0 fs/read_write.c:528
 write_pipe_buf+0xf9/0x150 fs/splice.c:799
 splice_from_pipe_feed fs/splice.c:502 [inline]
 __splice_from_pipe+0x351/0x8b0 fs/splice.c:626
 splice_from_pipe fs/splice.c:661 [inline]
 default_file_splice_write fs/splice.c:811 [inline]
 do_splice_from fs/splice.c:847 [inline]
 direct_splice_actor+0x1eb/0x2a0 fs/splice.c:1016
 splice_direct_to_actor+0x4a2/0xb60 fs/splice.c:971
 do_splice_direct+0x201/0x340 fs/splice.c:1059
 do_sendfile+0x86d/0x1210 fs/read_write.c:1540
 __do_sys_sendfile64 fs/read_write.c:1601 [inline]
 __se_sys_sendfile64 fs/read_write.c:1587 [inline]
 __x64_sys_sendfile64+0x164/0x1a0 fs/read_write.c:1587
 do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446ac9
Code: e8 9c b4 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb3d5c84d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000006dbc58 RCX: 0000000000446ac9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00000000006dbc50 R08: 65732f636f72702f R09: 65732f636f72702f
R10: 0800000080004103 R11: 0000000000000246 R12: 00000000006dbc5c
R13: 00007fb3d5c84d20 R14: 00007fb3d5c84d20 R15: 20c49ba5e353f7cf


Memory state around the buggy address:
 ffffc9000aa1f680: 00 00 00 00 00 77 00 00 00 77 07 00 77 00 70 07
 ffffc9000aa1f700: 00 77 07 00 00 77 00 00 00 77 00 00 00 77 07 00
>ffffc9000aa1f780: 00 77 00 00 77 00 00 00 77 00 77 00 70 07 00 00
                               ^
 ffffc9000aa1f800: 77 00 70 07 77 00 77 00 70 07 70 07 00 77 00 00
 ffffc9000aa1f880: 00 77 00 00 70 07 00 00 77 00 00 00 77 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches

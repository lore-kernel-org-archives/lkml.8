Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE857C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4EE206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgFEONR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:13:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:51409 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgFEONR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:13:17 -0400
Received: by mail-io1-f72.google.com with SMTP id c5so5786434iok.18
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rauaL61yD1b5TzBW2vli0M2yuBKLHU5KSUzfs5rkcSU=;
        b=PQpOtoclY8EdsfObIBt2EjIYxPwoG/IkAMS2f4Yxu+0SMBW2G18SsGudUsfejW7Ky9
         hk03AlrjVnOUOox2Bk2sCSz+KPPcNmNF9scso3P2yyeSlEsjfB32WqTYr+ufGYbPtPFj
         t+BvSXTLfz656RPjihBeJqcw+drEhWFPqla9f0/dLUL1XNV2JkhghdsXlGGUC/qucp60
         9Ug5LFXIbmrUNwFOsJtfw/P3KUrGgjXem9SbwnpvCwvjMRbqhdHMUqJ1K/IDQqMvIjrf
         X6G802ajQPfPeZd3U58TbNYfjpEcvFdgWa2xmVXIhD7pg10+u9a6qed7Ei8LDV9SAcfr
         4slQ==
X-Gm-Message-State: AOAM530fgY5ptkWyq67RqnOUT6saO1fgYRl7ZZsmBEcRUQgaych9TSlU
        83KxMOhLsHDM31TlW1Yf8bNzaV1MJ05MEqorijhTHT4A5FeE
X-Google-Smtp-Source: ABdhPJwSkPouCqieqp4ZCn3u8m242dOVPy70VunYtbo8fv6L+1FTqnL2Xpq50eAm+Ig92E3Jv0bp1PQ4QQp+gWB5D/a1+VdbDSAE
MIME-Version: 1.0
X-Received: by 2002:a6b:e714:: with SMTP id b20mr8736368ioh.195.1591366396000;
 Fri, 05 Jun 2020 07:13:16 -0700 (PDT)
Date:   Fri, 05 Jun 2020 07:13:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdc60705a756dcd2@google.com>
Subject: WARNING in snd_usbmidi_input_start/usb_submit_urb
From:   syzbot <syzbot+0f4ecfe6a2c322c81728@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1ee08de1 Merge tag 'for-5.8/io_uring-2020-06-01' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1132dfe2100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=764b977f857603f1
dashboard link: https://syzkaller.appspot.com/bug?extid=0f4ecfe6a2c322c81728
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12aa59ce100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1701eb91100000

The bug was bisected to:

commit f2c2e717642c66f7fe7e5dd69b2e8ff5849f4d10
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Mon Feb 24 16:13:03 2020 +0000

    usb: gadget: add raw-gadget interface

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171c33ee100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=149c33ee100000
console output: https://syzkaller.appspot.com/x/log.txt?x=109c33ee100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0f4ecfe6a2c322c81728@syzkaller.appspotmail.com
Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")

------------[ cut here ]------------
URB 00000000bfcadc71 submitted while active
WARNING: CPU: 0 PID: 8955 at drivers/usb/core/urb.c:363 usb_submit_urb+0xe3d/0x13e0 drivers/usb/core/urb.c:363
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8955 Comm: syz-executor958 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:105 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:197
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:216
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_submit_urb+0xe3d/0x13e0 drivers/usb/core/urb.c:363
Code: 00 04 00 00 eb 50 e8 82 20 3e fc eb 49 e8 7b 20 3e fc c6 05 c8 a5 32 04 01 48 c7 c7 30 02 fe 88 4c 89 ee 31 c0 e8 13 10 10 fc <0f> 0b e9 38 f2 ff ff e8 57 20 3e fc c7 04 24 80 00 00 00 eb 17 e8
RSP: 0018:ffffc90007c072e8 EFLAGS: 00010246
RAX: f3c090533e8e2b00 RBX: ffff88809ff85b08 RCX: ffff8880a84e6400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000cc0 R08: ffffffff815cbfb9 R09: ffffed1015d06660
R10: ffffed1015d06660 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88809ff85b00 R14: dffffc0000000000 R15: ffff8880924c0000
 snd_usbmidi_submit_urb sound/usb/midi.c:194 [inline]
 snd_usbmidi_input_start_ep sound/usb/midi.c:2313 [inline]
 snd_usbmidi_input_start+0x15f/0x7a0 sound/usb/midi.c:2329
 substream_open+0x22b/0x6e0 sound/usb/midi.c:1119
 open_substream+0x369/0x6a0 sound/core/rawmidi.c:299
 rawmidi_open_priv+0x99/0x900 sound/core/rawmidi.c:342
 snd_rawmidi_kernel_open+0x1db/0x270 sound/core/rawmidi.c:382
 midisynth_subscribe+0x93/0x280 sound/core/seq/seq_midi.c:170
 subscribe_port sound/core/seq/seq_ports.c:412 [inline]
 check_and_subscribe_port+0x62c/0xb10 sound/core/seq/seq_ports.c:495
 snd_seq_port_connect+0x20f/0x460 sound/core/seq/seq_ports.c:564
 snd_seq_ioctl_subscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1484
 snd_seq_oss_midi_open+0x4db/0x830 sound/core/seq/oss/seq_oss_midi.c:364
 snd_seq_oss_synth_setup_midi+0x108/0x510 sound/core/seq/oss/seq_oss_synth.c:269
 snd_seq_oss_open+0x899/0xe90 sound/core/seq/oss/seq_oss_init.c:261
 odev_open+0x5e/0x90 sound/core/seq/oss/seq_oss.c:125
 chrdev_open+0x498/0x580 fs/char_dev.c:414
 do_dentry_open+0x808/0x1020 fs/open.c:828
 do_open fs/namei.c:3229 [inline]
 path_openat+0x2790/0x38b0 fs/namei.c:3346
 do_filp_open+0x191/0x3a0 fs/namei.c:3373
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 __do_sys_openat fs/open.c:1209 [inline]
 __se_sys_openat fs/open.c:1204 [inline]
 __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x445719
Code: e8 8c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb cc fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff79d9b7c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000445719
RDX: 0000000000000000 RSI: 0000000020000280 RDI: ffffffffffffff9c
RBP: 000000000008b2e3 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402890
R13: 0000000000402920 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

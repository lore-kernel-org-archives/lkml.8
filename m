Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26B6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C73206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgFAD4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:56:16 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:38306 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFAD4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:56:15 -0400
Received: by mail-il1-f198.google.com with SMTP id c8so864681ilm.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 20:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2lVsqEau+OfjE24JbRCT3k2FzzgQCaY2jUo9KfMkRqc=;
        b=UQA7DvB6CUWQmnoVq7J5CBVqXSMuODYdrOtICIbjSSOHFKhLgkGsNrC8SGB+2YktDI
         AeIQj3RKPPcRQLIqiAWGtC3dvQx2Wh0vMkm+8+fPLlnc1eaX8J+EhM3GGJnEF6T9Jrjy
         CzY4Fox8JKmSPMHani72oiWZQt5095u3K7ePgRc9tpcSX6L2HxYdD8Qy+r2gbECg+eFN
         vGGOlZtva0CPs0ie8xck+GYWtzh26/OTPLOCckmuC8gNCWo19VFVzL+NF7mbgHBKubOh
         j0dLENn1sCMcm1nTR7WeuHZ1JeaTPdBzdMW8Rb4gEx6HJSBjRgx4KEnr+jwYgnHAtVXU
         sERQ==
X-Gm-Message-State: AOAM531PblyWCMrYfJDYIfeiitbLcWJEmJZcUcg7gIsk2o6QIQAafJHj
        Zzj1B66ZA1L7RsyNgeJGVzIPXcQOpEqbwnsIOHnWq/DWTn3m
X-Google-Smtp-Source: ABdhPJx7AKlcLyFaD1F3VWcDi4yr28z2sUl/7xATKlIccEUmlglIsDkCmfKqemlH/5EW7egV3t5uh+QVsnefYfkUph+sa4WDW0IE
MIME-Version: 1.0
X-Received: by 2002:a92:cf52:: with SMTP id c18mr7392210ilr.142.1590983774685;
 Sun, 31 May 2020 20:56:14 -0700 (PDT)
Date:   Sun, 31 May 2020 20:56:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbd09005a6fdc6cc@google.com>
Subject: WARNING in snd_usbmidi_submit_urb/usb_submit_urb
From:   syzbot <syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bdc48fa1 checkpatch/coding-style: deprecate 80-column warn..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d64586100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129ea1e5950835e5
dashboard link: https://syzkaller.appspot.com/bug?extid=5f1d24c49c1d2c427497
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d70cf2100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5f1d24c49c1d2c427497@syzkaller.appspotmail.com

RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00000000000007dc R14: 00000000004cab2a R15: 00007f5ab0e216d4
------------[ cut here ]------------
URB 00000000d6b1ff88 submitted while active
WARNING: CPU: 1 PID: 8661 at drivers/usb/core/urb.c:363 usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:363
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8661 Comm: syz-executor.0 Not tainted 5.7.0-rc7-syzkaller #0
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
RIP: 0010:usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:363
Code: 89 de e8 32 54 6a fc 84 db 0f 85 42 f6 ff ff e8 f5 52 6a fc 4c 89 fe 48 c7 c7 60 46 ab 88 c6 05 22 f3 7b 05 01 e8 b7 82 3b fc <0f> 0b e9 20 f6 ff ff c7 44 24 14 01 00 00 00 e9 d7 f6 ff ff 41 bd
RSP: 0018:ffffc9000a37f2c8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cf161 RDI: fffff5200146fe4b
RBP: dffffc0000000000 R08: ffff88808f2242c0 R09: ffffed1015ce66a9
R10: ffff8880ae733547 R11: ffffed1015ce66a8 R12: 0000000000000cc0
R13: 00000000fffffff0 R14: ffff8880a37b6400 R15: ffff8880894c1600
 snd_usbmidi_submit_urb+0x19/0x60 sound/usb/midi.c:194
 snd_usbmidi_input_start_ep sound/usb/midi.c:2313 [inline]
 snd_usbmidi_input_start.part.0+0xbe/0x1c0 sound/usb/midi.c:2329
 snd_usbmidi_input_start sound/usb/midi.c:1119 [inline]
 substream_open.isra.0+0x505/0x830 sound/usb/midi.c:1119
 open_substream+0x42e/0x880 sound/core/rawmidi.c:299
 rawmidi_open_priv+0x2e8/0x6e0 sound/core/rawmidi.c:342
 snd_rawmidi_kernel_open+0x1b5/0x270 sound/core/rawmidi.c:382
 midisynth_subscribe+0xf2/0x330 sound/core/seq/seq_midi.c:170
 subscribe_port sound/core/seq/seq_ports.c:412 [inline]
 check_and_subscribe_port+0x5b5/0x800 sound/core/seq/seq_ports.c:495
 snd_seq_port_connect+0x2e4/0x510 sound/core/seq/seq_ports.c:564
 snd_seq_ioctl_subscribe_port+0x1df/0x310 sound/core/seq/seq_clientmgr.c:1484
 snd_seq_kernel_client_ctl+0xeb/0x130 sound/core/seq/seq_clientmgr.c:2353
 snd_seq_oss_midi_open+0x3cb/0x640 sound/core/seq/oss/seq_oss_midi.c:364
 snd_seq_oss_synth_setup_midi+0x123/0x520 sound/core/seq/oss/seq_oss_synth.c:269
 snd_seq_oss_open+0x7fa/0x980 sound/core/seq/oss/seq_oss_init.c:261
 odev_open+0x6c/0x90 sound/core/seq/oss/seq_oss.c:125
 soundcore_open+0x446/0x600 sound/sound_core.c:593
 chrdev_open+0x219/0x5c0 fs/char_dev.c:414
 do_dentry_open+0x4ba/0x1290 fs/open.c:797
 do_open fs/namei.c:3229 [inline]
 path_openat+0x1e59/0x27d0 fs/namei.c:3346
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

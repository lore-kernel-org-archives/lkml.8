Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F37C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FF32072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgDGOfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:35:20 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:40196 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgDGOfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:35:20 -0400
Received: by mail-il1-f200.google.com with SMTP id g79so3352739ild.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DrOiOhIFnf1BvQ7pnLuWGhH2q/1ZIrRtofFqFtUp27M=;
        b=Vcb3ydY1+iRNbp7VdRWo1bOmDVq6YtvGLjf2UHPBs+z4K2AttY8FouPU8zgmBmxxot
         4fGN7AW/2xzEQ4sFWZBFYaLF3PHBG+uxilLos2keYjE5acQMyUwSspr3vp1LzYleqCQc
         wnTp+2Yk+UjLEoMB9zXQvW5iUuAdTyuLzOyv5wPSji09SfuQ8uaMqEixxSXOdD3lZwiZ
         YCN5C25EwQ5gGFYu+hNlGmPNUQ+eOQfaE5DA1KmYTbHbkM39d0RHAG1GO8ueMWvjeaXA
         UCU9Px3vX1cKLj4NxUgv4xFmRZ9wjLzXPn/j+Urn/g0so4pdrkUwCEIBhFD+su3g6tV5
         1C5w==
X-Gm-Message-State: AGi0PuaYsmr/Q+h1JpmsYEtBtCJAYNNEggQyI93CGLJ9Dd1XbUukD1ff
        ODA4/fLb5iIkIPMbVjSmMi3eC2WGE/2/hn8dFPEg13neAmip
X-Google-Smtp-Source: APiQypIPzmkdGfhwr1DKHuI4/FjJ/bMgn9Z346lrTLPvc30IISP1GbPLwjE+Qkth+YHj1ZooU6MxLDwq4gufEcCl16/+XanvKJii
MIME-Version: 1.0
X-Received: by 2002:a92:b0a:: with SMTP id b10mr2580712ilf.18.1586270119511;
 Tue, 07 Apr 2020 07:35:19 -0700 (PDT)
Date:   Tue, 07 Apr 2020 07:35:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdc98405a2b44a8c@google.com>
Subject: WARNING in add_taint/usb_submit_urb
From:   syzbot <syzbot+f44561cfce4cc0e75b89@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11cce12be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=f44561cfce4cc0e75b89
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a8312be00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e35d8fe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f44561cfce4cc0e75b89@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 384 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 384 Comm: systemd-udevd Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 usb_submit_urb+0x10b0/0x1460 drivers/usb/core/urb.c:363
 panic+0x2aa/0x6e1 kernel/panic.c:221
 add_taint.cold+0x16/0x16 kernel/panic.c:434
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 set_ti_thread_flag include/linux/thread_info.h:55 [inline]
 set_fs arch/x86/include/asm/uaccess.h:33 [inline]
 __probe_kernel_read+0x188/0x1d0 mm/maccess.c:67
 __warn.cold+0x14/0x30 kernel/panic.c:581
 __warn+0xd5/0x1c8 kernel/panic.c:574
 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
 __warn.cold+0x2f/0x30 kernel/panic.c:582
 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Code: 4d 85 e


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

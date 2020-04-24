Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38854C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1694D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgDXCKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:10:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:34415 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgDXCKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:10:07 -0400
Received: by mail-io1-f69.google.com with SMTP id v12so8591591iol.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/Fhh7LGHtZ8ySY6CxiNl1ZczNiIJ80m1bW6bNjasur0=;
        b=ujD0/VsnNgSeNNb5CYyrNr034qrFKdNdED2zCZlhjTpAlpne+JJP/FEGL8k/1FwEQr
         v5DcXrsFVZHNRMyMyCONk/sLQ2FjeLj+5kn0+/HzPIq+MMSAsPoq5vtI3Fp2osOMNVp4
         P4S5sxPiPUB6JffVxTF4hTs1QNTN0eAsSzojLjDcxS0o4M5oW26D/0yN0VZrDKtFCTG1
         CGJAmRygDvlM1XwPg7m84/JLQSi4nZNWZZPBmiI19YMp62+WmV1G4rS4rGCMf3ihbWJa
         q+wyOne6uUskQii/IwS8gnMCDc/4f83Qgb9YgMuvb+CmGDRRulJlrGR9fes1Xl6hZzRi
         Vhdg==
X-Gm-Message-State: AGi0PuaD3rukwyR+cRzyP2nRgnxURgf2g8Fd0K7p0HuG0+3T5lnNCrIF
        29CwzY0CETbduSmlrUixM34s+dtxZHydUpS7pzht2+XAdw81
X-Google-Smtp-Source: APiQypIaglRgjHeVPw1rS8+Pi/Vd8U1xr5pKZ0owqp7Vszi0bF51J4Wg1RyKWdBJlyOKt4cUpDcgt9OerUZzIJqJNI17iS3/TsvW
MIME-Version: 1.0
X-Received: by 2002:a92:498e:: with SMTP id k14mr5729919ilg.160.1587694206331;
 Thu, 23 Apr 2020 19:10:06 -0700 (PDT)
Date:   Thu, 23 Apr 2020 19:10:06 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004232138280.2101-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e31b205a3ffddb6@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered crash:
WARNING in usb_reset_and_verify_device

------------[ cut here ]------------
usb 1-1: Device reset
WARNING: CPU: 0 PID: 94 at drivers/usb/core/hub.c:5761 usb_reset_and_verify_device+0x37d/0xce0 drivers/usb/core/hub.c:5761
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 94 Comm: kworker/0:2 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events __usb_queue_reset_device
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 panic+0x2aa/0x6e1 kernel/panic.c:221
 __warn.cold+0x2f/0x30 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_reset_and_verify_device+0x37d/0xce0 drivers/usb/core/hub.c:5761
Code: 0f 84 9e 06 00 00 e8 82 89 df fd 49 8d bc 24 a8 00 00 00 e8 85 59 19 ff 4c 89 ea 48 c7 c7 e0 86 3b 86 48 89 c6 e8 2b 1a b4 fd <0f> 0b 4d 89 e5 4c 89 34 24 44 8b 74 24 3c 48 b8 00 00 00 00 00 fc
RSP: 0018:ffff8881d5d7fb98 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881d4d70000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed103abaff65
RBP: 0000000000000000 R08: ffff8881d6b01880 R09: ffffed103b646248
R10: ffffed103b646247 R11: ffff8881db23123f R12: ffff8881d8f1e000
R13: ffff8881c9381900 R14: ffff8881d4ce5000 R15: ffff8881d8f1e560
 usb_reset_device+0x4bb/0x960 drivers/usb/core/hub.c:5946
 __usb_queue_reset_device+0x68/0x90 drivers/usb/core/message.c:1754
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10d0c580100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ab96a0100000


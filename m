Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE80C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C815620737
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbgDAUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 16:49:14 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:52937 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgDAUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 16:49:14 -0400
Received: by mail-il1-f198.google.com with SMTP id a79so1001002ill.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 13:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7r8NswXjfuvcELdpBOP7oGX9yhtb0XG9BXF3BWoBi0M=;
        b=XklHTt2/VaVvmefDgKCbFeAZBgWamDNmSo65dsvTU1nDd0fyusjocKFZX8PWrWwdun
         YXDRaAP/zQ/ZZ+XRIgXFXw4393KQE7Ex3zb8Lwdv+WSap2HXMXAppLB3QN96WcS3Cb2I
         A2ajXjB91CgceQriJe1cYpvwqZHf1Uje20DDTfZdijfg3fV68AstMwFciQ6cIcROzb8L
         wOHr4Z06uo/8XhTUp9fLlLewt0ZHmiX73Dv+u0B/ZF1b94KU/fLViYHhbSC5X3qZlJyF
         k6FpfAYOYisnriORJ+NTy3AtBy14lpCLetK6rM7wLeMJ2XaOl5LhQD+rmaNicE/rFVyz
         CQcg==
X-Gm-Message-State: ANhLgQ3us1qVRqDDGmjddM5heJeTnlWW2EU4WSbkijDETjr+glfB939X
        /iP1/MF1TxnMrlMwYJPonoYphZ4zull+oqlld9gD8StpbSTa
X-Google-Smtp-Source: ADFU+vsGakw7Wlyq1R1VqY4rcxwzROqZR/Bl+7JsntKoj9AcqQjqAhBDG+LWvcoQl2t0alXPpNPDf66ifEF5hGW+P2eVx+bZlShf
MIME-Version: 1.0
X-Received: by 2002:a92:3b86:: with SMTP id n6mr23290195ilh.270.1585774153198;
 Wed, 01 Apr 2020 13:49:13 -0700 (PDT)
Date:   Wed, 01 Apr 2020 13:49:13 -0700
In-Reply-To: <00000000000046b2bf059c193afb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001873a005a240d114@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12aa8567e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1342740be00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 9241 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9241 Comm: syz-executor.1 Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
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
RIP: 0010:usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Code: 4d 85 ed 74 46 e8 68 87 dd fd 4c 89 f7 e8 90 57 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 80 dd 3b 86 e8 10 18 b2 fd <0f> 0b e9 20 f4 ff ff e8 3c 87 dd fd 0f 1f 44 00 00 e8 32 87 dd fd
RSP: 0018:ffff8881c7a47b38 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed1038f48f59
RBP: 0000000000000000 R08: ffff8881cd811880 R09: ffffed103b646248
R10: ffffed103b646247 R11: ffff8881db23123f R12: 0000000000000002
R13: ffff8881c5c764b0 R14: ffff8881c8daf0a0 R15: ffff8881d0117500
 usb_start_wait_urb+0x108/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:917 [inline]
 usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1265
 hid_hw_raw_request include/linux/hid.h:1079 [inline]
 hidraw_send_report+0x296/0x500 drivers/hid/hidraw.c:151
 hidraw_ioctl+0x620/0xaf0 drivers/hid/hidraw.c:422
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fa05ffffc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa0600006d4 RCX: 000000000045c849
RDX: 00000000200000c0 RSI: 0000000080404806 RDI: 0000000000000006
RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000335 R14: 00000000004c59df R15: 000000000076bfac
Kernel Offset: disabled
Rebooting in 86400 seconds..


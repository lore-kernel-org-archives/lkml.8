Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C9C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D63520757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgD2X7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:59:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55638 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2X7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:59:04 -0400
Received: by mail-io1-f70.google.com with SMTP id f4so4312347iov.22
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OUAG2mPRUJM+niwwLbggxgqIVOi7F8bBFM/poZWNpOs=;
        b=GKrGGwCfUClSSf0OQT4UzhH4IW3s6P8O/vJ4G51s0I/I4p+IEl8wXrtfQYODIDC48T
         tnasDsagsJv/xYB7WsNJcbuGqomwsYknNANblkYiVzi+9/FWln6zJJlbjs2CUavpdyFi
         H8zO4vaid1ktqLBKCXiyWfBXxLqtGpHGA8FToUgTtshfJQ2lPeQIeUqarybqS92iF1fj
         sgolY7EP0fwDqQ12qkWFVfFeDdatDBGMp1NfNfoRMWtOekHnX0An9Q+NxjAfG4NtJQ4P
         x/P5QQo5io5U+kf4MEmm9cjAfIY3wkuh6ErZRXcoe6Ljmpo2AEmsj76ltOPkTHHY5Xtq
         49uw==
X-Gm-Message-State: AGi0PuamkgYtfKaGVNVl2LYGzDX+m0gT0r4TqRU/oOEcM1H+K/kOUKIG
        iTa8n7OLdKznc4gAcjK+2VRfaTh0xbtrTUiBtmEXBNMfiL7b
X-Google-Smtp-Source: APiQypLlibrdymG74LfbzGsCGjEK1DBDXRP7SxYzWhxnMo0Vf6RVzy5TwgsZDzolgE0SbqoEvWdU0y1io/YybMzt7+Ga2fkqX8UM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f0f:: with SMTP id h15mr589036jas.142.1588204743586;
 Wed, 29 Apr 2020 16:59:03 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:59:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004291940080.7441-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000927dcc05a476bb41@google.com>
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
WARNING in usbhid_raw_request/usb_submit_urb

------------[ cut here ]------------
usb 3-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 1 PID: 5096 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 5096 Comm: syz-executor.2 Not tainted 5.6.0-rc7-syzkaller #0
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
RSP: 0018:ffff8881c83c7b38 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812974dd RDI: ffffed1039078f59
RBP: 0000000000000000 R08: ffff8881d5bbe200 R09: ffffed103b666248
R10: ffffed103b666247 R11: ffff8881db33123f R12: 0000000000000002
R13: ffff8881d8dc2480 R14: ffff8881c5ad80a0 R15: ffff8881d9a7ab00
 usb_start_wait_urb+0x108/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usbhid_set_raw_report drivers/hid/usbhid/hid-core.c:924 [inline]
 usbhid_raw_request+0x21f/0x640 drivers/hid/usbhid/hid-core.c:1272
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
RSP: 002b:00007ff1fff1bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff1fff1c6d4 RCX: 000000000045c849
RDX: 00000000200000c0 RSI: 0000000080404806 RDI: 0000000000000006
RBP: 000000000076bfa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000335 R14: 00000000004c59df R15: 000000000076bfac
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14d839dfe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13204440100000


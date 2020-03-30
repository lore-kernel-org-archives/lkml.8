Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80776C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE6E20716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgC3LVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:21:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:38571 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgC3LVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:21:18 -0400
Received: by mail-il1-f197.google.com with SMTP id b6so16292517iln.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 04:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CfhY61UHck7fYWqN/w7cPNYWAhLfN0P+iiBF3Bac0A4=;
        b=BmGVzQ/ymsbHLzObN2NeRFxiz6WGXsfvddcKHVAoi3ncolL6aeQXaHPIK8mE9YJ2ne
         VF9ZZf2I+oO+eBr5FnNEg49+DcfmL8qiKMIz/brxll+J4Cd4y4m/XF1+DOpqASPm2FxL
         pEJYocs7ju+6HuALyP/XXy1mee8V/KQHmdbF1Xo1aJg7gGljRK7iEEZXsrTG9MH7Hgpn
         hXMMM+O+XlYgLB5xouL9i2E9QHFW8vjZIUCVWpb6BU9oiOCh/EJSPYSGefqksx4VRxwF
         TByeQwLJKeLLSKB+ReMiDTuN4hiWV6rYVEmSlSi/a2WVbo3tcynPq0ykPndKN+Zq3XVq
         3GEw==
X-Gm-Message-State: ANhLgQ2DRn0Ka7BvEopECe6hIQxEgL0Wktb2qv9zO0miPomiNwqeqHgX
        h+7NC/CwhAkc5cgmx8PNvTEUEgCEMpSUojqXDxUOPNQuRVNK
X-Google-Smtp-Source: ADFU+vv8hUPAS9X3Qeiu/V92gCt8ONi6tKKXbuGKZwoRJ7Oah2fNPut7Mpn5Ql13uabznKPel6sINHuC/z3y6ucqzlvCE5uW5sDx
MIME-Version: 1.0
X-Received: by 2002:a92:9606:: with SMTP id g6mr10456050ilh.119.1585567277051;
 Mon, 30 Mar 2020 04:21:17 -0700 (PDT)
Date:   Mon, 30 Mar 2020 04:21:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050fd3505a210a664@google.com>
Subject: WARNING in hiddev_ioctl/usb_submit_urb (2)
From:   syzbot <syzbot+7c2b64c9bf83fea586fb@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1756de4de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a782c087b1f425c6
dashboard link: https://syzkaller.appspot.com/bug?extid=7c2b64c9bf83fea586fb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7c2b64c9bf83fea586fb@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 2 != type 2
WARNING: CPU: 0 PID: 3143 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 3143 Comm: syz-executor.0 Not tainted 5.6.0-rc7-syzkaller #0
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
Code: 4d 85 ed 74 46 e8 28 87 dd fd 4c 89 f7 e8 90 57 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 80 ed 3b 86 e8 d0 17 b2 fd <0f> 0b e9 20 f4 ff ff e8 fc 86 dd fd 0f 1f 44 00 00 e8 f2 86 dd fd
RSP: 0018:ffff8881d564fa08 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: 0000000000007382 RSI: ffffffff812974dd RDI: ffffed103aac9f33
RBP: 0000000000000000 R08: ffff8881d9831880 R09: ffffed103b646248
R10: ffffed103b646247 R11: ffff8881db23123f R12: 0000000000000002
R13: ffff8881c8636bd0 R14: ffff8881d20440a0 R15: ffff8881d53b3d00
 usb_start_wait_urb+0x108/0x4c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usb_get_string+0xac/0x1a0 drivers/usb/core/message.c:694
 usb_string_sub+0xfa/0x3d0 drivers/usb/core/message.c:733
 usb_get_langid drivers/usb/core/message.c:770 [inline]
 usb_string+0x1ce/0x540 drivers/usb/core/message.c:833
 hiddev_ioctl_string.isra.0+0xf5/0x1f0 drivers/hid/usbhid/hiddev.c:575
 hiddev_ioctl+0x5b8/0x1550 drivers/hid/usbhid/hiddev.c:681
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xb6/0x5a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9807022c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f98070236d4 RCX: 000000000045c849
RDX: 0000000020000080 RSI: 0000000081044804 RDI: 0000000000000004
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000033e R14: 00000000004c5a98 R15: 000000000076bf0c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

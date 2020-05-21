Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6795420748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgEUBMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:12:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43331 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgEUBMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:12:18 -0400
Received: by mail-il1-f200.google.com with SMTP id v14so4290066ilm.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=h/j6wGDGkA5f0OpUNBT2fc6Kw0541ZjHnj629UyszkE=;
        b=DP0q5ZHo+8P3p5KBS7NnWLEfUAa+F3/qWiAsuWWA0RZQBW66Hh2e18MTazahsDU7Bz
         Wd60/Jso6CSCOd3xw+BXlRio3LK0tPalFeFdbYf+1ARG32ESV53OeQOVA5nzO/zzF8+b
         jdGBLpJHKqaYDyyA1CvD1tHHU8RxJZrbT8MLhZ4zKBX+oetlUk12P1pzZJY4/zYOtxEE
         Qq6ChgnDLCkwL/Kqwyl2V6Tu2/qIepyNeHuyjtnbOfBGHkQ/2faAUmOkdqT4PUIj1BmT
         tayJaZg+Y3WcOixqq5yCzpFjervuqzcUrr5Yw5cP9BA2zfi4uEIRuXNrtpARH26aRg39
         SMcw==
X-Gm-Message-State: AOAM532KeDcNo4cuyZuZpyAwxwk7q4To+DNu/eEXJZFW+dcoj2eI/7jE
        WwWr9oaoGyjgz15ADN6PatQBT6GJrhIb+3UEJH5HHiU6Atim
X-Google-Smtp-Source: ABdhPJyOjchKzarFV0Phiwdbzhuhy+0JRjUwdIIfTpsgXO57OEYaks2BV8xLQH3h769qm6iu1ciqsnmPU5pz+Za9ON750NhH3F3z
MIME-Version: 1.0
X-Received: by 2002:a92:2ca:: with SMTP id 193mr6088947ilc.35.1590023537140;
 Wed, 20 May 2020 18:12:17 -0700 (PDT)
Date:   Wed, 20 May 2020 18:12:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001daa8d05a61e3440@google.com>
Subject: memory leak in do_eventfd
From:   syzbot <syzbot+f196caa45793d6374707@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5a9ffb95 Merge tag '5.7-rc5-smb3-fixes' of git://git.samba..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b72a02100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8295ae5b3f8268d
dashboard link: https://syzkaller.appspot.com/bug?extid=f196caa45793d6374707
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17585b76100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12500a02100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f196caa45793d6374707@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888117169ac0 (size 64):
  comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
  hex dump (first 32 bytes):
    01 00 00 00 ff ff ff ff 00 00 00 00 00 c9 ff ff  ................
    d0 9a 16 17 81 88 ff ff d0 9a 16 17 81 88 ff ff  ................
  backtrace:
    [<00000000351bb234>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000351bb234>] do_eventfd+0x35/0xf0 fs/eventfd.c:418
    [<00000000c2f69a77>] __do_sys_eventfd fs/eventfd.c:443 [inline]
    [<00000000c2f69a77>] __se_sys_eventfd fs/eventfd.c:441 [inline]
    [<00000000c2f69a77>] __x64_sys_eventfd+0x14/0x20 fs/eventfd.c:441
    [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888117169100 (size 64):
  comm "syz-executor012", pid 6609, jiffies 4294942172 (age 13.720s)
  hex dump (first 32 bytes):
    e8 99 dd 00 00 c9 ff ff e8 99 dd 00 00 c9 ff ff  ................
    00 00 00 20 00 00 00 00 00 00 00 00 00 00 00 00  ... ............
  backtrace:
    [<00000000436d2955>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000436d2955>] kzalloc include/linux/slab.h:669 [inline]
    [<00000000436d2955>] kvm_assign_ioeventfd_idx+0x4f/0x270 arch/x86/kvm/../../../virt/kvm/eventfd.c:798
    [<00000000e89390cc>] kvm_assign_ioeventfd arch/x86/kvm/../../../virt/kvm/eventfd.c:934 [inline]
    [<00000000e89390cc>] kvm_ioeventfd+0xbb/0x194 arch/x86/kvm/../../../virt/kvm/eventfd.c:961
    [<00000000ba9f6732>] kvm_vm_ioctl+0x1e6/0x1030 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3670
    [<000000005da94937>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<000000005da94937>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:771
    [<00000000a583d097>] __do_sys_ioctl fs/ioctl.c:780 [inline]
    [<00000000a583d097>] __se_sys_ioctl fs/ioctl.c:778 [inline]
    [<00000000a583d097>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:778
    [<0000000086d6f989>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<000000006c5bcb63>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

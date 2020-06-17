Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738BAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1082168B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQLYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:24:18 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40273 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQLYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:24:15 -0400
Received: by mail-il1-f198.google.com with SMTP id s4so1274053ilc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 04:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9VMHnIpjIIoaGQ215cnFAeiATHBF0bn8x+y3MmR8AgQ=;
        b=cgFA9roySX209jz6BcwIK6kIVevqovNMDxkYmcfqN7K8ZLkneutIwLdEfpiZtBxa9u
         1D6F+byQ5oTAMJCwxDeDKc38rze2Y0jM+Vep1K+Wg9HFth7yO26x12ChDmUMLCkZHlIO
         0ZbkpR8IExHKhjwPAVcgIev0hpdOjgta3f6Lxa0T/6qGVosj/0+/Fb9FRZix59VpcVET
         obcMoCyRoBlENPWXDbm5Vh4AdzsrsloyY9vcSK7C4TmPEMZJq66hPMsJuc/KdGLQWEmR
         cGndIOvGFd5fxkjVexjQHp+mNQ7MFVHZZIuQu6J5EF1St/0pVdJV4DyIfhVEa8ZdxN//
         /XuQ==
X-Gm-Message-State: AOAM531V+ijpYQpQZGhs6fnHUivwFYuWAYs5sHnGaRrLQm2x16btJkUF
        YwEfqr7ZLKAPcwCDtJj83Ay73+UCZtF7wNJsGplclHmtAhsZ
X-Google-Smtp-Source: ABdhPJz+MKzCz57Sskv3R4M7HkZVgsQXcDzJSbuIE2ID1x4nS22bOI4xWyIeeKHQACnWTf4GEd01RV7L8EZRL/Fg5EPei9GeEXff
MIME-Version: 1.0
X-Received: by 2002:a02:6305:: with SMTP id j5mr29038718jac.140.1592393053856;
 Wed, 17 Jun 2020 04:24:13 -0700 (PDT)
Date:   Wed, 17 Jun 2020 04:24:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005166b905a845e639@google.com>
Subject: WARNING in corrupted/usb_submit_urb
From:   syzbot <syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com>
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

HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=140052c3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
dashboard link: https://syzkaller.appspot.com/bug?extid=120d387f677320f6a57c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16195fd9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1610f2c3e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+120d387f677320f6a57c@syzkaller.appspotmail.com

ati_remote 1-1:0.0: Unknown Medion X10 receiver, using default ati_remote Medion keymap
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 81 at drivers/usb/core/urb.c:478 usb_submit_urb+0x1188/0x1460 drivers/usb/core/urb.c:478
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 81 Comm: kworker/1:1 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
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
Code: 4d 85 ed 74 46 e8 18 ce dd fd 4c 89 f7 e8 d0 5c 17 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 e0 e7 3b 86 e8 a0 5f b2 fd <0f> 0b e9 20 f4 ff ff e8 ec cd dd fd 0f 1f 44 00 00 e8 e2 cd dd fd
RSP: 0018:ffff8881d8a0f0b8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

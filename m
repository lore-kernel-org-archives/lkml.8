Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B0C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 06:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBCF21D91
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 06:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDRGoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 02:44:21 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47217 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgDRGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 02:44:16 -0400
Received: by mail-il1-f197.google.com with SMTP id a15so4719837ild.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pXmS78UP3PIHf/SRcQHxFXu6pvUOOha8DWE8p79NAfc=;
        b=ViZkYPrWhjgqxQGFJv2A5J/YqqMvuTl9/tY6BG21Uo6BaTEpRCv3MxVDD+XjzcfJ+i
         SJeA9DjSvy7KUxVSR7y6oEPVayFYob7oQr19KecKm9wpIQTpE2yNBLwHfCYonn4ye/TR
         ZIi+hlr/K8e7BwgcDDRFTZJHFCx56EMiONAinglw3Ww9fUNkKzH4GmND4CA83VvVaunO
         C5ER0dnDCMaSpW/G+jqHG2IWjb9uGr6KmqXImj4KiBrp5ZSVrSLD6n6/VCA42Z0mhiGX
         lNX3AGQMOUV/PI5EqsWKcz/n3uRYLIxt0IqWRZFix1bPD98kSU2CSjVtkM8LhLmEKMNW
         eqWw==
X-Gm-Message-State: AGi0PuY3ftEtaAeQLgXdWTUBB0+yCGg6STMSlWDE8O8VziWKkHSChyZE
        koCVpFL6gCOnKjGwgIuooZEv9s2r+CE17YNBYOflBNuG4eKu
X-Google-Smtp-Source: APiQypLwcu3iOTuryi0ondhPJrW7F+zsa1E+M/lJpkpwzLcRN3No1r+6BnQvVrMCLeiRcr/Lbm77C2pukHrig8tX9tmVPQhe2ipS
MIME-Version: 1.0
X-Received: by 2002:a92:39dd:: with SMTP id h90mr6713306ilf.80.1587192254928;
 Fri, 17 Apr 2020 23:44:14 -0700 (PDT)
Date:   Fri, 17 Apr 2020 23:44:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b9e0705a38afe52@google.com>
Subject: WARNING: refcount bug in do_enable_set
From:   syzbot <syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8f3d9f35 Linux 5.7-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1182b24fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11f10cc27c63cade
dashboard link: https://syzkaller.appspot.com/bug?extid=2e9900a1e1b3c9c96a77
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e9900a1e1b3c9c96a77@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 10817 at lib/refcount.c:28 refcount_warn_saturate+0x15b/0x1a0 lib/refcount.c:28
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 10817 Comm: kworker/0:7 Not tainted 5.7.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events do_enable_set
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:221
 __warn+0x209/0x210 kernel/panic.c:582
 report_bug+0x1ac/0x2d0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 do_error_trap+0xca/0x1c0 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:refcount_warn_saturate+0x15b/0x1a0 lib/refcount.c:28
Code: c7 9a a9 f2 88 31 c0 e8 a3 fb ac fd 0f 0b eb 85 e8 5a e7 da fd c6 05 10 48 cf 05 01 48 c7 c7 c6 a9 f2 88 31 c0 e8 85 fb ac fd <0f> 0b e9 64 ff ff ff e8 39 e7 da fd c6 05 f0 47 cf 05 01 48 c7 c7
RSP: 0000:ffffc900016d7c48 EFLAGS: 00010246
RAX: 8e9964d9ee901300 RBX: 0000000000000003 RCX: ffff888089a0e5c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff815cbca9 R09: ffffed1015d06660
R10: ffffed1015d06660 R11: 0000000000000000 R12: ffffffff895f43c8
R13: dffffc0000000000 R14: ffff88809365b018 R15: ffff8880ae83b400
 do_enable_set+0x63a/0x8d0 net/bluetooth/6lowpan.c:1075
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

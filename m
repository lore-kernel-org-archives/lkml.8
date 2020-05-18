Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0CFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A64207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 01:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgERBWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 21:22:22 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:41310 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgERBWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 21:22:14 -0400
Received: by mail-il1-f200.google.com with SMTP id f65so8389056ilh.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 18:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ap8i6E0yrJQAtmU9MgshgOvQ1VBY3o/WHGCOKeuX4nc=;
        b=E477BTiBmgC6fWyaB05QYJVHQTZP+9/l7P+e6nuCLnJbiCMTVEpsq96i3YnVAIJBQC
         HgL1OTICsLPTSbiWTamAXvzIjbhA0/a7joqDMZB8ddhe7hdkDxwpPV/xqh8Pt/x4JuvN
         z/UVhtNeYGkE4yMwMmlqClpzXsBcM2HEb+5S9e9txYR5KjQ5kjeLGiJctFj9UXfmzzjE
         M4kQFFFpyARWlAirrLXLCYtVq47HvxPb5kx4BTgu7PwobcabTOsMNIYC3q+qEQf3aSAh
         Glba0q4m9qr0WoqagyG/5ofeBl3QEr7UCcE9PC/bro0HTtds+iUF0Y7Ey4TqrvkupsPM
         ZwYQ==
X-Gm-Message-State: AOAM532uVN8b6PFXEMl00Z6sstyU055C/Cky1zquHMaMH70/n64ZkHXl
        /zIIaPYwrh+KWRb99iYm/iJZWtwE4h4ijsDYEsojqZPvto8z
X-Google-Smtp-Source: ABdhPJx3Rtos3rtwRka74QnG8oJkX6dZbfUmTZP+c6Q9rnRW8WUn6+HOHNDULTl1z0EQ9gaNdX3Rj6KcgInTcoBOQ8s9c7QPUizi
MIME-Version: 1.0
X-Received: by 2002:a92:1d49:: with SMTP id d70mr13345443ild.188.1589764933763;
 Sun, 17 May 2020 18:22:13 -0700 (PDT)
Date:   Sun, 17 May 2020 18:22:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002746f005a5e1fe6b@google.com>
Subject: BUG: sleeping function called from invalid context in console_lock
From:   syzbot <syzbot+f8589c355cdce42b2446@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    3d1c1e59 Merge tag 'block-5.7-2020-05-16' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8d202100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c14212794ed9ad24
dashboard link: https://syzkaller.appspot.com/bug?extid=f8589c355cdce42b2446
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f8589c355cdce42b2446@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2312
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 21174, name: syz-executor.5
3 locks held by syz-executor.5/21174:
 #0: ffff8880a965c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffff8880a965c3f8 (&tty->flow_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:378 [inline]
 #1: ffff8880a965c3f8 (&tty->flow_lock){....}-{2:2}, at: n_tty_ioctl_helper drivers/tty/tty_ioctl.c:914 [inline]
 #1: ffff8880a965c3f8 (&tty->flow_lock){....}-{2:2}, at: n_tty_ioctl_helper+0xcc/0x3b0 drivers/tty/tty_ioctl.c:894
 #2: ffff8880a965c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:288
irq event stamp: 46
hardirqs last  enabled at (45): [<ffffffff81b0ba8b>] kfree+0x1eb/0x2b0 mm/slab.c:3758
hardirqs last disabled at (46): [<ffffffff87d08f35>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:126 [inline]
hardirqs last disabled at (46): [<ffffffff87d08f35>] _raw_spin_lock_irq+0x35/0x80 kernel/locking/spinlock.c:167
softirqs last  enabled at (0): [<ffffffff8143deb7>] copy_process+0x1ae7/0x7110 kernel/fork.c:2031
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 21174 Comm: syz-executor.5 Not tainted 5.7.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 ___might_sleep.cold+0x1f4/0x23d kernel/sched/core.c:6801
 console_lock+0x19/0x80 kernel/printk/printk.c:2312
 do_con_write.part.0+0x95/0x1dc0 drivers/tty/vt/vt.c:2596
 do_con_write drivers/tty/vt/vt.c:2593 [inline]
 con_write+0x41/0xe0 drivers/tty/vt/vt.c:3159
 n_hdlc_send_frames+0x22d/0x3d0 drivers/tty/n_hdlc.c:289
 tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:536
 __start_tty+0x5c/0x70 drivers/tty/tty_io.c:803
 n_tty_ioctl_helper drivers/tty/tty_ioctl.c:917 [inline]
 n_tty_ioctl_helper+0x34e/0x3b0 drivers/tty/tty_ioctl.c:894
 n_hdlc_tty_ioctl+0xd3/0x2f0 drivers/tty/n_hdlc.c:615
 tty_ioctl+0xf88/0x1440 drivers/tty/tty_io.c:2665
 tty_compat_ioctl+0x2bf/0x410 drivers/tty/tty_io.c:2834
 __do_compat_sys_ioctl fs/ioctl.c:865 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:816 [inline]
 __ia32_compat_sys_ioctl+0x23d/0x2b0 fs/ioctl.c:816
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

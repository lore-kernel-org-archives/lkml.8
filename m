Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0483C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68AF20748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgAPF7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:59:10 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:36532 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgAPF7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:59:09 -0500
Received: by mail-il1-f198.google.com with SMTP id t2so15369462ilp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:59:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mvdn3qJwQ8zIspPo4yhX0MPJHSydaEstgFomVGSlOE0=;
        b=b99hVed3V8cfJ+RcQlE3zU3QOnF6+kgPGqO8f5nzlBo23Rb1Cv7ds6FiybBvxj9Do8
         pfXg2TTSxPP6hpjPbLtsUhG7g2ptUfoiS4bPVnOU2Jm+hHGYeiPxKhbwTvDspo9oHyc1
         YRkEZ/n4eSaUBtHKBFFXG9y4g1z9UH8AYFyZAwbyZKaIe6HOH7HrysKtA5rQ1cjDBKF2
         LQlU0161J3/kWf2PlgmGAUcAroYMNBYHiD3NCh2WpTLR0k111PZH62pPyAS2BroFlqC2
         fV8dAoZgW59cG6hZ/gMnZ58BkKH7W3d4d7pUYlfiqIRSzKEleWrih35BLc0LSn578Ycc
         AG2g==
X-Gm-Message-State: APjAAAUtrR2pUFYrC/whMOxtlFPgDDRXLjWMzAg9VcqLZ20XMWHC7jY0
        xuudJCNm1Ugusi8L/+D+MGh+iaoOrpN5zSYWTyRw7JXmCS17
X-Google-Smtp-Source: APXvYqxwQG6FA5969kzguYeLe/O6wnjEzqb+toFTmCJY+RvcGrC9EAKlPaHJTbm4gkIEjpPuN7V4Xc8wcb72xSXiWkpM4rzyh4jc
MIME-Version: 1.0
X-Received: by 2002:a92:cd02:: with SMTP id z2mr2177423iln.286.1579154349083;
 Wed, 15 Jan 2020 21:59:09 -0800 (PST)
Date:   Wed, 15 Jan 2020 21:59:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005d2bf059c3b86ac@google.com>
Subject: BUG: unable to handle kernel paging request in do_con_write
From:   syzbot <syzbot+d8cbeb7028cd2950172e@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    51d69817 Merge tag 'platform-drivers-x86-v5.5-3' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a41c76e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=d8cbeb7028cd2950172e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/  
c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d8cbeb7028cd2950172e@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffff0000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9070067 P4D 9070067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 25087 Comm: syz-executor.4 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:delete_char drivers/tty/vt/vt.c:853 [inline]
RIP: 0010:csi_P drivers/tty/vt/vt.c:1985 [inline]
RIP: 0010:do_con_trol drivers/tty/vt/vt.c:2379 [inline]
RIP: 0010:do_con_write+0x9565/0xf360 drivers/tty/vt/vt.c:2797
Code: 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 60 4b 00 00 48 8b 84 24 a0  
00 00 00 0f b7 00 41 81 e4 ff ff ff 7f 4c 89 e1 48 89 df <f3> 66 ab 48 b8  
00 00 00 00 00 fc ff df 48 8b 4c 24 50 8a 04 01 84
RSP: 0018:ffffc900019e7880 EFLAGS: 00010202
RAX: 0000000000000720 RBX: ffffffff0000000e RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000100000010 RDI: ffffffff0000000e
RBP: ffffc900019e7b68 R08: ffffffff83fa0511 R09: ffffffff83f9de70
R10: ffff8880a14b0180 R11: 000000000000001c R12: 0000000000000001
R13: 0000000000000000 R14: 0000000100000010 R15: 0000000000000002
FS:  00007f9510ce8700(0000) GS:ffff8880aed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff0000000e CR3: 000000009570c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  con_write+0x25/0x40 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0xd0c/0x1200 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x5a1/0x950 drivers/tty/tty_io.c:1046
  __vfs_write+0xb8/0x740 fs/read_write.c:494
  vfs_write+0x270/0x580 fs/read_write.c:558
  ksys_write+0x117/0x220 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x7b/0x90 fs/read_write.c:620
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45aff9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f9510ce7c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9510ce86d4 RCX: 000000000045aff9
RDX: 0000000000000320 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c60 R14: 00000000004cd0b9 R15: 000000000075bf2c
Modules linked in:
CR2: ffffffff0000000e
---[ end trace 0cf51c4bf0974ba5 ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:delete_char drivers/tty/vt/vt.c:853 [inline]
RIP: 0010:csi_P drivers/tty/vt/vt.c:1985 [inline]
RIP: 0010:do_con_trol drivers/tty/vt/vt.c:2379 [inline]
RIP: 0010:do_con_write+0x9565/0xf360 drivers/tty/vt/vt.c:2797
Code: 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 60 4b 00 00 48 8b 84 24 a0  
00 00 00 0f b7 00 41 81 e4 ff ff ff 7f 4c 89 e1 48 89 df <f3> 66 ab 48 b8  
00 00 00 00 00 fc ff df 48 8b 4c 24 50 8a 04 01 84
RSP: 0018:ffffc900019e7880 EFLAGS: 00010202
RAX: 0000000000000720 RBX: ffffffff0000000e RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000100000010 RDI: ffffffff0000000e
RBP: ffffc900019e7b68 R08: ffffffff83fa0511 R09: ffffffff83f9de70
R10: ffff8880a14b0180 R11: 000000000000001c R12: 0000000000000001
R13: 0000000000000000 R14: 0000000100000010 R15: 0000000000000002
FS:  00007f9510ce8700(0000) GS:ffff8880aed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff0000000e CR3: 000000009570c000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

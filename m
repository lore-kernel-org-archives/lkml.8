Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7136BC33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449B820674
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 17:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgASRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 12:19:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41804 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgASRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 12:19:10 -0500
Received: by mail-il1-f200.google.com with SMTP id k9so23237100ili.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 09:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jRp9vc5oqYGc0xBFqUae1fHqkh5dl4kljEMRgo4dMw0=;
        b=OkNAU5AhiwxhifwSwhV4qGKxs4ZYIoh09QqIiif7W7aSvYGJufVSh3v+ZPQcuyrX2w
         oF9Ozoz8Pt9Mux4Og9KqyaVmX119stqJivmiUY3Gur6CraWrcVsDqJ/CMjQ4aaVtgcUy
         Ou8j20WWgU1omEnFsU6n2FIEtwIA0GPqO2FgQu9LUkZcaeEUiAknZJW5pZHr1BkdZ6fJ
         wQek/DS7ZQmzde6V0H6pfI0M605b2a9E+VmB+68hcTs8RSS+EwCnAuudDGvMC4OPjss9
         RIcATS87wL1eeHbZD5MIpiL59/ka7Ogx25Bp7t+5JAz3RN/N2hLXcSvUQCl/IKl+NfMk
         3PaA==
X-Gm-Message-State: APjAAAUFYUk4NdrRijphosNM2fXoEfTXt5pXFn4+DsN1j9eEPYXPbN+C
        81GqP5mKeX3vAO/C0BYCutfm8b5/qHnbhucT1bdOFQ3gSTIo
X-Google-Smtp-Source: APXvYqwKkTt8yRulq1166eajloC48wId38Am6j/Fl57rx03RnmYDk1PKfbySra7z4hbVwjzw6v8ckNwdFkXqPSGy6s0z/swvGZ3x
MIME-Version: 1.0
X-Received: by 2002:a02:cd31:: with SMTP id h17mr39404547jaq.94.1579454349645;
 Sun, 19 Jan 2020 09:19:09 -0800 (PST)
Date:   Sun, 19 Jan 2020 09:19:09 -0800
In-Reply-To: <00000000000005d2bf059c3b86ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000731be4059c815f94@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_con_write
From:   syzbot <syzbot+d8cbeb7028cd2950172e@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        ghalat@redhat.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        okash.khawaja@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    8f8972a3 Merge tag 'mtd/fixes-for-5.5-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130b73b9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=d8cbeb7028cd2950172e
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec4966e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b148d6e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d8cbeb7028cd2950172e@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 000000010000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD a98de067 P4D a98de067 PUD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8686 Comm: syz-executor679 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_K drivers/tty/vt/vt.c:1558 [inline]
RIP: 0010:do_con_trol drivers/tty/vt/vt.c:2370 [inline]
RIP: 0010:do_con_write+0x9f72/0xf360 drivers/tty/vt/vt.c:2797
Code: 00 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 10 44 00 00 48 8b 84 24 a0 00 00 00 0f b7 00 44 89 f9 81 e1 ff ff ff 7f 4c 89 f7 <f3> 66 ab 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 50 8a 04 01 84
RSP: 0018:ffffc900021f7880 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff89239ed0 RDI: 000000010000000e
RBP: ffffc900021f7b68 R08: 0000000000000005 R09: ffffffff83fa1e48
R10: ffff8880a274c1c0 R11: 0000000000000003 R12: 0000000000000000
R13: dffffc0000000000 R14: 000000010000000e R15: 0000000000000001
FS:  0000000001545880(0000) GS:ffff8880aec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 0000000097629000 CR4: 00000000001406f0
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
RIP: 0033:0x4404f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcc98f9338 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 000000010000000e
---[ end trace f08a62f87bf81d1c ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_K drivers/tty/vt/vt.c:1558 [inline]
RIP: 0010:do_con_trol drivers/tty/vt/vt.c:2370 [inline]
RIP: 0010:do_con_write+0x9f72/0xf360 drivers/tty/vt/vt.c:2797
Code: 00 00 00 00 00 fc ff df 8a 04 08 84 c0 0f 85 10 44 00 00 48 8b 84 24 a0 00 00 00 0f b7 00 44 89 f9 81 e1 ff ff ff 7f 4c 89 f7 <f3> 66 ab 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 50 8a 04 01 84
RSP: 0018:ffffc900021f7880 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff89239ed0 RDI: 000000010000000e
RBP: ffffc900021f7b68 R08: 0000000000000005 R09: ffffffff83fa1e48
R10: ffff8880a274c1c0 R11: 0000000000000003 R12: 0000000000000000
R13: dffffc0000000000 R14: 000000010000000e R15: 0000000000000001
FS:  0000000001545880(0000) GS:ffff8880aec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 0000000097629000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


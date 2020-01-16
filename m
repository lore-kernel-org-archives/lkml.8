Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09453C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86B720723
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgAPBnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:43:12 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:50810 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgAPBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:43:11 -0500
Received: by mail-io1-f72.google.com with SMTP id e13so11607933iob.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pU+hl6DQtUVqquHBvUG4AoVSnPVgpA2g4GQSgo/iOTk=;
        b=RkPCu0gvr+4MkUQaga7V5GRZU3dn/3e63o/5nUgBnawnPR0C66OaKW4QjWBXiR/5Kl
         6WNZ9mlkyEq0Ax6A9LYJ15XjYDTLU55fKdGKRgGQPV/9D2gskmuoLZm0ybxGw6PkdnO4
         WLNpOgsyzO0zaobhtyzEUUxXtZvIjkjjHbKBFIXhSb8Ys9F9IlIN78BptH9Ykg/IVBIO
         7WpDbiVFuMZGAO91WZjOZi8nP2jaYzX8ATB/y6QsYipg+hGue7vcVnCA/Posu9VUL6v5
         GOJDpvfqfkWtlMX5d05Q47NNY8GI+Va5FckxdaF6wIb8KcBpvga+L2n7wcQPP/A92wNs
         m7fg==
X-Gm-Message-State: APjAAAUWmJ0jehrWPUkI1f7T2AqMgj9Yl+8Qtbhxc3dA0O+5QgqoGklX
        oYESTLfu8XcS8KbHWwsiPbRL0wHYs/rmxlgueP2kpVvyivsv
X-Google-Smtp-Source: APXvYqz8ExHWuxGQb4AmA+nA6X6PodKsUo+BozZEdaPxl0l2wKwGqlShFzpKA0ULAH+CjvHgZZIY2hIT2gdduJYf8fFx75M/oM1x
MIME-Version: 1.0
X-Received: by 2002:a02:cdcb:: with SMTP id m11mr26685012jap.125.1579138990672;
 Wed, 15 Jan 2020 17:43:10 -0800 (PST)
Date:   Wed, 15 Jan 2020 17:43:10 -0800
In-Reply-To: <000000000000e45b52059ba1d3b9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000971018059c37f223@google.com>
Subject: Re: BUG: unable to handle kernel paging request in csi_J
From:   syzbot <syzbot+3f1750a5249afd5d7d2d@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    51d69817 Merge tag 'platform-drivers-x86-v5.5-3' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145bfa59e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbb8fa33f49f9f3
dashboard link: https://syzkaller.appspot.com/bug?extid=3f1750a5249afd5d7d2d
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/  
c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d23421e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166ef33ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3f1750a5249afd5d7d2d@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 000000010000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9e8e1067 P4D 9e8e1067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8751 Comm: syz-executor043 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_J+0x6c7/0xa80 drivers/tty/vt/vt.c:1529
Code: 3b 49 8d 9e c8 03 00 00 48 89 d8 48 c1 e8 03 42 8a 04 28 84 c0 0f 85  
53 01 00 00 0f b7 03 44 89 e1 81 e1 ff ff ff 7f 4c 89 ff <f3> 66 ab 48 c7  
c3 5c 8f 44 89 48 c7 c7 5c 8f 44 89 be 04 00 00 00
RSP: 0018:ffffc90001ee7830 EFLAGS: 00010202
RAX: 0000000000000720 RBX: ffff8880a7cb73c8 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000010000000e
RBP: ffffc90001ee7870 R08: ffffffff83f954a1 R09: ffffffff83f9522d
R10: ffff88808f1a81c0 R11: 0000000000000004 R12: 7fffffff80000001
R13: dffffc0000000000 R14: ffff8880a7cb7000 R15: 000000010000000e
FS:  00000000018af880(0000) GS:ffff8880aec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 00000000a3c14000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_con_trol drivers/tty/vt/vt.c:2367 [inline]
  do_con_write+0x7183/0xf360 drivers/tty/vt/vt.c:2797
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
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe37f8e118 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 000000010000000e
---[ end trace 0426c9c4e025bc85 ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_J+0x6c7/0xa80 drivers/tty/vt/vt.c:1529
Code: 3b 49 8d 9e c8 03 00 00 48 89 d8 48 c1 e8 03 42 8a 04 28 84 c0 0f 85  
53 01 00 00 0f b7 03 44 89 e1 81 e1 ff ff ff 7f 4c 89 ff <f3> 66 ab 48 c7  
c3 5c 8f 44 89 48 c7 c7 5c 8f 44 89 be 04 00 00 00
RSP: 0018:ffffc90001ee7830 EFLAGS: 00010202
RAX: 0000000000000720 RBX: ffff8880a7cb73c8 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000010000000e
RBP: ffffc90001ee7870 R08: ffffffff83f954a1 R09: ffffffff83f9522d
R10: ffff88808f1a81c0 R11: 0000000000000004 R12: 7fffffff80000001
R13: dffffc0000000000 R14: ffff8880a7cb7000 R15: 000000010000000e
FS:  00000000018af880(0000) GS:ffff8880aec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 00000000a3c14000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


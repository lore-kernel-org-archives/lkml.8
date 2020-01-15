Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186FAC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85B924656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgAOGWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:22:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50950 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:22:09 -0500
Received: by mail-io1-f70.google.com with SMTP id e13so9661642iob.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 22:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xmbQvBewwLHmCca6OFwf5iUW4UVzM4rCUF0spkELjNs=;
        b=l76yO7uyfCfx6rmnOHMKHfR5FdTYAqmyjzR/6cGHLpB+XmGA1obc5LeIcK93Us3ipr
         /seCY88uinMcctNX4HzgZ6TWr9HDVfJXhwimo6d3E8yRgoJcr7ZEtEmvzVrMlXPdi1uK
         oEABYQ8fMRQH3reSWYxukoFvWSBKVE+GJpvqMQu2WMncQPwyggMg6UscspRClwpLjpUJ
         do63gHLc3JN1JgP12wke3RI/8eSlSll7TuBE9Q94zZcNk0f+cQGe3pbGpUXy2zVWeTjw
         oroXS/uN8B08DGuuiHswN3HQKKV1cb9wkQuniWUauh3XQDqQYeAI+2+cyqSDM20XynB6
         fxCg==
X-Gm-Message-State: APjAAAVDB0IqFCsbcJTvXVoVI5hyf/3XtUDEQsYN+H9w6zygxo6l2pjn
        HaBDAOJBqMAiVy+idL1+Lz85WBS5XgVYE9awMITqVfJoQNn4
X-Google-Smtp-Source: APXvYqzTj22Mbwc4DagBjg+vlYTZrIGYYFM+6ReVWyefySV7smdIAL/t2fYavl+Ll1+RWM144eaCtdL+90PHRZH58RDW5VfdrqyJ
MIME-Version: 1.0
X-Received: by 2002:a92:503:: with SMTP id q3mr1964565ile.160.1579069328277;
 Tue, 14 Jan 2020 22:22:08 -0800 (PST)
Date:   Tue, 14 Jan 2020 22:22:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063486a059c27baff@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in insert_char
From:   syzbot <syzbot+8d8b0a62e3d61b05a75c@syzkaller.appspotmail.com>
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

HEAD commit:    e033e7d4 Merge branch 'dhowells' (patches from DavidH)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129b4bfee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=8d8b0a62e3d61b05a75c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8d8b0a62e3d61b05a75c@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000012
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 66c47067 P4D 66c47067 PUD 97d45067 PMD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10771 Comm: syz-executor.1 Not tainted 5.5.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:insert_char+0x23d/0x400 drivers/tty/vt/vt.c:840
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 01 0f 8e  
1e 01 00 00 d1 eb 41 0f b7 85 c8 03 00 00 4c 89 ff 89 d9 <f3> 66 ab 49 8d  
bd 78 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90008227858 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 1ffff1100e70c879 RSI: 0000000000000012 RDI: 0000000000000012
RBP: ffffc900082278a0 R08: ffff888051f5c000 R09: ffff888051f5c890
R10: fffffbfff14f69b0 R11: ffffffff8a7b4d87 R12: 0000000000000000
R13: ffff888073864000 R14: ffff888073864334 R15: 0000000000000012
FS:  00007fbfc62aa700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000012 CR3: 0000000095551000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  csi_at drivers/tty/vt/vt.c:1964 [inline]
  do_con_trol+0x41a6/0x61b0 drivers/tty/vt/vt.c:2431
  do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbfc62a9c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbfc62aa6d4
R13: 00000000004ccf01 R14: 00000000004e8538 R15: 00000000ffffffff
Modules linked in:
CR2: 0000000000000012
---[ end trace 7959dc0106335e09 ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:insert_char+0x23d/0x400 drivers/tty/vt/vt.c:840
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 01 0f 8e  
1e 01 00 00 d1 eb 41 0f b7 85 c8 03 00 00 4c 89 ff 89 d9 <f3> 66 ab 49 8d  
bd 78 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90008227858 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 1ffff1100e70c879 RSI: 0000000000000012 RDI: 0000000000000012
RBP: ffffc900082278a0 R08: ffff888051f5c000 R09: ffff888051f5c890
R10: fffffbfff14f69b0 R11: ffffffff8a7b4d87 R12: 0000000000000000
R13: ffff888073864000 R14: ffff888073864334 R15: 0000000000000012
FS:  00007fbfc62aa700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000758080 CR3: 0000000095551000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

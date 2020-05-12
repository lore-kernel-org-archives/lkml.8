Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E4C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E720752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgELGzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:55:22 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37300 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbgELGzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:55:17 -0400
Received: by mail-io1-f71.google.com with SMTP id 141so3615209iou.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0utPJhl8u3dQnuupDpTMqPJeqZpeiR+EaJx9ihO75P0=;
        b=iKxbALIxkrWI8bhaNY1066l0nul32Qh14Xrq+V7IxkgPrrLPkpr2MzQP8kFt+KibnR
         OwkGZKL7UEbKiwlyCfVuO6sUGTbmTvquDsF+EamVojVwRgM38N3oMtENW7koSXx7ss0L
         hOCBAwCNq3JRF6c/iposPgfdgi0x2Vrzl5vpVJ3EYbI1U6nqJvrpU4ueTywLR6Wj3ncr
         JWH5+ExJPh0+zY4+EFYgxpDUFonPMa3VB05C1mt4RyVcMfn/YdfQlSAXPVYttIWnv/Xl
         ZoIkSdeykLatMbVZAZomiQ3MiT4IH6LLnCnJdHFDVs6caTmveex+pe/C6Ij39vuCqLmc
         PMrw==
X-Gm-Message-State: AGi0PuZfMbqTN0UaLoeMlFJ5IzHUzaZYrxWqp1qEB/0fxv58iynKC3IU
        O0pIucHZG7TwzS/EFe/l2ittGO/QcRcehsdap1jDD/ziqc0I
X-Google-Smtp-Source: APiQypKwCw/HVeBYlAIDKGK08rZj9zUSvpqZc6seXE0qHdOTdwDsdt0UCVGhbx/CgOyu5OpFdCQa9NkmKlPwkNqeQrBa6WUcwCoT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc3:: with SMTP id l3mr19189526ilj.149.1589266516388;
 Mon, 11 May 2020 23:55:16 -0700 (PDT)
Date:   Mon, 11 May 2020 23:55:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029b38c05a56df2b0@google.com>
Subject: BUG: unable to handle kernel paging request in bitfill_aligned
From:   syzbot <syzbot+00ed1cf405874e141432@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1d3962ae Merge tag 'io_uring-5.7-2020-05-08' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14874258100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0212dbee046bc1f
dashboard link: https://syzkaller.appspot.com/bug?extid=00ed1cf405874e141432
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+00ed1cf405874e141432@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff888000cf5080
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD d401067 P4D d401067 PUD d402067 PMD cf4063 PTE 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 30473 Comm: syz-executor.4 Not tainted 5.7.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__writeq arch/x86/include/asm/io.h:98 [inline]
RIP: 0010:bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:64 [inline]
RIP: 0010:bitfill_aligned+0xfc/0x200 drivers/video/fbdev/core/cfbfillrect.c:35
Code: fd 44 89 e0 31 d2 bf 07 00 00 00 f7 f5 41 89 c4 89 c6 89 c5 e8 c5 ab b3 fd 41 83 fc 07 76 62 45 89 e7 4c 89 ed e8 44 aa b3 fd <48> 89 5d 00 48 89 5d 08 48 89 5d 10 48 89 5d 18 48 89 5d 20 48 89
RSP: 0018:ffffc90001c474e0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc90012324000
RDX: 0000000000040000 RSI: ffffffff83bf846c RDI: 0000000000000005
RBP: ffff888000cf5080 R08: ffff888056a6a340 R09: 0000000000000040
R10: ffff888218d3331f R11: ffffed10431a6663 R12: 0000000000000030
R13: ffff888000cf5080 R14: 0000000000000000 R15: 0000000000000030
FS:  00007fe0d9986700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888000cf5080 CR3: 000000008ea77000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cfb_fillrect+0x418/0x7a0 drivers/video/fbdev/core/cfbfillrect.c:327
 vga16fb_fillrect+0x68f/0x1960 drivers/video/fbdev/vga16fb.c:951
 bit_clear_margins+0x2d5/0x4a0 drivers/video/fbdev/core/bitblit.c:232
 fbcon_clear_margins+0x1de/0x240 drivers/video/fbdev/core/fbcon.c:1381
 fbcon_switch+0xcde/0x16f0 drivers/video/fbdev/core/fbcon.c:2363
 redraw_screen+0x2ae/0x770 drivers/tty/vt/vt.c:1015
 fbcon_modechanged+0x581/0x720 drivers/video/fbdev/core/fbcon.c:3000
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3047
 fb_set_var+0xad0/0xd40 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0x390/0x6e0 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c829
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe0d9985c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e4860 RCX: 000000000045c829
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000002f2 R14: 00000000004c54c8 R15: 00007fe0d99866d4
Modules linked in:
CR2: ffff888000cf5080

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

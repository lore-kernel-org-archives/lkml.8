Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8986C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B70C20735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHHHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:07:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51275 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgEHHHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:07:14 -0400
Received: by mail-io1-f69.google.com with SMTP id k1so977395iov.18
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 00:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1g63PD4aW+o9z6DtIx6SKExc/rMZEaz5ow/1Vs89Rik=;
        b=fTy1TvkQ+a2ObMCOg4YRwQiAo39SvSq1zXrgiVe5VAUV21bvXEoQ/oJ28RIYd2Ldve
         TcscM8J+Wo1VAbAD7gFpsP3OJUlplRu6D+SViy7jBMxdkKCqpcyeIYG31uPGxy6HPqTZ
         v6tm54mMKUZT20+F7Ga2juKA7/U0oUKdMVSKw5+hfLkubPZC1DU98QaXv0tXh9+ZRbjb
         dKA9wpMfgcwwukfeXoUcdCvN0UWmmD2vIyLrgwvFJSKemmas03Jeu4qrbCYDK7od7SMu
         46FyKMfyj8s/dhyslOJ9sqfhbA/m2yrwFOJVi1YPVASVKvtrycTpbiVB9ZakgMBzcs7O
         bsJA==
X-Gm-Message-State: AGi0PuakMLkyNvZDGp8AIb1iisGW+GJoxA5Zs+7Ic0EwEp4GgstFKAWR
        jCPrdZgkwouEDIlk+E+OgQVMo1oFjgN+XGVHmDtNiLCRsF1V
X-Google-Smtp-Source: APiQypLuTPZ0bTtaD8jyqJ21T3s0snid0JDDtH58MJUSOncjcM9yqBUA/lwCTFQm9CLtkD0H8QkYgJrI5SPlEUbSFvOoKTfJeY0H
MIME-Version: 1.0
X-Received: by 2002:a05:6638:ca1:: with SMTP id x1mr321463jad.86.1588921633226;
 Fri, 08 May 2020 00:07:13 -0700 (PDT)
Date:   Fri, 08 May 2020 00:07:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086452c05a51da504@google.com>
Subject: BUG: unable to handle kernel paging request in vga16fb_imageblit (2)
From:   syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    262f7a6b Merge tag 'for-5.7-rc3-tag' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12786888100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b075813ec8b93cd
dashboard link: https://syzkaller.appspot.com/bug?extid=1f29e126cf461c4de3b3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff8880ffca0e80
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD d401067 P4D d401067 PUD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 710 Comm: syz-executor.5 Not tainted 5.7.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1168 [inline]
RIP: 0010:vga16fb_imageblit+0xa5b/0x2210 drivers/video/fbdev/vga16fb.c:1260
Code: 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 ee 59 ed fd 41 8b 47 14 48 8b 74 24 08 <88> 06 0f ae e8 8a 06 b8 05 00 00 00 ba ce 03 00 00 ee 48 c7 c2 18
RSP: 0000:ffffc90002ea71f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffc90014391000
RDX: 0000000000000000 RSI: ffff8880ffca0e80 RDI: ffffc90002ea739c
RBP: ffffc90002ea738c R08: ffff8880922ac200 R09: 0000000000000000
R10: ffffffff8a895007 R11: fffffbfff1512a00 R12: 0000000000000000
R13: ffff888218de5140 R14: 0000000000000001 R15: ffffc90002ea7388
FS:  00007fbeeb282700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880ffca0e80 CR3: 000000008e9c5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x910/0xe10 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x345/0x3f0 drivers/video/fbdev/core/fbcon.c:1362
 con_flush drivers/tty/vt/vt.c:2569 [inline]
 do_con_write.part.0+0x7d1/0x1dc0 drivers/tty/vt/vt.c:2772
 do_con_write drivers/tty/vt/vt.c:2588 [inline]
 con_write+0x41/0xe0 drivers/tty/vt/vt.c:3154
 process_output_block drivers/tty/n_tty.c:595 [inline]
 n_tty_write+0x3f0/0xf90 drivers/tty/n_tty.c:2333
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x495/0x800 drivers/tty/tty_io.c:1046
 __vfs_write+0x76/0x100 fs/read_write.c:495
 __kernel_write+0x11c/0x3a0 fs/read_write.c:516
 write_pipe_buf+0x153/0x1e0 fs/splice.c:809
 splice_from_pipe_feed fs/splice.c:512 [inline]
 __splice_from_pipe+0x3e6/0x7b0 fs/splice.c:636
 splice_from_pipe+0xd9/0x140 fs/splice.c:671
 default_file_splice_write+0x37/0x90 fs/splice.c:821
 do_splice_from fs/splice.c:863 [inline]
 direct_splice_actor+0x115/0x160 fs/splice.c:1037
 splice_direct_to_actor+0x38c/0x980 fs/splice.c:992
 do_splice_direct+0x1b4/0x280 fs/splice.c:1080
 do_sendfile+0x555/0xc50 fs/read_write.c:1521
 __do_sys_sendfile64 fs/read_write.c:1582 [inline]
 __se_sys_sendfile64 fs/read_write.c:1568 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1568
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c829
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fbeeb281c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004fc0c0 RCX: 000000000045c829
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0800000080004103 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000008d6 R14: 00000000004cb7a1 R15: 00007fbeeb2826d4
Modules linked in:
CR2: ffff8880ffca0e80
---[ end trace 5bb103c4fc7bf525 ]---
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1168 [inline]
RIP: 0010:vga16fb_imageblit+0xa5b/0x2210 drivers/video/fbdev/vga16fb.c:1260
Code: 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 ee 59 ed fd 41 8b 47 14 48 8b 74 24 08 <88> 06 0f ae e8 8a 06 b8 05 00 00 00 ba ce 03 00 00 ee 48 c7 c2 18
RSP: 0000:ffffc90002ea71f0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffc90014391000
RDX: 0000000000000000 RSI: ffff8880ffca0e80 RDI: ffffc90002ea739c
RBP: ffffc90002ea738c R08: ffff8880922ac200 R09: 0000000000000000
R10: ffffffff8a895007 R11: fffffbfff1512a00 R12: 0000000000000000
R13: ffff888218de5140 R14: 0000000000000001 R15: ffffc90002ea7388
FS:  00007fbeeb282700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880ffca0e80 CR3: 000000008e9c5000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

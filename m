Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14685C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D711E2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDKH7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:59:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55836 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgDKH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:59:11 -0400
Received: by mail-io1-f69.google.com with SMTP id k5so4342944ioa.22
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 00:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nooiccf0bvg2ymiBh4FJBdl7+CwejWp6PZyhC8b5zR0=;
        b=pwfcQRZRG/lrxMA0OQPzJGfcHzo2QZwhkNCT77Ovx0NOGf5C21T3hboas4zQ1ldbhL
         HqNmceKInYyL32QFFn979IzwThoB+fUjDTj0qk2Om780rn5+GJCZ/4pFiW7eMri2j5At
         0M7VbRPCLCewZ2GYnvTbHJNDzZRcRykCYl153c+bxDlGwO8JYbhwZgoEA9qZg3fwQqMN
         d5VOwQsphn1/7NEJDYU8SHNbIF6hJ3vuiHhCOltNeJvAHSqmpov5koAx2pzxdnokfbEo
         tTi6SwYVlGD1+1Vte1Attxne2PEAOEyhTqJrmkyrXdA79ZAaOtZjkyeTd6l7pyNEzuYJ
         fF7g==
X-Gm-Message-State: AGi0PuYD7vt7NyMrUn58m4Y2RzIJNjkdMEJ3T168htcHQRmFW2qC/lAF
        Eanmt965/38AFwPFGRttyaZ3PC3LERT3B2PbnznfTCQnML4O
X-Google-Smtp-Source: APiQypIGZsDNN5KpYHm+DmbsaBnPSsgcQ0r43bNVyREYjZiuSYffVtRMd6kPz/kB1nIGxqn5/mWHX6GHHxtivpB4hcn0PCmug5Ig
MIME-Version: 1.0
X-Received: by 2002:a92:89c7:: with SMTP id w68mr9058219ilk.233.1586591949675;
 Sat, 11 Apr 2020 00:59:09 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:59:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090655b05a2ff399a@google.com>
Subject: memory leak in drm_vma_node_allow
From:   syzbot <syzbot+04639d98c75c52e41b8a@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156ec43be00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d7f19fdf7ef2f5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=04639d98c75c52e41b8a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=121898ede00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+04639d98c75c52e41b8a@syzkaller.appspotmail.com

2020/04/07 05:10:47 executed programs: 23
2020/04/07 05:10:53 executed programs: 35
2020/04/07 05:11:00 executed programs: 46
2020/04/07 05:11:06 executed programs: 62
BUG: memory leak
unreferenced object 0xffff888104682080 (size 64):
  comm "syz-executor.5", pid 8616, jiffies 4294946318 (age 15.290s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 da bd 03 81 88 ff ff  ................
  backtrace:
    [<00000000cac525e9>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000cac525e9>] drm_vma_node_allow+0x32/0x120 drivers/gpu/drm/drm_vma_manager.c:274
    [<00000000ab055b7c>] drm_gem_handle_create_tail+0xd8/0x250 drivers/gpu/drm/drm_gem.c:403
    [<00000000d1e67364>] vgem_gem_create drivers/gpu/drm/vgem/vgem_drv.c:198 [inline]
    [<00000000d1e67364>] vgem_gem_dumb_create+0x73/0x100 drivers/gpu/drm/vgem/vgem_drv.c:218
    [<00000000dd87232b>] drm_mode_create_dumb+0xbe/0xf0 drivers/gpu/drm/drm_dumb_buffers.c:94
    [<00000000d7ff7e08>] drm_ioctl_kernel+0xcb/0x130 drivers/gpu/drm/drm_ioctl.c:787
    [<0000000080a20f26>] drm_ioctl+0x25c/0x420 drivers/gpu/drm/drm_ioctl.c:887
    [<00000000d53a93ee>] vfs_ioctl fs/ioctl.c:47 [inline]
    [<00000000d53a93ee>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:763
    [<00000000c5492a67>] __do_sys_ioctl fs/ioctl.c:772 [inline]
    [<00000000c5492a67>] __se_sys_ioctl fs/ioctl.c:770 [inline]
    [<00000000c5492a67>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:770
    [<00000000becf688f>] do_syscall_64+0x6e/0x220 arch/x86/entry/common.c:295
    [<0000000050094727>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches

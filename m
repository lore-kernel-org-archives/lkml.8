Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7BDC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97082084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgAKRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:19:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36608 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgAKRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 12:19:10 -0500
Received: by mail-il1-f197.google.com with SMTP id t2so4247434ilp.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 09:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rOxD20ubENsSvUKR96g4GhYacd9/gWfWmD4fONuaSG0=;
        b=RbpvdMog1ZxmEVjhvDqoiSdLLCx4GsNtWWn8n+GX2clym+Pg6nJKM24VToSD5x6sSW
         i+coodhMBXXH7F52zXgw16G84E8ywuT9+HCmtZQGipcUFlpNl7FYhCjUMAzbWCK2wZyZ
         WvH+FWxIoJUh/N4VtV41hjniuCrxFOAYRQdkQvXwXGvUp5eKUKYJ9QtgQLXhkOyFG7+5
         9oTvCQZaRowlmnsTw1O/OYbxYjUwBjfqLi68xNF/KVT2yfT3LGTzGknvuLxwn3yGZs0e
         F35FmdcaGvCsw9VSDBKxaDo+S0QJV2Fj3ry90C8xPTwc1us/STOk4QM5MobjoFlaKRLe
         csuA==
X-Gm-Message-State: APjAAAX0EqZF5yhofU3MIb3oiOjJVNwyU8w20NEDy1HtlHwIbpgsTfQq
        qQTevgKJtrNkzzfGpXERsxCN4WtvO5357pizsykfgKgNmQdP
X-Google-Smtp-Source: APXvYqxbZH4l1OKZCSVA3wEKraLueKJeidVG10Gfew2kkXB5bcA2+MIjG6lXeleijv5+yLvegBXC/vR4RjNxksi/M7l9sRtVenLv
MIME-Version: 1.0
X-Received: by 2002:a92:906:: with SMTP id y6mr7879438ilg.157.1578763149416;
 Sat, 11 Jan 2020 09:19:09 -0800 (PST)
Date:   Sat, 11 Jan 2020 09:19:09 -0800
In-Reply-To: <0000000000006d0a820599366088@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4acb6059be070c0@google.com>
Subject: Re: memory leak in erase_aeb
From:   syzbot <syzbot+f317896aae32eb281a58@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    bef1d882 Merge tag 'pstore-v5.5-rc6' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158a51b9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e479cb92d5ce3196
dashboard link: https://syzkaller.appspot.com/bug?extid=f317896aae32eb281a58
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132269e1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1247d58ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f317896aae32eb281a58@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888127cecb00 (size 32):
   comm "syz-executor527", pid 7144, jiffies 4294957528 (age 23.750s)
   hex dump (first 32 bytes):
     00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
     00 00 00 00 00 00 00 00 01 00 00 00 02 00 00 00  ................
   backtrace:
     [<0000000029f9ef6c>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000029f9ef6c>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<0000000029f9ef6c>] slab_alloc mm/slab.c:3320 [inline]
     [<0000000029f9ef6c>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3484
     [<000000003092c936>] erase_aeb+0x2a/0x100 drivers/mtd/ubi/wl.c:1691
     [<00000000d507b66e>] ubi_wl_init+0x1ae/0x600 drivers/mtd/ubi/wl.c:1758
     [<0000000072e7d762>] ubi_attach+0x665/0x18e7  
drivers/mtd/ubi/attach.c:1605
     [<0000000024d645cb>] ubi_attach_mtd_dev+0x5b3/0xd40  
drivers/mtd/ubi/build.c:946
     [<00000000e6600cef>] ctrl_cdev_ioctl+0x149/0x1c0  
drivers/mtd/ubi/cdev.c:1043
     [<000000001253992f>] vfs_ioctl fs/ioctl.c:47 [inline]
     [<000000001253992f>] file_ioctl fs/ioctl.c:545 [inline]
     [<000000001253992f>] do_vfs_ioctl+0x551/0x890 fs/ioctl.c:732
     [<00000000c49e8c94>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:749
     [<00000000261db07c>] __do_sys_ioctl fs/ioctl.c:756 [inline]
     [<00000000261db07c>] __se_sys_ioctl fs/ioctl.c:754 [inline]
     [<00000000261db07c>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:754
     [<000000004f01dc3e>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<000000002de81d29>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888127cecb00 (size 32):
   comm "syz-executor527", pid 7144, jiffies 4294957528 (age 26.350s)
   hex dump (first 32 bytes):
     00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
     00 00 00 00 00 00 00 00 01 00 00 00 02 00 00 00  ................
   backtrace:
     [<0000000029f9ef6c>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000029f9ef6c>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<0000000029f9ef6c>] slab_alloc mm/slab.c:3320 [inline]
     [<0000000029f9ef6c>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3484
     [<000000003092c936>] erase_aeb+0x2a/0x100 drivers/mtd/ubi/wl.c:1691
     [<00000000d507b66e>] ubi_wl_init+0x1ae/0x600 drivers/mtd/ubi/wl.c:1758
     [<0000000072e7d762>] ubi_attach+0x665/0x18e7  
drivers/mtd/ubi/attach.c:1605
     [<0000000024d645cb>] ubi_attach_mtd_dev+0x5b3/0xd40  
drivers/mtd/ubi/build.c:946
     [<00000000e6600cef>] ctrl_cdev_ioctl+0x149/0x1c0  
drivers/mtd/ubi/cdev.c:1043
     [<000000001253992f>] vfs_ioctl fs/ioctl.c:47 [inline]
     [<000000001253992f>] file_ioctl fs/ioctl.c:545 [inline]
     [<000000001253992f>] do_vfs_ioctl+0x551/0x890 fs/ioctl.c:732
     [<00000000c49e8c94>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:749
     [<00000000261db07c>] __do_sys_ioctl fs/ioctl.c:756 [inline]
     [<00000000261db07c>] __se_sys_ioctl fs/ioctl.c:754 [inline]
     [<00000000261db07c>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:754
     [<000000004f01dc3e>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<000000002de81d29>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888127cecb00 (size 32):
   comm "syz-executor527", pid 7144, jiffies 4294957528 (age 32.820s)
   hex dump (first 32 bytes):
     00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
     00 00 00 00 00 00 00 00 01 00 00 00 02 00 00 00  ................
   backtrace:
     [<0000000029f9ef6c>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000029f9ef6c>] slab_post_alloc_hook mm/slab.h:586 [inline]
     [<0000000029f9ef6c>] slab_alloc mm/slab.c:3320 [inline]
     [<0000000029f9ef6c>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3484
     [<000000003092c936>] erase_aeb+0x2a/0x100 drivers/mtd/ubi/wl.c:1691
     [<00000000d507b66e>] ubi_wl_init+0x1ae/0x600 drivers/mtd/ubi/wl.c:1758
     [<0000000072e7d762>] ubi_attach+0x665/0x18e7  
drivers/mtd/ubi/attach.c:1605
     [<0000000024d645cb>] ubi_attach_mtd_dev+0x5b3/0xd40  
drivers/mtd/ubi/build.c:946
     [<00000000e6600cef>] ctrl_cdev_ioctl+0x149/0x1c0  
drivers/mtd/ubi/cdev.c:1043
     [<000000001253992f>] vfs_ioctl fs/ioctl.c:47 [inline]
     [<000000001253992f>] file_ioctl fs/ioctl.c:545 [inline]
     [<000000001253992f>] do_vfs_ioctl+0x551/0x890 fs/ioctl.c:732
     [<00000000c49e8c94>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:749
     [<00000000261db07c>] __do_sys_ioctl fs/ioctl.c:756 [inline]
     [<00000000261db07c>] __se_sys_ioctl fs/ioctl.c:754 [inline]
     [<00000000261db07c>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:754
     [<000000004f01dc3e>] do_syscall_64+0x73/0x220  
arch/x86/entry/common.c:294
     [<000000002de81d29>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

executing program
executing program
executing program
executing program
executing program


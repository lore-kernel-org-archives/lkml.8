Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1536C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2742206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHCNzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:55:25 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39605 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgHCNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:55:23 -0400
Received: by mail-il1-f197.google.com with SMTP id i66so19212565ile.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=214EZ0fQRS+mwViVnXIcFRThja+FGwhtORlIAqobSEQ=;
        b=VNTlanXH3ARD2B86HPIKaYeLueBmS7JZZgPt3/zyVLQA34gxDlQYUQ7idWNIcutUX0
         rXEhkahaH/rkOc8dc9h2KS3PmO4pCwK/xf2Rmd5eOmSNtf+D7ZJdEk0cG7x4jlG2HAz6
         EL9xrTkVeU4KSoc1zfkz3MUrhutwyq4izGzmo7f/vle6UxMsd/fjnIGUVtZaKyzQDZ8A
         islVOVVU9S6kEJZA78wFVg+SwrVoasTauiAwSWp+lxjOHofde1x2qJblqZ4KVqyeg52l
         4kLCnyZKCWEB2FPF3iWrwbOmgvjYZ8FKxGWt+qZfmUgK0sB8xVs74H3mI+QyXojkugPn
         xJOA==
X-Gm-Message-State: AOAM531jmFD+wxpIsnajoM0ORhfIljMxXGL3pp5qh1JngW25kGc18hj1
        GlbEuz7mmTMYh8uIskX28A2IkiAYkz/gyi9HusFEdrUB5wxj
X-Google-Smtp-Source: ABdhPJyS2eyf9ck7Mt+eLZWu3V9kaUQV9aCHcCa2ZnHJ3IeRvFJyTyrMmiSeSCt6TfUpU5zCWp8w2/BSSGgHYqZFf3NbubJNM6DW
MIME-Version: 1.0
X-Received: by 2002:a92:d384:: with SMTP id o4mr948704ilo.243.1596462922144;
 Mon, 03 Aug 2020 06:55:22 -0700 (PDT)
Date:   Mon, 03 Aug 2020 06:55:22 -0700
In-Reply-To: <000000000000accada05a5595a10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f209505abf97dec@google.com>
Subject: Re: KASAN: use-after-free Read in vc_do_resize
From:   syzbot <syzbot+3c9716daab4ea34d814f@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ebiggers@google.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    bcf87687 Linux 5.8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1268f642900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19b11af1e394136d
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9716daab4ea34d814f
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f48ecc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd8c78900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c9716daab4ea34d814f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: use-after-free in scr_memcpyw include/linux/vt_buffer.h:49 [inline]
BUG: KASAN: use-after-free in vc_do_resize+0x9d6/0x13f0 drivers/tty/vt/vt.c:1286
Read of size 2 at addr ffff88809da9f8c2 by task syz-executor887/23625

CPU: 1 PID: 23625 Comm: syz-executor887 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x436 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:406 [inline]
 scr_memcpyw include/linux/vt_buffer.h:49 [inline]
 vc_do_resize+0x9d6/0x13f0 drivers/tty/vt/vt.c:1286
 fbcon_modechanged+0x36c/0x710 drivers/video/fbdev/core/fbcon.c:2990
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:3048
 fb_set_var+0xae8/0xd60 drivers/video/fbdev/core/fbmem.c:1056
 do_fb_ioctl+0x33f/0x6c0 drivers/video/fbdev/core/fbmem.c:1109
 fb_ioctl+0xdd/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x44aa19
Code: e8 3c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b 06 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f027d75bdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006e69f8 RCX: 000000000044aa19
RDX: 0000000020000000 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 00000000006e69f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e69fc
R13: 00007ffcf24f523f R14: 00007f027d75c9c0 R15: 20c49ba5e353f7cf

Allocated by task 23115:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x14f/0x2d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 apparmor_sk_alloc_security+0x79/0xf0 security/apparmor/lsm.c:776
 security_sk_alloc+0x50/0xb0 security/security.c:2180
 sk_prot_alloc+0xae/0x300 net/core/sock.c:1696
 sk_alloc+0x32/0xbd0 net/core/sock.c:1747
 unix_create1+0xbf/0x730 net/unix/af_unix.c:795
 unix_create+0xf9/0x1e0 net/unix/af_unix.c:857
 __sock_create+0x3ca/0x740 net/socket.c:1428
 sock_create net/socket.c:1479 [inline]
 __sys_socketpair+0x242/0x570 net/socket.c:1583
 __do_sys_socketpair net/socket.c:1632 [inline]
 __se_sys_socketpair net/socket.c:1629 [inline]
 __x64_sys_socketpair+0x93/0xf0 net/socket.c:1629
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 23107:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf5/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3757
 security_sk_free+0x3e/0x70 security/security.c:2185
 sk_prot_free net/core/sock.c:1726 [inline]
 __sk_destruct+0x537/0x860 net/core/sock.c:1815
 sk_destruct+0xbd/0xe0 net/core/sock.c:1830
 __sk_free+0xef/0x3d0 net/core/sock.c:1841
 sk_free+0x78/0xa0 net/core/sock.c:1852
 sock_put include/net/sock.h:1781 [inline]
 unix_release_sock+0x7fc/0xc10 net/unix/af_unix.c:574
 unix_release+0x3f/0x80 net/unix/af_unix.c:867
 __sock_release+0xcd/0x280 net/socket.c:605
 sock_close+0x18/0x20 net/socket.c:1278
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x1e9/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88809da9f8c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 2 bytes inside of
 32-byte region [ffff88809da9f8c0, ffff88809da9f8e0)
The buggy address belongs to the page:
page:ffffea000276a7c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88809da9ffc1
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002789fc8 ffffea0002a46148 ffff8880aa0001c0
raw: ffff88809da9ffc1 ffff88809da9f000 000000010000003c 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809da9f780: 00 00 00 fc fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88809da9f800: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
>ffff88809da9f880: 00 02 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
                                           ^
 ffff88809da9f900: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff88809da9f980: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


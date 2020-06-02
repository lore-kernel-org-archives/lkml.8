Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CF620734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgQk83LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgFBUfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgFBUfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2944C08C5C0;
        Tue,  2 Jun 2020 13:35:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u10so13032155ljj.9;
        Tue, 02 Jun 2020 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xgZhJ/0PiwRCGGeVSX5ESFlWEeZ6yZH6gPsuCEl06yY=;
        b=PgQk83LNStyULoWtcnPtjxZWOf7myP8fTxco6XL8EJ+Kaql/zDrzhzile8b1WsWiae
         NVtMkDUX4rJnIMl75KoAwAcZLCdYdFkumiMC9Q0ItD9sfJGNFMaR8G5+6DAbgIPIYwxw
         KUWFZwdJctg+5lNxxD8QfxDk+dt8aT+AhyCdy+7+ssep0eLhJ7G8wxeyCO5PUCpZjJfx
         fbxdWZcmE3oXOKdrrvFbnhHwjS0+emYRDP/A8BV0dvhZ5paWHZT7Gg792xM+AXDIMCg6
         jsMGfmfr6pb6nJ5OR7OcaaMY4xBoMJo65FNwiuf2zCGBPv67eNJh6argyeIIulO8vVk1
         V+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xgZhJ/0PiwRCGGeVSX5ESFlWEeZ6yZH6gPsuCEl06yY=;
        b=k8JW+FapVkPtaqPtOM8N1nL4VHfhpVnyxJQ0szJTMn+x0aWmsYPTnbPnT+Omy6nmeM
         INk7A2WpOxbb6BDKO8fjm7KgZQgM4/P3XgVIdr4NhMuFw7AsivX+tym3eHeZzG9+M8vG
         BvE2mejXtjcoQp9BH08ny80kGpBOmUNMCvMzQQ2x8wYAd/HqVwr2CnHrnVNfOqja3q/y
         JOos8+awJ++f64uLrgG0+Oo8IKiJ/DgbdMqccvqXTAiXsNbznIfoqkH3ln13UrfHPTpo
         0ZbCC0mYAPuJCD3MGYZwtoNlRon6KaY6MV2q4CWebXn2ZcNUqBY8b9hIJrY5BTA4K6MB
         j/fQ==
X-Gm-Message-State: AOAM5311VeUrmJ0yRd+YsmxRG2ZSILc4nIntaXphqXSOOE0XYbYIDEeD
        PSwU3G8aPpcpL7SdYR3LcgHAjxGPigX/clZhfYs=
X-Google-Smtp-Source: ABdhPJwxqwcMBYopvjpAI9BDGX+FzGiH119WPhtb52UHEwGZSLAxQa6b8DP0BsvDdciKmLorQkbTDFNbRnY23NJu7to=
X-Received: by 2002:a2e:8115:: with SMTP id d21mr422843ljg.167.1591130144141;
 Tue, 02 Jun 2020 13:35:44 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Tue, 2 Jun 2020 16:35:33 -0400
Message-ID: <CAEAjamsJLRYarDLCUs-ymUWusk=oC=ko5iRgouBJdP34zXSQHg@mail.gmail.com>
Subject: KASAN: use-after-free Read in printer_read
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.6.11) found by FuzzUSB (a modified version
of syzkaller)

This bug happened when accessing a deallocated instance in printer_read().

printer_read() tries to access lock_printer_io of the printer_dev instance
(f_printer.c:430). However, UAF arises because it had been freed
by gprinter_free().

To fix, we can check if an instance of printer_dev is still in use
before deallocating it.

kernel config: https://kt0755.github.io/etc/config_v5.6.11

==================================================================
BUG: KASAN: use-after-free in __mutex_lock_common
kernel/locking/mutex.c:938 [inline]
BUG: KASAN: use-after-free in __mutex_lock+0x13a7/0x14d0
kernel/locking/mutex.c:1103
Read of size 8 at addr ffff8880540c3890 by task syz-executor.0/6819

CPU: 1 PID: 6819 Comm: syz-executor.0 Not tainted 5.6.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
 __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 __mutex_lock_common kernel/locking/mutex.c:938 [inline]
 __mutex_lock+0x13a7/0x14d0 kernel/locking/mutex.c:1103
 mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
 printer_read+0xbc/0xd60 drivers/usb/gadget/function/f_printer.c:430
 __vfs_read+0x85/0x110 fs/read_write.c:425
 vfs_read+0x161/0x380 fs/read_write.c:461
 ksys_read+0x18a/0x220 fs/read_write.c:587
 __do_sys_read fs/read_write.c:597 [inline]
 __se_sys_read fs/read_write.c:595 [inline]
 __x64_sys_read+0x73/0xb0 fs/read_write.c:595
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4531a9
Code: ed 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 bb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f0024694c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000000000073bfa8 RCX: 00000000004531a9
RDX: 000000000000006b RSI: 0000000020000100 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bd843
R13: 00000000004d3468 R14: 00007f00246956d4 R15: 00000000ffffffff

Allocated by task 2420:
 save_stack+0x21/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:515
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 kmem_cache_alloc_trace+0xfa/0x2d0 mm/slub.c:2813
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 gprinter_alloc+0xa1/0x870 drivers/usb/gadget/function/f_printer.c:1416
 usb_get_function+0x58/0xc0 drivers/usb/gadget/functions.c:61
 config_usb_cfg_link+0x1ed/0x3e0 drivers/usb/gadget/configfs.c:444
 configfs_symlink+0x527/0x11d0 fs/configfs/symlink.c:202
 vfs_symlink+0x33d/0x5b0 fs/namei.c:4201
 do_symlinkat+0x11b/0x1d0 fs/namei.c:4228
 __do_sys_symlinkat fs/namei.c:4242 [inline]
 __se_sys_symlinkat fs/namei.c:4239 [inline]
 __x64_sys_symlinkat+0x73/0xb0 fs/namei.c:4239
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 6798:
 save_stack+0x21/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x135/0x190 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 slab_free_hook mm/slub.c:1444 [inline]
 slab_free_freelist_hook mm/slub.c:1477 [inline]
 slab_free mm/slub.c:3034 [inline]
 kfree+0xf7/0x410 mm/slub.c:3995
 gprinter_free+0x49/0xd0 drivers/usb/gadget/function/f_printer.c:1353
 usb_put_function+0x38/0x50 drivers/usb/gadget/functions.c:87
 config_usb_cfg_unlink+0x2db/0x3b0 drivers/usb/gadget/configfs.c:485
 configfs_unlink+0x3b9/0x7f0 fs/configfs/symlink.c:250
 vfs_unlink+0x287/0x570 fs/namei.c:4073
 do_unlinkat+0x4f9/0x620 fs/namei.c:4137
 __do_sys_unlink fs/namei.c:4184 [inline]
 __se_sys_unlink fs/namei.c:4182 [inline]
 __x64_sys_unlink+0x42/0x50 fs/namei.c:4182
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880540c3800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 144 bytes inside of
 1024-byte region [ffff8880540c3800, ffff8880540c3c00)
The buggy address belongs to the page:
page:ffffea0001503000 refcount:1 mapcount:0 mapping:ffff88806c00e300
index:0xffff8880540c4800 compound_mapcount: 0
flags: 0x100000000010200(slab|head)
raw: 0100000000010200 ffffea0001ae3808 ffffea0001ac6c08 ffff88806c00e300
raw: ffff8880540c4800 0000000000100007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880540c3780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880540c3800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880540c3880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff8880540c3900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880540c3980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95730C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 18:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71CBE23A9B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 18:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3VIAsrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgFUSGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730522AbgFUSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 14:06:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FBC061794;
        Sun, 21 Jun 2020 11:06:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so16830072lji.2;
        Sun, 21 Jun 2020 11:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pKJIHr9V83SjvQb03h2K7vmu7LndC3Ea0/4vel+6jjk=;
        b=n3VIAsrFY1lcL3z7vvT1Z2H4+AMwlKK6AzRSTDzE66rcDlsq+WWGZRqJ3t93vmn++F
         7hvD5I1lUu/FHLz3/wAkuQVsu3sq93Z8nZfW13LIwEt5A6XF14HSMVBs5bcQNjcCfh9j
         vv26k1M41IA2gdOvGg2gmogCU+J4mCeFMFjCQ2USLcy80817neIxTZ3ioNt6hyH2tmHl
         hlgT41VnhsVkZYreNEpLcqP9bmxvMRPTZCoRXwwcnC15r87KxUU2KwCSiiQHEtabtkXh
         4CRfBzamMMobo+NaFX1wIf1B2kD0wlRGx0LKUsdm84qiVphYOLQdBiEADgEJ5iivdvbp
         Ehkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pKJIHr9V83SjvQb03h2K7vmu7LndC3Ea0/4vel+6jjk=;
        b=W5ziHLd/CoM5IesA5BJE+Rm3YnGNrfLK52IvZh53Fg1nJsmOOmpDJUNITlbqrs9LZ5
         LwD3FPiEagQTU3P8/JqClDhB9D1nemRG1m9Qg1QxsIDYwEbfE29gvlR9aXsoh2dvXya+
         vo4XEFqTfIHUmnsSgLQCkxcmKWAJVQV5TbNUn5vp60ivg9ZyRRhtlrR4dZeBLPC5icMG
         SH63bV04N7fTERfb+xOSSvY7pG599qnPDdalEcJhfWCJy3FPhNh7TXdzBBRXPaKWd7xd
         1gj3kiuMMC65bAE4KslO41WZAqPeczAyymnLxZcPadmIVqhWH8RpaPzDotiTFQANJiNf
         hVeQ==
X-Gm-Message-State: AOAM532a6Ky/feBVW3U/0C3mWhrDbiQvKcRqopKNxNjFcemeLly5Hsuo
        PF0k4zrSJpN2HxHTkn0QSYB5JfO6D/orXcG0+2w=
X-Google-Smtp-Source: ABdhPJwmjeXXTUN2ZehMJQbnpvj6G1WXngNWdu7IQLgmpnyQnY6r16qymWSQDSiUnZv+dlMkWicROaUL3ZLleZMJcFQ=
X-Received: by 2002:a2e:8e8d:: with SMTP id z13mr6346205ljk.461.1592762809278;
 Sun, 21 Jun 2020 11:06:49 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sun, 21 Jun 2020 14:06:38 -0400
Message-ID: <CAEAjamtFJJaj=Xn9Jb2T3wPm3eVb=SUFMnhFCCd3zULNy_FBUw@mail.gmail.com>
Subject: KASAN: use-after-free Read in gs_flush_chars
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.7) found by FuzzUSB (a modified version
of syzkaller)

The bug happened when accessing a deallocated instance of gs_port.
While spinning a lock in gs_flush_chars(),
port is allowed to be freed in gser_free_inst().
This ends up tringgering an memory error.

To fix this, it needs to check if port is is still in use, in particular,
lock spinning, when deallocating it.

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x44f1/0x4aa0
kernel/locking/lockdep.c:4225
Read of size 8 at addr ffff88803bf5d398 by task syz-executor.7/3903

CPU: 3 PID: 3903 Comm: syz-executor.7 Not tainted 5.7.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 print_address_description.constprop.6+0x1f/0x410 mm/kasan/report.c:382
 __kasan_report+0x106/0x140 mm/kasan/report.c:511
 kasan_report+0x38/0x50 mm/kasan/common.c:625
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:146
 __lock_acquire+0x44f1/0x4aa0 kernel/locking/lockdep.c:4225
 lock_acquire+0x18d/0xbe0 kernel/locking/lockdep.c:4934
 __raw_spin_lock_irqsave ./include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
 gs_flush_chars+0x45/0xb0 drivers/usb/gadget/function/u_serial.c:764
 n_tty_write+0x685/0xe70 drivers/tty/n_tty.c:2350
 do_tty_write drivers/tty/tty_io.c:962 [inline]
 tty_write+0x462/0x970 drivers/tty/tty_io.c:1046
 __vfs_write+0x85/0x110 fs/read_write.c:495
 vfs_write+0x1d3/0x520 fs/read_write.c:559
 ksys_write+0x190/0x220 fs/read_write.c:612
 __do_sys_write fs/read_write.c:624 [inline]
 __se_sys_write fs/read_write.c:621 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:621
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x453769
Code: ed 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 bb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7f29106c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000453769
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004c0ed1
R13: 00000000004d8fa0 R14: 00007f7f291076d4 R15: 00000000ffffffff

Allocated by task 2445:
 save_stack+0x21/0x50 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:495
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:509
 kmem_cache_alloc_trace+0xfa/0x2d0 mm/slub.c:2824
 kmalloc ./include/linux/slab.h:555 [inline]
 kzalloc ./include/linux/slab.h:669 [inline]
 gs_port_alloc drivers/usb/gadget/function/u_serial.c:1142 [inline]
 gserial_alloc_line_no_console+0xdc/0x920
drivers/usb/gadget/function/u_serial.c:1222
 gserial_alloc_line+0x17/0x70 drivers/usb/gadget/function/u_serial.c:1256
 gser_alloc_inst+0x8d/0xf0 drivers/usb/gadget/function/f_serial.c:327
 try_get_usb_function_instance+0xf8/0x1c0 drivers/usb/gadget/functions.c:28
 usb_get_function_instance+0x17/0x80 drivers/usb/gadget/functions.c:44
 function_make+0xfa/0x3c0 drivers/usb/gadget/configfs.c:600
 configfs_mkdir+0x458/0xaf0 fs/configfs/dir.c:1344
 vfs_mkdir+0x3aa/0x670 fs/namei.c:3625
 do_mkdirat+0x12b/0x220 fs/namei.c:3648
 __do_sys_mkdir fs/namei.c:3664 [inline]
 __se_sys_mkdir fs/namei.c:3662 [inline]
 __x64_sys_mkdir+0x5c/0x80 fs/namei.c:3662
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 3905:
 save_stack+0x21/0x50 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0x135/0x190 mm/kasan/common.c:456
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:465
 slab_free_hook mm/slub.c:1455 [inline]
 slab_free_freelist_hook mm/slub.c:1488 [inline]
 slab_free mm/slub.c:3045 [inline]
 kfree+0xf7/0x410 mm/slub.c:4026
 gserial_free_port+0x124/0x250 drivers/usb/gadget/function/u_serial.c:1186
 gserial_free_line+0x12b/0x270 drivers/usb/gadget/function/u_serial.c:1203
 gser_free_inst+0x3d/0x50 drivers/usb/gadget/function/f_serial.c:313
 usb_put_function_instance+0x86/0xb0 drivers/usb/gadget/functions.c:77
 serial_attr_release+0x15/0x20 drivers/usb/gadget/function/f_serial.c:262
 config_item_cleanup fs/configfs/item.c:130 [inline]
 config_item_release fs/configfs/item.c:139 [inline]
 kref_put ./include/linux/kref.h:65 [inline]
 config_item_put.part.0+0x191/0x250 fs/configfs/item.c:151
 config_item_put+0x1f/0x30 fs/configfs/item.c:150
 configfs_rmdir+0x58e/0x870 fs/configfs/dir.c:1555
 vfs_rmdir+0x168/0x490 fs/namei.c:3688
 do_rmdir+0x2f2/0x3a0 fs/namei.c:3750
 __do_sys_rmdir fs/namei.c:3768 [inline]
 __se_sys_rmdir fs/namei.c:3766 [inline]
 __x64_sys_rmdir+0x36/0x40 fs/namei.c:3766
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff88803bf5d000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 920 bytes inside of
 2048-byte region [ffff88803bf5d000, ffff88803bf5d800)
The buggy address belongs to the page:
page:ffffea0000efd600 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 head:ffffea0000efd600 order:3 compound_mapcount:0
compound_pincount:0
flags: 0x100000000010200(slab|head)
raw: 0100000000010200 0000000000000000 0000000100000001 ffff88806c00e080
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88803bf5d280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803bf5d300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803bf5d380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88803bf5d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803bf5d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

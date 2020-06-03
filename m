Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B6D20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbCrGRwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFCUaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgFCUaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:30:04 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51716C08C5C0;
        Wed,  3 Jun 2020 13:30:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so2176392lfe.5;
        Wed, 03 Jun 2020 13:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=biRAcPstG0F9XpAl3Hv8FW3JDKuIScrFIinXePuxTag=;
        b=MbCrGRwP1OLWsGJzSuBBhqjn+X2eNHeZkr2JWPHepScxg4AXhkvxV/Y+cPGeEuhBg4
         qQw9bxiUPNWD1hMl2Cr+IjHs2cTy8louutG2Wn6HmWp/6PpLrCMlrPrJI67BGMmQ96JP
         uqdPzTJH9dHwDU4m3GDX8dvuhqNTCApJivMgQ30K2B+3fW+XKf2yQLswKnVwT+KD1va1
         790Xy3rkbJ6OPLXMyHiMq4tpMGFWBW1KKS/R29wHrTZa0V0RXCjMW/SmA3fj9UfsAWv7
         aLYmYw8zU6iYeB8e9qBsDseerI9b4lDSK36Rp2GmCo4pFSdDXdYzmG4f/JvUMXxo9lsG
         RPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=biRAcPstG0F9XpAl3Hv8FW3JDKuIScrFIinXePuxTag=;
        b=Jm1WYu1EgESrYvadTTFYYAPfUOWXm+roB6vnb2vRMboUl/XpVFsaRIDB1cPMBNwYjY
         lrF9XOssYeixdO6PEX3yfuQPLJ3aHbYNkUo5xuOOsmlyNAxxuv9GUcPfodY9xTTkPg3v
         Lxgg1U6ZaRPH8H1U/aLRc+ppQFXkXi8h7hZ//SJkEJeRO7urnsjNLav/autCBFgElXSv
         DwOxrexS6J0666+EV0h4Rr9HUMDhFC8dUA9TEcw65d+Cueqg+m3MevJ/uRBml8xL4EoP
         FOWd5P60AjS+mZpAf0ro1N1Sk3AWoENKul935c6rz4xHlUJFidl4Z0431i4k6N/W7xU+
         Leuw==
X-Gm-Message-State: AOAM532ktMOIcBynoiAdW8dLgFV8axcnV6q76bXuGmtI6MMPSvmr3AmA
        p+6JPWou2tQ66Y7bUbMiO/+eNM4zzWRPQqxQF88=
X-Google-Smtp-Source: ABdhPJyN3aWHGy0yvsIDasYKJzXBtsMqHZknjUMH1/av/ICGzzumlmBwIvy++Q3X8KdEklM01HZ2Kd6p+kPiSnfq1Wo=
X-Received: by 2002:ac2:485a:: with SMTP id 26mr639441lfy.57.1591216201712;
 Wed, 03 Jun 2020 13:30:01 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Wed, 3 Jun 2020 16:29:50 -0400
Message-ID: <CAEAjamttx6-9-uFr3whGRYK1pPH3ivWue3ROnbRpPdcS_rdbiA@mail.gmail.com>
Subject: KASAN: use-after-free Read in printer_ioctl
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

This bug happened when accessing a deallocated instance in printer_ioctl().

This seems to be in line with the following bug.

https://groups.google.com/forum/#!topic/syzkaller/U2SJOYi-S08

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3fd4/0x4180
kernel/locking/lockdep.c:3831
Read of size 8 at addr ffff8880683b0018 by task syz-executor.0/3377

CPU: 1 PID: 3377 Comm: syz-executor.0 Not tainted 5.6.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
 __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
 __lock_acquire+0x3fd4/0x4180 kernel/locking/lockdep.c:3831
 lock_acquire+0x127/0x350 kernel/locking/lockdep.c:4488
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x35/0x50 kernel/locking/spinlock.c:159
 printer_ioctl+0x4a/0x110 drivers/usb/gadget/function/f_printer.c:723
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0xfb/0x130 fs/ioctl.c:763
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4531a9
Code: ed 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 bb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd14ad72c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000073bfa8 RCX: 00000000004531a9
RDX: fffffffffffffff9 RSI: 000000000000009e RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bbd61
R13: 00000000004d0a98 R14: 00007fd14ad736d4 R15: 00000000ffffffff

Allocated by task 2393:
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

Freed by task 3368:
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

The buggy address belongs to the object at ffff8880683b0000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 24 bytes inside of
 1024-byte region [ffff8880683b0000, ffff8880683b0400)
The buggy address belongs to the page:
page:ffffea0001a0ec00 refcount:1 mapcount:0 mapping:ffff88806c00e300
index:0xffff8880683b1800 compound_mapcount: 0
flags: 0x100000000010200(slab|head)
raw: 0100000000010200 0000000000000000 0000000600000001 ffff88806c00e300
raw: ffff8880683b1800 000000008010000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880683aff00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff8880683aff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880683b0000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880683b0080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880683b0100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF44C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086CF206A5
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 04:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyDLaUNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFGEOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 00:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFGEOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 00:14:30 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1818BC08C5C2;
        Sat,  6 Jun 2020 21:14:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id i27so5484104ljb.12;
        Sat, 06 Jun 2020 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eaTeFkyuDXOVxv15IwoyOiM8maMfUDGW/xnRZ0uQoME=;
        b=GyDLaUNz4OlJ2o1MnAH3EtY3hGCtkJAzCITGxa88wzjbhJXimdmBpGTvAnDEgVJqOQ
         MV4Y0yz+bro0ia+AYNjOnBhyeK+EGmQXZrrZ7cXhZVQcOseVn0x1oJ+9dt6eyCgpSPJs
         I5ucpjPuzGQp0QURob7o6O0rmEBVj9aM/6Hr7DKBL7TGSf2gewYAXfqUPSXWSIkNq4hQ
         Uj8rIbDre9bUZ7l7JwxCXKEBAJRH73H80vmVc45yBBCdAWGSApHZ7ehMkghJfpVBs08o
         Y66NF2dLVyms9VWAp4KAAKSWEfb1CwegUzyG4eJwo9ggKCcNxWRLXOGYg/WRQoIgpS0u
         2HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eaTeFkyuDXOVxv15IwoyOiM8maMfUDGW/xnRZ0uQoME=;
        b=mbAxgyhxnSC/rX/LiCwD17ryjEg9Y17WIxAhQhUdmDiPy3QRn8TMOHgIevBqUp9Pdn
         cs4Z+mh6UwmmRY8cC3HiumUx4khF0tz20ZGzw5gWRH0Zgtz2T+qVRXpFVWwdK+H+7b+Q
         QaszMzLGuwldYSYU5uKc6oGEKV/hBprG16Iw+pdkDmoqMWcH93jfP0ZGnzKDQfcwtEo9
         2xGf+2CwDCuwUwViAZnmGSNlonLOD+RUC5mvC9gu263o4Nk2S1lqQAvPIK8VxL9LLQVc
         569YOYQZSbvZuqvb6LSjvj4CccFVGR9WpHiL8V1IrNAT+fp0UbvVnm0oWM6gvhexwN3p
         j/bw==
X-Gm-Message-State: AOAM5310D0ICVmxWdsjWKZQUBEbuiM9/KJi2gf3EpKR+jfD85bIfhgag
        MdFunhKTmPHGSzg2RatSI7WLZ6NURr7x8VwB7aE=
X-Google-Smtp-Source: ABdhPJwNfTLbd2G/czqOckU2Cfb2w4FhR4Eed7wqykdApRu/JEyS7dPgw0De8zC+yjF+kGJAzXSB+uRkh/zmm2IRhCU=
X-Received: by 2002:a2e:8115:: with SMTP id d21mr8485591ljg.167.1591503267486;
 Sat, 06 Jun 2020 21:14:27 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sun, 7 Jun 2020 00:14:16 -0400
Message-ID: <CAEAjamuqGS3wLowBxuZoDPo5DeM84Adf=jvrb61x9CcRVNFxpQ@mail.gmail.com>
Subject: KASAN: null-ptr-deref Read in tty_wakeup
To:     Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
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

This bug happened during enumeration (i.e., set_config) for an acm gadget.

Although tty (instance of tty_struct) held by port->port in
gs_start_io() is null,
this tries to access its field (tty->flags) in tty_wakeup(), thereby
triggering this error.

kernel config: https://kt0755.github.io/etc/config_v5.6.11

==================================================================
BUG: KASAN: null-ptr-deref in test_bit
include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
BUG: KASAN: null-ptr-deref in tty_wakeup+0x25/0x110 drivers/tty/tty_io.c:532
Read of size 8 at addr 0000000000000460 by task systemd-udevd/2719

CPU: 2 PID: 2719 Comm: systemd-udevd Not tainted 5.6.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 __kasan_report+0x161/0x1b0 mm/kasan/report.c:510
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x152/0x1b0 mm/kasan/generic.c:192
 __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
 test_bit include/asm-generic/bitops/instrumented-non-atomic.h:110 [inline]
 tty_wakeup+0x25/0x110 drivers/tty/tty_io.c:532
 gs_start_io+0x1b7/0x2a0 drivers/usb/gadget/function/u_serial.c:568
 gserial_connect+0x41c/0x590 drivers/usb/gadget/function/u_serial.c:1333
 acm_set_alt+0x251/0x5c0 drivers/usb/gadget/function/f_acm.c:456
 set_config drivers/usb/gadget/composite.c:838 [inline]
 composite_setup+0x4231/0x6f10 drivers/usb/gadget/composite.c:1717
 configfs_composite_setup+0x11a/0x170 drivers/usb/gadget/configfs.c:1466
 dummy_timer+0xda5/0x33f0 drivers/usb/gadget/udc/dummy_hcd.c:1898
 call_timer_fn+0x20e/0x770 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 run_timer_softirq+0x63f/0x13c0 kernel/time/timer.c:1786
 __do_softirq+0x262/0xb46 kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x161/0x1b0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x137/0x500 arch/x86/kernel/apic/apic.c:1146
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:create_object+0x74c/0xba0 mm/kmemleak.c:607
Code: e9 44 fc ff ff 65 48 8b 04 25 00 0f 02 00 48 8d b8 90 04 00 00
48 ba 00 00 00 00 00 fc ff df 48 89 fe 48 c1 ee 03 0f b6 14 16 <84> d2
74 09 80 fa 03 0f 8e be 01 00 00 49 8d bf 50 01 00 00 8b 90
RSP: 0018:ffff88805ad17560 EFLAGS: 00000a02 ORIG_RAX: ffffffffffffff13
RAX: ffff88803b448000 RBX: 0000000000000120 RCX: ffffffff816e25c4
RDX: 0000000000000000 RSI: 1ffff11007689092 RDI: ffff88803b448490
RBP: ffff88805ad175b0 R08: ffffed100c9a128e R09: ffffed100c9a128e
R10: 0000000000000001 R11: ffffed100c9a128d R12: ffff888057bb8160
R13: ffff888064d09420 R14: ffff888064d09534 R15: ffff888064d093e0
 kmemleak_alloc+0x21/0x30 mm/kmemleak.c:893
 kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc_node mm/slub.c:2786 [inline]
 slab_alloc mm/slub.c:2794 [inline]
 kmem_cache_alloc+0x157/0x2d0 mm/slub.c:2799
 __d_alloc+0x2e/0x8b0 fs/dcache.c:1690
 d_alloc+0x4d/0x250 fs/dcache.c:1769
 d_alloc_parallel+0xfe/0x1910 fs/dcache.c:2521
 __lookup_slow+0x195/0x440 fs/namei.c:1742
 lookup_slow fs/namei.c:1774 [inline]
 walk_component+0x779/0xe30 fs/namei.c:1915
 lookup_last fs/namei.c:2391 [inline]
 path_lookupat+0x151/0x3e0 fs/namei.c:2436
 filename_lookup+0x191/0x3a0 fs/namei.c:2466
 user_path_at_empty+0x40/0x50 fs/namei.c:2746
 user_path_at include/linux/namei.h:58 [inline]
 vfs_statx+0xe9/0x190 fs/stat.c:197
 vfs_lstat include/linux/fs.h:3277 [inline]
 __do_sys_newlstat+0x87/0xf0 fs/stat.c:364
 __se_sys_newlstat fs/stat.c:358 [inline]
 __x64_sys_newlstat+0x54/0x80 fs/stat.c:358
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f473bb9f335
Code: 69 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00
83 ff 01 48 89 f0 77 30 48 89 c7 48 89 d6 b8 06 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 03 f3 c3 90 48 8b 15 31 db 2b 00 f7 d8 64 89
RSP: 002b:00007ffc79ada6f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000006
RAX: ffffffffffffffda RBX: 000055d54f102c1a RCX: 00007f473bb9f335
RDX: 00007ffc79ada7b0 RSI: 00007ffc79ada7b0 RDI: 00007ffc79ada700
RBP: 00007ffc79ada880 R08: 000000000000fc00 R09: 0000000000000000
R10: 0000000000000007 R11: 0000000000000246 R12: 00007ffc79ada890
R13: 00007ffc79ada788 R14: 0000000000000018 R15: 000055d54f846470
==================================================================

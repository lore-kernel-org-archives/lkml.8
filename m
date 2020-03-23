Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5213C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618C7206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6CGikb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCWVuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:50:50 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44978 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:50:50 -0400
Received: by mail-lf1-f65.google.com with SMTP id j188so7670273lfj.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awriAJ/UGkX1bKms0hcVq3QXUUYcggmI13L6OZOIT1s=;
        b=A6CGikb4ixy0N3jxLh3sfml+5zyNO87lU4R3AdcHtQE1KNSuc1SHLC64dFbSEJ6vRq
         9u8CyzmMeXLuAwXMbt3yhvtxB49wFRU506BFeJDByrFhb4uqo+abwYPFVxLyLVimL2Eg
         rzWxTjseHctZhw+qBvohQ1bj/FW63IsSuOBIysS1dRldhnyi0fGRiy57T7nZ+0IdMt+g
         ar0+04o/T7n0y8jY3+nUdepcvaQYgttgYbWtGyqEMJVS3iEArs930+UFkgOY84k5LPo+
         1QBTDl5ELtzfmwaqOY1W/NAbxsiAtknQYYqeOi1bnd0xamiJsVoYd/GKj0gJBXceiYZG
         T7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awriAJ/UGkX1bKms0hcVq3QXUUYcggmI13L6OZOIT1s=;
        b=N56XcsOZYtLccLUx3XPQVj6oOZvDf+abYz5GanR24i3Oq6rOeH/9nt+qHxxD2RLO87
         YAaq242fzL1oTh87MuOz8b1kvqgAS63CoOJRWudNHhCltm9fj9xrwmU70B8XvI79FqIv
         F8F03pB9BwH7jEWALPYSarFNuyhLq1pl3KzSodMCtNCD1ADJfm3VbcZImez1XL5O9hbx
         z20JOaGV1hEXmaHdrm760ndH3MGIA5VkSp18An1d1kYRpsd7MjOf59emR3qKzeSLcoJ+
         fgx2KuTwbZW/YRm7NAMFXnMXMpEaDsEzsU0KJXVjQ7gI2vHqiMT4LwCzO7W+zt5q2FNN
         zcKQ==
X-Gm-Message-State: ANhLgQ3x+/gZo0Wm94eqT+AmM/sHC1zWSV/tH46QcgaXCUpmj0BjMpQF
        B0ijsNPXy2i+7ShZoE2m6X6cHYD8ocInr29ilL8=
X-Google-Smtp-Source: ADFU+vtTD8SNHt7dSkUqOeNL/r2ikQNu0FCpR39WcthBYWH/eeVJal7JgUg09kng4S6SEt54VrJMGAdxR2e+DoWWeKA=
X-Received: by 2002:ac2:4352:: with SMTP id o18mr10618183lfl.81.1585000246670;
 Mon, 23 Mar 2020 14:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAEAjamtb2Kbn0He5O++=d_HCG1eQvLnGGbcVUOQ76+NfDiNybQ@mail.gmail.com>
 <CAAeHK+zy+seoWm7avxGSEXwoR1tuqHyO00eA_SWk3CC-ngbmLQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zy+seoWm7avxGSEXwoR1tuqHyO00eA_SWk3CC-ngbmLQ@mail.gmail.com>
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Mon, 23 Mar 2020 17:50:35 -0400
Message-ID: <CAEAjamvxCQ9xgjw3Rqe-uJJuPfNLJ30+9U+wbWamCcSCwhh9bg@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in usb_hcd_unlink_urb+0x5f/0x170 drivers/usb/core/hcd.c
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, laurentiu.tudor@nxp.com,
        noring@nocrew.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        tony@atomide.com, rrangel@chromium.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dave Tian <dave.jing.tian@gmail.com>, linux-usb@vger.kernel.og,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:45:17PM +0100, Andrey Konovalov wrote:
> On Mon, Mar 23, 2020 at 7:16 AM Kyungtae Kim <kt0755@gmail.com> wrote:
> >
> > We report a bug (in linux-5.5.11) found by FuzzUSB (a modified version
> > of syzkaller)
>
> Hi Kyungtae,
>
> Sounds interesting! Could you share what approach to USB fuzzing you
> have taken? Based on the stack trace I see you're fuzzing the USB
> storage layer, for which we don't yet have any descriptions in
> syzkaller's USB fuzzer itself [1].
>
> Thanks!
>
> [1] https://github.com/google/syzkaller/blob/master/docs/linux/external_fuzzing_usb.md
>
> >
> > In function usb_hcd_unlink_urb (driver/usb/core/hcd.c:1607), it tries to
> > read "urb->use_count". But it seems the instance "urb" was
> > already freed (right after urb->dev at line 1597) by the function "urb_destroy"
> > in a different thread, which caused memory access violation.
> > To solve, it may need to check if urb is valid before urb->use_count,
> > to avoid such freed memory access.
> >
> > kernel config: https://kt0755.github.io/etc/config_v5.5.11
> >
> > ==================================================================
> > BUG: KASAN: use-after-free in atomic_read
> > include/asm-generic/atomic-instrumented.h:26 [inline]
> > BUG: KASAN: use-after-free in usb_hcd_unlink_urb+0x5f/0x170
> > drivers/usb/core/hcd.c:1607
> > Read of size 4 at addr ffff888065379610 by task kworker/u4:1/27
> >
> > CPU: 1 PID: 27 Comm: kworker/u4:1 Not tainted 5.5.11 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > 1.10.2-1ubuntu1 04/01/2014
> > Workqueue: scsi_tmf_2 scmd_eh_abort_handler
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0xce/0x128 lib/dump_stack.c:118
> >  print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
> >  __kasan_report+0x153/0x1cb mm/kasan/report.c:506
> >  kasan_report+0x12/0x20 mm/kasan/common.c:639
> >  check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >  check_memory_region+0x152/0x1b0 mm/kasan/generic.c:192
> >  __kasan_check_read+0x11/0x20 mm/kasan/common.c:95
> >  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
> >  usb_hcd_unlink_urb+0x5f/0x170 drivers/usb/core/hcd.c:1607
> >  usb_unlink_urb+0x72/0xb0 drivers/usb/core/urb.c:657
> >  usb_sg_cancel+0x14e/0x290 drivers/usb/core/message.c:602
> >  usb_stor_stop_transport+0x5e/0xa0 drivers/usb/storage/transport.c:937
> >  command_abort+0x19d/0x200 drivers/usb/storage/scsiglue.c:439
> >  scsi_try_to_abort_cmd drivers/scsi/scsi_error.c:927 [inline]
> >  scmd_eh_abort_handler+0x18e/0x410 drivers/scsi/scsi_error.c:145
> >  process_one_work+0x9dd/0x1710 kernel/workqueue.c:2266
> >  worker_thread+0x8b/0xc40 kernel/workqueue.c:2412
> >  kthread+0x35f/0x440 kernel/kthread.c:255
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > Allocated by task 2532:
> >  save_stack+0x21/0x90 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:513
> >  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
> >  __kmalloc+0x148/0x380 mm/slub.c:3812
> >  kmalloc include/linux/slab.h:561 [inline]
> >  usb_alloc_urb+0x42/0x90 drivers/usb/core/urb.c:74
> >  usb_sg_init+0x323/0xa00 drivers/usb/core/message.c:406
> >  usb_stor_bulk_transfer_sglist+0xbe/0x280 drivers/usb/storage/transport.c:423
> >  usb_stor_bulk_srb+0x10d/0x230 drivers/usb/storage/transport.c:465
> >  usb_stor_Bulk_transport+0x55f/0x1060 drivers/usb/storage/transport.c:1161
> >  usb_stor_invoke_transport+0xef/0x15f0 drivers/usb/storage/transport.c:606
> >  usb_stor_transparent_scsi_command+0x1d/0x30 drivers/usb/storage/protocol.c:108
> >  usb_stor_control_thread+0x6d8/0xa80 drivers/usb/storage/usb.c:380
> >  kthread+0x35f/0x440 kernel/kthread.c:255
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > Freed by task 2532:
> >  save_stack+0x21/0x90 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  kasan_set_free_info mm/kasan/common.c:335 [inline]
> >  __kasan_slab_free+0x135/0x190 mm/kasan/common.c:474
> >  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
> >  slab_free_hook mm/slub.c:1425 [inline]
> >  slab_free_freelist_hook mm/slub.c:1458 [inline]
> >  slab_free mm/slub.c:3005 [inline]
> >  kfree+0xf7/0x410 mm/slub.c:3966
> >  urb_destroy drivers/usb/core/urb.c:26 [inline]
> >  kref_put include/linux/kref.h:65 [inline]
> >  usb_free_urb.part.0+0x95/0x100 drivers/usb/core/urb.c:96
> >  usb_free_urb+0x1f/0x30 drivers/usb/core/urb.c:95
> >  sg_clean+0x111/0x270 drivers/usb/core/message.c:263
> >  usb_sg_wait+0x26d/0x440 drivers/usb/core/message.c:573
> >  usb_stor_bulk_transfer_sglist+0x127/0x280 drivers/usb/storage/transport.c:447
> >  usb_stor_bulk_srb+0x10d/0x230 drivers/usb/storage/transport.c:465
> >  usb_stor_Bulk_transport+0x55f/0x1060 drivers/usb/storage/transport.c:1161
> >  usb_stor_invoke_transport+0xef/0x15f0 drivers/usb/storage/transport.c:606
> >  usb_stor_transparent_scsi_command+0x1d/0x30 drivers/usb/storage/protocol.c:108
> >  usb_stor_control_thread+0x6d8/0xa80 drivers/usb/storage/usb.c:380
> >  kthread+0x35f/0x440 kernel/kthread.c:255
> >  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> >
> > The buggy address belongs to the object at ffff888065379600
> >  which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 16 bytes inside of
> >  192-byte region [ffff888065379600, ffff8880653796c0)
> > The buggy address belongs to the page:
> > page:ffffea000194de40 refcount:1 mapcount:0 mapping:ffff88806c002a00 index:0x0
> > flags: 0x100000000000200(slab)
> > raw: 0100000000000200 ffffea0000ee7a00 0000000500000005 ffff88806c002a00
> > raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff888065379500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff888065379580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> > >ffff888065379600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                          ^
> >  ffff888065379680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >  ffff888065379700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/CAEAjamtb2Kbn0He5O%2B%2B%3Dd_HCG1eQvLnGGbcVUOQ76%2BNfDiNybQ%40mail.gmail.com.

Thanks a lot for your interest. We are still improving, so right now
we cannot share too much details,
but we are actually trying to test in several different ways without
kernel modification.

Regards,
Kyungtae Kim

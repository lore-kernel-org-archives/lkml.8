Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385CC20842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="durAhwam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgHDRhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729061AbgHDRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:37:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01A9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 10:37:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so39195492qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcA1zUeCATKqXdJegOq7HPw1uI9nbBDamp5TR69krwE=;
        b=durAhwamCPxp9YvVxhkfK4oToay9MDFhV0RQ6bHJZ8j2KZBaOEJx76SI9jszcbclvx
         4bupLxlPx/Ym0RD1s90u8DW/l7TWtNxC5vZCxBxPWGsqus1jVphlEFl+8AzbzQT2Rug0
         vjKTWnG0S+sRGDVgorGSvfP3k9A8NKFku/FH7Uw4HxBZAIJ5M0b2W2YZsaMlhEfyMjh+
         g+vLv4JWjR5Bfl9Sj5RmYhMEgsXNDd02QoWTn3BWn4KX2EqxJ6MQOwH1K6JykcbTqE3G
         XXehZNq2Ce0U7+8hI67wQyctPTZPUqODRm5hn4jFVCnU8CN+BTK1RoImw9fDn8U5FLrv
         mn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcA1zUeCATKqXdJegOq7HPw1uI9nbBDamp5TR69krwE=;
        b=qFfRCF3qcept2qg10KjbcxnrnWkT4VI+OJfw3cFHgo8tru60PU18shIbXAcSZy36Za
         7FSaOSDg2j4orMYRkv4nTcZ/X7cQhb72niTcvpym7zkL09qVYZRiZJ5HloBLz2IkmG43
         kMuSbzyyYU6Lf/XutUqy1iFw7Wcrxi4S+VWZo+mFVfMuQhNbuxbZwJso86GCtogsC72z
         IRH1/Nzeffy5fs4uhijQlTtwZqEXgRM41R/+FPh0dkYHa3p4iDqv/yu9UGfUIH4KWEEY
         8jrnOGxF/zgAyVDyWcMjYkdmTScMiB3xVWMSSQB/rPoRL0ooul2CjlRuGWlCmvaZe4Sf
         urLg==
X-Gm-Message-State: AOAM530F0RDDoKm8BVdCS7sNSMZfZa2QlyXgvenKpNyViNdaUanIvG65
        aDM5kxB4GwORQNixqv5jMWlmysMYCxZDgRbtU8GzKQTUDzQ=
X-Google-Smtp-Source: ABdhPJyHMwcd5qtQjassdMQoXgKwyPVfrw5FnW725HCxTp+YslNg7WqcNTonbB9sJbU5WJ3JLOYMl/AQSJX3bVbtaOs=
X-Received: by 2002:a37:b6c5:: with SMTP id g188mr20838757qkf.1.1596562632474;
 Tue, 04 Aug 2020 10:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com> <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com> <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com> <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
 <20200804142250.GA247448@kroah.com> <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
 <20200804164246.GA502540@kroah.com>
In-Reply-To: <20200804164246.GA502540@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 4 Aug 2020 14:37:01 -0300
Message-ID: <CAFmMkTERJ+21wx8wU93xNm2z6ndvLppym4MpmgqnrrCdAANrEg@mail.gmail.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 04, 2020 at 11:37:02AM -0300, Daniel Gutson wrote:
> > static void mypci_remove(struct pci_dev *pdev)
> > {
> >         /*
> >     I tried enabling and disabling this
> >         if (child_device != NULL) {
> >                 put_device(child_device);
> >                 device_unregister(child_device);
> >         }
> >         */
>
> You can just call device_destroy() here, but this should be the same.

There's a key difference:

void device_destroy(struct class *class, dev_t devt)
{
    struct device *dev;

    dev = class_find_device_by_devt(class, devt);
    if (dev) {
        put_device(dev);
        device_unregister(dev);
    }
}

It won't work because it receives a dev_t, which in my case is 0,0 and
won't find it.

>
> But, if you have it commented out, that's not good, you have to clean
> this up.
>
> >         class_remove_file(&my_class, &class_attr_howareyou);
>
> You don't always have to remove files you create, but it doesn't hurt.
>
> >         class_unregister(&my_class);
>
> class_destroy()?  But this is the same as well, so all is good.
>
> Try running without the above code commented out.

kaboom :) Seems the reference counting went negative

[  514.412418] kernfs: can not remove 'uevent', no directory
[  514.412425] WARNING: CPU: 6 PID: 6203 at fs/kernfs/dir.c:1507
kernfs_remove_by_name_ns+0x8a/0xa0
[  514.412425] Modules linked in: firmware_security_class(OE-) xxx
[  514.412458] CPU: 6 PID: 6203 Comm: rmmod Tainted: G           OE
 5.8.0+ #1
[  514.412458] Hardware name: xxx
[  514.412459] RIP: 0010:kernfs_remove_by_name_ns+0x8a/0xa0
[  514.412460] Code: 00 31 c0 41 5c 41 5d 41 5e 5d c3 48 c7 c7 80 14
93 b1 e8 19 b0 77 00 b8 fe ff ff ff eb e5 48 c7 c7 f8 56 5d b1 e8 3b
ca ce ff <0f> 0b b8 fe ff ff ff eb d0 66 66 2e 0f 1f 84 00 00 00 00 00
66 90
[  514.412460] RSP: 0018:ffffbedac1a43d48 EFLAGS: 00010286
[  514.412461] RAX: 0000000000000000 RBX: ffffa081de519c00 RCX: 0000000000000027
[  514.412461] RDX: 0000000000000027 RSI: 0000000000000082 RDI: ffffa0823d798cc8
[  514.412462] RBP: ffffbedac1a43d60 R08: 000000000000050e R09: 0000000000000004
[  514.412462] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa082384650b0
[  514.412462] R13: ffffffffb15f9575 R14: dead000000000122 R15: dead000000000100
[  514.412463] FS:  00007f912a4f6540(0000) GS:ffffa0823d780000(0000)
knlGS:0000000000000000
[  514.412464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  514.412464] CR2: 0000559b849611b8 CR3: 000000080650e001 CR4: 00000000003606e0
[  514.412464] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  514.412465] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  514.412465] Call Trace:
[  514.412468]  sysfs_remove_file_ns+0x15/0x20
[  514.412470]  device_del+0x164/0x3e0
[  514.412472]  device_unregister+0x1b/0x60
[  514.412473]  mypci_remove+0x26/0x50 [firmware_security_class]
[  514.412475]  pci_device_remove+0x3e/0xb0
[  514.412476]  device_release_driver_internal+0xf0/0x1c0
[  514.412477]  driver_detach+0x4c/0x8f
[  514.412477]  bus_remove_driver+0x5c/0xd0
[  514.412478]  driver_unregister+0x31/0x50
[  514.412479]  pci_unregister_driver+0x40/0x90
[  514.412480]  my_pci_driver_exit+0x10/0xe80 [firmware_security_class]
[  514.412482]  __x64_sys_delete_module+0x146/0x2a0
[  514.412483]  ? __syscall_return_slowpath+0x31/0x160
[  514.412485]  do_syscall_64+0x52/0xc0
[  514.412486]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  514.412487] RIP: 0033:0x7f912a642a3b
[  514.412488] Code: 73 01 c3 48 8b 0d 55 84 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 84 0c 00 f7 d8 64 89
01 48
[  514.412489] RSP: 002b:00007ffc3e5c6b58 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  514.412489] RAX: ffffffffffffffda RBX: 0000559b84956770 RCX: 00007f912a642a3b
[  514.412490] RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559b849567d8
[  514.412490] RBP: 00007ffc3e5c6bb8 R08: 0000000000000000 R09: 0000000000000000
[  514.412491] R10: 00007f912a6beac0 R11: 0000000000000206 R12: 00007ffc3e5c6d90
[  514.412491] R13: 00007ffc3e5c77ba R14: 0000559b849562a0 R15: 0000559b84956770
[  514.412492] ---[ end trace 6c3ef2924fc0afa7 ]---
[  514.412492] ------------[ cut here ]------------
[  514.412493] kernfs: can not remove 'online', no directory
[  514.412496] WARNING: CPU: 6 PID: 6203 at fs/kernfs/dir.c:1507
kernfs_remove_by_name_ns+0x8a/0xa0
[  514.412496] Modules linked in: firmware_security_class(OE-) xxx
[  514.412513] CPU: 6 PID: 6203 Comm: rmmod Tainted: G        W  OE
 5.8.0+ #1
[  514.412513] Hardware name: xxx
[  514.412513] RIP: 0010:kernfs_remove_by_name_ns+0x8a/0xa0
[  514.412514] Code: 00 31 c0 41 5c 41 5d 41 5e 5d c3 48 c7 c7 80 14
93 b1 e8 19 b0 77 00 b8 fe ff ff ff eb e5 48 c7 c7 f8 56 5d b1 e8 3b
ca ce ff <0f> 0b b8 fe ff ff ff eb d0 66 66 2e 0f 1f 84 00 00 00 00 00
66 90
[  514.412514] RSP: 0018:ffffbedac1a43d20 EFLAGS: 00010282
[  514.412515] RAX: 0000000000000000 RBX: ffffffffc0c83120 RCX: 0000000000000027
[  514.412515] RDX: 0000000000000027 RSI: 0000000000000092 RDI: ffffa0823d798cc8
[  514.412516] RBP: ffffbedac1a43d38 R08: 000000000000053b R09: 0000000000000004
[  514.412516] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa081de519c00
[  514.412516] R13: ffffffffb16650b8 R14: dead000000000122 R15: dead000000000100
[  514.412517] FS:  00007f912a4f6540(0000) GS:ffffa0823d780000(0000)
knlGS:0000000000000000
[  514.412517] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  514.412518] CR2: 0000559b849611b8 CR3: 000000080650e001 CR4: 00000000003606e0
[  514.412518] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  514.412519] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  514.412519] Call Trace:
[  514.412520]  sysfs_remove_file_ns+0x15/0x20
[  514.412521]  device_remove_attrs+0x2f/0x70
[  514.412521]  device_del+0x173/0x3e0
[  514.412523]  device_unregister+0x1b/0x60
[  514.412523]  mypci_remove+0x26/0x50 [firmware_security_class]
[  514.412524]  pci_device_remove+0x3e/0xb0
[  514.412525]  device_release_driver_internal+0xf0/0x1c0
[  514.412526]  driver_detach+0x4c/0x8f
[  514.412526]  bus_remove_driver+0x5c/0xd0
[  514.412527]  driver_unregister+0x31/0x50
[  514.412528]  pci_unregister_driver+0x40/0x90
[  514.412529]  my_pci_driver_exit+0x10/0xe80 [firmware_security_class]
[  514.412530]  __x64_sys_delete_module+0x146/0x2a0
[  514.412531]  ? __syscall_return_slowpath+0x31/0x160
[  514.412532]  do_syscall_64+0x52/0xc0
[  514.412533]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  514.412533] RIP: 0033:0x7f912a642a3b
[  514.412534] Code: 73 01 c3 48 8b 0d 55 84 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 84 0c 00 f7 d8 64 89
01 48
[  514.412534] RSP: 002b:00007ffc3e5c6b58 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  514.412535] RAX: ffffffffffffffda RBX: 0000559b84956770 RCX: 00007f912a642a3b
[  514.412535] RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559b849567d8
[  514.412535] RBP: 00007ffc3e5c6bb8 R08: 0000000000000000 R09: 0000000000000000
[  514.412536] R10: 00007f912a6beac0 R11: 0000000000000206 R12: 00007ffc3e5c6d90
[  514.412536] R13: 00007ffc3e5c77ba R14: 0000559b849562a0 R15: 0000559b84956770
[  514.412537] ---[ end trace 6c3ef2924fc0afa8 ]---
[  514.412543] ------------[ cut here ]------------
[  514.412543] refcount_t: underflow; use-after-free.
[  514.412548] WARNING: CPU: 6 PID: 6203 at lib/refcount.c:28
refcount_warn_saturate+0xae/0xf0
[  514.412548] Modules linked in: firmware_security_class(OE-) xxx
[  514.412564] CPU: 6 PID: 6203 Comm: rmmod Tainted: G        W  OE
 5.8.0+ #1
[  514.412565] Hardware name: xxx
[  514.412566] RIP: 0010:refcount_warn_saturate+0xae/0xf0
[  514.412566] Code: 65 0c 2d 01 01 e8 77 0a b4 ff 0f 0b 5d c3 80 3d
52 0c 2d 01 00 75 91 48 c7 c7 40 6b 5f b1 c6 05 42 0c 2d 01 01 e8 57
0a b4 ff <0f> 0b 5d c3 80 3d 30 0c 2d 01 00 0f 85 6d ff ff ff 48 c7 c7
98 6b
[  514.412566] RSP: 0018:ffffbedac1a43d90 EFLAGS: 00010286
[  514.412567] RAX: 0000000000000000 RBX: ffffa08238465000 RCX: 0000000000000027
[  514.412567] RDX: 0000000000000027 RSI: 0000000000000096 RDI: ffffa0823d798cc8
[  514.412568] RBP: ffffbedac1a43d90 R08: 0000000000000569 R09: 0000000000000004
[  514.412568] R10: 0000000000000000 R11: 0000000000000001 R12: ffffa081de519c00
[  514.412568] R13: ffffffffc0c83000 R14: dead000000000122 R15: dead000000000100
[  514.412569] FS:  00007f912a4f6540(0000) GS:ffffa0823d780000(0000)
knlGS:0000000000000000
[  514.412569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  514.412570] CR2: 0000559b849611b8 CR3: 000000080650e001 CR4: 00000000003606e0
[  514.412570] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  514.412570] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  514.412571] Call Trace:
[  514.412572]  kobject_put+0xf1/0x190
[  514.412573]  device_unregister+0x28/0x60
[  514.412574]  mypci_remove+0x26/0x50 [firmware_security_class]
[  514.412575]  pci_device_remove+0x3e/0xb0
[  514.412576]  device_release_driver_internal+0xf0/0x1c0
[  514.412577]  driver_detach+0x4c/0x8f
[  514.412577]  bus_remove_driver+0x5c/0xd0
[  514.412578]  driver_unregister+0x31/0x50
[  514.412579]  pci_unregister_driver+0x40/0x90
[  514.412580]  my_pci_driver_exit+0x10/0xe80 [firmware_security_class]
[  514.412581]  __x64_sys_delete_module+0x146/0x2a0
[  514.412582]  ? __syscall_return_slowpath+0x31/0x160
[  514.412583]  do_syscall_64+0x52/0xc0
[  514.412584]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  514.412584] RIP: 0033:0x7f912a642a3b
[  514.412585] Code: 73 01 c3 48 8b 0d 55 84 0c 00 f7 d8 64 89 01 48
83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 25 84 0c 00 f7 d8 64 89
01 48
[  514.412585] RSP: 002b:00007ffc3e5c6b58 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  514.412586] RAX: ffffffffffffffda RBX: 0000559b84956770 RCX: 00007f912a642a3b
[  514.412586] RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000559b849567d8
[  514.412586] RBP: 00007ffc3e5c6bb8 R08: 0000000000000000 R09: 0000000000000000
[  514.412587] R10: 00007f912a6beac0 R11: 0000000000000206 R12: 00007ffc3e5c6d90
[  514.412587] R13: 00007ffc3e5c77ba R14: 0000559b849562a0 R15: 0000559b84956770
[  514.412588] ---[ end trace 6c3ef2924fc0afa9 ]---



>
> greg k-h



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport

Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35A192086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="NTCvSZf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgHDPFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHDPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:05:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A42C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 08:05:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so34542118qkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaNTJSyMb59EJaY4fr5r+Cx0iWCtId5fOe3WWFeAiAg=;
        b=NTCvSZf1KvClLCqlNEqpSP6HMqm46P127iQJjUYDIsd6CilMHnB2N3QbhWl/PnUeJd
         fOzUw3jjXdqG6ol4CB496/a2X8JzdwF4oxp3iVcE56nS8YvJjnZ6EgDpSURWM2S6Hxw5
         KMC4fgdMDBJKf7ICfChJ+4Ltg+JAzeg2GPFaJgjelIfHOhz4y/I9HMRWoPEm/qI0Adbl
         LbK1m31IyT4OEn310K42VbBTNOmv7fpy7fcfGDHFA1oYsUcpFW86tQIAgyPY7BSaIk6L
         GumkZ4zNidSOyJ+BeBUdl0rxWLHHgMiOtbAFVn7rEddI2s+godsSrsczvTXiywE2Lj7C
         9Xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaNTJSyMb59EJaY4fr5r+Cx0iWCtId5fOe3WWFeAiAg=;
        b=PgXI96tptpulfYXxdkwABV5oRIK/co+r+9Y0dgAd9ixn7aKGBKyPht9xH7gh1vT3lq
         QejDQOBzzvdd/rLemAYMLpNTQO9d8iRG7BX7ryvSOzszJZd1hacH/2MFUUNtCD0+w6k8
         lSdYq8ModKlvn4ZuSSCPnm7vlLbg/Pnacm+PG0/816Uu+tojBwR6oWS5rWioa1tdosCF
         YHBYRtunR/tr/joecjHGlBXy9/BEYqe+G6qjxloUqiBFGyG6oFINC1LN2pAE+0E5C+rH
         7PHNYlTbUmjkA34m/yOnF93SK5J76uv0lZya9W8kjsSM9a80Hae0EamXHm1YbrSS/KOs
         EDvw==
X-Gm-Message-State: AOAM531S3KQY9oqoSGEyFpFcGXFF2udj6nm/HWBUgGwnlQ+a6p4bFZJN
        K1UOVrT9jFqHbsOfnU2N4LoapGGlO8NT3oR50g003ewo8v8=
X-Google-Smtp-Source: ABdhPJy8GArFS5avstH0pHUnWcQSX3pClFyD1W0Pyr3fn+5A6ma7DFhftQ0Fzwr4VGGxLpQ6F49/Di6AJNChJR6Kqm0=
X-Received: by 2002:a37:278d:: with SMTP id n135mr20963987qkn.486.1596553536937;
 Tue, 04 Aug 2020 08:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com> <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com> <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com> <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
 <20200804142250.GA247448@kroah.com> <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
 <20200804144414.GA50022@kroah.com>
In-Reply-To: <20200804144414.GA50022@kroah.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Tue, 4 Aug 2020 12:05:25 -0300
Message-ID: <CAFmMkTG342Thq+H-om+3mCog5Yh3ZzqO_HYnR-Jv-b1utojk0g@mail.gmail.com>
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

On Tue, Aug 4, 2020 at 11:43 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 04, 2020 at 11:37:02AM -0300, Daniel Gutson wrote:
> > On Tue, Aug 4, 2020 at 11:23 AM Greg Kroah-Hartman <
> > gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 10:50:13AM -0300, Daniel Gutson wrote:
> > > > On Tue, Aug 4, 2020 at 3:41 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Aug 03, 2020 at 07:04:56PM -0300, Daniel Gutson wrote:
> > > > > > > > > Think of this as an input device.  You don't put the random
> > input
> > > > > > > > > attributes all in one place, you create a new device that
> > represents the
> > > > > > > > > input interface and register that.
> > > > > >
> > > > > > I'm having trouble with this. What's the dev_t for the child
> > devices?
> > > > > > I'm doing
> > > > > >     child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > > > > > NULL, "child");
> > > > > > pdev is the pci_device (intel-spi-pci)
> > > > > > dmesg shows
> > > > > >
> > > > > >     sysfs: cannot create duplicate filename '/class/my-class'
> > > > > >     (call trace)
> > > > > >     kobject_add_internal failed for my-class with -EEXIST, don't try
> > > > > > to register things with the same name in the same directory.
> > > > >
> > > > > Without seeing all of your code, I can't tell you what you are doing
> > > > > wrong, but the kernel should be giving you a huge hint here...
> > > > >
> > > > > Don't create duplicate names in the same subdirectory.
> > > >
> > > > I'm not doing that. One of my questions is if MKDEV(0, 0) is valid for
> > > > create_device, which I inferred so from the documentation.
> > >
> > > Yes it is, but that's not the error given to you :)
> > >
> > > Many in-kernel users call device_create() with MKDEV(0, 0)
> > >
> > > > Here is the listing
> > >
> > > <snip>
> > >
> > > It's not in any format to read, please never strip leading whitespace,
> > > it hurts my brain...
> >
> > (trying again)
> > Also, this is in pastebin:  https://pastebin.com/8Ye9eUm5
> >
> > #include <linux/kobject.h>
> > #include <linux/sysfs.h>
> > #include <linux/module.h>
> > #include <linux/init.h>
> > #include <linux/list.h>
> > #include <linux/slab.h>
> > #include <linux/device.h>
> > #include <linux/pci.h>
> >
> > static ssize_t howareyou_show(struct class *class, struct class_attribute
> > *attr,
> >    char *buf)
> > {
> >         return sprintf(buf, "%s\n", "How are you?");
> > }
> > static CLASS_ATTR_RO(howareyou);
>
> These are rare, as they are "global" for a class, are you sure you want
> that?

I'm no longer using class attributes, this is from my previous
experiment. Sorry for the confusion.
In the "real" code I'll use DEVICE_ATTR_RO.

>
> >
> > static struct class my_class = {
> >         .name =         "my-class",
> >         .owner =        THIS_MODULE,
> > };
> >
> > struct device* child_device;
> >
> > static int mypci_probe(struct pci_dev *pdev,
> >       const struct pci_device_id *id)
> > {
> >         int ret;
> >
> >         ret = pcim_enable_device(pdev);
> >         if (ret)
> >                 return ret;
> >
> >         ret = class_register(&my_class);
> >         if (ret < 0)
> >                 return ret;
> >
> >
> >         pr_info("DFG: Recognized. DID: %lx\n", (unsigned long
> > int)id->driver_data);
> >         pr_info("DFG: device DID: %lx\n", (unsigned long int)pdev->device);
> >
> >         ret = class_create_file(&my_class, &class_attr_howareyou);
> >         if (ret != 0) {
> >                pr_err("DFG class create file error: %d\n", ret);
> >                class_unregister(&my_class);
> >                return ret;
> >        }
> >
> >        child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > NULL, "child");
> >         if (child_device == NULL) {
> >                pr_err("DFG error child device NULL");
> >         }
> >
> >         return ret;
> > }
> >
>
>
> Looks sane, what does your kernel log say when you load this?
first insmod, OK.
rmmod, OK.
Second insmod:

[ 4149.389133] sysfs: cannot create duplicate filename
'/devices/pci0000:00/0000:00:1f.0/my-class'
[ 4149.389135] CPU: 2 PID: 8900 Comm: insmod Tainted: G           OE
  5.8.0+ #1
[ 4149.389136] Hardware name: xxxxx
[ 4149.389136] Call Trace:
[ 4149.389141]  dump_stack+0x74/0x9a
[ 4149.389143]  sysfs_warn_dup.cold+0x17/0x35
[ 4149.389144]  sysfs_create_dir_ns+0xb8/0xd0
[ 4149.389146]  kobject_add_internal+0xbd/0x2b0
[ 4149.389147]  kobject_add+0x7e/0xb0
[ 4149.389149]  ? _cond_resched+0x19/0x30
[ 4149.389151]  ? kmem_cache_alloc_trace+0x16c/0x240
[ 4149.389154]  get_device_parent.isra.0+0x179/0x1b0
[ 4149.389155]  device_add+0xed/0x830
[ 4149.389156]  device_create_groups_vargs+0xd4/0xf0
[ 4149.389157]  device_create+0x49/0x60
[ 4149.389159]  mypci_probe.cold+0x79/0x9a [firmware_security_class]
[ 4149.389160]  local_pci_probe+0x48/0x80
[ 4149.389161]  pci_device_probe+0x10f/0x1c0
[ 4149.389162]  really_probe+0x159/0x3e0
[ 4149.389163]  driver_probe_device+0xe9/0x160
[ 4149.389164]  device_driver_attach+0x5d/0x70
[ 4149.389165]  __driver_attach+0x8f/0x150
[ 4149.389166]  ? device_driver_attach+0x70/0x70
[ 4149.389167]  bus_for_each_dev+0x7e/0xc0
[ 4149.389168]  driver_attach+0x1e/0x20
[ 4149.389168]  bus_add_driver+0x152/0x1f0
[ 4149.389169]  driver_register+0x74/0xd0
[ 4149.389170]  ? 0xffffffffc0cb8000
[ 4149.389171]  __pci_register_driver+0x54/0x60
[ 4149.389172]  my_pci_driver_init+0x23/0x1000 [firmware_security_class]
[ 4149.389174]  do_one_initcall+0x4a/0x200
[ 4149.389175]  ? _cond_resched+0x19/0x30
[ 4149.389176]  ? kmem_cache_alloc_trace+0x16c/0x240
[ 4149.389177]  do_init_module+0x62/0x240
[ 4149.389178]  load_module+0x291f/0x2b90
[ 4149.389180]  __do_sys_finit_module+0xbe/0x120
[ 4149.389181]  ? __do_sys_finit_module+0xbe/0x120
[ 4149.389182]  __x64_sys_finit_module+0x1a/0x20
[ 4149.389183]  do_syscall_64+0x52/0xc0
[ 4149.389184]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 4149.389185] RIP: 0033:0x7fbdc4b8c70d
[ 4149.389186] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 53 f7 0c 00 f7 d8 64 89
01 48
[ 4149.389187] RSP: 002b:00007ffd7f2b7d88 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[ 4149.389188] RAX: ffffffffffffffda RBX: 000055b301ef4770 RCX: 00007fbdc4b8c70d
[ 4149.389188] RDX: 0000000000000000 RSI: 000055b301b4d358 RDI: 0000000000000003
[ 4149.389188] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007fbdc4c60260
[ 4149.389189] R10: 0000000000000003 R11: 0000000000000246 R12: 000055b301b4d358
[ 4149.389189] R13: 0000000000000000 R14: 000055b301ef7180 R15: 0000000000000000
[ 4149.389190] kobject_add_internal failed for my-class with -EEXIST,
don't try to register things with the same name in the same directory.



>
> thanks,
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

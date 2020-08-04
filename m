Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F23C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F058208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596556276;
	bh=OtA0EW8iaXuoVIFAIgh1KuT3uEjn0AAO/2QdeC/r5FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k8zlLOtEIK619H+DYQVl4zBAkJdhBXc3aUz+6FZuO8NttMA3hk7n8csvZKeI1rb80
	 nDRsuqsEtYu3Nfr1JjBBSDIUx2oibhPJw4Ab1mHaulkJyKhl5StNnjQ5Bvy1dNvdwK
	 AlPXoxxmXuu/PFadnQ9F/0/xVhajfBMuEoC4Zkg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgHDPvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbgHDPvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:51:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C4F208A9;
        Tue,  4 Aug 2020 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596556260;
        bh=OtA0EW8iaXuoVIFAIgh1KuT3uEjn0AAO/2QdeC/r5FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdNvOcx/C/QBAmmNbx2kEz7HV7AG9W6G/LHdx67gZbzUj6EBVIXA+Xzl5Ln9iwRol
         Dk/vWrU+PEqGDGTGOxxue63JHVdSYIM7lKHgBq1XL9wW/63bp4g3MYScoDdlnSkNGr
         xzTh1LQol6MghcQajeEM7cJ4eudzb584hPevBoXM=
Date:   Tue, 4 Aug 2020 17:51:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
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
Subject: Re: [PATCH] Platform lockdown information in SYSFS
Message-ID: <20200804155120.GA496635@kroah.com>
References: <20200731070053.GC1518178@kroah.com>
 <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com>
 <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com>
 <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
 <20200804142250.GA247448@kroah.com>
 <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
 <20200804144414.GA50022@kroah.com>
 <CAFmMkTG342Thq+H-om+3mCog5Yh3ZzqO_HYnR-Jv-b1utojk0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTG342Thq+H-om+3mCog5Yh3ZzqO_HYnR-Jv-b1utojk0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:05:25PM -0300, Daniel Gutson wrote:
> On Tue, Aug 4, 2020 at 11:43 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 04, 2020 at 11:37:02AM -0300, Daniel Gutson wrote:
> > > On Tue, Aug 4, 2020 at 11:23 AM Greg Kroah-Hartman <
> > > gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Aug 04, 2020 at 10:50:13AM -0300, Daniel Gutson wrote:
> > > > > On Tue, Aug 4, 2020 at 3:41 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Aug 03, 2020 at 07:04:56PM -0300, Daniel Gutson wrote:
> > > > > > > > > > Think of this as an input device.  You don't put the random
> > > input
> > > > > > > > > > attributes all in one place, you create a new device that
> > > represents the
> > > > > > > > > > input interface and register that.
> > > > > > >
> > > > > > > I'm having trouble with this. What's the dev_t for the child
> > > devices?
> > > > > > > I'm doing
> > > > > > >     child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > > > > > > NULL, "child");
> > > > > > > pdev is the pci_device (intel-spi-pci)
> > > > > > > dmesg shows
> > > > > > >
> > > > > > >     sysfs: cannot create duplicate filename '/class/my-class'
> > > > > > >     (call trace)
> > > > > > >     kobject_add_internal failed for my-class with -EEXIST, don't try
> > > > > > > to register things with the same name in the same directory.
> > > > > >
> > > > > > Without seeing all of your code, I can't tell you what you are doing
> > > > > > wrong, but the kernel should be giving you a huge hint here...
> > > > > >
> > > > > > Don't create duplicate names in the same subdirectory.
> > > > >
> > > > > I'm not doing that. One of my questions is if MKDEV(0, 0) is valid for
> > > > > create_device, which I inferred so from the documentation.
> > > >
> > > > Yes it is, but that's not the error given to you :)
> > > >
> > > > Many in-kernel users call device_create() with MKDEV(0, 0)
> > > >
> > > > > Here is the listing
> > > >
> > > > <snip>
> > > >
> > > > It's not in any format to read, please never strip leading whitespace,
> > > > it hurts my brain...
> > >
> > > (trying again)
> > > Also, this is in pastebin:  https://pastebin.com/8Ye9eUm5
> > >
> > > #include <linux/kobject.h>
> > > #include <linux/sysfs.h>
> > > #include <linux/module.h>
> > > #include <linux/init.h>
> > > #include <linux/list.h>
> > > #include <linux/slab.h>
> > > #include <linux/device.h>
> > > #include <linux/pci.h>
> > >
> > > static ssize_t howareyou_show(struct class *class, struct class_attribute
> > > *attr,
> > >    char *buf)
> > > {
> > >         return sprintf(buf, "%s\n", "How are you?");
> > > }
> > > static CLASS_ATTR_RO(howareyou);
> >
> > These are rare, as they are "global" for a class, are you sure you want
> > that?
> 
> I'm no longer using class attributes, this is from my previous
> experiment. Sorry for the confusion.
> In the "real" code I'll use DEVICE_ATTR_RO.
> 
> >
> > >
> > > static struct class my_class = {
> > >         .name =         "my-class",
> > >         .owner =        THIS_MODULE,
> > > };
> > >
> > > struct device* child_device;
> > >
> > > static int mypci_probe(struct pci_dev *pdev,
> > >       const struct pci_device_id *id)
> > > {
> > >         int ret;
> > >
> > >         ret = pcim_enable_device(pdev);
> > >         if (ret)
> > >                 return ret;
> > >
> > >         ret = class_register(&my_class);
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > >
> > >         pr_info("DFG: Recognized. DID: %lx\n", (unsigned long
> > > int)id->driver_data);
> > >         pr_info("DFG: device DID: %lx\n", (unsigned long int)pdev->device);
> > >
> > >         ret = class_create_file(&my_class, &class_attr_howareyou);
> > >         if (ret != 0) {
> > >                pr_err("DFG class create file error: %d\n", ret);
> > >                class_unregister(&my_class);
> > >                return ret;
> > >        }
> > >
> > >        child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > > NULL, "child");
> > >         if (child_device == NULL) {
> > >                pr_err("DFG error child device NULL");
> > >         }
> > >
> > >         return ret;
> > > }
> > >
> >
> >
> > Looks sane, what does your kernel log say when you load this?
> first insmod, OK.
> rmmod, OK.
> Second insmod:
> 
> [ 4149.389133] sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:1f.0/my-class'

Ok, that means you did not clean up properly.

After rmmod see if you really did clean up all of the directories/files
you created.

The kernel is trying to be nice and give you a hint here :)

thanks,

greg k-h

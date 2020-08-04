Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D56FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1BBC208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596551005;
	bh=gCAOTGV+S81wbKkcdN1P5rxcMrLXO+oK03/TIyVDses=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GCoA+17IQfIGcKm8FpSi2i46wDyuvEX2ducUdJxvzR+tBYgadqW76GINsfgWvzr/c
	 YKpLSMxl4p6RVso/LRIiFg0P6l+xlLDFKX7V7vZ5kSTpe0jLLjagsMb5b77s/eRHeo
	 3cnZMBpYBJD+l2alp29iwMiD/hbyxY3x8XagTo74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgHDOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgHDOXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:23:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E468208A9;
        Tue,  4 Aug 2020 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596550991;
        bh=gCAOTGV+S81wbKkcdN1P5rxcMrLXO+oK03/TIyVDses=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnPcdLRmjk0BoEPdgStiHhz3IrtIBwNjq2Pwr+QjQ3YkoGp1MF7W54hvnm03KMQrc
         60QZhwFmrfQ56agxlyCvDzWqnmmZxYehYxScxkEWWVOa+cHzklHbaM2CpEa7GeyRUo
         WkBlOG5Rk1nHpVd5vaooFnkOYOdvbYg2FilFG94Y=
Date:   Tue, 4 Aug 2020 16:22:50 +0200
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
Message-ID: <20200804142250.GA247448@kroah.com>
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com>
 <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com>
 <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com>
 <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:50:13AM -0300, Daniel Gutson wrote:
> On Tue, Aug 4, 2020 at 3:41 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 03, 2020 at 07:04:56PM -0300, Daniel Gutson wrote:
> > > > > > Think of this as an input device.  You don't put the random input
> > > > > > attributes all in one place, you create a new device that represents the
> > > > > > input interface and register that.
> > >
> > > I'm having trouble with this. What's the dev_t for the child devices?
> > > I'm doing
> > >     child_device = device_create(&my_class, &pdev->dev, MKDEV(0, 0),
> > > NULL, "child");
> > > pdev is the pci_device (intel-spi-pci)
> > > dmesg shows
> > >
> > >     sysfs: cannot create duplicate filename '/class/my-class'
> > >     (call trace)
> > >     kobject_add_internal failed for my-class with -EEXIST, don't try
> > > to register things with the same name in the same directory.
> >
> > Without seeing all of your code, I can't tell you what you are doing
> > wrong, but the kernel should be giving you a huge hint here...
> >
> > Don't create duplicate names in the same subdirectory.
> 
> I'm not doing that. One of my questions is if MKDEV(0, 0) is valid for
> create_device, which I inferred so from the documentation.

Yes it is, but that's not the error given to you :)

Many in-kernel users call device_create() with MKDEV(0, 0)

> Here is the listing

<snip>

It's not in any format to read, please never strip leading whitespace,
it hurts my brain...

thanks,

greg k-h

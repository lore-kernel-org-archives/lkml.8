Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A795820792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595328770;
	bh=tP/j9SYV2Wc096FLcNTJNBdxAa7a73U6cx63i0V4ty8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H4ctnmmnCMJ8CNkrTdj6QbgPA4X2SFv2mrzYt+ee6rx6+U/vKLADlOtFZ1JqTauyB
	 xR72Jjd6xMfGDu1CMB6XaAZl1gMvBTf/f6yxLjDRb6V1GAmk+9llmG8hPMtpjY+fm8
	 5t9jQQx6VAurv9y9l8CcITpxuyZ7V4ZTKSeYy60s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGUKwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgGUKws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:52:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9187E2073A;
        Tue, 21 Jul 2020 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595328768;
        bh=tP/j9SYV2Wc096FLcNTJNBdxAa7a73U6cx63i0V4ty8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4qfj7soch1wyIflz540mPLAPLtJYuO8SK3jkGX5d8cfohn9NypIIsxLTvlIV9/Lg
         mKJt6wmfQzoHA0dd4UmP36gtZWE4h6n6gU8AlBp4M1v+Eo3Z6qD0RcHbNXdIDRssUw
         wZWsV11dbBed35NXhsGXy9Lleq3eRK2u8dAwJ0yQ=
Date:   Tue, 21 Jul 2020 12:52:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
Message-ID: <20200721105256.GC1678476@kroah.com>
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
 <20200717062841.GA3238569@kroah.com>
 <CAK8P3a1yy7YyeJH5k40yAXb23y9siBnfuqixb76t3BK9Xh=uXQ@mail.gmail.com>
 <CAFmMkTFLm9mw5-8Dj_7rhP2KBcLUoJ1WcQCJv5_k+QRsmJPxjg@mail.gmail.com>
 <20200717145746.GB3008378@kroah.com>
 <CAFmMkTEsm7CRBzEJSCjkhCT7NHvRUXzcgchExbnfFbwPjT0YFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTEsm7CRBzEJSCjkhCT7NHvRUXzcgchExbnfFbwPjT0YFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 05:58:47PM -0300, Daniel Gutson wrote:
> On Fri, Jul 17, 2020 at 11:57 AM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> 
> > On Fri, Jul 17, 2020 at 11:46:39AM -0300, Daniel Gutson wrote:
> > > On Fri, Jul 17, 2020 at 11:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > > On Fri, Jul 17, 2020 at 8:28 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Thu, Jul 16, 2020 at 07:36:27PM -0300, Daniel Gutson wrote:
> > > > > > +What:                /sys/kernel/firmware-security/bioswe
> > > > >
> > > > > Ick, I stopped reading right here.
> > > > >
> > > > > No, this is not where this belongs.
> > > > >
> > > > > We already have /sys/firmware/, right?  And firmware-specific
> > > > > subdirectories below that.
> > > > >
> > > > > We also have /sys/devices/system/ and I think that would be a much
> > > > > better place for this, as it is easier to work with a real 'struct
> > > > > device' than a "raw" kobject any day.  Bonus is you get full support
> > of
> > > > > userspace libraries when you do that, unlike when dealing with
> > kobjects.
> > > > >
> > > > > Also, this really is a _SPECIFIC_ type of firmware that supports
> > these
> > > > > features, right?  Why not call that out too?  This is not generic by
> > any
> > > > > means.
> > > >
> > > > As I suggested in my previous review, I wouldn't worry too much about
> > > > the user interface at the start, but instead first work out how the
> > > > hardware
> > > > support fits in with the existing drivers and once that looks fine
> > decide
> > > > on how to export it to user space.
> > > >
> > > > I agree the  /sys/kernel/firmware-security/bioswe sounds like the wrong
> > > > place, but I'm not sure if adding any other new directory in sysfs is
> > > > much better. I think the most promising would be to have it on the
> > > > sysfs directory for the device it refers to,
> > >
> > >
> > > My idea is to have all the firmware security information together in the
> > > same place; this information comes from many devices.
> > > This initial patch involves the SPI Controller, and I don't want to add
> > > more stuff until there
> > > is a consensus.
> > > So, do you have a suggestion where to put this information?
> > > /sys/devices/system/firmware-security?
> > > /sys/firmware/security?
> > > other?
> > >
> > > Please advise.
> >
> > It's fun to focus on things like this, as it's the most visible part,
> > but are you sure the "talk to the hardware" part is working properly?
> >
> 
> Yes.
> 
> 
> 
> >
> > If so, great, it should be a "class", as that way it is independent of
> > any hardware type, right?  Classes show how devices talk to userspace in
> > a common way (input, tty, led, block, etc.)  So why is this any
> > different from that?
> >
> 
> Are you suggesting to create a new class, or use an existing one?

Probably a new one, unless you can find an existing one that would fit?

thanks,

greg k-h

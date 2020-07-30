Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B8FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737DB2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596087081;
	bh=Dvo2/mKtVKTG0GN4Ptkmba8k3YXSZeccrO2bOD3DvS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KZBZ3aWgj6xjYqrkvpA/o2mRKwiySn0AWDbShQbd+Yja2BI4b4fMz/+r5WIV8Zu0L
	 Hy9AuMxYY3uRaVIubmSRCITC9WbagdLxyJg4uPIei265JqgENjlGAGoqQdpFAc5oeo
	 CuKY60jbrfYFRQpwghAZkgpigZOabdjz1kaZPJB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgG3FbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3FbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:31:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750DB20842;
        Thu, 30 Jul 2020 05:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596087079;
        bh=Dvo2/mKtVKTG0GN4Ptkmba8k3YXSZeccrO2bOD3DvS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpV2wkx35kvXQjleYoNCJcsBGjTxjZ5HYiB+hNWmiqiK671/+WrR5JYbDKTda0Ofe
         iJ2LMYGqOXjIwTDvGjHSf7jefTImzSy1nmFR/UX5WXw1aifCej7tQlxaK4nZGW+MhU
         W9NJrpkDjBfmT5UOj2a/UE8guQgDRF6qPj9UbvVE=
Date:   Thu, 30 Jul 2020 07:31:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci
 attempts to turn the SPI flash chip writeable
Message-ID: <20200730053108.GA3861609@kroah.com>
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com>
 <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com>
 <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
 <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
 <CAFmMkTExBY3V_Ghej7Bzjatg+vFtWq3UZmKzjAiEoR9EqnFN9Q@mail.gmail.com>
 <CAFmMkTEO7VNKJeYz2uoHsS-yN_aY8UuiQ2GcCq9NyAD5481ZGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFmMkTEO7VNKJeYz2uoHsS-yN_aY8UuiQ2GcCq9NyAD5481ZGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 05:54:35PM -0300, Daniel Gutson wrote:
> On Mon, Jul 27, 2020 at 12:31 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> >
> > On Mon, Jul 27, 2020 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Mon, Jul 27, 2020 at 5:05 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> > > > On Sun, Jul 26, 2020 at 4:17 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >>
> > > >> On Sat, Jul 25, 2020 at 02:20:03PM -0300, Daniel Gutson wrote:
> > > >> > El sáb., 25 jul. 2020 2:56 a. m., Greg Kroah-Hartman <
> > > >> > gregkh@linuxfoundation.org> escribió:
> > > >> >
> > > >> >
> > > >> > 1) I just did the same that intel-spi.c does.
> > > >>
> > > >> No need to copy bad examples :)
> > > >
> > > >
> > > > Didn't know it was a bad example. What's is the current modern mechanism that replaces initialization-time configuration?
> > >
> > > I'd say you'd generally want this to be a per-instance setting, which
> > > could be a sysfs attribute of the physical device, or an ioctl for an
> > > existing user space abstraction.
> >
> > But still, they are not equivalent. The initial configuration remains
> > constant for the rest of the life of the driver, whereas the
> > sysfs attribute is set after the initialization and can be re-set over
> > time. I'm not asking module parameters "to come back" if
> > they are now considered obsolete, I'm just trying to understand.
> >
> > >
> > > In the changelog, you should also explain what this is used for. Do
> > > you actually want to write to a device that is marked read-only, or
> > > are you just trying to make the interface more consistent between the
> > > two drivers?
> >
> > The device can either be locked or unlocked. If it is unlocked, it can
> > be set writable depending on the module
> > argument in intel-spi, or straight writable in intel-spi-pci. Which is
> > dangerous.
> > I wanted to make, as you say, the interface consistent.
> > Exposing an interface to the user (via a sysfs attribute) to try to
> > make the driver writable is definitively a bad idea.
> > I'd rather do nothing (no module arg) rather than open that
> > here-be-dragons door.
> 
> ping.
> This is a real existing problem that I'm trying to address.
> There's currently no way to prevent the kernel to try to turn
> the SPI flash chip writable for the device IDs handled by
> intel-spi-pci. And allowing userspace to switch it between
> writable/non-writable is not an option.
> What other mechanism can I use other than the module parameter,

Again, module parameters are working on a per-chunk-of-code basis, while
you want to work on a per-device basis, which is why you should not use
a module parameter.

good luck!

greg k-h

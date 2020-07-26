Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B01C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A6020714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595747847;
	bh=aEkIV5Yc1/XFjZwqDPVoFSYk2JX22XKln/kgJ0przBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dXsehR9PrHXlhepl4kTA4jCK9ft5JBsbTwZo/INNRF3JP0ZNFDolxJrmWtj47EPR7
	 capbOAFv53xXZ0r8QpwqyM1wo5tItcIroj26jLtRxZIDhmlZd9mlcOJqTcQcR4TKJj
	 hZgPPhLHGgx8utiBXmnExF8dR4k+rE1+i4num4No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGZHR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGZHR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:17:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E267320658;
        Sun, 26 Jul 2020 07:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595747845;
        bh=aEkIV5Yc1/XFjZwqDPVoFSYk2JX22XKln/kgJ0przBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUJ1TV40nHKMyOC0OjL/UzjKvO8R56vep5x+d05V4vytQAonEDwHXoaNDLJPOFfG2
         vFxyrEjHETtPrY0b/7+aH5sygMOK/DGlQZ4w+Lo4VUAHjYGTBzPGVwwuepck67Bno0
         xKm/tPegTBb7NZeFvuOuKanotC/P5eoJfPZAjnbI=
Date:   Sun, 26 Jul 2020 09:17:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci
 attempts to turn the SPI flash chip writeable
Message-ID: <20200726071723.GB441916@kroah.com>
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com>
 <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 02:20:03PM -0300, Daniel Gutson wrote:
> El sáb., 25 jul. 2020 2:56 a. m., Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> escribió:
> 
> > On Fri, Jul 24, 2020 at 06:28:53PM -0300, Daniel Gutson wrote:
> > > Currently, intel-spi has a module argument that controls whether the
> > driver
> > > attempts to turn the SPI flash chip writeable. The default value
> > > is FALSE (don't try to make it writeable).
> > > However, this flag applies only for a number of devices, coming from the
> > > platform driver, whereas the devices detected through the PCI driver
> > > (intel-spi-pci) are not subject to this check since the configuration
> > > takes place in intel-spi-pci which doesn't have an argument.
> > >
> > > That's why I propose this patch to add such argument to intel-spi-pci,
> > > so the user can control whether the driver tries to make the chip
> > > writeable or not, being the default FALSE as is the argument of
> > > intel-spi.
> > >
> > > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> > > ---
> > >  drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > > index 81329f680bec..77e57450f166 100644
> > > --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > > +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> > > @@ -24,6 +24,10 @@ static const struct intel_spi_boardinfo cnl_info = {
> > >       .type = INTEL_SPI_CNL,
> > >  };
> > >
> > > +static bool writeable;
> > > +module_param(writeable, bool, 0);
> > > +MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip
> > (default=0)");
> >
> > Ick, this isn't the 1990's, please do not add new module parameters,
> > they are a major pain to work with and only work on a global basis, not
> > on a per-device basis.
> >
> > No user will remember how to use this, as it isn't documented anywhere
> > either.  Can you make this a sysfs attribute or something, or better
> > yet, make it "just work" depending on the device type?
> >
> 
> 1) I just did the same that intel-spi.c does.

No need to copy bad examples :)

> You need to understand that there's a set of DIDs coming from the
> lpc_ich (and then the platform) driver, and another set from
> intel-spi-pci. The first set is subject to the check, the second
> doesn't. So there is no "just work" as I understand it.

I have no idea what "DID" is here, sorry.

But why do you want to write it?

> 2) this is an initialization argument, I could make it always NOT attempt
> to make the chip writable, and a system attribute to turn it writable
> post-initialization but the behavior is not the same. In any ways, as I
> mentioned before, some DIDs will be covered by the existing argument of
> intel-spi and other DIDs by this sysfs attribute, becoming IMHO
> inconsistent from the user POV.

What sysfs attribute?  This is a module parameter :(

totally confused,

greg k-h

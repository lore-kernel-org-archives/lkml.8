Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F778C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAAB206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595656615;
	bh=lQhz2ZepJuKrQE6NHOi5RHfNha5MRdXWgWs0MBUaets=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xQeoy3FyCVqJa4xnBj0tVXepQ97PNTVfUOllmty24F8yEMPoACNQWYKhKLA/ptm5i
	 7KbrCeMIWwF0oiV2UHwZnh4M/djym2R3IthYjRXuRDPimtAfYlOVIh6IyO4w+AL5+5
	 75pmKGAM/icwSYh46ZP6p8UBjJmQga2W+qAIlRS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGYF4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGYF4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:56:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E45206D8;
        Sat, 25 Jul 2020 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595656608;
        bh=lQhz2ZepJuKrQE6NHOi5RHfNha5MRdXWgWs0MBUaets=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ts8zMM8p72miir5GvC28+VIQ0mLvr9mVzE62fON6hzD2PGrz0uIGan2mZ9pJhiee6
         1m+kOyHkfHShDhA9JXPdXufKS52nM7bzVjmoTUSSzJ4RS0MIqQsq/pw0+bLr0nzXpD
         O3Fzz2P/CsmxYuZROgyNTtQwQAEQAEGB7j9r/Um0=
Date:   Sat, 25 Jul 2020 07:56:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
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
Message-ID: <20200725055649.GA1047853@kroah.com>
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:28:53PM -0300, Daniel Gutson wrote:
> Currently, intel-spi has a module argument that controls whether the driver
> attempts to turn the SPI flash chip writeable. The default value
> is FALSE (don't try to make it writeable).
> However, this flag applies only for a number of devices, coming from the
> platform driver, whereas the devices detected through the PCI driver
> (intel-spi-pci) are not subject to this check since the configuration
> takes place in intel-spi-pci which doesn't have an argument.
> 
> That's why I propose this patch to add such argument to intel-spi-pci,
> so the user can control whether the driver tries to make the chip
> writeable or not, being the default FALSE as is the argument of
> intel-spi.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> index 81329f680bec..77e57450f166 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> @@ -24,6 +24,10 @@ static const struct intel_spi_boardinfo cnl_info = {
>  	.type = INTEL_SPI_CNL,
>  };
>  
> +static bool writeable;
> +module_param(writeable, bool, 0);
> +MODULE_PARM_DESC(writeable, "Enable write access to SPI flash chip (default=0)");

Ick, this isn't the 1990's, please do not add new module parameters,
they are a major pain to work with and only work on a global basis, not
on a per-device basis.

No user will remember how to use this, as it isn't documented anywhere
either.  Can you make this a sysfs attribute or something, or better
yet, make it "just work" depending on the device type?

thanks,

greg k-h

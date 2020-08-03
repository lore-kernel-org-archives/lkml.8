Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E682520678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgHCJ50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:57:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:43518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgHCJ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:57:25 -0400
IronPort-SDR: 0O2O0Ju5EEMwF4I0hSmpcTNJNMu1CQh9pDJ0b0TeQR9mo/hPTUm5p0DXe3qy/MCeXyhYlnq3rf
 xf8wGg5T2F3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="216495737"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="216495737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 02:57:24 -0700
IronPort-SDR: MsiKdyIvj4fmPlYeIFCmVI5xosoHyyG+1kksLDAieWifeoY53aYQt2EGOqbylbRPy1hkBTV432
 Fom/VXLNwQXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="396002736"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Aug 2020 02:57:21 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 03 Aug 2020 12:57:20 +0300
Date:   Mon, 3 Aug 2020 12:57:20 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci
 attempts to turn the SPI flash chip writeable
Message-ID: <20200803095720.GC1375436@lahna.fi.intel.com>
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the delay, I was on vacation.

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

I think instead of this we should simply make it so that the driver
never tries to make the chip writable.

> +
>  static int intel_spi_pci_probe(struct pci_dev *pdev,
>  			       const struct pci_device_id *id)
>  {
> @@ -41,12 +45,14 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
>  	if (!info)
>  		return -ENOMEM;
>  
> -	/* Try to make the chip read/write */
> -	pci_read_config_dword(pdev, BCR, &bcr);
> -	if (!(bcr & BCR_WPD)) {
> -		bcr |= BCR_WPD;
> -		pci_write_config_dword(pdev, BCR, bcr);
> +	if (writeable) {
> +		/* Try to make the chip read/write */
>  		pci_read_config_dword(pdev, BCR, &bcr);
> +		if (!(bcr & BCR_WPD)) {
> +			bcr |= BCR_WPD;
> +			pci_write_config_dword(pdev, BCR, bcr);
> +			pci_read_config_dword(pdev, BCR, &bcr);
> +		}
>  	}
>  	info->writeable = !!(bcr & BCR_WPD);

So here we just read the BCR register and then set info->writeable based
on its value.

Then it is up to the BIOS to enable this if it allows writing the flash
chip from the OS side.

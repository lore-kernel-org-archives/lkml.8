Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16EBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBCB2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgHDL5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:57:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:36354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgHDLyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:54:40 -0400
IronPort-SDR: yvhls4l+eb1tRfZb2WlfJmaCYQ61KW0wJd/jjGSEIdo1UoW/CfzqOAumjtbMw0CnkyOweMDGDT
 uozNiaRLwxYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="170378366"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="170378366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 04:52:39 -0700
IronPort-SDR: 5j8lkSutCNkcZJP6Z22txQhbEEyybEd3JikPty+wtafuTyns5+9QrI47aQw9fxslKMosrmzW2t
 GxfCGB2fWp8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="396550686"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Aug 2020 04:52:34 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 04 Aug 2020 14:52:33 +0300
Date:   Tue, 4 Aug 2020 14:52:33 +0300
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
Subject: Re: [PATCH] Remove attempt by intel-spi-pci to turn the SPI flash
 chip writeable
Message-ID: <20200804115233.GO1375436@lahna.fi.intel.com>
References: <20200803134449.72502-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803134449.72502-1-daniel.gutson@eclypsium.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 03, 2020 at 10:44:49AM -0300, Daniel Gutson wrote:
> Currently, the intel-spi-pci driver tries to unconditionally set
> the SPI chip writeable. After discussing in the LKML, the original
> author decided that it was better  to remove the attempt.
> 
> Context, the intel-spi has a module argument that controls
> whether the driver attempts to turn the SPI flash chip writeable.
> The default value is FALSE (don't try to make it writeable).
> However, this flag applies only for a number of devices, coming from the
> platform driver, whereas the devices detected through the PCI driver
> (intel-spi-pci) are not subject to this check since the configuration
> takes place in intel-spi-pci which doesn't have an argument.
> 
> This patch removes the code that attempts to turn the SPI chip writeable.

I think you should make the $subject to follow the convention used in
the SPI-NOR subsystem. You can see it running following command:

  $ git log --oneline drivers/mtd/spi-nor/controllers/intel-spi-pci.c

In this case I think it should be:

  mtd: spi-nor: intel-spi: Do not try to make the SPI flash chip writable

or something like that.

The patch itself looks good, one minor comment below.

> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  drivers/mtd/spi-nor/controllers/intel-spi-pci.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> index 81329f680bec..d721ba4e8b41 100644
> --- a/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> +++ b/drivers/mtd/spi-nor/controllers/intel-spi-pci.c
> @@ -41,13 +41,7 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
>  	if (!info)
>  		return -ENOMEM;
>  
> -	/* Try to make the chip read/write */
>  	pci_read_config_dword(pdev, BCR, &bcr);
> -	if (!(bcr & BCR_WPD)) {
> -		bcr |= BCR_WPD;
> -		pci_write_config_dword(pdev, BCR, bcr);
> -		pci_read_config_dword(pdev, BCR, &bcr);
> -	}
>  	info->writeable = !!(bcr & BCR_WPD);

Perhaps we should log this in debug level (dev_dbg()) so when debugging
possible issues we can see that the chip is write protected by the BIOS.

>  
>  	ispi = intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
> -- 
> 2.25.1

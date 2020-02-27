Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B392C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EECE2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgB0SHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:07:35 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40740 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgB0SHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:07:34 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7B24C2963D9;
        Thu, 27 Feb 2020 18:07:32 +0000 (GMT)
Date:   Thu, 27 Feb 2020 19:07:29 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     shiva.linuxworks@gmail.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v4 3/5] mtd: spinand: micron: identify SPI NAND device
 with Continuous Read mode
Message-ID: <20200227190729.1c5e4fef@collabora.com>
In-Reply-To: <20200206202206.14770-4-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
        <20200206202206.14770-4-sshivamurthy@micron.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Feb 2020 21:22:04 +0100
shiva.linuxworks@gmail.com wrote:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Add SPINAND_HAS_CR_FEAT_BIT flag to identify the SPI NAND device with
> the Continuous Read mode.
> 
> Some of the Micron SPI NAND devices have the "Continuous Read" feature
> enabled by default, which does not fit the subsystem needs.
> 
> In this mode, the READ CACHE command doesn't require the starting column
> address. The device always output the data starting from the first
> column of the cache register, and once the end of the cache register
> reached, the data output continues through the next page. With the
> continuous read mode, it is possible to read out the entire block using
> a single READ command, and once the end of the block reached, the output
> pins become High-Z state. However, during this mode the read command
> doesn't output the OOB area.
> 
> Hence, we disable the feature at probe time.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 16 ++++++++++++++++
>  include/linux/mtd/spinand.h   |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 5fd1f921ef12..a8e947609cd9 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -18,6 +18,8 @@
>  #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
>  #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
>  
> +#define MICRON_CFG_CONTI_READ		BIT(0)

Let's try to use consistent names. The feature bit is
SPINAND_HAS_CR_FEAT_BIT, so maybe MICRON_CFG_CR. BTW, is this really a
micron-specific bit?

> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -153,8 +155,22 @@ static int micron_spinand_detect(struct spinand_device *spinand)
>  	return 1;
>  }
>  
> +static int micron_spinand_init(struct spinand_device *spinand)
> +{
> +	/*
> +	 * M70A device series enable Continuous Read feature at Power-up,
> +	 * which is not supported. Disable this bit to avoid any possible
> +	 * failure.
> +	 */
> +	if (spinand->flags == SPINAND_HAS_CR_FEAT_BIT)

	if (spinand->flags & SPINAND_HAS_CR_FEAT_BIT)

> +		return spinand_upd_cfg(spinand, MICRON_CFG_CONTI_READ, 0);
> +
> +	return 0;
> +}
> +
>  static const struct spinand_manufacturer_ops micron_spinand_manuf_ops = {
>  	.detect = micron_spinand_detect,
> +	.init = micron_spinand_init,
>  };
>  
>  const struct spinand_manufacturer micron_spinand_manufacturer = {
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 4ea558bd3c46..333149b2855f 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -270,6 +270,7 @@ struct spinand_ecc_info {
>  };
>  
>  #define SPINAND_HAS_QE_BIT		BIT(0)
> +#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
>  
>  /**
>   * struct spinand_info - Structure used to describe SPI NAND chips


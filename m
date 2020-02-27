Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A19C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1B246A8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgB0SWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41148 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgB0SWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:22:12 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 20FFE29645A;
        Thu, 27 Feb 2020 18:22:11 +0000 (GMT)
Date:   Thu, 27 Feb 2020 19:22:09 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     shiva.linuxworks@gmail.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v4 1/5] mtd: spinand: micron: Generalize the OOB layout
 structure and function names
Message-ID: <20200227192209.77d637a4@collabora.com>
In-Reply-To: <20200206202206.14770-2-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
        <20200206202206.14770-2-sshivamurthy@micron.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Feb 2020 21:22:02 +0100
shiva.linuxworks@gmail.com wrote:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> In order to add new Micron SPI NAND devices, we generalized the OOB
> layout structure and function names.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/nand/spi/micron.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 7d7b1f7fcf71..c028d0d7e236 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -34,38 +34,38 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
>  		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
>  		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>  
> -static int mt29f2g01abagd_ooblayout_ecc(struct mtd_info *mtd, int section,
> -					struct mtd_oob_region *region)
> +static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
>  {
>  	if (section)
>  		return -ERANGE;
>  
> -	region->offset = 64;
> -	region->length = 64;
> +	region->offset = mtd->oobsize / 2;
> +	region->length = mtd->oobsize / 2;
>  
>  	return 0;
>  }
>  
> -static int mt29f2g01abagd_ooblayout_free(struct mtd_info *mtd, int section,
> -					 struct mtd_oob_region *region)
> +static int micron_8_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
>  {
>  	if (section)
>  		return -ERANGE;
>  
>  	/* Reserve 2 bytes for the BBM. */
>  	region->offset = 2;
> -	region->length = 62;
> +	region->length = (mtd->oobsize / 2) - 2;
>  
>  	return 0;
>  }
>  
> -static const struct mtd_ooblayout_ops mt29f2g01abagd_ooblayout = {
> -	.ecc = mt29f2g01abagd_ooblayout_ecc,
> -	.free = mt29f2g01abagd_ooblayout_free,
> +static const struct mtd_ooblayout_ops micron_8_ooblayout = {
> +	.ecc = micron_8_ooblayout_ecc,
> +	.free = micron_8_ooblayout_free,
>  };
>  
> -static int mt29f2g01abagd_ecc_get_status(struct spinand_device *spinand,
> -					 u8 status)
> +static int micron_8_ecc_get_status(struct spinand_device *spinand,
> +				   u8 status)
>  {
>  	switch (status & MICRON_STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -98,8 +98,8 @@ static const struct spinand_info micron_spinand_table[] = {
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&mt29f2g01abagd_ooblayout,
> -				     mt29f2g01abagd_ecc_get_status)),
> +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +				     micron_8_ecc_get_status)),
>  };
>  
>  static int micron_spinand_detect(struct spinand_device *spinand)


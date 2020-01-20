Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBD0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673C3207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgATKW1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:22:27 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36223 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgATKW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:22:26 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 27B3EFF808;
        Mon, 20 Jan 2020 10:22:21 +0000 (UTC)
Date:   Mon, 20 Jan 2020 11:22:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH 4/4] mtd: spinand: Add new Micron SPI NAND devices with
 multiple dies
Message-ID: <20200120112219.36bae01e@xps13>
In-Reply-To: <20200119145432.10405-5-sshivamurthy@micron.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
        <20200119145432.10405-5-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Sun, 19 Jan 2020 15:54:32 +0100:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Add device table for new Micron SPI NAND devices, which have multiple
> dies. While at it, add support to select the die.

Same comment as in 3/4.

> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 50 +++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 45fc37c58f8a..03b486843210 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -18,6 +18,8 @@
>  #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)
>  #define MICRON_STATUS_ECC_7TO8_BITFLIPS	(5 << 4)
>  
> +#define MICRON_DIE_SELECTION_BIT	6
> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -64,6 +66,21 @@ static const struct mtd_ooblayout_ops micron_8_ooblayout = {
>  	.free = micron_8_ooblayout_free,
>  };
>  
> +static int micron_select_target(struct spinand_device *spinand,
> +				unsigned int target)
> +{
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(0xd0,
> +						      spinand->scratchbuf);
> +
> +	/*
> +	 * As per datasheet, die selection is done by the 6th bit of Die
> +	 * Select Register (Address 0xD0).
> +	 */

I would put this comment close to the macro definition.

> +	*spinand->scratchbuf = target << MICRON_DIE_SELECTION_BIT;

Either target is or or 1 and you can use the BIT macro, or you suppose
it can go higher and the _BIT suffix does not fit. _SHIFT would work
and creating a macro directly would be even better.

> +
> +	return spi_mem_exec_op(spinand->spimem, &op);
> +}
> +

Where is this function used?

>  static int micron_8_ecc_get_status(struct spinand_device *spinand,
>  				   u8 status)
>  {
> @@ -131,6 +148,17 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     0,
>  		     SPINAND_ECCINFO(&micron_8_ooblayout,
>  				     micron_8_ecc_get_status)),
> +	/* M79A 4Gb 3.3V */
> +	SPINAND_INFO("MT29F4G01ADAGD", 0x36,
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 80, 2, 1, 2),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +				     micron_8_ecc_get_status),
> +		     SPINAND_SELECT_TARGET(micron_select_target)),
>  	/* M70A 4Gb 3.3V */
>  	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> @@ -151,6 +179,28 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     0,
>  		     SPINAND_ECCINFO(&micron_8_ooblayout,
>  				     micron_8_ecc_get_status)),
> +	/* M70A 8Gb 3.3V */
> +	SPINAND_INFO("MT29F8G01ADAFD", 0x46,
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +				     micron_8_ecc_get_status),
> +		     SPINAND_SELECT_TARGET(micron_select_target)),
> +	/* M70A 8Gb 1.8V */
> +	SPINAND_INFO("MT29F8G01ADBFD", 0x47,
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 2),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +				     micron_8_ecc_get_status),
> +		     SPINAND_SELECT_TARGET(micron_select_target)),
>  };
>  
>  static int micron_spinand_detect(struct spinand_device *spinand)




Thanks,
Miquèl

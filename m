Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0F6C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E642063A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEGSD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:03:56 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:24667 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:03:56 -0400
X-Originating-IP: 42.109.205.33
Received: from localhost (unknown [42.109.205.33])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E413C240003;
        Thu,  7 May 2020 18:03:51 +0000 (UTC)
Date:   Thu, 7 May 2020 23:33:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Message-ID: <20200507180346.gwni4hf6kb6gd2e5@yadavpratyush.com>
References: <20200507162047.30788-1-danielwa@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507162047.30788-1-danielwa@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 09:20AM, Daniel Walker wrote:
> Some chips have 4B opcodes, but there is no way to know if they have
> them. This device tree option allows platform owners to force enable 4b
> opcodes when they know their chips support it even when it can be
> automatically identified.

Do you mean that two chips might have the same ID but one of them can 
support 4B opcodes and the other can not? Is it possible to detect this 
in a fixup hook? I think it would be better to do something like this in 
a fixup hook instead of via device tree.
 
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  drivers/mtd/spi-nor/core.c      | 5 +++++
>  drivers/mtd/spi-nor/core.h      | 5 +++++
>  drivers/mtd/spi-nor/micron-st.c | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index cc68ea84318e..2bd130687f4b 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3134,6 +3134,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (info->flags & SPI_NOR_HAS_LOCK)
>  		nor->flags |= SNOR_F_HAS_LOCK;
>  
> +	/* Add SPI_NOR_4B_OPCODES if force in the device tree */
> +	if (info->flags & SPI_NOR_COND_4B_OPCODES &&
> +		of_property_read_bool(np, "force-4b-opcodes"))
> +		info->flags |= SPI_NOR_4B_OPCODES;
> +
>  	mtd->_write = spi_nor_write;
>  
>  	/* Init flash parameters based on flash_info struct and SFDP */
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 6f2f6b27173f..49e17415d834 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -312,6 +312,11 @@ struct flash_info {
>  					 * Must be used with SPI_NOR_4BIT_BP.
>  					 */
>  
> +#define SPI_NOR_COND_4B_OPCODES	BIT(19) /*
> +					 * Same as SPI_NOR_4B_OPCODES, but
> +					 * must also be force in the device
> +					 * tree.
> +					 */
>  	/* Part specific fixup hooks. */
>  	const struct spi_nor_fixups *fixups;
>  };
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index 6c034b9718e2..f827454eaa5f 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -37,7 +37,7 @@ static const struct flash_info st_parts[] = {
>  			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
>  			      USE_FSR | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_COND_4B_OPCODES) },
>  	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
>  			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>  			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

-- 
Regards,
Pratyush Yadav

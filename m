Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD906C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C692206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgEOHEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:04:45 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:36215 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgEOHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:04:44 -0400
X-Originating-IP: 42.109.214.107
Received: from localhost (unknown [42.109.214.107])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AD1D820002;
        Fri, 15 May 2020 07:04:39 +0000 (UTC)
Date:   Fri, 15 May 2020 12:34:36 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH v1 2/2] spi: nor: update page program settings for
 is25wp256 using post bfpt fixup
Message-ID: <20200515070436.hk5ho7ygluqznpcq@yadavpratyush.com>
References: <1589457051-5410-1-git-send-email-sagar.kadam@sifive.com>
 <1589457051-5410-3-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589457051-5410-3-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagar,

On 14/05/20 04:50AM, Sagar Shrikant Kadam wrote:
> During SFDP parsing it is seen that the IS25WP256d device is missing 4BAIT
> (4-Byte address instruction table), due to which it's page program
> capacity doesn't get correctly populated and the device gets configured
> with 4-byte Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1
> even though it can work with SNOR_PROTO_1_1_4.
> 
> Here using the post bfpt fixup hooks we update the page program
> settings to 4-byte QUAD Input Page program operations.
> 
> The patch is tested on HiFive Unleashed A00 board and it benefits
> few seconds of average write time for entire flash write.
> 
> QUAD Input Page Program operations:
> > time mtd_debug write /dev/mtd0 0 33554432 rd32M
> Copied 33554432 bytes from rd32M to address 0x00000000 in flash
> real    0m 32.85s
> user    0m 0.00s
> sys     0m 31.79s
> 
> Serial Input Page Program operations:
> > time mtd_debug write /dev/mtd0 0 33554432 rd32M
> Copied 33554432 bytes from rd32M to address 0x00000000 in flash
> real    0m 35.87s
> user    0m 0.00s
> sys     0m 35.42s
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  drivers/mtd/spi-nor/issi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
> index ffcb60e..9eb6e82 100644
> --- a/drivers/mtd/spi-nor/issi.c
> +++ b/drivers/mtd/spi-nor/issi.c
> @@ -23,6 +23,22 @@ is25lp256_post_bfpt_fixups(struct spi_nor *nor,
>  		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
>  		nor->addr_width = 4;
>  
> +	/*
> +	 * On IS25WP256d device 4-Byte address instruction table doesn't
> +	 * get populated and so the device get's configured with 4-byte
> +	 * Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1 even
> +	 * though it supports SNOR_PROTO_1_1_4, so priorotize QUAD write
> +	 * over SINGLE write if device id table holds SPI_NOR_QUAD_READ.
> +	 */
> +	if (strcmp(nor->info->name, "is25wp256") == 0) {

Instead of doing this, wouldn't it make more sense to have a separate 
fixup hook for is25wp256? Does this device also need the above address 
width fixup? If it does, maybe that can be split into a separate 
function, and used by both the fixups?

> +		if (nor->info->flags & SPI_NOR_QUAD_READ) {
> +			params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
> +			spi_nor_set_pp_settings
> +				(&params->page_programs[SNOR_CMD_PP_1_1_4],
> +				 SPINOR_OP_PP_1_1_4,
> +				 SNOR_PROTO_1_1_4);
> +		}
> +	}
>  	return 0;
>  }

-- 
Regards,
Pratyush Yadav

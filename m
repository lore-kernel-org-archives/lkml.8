Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A733C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65783214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgCDHVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:21:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:35792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgCDHVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:21:08 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 290C6D4FC46FAEFD2B52;
        Wed,  4 Mar 2020 15:20:53 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Mar 2020
 15:20:46 +0800
Subject: Re: [PATCH 14/23] mtd: spi-nor: Move Macronix bits out of core.c
To:     <Tudor.Ambarus@microchip.com>, <bbrezillon@kernel.org>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>
References: <20200302180730.1886678-1-tudor.ambarus@microchip.com>
 <20200302180730.1886678-15-tudor.ambarus@microchip.com>
CC:     <kstewart@linuxfoundation.org>, <alexandre.belloni@bootlin.com>,
        <linux-aspeed@lists.ozlabs.org>, <thor.thayer@linux.intel.com>,
        <jethro@fortanix.com>, <rfontana@redhat.com>,
        <miquel.raynal@bootlin.com>, <opensource@jilayne.com>,
        <richard@nod.at>, <michal.simek@xilinx.com>,
        <Ludovic.Desroches@microchip.com>, <joel@jms.id.au>,
        <nishkadg.linux@gmail.com>, <john.garry@huawei.com>,
        <vz@mleia.com>, <alexander.sverdlin@nokia.com>,
        <matthias.bgg@gmail.com>, <tglx@linutronix.de>,
        <swboyd@chromium.org>, <mika.westerberg@linux.intel.com>,
        <allison@lohutok.net>, <linux-arm-kernel@lists.infradead.org>,
        <andrew@aj.id.au>, <Nicolas.Ferre@microchip.com>,
        <linux-kernel@vger.kernel.org>, <dinguyen@kernel.org>,
        <michael@walle.cc>, <ludovic.barre@st.com>,
        <linux-mediatek@lists.infradead.org>, <info@metux.net>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <3b947b8a-5e99-f324-951a-3a1c88d59111@hisilicon.com>
Date:   Wed, 4 Mar 2020 15:20:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200302180730.1886678-15-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2020/3/3 2:07, Tudor.Ambarus@microchip.com 写道:
> From: Boris Brezillon <bbrezillon@kernel.org>
>
> Create a SPI NOR manufacturer driver for Macronix chips, and move the
> Macronix definitions outside of core.c.

I have tested it with erase-wite-read-compare(1MB file) testcase on 
mx25u12835f flash, it is ok. So add:
Tested-by: Xiang Chen <chenxiang66@hisilicon.com>

>
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   drivers/mtd/spi-nor/Makefile   |  1 +
>   drivers/mtd/spi-nor/core.c     | 69 +-----------------------
>   drivers/mtd/spi-nor/core.h     |  1 +
>   drivers/mtd/spi-nor/macronix.c | 98 ++++++++++++++++++++++++++++++++++
>   4 files changed, 101 insertions(+), 68 deletions(-)
>   create mode 100644 drivers/mtd/spi-nor/macronix.c
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 5c849f104cc4..c94798987801 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -9,4 +9,5 @@ spi-nor-objs			+= fujitsu.o
>   spi-nor-objs			+= gigadevice.o
>   spi-nor-objs			+= intel.o
>   spi-nor-objs			+= issi.o
> +spi-nor-objs			+= macronix.o
>   obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index d781cb9af182..9d0e0fc5af45 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2005,31 +2005,6 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
>   	return 0;
>   }
>   
> -static int
> -mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
> -			    const struct sfdp_parameter_header *bfpt_header,
> -			    const struct sfdp_bfpt *bfpt,
> -			    struct spi_nor_flash_parameter *params)
> -{
> -	/*
> -	 * MX25L25635F supports 4B opcodes but MX25L25635E does not.
> -	 * Unfortunately, Macronix has re-used the same JEDEC ID for both
> -	 * variants which prevents us from defining a new entry in the parts
> -	 * table.
> -	 * We need a way to differentiate MX25L25635E and MX25L25635F, and it
> -	 * seems that the F version advertises support for Fast Read 4-4-4 in
> -	 * its BFPT table.
> -	 */
> -	if (bfpt->dwords[BFPT_DWORD(5)] & BFPT_DWORD5_FAST_READ_4_4_4)
> -		nor->flags |= SNOR_F_4B_OPCODES;
> -
> -	return 0;
> -}
> -
> -static struct spi_nor_fixups mx25l25635_fixups = {
> -	.post_bfpt = mx25l25635_post_bfpt_fixups,
> -};
> -
>   /* NOTE: double check command sets and memory organization when you add
>    * more nor chips.  This current list focusses on newer chips, which
>    * have been converging on command sets which including JEDEC ID.
> @@ -2042,39 +2017,6 @@ static struct spi_nor_fixups mx25l25635_fixups = {
>    * old entries may be missing 4K flag.
>    */
>   static const struct flash_info spi_nor_ids[] = {
> -	/* Macronix */
> -	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> -	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> -	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8, SECT_4K) },
> -	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
> -	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
> -	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
> -	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
> -	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
> -	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
> -	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
> -			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
> -	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
> -	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
> -	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
> -	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
> -	{ "mx25r3235f",  INFO(0xc22816, 0, 64 * 1024,  64,
> -			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "mx25u12835f", INFO(0xc22538, 0, 64 * 1024, 256,
> -			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512,
> -			 SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> -			 .fixups = &mx25l25635_fixups },
> -	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_4B_OPCODES) },
> -	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16,
> -			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
> -	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> -	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> -	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
> -
>   	/* Micron <--> ST Micro */
>   	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_READ) },
>   	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
> @@ -2311,6 +2253,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>   	&spi_nor_gigadevice,
>   	&spi_nor_intel,
>   	&spi_nor_issi,
> +	&spi_nor_macronix,
>   };
>   
>   static const struct flash_info *
> @@ -3090,12 +3033,6 @@ static int spi_nor_setup(struct spi_nor *nor,
>   	return nor->params.setup(nor, hwcaps);
>   }
>   
> -static void macronix_set_default_init(struct spi_nor *nor)
> -{
> -	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
> -	nor->params.set_4byte = spi_nor_en4_ex4_set_4byte;
> -}
> -
>   static void sst_set_default_init(struct spi_nor *nor)
>   {
>   	nor->flags |= SNOR_F_HAS_LOCK;
> @@ -3123,10 +3060,6 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
>   {
>   	/* Init flash parameters based on MFR */
>   	switch (JEDEC_MFR(nor->info)) {
> -	case SNOR_MFR_MACRONIX:
> -		macronix_set_default_init(nor);
> -		break;
> -
>   	case SNOR_MFR_ST:
>   	case SNOR_MFR_MICRON:
>   		st_micron_set_default_init(nor);
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index b4ed9acbef63..9af3a701de95 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -175,6 +175,7 @@ extern const struct spi_nor_manufacturer spi_nor_fujitsu;
>   extern const struct spi_nor_manufacturer spi_nor_gigadevice;
>   extern const struct spi_nor_manufacturer spi_nor_intel;
>   extern const struct spi_nor_manufacturer spi_nor_issi;
> +extern const struct spi_nor_manufacturer spi_nor_macronix;
>   
>   int spi_nor_write_enable(struct spi_nor *nor);
>   int spi_nor_write_disable(struct spi_nor *nor);
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> new file mode 100644
> index 000000000000..1ae609c44676
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2005, Intec Automation Inc.
> + * Copyright (C) 2014, Freescale Semiconductor, Inc.
> + */
> +
> +#include <linux/mtd/spi-nor.h>
> +
> +#include "core.h"
> +
> +static int
> +mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
> +			    const struct sfdp_parameter_header *bfpt_header,
> +			    const struct sfdp_bfpt *bfpt,
> +			    struct spi_nor_flash_parameter *params)
> +{
> +	/*
> +	 * MX25L25635F supports 4B opcodes but MX25L25635E does not.
> +	 * Unfortunately, Macronix has re-used the same JEDEC ID for both
> +	 * variants which prevents us from defining a new entry in the parts
> +	 * table.
> +	 * We need a way to differentiate MX25L25635E and MX25L25635F, and it
> +	 * seems that the F version advertises support for Fast Read 4-4-4 in
> +	 * its BFPT table.
> +	 */
> +	if (bfpt->dwords[BFPT_DWORD(5)] & BFPT_DWORD5_FAST_READ_4_4_4)
> +		nor->flags |= SNOR_F_4B_OPCODES;
> +
> +	return 0;
> +}
> +
> +static struct spi_nor_fixups mx25l25635_fixups = {
> +	.post_bfpt = mx25l25635_post_bfpt_fixups,
> +};
> +
> +static const struct flash_info macronix_parts[] = {
> +	/* Macronix */
> +	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
> +	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
> +	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8, SECT_4K) },
> +	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
> +	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
> +	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
> +	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
> +	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
> +	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
> +	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
> +			      SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
> +	{ "mx25u4035",   INFO(0xc22533, 0, 64 * 1024,   8, SECT_4K) },
> +	{ "mx25u8035",   INFO(0xc22534, 0, 64 * 1024,  16, SECT_4K) },
> +	{ "mx25u6435f",  INFO(0xc22537, 0, 64 * 1024, 128, SECT_4K) },
> +	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
> +	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
> +	{ "mx25r3235f",  INFO(0xc22816, 0, 64 * 1024,  64,
> +			      SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
> +	{ "mx25u12835f", INFO(0xc22538, 0, 64 * 1024, 256,
> +			      SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
> +	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512,
> +			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
> +		.fixups = &mx25l25635_fixups },
> +	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512,
> +			      SECT_4K | SPI_NOR_4B_OPCODES) },
> +	{ "mx25v8035f",  INFO(0xc22314, 0, 64 * 1024,  16,
> +			      SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
> +	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
> +	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
> +			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +			      SPI_NOR_4B_OPCODES) },
> +	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024,
> +			      SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048,
> +			      SECT_4K | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ) },
> +	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
> +			      SPI_NOR_QUAD_READ) },
> +};
> +
> +static void macronix_default_init(struct spi_nor *nor)
> +{
> +	nor->params.quad_enable = spi_nor_sr1_bit6_quad_enable;
> +	nor->params.set_4byte = spi_nor_en4_ex4_set_4byte;
> +}
> +
> +static const struct spi_nor_fixups macronix_fixups = {
> +	.default_init = macronix_default_init,
> +};
> +
> +const struct spi_nor_manufacturer spi_nor_macronix = {
> +	.name = "macronix",
> +	.parts = macronix_parts,
> +	.nparts = ARRAY_SIZE(macronix_parts),
> +	.fixups = &macronix_fixups,
> +};



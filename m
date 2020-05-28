Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F2F208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QMaBLY1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgE1Kbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:31:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60956 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbgE1Kbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:31:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04SAVSRj081848;
        Thu, 28 May 2020 05:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590661888;
        bh=AEQTkef1+kNlzNaEHtQu4Pn0JuBaAy+rLXTEbnti/Us=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=QMaBLY1DCBcVNqupoVs0TM5pAtsLZi10NcXap32Gn+sTFLTJJGQAw68+uxr38Mdia
         u98YUmnGEdA1a5nkDdbcyoW/KpjNRJv6eWG/HgYB1HDuquF/mFwhXiZx4HYNxEv/+l
         /heW0alJzxC8z6R5D5eafJRU96x49KQZbRp2M//Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04SAVSwP037047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 05:31:28 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 28
 May 2020 05:30:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 28 May 2020 05:30:42 -0500
Received: from [10.250.234.195] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04SAUdGW082256;
        Thu, 28 May 2020 05:30:40 -0500
Subject: Re: [PATCH v1 1/1] drivers: mtd: spi-nor: update read capabilities
 for w25q64 and s25fl064k
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200521052608.32667-1-rayagonda.kokatanur@broadcom.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9dc3722e-497f-b092-6a97-01e0f7e3843c@ti.com>
Date:   Thu, 28 May 2020 16:00:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521052608.32667-1-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/05/20 10:56 am, Rayagonda Kokatanur wrote:
> Both w25q64 and s25fl064k nor flash support QUAD and DUAL read
> command, hence update the same in flash_info table.
> 

I am guessing both modes were tested on some platform?
Could you add that info here?

> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/mtd/spi-nor/spansion.c | 3 ++-
>  drivers/mtd/spi-nor/winbond.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 6756202ace4b..c91bbb8d9cd6 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -52,7 +52,8 @@ static const struct flash_info spansion_parts[] = {
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32,
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> -	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
> +	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "s25fl116k",  INFO(0x014015,      0,  64 * 1024,  32,
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "s25fl132k",  INFO(0x014016,      0,  64 * 1024,  64, SECT_4K) },
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 17deabad57e1..2028cab3eff9 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -39,7 +39,8 @@ static const struct flash_info winbond_parts[] = {
>  			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>  	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
> -	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
> +	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128,
> +			 SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
>  			   SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			   SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> 

Regards
Vignesh

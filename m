Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04468C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A1D246A8
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgB0SXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41178 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgB0SXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:23:25 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 433FA293427;
        Thu, 27 Feb 2020 18:23:24 +0000 (GMT)
Date:   Thu, 27 Feb 2020 19:23:21 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     shiva.linuxworks@gmail.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v4 4/5] mtd: spinand: micron: Add M70A series Micron SPI
 NAND devices
Message-ID: <20200227192321.17f9cdd3@collabora.com>
In-Reply-To: <20200206202206.14770-5-sshivamurthy@micron.com>
References: <20200206202206.14770-1-sshivamurthy@micron.com>
        <20200206202206.14770-5-sshivamurthy@micron.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Feb 2020 21:22:05 +0100
shiva.linuxworks@gmail.com wrote:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Add device table for M70A series Micron SPI NAND devices.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/nand/spi/micron.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index a8e947609cd9..3d3734afc35e 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -133,6 +133,26 @@ static const struct spinand_info micron_spinand_table[] = {
>  		     0,
>  		     SPINAND_ECCINFO(&micron_8_ooblayout,
>  				     micron_8_ecc_get_status)),
> +	/* M70A 4Gb 3.3V */
> +	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_CR_FEAT_BIT,
> +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +				     micron_8_ecc_get_status)),
> +	/* M70A 4Gb 1.8V */
> +	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_CR_FEAT_BIT,
> +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> +				     micron_8_ecc_get_status)),
>  };
>  
>  static int micron_spinand_detect(struct spinand_device *spinand)


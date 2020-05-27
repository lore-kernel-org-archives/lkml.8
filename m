Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4354F2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbgE0NxM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:53:12 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33555 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbgE0NxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:53:12 -0400
X-Originating-IP: 93.23.196.54
Received: from xps13 (54.196.23.93.rev.sfr.net [93.23.196.54])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AE2641BF213;
        Wed, 27 May 2020 13:53:05 +0000 (UTC)
Date:   Wed, 27 May 2020 15:53:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: arasan: select CONFIG_BCH
Message-ID: <20200527155304.0cf42848@xps13>
In-Reply-To: <20200527134210.847411-1-arnd@arndb.de>
References: <20200527134210.847411-1-arnd@arndb.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 27 May 2020 15:42:03 +0200:

> Like several other nand flash drivers, this one requires the BCH
> library to be selected from Kconfig.

Actually most of the time these drivers do not depend on BCH directly.
Here it is a bit particular: the hardware ECC engine logic being
broken, I found a workaround by using BCH's library functions directly
to verify the hardware correctness.

Anyway, thank you very much for the fix but if I didn't make a mistake
it should have been fixed yesterday night already, so it's probably not
in linux-next yet.

> arm-linux-gnueabi-ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_attach_chip':
> arasan-nand-controller.c:(.text+0x894): undefined reference to `bch_init'
> arm-linux-gnueabi-ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_detach_chip':
> arasan-nand-controller.c:(.text+0x98c): undefined reference to `bch_free'
> arm-linux-gnueabi-ld: drivers/mtd/nand/raw/arasan-nand-controller.o: in function `anfc_read_page_hw_ecc':
> arasan-nand-controller.c:(.text+0x1080): undefined reference to `bch_decode'
> 
> Fixes: 197b88fecc50 ("mtd: rawnand: arasan: Add new Arasan NAND controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mtd/nand/raw/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index e2bc87779bf9..113f61052269 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -456,6 +456,7 @@ config MTD_NAND_CADENCE
>  config MTD_NAND_ARASAN
>  	tristate "Support for Arasan NAND flash controller"
>  	depends on HAS_IOMEM && HAS_DMA
> +	select BCH
>  	help
>  	  Enables the driver for the Arasan NAND flash controller on
>  	  Zynq Ultrascale+ MPSoC.

Thanks,
Miquèl

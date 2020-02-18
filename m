Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB0C34035
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D206206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBRKp4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:45:56 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59775 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgBRKpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:45:55 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B9E5140017;
        Tue, 18 Feb 2020 10:45:53 +0000 (UTC)
Date:   Tue, 18 Feb 2020 11:45:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] mtd: rawnand: cadence: fix calculating avaialble
 oob size
Message-ID: <20200218114537.723436b3@xps13>
In-Reply-To: <1581328530-29966-2-git-send-email-piotrs@cadence.com>
References: <1581328530-29966-1-git-send-email-piotrs@cadence.com>
        <1581328530-29966-2-git-send-email-piotrs@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Mon, 10 Feb 2020 10:55:26
+0100:

There is a typo in the title (available).

> Previously ecc_sector size was used for calculation but its value
> was not yet known.

Can we rework a little bit this? What about:

	The value of cdns_chip->sector_count is not known at the moment
	of the derivation of ecc_size, leading to a zero value. Fix
	this by assigning ecc_size later in the code.

Also, I think it deserves a Fixes/Cc:stable tag!

> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> ---
>  drivers/mtd/nand/raw/cadence-nand-controller.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
> index 5063a8b493a4..2ebfd0934739 100644
> --- a/drivers/mtd/nand/raw/cadence-nand-controller.c
> +++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
> @@ -2595,7 +2595,7 @@ int cadence_nand_attach_chip(struct nand_chip *chip)
>  {
>  	struct cdns_nand_ctrl *cdns_ctrl = to_cdns_nand_ctrl(chip->controller);
>  	struct cdns_nand_chip *cdns_chip = to_cdns_nand_chip(chip);
> -	u32 ecc_size = cdns_chip->sector_count * chip->ecc.bytes;
> +	u32 ecc_size;
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	int ret;
>  
> @@ -2634,6 +2634,7 @@ int cadence_nand_attach_chip(struct nand_chip *chip)
>  	/* Error correction configuration. */
>  	cdns_chip->sector_size = chip->ecc.size;
>  	cdns_chip->sector_count = mtd->writesize / cdns_chip->sector_size;
> +	ecc_size = cdns_chip->sector_count * chip->ecc.bytes;
>  
>  	cdns_chip->avail_oob_size = mtd->oobsize - ecc_size;
>  

Thanks,
Miquèl

Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E075C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0179120684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395535AbgAPSWl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:22:41 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35717 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390359AbgAPSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:22:28 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 52FC1C0005;
        Thu, 16 Jan 2020 18:22:23 +0000 (UTC)
Date:   Thu, 16 Jan 2020 19:22:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     zdhays@gmail.com
Cc:     zhays@lexmark.com, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Piotr Sroka <piotrs@cadence.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: micron: don't error out if internal
 ECC is set
Message-ID: <20200116192221.49986c13@xps13>
In-Reply-To: <20200110162503.7185-1-zdhays@gmail.com>
References: <20200110162503.7185-1-zdhays@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zak,

zdhays@gmail.com wrote on Fri, 10 Jan 2020 11:25:01 -0500:

> From: Zak Hays <zdhays@gmail.com>
> 
> Recent changes to the driver require use of on-die correction if
> the internal ECC enable bit is set. On some Micron parts, this bit
> is enabled by default and there is no method for disabling it.
> 
> This is a false assumption though as that bit being enabled does not
> necessarily mean that the on-die ECC *has* to be used. It has been
> verified with a Micron FAE that other methods of error correction are
> still valid even if this bit is set.
> 
> HW ECC offers generally higher performance than on-die so it is
> preferred in some situations. This also allows multiple NAND parts to
> be supported on the same PCB as some parts may not support on-die
> error correction.
> 
> With that in mind, only throw a warning that the on-die bit is set
> and allow the init to continue.

I don't think I can take this patch as-is. We must find a reliable way
to discriminate Micron parts features. If we cannot (I think we can't
before of the endless list of bugs they have introduced without
documenting them), the best way is to build a static table.

> 
> Signed-off-by: Zak Hays <zdhays@gmail.com>
> ---
>  drivers/mtd/nand/raw/nand_micron.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> index 56654030ec7f..ec40c76443be 100644
> --- a/drivers/mtd/nand/raw/nand_micron.c
> +++ b/drivers/mtd/nand/raw/nand_micron.c
> @@ -455,9 +455,7 @@ static int micron_nand_init(struct nand_chip *chip)
>  
>  	if (ondie == MICRON_ON_DIE_MANDATORY &&
>  	    chip->ecc.mode != NAND_ECC_ON_DIE) {
> -		pr_err("On-die ECC forcefully enabled, not supported\n");
> -		ret = -EINVAL;
> -		goto err_free_manuf_data;
> +		pr_warn("WARNING: On-die ECC forcefully enabled, use caution with other methods\n");
>  	}
>  
>  	if (chip->ecc.mode == NAND_ECC_ON_DIE) {

Thanks,
Miquèl

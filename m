Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4298F2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgFKH1S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:27:18 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:51245 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:27:18 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C516324000C;
        Thu, 11 Jun 2020 07:27:08 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:27:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2/2] mtd: rawnand: brcmnand: Ecc error handling on EDU
 transfers
Message-ID: <20200611092707.75da8c6a@xps13>
In-Reply-To: <20200611054454.2547-2-kdasu.kdev@gmail.com>
References: <20200611054454.2547-1-kdasu.kdev@gmail.com>
        <20200611054454.2547-2-kdasu.kdev@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:54
-0400:

> Implemented ECC correctable and uncorrectable error handling for EDU

Implement?

> reads. If ECC correctable bitflips are encountered  on EDU transfer,

extra space                                         ^

> read page again using pio, This is needed due to a controller lmitation

s/pio/PIO/

> where read and corrected data is not transferred to the DMA buffer on ECC
> errors. This holds true for ECC correctable errors beyond set threshold.

error.

Not sure what the last sentence means?

> 
> Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---

Minor nits below :)

>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 0c1d6e543586..d7daa83c8a58 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1855,6 +1855,22 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
>  	edu_writel(ctrl, EDU_STOP, 0); /* force stop */
>  	edu_readl(ctrl, EDU_STOP);
>  
> +	if (ret == 0 && edu_cmd == EDU_CMD_READ) {

!ret

> +		u64 err_addr = 0;
> +
> +		/*
> +		 * check for ecc errors here, subpage ecc erros are
> +		 * retained in ecc error addr register

s/ecc/ECC/
s/erros/errors/
s/addr/address/

> +		 */
> +		err_addr = brcmnand_get_uncorrecc_addr(ctrl);
> +		if (!err_addr) {
> +			err_addr = brcmnand_get_correcc_addr(ctrl);
> +			if (err_addr)
> +				ret = -EUCLEAN;
> +		} else
> +			ret = -EBADMSG;

I don't like very much to see these values being used within NAND
controller drivers but I see it's already the cause, so I guess I can
live with that.

> +	}
> +
>  	return ret;
>  }
>  
> @@ -2058,6 +2074,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
>  	u64 err_addr = 0;
>  	int err;
>  	bool retry = true;
> +	bool edu_read = false;
>  
>  	dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
>  
> @@ -2075,6 +2092,10 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
>  			else
>  				return -EIO;
>  		}
> +
> +		if (has_edu(ctrl))
> +			edu_read = true;

You don't need this extra value, you already have the cmd parameter
which tells you if it is a read or a write. You might even want to
create a if block so set dir and edu_cmd and eventually a local
edu_read if you think it still makes sense.

> +
>  	} else {
>  		if (oob)
>  			memset(oob, 0x99, mtd->oobsize);
> @@ -2122,6 +2143,11 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
>  	if (mtd_is_bitflip(err)) {
>  		unsigned int corrected = brcmnand_count_corrected(ctrl);
>  
> +		/* in case of edu correctable error we read again using pio */

s/edu/EDU/ ?
s/pio/PIO/

> +		if (edu_read)
> +			err = brcmnand_read_by_pio(mtd, chip, addr, trans, buf,
> +						   oob, &err_addr);
> +
>  		dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
>  			(unsigned long long)err_addr);
>  		mtd->ecc_stats.corrected += corrected;

Thanks,
Miquèl

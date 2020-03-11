Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96741C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676AB2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgCKKNW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:13:22 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:32969 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCKKNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:13:22 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D912D40010;
        Wed, 11 Mar 2020 10:13:13 +0000 (UTC)
Date:   Wed, 11 Mar 2020 11:13:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spinand: wait for erase completion before
 writing bad block maker
Message-ID: <20200311111312.5c175916@xps13>
In-Reply-To: <20200310203224.410198-1-mikhail.kshevetskiy@oktetlabs.ru>
References: <20200310203224.410198-1-mikhail.kshevetskiy@oktetlabs.ru>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru> wrote on Tue, 10
Mar 2020 23:32:23 +0300:

> SPI flash will discard any write operation while it is busy with block
> erasing. As result bad block marker will not be writed to a flash.
> To fix it just wait for completion of erase operation.
> 
> The erasing code is almost the same as in spinand_erase(). The only
> difference is: we ignore ERASE_FAILED status.
> 
> This patch also improve error handling a bit.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@oktetlabs.ru>

Thanks a lot for sharing this!

Actually Frieder sent a fix for that I already added to nand/next,
please have a look at:
https://lore.kernel.org/linux-mtd/20200218100432.32433-1-frieder.schrempf@kontron.de/

If you think I'm missing something else, please tell me!

> ---
>  drivers/mtd/nand/spi/core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 89f6beefb01c..bb4eac400b0f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -610,6 +610,7 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
>  		.oobbuf.out = spinand->oobbuf,
>  	};
>  	int ret;
> +	u8 status;
>  
>  	/* Erase block before marking it bad. */
>  	ret = spinand_select_target(spinand, pos->target);
> @@ -620,7 +621,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
>  	if (ret)
>  		return ret;
>  
> -	spinand_erase_op(spinand, pos);
> +	ret = spinand_erase_op(spinand, pos);
> +	if (ret)
> +		return ret;
> +
> +	/* ignore status as erase may fail for bad blocks */
> +	spinand_wait(spinand, &status);
> +	if (ret)
> +		return ret;
>  
>  	memset(spinand->oobbuf, 0, 2);
>  	return spinand_write_page(spinand, &req);

Thanks,
Miquèl

Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A68C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127582074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgFKHQJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:16:09 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51971 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:16:08 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 0FEE5E0012;
        Thu, 11 Jun 2020 07:16:05 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:16:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  1/2] mtd: rawnand: brcmnand: Don't default to edu
 transfer
Message-ID: <20200611091604.1bec2418@xps13>
In-Reply-To: <20200611054454.2547-1-kdasu.kdev@gmail.com>
References: <20200611054454.2547-1-kdasu.kdev@gmail.com>
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

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:53
-0400:

> When flash-dma is absent do not default to using flash-edu.
> Make sure flash-edu is enabled before setting EDU transfer
> function.
> 
> Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 8f9ffb46a09f..0c1d6e543586 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -2953,8 +2953,9 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
>  		if (ret < 0)
>  			goto err;
>  
> -		/* set edu transfer function to call */
> -		ctrl->dma_trans = brcmnand_edu_trans;
> +		if (has_edu(ctrl))
> +			/* set edu transfer function to call */
> +			ctrl->dma_trans = brcmnand_edu_trans;

Does this fallback to returning an error in case !has_edu() ? Othewise,
how is it handled?

Thanks,
Miquèl

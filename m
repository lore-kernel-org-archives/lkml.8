Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5427AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1392068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgFOHYu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:24:50 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:50901 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgFOHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:24:50 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 470A3200014;
        Mon, 15 Jun 2020 07:24:44 +0000 (UTC)
Date:   Mon, 15 Jun 2020 09:24:43 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, wu000273@umn.edu, Han Xu <han.xu@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: gpmi: fix reference count leak due to
 pm_runtime_get_sync
Message-ID: <20200615092443.1e76169d@xps13>
In-Reply-To: <20200614034300.130385-1-pakki001@umn.edu>
References: <20200614034300.130385-1-pakki001@umn.edu>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

Aditya Pakki <pakki001@umn.edu> wrote on Sat, 13 Jun 2020 22:43:00
-0500:

> On calling pm_runtime_get_sync() the reference count of the device
> is incremented. In case of failure, decrement the
> reference count before returning the error.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Missing Fixes/Stable tags here I guess?

> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 061a8ddda275..657c0be5c038 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -149,8 +149,10 @@ static int gpmi_init(struct gpmi_nand_data *this)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(this->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(this->dev);
>  		return ret;
> +	}
>  
>  	ret = gpmi_reset_block(r->gpmi_regs, false);
>  	if (ret)
> @@ -2264,8 +2266,10 @@ static int gpmi_nfc_exec_op(struct nand_chip *chip,
>  		this->transfers[i].direction = DMA_NONE;
>  
>  	ret = pm_runtime_get_sync(this->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(this->dev);
>  		return ret;
> +	}
>  
>  	/*
>  	 * This driver currently supports only one NAND chip. Plus, dies share

Thanks,
Miquèl

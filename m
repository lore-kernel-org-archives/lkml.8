Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A801C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008B42072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFHMhv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:37:51 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50723 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgFHMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:37:50 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 11E49240013;
        Mon,  8 Jun 2020 12:37:40 +0000 (UTC)
Date:   Mon, 8 Jun 2020 14:37:39 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     richard@nod.at, vigneshr@ti.com, peter.ujfalusi@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: raw: qcom_nand: Fix register write error
Message-ID: <20200608143739.368f2b53@xps13>
In-Reply-To: <1591613254-1065-1-git-send-email-sivaprak@codeaurora.org>
References: <1591613254-1065-1-git-send-email-sivaprak@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sivaprakash,

Sivaprakash Murugesan <sivaprak@codeaurora.org> wrote on Mon,  8 Jun
2020 16:17:34 +0530:

Subject prefix should be mtd: rawnand: qcom:

And I don't think "Fix register write error" is relevant in any of the
two following cases.

> 1. SFLASHC_BURST_CFG register is not available on all ipq nand platforms,
>    it is available only on ipq8064 devices and the nand controller works
>    without configuring these registers in this platform, so register
>    write to this can be removed.
> 
> 2. Once BAM mode is enabled register writes to NAND_CTRL should be
>    performed through BAM command descriptors. The NAND BAM mode will
>    be enabled by bootloaders. Check if BAM mode is already enabled and
>    enable it only if not enabled already.
> 

It looks like there are two completely different changes that you are
doing here, please split.

Also, please explain why #2 is needed, it is not very clear.

Thanks,
Miquèl

> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 5b11c70..7bfd93a 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -36,7 +36,6 @@
>  #define	NAND_DEV_CMD1			0xa4
>  #define	NAND_DEV_CMD2			0xa8
>  #define	NAND_DEV_CMD_VLD		0xac
> -#define	SFLASHC_BURST_CFG		0xe0
>  #define	NAND_ERASED_CW_DETECT_CFG	0xe8
>  #define	NAND_ERASED_CW_DETECT_STATUS	0xec
>  #define	NAND_EBI2_ECC_BUF_CFG		0xf0
> @@ -2774,14 +2773,20 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>  	u32 nand_ctrl;
>  
>  	/* kill onenand */
> -	nandc_write(nandc, SFLASHC_BURST_CFG, 0);
>  	nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
>  		    NAND_DEV_CMD_VLD_VAL);
>  
>  	/* enable ADM or BAM DMA */
>  	if (nandc->props->is_bam) {
>  		nand_ctrl = nandc_read(nandc, NAND_CTRL);
> -		nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
> +		/* Once BAM_MODE_EN bit is set, writes to the NAND_CTRL
> +		 * should be done through BAM command descriptors.
> +		 * in most cases bootloader enables the bam mode we
> +		 * need to set the BAM mode only if it is not set by
> +		 * bootloader
> +		 */
> +		if (!(nand_ctrl & BAM_MODE_EN))
> +			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
>  	} else {
>  		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
>  	}


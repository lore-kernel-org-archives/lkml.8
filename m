Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE51C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339DF20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFIOEA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:00 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48203 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:03:57 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id D2DD120003;
        Tue,  9 Jun 2020 14:03:53 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:03:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     richard@nod.at, vigneshr@ti.com, peter.ujfalusi@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] mtd: rawnand: qcom: set BAM mode only if not set
 already
Message-ID: <20200609160352.60cbad80@xps13>
In-Reply-To: <1591701056-3944-3-git-send-email-sivaprak@codeaurora.org>
References: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
        <1591701056-3944-3-git-send-email-sivaprak@codeaurora.org>
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

Sivaprakash Murugesan <sivaprak@codeaurora.org> wrote on Tue,  9 Jun
2020 16:40:56 +0530:

> BAM mode is set by writing BAM_MODE_EN bit on NAND_CTRL register.
> NAND_CTRL is an operational register and in BAM mode operational
> registers are read only.
> 
> So, before writing into NAND_CTRL register check if BAM mode is already
> enabled by bootloader, and set BAM mode only if it is not set already.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index e0afa2c..7740059 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2779,7 +2779,14 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>  	/* enable ADM or BAM DMA */
>  	if (nandc->props->is_bam) {
>  		nand_ctrl = nandc_read(nandc, NAND_CTRL);
> -		nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
> +		/* NAND_CTRL is an operational registers, and CPU
> +		 * access to operational registers are read only
> +		 * in BAM mode. So update the NAND_CTRL register
> +		 * only if it is not in BAM mode. In most cases BAM
> +		 * mode will be enabled in bootloader
> +		 */
> +		if (!(nand_ctrl | BAM_MODE_EN))
> +			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
>  	} else {
>  		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
>  	}

Does this currently produces an issue at runtime?

If yes, you should have a Fixes/CC: stable pair of tags.

Also, what is BAM mode? Please tell us in the commit log.

Thanks,
Miquèl

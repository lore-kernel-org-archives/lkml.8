Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD9BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CD820801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgFLHXR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:23:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54707 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgFLHXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:23:16 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 926A320003;
        Fri, 12 Jun 2020 07:23:14 +0000 (UTC)
Date:   Fri, 12 Jun 2020 09:23:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     richard@nod.at, vigneshr@ti.com, peter.ujfalusi@ti.com,
        boris.brezillon@collabora.com, architt@codeaurora.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] mtd: rawnand: qcom: set BAM mode only if not set
 already
Message-ID: <20200612092313.3d8df859@xps13>
In-Reply-To: <1591944589-14357-3-git-send-email-sivaprak@codeaurora.org>
References: <1591944589-14357-1-git-send-email-sivaprak@codeaurora.org>
        <1591944589-14357-3-git-send-email-sivaprak@codeaurora.org>
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

Sivaprakash Murugesan <sivaprak@codeaurora.org> wrote on Fri, 12 Jun
2020 12:19:49 +0530:

> BAM is DMA controller on QCOM ipq platforms, BAM mode on NAND driver
> is set by writing BAM_MODE_EN bit on NAND_CTRL register.
> 
> NAND_CTRL is an operational register and in BAM mode operational
> registers are read only.
> 
> So, before writing into NAND_CTRL register check if BAM mode is already

So, before enabling BAM mode by writing the NAND_CTRL register, check
if BAM mode was already enabled by the bootloader.

> enabled by bootloader, and set BAM mode only if it is not set already.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V3]
>  * Changed commit message to give a small info about BAM
>  drivers/mtd/nand/raw/qcom_nandc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index e0c55bb..4827edd 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2784,7 +2784,14 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>  	/* enable ADM or BAM DMA */
>  	if (nandc->props->is_bam) {
>  		nand_ctrl = nandc_read(nandc, NAND_CTRL);
> -		nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
> +		/* NAND_CTRL is an operational registers, and CPU
> +		 * access to operational registers are read only
> +		 * in BAM mode. So update the NAND_CTRL register
> +		 * only if it is not in BAM mode. In most cases BAM

                                        BAM mode already (Bootloaders
                                        might have already entered
                                        this mode).

> +		 * mode will be enabled in bootloader
> +		 */
> +		if (!(nand_ctrl | BAM_MODE_EN))
> +			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
>  	} else {
>  		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
>  	}

Thanks,
Miquèl

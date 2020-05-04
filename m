Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E622AC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64F52073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgEDKcm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:32:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55772 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgEDKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:32:42 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 10EFE2A0821;
        Mon,  4 May 2020 11:32:40 +0100 (BST)
Date:   Mon, 4 May 2020 12:32:37 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, masonccyang@mxic.com.tw,
        christophe.kerello@st.com, stefan@agner.ch, piotrs@cadence.com,
        devik@eaxlabs.cz, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: raw: use write_oob_raw for MTD_OPS_AUTO_OOB mode
Message-ID: <20200504123237.5c128668@collabora.com>
In-Reply-To: <20200504094253.2741109-1-noltari@gmail.com>
References: <20200504094253.2741109-1-noltari@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 May 2020 11:42:53 +0200
Álvaro Fernández Rojas <noltari@gmail.com> wrote:

> Some NAND controllers change the ECC bytes when OOB is written with ECC
> enabled.
> This is a problem in brcmnand, since adding JFFS2 cleanmarkers after the page
> has been erased will change the ECC bytes to 0 and the controller will think
> the block is bad.
> It can be fixed by using write_oob_raw, which ensures ECC is disabled.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index c24e5e2ba130..755d25200520 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -488,7 +488,7 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
>  
>  	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
>  
> -	if (ops->mode == MTD_OPS_RAW)
> +	if (ops->mode == MTD_OPS_AUTO_OOB || ops->mode == MTD_OPS_RAW)
>  		status = chip->ecc.write_oob_raw(chip, page & chip->pagemask);

The doc says:

@MTD_OPS_PLACE_OOB:  OOB data are placed at the given offset (default)
@MTD_OPS_AUTO_OOB:   OOB data are automatically placed at the free areas
                     which are defined by the internal ecclayout
@MTD_OPS_RAW:        data are transferred as-is, with no error
		     correction; this mode implies %MTD_OPS_PLACE_OOB

To me, that means MTD_OPS_PLACE_OOB and MTD_OPS_AUTO_OOB do not imply
MTD_OPS_RAW. Anyway those modes are just too vague. We really should
separate the ECC-disabled/ECC-enabled concept (AKA raw vs non-raw mode)
from the OOB placement scheme. IIRC, Miquel had a patchset doing that.

We also should have the concept of protected OOB-region vs
unprotected-OOB-region if we want JFFS2 to work with controllers that
protect part of the OOB region. Once we have that we can patch JFFS2
to write things with "ECC-disabled"+"auto-OOB-placement-on-unprotected
area".

>  	else
>  		status = chip->ecc.write_oob(chip, page & chip->pagemask);


Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184A8C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0000A206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgEKQ3b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:29:31 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45141 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgEKQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:29:31 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BACE960012;
        Mon, 11 May 2020 16:29:24 +0000 (UTC)
Date:   Mon, 11 May 2020 18:29:23 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
        richard@nod.at, vigneshr@ti.com, s.hauer@pengutronix.de,
        masonccyang@mxic.com.tw, christophe.kerello@st.com,
        stefan@agner.ch, piotrs@cadence.com, devik@eaxlabs.cz,
        tglx@linutronix.de, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: raw: use write_oob_raw for MTD_OPS_AUTO_OOB mode
Message-ID: <20200511182923.6a4961ab@xps13>
In-Reply-To: <20200504123237.5c128668@collabora.com>
References: <20200504094253.2741109-1-noltari@gmail.com>
        <20200504123237.5c128668@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 4 May
2020 12:32:37 +0200:

> On Mon,  4 May 2020 11:42:53 +0200
> Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> 
> > Some NAND controllers change the ECC bytes when OOB is written with ECC
> > enabled.
> > This is a problem in brcmnand, since adding JFFS2 cleanmarkers after the page
> > has been erased will change the ECC bytes to 0 and the controller will think
> > the block is bad.
> > It can be fixed by using write_oob_raw, which ensures ECC is disabled.
> > 
> > Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index c24e5e2ba130..755d25200520 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -488,7 +488,7 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
> >  
> >  	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
> >  
> > -	if (ops->mode == MTD_OPS_RAW)
> > +	if (ops->mode == MTD_OPS_AUTO_OOB || ops->mode == MTD_OPS_RAW)
> >  		status = chip->ecc.write_oob_raw(chip, page & chip->pagemask);  
> 
> The doc says:
> 
> @MTD_OPS_PLACE_OOB:  OOB data are placed at the given offset (default)
> @MTD_OPS_AUTO_OOB:   OOB data are automatically placed at the free areas
>                      which are defined by the internal ecclayout
> @MTD_OPS_RAW:        data are transferred as-is, with no error
> 		     correction; this mode implies %MTD_OPS_PLACE_OOB
> 
> To me, that means MTD_OPS_PLACE_OOB and MTD_OPS_AUTO_OOB do not imply
> MTD_OPS_RAW. Anyway those modes are just too vague. We really should
> separate the ECC-disabled/ECC-enabled concept (AKA raw vs non-raw mode)
> from the OOB placement scheme. IIRC, Miquel had a patchset doing that.
> 
> We also should have the concept of protected OOB-region vs
> unprotected-OOB-region if we want JFFS2 to work with controllers that
> protect part of the OOB region. Once we have that we can patch JFFS2
> to write things with "ECC-disabled"+"auto-OOB-placement-on-unprotected
> area".

I see the problem but as Boris said the fix is not valid as-is.
Problem is: I don't have a better proposal yet.

Is forcing JFFS2 to write cleanmarkers in raw mode only an option?

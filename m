Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB9AC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B0120714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgELIoc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:44:32 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33491 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgELIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:44:31 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6C06A240007;
        Tue, 12 May 2020 08:44:23 +0000 (UTC)
Date:   Tue, 12 May 2020 10:44:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>, richard@nod.at,
        vigneshr@ti.com, s.hauer@pengutronix.de, masonccyang@mxic.com.tw,
        christophe.kerello@st.com, stefan@agner.ch, piotrs@cadence.com,
        devik@eaxlabs.cz, tglx@linutronix.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nand: raw: use write_oob_raw for MTD_OPS_AUTO_OOB mode
Message-ID: <20200512104422.4c31f7e0@xps13>
In-Reply-To: <6F41AA9B-71D6-47FA-BC12-24941F84DA71@gmail.com>
References: <20200504094253.2741109-1-noltari@gmail.com>
        <20200504123237.5c128668@collabora.com>
        <20200511182923.6a4961ab@xps13>
        <6F41AA9B-71D6-47FA-BC12-24941F84DA71@gmail.com>
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

Richard, maybe you'll have an idea to fix the situation here?

Álvaro Fernández Rojas <noltari@gmail.com> wrote on Tue, 12 May 2020
10:36:25 +0200:

> Hi,
> 
> > El 11 may 2020, a las 18:29, Miquel Raynal <miquel.raynal@bootlin.com> escribió:
> > 
> > Hello,
> > 
> > Boris Brezillon <boris.brezillon@collabora.com> wrote on Mon, 4 May
> > 2020 12:32:37 +0200:
> >   
> >> On Mon,  4 May 2020 11:42:53 +0200
> >> Álvaro Fernández Rojas <noltari@gmail.com> wrote:
> >>   
> >>> Some NAND controllers change the ECC bytes when OOB is written with ECC
> >>> enabled.
> >>> This is a problem in brcmnand, since adding JFFS2 cleanmarkers after the page
> >>> has been erased will change the ECC bytes to 0 and the controller will think
> >>> the block is bad.
> >>> It can be fixed by using write_oob_raw, which ensures ECC is disabled.
> >>> 
> >>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> >>> ---
> >>> drivers/mtd/nand/raw/nand_base.c | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>> 
> >>> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> >>> index c24e5e2ba130..755d25200520 100644
> >>> --- a/drivers/mtd/nand/raw/nand_base.c
> >>> +++ b/drivers/mtd/nand/raw/nand_base.c
> >>> @@ -488,7 +488,7 @@ static int nand_do_write_oob(struct nand_chip *chip, loff_t to,
> >>> 
> >>> 	nand_fill_oob(chip, ops->oobbuf, ops->ooblen, ops);
> >>> 
> >>> -	if (ops->mode == MTD_OPS_RAW)
> >>> +	if (ops->mode == MTD_OPS_AUTO_OOB || ops->mode == MTD_OPS_RAW)
> >>> 		status = chip->ecc.write_oob_raw(chip, page & chip->pagemask);    
> >> 
> >> The doc says:
> >> 
> >> @MTD_OPS_PLACE_OOB:  OOB data are placed at the given offset (default)
> >> @MTD_OPS_AUTO_OOB:   OOB data are automatically placed at the free areas
> >>                     which are defined by the internal ecclayout
> >> @MTD_OPS_RAW:        data are transferred as-is, with no error
> >> 		     correction; this mode implies %MTD_OPS_PLACE_OOB
> >> 
> >> To me, that means MTD_OPS_PLACE_OOB and MTD_OPS_AUTO_OOB do not imply
> >> MTD_OPS_RAW. Anyway those modes are just too vague. We really should
> >> separate the ECC-disabled/ECC-enabled concept (AKA raw vs non-raw mode)
> >> from the OOB placement scheme. IIRC, Miquel had a patchset doing that.
> >> 
> >> We also should have the concept of protected OOB-region vs
> >> unprotected-OOB-region if we want JFFS2 to work with controllers that
> >> protect part of the OOB region. Once we have that we can patch JFFS2
> >> to write things with "ECC-disabled"+"auto-OOB-placement-on-unprotected
> >> area".  
> > 
> > I see the problem but as Boris said the fix is not valid as-is.
> > Problem is: I don't have a better proposal yet.
> > 
> > Is forcing JFFS2 to write cleanmarkers in raw mode only an option?  
> 
> The doc says that for MTD_OPS_AUTO_OOB "the data is automatically placed at the free areas which are defined by the internal ecclayout”.
> So, if we’re placing this data in the free OOB area left by the ECC bytes it means that this automatically placed data won’t be error correctable, since it’s in the OOB, and the OOB data isn’t error corrected, right?

No, free bytes sometimes are and sometimes are not covered by the ECC
engine. It depends on the controller.

> The problem is that "flash_erase -j” uses MTD_OPS_AUTO_OOB to write the OOB JFFS2 clean markers and if this is written with ECC enabled the NAND controller will change the ECC bytes to an invalid value (or at least brcmnand controller).
> 
> Another option could be adding another mode, something like MTD_OPS_AUTO_OOB_RAW and using it in mtd-utils and JFFS2.

No, these modes already are completely wrong, I must resend my series
fixing them.


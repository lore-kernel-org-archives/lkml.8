Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D505C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5505A2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgFKPYW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:24:22 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43067 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:24:22 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 523F120000C;
        Thu, 11 Jun 2020 15:24:18 +0000 (UTC)
Date:   Thu, 11 Jun 2020 17:24:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: rawnand: brcmnand: Don't default to edu
 transfer
Message-ID: <20200611172417.66eb6c3b@xps13>
In-Reply-To: <CAC=U0a0ReuPpxZjB2vV_YNynrMx4OjzPmPPyJeVbhueFgFeNbQ@mail.gmail.com>
References: <20200611054454.2547-1-kdasu.kdev@gmail.com>
        <20200611091604.1bec2418@xps13>
        <CAC=U0a0ReuPpxZjB2vV_YNynrMx4OjzPmPPyJeVbhueFgFeNbQ@mail.gmail.com>
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

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 11:22:56
-0400:

> On Thu, Jun 11, 2020 at 3:16 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Kamal,
> >
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:53
> > -0400:
> >  
> > > When flash-dma is absent do not default to using flash-edu.
> > > Make sure flash-edu is enabled before setting EDU transfer
> > > function.
> > >
> > > Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > ---
> > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > index 8f9ffb46a09f..0c1d6e543586 100644
> > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > @@ -2953,8 +2953,9 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
> > >               if (ret < 0)
> > >                       goto err;
> > >
> > > -             /* set edu transfer function to call */
> > > -             ctrl->dma_trans = brcmnand_edu_trans;
> > > +             if (has_edu(ctrl))
> > > +                     /* set edu transfer function to call */
> > > +                     ctrl->dma_trans = brcmnand_edu_trans;  
> >
> > Does this fallback to returning an error in case !has_edu() ? Othewise,
> > how is it handled?
> >  
> 
>  The driver will default to pio if both flash-dma and falsh-edu are
> not present.
> 
> > Thanks,
> > Miquèl  
> 
> Kamal


Ok, thanks for the clarification!

Thanks,
Miquèl

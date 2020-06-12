Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1ECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEEB20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFLHHe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:07:34 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:10175 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFLHHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:07:33 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E578E240006;
        Fri, 12 Jun 2020 07:07:29 +0000 (UTC)
Date:   Fri, 12 Jun 2020 09:07:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: rawnand: brcmnand: Ecc error handling on EDU
 transfers
Message-ID: <20200612090728.043b6baf@xps13>
In-Reply-To: <CAC=U0a3RXScu12LkU+hCv_5Lp_he92ExRFSgqLkwx40D6Xtrag@mail.gmail.com>
References: <20200611054454.2547-1-kdasu.kdev@gmail.com>
        <20200611054454.2547-2-kdasu.kdev@gmail.com>
        <20200611092707.75da8c6a@xps13>
        <CAC=U0a3RXScu12LkU+hCv_5Lp_he92ExRFSgqLkwx40D6Xtrag@mail.gmail.com>
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

Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 12:04:29
-0400:

> On Thu, Jun 11, 2020 at 3:27 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Kamal,
> >
> > Kamal Dasu <kdasu.kdev@gmail.com> wrote on Thu, 11 Jun 2020 01:44:54
> > -0400:
> >  
> > > Implemented ECC correctable and uncorrectable error handling for EDU  
> >
> > Implement?
> >  
> > > reads. If ECC correctable bitflips are encountered  on EDU transfer,  
> >
> > extra space                                         ^
> >  
> > > read page again using pio, This is needed due to a controller lmitation  
> >
> > s/pio/PIO/
> >  
> > > where read and corrected data is not transferred to the DMA buffer on ECC
> > > errors. This holds true for ECC correctable errors beyond set threshold.  
> >
> > error.
> >
> > Not sure what the last sentence means?
> >  
> 
> NAND controller allows for setting a correctable  ECC threshold number
> of bits beyond which it will actually report the error to the driver.
> e.g. for BCH-4 the threshold is 3, so 3-bit and 4-bit errors will
> generate correctable ECC interrupt however 1-bit and 2-bit errors will
> be corrected silently.
> From the above example EDU hardware will not transfer corrected data
> to the DMA buffer for 3-bit and 4-bit errors that get reported. So
> once we detect
> the error duing EDU we read the page again using pio.

Ok I see what you mean, can't you fake the threshold instead? The NAND
controller in Linux is not supposed to handle this threshold, the NAND
core is in charge. So what the controller driver should do is just:
increase the number of bitflips + return the maximum number or bitflip
or increase the failure counter. Is this already the case?

> 
> > >
> > > Fixes: a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
> > > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> > > ---  
> >
> > Minor nits below :)
> >  
> > >  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 26 ++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > index 0c1d6e543586..d7daa83c8a58 100644
> > > --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> > > @@ -1855,6 +1855,22 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
> > >       edu_writel(ctrl, EDU_STOP, 0); /* force stop */
> > >       edu_readl(ctrl, EDU_STOP);
> > >
> > > +     if (ret == 0 && edu_cmd == EDU_CMD_READ) {  
> >
> > !ret
> >  
> > > +             u64 err_addr = 0;
> > > +
> > > +             /*
> > > +              * check for ecc errors here, subpage ecc erros are
> > > +              * retained in ecc error addr register  
> >
> > s/ecc/ECC/
> > s/erros/errors/
> > s/addr/address/
> >  
> > > +              */
> > > +             err_addr = brcmnand_get_uncorrecc_addr(ctrl);
> > > +             if (!err_addr) {
> > > +                     err_addr = brcmnand_get_correcc_addr(ctrl);
> > > +                     if (err_addr)
> > > +                             ret = -EUCLEAN;
> > > +             } else
> > > +                     ret = -EBADMSG;  
> >
> > I don't like very much to see these values being used within NAND
> > controller drivers but I see it's already the cause, so I guess I can

s/cause/case/

> > live with that.
> >  
> > > +     }
> > > +
> > >       return ret;
> > >  }
> > >
> > > @@ -2058,6 +2074,7 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
> > >       u64 err_addr = 0;
> > >       int err;
> > >       bool retry = true;
> > > +     bool edu_read = false;
> > >
> > >       dev_dbg(ctrl->dev, "read %llx -> %p\n", (unsigned long long)addr, buf);
> > >
> > > @@ -2075,6 +2092,10 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
> > >                       else
> > >                               return -EIO;
> > >               }
> > > +
> > > +             if (has_edu(ctrl))
> > > +                     edu_read = true;  
> >
> > You don't need this extra value, you already have the cmd parameter
> > which tells you if it is a read or a write. You might even want to
> > create a if block so set dir and edu_cmd and eventually a local
> > edu_read if you think it still makes sense.
> >  
> 
> I needed the value since dma and edu read has multiple conditions like
> oob is not included, buffer is aligned, virtual address is good. This
> indicates to
> the if (mtd_is_bitflip(err))  block that the error was from an edu
> transaction that happened.This way all ecc error handling for dma,
> edu, pio is in one place.
> Also there is more controller version specific logic for read error
> handling in there and this allows us to maintain the hierarchy how we
> handle both correctable
> and uncorrectable error.

Fair enough.

> 
> > > +
> > >       } else {
> > >               if (oob)
> > >                       memset(oob, 0x99, mtd->oobsize);
> > > @@ -2122,6 +2143,11 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
> > >       if (mtd_is_bitflip(err)) {
> > >               unsigned int corrected = brcmnand_count_corrected(ctrl);
> > >
> > > +             /* in case of edu correctable error we read again using pio */  
> >
> > s/edu/EDU/ ?
> > s/pio/PIO/
> >  
> > > +             if (edu_read)
> > > +                     err = brcmnand_read_by_pio(mtd, chip, addr, trans, buf,
> > > +                                                oob, &err_addr);
> > > +
> > >               dev_dbg(ctrl->dev, "corrected error at 0x%llx\n",
> > >                       (unsigned long long)err_addr);
> > >               mtd->ecc_stats.corrected += corrected;  
> >  
> 
> Will fix all the other typos.
> 
> > Thanks,
> > Miquèl  
> 
> Thanks
> Kamal


Thanks,
Miquèl

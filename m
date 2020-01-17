Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA2C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0946A2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAQHKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:10:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37425 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbgAQHKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:10:44 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1isLm1-0003Yx-HD; Fri, 17 Jan 2020 08:10:29 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1isLly-0000eh-QS; Fri, 17 Jan 2020 08:10:26 +0100
Date:   Fri, 17 Jan 2020 08:10:26 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     zdhays@gmail.com, zhays@lexmark.com,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: micron: don't error out if internal ECC
 is set
Message-ID: <20200117071026.gydlruw2cxre2r2u@pengutronix.de>
References: <20200110162503.7185-1-zdhays@gmail.com>
 <20200116192221.49986c13@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116192221.49986c13@xps13>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:02:50 up 62 days, 22:21, 55 users,  load average: 0.07, 0.07,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zak, Miquel,

On 20-01-16 19:22, Miquel Raynal wrote:
> Hi Zak,
> 
> zdhays@gmail.com wrote on Fri, 10 Jan 2020 11:25:01 -0500:
> 
> > From: Zak Hays <zdhays@gmail.com>
> > 
> > Recent changes to the driver require use of on-die correction if
> > the internal ECC enable bit is set. On some Micron parts, this bit
> > is enabled by default and there is no method for disabling it.

Which changes did you mean here?

> > This is a false assumption though as that bit being enabled does not
> > necessarily mean that the on-die ECC *has* to be used. It has been
> > verified with a Micron FAE that other methods of error correction are
> > still valid even if this bit is set.

It would be cool if a micron FAE can provide a document with all the
quirks and how those quirks can be handled.

> > HW ECC offers generally higher performance than on-die so it is
> > preferred in some situations. This also allows multiple NAND parts to
> > be supported on the same PCB as some parts may not support on-die
> > error correction.

By HW ECC you mean the host ecc controller?

> > With that in mind, only throw a warning that the on-die bit is set
> > and allow the init to continue.
> 
> I don't think I can take this patch as-is. We must find a reliable way
> to discriminate Micron parts features. If we cannot (I think we can't
> before of the endless list of bugs they have introduced without
> documenting them), the best way is to build a static table.

+1 for 'find a reliable way to discriminate Micron parts features'

Regards,
  Marco

> > 
> > Signed-off-by: Zak Hays <zdhays@gmail.com>
> > ---
> >  drivers/mtd/nand/raw/nand_micron.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
> > index 56654030ec7f..ec40c76443be 100644
> > --- a/drivers/mtd/nand/raw/nand_micron.c
> > +++ b/drivers/mtd/nand/raw/nand_micron.c
> > @@ -455,9 +455,7 @@ static int micron_nand_init(struct nand_chip *chip)
> >  
> >  	if (ondie == MICRON_ON_DIE_MANDATORY &&
> >  	    chip->ecc.mode != NAND_ECC_ON_DIE) {
> > -		pr_err("On-die ECC forcefully enabled, not supported\n");
> > -		ret = -EINVAL;
> > -		goto err_free_manuf_data;
> > +		pr_warn("WARNING: On-die ECC forcefully enabled, use caution with other methods\n");
> >  	}
> >  
> >  	if (chip->ecc.mode == NAND_ECC_ON_DIE) {
> 
> Thanks,
> Miquèl
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

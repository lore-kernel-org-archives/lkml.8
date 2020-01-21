Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F11C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C224125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUNki convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:40:38 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:35473 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgAUNki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:40:38 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id CED78FF809;
        Tue, 21 Jan 2020 13:40:34 +0000 (UTC)
Date:   Tue, 21 Jan 2020 14:40:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shivamurthy Shastri <shiva.linuxworks@gmail.com>
Subject: Re: [EXT] Re: [PATCH 3/4] mtd: spinand: Add M70A series Micron SPI
 NAND devices
Message-ID: <20200121144034.05a8f49d@xps13>
In-Reply-To: <MN2PR08MB6397062A37D39287E820A0D8B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
        <20200119145432.10405-4-sshivamurthy@micron.com>
        <20200120111626.7cb2f6c5@xps13>
        <MN2PR08MB6397062A37D39287E820A0D8B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Tue, 21 Jan 2020 12:23:20 +0000:

> Hi Miquel,
> 
> > 
> > Hi Shiva,
> > 
> > This is remark common to the four patches: you miss the 'v2' prefix in
> > the object.
> >   
> 
> Sorry for this mistake.
> I recognized this after sending out the patches.
> 
> > shiva.linuxworks@gmail.com wrote on Sun, 19 Jan 2020 15:54:31 +0100:
> >   
> > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > >
> > > Add device table for M70A series Micron SPI NAND devices.
> > >
> > > While at it, disable the Continuous Read feature which is enabled by
> > > default.  
> > 
> > Can you please give us more detail on why this is an issue?  
> 
> "Continuous Read" is the new feature added by the Micron for 
> M70A series devices. If this feature is enabled, the READ command 
> doesn't output the OOB area. The following short description
> describes this feature.
> 
> Description:
> If the Continuous Read feature is enabled, the device provides 
> the capability to read the whole block with a single command.
> However, the read command doesn't output the OOB area.
> 
> Read command behavior (if Continuous Read enabled):
> The READ CACHE command doesn't require the starting column address.
> The device always output the data starting from the first column of the
> cache register, and once the end of the cache register reached, the data
> output continues through the next page. With the continuous read mode,
> it is possible to read out the entire block using a single READ command, and
> once the end of the block reached, the output pins become High-Z state.

Ok I understand better. In this case there is no need to split this
commit, instead just reword the commit log to something like:

--->8---
Add device table for M70A series Micron SPI-NAND devices.

As opposed to the M60A series already supported, M70A parts have the
"Continuous Read" feature enabled by default which does not fit the
subsystem needs.

<here explain the feature>.

Hence, we disable the feature at probe time.
---8<---

However, below, you disable this bit for all the parts. Is this really
ok? Souldn't we make it more specific to this series?

> 
> > 
> > Shall we backport it to stable?  
> 
> This is not a bug fix and applicable only to M70A series devices, there is no
> need to backport.
> (FYI, the previously enabled device was M79A series)
> 
> > 
> > As a rule of thumb, when you start a sentence by "while at it" in a
> > commit message and this is not a trivial change : split the patch,
> > please. Unless this is really related and in this case explain how and
> > why in the commit message.  
> 
> Okay, I will explain in my next version.
> 
> >   
> > >
> > > Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > ---
> > >  drivers/mtd/nand/spi/micron.c | 31  
> > +++++++++++++++++++++++++++++++  
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/drivers/mtd/nand/spi/micron.c  
> > b/drivers/mtd/nand/spi/micron.c  
> > > index 5fd1f921ef12..45fc37c58f8a 100644
> > > --- a/drivers/mtd/nand/spi/micron.c
> > > +++ b/drivers/mtd/nand/spi/micron.c
> > > @@ -131,6 +131,26 @@ static const struct spinand_info  
> > micron_spinand_table[] = {  
> > >  		     0,
> > >  		     SPINAND_ECCINFO(&micron_8_ooblayout,
> > >  				     micron_8_ecc_get_status)),
> > > +	/* M70A 4Gb 3.3V */
> > > +	SPINAND_INFO("MT29F4G01ABAFD", 0x34,
> > > +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> > > +		     NAND_ECCREQ(8, 512),
> > > +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > > +					      &write_cache_variants,
> > > +					      &update_cache_variants),
> > > +		     0,
> > > +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> > > +				     micron_8_ecc_get_status)),
> > > +	/* M70A 4Gb 1.8V */
> > > +	SPINAND_INFO("MT29F4G01ABBFD", 0x35,
> > > +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> > > +		     NAND_ECCREQ(8, 512),
> > > +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> > > +					      &write_cache_variants,
> > > +					      &update_cache_variants),
> > > +		     0,
> > > +		     SPINAND_ECCINFO(&micron_8_ooblayout,
> > > +				     micron_8_ecc_get_status)),
> > >  };
> > >
> > >  static int micron_spinand_detect(struct spinand_device *spinand)
> > > @@ -153,8 +173,19 @@ static int micron_spinand_detect(struct  
> > spinand_device *spinand)  
> > >  	return 1;
> > >  }
> > >
> > > +static int micron_spinand_init(struct spinand_device *spinand)
> > > +{
> > > +	/*
> > > +	 * M70A device series enable Continuous Read feature at Power-up,
> > > +	 * which is not supported. Disable this bit to avoid any possible
> > > +	 * failure.
> > > +	 */
> > > +	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE, 0);
> > > +}
> > > +
> > >  static const struct spinand_manufacturer_ops  
> > micron_spinand_manuf_ops = {  
> > >  	.detect = micron_spinand_detect,
> > > +	.init = micron_spinand_init,
> > >  };
> > >
> > >  const struct spinand_manufacturer micron_spinand_manufacturer = {  
> > 
> > Thanks,
> > Miquèl  
> 
> Thanks,
> Shiva




Thanks,
Miquèl

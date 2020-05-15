Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D4E2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEOHdi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:33:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:44961 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgEOHdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:33:38 -0400
Received: from xps13 (126.249.23.93.rev.sfr.net [93.23.249.126])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7CA4C100006;
        Fri, 15 May 2020 07:33:32 +0000 (UTC)
Date:   Fri, 15 May 2020 09:33:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Poonam Aggrwal <poonam.aggrwal@nxp.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "shiva.linuxworks@gmail.com" <shiva.linuxworks@gmail.com>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Suram Suram <suram@nxp.com>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>
Subject: Re: [PATCH v7 0/6] Add new series Micron SPI NAND devices
Message-ID: <20200515093330.7e3b2911@xps13>
In-Reply-To: <VI1PR04MB70232F2A753142DE7E0D3A6986BD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20200311175735.2007-1-sshivamurthy@micron.com>
        <CA+G9fYuavikY4yjc+bjnvDGHGwQRs6bf31gUa3gyFzd=0zLR7Q@mail.gmail.com>
        <VI1PR04MB70232F2A753142DE7E0D3A6986BD0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Poonam,

Poonam Aggrwal <poonam.aggrwal@nxp.com> wrote on Fri, 15 May 2020
05:29:07 +0000:

> Adding Ashish.
> 
> Regards
> Poonam
> 
> > -----Original Message-----
> > From: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Sent: Friday, May 15, 2020 10:57 AM
> > To: shiva.linuxworks@gmail.com; Miquel Raynal <miquel.raynal@bootlin.com>;
> > Shivamurthy Shastri <sshivamurthy@micron.com>
> > Cc: Richard Weinberger <richard@nod.at>; Vignesh Raghavendra
> > <vigneshr@ti.com>; Boris Brezillon <boris.brezillon@collabora.com>;
> > Chuanhong Guo <gch981213@gmail.com>; Frieder Schrempf
> > <frieder.schrempf@kontron.de>; linux-mtd@lists.infradead.org; open list <linux-  
> > kernel@vger.kernel.org>; Poonam Aggrwal <poonam.aggrwal@nxp.com>;  
> > Suram Suram <suram@nxp.com>; lkft-triage@lists.linaro.org
> > Subject: Re: [PATCH v7 0/6] Add new series Micron SPI NAND devices
> > 
> > On Wed, 11 Mar 2020 at 23:28, <shiva.linuxworks@gmail.com> wrote:  
> > >
> > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > >
> > > This patchset is for the new series of Micron SPI NAND devices, and
> > > the following links are their datasheets.  
> > 
> > While boot NXP ls2088 device with mainline kernel the following nand warning
> > noticed. How critical this warning ?

Are you sure this is the right thread? Shivamurthy added SPI-NAND
support, you are talking about a raw NAND device.
> > 
> > [    1.357722] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x48
> > [    1.364085] nand: Micron MT29F16G08ABACAWP
> > [    1.368181] nand: 2048 MiB, SLC, erase size: 512 KiB, page size:
> > 4096, OOB size: 224
> > [    1.375932] nand: WARNING: 530000000.flash: the ECC used on your
> > system is too weak compared to the one required by the NAND chip

If you are talking about this one, it is pretty self explanatory: the
NAND chip requires a minimum correction which is not achieved here.
Either because the ECC engine cannot reach the requested amount (you
cannot do anything) or because you requested a too low correction with
DT properties.

> > 
> > [    1.388767] Bad block table found at page 524160, version 0x01
> > [    1.396833] Bad block table found at page 524032, version 0x01
> > [    1.403781] nand_read_bbt: bad block at 0x000002d00000
> > [    1.408921] nand_read_bbt: bad block at 0x000002d80000
> > [    1.414750] fsl,ifc-nand 530000000.nand: IFC NAND device at
> > 0x530000000, bank 2
> > 
> > 
> > Full test log,
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fqa-
> > reports.linaro.org%2Flkft%2Flinux-mainline-oe%2Fbuild%2Fv5.7-rc5-55-
> > g1ae7efb38854%2Ftestrun%2F18254%2Flog&amp;data=02%7C01%7Cpoonam.
> > aggrwal%40nxp.com%7C146f634c869f4c70baa108d7f8909ffb%7C686ea1d3bc2
> > b4c6fa92cd99c5c301635%7C0%7C0%7C637251172354638298&amp;sdata=%2B
> > Jhs%2Fb92%2BA56WzYdHe%2BBhXWfjk8feCGAFv%2BRzFKC9PM%3D&amp;rese
> > rved=0
> > 
> > - Naresh  

Thanks,
Miquèl

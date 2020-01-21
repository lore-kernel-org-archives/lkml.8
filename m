Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DB624125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAUP1k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:27:40 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:56163 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:27:39 -0500
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3B12A10000F;
        Tue, 21 Jan 2020 15:27:36 +0000 (UTC)
Date:   Tue, 21 Jan 2020 16:27:34 +0100
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
Message-ID: <20200121162734.464123fd@xps13>
In-Reply-To: <MN2PR08MB6397EE91C508B6DA2263F3D6B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
References: <20200119145432.10405-1-sshivamurthy@micron.com>
        <20200119145432.10405-4-sshivamurthy@micron.com>
        <20200120111626.7cb2f6c5@xps13>
        <MN2PR08MB6397062A37D39287E820A0D8B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
        <20200121144034.05a8f49d@xps13>
        <MN2PR08MB6397EE91C508B6DA2263F3D6B80D0@MN2PR08MB6397.namprd08.prod.outlook.com>
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
Tue, 21 Jan 2020 14:59:11 +0000:

> Hi Miquel,
> 
> > 
> > Hi Shivamurthy,
> > 
> > "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote
> > on
> > Tue, 21 Jan 2020 12:23:20 +0000:
> >   
> > > Hi Miquel,
> > >  
> > > >
> > > > Hi Shiva,
> > > >
> > > > This is remark common to the four patches: you miss the 'v2' prefix in
> > > > the object.
> > > >  
> > >
> > > Sorry for this mistake.
> > > I recognized this after sending out the patches.
> > >  
> > > > shiva.linuxworks@gmail.com wrote on Sun, 19 Jan 2020 15:54:31 +0100:
> > > >  
> > > > > From: Shivamurthy Shastri <sshivamurthy@micron.com>
> > > > >
> > > > > Add device table for M70A series Micron SPI NAND devices.
> > > > >
> > > > > While at it, disable the Continuous Read feature which is enabled by
> > > > > default.  
> > > >
> > > > Can you please give us more detail on why this is an issue?  
> > >
> > > "Continuous Read" is the new feature added by the Micron for
> > > M70A series devices. If this feature is enabled, the READ command
> > > doesn't output the OOB area. The following short description
> > > describes this feature.
> > >
> > > Description:
> > > If the Continuous Read feature is enabled, the device provides
> > > the capability to read the whole block with a single command.
> > > However, the read command doesn't output the OOB area.
> > >
> > > Read command behavior (if Continuous Read enabled):
> > > The READ CACHE command doesn't require the starting column address.
> > > The device always output the data starting from the first column of the
> > > cache register, and once the end of the cache register reached, the data
> > > output continues through the next page. With the continuous read mode,
> > > it is possible to read out the entire block using a single READ command, and
> > > once the end of the block reached, the output pins become High-Z state.  
> > 
> > Ok I understand better. In this case there is no need to split this
> > commit, instead just reword the commit log to something like:
> >   
> > --->8---  
> > Add device table for M70A series Micron SPI-NAND devices.
> > 
> > As opposed to the M60A series already supported, M70A parts have the
> > "Continuous Read" feature enabled by default which does not fit the
> > subsystem needs.
> > 
> > <here explain the feature>.
> > 
> > Hence, we disable the feature at probe time.
> > ---8<---
> >   
> 
> Sure, I will change as per your suggestion.
> 
> > However, below, you disable this bit for all the parts. Is this really
> > ok? Souldn't we make it more specific to this series?  
> 
> It is ok because this bit is unused in other series.

I would rather prefer to avoid this kind of arrangement. Please change
this bit only for the series which has it.


Thanks,
Miquèl

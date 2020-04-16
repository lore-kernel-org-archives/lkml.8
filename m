Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D3EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA2921BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503766AbgDPJim convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:38:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37342 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503607AbgDPJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:38:30 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DED562A1115;
        Thu, 16 Apr 2020 10:38:26 +0100 (BST)
Date:   Thu, 16 Apr 2020 11:38:22 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        anders.roxell@linaro.org, andriy.shevchenko@intel.com,
        arnd@arndb.de, brendanhiggins@google.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        miquel.raynal@bootlin.com, piotrs@cadence.com,
        qi-ming.wu@intel.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200416113822.2ef326cb@collabora.com>
In-Reply-To: <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
        <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 17:35:26 +0800
"Ramuthevar, Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> Hi Martin,
> 
>      Thank you so much for review comments and your time...
> 
> On 16/4/2020 6:05 am, Martin Blumenstingl wrote:
> > Hi,
> >
> > first of all: thank you for working on upstreaming this.
> > Especially since you are going to use the new exec_op style in v2 as
> > Boris suggested.
> >  
> >> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>
> >> This patch adds the new IP of Nand Flash Controller(NFC) support
> >> on Intel's Lightning Mountain(LGM) SoC.
> >>
> >> DMA is used for burst data transfer operation, also DMA HW supports
> >> aligned 32bit memory address and aligned data access by default.
> >> DMA burst of 8 supported. Data register used to support the read/write
> >> operation from/to device.  
> > I am wondering how this new hardware is different from the Lantiq NAND
> > controller IP - for which there is already a driver in mainline (it's
> > in drivers/mtd/nand/raw/xway_nand.c).
> > The CON and WAIT registers look suspiciously similar.
> >
> > As far as I understand the "old" SoCs (VRX200 and earlier) don't have
> > a built-in ECC engine. This seems to have changed with ARX300 though
> > (again, AFAIK).
> >
> > A bit of lineage on these SoCs (initially these were developed by
> > Infineon. Lantiq then started as an Infineon spin-off in 2009 and
> > was then acquired by Intel in 2015):
> > - Danube
> > - ARX100 from 2008/2009
> > - VRX200 from 2009/2010
> > - ARX300 from 2014
> > - GRX350 from 2015/2016
> > - GRX550 from 2017
> > - and now finally: LGM from 2020 (est.)
> >
> > The existing xway_nand driver supports the Danube, ARX100 and VRX200
> > SoCs.  
> Lantiq upstreamed a driver for an older version of this IP core 8 years 
> ago, see here:
> https://elixir.bootlin.com/linux/v5.5.6/source/drivers/mtd/nand/raw/xway_nand.c 
> It does not support DMA and ECC.

Then let's just extend this driver to support the new features. Plus,
we'll be happy to have one more of the existing driver converted to
->exec_op() ;-).

> This upstream driver works with the xrx200, I do not know how well it 
> works with other SoCs.
> 
> Regards
> Vadivel
> >
> >
> > Best regards,
> > Martin  


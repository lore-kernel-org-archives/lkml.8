Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D61DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621C52192A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504834AbgDPK2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:28:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504681AbgDPK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:26:26 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7C98B2A1375;
        Thu, 16 Apr 2020 11:26:23 +0100 (BST)
Date:   Thu, 16 Apr 2020 12:26:19 +0200
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
Message-ID: <20200416122619.2c481792@collabora.com>
In-Reply-To: <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
        <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
        <20200416113822.2ef326cb@collabora.com>
        <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 17:45:49 +0800
"Ramuthevar, Vadivel MuruganX"
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> >>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>>>
> >>>> This patch adds the new IP of Nand Flash Controller(NFC) support
> >>>> on Intel's Lightning Mountain(LGM) SoC.
> >>>>
> >>>> DMA is used for burst data transfer operation, also DMA HW supports
> >>>> aligned 32bit memory address and aligned data access by default.
> >>>> DMA burst of 8 supported. Data register used to support the read/write
> >>>> operation from/to device.  
> >>> I am wondering how this new hardware is different from the Lantiq NAND
> >>> controller IP - for which there is already a driver in mainline (it's
> >>> in drivers/mtd/nand/raw/xway_nand.c).
> >>> The CON and WAIT registers look suspiciously similar.
> >>>
> >>> As far as I understand the "old" SoCs (VRX200 and earlier) don't have
> >>> a built-in ECC engine. This seems to have changed with ARX300 though
> >>> (again, AFAIK).
> >>>
> >>> A bit of lineage on these SoCs (initially these were developed by
> >>> Infineon. Lantiq then started as an Infineon spin-off in 2009 and
> >>> was then acquired by Intel in 2015):
> >>> - Danube
> >>> - ARX100 from 2008/2009
> >>> - VRX200 from 2009/2010
> >>> - ARX300 from 2014
> >>> - GRX350 from 2015/2016
> >>> - GRX550 from 2017
> >>> - and now finally: LGM from 2020 (est.)
> >>>
> >>> The existing xway_nand driver supports the Danube, ARX100 and VRX200
> >>> SoCs.  
> >> Lantiq upstreamed a driver for an older version of this IP core 8 years
> >> ago, see here:
> >> https://elixir.bootlin.com/linux/v5.5.6/source/drivers/mtd/nand/raw/xway_nand.c
> >> It does not support DMA and ECC.  
> > Then let's just extend this driver to support the new features. Plus,  
> We do not have the platform to test also it's very old legacy driver .

Well, if it's similar enough, we want to have one driver.

> > we'll be happy to have one more of the existing driver converted to  
> > ->exec_op() ;-).  
> 
> I have completely adapted to ->exec_op() hook up to replace the legacy 
> call-back.

I suspect porting what you've done to the xway driver shouldn't be too
complicated.

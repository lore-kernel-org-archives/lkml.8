Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F3C35243
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C682075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgAXRR5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:17:57 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55193 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgAXRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:17:57 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 04F64E0003;
        Fri, 24 Jan 2020 17:17:52 +0000 (UTC)
Date:   Fri, 24 Jan 2020 18:17:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: Re: [RFC PATCH v2 00/10] Enable RK3066 NANDC for MK808
Message-ID: <20200124181751.721aa428@xps13>
In-Reply-To: <20200124163001.28910-1-jbx6244@gmail.com>
References: <20200124163001.28910-1-jbx6244@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Johan Jonker <jbx6244@gmail.com> wrote on Fri, 24 Jan 2020 17:29:51
+0100:

> DISCLAIMER: Use at your own risk.
> Status: For testing only!
> 
> Version: V2
> 
> Title: Enable RK3066 NANDC for MK808.
> 
> The majority of Rockchip devices use a closed source FTL driver
> to reduce wear leveling. This patch serie proposes
> an experimental raw NAND controller driver for basic tasks
> in order to get the bindings and the nodes accepted for in the dts files.
> 
> What does it do:
> 
> On module load this driver will reserve its resources.
> After initialization the MTD framework will then try to detect
> the type and number of NAND chips. When all conditions are met,
> it registers it self as MTD device.
> This driver is then ready to receive user commands
> such as to read and write NAND pages.
> 
> Test examples:
> 
> # dd if=/dev/mtd0 of=dd.bin bs=8192 count=4
> 
> # nanddump -a -l 32768 -f nanddump.bin /dev/mtd0
> 
> Not tested:
> 
> NANDC version 9.
> NAND raw write.

nandbiterrs -i /dev/mtd<x> to validate it works!

> RK3066 still has no support for Uboot.
> Any write command would interfere with data structures made by the boot loader.
> 
> Etc.
> 
> Problems:
> 
> No bad block support. Most devices use a FTL bad block map with tags
> that must be located on specific page locations which is outside
> the scope of the raw MTD framework.

I don't understand this story of bad block map. Are you comparing with
a vendor kernel?

If vendors invent new ways to handle MTD blocks it's sad but they will
never be compatible with mainline. It's a fact. However for an upstream
version, I don't get if there is any real issue? The location of the
BBM is not related to your controller driver but depends on the NAND
chip and as you say below we know provide three possible positions in
a block.

What you refer as the FTL is the equivalent of UBI in Linux, which
indeed offers to the user a linear logical view of all the valid blocks
while physically the data is spread across all the available
eraseblocks.

> 
> hynix_nand_init() add extra option NAND_BBM_LASTPAGE for H27UCG8T2ATR-BC.
> 
> No partition support. A FTL driver will store at random locations and
> a linear user specific layout does not fit within
> the generic character of this basic driver.
> 
> Driver assumes that IO pins are correctly set by the boot loader.

Which pins are you talking about? Are you missing a pinctrl driver?

> 
> Fixed timing setting.
> 
> RK3228A/RK3228B compatibility version 701 unknown
> RV1108 nand version unknown
> 
> Etc.
> 
> Todo:
> 
> MLC ?

This is not related to your NAND controller driver neither.


Cheers,
Miquèl

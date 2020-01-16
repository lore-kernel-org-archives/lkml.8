Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AB8C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC72077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgAPQds convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:33:48 -0500
Received: from mailoutvs21.siol.net ([185.57.226.212]:54468 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgAPQds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:33:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 20B0F523B22;
        Thu, 16 Jan 2020 17:33:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5RtdmHMpsPgp; Thu, 16 Jan 2020 17:33:45 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C6669523B46;
        Thu, 16 Jan 2020 17:33:45 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 808C9523B22;
        Thu, 16 Jan 2020 17:33:45 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: add OrangePi 3 with eMMC
Date:   Thu, 16 Jan 2020 17:33:45 +0100
Message-ID: <12435330.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20200116122944.sgl2fgxf5mrg6i52@gilmour.lan>
References: <20200115194216.173117-1-jernej.skrabec@siol.net> <4200557.LvFx2qVVIh@jernej-laptop> <20200116122944.sgl2fgxf5mrg6i52@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 16. januar 2020 ob 13:29:44 CET je Maxime Ripard napisal(a):
> On Thu, Jan 16, 2020 at 12:10:58AM +0100, Jernej Škrabec wrote:
> > Hi!
> > 
> > Dne sreda, 15. januar 2020 ob 22:57:31 CET je Rob Herring napisal(a):
> > > On Wed, Jan 15, 2020 at 1:42 PM Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > wrote:
> > > > OrangePi 3 can optionally have eMMC. Add a compatible for it.
> > > 
> > > Is this just a population option or a different board layout? If the
> > > former, I don't think you need a new compatible, just add/enable a
> > > node for the eMMC.
> > 
> > I have only board with eMMC but I imagine it's the former. Even so,
> > current
> > approach with Allwinner boards is to have two different board DT files,
> > one for each variant. This can be seen from
> > Documentation/devicetree/bindings/arm/ sunxi.yaml which has a lot of
> > compatibles ending with "-emmc". I guess reason for that is to avoid
> > having MMC controller being powered on for no reason.
> The main reason for that is that those populating options can be
> conflicting. For example, last week we discussed an issue about the
> eMMC being on the same pin set than an SPI flash, both options being
> available.
> 
> The solution Andre suggested then was to let the eMMC be disabled, and
> have the bootloader probe the emmc, and if found, enable
> it. Otherwise, it means that you have a SPI flash (and enable it).
> 
> I guess a similar solution would apply here.

From what I can tell from schematic, pins are dedicated for eMMC.

So what solution do you suggest? Put eMMC node in original OrangePi 3 DT and 
set status to disabled?

Best regards,
Jernej




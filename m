Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D03C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7132082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBKHKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:10:02 -0500
Received: from mailoutvs60.siol.net ([185.57.226.251]:46974 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727467AbgBKHKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:10:02 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id F143A521267;
        Tue, 11 Feb 2020 08:09:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sUOmFP3lA8oO; Tue, 11 Feb 2020 08:09:58 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 9883F521FDA;
        Tue, 11 Feb 2020 08:09:58 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id E6842521FD0;
        Tue, 11 Feb 2020 08:09:57 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: orangepi-3: Add eMMC node
Date:   Tue, 11 Feb 2020 08:09:57 +0100
Message-ID: <5325319.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20200211065141.2kn2gsg5kvzu7kl6@gilmour.lan>
References: <20200210174007.118575-1-jernej.skrabec@siol.net> <20200211065141.2kn2gsg5kvzu7kl6@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 11. februar 2020 ob 07:51:41 CET je Maxime Ripard napisal(a):
> On Mon, Feb 10, 2020 at 06:40:07PM +0100, Jernej Skrabec wrote:
> > OrangePi 3 can optionally have 8 GiB eMMC (soldered on board). Because
> > those pins are dedicated to eMMC exclusively, node can be added for both
> > variants (with and without eMMC). Kernel will then scan bus for presence
> > of eMMC and act accordingly.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > Changes since v1:
> > - don't make separate DT just for -emmc variant - add node to existing
> > 
> >   orangepi 3 DT
> >  
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts index
> > c311eee52a35..1e0abd9d047f 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> > @@ -144,6 +144,15 @@ brcm: sdio-wifi@1 {
> > 
> >  	};
> >  
> >  };
> > 
> > +&mmc2 {
> > +	vmmc-supply = <&reg_cldo1>;
> > +	vqmmc-supply = <&reg_bldo2>;
> > +	cap-mmc-hw-reset;
> > +	non-removable;
> 
> Given that non-removable is documented as "Non-removable slot (like
> eMMC); assume always present.", we should probably get rid of that
> property?

I checked mmc core code and this property means that bus will be scanned only 
once. In this form, node doesn't tell what kind of device is connected, so 
core has to scan it no matter if "non-removable" property is present or not. I 
maybe missed something though, so it would be great if someone can check it 
again.

Best regards,
Jernej



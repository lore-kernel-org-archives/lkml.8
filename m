Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8913AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F49320866
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHXVCV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:02:21 -0400
Received: from mailoutvs45.siol.net ([185.57.226.236]:55130 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726541AbgHXVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:02:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DAF8D5255E6;
        Mon, 24 Aug 2020 23:02:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8smrMg2Df_S6; Mon, 24 Aug 2020 23:02:10 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 836F5525654;
        Mon, 24 Aug 2020 23:02:10 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 31CFF5255E6;
        Mon, 24 Aug 2020 23:02:10 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org,
        Pablo =?ISO-8859-1?Q?Sebasti=E1n?= Greco 
        <pgreco@centosproject.org>
Cc:     robh+dt@kernel.org, icenowy@aosc.io, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix dcdc1 regulator
Date:   Mon, 24 Aug 2020 23:02:09 +0200
Message-ID: <2982591.9ztLHtxLPI@jernej-laptop>
In-Reply-To: <a25ee214-5316-f6c8-53ce-676aa3c8a8ca@centosproject.org>
References: <20200824193649.978197-1-jernej.skrabec@siol.net> <a25ee214-5316-f6c8-53ce-676aa3c8a8ca@centosproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 24. avgust 2020 ob 22:54:01 CEST je Pablo Sebastián Greco 
napisal(a):
> On 24/8/20 16:36, Jernej Skrabec wrote:
> > DCDC1 regulator powers many different subsystems. While some of them can
> > work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
> > between 3.24 V and 3.36 V. According to OS images provided by the board
> > manufacturer this regulator should be set to 3.3 V.
> > 
> > Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.
> > 
> > Fixes: da7ac948fa93 ("ARM: dts: sun8i: Add board dts file for Banana Pi M2
> > 
> > 		      Ultra")
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >   arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts index
> > 42d62d1ba1dc..ea15073f0c79 100644
> > --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> > @@ -223,16 +223,16 @@ &reg_aldo3 {
> > 
> >   };
> >   
> >   &reg_dc1sw {
> > 
> > -	regulator-min-microvolt = <3000000>;
> > -	regulator-max-microvolt = <3000000>;
> > +	regulator-min-microvolt = <3300000>;
> > +	regulator-max-microvolt = <3300000>;
> > 
> >   	regulator-name = "vcc-gmac-phy";
> >   
> >   };
> >   
> >   &reg_dcdc1 {
> >   
> >   	regulator-always-on;
> > 
> > -	regulator-min-microvolt = <3000000>;
> > -	regulator-max-microvolt = <3000000>;
> > -	regulator-name = "vcc-3v0";
> > +	regulator-min-microvolt = <3300000>;
> > +	regulator-max-microvolt = <3300000>;
> > +	regulator-name = "vcc-3v3";
> > 
> >   };
> >   
> >   &reg_dcdc2 {
> 
> Should this be done also for the bananapi-m2-berry?, it is basically the
> same device
> sun8i-v40-bananapi-m2-berry.dts

I think so but I would rather not do that without testing and I don't have 
that board.

Best regards,
Jernej




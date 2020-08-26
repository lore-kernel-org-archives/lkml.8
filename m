Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A5AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 508432075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598450730;
	bh=YkzcWB73ePr3Oil75zS5HXqhh0BUssf4jCPt3WQXWv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JM7jhIwVYwjBPbn+k/Z9SkvOadZpfWDsWYCFxaRnYH+/EVG5lpKYa/OOgANYHrPvC
	 OUymZR/1+dAbek+UVHPjZOw+RHgTPk9S5Jj5MnJyTl/ZZENFaGa9joV9zBZtHITl+j
	 3e2QGFI8GyGWfPdzWDk4rHMS9yw6tbDsKgKGC5o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgHZOF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZOF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:05:27 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1633208E4;
        Wed, 26 Aug 2020 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598450336;
        bh=YkzcWB73ePr3Oil75zS5HXqhh0BUssf4jCPt3WQXWv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AyWGoc8NK5xXU2LyoXkTZSSzMY+framiCGojSBWhjv8qiK67iwx/uPDC3FdRr4wnE
         MJ+tACUhGnG5HhmyBQ9W/nmL+VDnGRo6rdOT6uM35/3qXJwn9YXwD8Y3GacSeXxv9W
         gZG8SbjwpzcintC9fQPvyolV9akUUy4BQXgmyauQ=
Date:   Wed, 26 Aug 2020 15:58:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>, linuxarm@huawei.com,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>, mauro.chehab@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dtbs: hikey970: add wifi support
Message-ID: <20200826155851.72219d24@coco.lan>
In-Reply-To: <f055afe8-1888-48a4-4a4f-0ea031d1942c@arm.com>
References: <b22e5799fe16a6902f95a8bd3f0f41f5a260c1ad.1598421453.git.mchehab+huawei@kernel.org>
        <f055afe8-1888-48a4-4a4f-0ea031d1942c@arm.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 26 Aug 2020 13:41:49 +0100
Robin Murphy <robin.murphy@arm.com> escreveu:

> On 2020-08-26 06:57, Mauro Carvalho Chehab wrote:
> > The dwmmc2 is used on Hikey 970 for WiFi support. The
> > hi3670.dtsi adds it, but with status="disabled".
> > 
> > For WiFi to work,it needs to be enabled. While here, add
> > the missing properties:
> > 
> > 	#address-cells = <0x1>;
> > 	#size-cells = <0x0>;
> > 
> > and add
> > 	ti,non-removable
> > 
> > To DT properties, as the WiFi support is on a non-removable slot.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >   arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > index f218acceec0b..a2b0d2a1d09d 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> > @@ -402,6 +402,7 @@ &sd_clk_cfg_func
> >   
> >   &dwmmc2 { /* WIFI */
> >   	bus-width = <0x4>;
> > +	ti,non-removable;  
> 
> Why? This property is only defined for OMAP HSMMC controllers, which 
> this isn't, and you've already got the proper generic property right 
> there below. Plus in terms of Linux it will have zero effect, since it's 
> only parsed by the omap_hsmmc driver anyway.
> 
> >   	non-removable;
> >   	broken-cd;
> >   	cap-power-off-card;
> > @@ -409,8 +410,12 @@ &dwmmc2 { /* WIFI */
> >   	pinctrl-0 = <&sdio_pmx_func
> >   		     &sdio_clk_cfg_func  
> >   		     &sdio_cfg_func>;  
> > +	status = "ok";  
> 
> Have you noticed the context 6 lines below?
> 
> > +
> >   	/* WL_EN */
> >   	vmmc-supply = <&wlan_en>;
> > +	#address-cells = <0x1>;
> > +	#size-cells = <0x0>;  
> 
> These are already present in hi3670.dtsi. AFAICS Wifi support was merged 
> 18 months ago :/

My mistake! It seems that I need more caffeine today.
I wrote this patch for an older Kernel version (4.19). 

I ended porting it to 5.8, with also required another patch,
due to a regression between Kernel 5.7 and 5.8:

	https://lore.kernel.org/lkml/f0a2cb7ea606f1a284d4c23cbf983da2954ce9b6.1598420968.git.mchehab+huawei@kernel.org/

Thanks,
Mauro

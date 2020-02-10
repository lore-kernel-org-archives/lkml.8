Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DBDC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A4E2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581360904;
	bh=6pgtcQndcROYmWBHJTcegWLxUbTrUDy+hULdIFfEwTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jl903rIHDq83YXgNnuaBa6H9MQ+aq6qZVjFybC7qC3mQOjtu+YtIKHyfO+YbkLErV
	 AgDcVBPjJ+sJVVqwKBSPPKFXDmmiZQLTe5HOLGA8x7JQJlMIJO2HdakZqoZUVt9bF8
	 nODddQcvd6+MKbKmXTiYMiqu+eNP7Xw4jlfnUgys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBJSzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:55:03 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40278 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBJSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:55:03 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so1575211edx.7;
        Mon, 10 Feb 2020 10:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jlkep5BMgERBHRiRFRjnqMtZPt75n7yCPDHspM4Vr4s=;
        b=pEvR8ABTtQkrO9u6pVgAlLHW7KBW3peH1uZYJ2eqTKxZ7Tj9nedUCZoATzhRnostW7
         PloRMJ5o9wcPZcJXjgPNKdbuky18rMhsSGVmFO8owtO5mFJgCsZFYisCdC2a6oOSkYBR
         JkrT4YL2WjB/6zdE6xNLDf3hMxGM7PTaJQ+uLpuSFBK/r1W+sQrbHSEiA556+//b836t
         zkQHNc1Bzt1A6syHSrSDc5qBNMip1Om8XdpActNsX1mSFIrVmzDpHI4cWsJTG33dq98C
         ZceSe3ZscFFJ2G6+Ke53h4hNBPtL13Ntu0OdAmTDtQx4GqNy1QrkELIgsf+YYq7D4zcw
         xteQ==
X-Gm-Message-State: APjAAAWptcotSWc9c73ehDLs8lMSVydvighn6UcGldlIxYcFQzrXJUE5
        f9OAg4YzH/KBJfapeDs6ddY=
X-Google-Smtp-Source: APXvYqw0gOeAueOeG/UOMWpy/5re47tSz7mLAaISIcnPIQ/kq1PJH7gsUfZZce4d+I4k2uUUDYoxfQ==
X-Received: by 2002:a05:6402:14d6:: with SMTP id f22mr2415351edx.59.1581360901336;
        Mon, 10 Feb 2020 10:55:01 -0800 (PST)
Received: from kozik-lap ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id j21sm74756eds.8.2020.02.10.10.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 10:55:00 -0800 (PST)
Date:   Mon, 10 Feb 2020 19:54:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 2/3] ARM: dts: exynos: Add missing usbdrd3 suspend clk
Message-ID: <20200210185458.GA16433@kozik-lap>
References: <20200210105108.1128-1-linux.amoon@gmail.com>
 <20200210105108.1128-3-linux.amoon@gmail.com>
 <20200210135008.GA2163@pi3>
 <CANAwSgT9_8JhjyN9yfZ6=AUE7kVhrrTwdK1KFQLwxuNSYyBKKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgT9_8JhjyN9yfZ6=AUE7kVhrrTwdK1KFQLwxuNSYyBKKA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:43:45PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> Thanks for your review comments.
> 
> On Mon, 10 Feb 2020 at 19:20, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Mon, Feb 10, 2020 at 10:51:07AM +0000, Anand Moon wrote:
> > > This patch adds new combatible strings for USBDRD3
> > > for adding missing suspend clk, exynos5422 usbdrd3
> > > support two clk USBD300 and SCLK_USBD300, so add missing
> > > suspemd_clk for Exynos542x DWC3 nodes.
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
> > >  arch/arm/boot/dts/exynos54xx.dtsi | 4 ++--
> > >  2 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> > > index b672080e7469..bd505256a223 100644
> > > --- a/arch/arm/boot/dts/exynos5420.dtsi
> > > +++ b/arch/arm/boot/dts/exynos5420.dtsi
> > > @@ -1372,8 +1372,8 @@ &trng {
> > >  };
> > >
> > >  &usbdrd3_0 {
> > > -     clocks = <&clock CLK_USBD300>;
> > > -     clock-names = "usbdrd30";
> > > +     clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
> > > +     clock-names = "usbdrd30", "usbdrd30_susp_clk";
> > >  };
> > >
> > >  &usbdrd_phy0 {
> > > @@ -1383,8 +1383,8 @@ &usbdrd_phy0 {
> > >  };
> > >
> > >  &usbdrd3_1 {
> > > -     clocks = <&clock CLK_USBD301>;
> > > -     clock-names = "usbdrd30";
> > > +     clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
> > > +     clock-names = "usbdrd30", "usbdrd30_susp_clk";
> > >  };
> > >
> > >  &usbdrd_dwc3_1 {
> > > diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> > > index 8aa5117e58ce..0aac6255de5d 100644
> > > --- a/arch/arm/boot/dts/exynos54xx.dtsi
> > > +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> > > @@ -143,7 +143,7 @@ hsi2c_7: i2c@12cd0000 {
> > >               };
> > >
> > >               usbdrd3_0: usb3-0 {
> > > -                     compatible = "samsung,exynos5250-dwusb3";
> > > +                     compatible = "samsung,exynos5420-dwusb3";
> > >                       #address-cells = <1>;
> > >                       #size-cells = <1>;
> > >                       ranges;
> > > @@ -165,7 +165,7 @@ usbdrd_phy0: phy@12100000 {
> > >               };
> > >
> > >               usbdrd3_1: usb3-1 {
> > > -                     compatible = "samsung,exynos5250-dwusb3";
> > > +                     compatible = "samsung,exynos5420-dwusb3";
> >
> > This affects also Exynos5410 but you do not add new clock there.
> >
> > Best regards,
> > Krzysztof
> >
> 
> Ok I will update this Exynos5410 dts.
> 
> Is samsung,exynos54xx-dwusb3 is valid compatible string
> for both the SoC.

The compatible should not be wildcard so keep it as
samsung,exynos5420-dwusb3.

Best regards,
Krzysztof


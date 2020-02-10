Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B5C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7EE20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3+u35TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgBJRN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:13:57 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39423 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgBJRN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:13:56 -0500
Received: by mail-il1-f193.google.com with SMTP id f70so867879ill.6;
        Mon, 10 Feb 2020 09:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OMBPex9jA3tUl+7G1mNGvd+gODbNk9naFIiYtHyZvE=;
        b=K3+u35TRE63GpeI94Hcn56aHL8TkE541qoXK4T7pzDuUVHd/PJJs0tLOqs6FC8yY5o
         726WSroyELFlw1KtSEUQLBCA0g1r7uzJt/iSTVqQUSUw/Jg7nrgOrsdPhmF2s95Cbs9F
         WlN10IwmMwrfqN+rIKiJSzFhVo4BY3/ZvpEvNt97HH68wf5XE4Ky0RsiiGauGEWUNuOd
         3l4uNYCbPjjBzRJYg7thZs6TGobcYZhGNhVymUQvPaUR6ttu0q6Fof7fg9Pgt32Xr72p
         9xf9tMegJuvTL1Jm7qdxggl5uKd7lHKwSzXxA7eJ/FEViiylzLaBH9tnDPFwGuvKz7bA
         zrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OMBPex9jA3tUl+7G1mNGvd+gODbNk9naFIiYtHyZvE=;
        b=UwBOftJcfwI3FEFxpH9nePAkDvtd/22Ob46ATtv3Z0LZExvRcHR3Xra5vZTmXrQ4Z+
         HIjzPwfYZSZ6l7tNPTmd4MBOHqx7c5jbdv6o4Zz8t3YXVABf1N0qT5gP6PEHoewnlBaO
         g6xYXNfAjNTWWpaPcl1HWTgvsSORJ+vBW9m7iv/rwGpJcjJA7ddXmBqbLj85fGouQrZr
         BVTNj1GTudlGEyaHWBt+qu5JLIrfI1dBqN5p1G6uT2jX8VHWzCnYvG2Yd4pRtJ8GyeSV
         IZx2Qa4nY7A9R60+ZM6eBeQSeytCLV9+3ePWEInCEuV0euND1Wbrqzi65YOC4+jo9/Ub
         hcFQ==
X-Gm-Message-State: APjAAAUP6LaXEki+8fTvkmwpwXzLuNsNprnN5jRkUIX2OCP40WDoJCxG
        iBE6ETzBaxLtIpGFX8xbglQYkraujhQMcCXchQ4=
X-Google-Smtp-Source: APXvYqxOleLjjkfnqGbk8s3yYuPx72eh3yoUqE6ukevQxdLc3Qx2eaHu6jnI3/Zfma3Bg3N/Oppma3JGFLT047sLatM=
X-Received: by 2002:a92:9507:: with SMTP id y7mr2270185ilh.243.1581354835793;
 Mon, 10 Feb 2020 09:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20200210105108.1128-1-linux.amoon@gmail.com> <20200210105108.1128-3-linux.amoon@gmail.com>
 <20200210135008.GA2163@pi3>
In-Reply-To: <20200210135008.GA2163@pi3>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 10 Feb 2020 22:43:45 +0530
Message-ID: <CANAwSgT9_8JhjyN9yfZ6=AUE7kVhrrTwdK1KFQLwxuNSYyBKKA@mail.gmail.com>
Subject: Re: [PATCHv3 2/3] ARM: dts: exynos: Add missing usbdrd3 suspend clk
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your review comments.

On Mon, 10 Feb 2020 at 19:20, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Feb 10, 2020 at 10:51:07AM +0000, Anand Moon wrote:
> > This patch adds new combatible strings for USBDRD3
> > for adding missing suspend clk, exynos5422 usbdrd3
> > support two clk USBD300 and SCLK_USBD300, so add missing
> > suspemd_clk for Exynos542x DWC3 nodes.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm/boot/dts/exynos5420.dtsi | 8 ++++----
> >  arch/arm/boot/dts/exynos54xx.dtsi | 4 ++--
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> > index b672080e7469..bd505256a223 100644
> > --- a/arch/arm/boot/dts/exynos5420.dtsi
> > +++ b/arch/arm/boot/dts/exynos5420.dtsi
> > @@ -1372,8 +1372,8 @@ &trng {
> >  };
> >
> >  &usbdrd3_0 {
> > -     clocks = <&clock CLK_USBD300>;
> > -     clock-names = "usbdrd30";
> > +     clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBD300>;
> > +     clock-names = "usbdrd30", "usbdrd30_susp_clk";
> >  };
> >
> >  &usbdrd_phy0 {
> > @@ -1383,8 +1383,8 @@ &usbdrd_phy0 {
> >  };
> >
> >  &usbdrd3_1 {
> > -     clocks = <&clock CLK_USBD301>;
> > -     clock-names = "usbdrd30";
> > +     clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBD301>;
> > +     clock-names = "usbdrd30", "usbdrd30_susp_clk";
> >  };
> >
> >  &usbdrd_dwc3_1 {
> > diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> > index 8aa5117e58ce..0aac6255de5d 100644
> > --- a/arch/arm/boot/dts/exynos54xx.dtsi
> > +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> > @@ -143,7 +143,7 @@ hsi2c_7: i2c@12cd0000 {
> >               };
> >
> >               usbdrd3_0: usb3-0 {
> > -                     compatible = "samsung,exynos5250-dwusb3";
> > +                     compatible = "samsung,exynos5420-dwusb3";
> >                       #address-cells = <1>;
> >                       #size-cells = <1>;
> >                       ranges;
> > @@ -165,7 +165,7 @@ usbdrd_phy0: phy@12100000 {
> >               };
> >
> >               usbdrd3_1: usb3-1 {
> > -                     compatible = "samsung,exynos5250-dwusb3";
> > +                     compatible = "samsung,exynos5420-dwusb3";
>
> This affects also Exynos5410 but you do not add new clock there.
>
> Best regards,
> Krzysztof
>

Ok I will update this Exynos5410 dts.

Is samsung,exynos54xx-dwusb3 is valid compatible string
for both the SoC.

-Anand

Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD064C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEB824679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dtw6/+Ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgB0Fyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:54:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46411 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgB0Fyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:54:31 -0500
Received: by mail-qt1-f196.google.com with SMTP id i14so1410851qtv.13;
        Wed, 26 Feb 2020 21:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JG6Di4Gll3ra/P/kq24/31+1wa1Oo6M8vrUkvuZY4ls=;
        b=dtw6/+Ad0LCrN8QWEFAr0Kq717Kpi210ws5TZRsscrzkH6qznd71bIsRibeXXIii7H
         D9H+5XIcpLvVvDFTfJZyUFQkXPWDmnnbywN7tCgCoP3uFWYPIJOLw3tjCyM+8ShSd5xf
         eb1LJyIBbg3qkOzNsCiwLkZI6M0Uep7JPbw2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JG6Di4Gll3ra/P/kq24/31+1wa1Oo6M8vrUkvuZY4ls=;
        b=CjM3w/o6knTVIJlZP6iCbnwLjElIJIZ/be7t78LMbu0Rq7QxS2orb9aTTN4EN1xAU8
         lZGGUrox0WfyeUFDxtbVgj5Zu+VFCXeONO3d2QNqLj0IIPCep46B99bvDBeUhsodcMqj
         1ttPL8bRnX0yHn+4TIsb4RUFZrWw/eB4zVePh8S/65FBNquBrv9ZP36e7ko9z3VkCNZY
         2/7/PnjLGcpFrHTwll+ygWRX5A4XUGatC4dUtf+Q4dV1LCCEvkCpjRGlmQbioAkrEb48
         /qXIkQDSEzuqCIG+BUr7KnYpZDJmvxLlrrfPVW294DH56doEzYofr3+DLQ+xH8fyz0Bk
         eHXg==
X-Gm-Message-State: APjAAAVhuvlmSfJWbtX5xfnb90RyCBti53EOY6jxOh3RTDdunW+lfdz5
        U5eAH/R4TREN1uTd01wmQV+kSP0cLxuLLfkQMCQ=
X-Google-Smtp-Source: APXvYqwOTL0JsvR5hVzDIrVzEDRplaPhO41VCXL2WSvZ91+hn3KwgtVR4fKkEaxwcoirvnDYS32rvgGm5x23WhE7Pi0=
X-Received: by 2002:ac8:4244:: with SMTP id r4mr2803245qtm.169.1582782870414;
 Wed, 26 Feb 2020 21:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20200226230346.672-1-rentao.bupt@gmail.com> <20200226230346.672-5-rentao.bupt@gmail.com>
 <7a210c19a7793b925275dbd8392e3c1ef538b229.camel@kernel.crashing.org>
In-Reply-To: <7a210c19a7793b925275dbd8392e3c1ef538b229.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 Feb 2020 05:54:19 +0000
Message-ID: <CACPK8XeDBeU+c=Fgcj_CYo3AG02+JX9eD4ABkwO64uMXh+hTtQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] ARM: dts: aspeed-g6: add usb functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Tao Ren <rentao.bupt@gmail.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 at 04:10, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add USB components and according pin groups in aspeed-g6 dtsi.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will take this patch through the aspeed tree for 5.7.

Cheers,

Joel


>
> > ---
> >  No change in v3/v4.
> >  Changes in v2:
> >    - added port/endpoint properties for vhub dt node.
> >
> >  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 25 +++++++++++++
> >  arch/arm/boot/dts/aspeed-g6.dtsi         | 45
> > ++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > index 045ce66ca876..7028e21bdd98 100644
> > --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> > @@ -1112,6 +1112,31 @@
> >               groups = "UART9";
> >       };
> >
> > +     pinctrl_usb2ah_default: usb2ah_default {
> > +             function = "USB2AH";
> > +             groups = "USBA";
> > +     };
> > +
> > +     pinctrl_usb2ad_default: usb2ad_default {
> > +             function = "USB2AD";
> > +             groups = "USBA";
> > +     };
> > +
> > +     pinctrl_usb2bh_default: usb2bh_default {
> > +             function = "USB2BH";
> > +             groups = "USBB";
> > +     };
> > +
> > +     pinctrl_usb2bd_default: usb2bd_default {
> > +             function = "USB2BD";
> > +             groups = "USBB";
> > +     };
> > +
> > +     pinctrl_usb11bhid_default: usb11bhid_default {
> > +             function = "USB11BHID";
> > +             groups = "USBB";
> > +     };
> > +
> >       pinctrl_vb_default: vb_default {
> >               function = "VB";
> >               groups = "VB";
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> > b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 796976d275e1..0a29b3b57a9d 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -245,6 +245,51 @@
> >                       status = "disabled";
> >               };
> >
> > +             ehci0: usb@1e6a1000 {
> > +                     compatible = "aspeed,ast2600-ehci", "generic-
> > ehci";
> > +                     reg = <0x1e6a1000 0x100>;
> > +                     interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_usb2ah_default>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             ehci1: usb@1e6a3000 {
> > +                     compatible = "aspeed,ast2600-ehci", "generic-
> > ehci";
> > +                     reg = <0x1e6a3000 0x100>;
> > +                     interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_usb2bh_default>;
> > +                     status = "disabled";
> > +             };
> > +
> > +             uhci: usb@1e6b0000 {
> > +                     compatible = "aspeed,ast2600-uhci", "generic-
> > uhci";
> > +                     reg = <0x1e6b0000 0x100>;
> > +                     interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #ports = <2>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
> > +                     status = "disabled";
> > +                     /*
> > +                      * No default pinmux, it will follow EHCI, use
> > an
> > +                      * explicit pinmux override if EHCI is not
> > enabled.
> > +                      */
> > +             };
> > +
> > +             vhub: usb-vhub@1e6a0000 {
> > +                     compatible = "aspeed,ast2600-usb-vhub";
> > +                     reg = <0x1e6a0000 0x350>;
> > +                     interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     aspeed,vhub-downstream-ports = <7>;
> > +                     aspeed,vhub-generic-endpoints = <21>;
> > +                     pinctrl-names = "default";
> > +                     pinctrl-0 = <&pinctrl_usb2ad_default>;
> > +                     status = "disabled";
> > +             };
> > +
> >               apb {
> >                       compatible = "simple-bus";
> >                       #address-cells = <1>;
>

Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F95FC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884C24679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="AFGunOiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgB0Fys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:54:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41002 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgB0Fyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:54:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so1435468qtr.8;
        Wed, 26 Feb 2020 21:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2Lzw+6DwIXD5wFIdGhdMkBNEqUvLgerW4Hymt2eRxg=;
        b=AFGunOiDTG9tUPYAnoVO+elFcJSM3Whfz90g8CbpJOtUYOijJJZriLWq9n8qE6lJT1
         i4dHPMZdW8OhQtDMX5HxuWkwbDdB0jJnc+s+eMT6QS5whv9ZInYZY9K8S1pOGjMU+Dtf
         tyFC4J9uj5HsUQ0/+A44qRNAPPWY2CCtzm0Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2Lzw+6DwIXD5wFIdGhdMkBNEqUvLgerW4Hymt2eRxg=;
        b=RVi9zypuu4JqFx+08qALH3vBgTIy1R7m97Xl3ZW0Sy3dTS1BlaYL2pzPg1HtrweRHj
         xzhudX9+InNUek4l8y97cCQO98hJ0FJWuym7/08/16HcpnVlr3hPghDzVZoZdEWVKtlH
         OFdOmRWcNLFV78r6Ig7nhYC87ZMC4JJhWcjbtanuZ3LygK/frQJlAlGfQFEmDNsNyV5d
         h/TV361V8fsxrUBCPUSGsa6Xeupi/VN4AvpmQ0SfDYtJREOKrfwDbcZk2V0XkLZTXTUC
         YeO5wlzez1FbYIJPfv0pYjmzwBlzLFedkMKxhdqqdkrI1mfmfPrGd3XT1dOci9j9hLp6
         fk5g==
X-Gm-Message-State: APjAAAWW/dHqTS1QkATY4h0hhuL2FQiqrkJlv2CrTQ/swLoyV+MvPRpN
        SF9SlPgZlVD+hQ8CQHFzOav+ZdJWWvt1MLyEkn8=
X-Google-Smtp-Source: APXvYqzkUWO9RFM7Di6p87wS+Vk/jUfjgdcxe/+ZDF1v3BDViIFdLlrzgrk/5NcaTxAv+I2EX+x/Rkh3OZXw908Xzio=
X-Received: by 2002:aed:3841:: with SMTP id j59mr3043607qte.220.1582782886154;
 Wed, 26 Feb 2020 21:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20200226230346.672-1-rentao.bupt@gmail.com> <20200226230346.672-7-rentao.bupt@gmail.com>
 <83d7b817234f99c92272f7950129c56a58f4de54.camel@kernel.crashing.org>
In-Reply-To: <83d7b817234f99c92272f7950129c56a58f4de54.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 Feb 2020 05:54:34 +0000
Message-ID: <CACPK8XdkPLZVJTpAc2u3Q0W0KoRrC4hfHjy27VKpGDRF45JByg@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] ARM: dts: aspeed-g4: add vhub port and endpoint properties
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

On Thu, 27 Feb 2020 at 04:11, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > Add "aspeed,vhub-downstream-ports" and "aspeed,vhub-generic-
> > endpoints"
> > properties to describe supported number of vhub ports and endpoints.
> >
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will take this patch through the aspeed tree for 5.7.

Cheers,

Joel

>
>
> > ---
> >  No change in v2/v3/v4.
> >    - It's given v4 to align with the version of the patch series.
> >
> >  arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi
> > b/arch/arm/boot/dts/aspeed-g4.dtsi
> > index 807a0fc20670..8e04303e8514 100644
> > --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> > @@ -164,6 +164,8 @@
> >                       reg = <0x1e6a0000 0x300>;
> >                       interrupts = <5>;
> >                       clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     aspeed,vhub-downstream-ports = <5>;
> > +                     aspeed,vhub-generic-endpoints = <15>;
> >                       pinctrl-names = "default";
> >                       pinctrl-0 = <&pinctrl_usb2d_default>;
> >                       status = "disabled";
>

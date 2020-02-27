Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52FEC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4224672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="I2KS5PW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgB0FzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:55:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39506 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB0FzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:55:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id e16so2056233qkl.6;
        Wed, 26 Feb 2020 21:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BT+Y4zDOpTN8aRnsqq1qa2mSs9wu0N9tys2uzX7EM7Q=;
        b=I2KS5PW/7Kw7fTHC3Wxq8Osxk8ug/lmvcU2moEvkCzfofFm2FVnq73DDl0YTEDLd3u
         Q3v+LTl0KnhEidEoGD8Az1KBh2NbkQHyMlUWo/6cNu49XIQ3CYxqXnQVbFsadGjrS6pN
         Z9IgLoO5G01BEyRaeY6NY+Ey62eqAglnXlFMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BT+Y4zDOpTN8aRnsqq1qa2mSs9wu0N9tys2uzX7EM7Q=;
        b=k7PdoSG/E9mO4QBqwQaPzbseEai9UV3GMxCyEPHyRkfQpPdbSVTkMkKqrMlBGUb+sH
         yhzRVdoPwii9yvnKz2fMYAZxV9yYpFW1t4ng0pnfEz/nyw8UQmhGNzz9Jco6TqwGGFqS
         1UhjsJrep3aQC0X9fGEAruGDBei9OogT40LOVfeY/t6HEZzf7TqdrMkUIGPEqFKWwYmS
         8loDmhewWWTlAQ8+P+llbdPGsKg/IX2GoruLW9HPL9lPFGDliRfPT6lFg6vK2Z1rheX9
         CiPg/etLswNxWMqbla6tIr36jYfBYAeZd+n0DWFVdLlBLdEpo0rxfgCkotwJnoEGvyVq
         IWdw==
X-Gm-Message-State: APjAAAVD9Qa08Zm2mc22mUlUHcos0lRueamgVYkl8Vn9doC8HOM2faXJ
        tX3uBt00RRKJ0L1SJbdTTwWTQ8asPN6zTVeX+UI=
X-Google-Smtp-Source: APXvYqzT52XJX1ayxGeNKzjAkfyJjllIsA3MS1ZOUJZUZBT6z2y1pnNAw6jRX/tZyQhZlu/wqAmNLrhydyjZY7ZzuqU=
X-Received: by 2002:a37:a493:: with SMTP id n141mr1860258qke.330.1582782900930;
 Wed, 26 Feb 2020 21:55:00 -0800 (PST)
MIME-Version: 1.0
References: <20200226230346.672-1-rentao.bupt@gmail.com> <20200226230346.672-6-rentao.bupt@gmail.com>
 <c1f990ad2fd35deeba9e4e937cb19ee5080ea2a8.camel@kernel.crashing.org>
In-Reply-To: <c1f990ad2fd35deeba9e4e937cb19ee5080ea2a8.camel@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 27 Feb 2020 05:54:49 +0000
Message-ID: <CACPK8XfALBpAUmvAmBLDGa-oEMaZSqaKsHjs0EEPYP=_riGJVA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] ARM: dts: aspeed-g5: add vhub port and endpoint properties
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
> > ---
> >  No change in v2/v3/v4.
> >    - It's given v4 to align with the version of the patch series.
> >
> >  arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi
> > b/arch/arm/boot/dts/aspeed-g5.dtsi
> > index ebec0fa8baa7..f12ec04d3cbc 100644
> > --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> > @@ -195,6 +195,8 @@
> >                       reg = <0x1e6a0000 0x300>;
> >                       interrupts = <5>;
> >                       clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> > +                     aspeed,vhub-downstream-ports = <5>;
> > +                     aspeed,vhub-generic-endpoints = <15>;
> >                       pinctrl-names = "default";
> >                       pinctrl-0 = <&pinctrl_usb2ad_default>;
> >                       status = "disabled";
>

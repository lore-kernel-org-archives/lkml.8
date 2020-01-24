Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A374C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EC62072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7sKL3fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgAXXL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:11:57 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43494 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgAXXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:11:56 -0500
Received: by mail-qk1-f194.google.com with SMTP id j20so3756873qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 15:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HswFXBTNIeWeTvt50jMznmxACH9SU+cjRQuD11+yx8=;
        b=K7sKL3fgbLSQl6rqdpxFQ3pAEC3PwvamOK9XotwauEp6BC+GUGBjm0gI5i/8dDaTGh
         eq+9gjeZJ6+8q1xH1XNFDaA1gMDlrBHnPZ24J/uz87nRoCAHMrK27vc0YpUQJ/kOnJn/
         IMDE080DQ/fsps3kv49LfrivhP785MbAV1uVCLEeqrRQC450xUOpM1PQHDnNm64qRQzH
         +wN+XBnsX8aV5kXaaLh4lUd+OefQ4Any9sLPzQzAGVkKpR+ADtsOK+gzWF7aNagE1pqP
         jt/9V3bHufGnNtdRtuVWJZpxnf4yAihAEkzogsvu7uZ0G2csIJVy+XnGOoCikMXZDjXL
         W1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HswFXBTNIeWeTvt50jMznmxACH9SU+cjRQuD11+yx8=;
        b=USIJI8nXQsL3fqvdK7eQO21TvDLL6aFVBh9eqkwCXAQyxnA676uTaE8W2G+GIyv1yI
         ew5zS5XtzWeEN8uWAXZSCnLfZ3pBKavKHXcKQU+sFsMSRmfV/agWLZ736B29sKRXETYh
         bxDh8bsIAHoAexS3G+sgXTpJCVa85cH43Yo2c7rPUFy5OLpPmp6i4z/DDA/E7vVNFpRr
         P2lT/GtyYgHzFlYila1509H3TXZIbPN4g1Itqgmi3oMl9j7y7Nh9xIjrPN4ahQGpwwFu
         2AYqVIb/EiEk1XO0ayWVnRYAo9Bh5VzaD1OTtOxlbrwN5pe7w77c+MQyy2JQBQrgmYRa
         ffvQ==
X-Gm-Message-State: APjAAAUgmlBT/UA5ZOSz8wbsncAVZ7PUbb+gqnPtwGEkQkiIi40nHDyV
        piDNneqr9K3Hkt25As1a03wCHh/iKSorWSMPMms=
X-Google-Smtp-Source: APXvYqxG8RAexIddZ3jl2CRvSVb6ONA7ENB7fqbXwjU782RHCEiTKASgXMlaJcxjYTXeMVOJTChCjxzxsyiaWhx8Q/4=
X-Received: by 2002:a37:7a83:: with SMTP id v125mr224829qkc.22.1579907514418;
 Fri, 24 Jan 2020 15:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20200119163104.13274-1-samuel@sholland.org> <20200119163104.13274-3-samuel@sholland.org>
 <20200121090539.mgswdzfharrfy5ad@gilmour.lan> <8006a501-733e-b998-edb3-378769cd3a4c@sholland.org>
 <20200124163318.y3pykbfgpwsqiru6@gilmour.lan>
In-Reply-To: <20200124163318.y3pykbfgpwsqiru6@gilmour.lan>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Fri, 24 Jan 2020 15:11:29 -0800
Message-ID: <CA+E=qVf0wcds7SzLOQT5BS2fVXT5w6-e9yhTK4=BXBm==P3Kzg@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused AXP803 regulators
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Samuel Holland <samuel@sholland.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 8:36 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Jan 21, 2020 at 09:14:02PM -0600, Samuel Holland wrote:
> > On 1/21/20 3:05 AM, Maxime Ripard wrote:
> > > On Sun, Jan 19, 2020 at 10:30:58AM -0600, Samuel Holland wrote:
> > >> The Pinebook does not use the CSI bus on the A64. In fact it does not
> > >> use GPIO port E for anything at all. Thus the following regulators are
> > >> not used and do not need voltages set:
> > >>
> > >>  - ALDO1: Connected to VCC-PE only
> > >>  - DLDO3: Not connected
> > >>  - ELDO3: Not connected
> > >>
> > >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> > >> ---
> > >>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 +---------------
> > >>  1 file changed, 1 insertion(+), 15 deletions(-)
> > >>
> > >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > >> index ff32ca1a495e..8e7ce6ad28dd 100644
> > >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> > >> @@ -202,9 +202,7 @@
> > >>  };
> > >>
> > >>  &reg_aldo1 {
> > >> -  regulator-min-microvolt = <2800000>;
> > >> -  regulator-max-microvolt = <2800000>;
> > >> -  regulator-name = "vcc-csi";
> > >> +  regulator-name = "vcc-pe";
> > >>  };
> > >
> > > If it's connected to PE, I'd expect the voltage to be at 3.3v?
> >
> > If we provide voltage constraints, the regulator core will enable the regulator
> > and set its voltage at boot. That seems like a bit of a waste.
>
> I'm not sure the regulator core enables them if there's neither
> regulator-boot-on nor regulator-always-on.
>
> > I don't think the voltage really matters, since nothing is plugged in to the
> > port. ALDO1 can't go over 3.3V anyway, so even if it does get turned on for some
> > reason, nothing will get damaged.
>
> Looking at the schematics, it looks like the PE pins are connected to
> the front-facing camera?

The only camera on Pinebook is UVC

>
> Maxime
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

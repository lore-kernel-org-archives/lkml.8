Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB0C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07FA20752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mllYl6GF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCTJLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:11:39 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32818 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTJLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:11:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so3924971lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OU/CpAGIqH8KmfsyruwEDtwqFN1iNUUKyUH7R3UxLkw=;
        b=mllYl6GF2syYSUniY8DE9rxhVQ9ZjeJtdUw2jL/qdetWaKL4P4TFCzv5AjONaNrDzs
         BGM8hqFjQpEIYY1BWfAadf0qCywfRXMAfeboea/zxJo57UoIVHfgZWrG/zwY9BwTuVgb
         DRXULnIB8wnRcpx/yKPfjz+J/PSnVSxl+Bt7vPIcZyJtyReDP/OxZHesXHBx+tinokkR
         IKKc188enCZ7EwyPkgD6Y9blmbi+56B1MJKDi1Fk8OvlUKZw3GAPgVVhAJvfZibhUl5t
         ekKWzyO+eyqmq12qo3Pns7t3wOzedDpKks/K9dXWARk5rtaiwF/SWq6Rqe5cYFNsYqlU
         rw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OU/CpAGIqH8KmfsyruwEDtwqFN1iNUUKyUH7R3UxLkw=;
        b=YGlaXo1Y1bYePwicqibcFcucca9hdDY0uIQ/oS0hDMXKiiAks2vesM6ca2li/+ooOu
         VF6PbFY6S6L+z/bza9tPyqT3cM8Sule8MLGzBNR7peTKQDNcbCih1S73QNLPYnF+6+TS
         VQAthzdUfxt7QhrRLC6MxhZrP2k+HcCqRXbjU4qbmgyiW4L9I3Sgtgb9VDKn1+Gtpv3+
         aki8dTRsU+JscPG0EI7JrcSWbTje0SL2/bq98XUTHlHpPsEKScZ6UeEqQL4FFzk5yxq8
         7irERN+psPiTAZjvLQ+nGeR+8mmqOlI9rnoeRdj99Mx06Gf6oWBIV9jDqFks8+Fp8SWt
         MB/A==
X-Gm-Message-State: ANhLgQ18c6x9WAylnXBSBU2wdrn07Vl3gspv10paosaSZgkLwZ3EUb21
        Xt2ANY38p/7mcTGVUDa1JUO1u3Gk+8miCxgYs+MKUQ==
X-Google-Smtp-Source: ADFU+vtJYWG8EQJP/hgD78QKWv99yAbCP307TFvbYqg8VWMrgeCGnVYbnG2Hccuki3Zkny8VqCdXwG3hw10skhhk4Rw=
X-Received: by 2002:a05:6512:247:: with SMTP id b7mr4683821lfo.21.1584695495451;
 Fri, 20 Mar 2020 02:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200316133503.144650-1-icenowy@aosc.io> <20200316133503.144650-3-icenowy@aosc.io>
 <CACRpkdaVrfd1p+WyACy-gq-3BPsXJ_CZwi2OZe+=csseBcvcaA@mail.gmail.com> <491ADD02-5511-404B-88A8-5725EF061EAC@aosc.io>
In-Reply-To: <491ADD02-5511-404B-88A8-5725EF061EAC@aosc.io>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Mar 2020 10:11:22 +0100
Message-ID: <CACRpkdbeLAyhhkx115zAV0tdC7KJ4T0UoQ2QeDwTVN+btxp=Jw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: panel: add binding for Xingbangda
 XBD599 panel
To:     Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ondrej Jirman <megous@megous.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 9:07 AM Icenowy Zheng <icenowy@aosc.io> wrote:
> =E4=BA=8E 2020=E5=B9=B43=E6=9C=8819=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
10:14:27, Linus Walleij <linus.walleij@linaro.org> =E5=86=99=E5=88=B0:
> >On Mon, Mar 16, 2020 at 2:37 PM Icenowy Zheng <icenowy@aosc.io> wrote:

> >As noticed in the review of the driver, this display is very close to
> >himax,hx8363.
> >
> >I think the best is to determin what actual display controller it is,
> >I think it is some kind of Ilitek controller since Ilitek ili9342 is
> >clearly very similar.
>
> It's Sitronix ST7703, same as the Librem 5 panel.

Heh, I wonder how it comes that it is so similar to Ilitek.
I guess I will never understand how the silicon ecosystem works
in asia (I did read a lot of Bunnie Huang's articles and hardware
hacking book to try to understand...)

This file should be named sitronix,st7703.yaml then.

According to the code in the Librem 5:
https://source.puri.sm/Librem5/linux-next/blob/imx8-current-librem5/drivers=
/gpu/drm/panel/panel-sitronix-st7701.c
The actual name of the display is Techstar ts8550b.
And the display controller is st7701, so maybe we should
actually name it sitronix,st770x.yaml if there are some
sub-variants of st770x?

> >properties:
> >  compatible:
> >    items:
> >      - const: xingbangda,xbd599
> >      - const: ilitek,ili9342
> >
> >Possibly use oneOf and add support for the himax,hx8363
> >already while you're at it.

This should at least be:

compatible:
   items:
     - enum:
       - xingbangda,xbd599
       - himax,hx8363
       - techstar,ts8550b
     - enum:
       - sitronix,st7701
       - sitronix,st7703

So panel nodes using this panel become
compatible =3D "xingbangda,sbd599", "sitronix,st7703"
etc.

This way it is straight-forward for drivers to identify the panel
vendor and display controller.

Yours,
Linus Walleij

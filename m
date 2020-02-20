Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1813EC11D25
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA1206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D531YR+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgBTVhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:37:33 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39178 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:37:33 -0500
Received: by mail-qk1-f196.google.com with SMTP id a141so5049059qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYj5LNpCUCCnBa2oy1JmbMYUv7Pxu05SUX364TAcUFQ=;
        b=D531YR+wxORn5yMqquYHuw0LOWJwbMGqJ/HNHEyXBvdaX61mb84C66r8YuwEn3FbWt
         B/4c623opxfVqQ+1xjlyGZUz1cj4ayk53VLlmQwfrriCzxb33kj2nNxvYuk1dMe2nX61
         l3AU+Tji7SjC591I2p8T9VMcXTtwLNlxZBdUZzHGQQRX0OIgYU0bKXkGmYdNWOFO3DSi
         n6lUEqkPx+kB698msH6xwbOr0YZFMTxcQGTpEqDjyHB4k6ZX2WksZV05JoWvHdAbMvuq
         spgfJOviI3N/k8F6SjsJ5Jq4wq3N7rNdG4rv0BPhG2hNi+8F2rSq252ySBXhEcw7BNvt
         YtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYj5LNpCUCCnBa2oy1JmbMYUv7Pxu05SUX364TAcUFQ=;
        b=C8oTPfexUeLuTE0u+mkwhi6DXbGYBJWXVj30+2AM4gZzq6ENu2WeRcb2fdj/CyE/to
         lZ40H0C30NrbfbjXOl6FPZ9VDz+KBlJYUS2jRj5C0oBQlgAx1GBwCHg8eGhl4n5DwUWr
         fJ37/tjsgsdITInE7peyXNWc2nkc6Rlc96prMwC2Pyl3doeB7r5DCg6FX5n/t3hpoNAT
         7xq2TCuD5eS1nCQTnum3zzpyf4G4BBaG2/rybZAQsirnRtG5dhwvTNeS37G3gpU4oGQ6
         M8auwC8O9gwoZl4tcqrokbcAx3hYrk4Y/x13oPouJesmGMd58YnBh6L3eE/Bt2Kf6Yd9
         demg==
X-Gm-Message-State: APjAAAUdfjyn9qDcutLp9IMqSsZMgcZieZIZdB0D9B1RstqTrUFsliI0
        kDwbACDwwBG2PX6qBYtINwYIv16WYKSiDmONIEE=
X-Google-Smtp-Source: APXvYqwplzoe4CvRRPMOeVSyg+GmZ7Xr+hoa90z86t8lCC8IWOl3oqq6wqqyXavOdlPzo69TGu/dWGFBrsXKgjK6BPo=
X-Received: by 2002:a37:a581:: with SMTP id o123mr28961726qke.131.1582234652483;
 Thu, 20 Feb 2020 13:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20200220083508.792071-1-anarsoul@gmail.com> <20200220083508.792071-4-anarsoul@gmail.com>
 <20200220135608.GE4998@pendragon.ideasonboard.com>
In-Reply-To: <20200220135608.GE4998@pendragon.ideasonboard.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 20 Feb 2020 13:37:19 -0800
Message-ID: <CA+E=qVeYUgPZMxmp5oHu1W8LYYqaJfEK6=L-3wadG6s-a2NPEw@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: Add Guangdong Neweast Optoelectronics
 CO. LTD vendor prefix
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 5:56 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Vasily,

Hi Laurent,

> Thank you for the patch.
>
> On Thu, Feb 20, 2020 at 12:35:05AM -0800, Vasily Khoruzhick wrote:
> > Add vendor prefix for Guangdong Neweast Optoelectronics CO. LTD
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 6456a6dfd83d..a390a793422b 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -665,6 +665,8 @@ patternProperties:
> >      description: Nexbox
> >    "^nextthing,.*":
> >      description: Next Thing Co.
> > +  "^neweast,.*":
> > +    description: Guangdong Neweast Optoelectronics CO., LT
>
> Google only returns two hits for this name, beside the ones related to
> this patch series. Are you sure this is the correct company name ?

That is what datasheet says:

http://files.pine64.org/doc/datasheet/pinebook/11.6inches-1080P-IPS-LCD-Panel-spec-WJFH116008A.pdf



> >    "^newhaven,.*":
> >      description: Newhaven Display International
> >    "^ni,.*":
>
> --
> Regards,
>
> Laurent Pinchart

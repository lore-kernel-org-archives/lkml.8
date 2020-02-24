Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D73C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6356720836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ+Er6bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgBXNXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:23:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43735 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBXNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:23:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id r11so10351598wrq.10;
        Mon, 24 Feb 2020 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVbC5gLHR4yvUi9/1oHpmpfPLd1cTf7rKPhbOVibfvA=;
        b=nZ+Er6bnu9NAANUCJQsLH9xn2qY4PV29m4rBNuQLqX+sm7XjOQSOVhr3uvinbc3Gw2
         Z8Gy97ASz6Waj6Tlb0W9fOejWx2niXnXxlWyV6u6Gy0x/WsFBcpEJ2pj6VSIYWibluqn
         NDibT5RHD+I8fj0piJJLqET6z0NUXtsMKCHk4RDIvOePogmLKDsqxAQPGbY3UL4b2ss+
         /sUU3wixVdGMoZ+jdqVZxHZgn3aPmBe4w76JwDTBsjeY2HsL6GSyBGeLglv6rxtAy+da
         2siGfxYT2eYZJfYytqUAcglrqlE3lNhl16sRAVg8Cw7l265RiBxd4lNdPl+iQgjcjcKD
         ky6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVbC5gLHR4yvUi9/1oHpmpfPLd1cTf7rKPhbOVibfvA=;
        b=QF9SkXP0VFWuPVrovoxZLa07uxuCGnsnJ98UxxilUvJ8lX5+brquxCIJXiIJYVeQx5
         ubv1+mO6K/yY1ZXGdKm+Q3X1vyrZCi7dFvdgMpP9kAYAnZkyVPLuws5v1KQQ8+6MVZSk
         CUyfdfAejKo9f74ZEUScUIsjqNhbiFkIpFafOpx+gYpq1DFknG1ZjKDc0nnP4gL4KJo3
         KAajfkyK42XA5seObKDvdZ8Y3Onc8r8OZ2yssFXMsKTNbRy8C2K3BUXbNp8Y3fx40BD6
         YwRiTBtM321l7l0svXKBBSCLAlDpvWErsM4YtXAd0pt9R55BlKboKEPHffLO1bjzYmYB
         ErGw==
X-Gm-Message-State: APjAAAVxmRRilRMDROUJ2PUKm/U66787CDiccYcZtwEOlJp9KYrqMkF6
        YTUt2zQ+LM+J9fNPyGQUoFCcQHmn
X-Google-Smtp-Source: APXvYqzxxkpsyjYl9JyAtHtAmjKM8GLv1qb2XlMzrH7fcepRzF8ODOpD7CmTVLcSCaFAXRbbT7LgBA==
X-Received: by 2002:a5d:66ca:: with SMTP id k10mr15454421wrw.194.1582550587045;
        Mon, 24 Feb 2020 05:23:07 -0800 (PST)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id s22sm17464417wmh.4.2020.02.24.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:23:06 -0800 (PST)
Date:   Mon, 24 Feb 2020 14:23:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Sam Ravnborg <sam@ravnborg.org>,
        Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
Message-ID: <20200224132303.GB2209519@ulmo>
References: <20200221222711.15973-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 04:27:10PM -0600, Rob Herring wrote:
> Fix all the warnings in the DT binding schema examples when built with
> 'W=3D1'. This is in preparation to make that the default for examples.
>=20
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |  2 +-
>  .../clock/allwinner,sun4i-a10-osc-clk.yaml         |  2 +-
>  .../bindings/clock/allwinner,sun9i-a80-gt-clk.yaml |  2 +-
>  .../display/allwinner,sun4i-a10-tv-encoder.yaml    |  6 +-----
>  .../bindings/display/bridge/anx6345.yaml           | 10 ++--------
>  .../display/panel/leadtek,ltk500hd1829.yaml        |  2 ++
>  .../bindings/display/panel/xinpeng,xpp055c272.yaml |  2 ++
>  .../bindings/display/simple-framebuffer.yaml       |  6 +-----
>  .../devicetree/bindings/dma/ti/k3-udma.yaml        | 14 +-------------
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  | 14 +++++++-------
>  .../devicetree/bindings/gpu/arm,mali-midgard.yaml  | 14 +++++++-------
>  .../bindings/iio/adc/samsung,exynos-adc.yaml       |  2 +-
>  .../bindings/input/touchscreen/goodix.yaml         |  2 +-
>  .../devicetree/bindings/media/ti,cal.yaml          |  2 +-
>  .../devicetree/bindings/mfd/max77650.yaml          |  4 ++--
>  .../devicetree/bindings/mmc/mmc-controller.yaml    |  1 +
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml |  2 ++
>  .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  |  2 +-
>  .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  2 +-
>  .../devicetree/bindings/regulator/regulator.yaml   |  2 +-
>  .../sram/allwinner,sun4i-a10-system-control.yaml   |  2 +-
>  .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |  2 +-
>  22 files changed, 39 insertions(+), 58 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5TzjcACgkQ3SOs138+
s6GeWhAArfC4DkbVVCEJsL56rih4V9WezBzZTgBe1i7wY66Vpn+tD3fjS7VGo9rZ
VHqoeP4Ny+uMURGs8jNhigP/wiDxAPuRcyMsw8daDESGMxcafJFa1Jczv+NZv+XL
4DDgKxYRSmPLdaYr7IKwEEj0Rrz1RMpHff51gX+Nj6nxZ8Y8KpYWPvn5STXsbzal
ESS82GbDWWnvXonMsXQZ+86BHxWZaFqgKKOKAog692OXOl1qFprityO8LLCM2edB
5HCAdRQiJAJaH+osFgT/vocpq5hqEk93NZj7efmZ4DPoTe2wMuoUgdh5alRM3XK7
nKTxOFHx7oe7MiWRglyhyjGiCxzB24g5CXAjL1Sj12weqE2GMzDQxiswLUcUNu4B
vYTmfeHUbXuiDly++sC1xQpIhaepNV9gr+GuH1JAYbMwkinAixZgXtWLC9IjT9+Z
mwb6+muaIR8OZwC3SsPWYEKn3zAa7TQaAlPrQTCZZucBK/80saCnE0o5JqqmCjN6
2DoG7yxnmgQfp/l8f5cL34bHtuwarJ4kdppZUetIsyX1FUB9ihRUKbAkwEfruPU7
1vvthv6rLFcTQVGxUNXlT5cNs390K3pDOP5KfRhDXdfkTh9q6VP5svmvZWLd4a3X
vefVbUKo+4iS8tRRUD6WC2x6dHdAA18BcBlGd/Cpvem/2s4JpXU=
=Ilg9
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

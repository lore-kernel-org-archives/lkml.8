Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5553CC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E8120714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibNSapZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBXIgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:36:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45847 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBXIgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:36:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so9246820wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 00:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eQfv9Vg9FNZ1IKRXYyQ5Ipdv+XiwvqU0fwrAQYdRsOI=;
        b=ibNSapZoeaEr3wrJYHv3XHiZ3QcEoiPhb1ADLXE8orFfh3k42YaX4YlosY1nBAT8lS
         jMm7/rqDIRZdU064CtAfPx5YbYBvl7ntri7GdwIc8mvg1v8U0drfYleP53Whm4JQPesp
         GpaVjSUlYI0RqKT50IZ/z5kW2AjKtlb+JmsmLWDkU2+NWWvhndcZJqjcxewYKbmVgDfq
         ew/ledAYYSUEtv1Pu8r3gEdvxhdultHphkN+D8Hiq/5C1URDUylLs9b/OX3ZAzzb7J3G
         /vJ776u4B4JJw0jQ5ZHDsLhCqQwmx5O1kY2cUSXXysfxE0HWZhSOXK7RtR16TR7nSHmA
         GHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eQfv9Vg9FNZ1IKRXYyQ5Ipdv+XiwvqU0fwrAQYdRsOI=;
        b=T+FnJ2QbKK/mUra3hROTNvsqOH3s+G0NsSZcjXf9tQcnmJc/4n/cBc7r98mgRJiUCm
         /X2XQP47mSBRCEFrqoZqogJ/6ew8iVg7oZoYerKyJDLhmeThitS89GtSuZKnn++K/LLw
         qmqSOUoftZK4KQccWYAOvF6ChhW++QwAq2HcBssYq6u1ixGSGEvdsygkOBsjofQXGpf6
         paWluyx7mFYrIqphERBXrL7CBVsrVYL03c3FzrYtu6ys9Gl3q4Tu7nWC9TNNxNVneI3L
         dnudlc405Zzm+/1B4JJsnYKspXGyvQNZqjmaVq4e2VuAvW+0fNvp/AZmjiL1gDCIYKo6
         qMyw==
X-Gm-Message-State: APjAAAWfit4QeIYusge/I9tD2fJflvjNKVInfWRBNEoqQ5or6G6NbI9B
        xLMQvzsseEUHnBO222RYRtQseQ==
X-Google-Smtp-Source: APXvYqw/NrMmIvPn6D5GC4zuvZdHE1WEiDRn6PxfraTp2mGxrE4G9Fpye1/arFzUCjW7Eud9wvHmZQ==
X-Received: by 2002:a5d:4bcf:: with SMTP id l15mr2765537wrt.0.1582533402119;
        Mon, 24 Feb 2020 00:36:42 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id f65sm17120731wmf.29.2020.02.24.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 00:36:41 -0800 (PST)
Date:   Mon, 24 Feb 2020 08:37:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
Message-ID: <20200224083712.GH3494@dell>
References: <20200221222711.15973-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020, Rob Herring wrote:

> Fix all the warnings in the DT binding schema examples when built with
> 'W=1'. This is in preparation to make that the default for examples.
> 
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

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/mmc/mmc-controller.yaml    |  1 +
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml |  2 ++
>  .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  |  2 +-
>  .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  2 +-
>  .../devicetree/bindings/regulator/regulator.yaml   |  2 +-
>  .../sram/allwinner,sun4i-a10-system-control.yaml   |  2 +-
>  .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |  2 +-
>  22 files changed, 39 insertions(+), 58 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

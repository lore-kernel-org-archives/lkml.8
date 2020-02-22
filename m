Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB0C35666
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D785B20702
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 12:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzKvVRbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgBVMDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 07:03:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38400 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBVMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 07:03:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so5034313ljh.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 04:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI6FYDIlYmOfWKvl/WJxJSFM4DVF5Yvn/VpcEKIII3A=;
        b=NzKvVRbdGdb7fet4JDEYWjdZd0SZoiMLU09m15vyGP/1mMMmO/uRvhKieGH2bvf+oQ
         LwTVfBxvexh7++Lrbf85ZdIsvFBUTqPH6DKsX1/QDGV7fvhealZr+BgaShmKWrxgFMOK
         a7Lkkm7zaawNvRivqbYce4u2yn/YTXtAWEEZZRftNFxjjcxf1H3Gq3cWy4ozRbptGKhC
         tEiHb35z+oBMpb5L0M1NpgAEGR5msj41T75nOw1kuqAX0oxB51TlR99TkYGJvpY0J+B9
         aj77pVqbVxpTwbSxwN439qwoxdcyWsmFHTCw/M/Ij42tt5KpyMCnKB/ak01a8kg2N8vs
         fqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI6FYDIlYmOfWKvl/WJxJSFM4DVF5Yvn/VpcEKIII3A=;
        b=L2k1PGkxNJAk+MqAH+UTcKHnNdy7oR7S09jB808aYtLk3jS/DcdzycOUAoJ49asOsj
         Dhh2A3w3fk2fVnGTztZkfI1zj+tAFyq+o6TdSOxiZQe9W8qHK1Ex/nmMYJCynbhzmWq/
         oKPY+02noL5taQzeIZ15Rk06y80S0ic+zWsNXksGJd51eqO0Cmwu5Pv1Fy2ylVzcr6LT
         N7cJFkXe8mGPatHNEvh012uWWS5SLFatLqQg6N+MgAEODfehK7fcE9m9QvWOpQlV4HQJ
         rFslw+LKlNmPYraWnsjUF2b3+HwOcgZYyHVFWOSm1uSsI15tjoOCFeLxzK9dpO2rkQyJ
         Q1TQ==
X-Gm-Message-State: APjAAAUYaAS53mkWD8WZQLrMIMj/OaW9QOA/1M1dr6LRXA5E/NE0/9fL
        w0dgyz4b1vPv+7RwTuXaoDCQlDpTvtfjH8UvrKzNxw==
X-Google-Smtp-Source: APXvYqx7HNT3OvQPpFRpcfvn1fZJFwlOJRC5z5A3c4pljTmYD1KHOgqnauKg9oW5ZN7eF81XJxTgpFvAQEKoAMqxkl8=
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr25892647ljc.39.1582372996940;
 Sat, 22 Feb 2020 04:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20200221222711.15973-1-robh@kernel.org>
In-Reply-To: <20200221222711.15973-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 Feb 2020 13:03:05 +0100
Message-ID: <CACRpkdZN5TMnAsf5SmKvwAqSpwu+oE1Yx7SDz6tksRjxDE1HRw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix dtc warnings in examples
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:27 PM Rob Herring <robh@kernel.org> wrote:

> Fix all the warnings in the DT binding schema examples when built with
> 'W=1'. This is in preparation to make that the default for examples.
>
(...)
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

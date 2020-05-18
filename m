Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411BEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB01207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aK+zuEJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgERHk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgERHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:40:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD52C05BD0A
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:40:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d22so7123526lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbNo2bO8UT/NFEvCqltEb1Sgxiq57A9y9mhkDWjZGSA=;
        b=aK+zuEJG4robhm4skrw9lQNXp7D7AJSechYuPi13f1BmzrJUmpTkyQylwz0URbvJLt
         7Cdcro5gNOORmzH0rJCovjXjSk+ZIFt8jMV7hsiCF1BLk+AKvv1bEnwxAphyNvWJo1Oy
         Zgz3Esz1YYsCEbGWg5OAAbyclu6DQLuJPFnE5tp7nLRwqAOLMAvvuPyeyxckFcHXYfSS
         i3+mBKWz2GgyRpDw/BdYs0ZpOhWHD8v2dW/mc6YEr00sH/zxDPzEa3L7iopeXyRcQ8Xl
         i5hrG3E+IcMMe2MIZ90GFX9NqyZCTOSqMRpY05fav78/Pc7HAZu2Jy3l1y3tXnYsZQez
         ObgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbNo2bO8UT/NFEvCqltEb1Sgxiq57A9y9mhkDWjZGSA=;
        b=mJ8/4dZysdL2QK0ZY67/GghEiEOWmfaZ5rHULp3p9FuF7X06olrG5Ej5V7/dASoRfQ
         192a8WwHDMZOIZdR5WoBNAaedZ7KXblvSm2zLVKcJ64hKii88buM6aSRHk1Ii2GtOXUI
         QMVZhU9SCiTvK/yMLY0RBOvMTarct0RW6zMCnj7bapo4oL3QQz5ZfQu1ZF+O6zsjuzQI
         cWOZdnh+kRVJPdpPSrOBuBBz0muabyXZCCk7Qk22ZaLZoN72WfzasPnUIS4Dnx2PY1Tf
         6zeT5R42rXq2EFuU7JE5YUu7CTAcGmIYmIR7D2/atERSTdx+GMigw453eQ3LeLQdOmI9
         WAWA==
X-Gm-Message-State: AOAM53224gZHGf4hUAdowaOETWJPRQXtuFVxzvCREbeSqOsfusCw9aw3
        sxs6d/PoQwvRsDxp1mZ4iLkkxCIeyShoIOw1/noA6A==
X-Google-Smtp-Source: ABdhPJyzpxA/jPQ4m8GVMOhz93WPaHbW4zXids0G1ejXAyNHf7LdEoJ/7wtEq0WWnsDkRrcVjUxYEX0ptm1k0s0Iwa4=
X-Received: by 2002:ac2:414c:: with SMTP id c12mr10660804lfi.47.1589787625454;
 Mon, 18 May 2020 00:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200513141134.25819-1-lars.povlsen@microchip.com> <20200513141134.25819-2-lars.povlsen@microchip.com>
In-Reply-To: <20200513141134.25819-2-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 May 2020 09:40:14 +0200
Message-ID: <CACRpkdZa7OM3bqB+zRprEQ3M4m9hG3uPCoYxrdH_O=oxD8zi8Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: Add bindings for mscc,ocelot-sgpio
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:11 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> This adds DT bindings for the Microsemi SGPIO controller, bindings
> mscc,ocelot-sgpio and mscc,luton-sgpio.
>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

> +  microchip,sgpio-ports:
> +    description: This is a 32-bit bitmask, configuring whether a
> +      particular port in the controller is enabled or not. This allows
> +      unused ports to be removed from the bitstream and reduce latency.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

I don't know about this.

You are saying this pin controller can have up to 32 GPIO "ports"
(also known as banks).

Why can't you just represent each such port as a separate GPIO
node:

pinctrl@nnn {
    gpio@0 {
        ....
    };
    gpio@1 {
        ....
    };
    ....
    gpio@31 {
        ....
    };
};

Then if some of them are unused just set it to status = "disabled";

This also makes your Linux driver simpler because each GPIO port
just becomes a set of 32bit registers and you can use
select GPIO_GENERIC and bgpio_init() and save a whole
slew of standard stock code.

Yours,
Linus Walleij

Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E45120707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiXCU+2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbgFVQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgFVQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:57:34 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55731C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:57:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y20so268587wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+nlUAhHEbsgDoArBUNdvvaIbV4AUsHI2HbfVWN8ih0=;
        b=ZiXCU+2An8ajIuIk/jVXiqjUZ6QhL/GTYo7OKI7BEariTuLskGO4iJ4u2Mmj+YpjRy
         heQ7oBLCcTWv5Liiyva55Ni+yPP9jZap/wVaIVx5TWCfhs7vwsUxsmTbfcz/NTwpoKB5
         vuYu14wLQK8OCg4x7FMkcDE7moG5zK7cLYIFEycAFEqA9Kuh1cp5kN5SLErAZ/oUe3IE
         JGNy6459N+IPwcGTWR8hYWGhey1TQGH+EIoI4CJzOr0BFqG8RcQ9/ocy3ehQut/sWPU8
         UcGk6Ygvgo+B9gq5S5MFjZ+LAJEFOLvykrKDyR/9LtZCmIjL+4AZGY+ZSAcsWmCJHmi0
         D6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+nlUAhHEbsgDoArBUNdvvaIbV4AUsHI2HbfVWN8ih0=;
        b=OSKlw74vJ6nXoRizpfbpGiIFjy9eZn6xVaWKXbFIe4IJPNhqzvblurWzyGLFCb+5Sb
         QJA7+GaP7PZxuIiCeYPo9eG4zgCkmoE9phDPgZx4+vnYvs+RhwfZUJGjl3qHIuSguXER
         s6EwaTf2D+4iOteZxE/gfSVFPun+0lSiUR10p+B5x6fJkhhwNsat7GfDAFftsT1vFfea
         HgKy/ERxub+zG/kgAy36GHgb+EvmmreP3QGsWerqwrhiACm76xyxY/NFIWYWLH68B+kj
         /L4PMKWSDoRxwM9pS3hVKxH4RhKHQ2oVhoxnNXAZsEEj4ln3UgWRrBHo7PJcBGJQOWpd
         iMtw==
X-Gm-Message-State: AOAM530yUMVxODgziGAVQNq9pj2hh61cqKBAOxEw4y1VVEONSvba7nFU
        59IZ4wl10qCJpC26NUgZ3kKyCw==
X-Google-Smtp-Source: ABdhPJwC+mgtdB3qpfYTUZ3BE0gyIVx6GhzJ1K2c92QPj0jBT2j5czIy0RQw3+GtlciTGxhLBPoMoA==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr18924478wmc.52.1592845053002;
        Mon, 22 Jun 2020 09:57:33 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s18sm20653700wra.85.2020.06.22.09.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:57:32 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:57:30 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: backlight: Convert common backlight
 bindings to DT schema
Message-ID: <20200622165730.pnx7fzbq5e6q5h4l@holly.lan>
References: <20200618224413.1115849-1-robh@kernel.org>
 <20200619215341.GA6857@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619215341.GA6857@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:53:41PM +0200, Sam Ravnborg wrote:
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> > new file mode 100644
> > index 000000000000..7e1f109a38a4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/leds/backlight/pwm-backlight.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: pwm-backlight bindings
> > +
> > +maintainers:
> > +  - Lee Jones <lee.jones@linaro.org>
> > +  - Daniel Thompson <daniel.thompson@linaro.org>
> > +  - Jingoo Han <jingoohan1@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: pwm-backlight
> > +
> > +  pwms:
> > +    maxItems: 1
> > +
> > +  pwm-names: true
> > +
> > +  power-supply:
> > +    description: regulator for supply voltage
> > +
> > +  enable-gpios:
> > +    description: Contains a single GPIO specifier for the GPIO which enables
> > +      and disables the backlight
> > +    maxItems: 1
> > +
> > +  post-pwm-on-delay-ms:
> > +    description: Delay in ms between setting an initial (non-zero) PWM and
> > +      enabling the backlight using GPIO.
> > +
> > +  pwm-off-delay-ms:
> > +    description: Delay in ms between disabling the backlight using GPIO
> > +      and setting PWM value to 0.
> > +
> > +  brightness-levels:
> > +    description: Array of distinct brightness levels. Typically these are
> > +      in the range from 0 to 255, but any range starting at 0 will do. The
> > +      actual brightness level (PWM duty cycle) will be interpolated from
> > +      these values. 0 means a 0% duty cycle (darkest/off), while the last
> > +      value in the array represents a 100% duty cycle (brightest).
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +
> > +  default-brightness-level:
> > +    description: The default brightness level (index into the array defined
> > +      by the "brightness-levels" property).
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> Same comment as before...

Sorry the "ditto" meant I didn't thing about PWM as much as I should
have.

The situation for PWM is a little different to LED. That's mostly
because we decided not to clutter the LED code with
"num-interpolated-steps".

The PWM code implements the default-brightness-level as an index into
the brightness array *after* it has been expanded using interpolation.
In other words today Linux treats the default-brightness-level more
like[1].

    description: The default brightness level. When
      num-interpolated-steps is not set this is simply an index into
      the array defined by the "brightness-levels" property. If
      num-interpolated-steps is set the brightness array will be
      expanded by interpolation before we index to get a default
      level.

This is the best I have come up with so far... but I concede it still
lacks elegance.


Daniel.


[1] I don't know my way round the BSD code bases to be sure what they
    do... I did a couple of web searches but didn't pull up anything
    definitive.


> 
> > +
> > +  num-interpolated-steps:
> > +    description: Number of interpolated steps between each value of brightness-levels
> > +      table. This way a high resolution pwm duty cycle can be used without
> > +      having to list out every possible value in the brightness-level array.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +dependencies:
> > +  default-brightness-level: [brightness-levels]
> > +  num-interpolated-steps: [brightness-levels]
> > +
> > +required:
> > +  - compatible
> > +  - pwms
> > +  - power-supply
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    backlight {
> > +        compatible = "pwm-backlight";
> > +        pwms = <&pwm 0 5000000>;
> > +
> > +        brightness-levels = <0 4 8 16 32 64 128 255>;
> > +        default-brightness-level = <6>;
> > +
> > +        power-supply = <&vdd_bl_reg>;
> > +        enable-gpios = <&gpio 58 0>;
> > +        post-pwm-on-delay-ms = <10>;
> > +        pwm-off-delay-ms = <10>;
> > +    };
> > +
> > +  - |
> > +    // Example using num-interpolation-steps:
> > +    backlight {
> > +        compatible = "pwm-backlight";
> > +        pwms = <&pwm 0 5000000>;
> > +
> > +        brightness-levels = <0 2048 4096 8192 16384 65535>;
> > +        num-interpolated-steps = <2048>;
> > +        default-brightness-level = <4096>;
> > +
> > +        power-supply = <&vdd_bl_reg>;
> > +        enable-gpios = <&gpio 58 0>;
> > +    };
> > +
> > +...
> > -- 
> > 2.25.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

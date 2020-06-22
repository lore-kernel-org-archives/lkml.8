Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA11C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B204520720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feZREHIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgFVOWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgFVOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:22:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C18C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:22:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so1351858wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bJSKL8sfjoItMlLZIHvSZPyc9+WORmnIJIkfFHS/Uhc=;
        b=feZREHIMAeCKCnPPAFWeIamudTiI2hndBHx8gCPufSriYMHHewVeh8yLFbdjBYhuS/
         A7GFYLPR5RoZndfJUADG4GY/2u8/Uia7jurvKStBl3zH6uZRkywjEoVw01+kE0NChzOc
         VN05+Rp1Sm0iCKvlcmDNjItZq1FNxg3So8FZSWXsKC9bHlU417QwWol6je2VQmdoVK1u
         h/iuxoXJnWtiXbi76Ddc5mT8jtZKGWInHVYFSgp4KEQGCcVQNiGx01PmlHOThUnGGGWR
         5ycd2gUnQ5/GOeZJkSZF4P2Xt4++bax/z9Y374W5fF6tYepk4CwEEDjmj/dB1HSPxPMS
         rNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bJSKL8sfjoItMlLZIHvSZPyc9+WORmnIJIkfFHS/Uhc=;
        b=SiaBu5L0a937XWGmFPUxgOXrkFNoHenlhEoSb6GIQVDz8GdwMw+MEPYcAQCmH8Fi+V
         sq0ss16HbV0uzwQ6H3d8oV5OVW90bmrDAUQfIKnnXBm4cq9+ouZJ7XK1q9gYK3a/oYoH
         7LIti9FmL4LP/6VkvPiqiQZCbIFTJ5e0M80FDN2W0Drgdzozja+XvyYsD1mZlWG6xGNG
         KfjkTlYbDzv3XDDwgx9SZqkQzjgRtkHlkXSDCeVFbVs7u6P3jG+pMTy3A2MbuX2RRvkY
         G9nATd+PAOhaM+YivDbyPXcEWeJ99yhQG7nuS0zs718yiIov8/cfd2wSmHUgCzexu+X3
         +QOA==
X-Gm-Message-State: AOAM530Z6c2H7COTAhJ6519hdkMkj0c/b1TSsvP7i/Vk+N9MrNFyYJ5i
        /J1NKvTrsRmpMrYksT5hKGZ6qw==
X-Google-Smtp-Source: ABdhPJwa0y5j0FoupL7KxiiKxqCc0LORL3TMqBTcZBpU8Hjnw6rSwhmgMhnha+I5P52T/2yZa/ljwg==
X-Received: by 2002:a1c:e303:: with SMTP id a3mr1000199wmh.26.1592835738837;
        Mon, 22 Jun 2020 07:22:18 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v24sm20804558wrd.92.2020.06.22.07.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:22:17 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:22:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] dt-bindings: backlight: Convert common backlight
 bindings to DT schema
Message-ID: <20200622142215.biy2g6sd44czky4u@holly.lan>
References: <20200618224413.1115849-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618224413.1115849-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:44:13PM -0600, Rob Herring wrote:
> Convert the common GPIO, LED, and PWM backlight bindings to DT schema
> format.
> 
> Given there's only 2 common properties and the descriptions are slightly
> different, I opted to not create a common backlight schema.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

...


> diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> new file mode 100644
> index 000000000000..ae50945d2798
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/led-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: led-backlight bindings
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>
> +
> +description:
> +  This binding is used to describe a basic backlight device made of LEDs. It
> +  can also be used to describe a backlight device controlled by the output of
> +  a LED driver.
> +
> +properties:
> +  compatible:
> +    const: led-backlight
> +
> +  leds:
> +    description: A list of LED nodes
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  brightness-levels:
> +    description: Array of distinct brightness levels. The levels must be
> +      in the range accepted by the underlying LED devices. This is used
> +      to translate a backlight brightness level into a LED brightness level.
> +      If it is not provided, the identity mapping is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  default-brightness-level:
> +    description: The default brightness level (index into the array defined
> +      by the "brightness-levels" property).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +dependencies:
> +  default-brightness-level: [brightness-levels]

I don't think there is a dependency here. default-brightness-level still
makes sense with there is no mapping table present.

Based on Sam's feedback perhaps adding ("if one is provided") to the
parenthetic text.


> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> new file mode 100644
> index 000000000000..7e1f109a38a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/pwm-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: pwm-backlight bindings
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: pwm-backlight
> +
> +  pwms:
> +    maxItems: 1
> +
> +  pwm-names: true
> +
> +  power-supply:
> +    description: regulator for supply voltage
> +
> +  enable-gpios:
> +    description: Contains a single GPIO specifier for the GPIO which enables
> +      and disables the backlight
> +    maxItems: 1
> +
> +  post-pwm-on-delay-ms:
> +    description: Delay in ms between setting an initial (non-zero) PWM and
> +      enabling the backlight using GPIO.
> +
> +  pwm-off-delay-ms:
> +    description: Delay in ms between disabling the backlight using GPIO
> +      and setting PWM value to 0.
> +
> +  brightness-levels:
> +    description: Array of distinct brightness levels. Typically these are
> +      in the range from 0 to 255, but any range starting at 0 will do. The
> +      actual brightness level (PWM duty cycle) will be interpolated from
> +      these values. 0 means a 0% duty cycle (darkest/off), while the last
> +      value in the array represents a 100% duty cycle (brightest).
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +  default-brightness-level:
> +    description: The default brightness level (index into the array defined
> +      by the "brightness-levels" property).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  num-interpolated-steps:
> +    description: Number of interpolated steps between each value of brightness-levels
> +      table. This way a high resolution pwm duty cycle can be used without
> +      having to list out every possible value in the brightness-level array.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +dependencies:
> +  default-brightness-level: [brightness-levels]
> +  num-interpolated-steps: [brightness-levels]

Just for the record, these dependencies are OK. Iit isn't really a good
idea to map 1:1 to a PWM since we end up with a gazillion
indistinguishable levels so the bindings (and the driver) to not allow
such a mode.


Daniel.

Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449FCC2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816020675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610927;
	bh=0SgYMAZMeeGsL+feFlycrOrySDUo9QKrxQjouG7rXxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ubU+qh/TGl0zgxH+69Hk+K0pYb0CG8Z/NQajdcKV/C2UI1BciDY7SqufY5Ws8SX/7
	 km0whcmP7O5OqJSIi0ZxhV33NpOo8mYFhb+vizAlk6K+IucTG4TokjrBDb/AGYAxWg
	 8bxHbHRe+hEg23cD3wrXEWtV8Ex2nHadDrMKIWHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgC3X2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:28:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33060 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbgC3X2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:28:46 -0400
Received: by mail-io1-f65.google.com with SMTP id o127so19777481iof.0;
        Mon, 30 Mar 2020 16:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T3SelQy49aACUXmKXVT4NOVYKNHT6s8n6dCJkbIM0m4=;
        b=c8sFf7NIYPDsrKY+b85hj9rMyKzZTS9wzK36tDmxVgfVVOyl5gOaclLI8jWkY+C6nl
         HJi1saglGRRwSzIvHZDRU0g3CAhzObyiMG3brssrWEyq3miP6Jmzya2oR4Wv/+ZvOPgA
         x/b9J9XMA6qAr4ynRyl7MvzVmj635n/qk6dxGu5IpxFpmr/4WHsPFmFRScyyX6xRWQYo
         VUCjz96mCyPG2wZ0EWGOpf4Lm8iFTD9xcAhBVv6A0OixILDMLpNrhPrYOdzb/LDvlJWM
         XcGZ9uk1qGgBraRe0IgWKzbb3xaih/txaQ8VVHRUM3tVYrdeeooukvasD37lzTYlPkDq
         PKLA==
X-Gm-Message-State: ANhLgQ2FobBBvi8BmNdI/NOzG6b0XJM9pIMA81hQdtxBopdVf2x49LWz
        xfDKwNjnTHNcC7arPxrcntiACvA=
X-Google-Smtp-Source: ADFU+vspZXZ8V4GDKPfcghhhUe9/kcgSRNVcKdRoepeYAVHsPP4lMq1koJNZYBxxqEnNiHv91dAEaw==
X-Received: by 2002:a05:6602:14c6:: with SMTP id b6mr12742265iow.133.1585610924975;
        Mon, 30 Mar 2020 16:28:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m14sm5432374ilr.16.2020.03.30.16.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:28:44 -0700 (PDT)
Received: (nullmailer pid 28523 invoked by uid 1000);
        Mon, 30 Mar 2020 23:28:42 -0000
Date:   Mon, 30 Mar 2020 17:28:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: timer: Add bindings for NVIDIA Tegra186
 timers
Message-ID: <20200330232842.GA25358@bogus>
References: <20200320133452.3705040-1-thierry.reding@gmail.com>
 <20200320133452.3705040-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320133452.3705040-2-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 02:34:46PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The NVIDIA Tegra186 SoC contains an IP block that provides a register
> interface for ten timers with a 29-bit counter that can generate one-
> shot, periodic or watchdog interrupts.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/timer/nvidia,tegra186-timer.yaml | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> new file mode 100644
> index 000000000000..f9b55041a5ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra186 timers
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +description: |
> +  The Tegra186 timer provides ten 29-bit timer counters and one 32-bit TSC
> +  (timestamp counter). The timers run at either a fixed 1 MHz clock rate
> +  derived from the oscillator clock. Each timer can be programmed to raise
> +  one-shot, periodic, or watchdog interrupts.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: NVIDIA Tegra186
> +        items:
> +          - const: nvidia,tegra186-timer
> +
> +      - description: NVIDIA Tegra194
> +        items:
> +          - const: nvidia,tegra194-timer
> +          - const: nvidia,tegra186-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 10

required props?

Also, add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    timer@3010000 {
> +        compatible = "nvidia,tegra186-timer";
> +        reg = <0x03010000 0x000e0000>;
> +        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +        status = "disabled";

Don't show status in examples.

> +    };
> -- 
> 2.24.1
> 

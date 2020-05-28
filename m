Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36546C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F4002084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590675477;
	bh=zqc71Q27/B8/dUwRLhvm0S+/HIhHCNTNHUpNdVv+Lzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D4+IM6tVm73Ip4Mgtbm6Po/uE7Gf5oH51An9mymGUvJt/F+8UZJ6k8JebXOx9QjCx
	 wOBE7RzLuvUZT7A/NnXsvCYicm5vL351ktlt67qhoCPrkTQDqHfx1V9JxIDuwGm8Qz
	 y5AgrV4yiE2Cr6Stirr1N6Jp5Mah414+Q4RcqSOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391074AbgE1ORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:17:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43014 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390953AbgE1ORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:17:52 -0400
Received: by mail-io1-f67.google.com with SMTP id h10so30110855iob.10;
        Thu, 28 May 2020 07:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQyivfejSNXbCqlTdGdrhX0zYMkRgbdRvewpKbUjPCY=;
        b=Dv1T5prLKuzwbUBcUepbVsAyZlBdUeMeG9WYo2EeWgvHycfJBrRs770zkO3Iijsg8l
         jUZl3VEb64xbCNURpo/DOfYh2+vNQzF0+LI4aNKdUfKKTiM26CJvBBCu8HGmh3uZiPZ+
         6rLmeUCYxveYV8T/GVqNakXqFe0H8a9T2Kx0lgieRvrCsO3DmaP6K8aVealyHgiMBqr5
         bgEDCEOhjWf5IIBXRfMGvJqvspPiLasXDS95AX4DSSo70H3xLXzCjh/ILnMq67YKu2vZ
         dP9H3qLONiq2Hap7PcImJrvENINkDIQFDg8//f6MRdBtdvpBgHN1+GUiJrF+vZqQtJ1E
         y4vg==
X-Gm-Message-State: AOAM531JzXRHLNo55YlE9JfaF3VnGcphW0RO7adt2dP45VMUjPg5+viv
        xYxquSwwFuC9/UW0KzIw6g==
X-Google-Smtp-Source: ABdhPJz80onPAITqqpwaWbabl4SgfiYAPqN/MWHUc1QI9/knq0XMJmKYbmvkCambm8IbFEAYxixOHg==
X-Received: by 2002:a05:6602:2e05:: with SMTP id o5mr2566148iow.28.1590675470945;
        Thu, 28 May 2020 07:17:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z3sm2623657ior.45.2020.05.28.07.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:17:50 -0700 (PDT)
Received: (nullmailer pid 4189639 invoked by uid 1000);
        Thu, 28 May 2020 14:17:49 -0000
Date:   Thu, 28 May 2020 08:17:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.com,
        ryans.lee@maximintegrated.com, steves.lee.maxim@gmail.com
Subject: Re: [V6 PATCH 1/2] dt-bindings: Added device tree binding for
 max98390
Message-ID: <20200528141749.GB4186430@bogus>
References: <20200528103755.17381-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528103755.17381-1-steves.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 07:37:55PM +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> Changed since V5:
> 	* Change txt to yaml and fix up the examples.
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example
> 
>  .../bindings/sound/maxim,max98390.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> new file mode 100644
> index 000000000000..1ed4ab9e1c37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX98390 Speaker Amplifier with Integrated Dynamic Speaker Management
> +
> +maintainers:
> +  - Steve Lee <steves.lee@maximintegrated.com>
> +
> +properties:
> +  compatible:
> +      const: maxim,max98390
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.
> +
> +  temperature_calib:

s/_/-/

And missing 'maxim' prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12

Any constraints? 0-2^32 are valid values?

> +
> +  r0_calib:

Same here.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: This is r0 calibration data which was measured in factory mode.
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    max98390: amplifier@38 {
> +            compatible = "maxim,max98390";
> +            reg = <0x38>;
> +            maxim,temperature_calib = <1024>;
> +            maxim,r0_calib = <100232>;
> +    };
> -- 
> 2.17.1
> 

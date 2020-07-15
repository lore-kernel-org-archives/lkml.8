Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FE1C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2092065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594836772;
	bh=fcQDgyyGhKHA92TYesU44H0lTyF4CEkwxG576vw2ga8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCB5uMU3htHaIT0dMxiS50GJzWfDURI2wrqSiWQ57wJQHYTE8BnzVYF6YQRl/GUoq
	 p4j+z+C0rHEH86LqWXFvuJ6ghTxQPQ46hkv2uio2rLmGGPEyDMRRjRCCMjUHJstugt
	 ffskTD6Lb9oMstuU/nuMTPzuqpZpQGNDGiNu7LQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGOSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:12:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37176 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgGOSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:12:49 -0400
Received: by mail-io1-f67.google.com with SMTP id v6so3253986iob.4;
        Wed, 15 Jul 2020 11:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4JqWAJUqAlytAcvwdFiI+dvQqxz5t1soB/hFAm5OjQ=;
        b=cyfNtErCjqed345PiCA7PX9i2S6XtU9+udy7nzIUOyePJqoO0vBlj27Vx1l6MoF3lo
         pBpRCenkyqQSXcTwEOPlR84opu0SDJVMbb4sHFX5AP4dTMsfmJnlYgiU0OjcXL8fQy4Y
         WE8uyN7B/3NeruuovSHn0YUGWOu4xLYSsCgKUAK/URLIVOw8tWkRyTcuDI2SWcOKFh3q
         Imgv1ueCiYSYHd7PuoCWZa5zWkwnr7ogWGwYtLBfIwyVF+sfocfQT8S08kBDVJfr8qFB
         qL9DmzbBfARAjoX4pPtbwHkKAh+FqplrjcoNa+r1CID9LLLuHURDXKeC2cg+P67Xd94B
         F0jA==
X-Gm-Message-State: AOAM532E5whfqZfW2rdcNgbKr1ITzrdmKXte1H0b2crOuenCVZf/NYAz
        4UgJoTeexv/tWFv9p8fm9g==
X-Google-Smtp-Source: ABdhPJxxgQ53vC9zVBi4XB7WdDH+bHdKBpexEFln2Bz9WLXLPsN+v2YsSm0PlI2wwA+pwM3cWthaUg==
X-Received: by 2002:a5d:9c0e:: with SMTP id 14mr519954ioe.109.1594836768497;
        Wed, 15 Jul 2020 11:12:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k3sm1414030ils.8.2020.07.15.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:12:47 -0700 (PDT)
Received: (nullmailer pid 545010 invoked by uid 1000);
        Wed, 15 Jul 2020 18:12:47 -0000
Date:   Wed, 15 Jul 2020 12:12:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shifu0704@thundersoft.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Message-ID: <20200715181247.GA535887@bogus>
References: <20200612171342.25364-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612171342.25364-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:13:41PM -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2770.txt     | 37 ---------
>  .../devicetree/bindings/sound/tas2770.yaml    | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/tas2770.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2770.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2770.txt b/Documentation/devicetree/bindings/sound/tas2770.txt
> deleted file mode 100644
> index ede6bb3d9637..000000000000
> --- a/Documentation/devicetree/bindings/sound/tas2770.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Texas Instruments TAS2770 Smart PA
> -
> -The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
> -efficiently driving high peak power into small loudspeakers.
> -Integrated speaker voltage and current sense provides for
> -real time monitoring of loudspeaker behavior.
> -
> -Required properties:
> -
> - - compatible:	   - Should contain "ti,tas2770".
> - - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
> - - #address-cells  - Should be <1>.
> - - #size-cells     - Should be <0>.
> - - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
> - - ti,imon-slot-no:- TDM TX current sense time slot.
> - - ti,vmon-slot-no:- TDM TX voltage sense time slot.
> -
> -Optional properties:
> -
> -- interrupt-parent: the phandle to the interrupt controller which provides
> -                     the interrupt.
> -- interrupts: interrupt specification for data-ready.
> -
> -Examples:
> -
> -    tas2770@4c {
> -                compatible = "ti,tas2770";
> -                reg = <0x4c>;
> -                #address-cells = <1>;
> -                #size-cells = <0>;
> -                interrupt-parent = <&msm_gpio>;
> -                interrupts = <97 0>;
> -                ti,asi-format = <0>;
> -                ti,imon-slot-no = <0>;
> -                ti,vmon-slot-no = <2>;
> -        };
> -
> diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
> new file mode 100644
> index 000000000000..8c667fd37a57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

Do you have rights to relicense? The old binding defaults to 
GPL-2.0-only. If so, great.

Either way, GPL-2.0-only not GPL-2.0+.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +# Copyright (C) 2019-20 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2770.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments TAS2770 Smart PA
> +
> +maintainers:
> +  - Shi Fu <shifu0704@thundersoft.com>
> +
> +description: |
> +  The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
> +  efficiently driving high peak power into small loudspeakers.
> +  Integrated speaker voltage and current sense provides for
> +  real time monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2770
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
> +
> +  reset-gpio:
> +    description: GPIO used to reset the device.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,imon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX current sense time slot.
> +
> +  ti,vmon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX voltage sense time slot.
> +
> +  ti,asi-format:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sets TDM RX capture edge.
> +    enum:
> +          - 0 # Rising edge
> +          - 1 # Falling edge
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c0 {
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     codec: codec@4c {
> +       compatible = "ti,tas2770";
> +       reg = <0x4c>;
> +       #sound-dai-cells = <1>;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <14>;
> +       reset-gpio = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +       ti,vmon-slot-no = <2>;
> +     };
> +   };
> +
> -- 
> 2.26.2
> 

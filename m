Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C40A82065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594844127;
	bh=dGYf/tHQBWn4bdbRSiuDfLlvttK4hCaHiP3yARv6KX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vzPsI8xp3yrSAzkRmusnFFk+I8l326xoBJDhZDBdS673xGvo+ygrolxsz2XNpANNP
	 VselvDxE0YjuweWpsCMP0IE2DDWYnGUQXvg4RKCcMblA6rMOzNnngAQV1Ut8THavKE
	 IsBEcM5dYu+8V9qk4PWtOW5Gu1bU5howW2yeWVcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGOUP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:15:26 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39420 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:15:25 -0400
Received: by mail-io1-f68.google.com with SMTP id f23so3620327iof.6;
        Wed, 15 Jul 2020 13:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jwmed9W8YV4otf8sjLnvkq/YvcQL2YKBO/oE4ZEh/lU=;
        b=EP+YkyodgfsNOHgSinM9PF6GMz9ZB5L9SJFUX4DE1IkoVG3VYBZkYnbw9KDVI1EJ07
         8uKFH3Kb9WN9kEKu9FTD7MbBYv+pOPsqFP45GN6+cmrxITmZ5Oze01utNZrIkCYP6Ibc
         NFq8buEi7yUBj80z9YMAoemKbT2tl451m0u3KbVu3j++iJMYnw5pPy7JZHiaY4KjtZIZ
         RgCXhj99S/dfkVXXq6RhRz0syIkUNfxCaZeT6HM0hFkYJpuqRTjsvf7cttufkWbM5ydS
         lvoPpu70Exwtt9ZIXUtS3/sNb3DaNSqqmVMU7mwpPEx1gkRVgAj/9E62rH7cgb4YVNNX
         V8BQ==
X-Gm-Message-State: AOAM530UYJJ7/fnUuOyIfeHE3ENm0tG7lP5CGIKK3i1feFUlTH1xFjb/
        gngUaVxvmhnaOaXgcLkCXQ==
X-Google-Smtp-Source: ABdhPJwWGqj/kbCRlCfbWr0duC0h62VBfCvd92AK2M1tAhhTkctI7eNuwUUYbPaW8MF3aZEMlexccg==
X-Received: by 2002:a6b:1885:: with SMTP id 127mr1052907ioy.17.1594844124494;
        Wed, 15 Jul 2020 13:15:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a1sm1531119ilq.50.2020.07.15.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:15:23 -0700 (PDT)
Received: (nullmailer pid 746665 invoked by uid 1000);
        Wed, 15 Jul 2020 20:15:22 -0000
Date:   Wed, 15 Jul 2020 14:15:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: tas2562: Convert the tas2562 binding to
 yaml
Message-ID: <20200715201522.GA740682@bogus>
References: <20200626154143.20351-1-dmurphy@ti.com>
 <20200626154143.20351-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626154143.20351-4-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 10:41:43AM -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2562.txt     | 37 ---------
>  .../devicetree/bindings/sound/tas2562.yaml    | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
> deleted file mode 100644
> index dc6d7362ded7..000000000000
> --- a/Documentation/devicetree/bindings/sound/tas2562.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Texas Instruments TAS2562 Smart PA
> -
> -The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
> -efficiently driving high peak power into small loudspeakers.
> -Integrated speaker voltage and current sense provides for
> -real time monitoring of loudspeaker behavior.
> -
> -Required properties:
> - - #address-cells  - Should be <1>.
> - - #size-cells     - Should be <0>.
> - - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
> - - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
> - - ti,imon-slot-no:- TDM TX current sense time slot.
> - - ti,vmon-slot-no:- TDM TX voltage sense time slot. This slot must always be
> -		     greater then ti,imon-slot-no.
> -
> -Optional properties:
> -- interrupt-parent: phandle to the interrupt controller which provides
> -                    the interrupt.
> -- interrupts: (GPIO) interrupt to which the chip is connected.
> -- shut-down-gpio: GPIO used to control the state of the device.
> -
> -Examples:
> -tas2562@4c {
> -        #address-cells = <1>;
> -        #size-cells = <0>;
> -        compatible = "ti,tas2562";
> -        reg = <0x4c>;
> -
> -        interrupt-parent = <&gpio1>;
> -        interrupts = <14>;
> -
> -	shut-down-gpio = <&gpio1 15 0>;
> -        ti,imon-slot-no = <0>;
> -        ti,vmon-slot-no = <1>;
> -};
> -
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
> new file mode 100644
> index 000000000000..1fb467e14d4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

Same licensing comment here as tas2770

> +# Copyright (C) 2019 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments TAS2562 Smart PA
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
> +  efficiently driving high peak power into small loudspeakers.
> +  Integrated speaker voltage and current sense provides for
> +  real time monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2562
> +      - ti,tas2563
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
> +
> +  shut-down-gpio:
> +    description: GPIO used to control the state of the device.
> +    deprecated: true

Why do we need this as the driver never worked?

> +
> +  shutdown-gpio:
> +    description: GPIO used to control the state of the device.

-gpios is the preferred form: shutdown-gpios

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
> +    description: |
> +      TDM TX voltage sense time slot.  This slot must always be greater then
> +      ti,imon-slot-no.
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
> +       compatible = "ti,tas2562";
> +       reg = <0x4c>;
> +       #sound-dai-cells = <1>;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <14>;
> +       shutdown-gpio = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +       ti,vmon-slot-no = <2>;
> +     };
> +   };
> +
> +...
> -- 
> 2.26.2
> 

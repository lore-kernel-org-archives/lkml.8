Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3A7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7D2206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591819640;
	bh=AS09uQ5zG0psed2eOsF980Tp3NDWfM8ROSl6fOyce9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RVwesc7j5XvaVHtv/2kfejLQ/4bwVz6ZuKxpDRrq7rGaxzb48g3Ho/yp8n7KZ6GvN
	 rv9ZLDkDO3ec6/rAnBdXSnOa7N7wOAxanPQtJR6EQpDROgs5+NjVyXCgI/QemYv/FP
	 gMyGE+g0Hmp7cQnyiyQOwJTLlYqQ4j6YkCPGc9VU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgFJUHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:07:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44426 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgFJUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:07:18 -0400
Received: by mail-io1-f66.google.com with SMTP id p20so3728467iop.11;
        Wed, 10 Jun 2020 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mDjqIFf471IkbejX9X3mSLq57qUbwtdIynz5m3TbNPc=;
        b=N1EBnFhBD1dkm6Zs5C7O6hcfqYj643A3BQLHyDb4Gl3QDVVdBY2hOXhDXU03ZiNBxR
         Zh7X9kWyGgHznMgBuG0nzNDxeJeFIhwVTHN0V7+ALjQcdWOVGmWUMmmL5ZQCCnHSrZ8M
         OX6Pkx4Jo/aR3MSpQHmDE0IbrPgb0J6BkM1HxpD3wUowjopDH/XYsDyY1uypcMWh6vqn
         mn5Bb4Dbx88oiElpEbZCWfC71T4M6mlsM8eontSXwSCY0HQaYzzIyNGzvsvh3ekVHsR2
         xrtHPvU8nx11v4Hkum/MXo/ZCe5485TTq5YFHxReQvoHZbuhWeSLgD0+CABfd466xgWA
         Epiw==
X-Gm-Message-State: AOAM530a9JZ9m1aIk9x5Jg2mIezHJHOIXhEbn89TG/OulnHjRjWWZQvY
        n+cIMsdPcZdUQ9Ppo1vAfw==
X-Google-Smtp-Source: ABdhPJx0DQIW00e65FugR8+MSaJ77U4Ds57FdAdVskpy7VWOQQOAAYy8VolmUsIiUifIEK8uD4BRrg==
X-Received: by 2002:a6b:7516:: with SMTP id l22mr5097843ioh.18.1591819636816;
        Wed, 10 Jun 2020 13:07:16 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y5sm491598iov.3.2020.06.10.13.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:07:16 -0700 (PDT)
Received: (nullmailer pid 3629265 invoked by uid 1000);
        Wed, 10 Jun 2020 20:07:15 -0000
Date:   Wed, 10 Jun 2020 14:07:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: tas2562: Convert the tas2562 binding to
 yaml
Message-ID: <20200610200715.GA3612550@bogus>
References: <20200602193524.30309-1-dmurphy@ti.com>
 <20200602193524.30309-2-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602193524.30309-2-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:35:24PM -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2562.txt     | 34 ----------
>  .../devicetree/bindings/sound/tas2562.yaml    | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 34 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
> deleted file mode 100644
> index 94796b547184..000000000000
> --- a/Documentation/devicetree/bindings/sound/tas2562.txt
> +++ /dev/null
> @@ -1,34 +0,0 @@
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
> -
> -Optional properties:
> -- interrupt-parent: phandle to the interrupt controller which provides
> -                    the interrupt.
> -- interrupts: (GPIO) interrupt to which the chip is connected.
> -- shut-down: GPIO used to control the state of the device.
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
> -	shut-down = <&gpio1 15 0>;
> -        ti,imon-slot-no = <0>;
> -};
> -
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
> new file mode 100644
> index 000000000000..11e0269d03b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
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
> +       I2C addresss of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
> +
> +  shut-down:

Hopefully, this is an error. It should be 'shut-down-gpios'.

Looking at the driver, it is also broken. It's passing 'shut-down-gpio' 
which means the GPIO core is looking for 'shut-down-gpio-gpio' or 
'shut-down-gpio-gpios'.

Also the standardish naming here is 'shutdown-gpios'. Given this 
probably never worked, we should use that.

> +    description: GPIO used to control the state of the device.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,imon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX current sense time slot.
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
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
> +
> +       shut-down = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +     };
> +   };
> +
> -- 
> 2.26.2
> 

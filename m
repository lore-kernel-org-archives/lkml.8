Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF69BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8DC22CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535509;
	bh=OKaS1P28nJxxtCAWZB+HdxF8uwxJI3GOsJdAJpz1Wb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pzAEEizUGuQSDAiHHDKQL4rH0dwllI0h8U4lHVBbXNCqQ1UpBU3C50vKROqErCLqo
	 JA5V0b7ydn7WLGx4Zr1Z2wb1M2g3e2EuEDJXGn+7k46cnMGJmuOU1D1P2uMXI+9Iuq
	 E7vUzV6tfFIPSg+R3Ix3tHwwaaQYE5bzC2lrPx88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgGWUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:18:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41173 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:18:26 -0400
Received: by mail-io1-f68.google.com with SMTP id p205so7617289iod.8;
        Thu, 23 Jul 2020 13:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+bs3OlS8UQmhllIUhonZMM/+IfllG/gM+l8StXXg04=;
        b=Cj0Nypo93IqGg+qJzGKISCP+PVGF5qtw5DbS+WFFuKUZKGG6AzVASrBnW8TclQahBI
         9QSrpf8os1c8jLb+olVzwZMwMx1tyq8F+zKP0X2qR7b92qlb7Ld9/MvIDO5jIXktP+qG
         oP1fqPFtDuhgRMUn6tTFnW8zYRHuacGAwh4clbwbhk5bYYuQSKQXlCyu7geXg+G2vlDs
         aChkH35dH6vtErDREsEf0JoPVaP4i1wT5+0STq+4Jp6PLLcwzxiN5Yrbas2gPFMxwjP8
         1O8s4tshvMSeRy99EGYnmGXRuTDgXHPxskr4Iy9CAe++JJ1fwCzqZiV5DJDGF7WhkEa5
         oLRA==
X-Gm-Message-State: AOAM533mtR6wGYBVOozv21kfNvwuu7ElBO1BdG/aIg5RzpUTA0w7XYOf
        CmT6JjKWlXN5OsJT3n6rc5g+OHWSXA==
X-Google-Smtp-Source: ABdhPJx40znh6EFlcwp+i/5XHaqEwUcM8wAzVExw4KY1VjVYL+2q03d6mC37eNjFzhZiBelEbH+gdA==
X-Received: by 2002:a02:7786:: with SMTP id g128mr4182617jac.45.1595535502832;
        Thu, 23 Jul 2020 13:18:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u65sm2019040iod.45.2020.07.23.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:18:21 -0700 (PDT)
Received: (nullmailer pid 793895 invoked by uid 1000);
        Thu, 23 Jul 2020 20:18:19 -0000
Date:   Thu, 23 Jul 2020 14:18:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: tas2562: Convert the tas2562 binding
 to yaml
Message-ID: <20200723201819.GA783613@bogus>
References: <20200722154706.9657-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722154706.9657-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:47:05AM -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Updated the shutdown-gpio to shutdown-gpios and fixed licensing to be
> GPL-2.0-only.
> 
>  .../devicetree/bindings/sound/tas2562.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
> new file mode 100644
> index 000000000000..8d75a798740b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +  shut-down-gpios:
> +    description: GPIO used to control the state of the device.
> +    deprecated: true

I think you should just remove this given it never worked with any 
released kernel. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  shutdown-gpios:
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
> +       shutdown-gpios = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +     };
> +   };
> +
> -- 
> 2.27.0
> 

Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C8AC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD842467A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFnpOOWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgANON0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:13:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50947 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgANONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:13:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so5758593pjb.0;
        Tue, 14 Jan 2020 06:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwewGPMlyYgbBTwNYGVyidwgkkrwVgWPxHCzzjXixgo=;
        b=nFnpOOWJnpzV3jjSJ3p1/KJFgv9Xxh3NLQ7sWu/YdtCQ7oG7KuGseIqty5wPiX7AzN
         Xu52Bw8e0X4JqNKV9zN0oF0ty/aoyi8/cVGd6Dstd3riwsx7LTwo2QxmMTz02rKBEbMT
         0APFp8y7MNBlREBae5BDW7LOJuWVzRkk5m35YdAfMV4/MFEQ+EEBG1/otusf4dy7nmT3
         nZL0YiV8qvaL/LnGDMBmsKHRaRhLlGzlZtMnIDP2Tdsyb1vMAUvsas+QxnEJksODBDdA
         YMgmsV94puRDxFskXeBlpHZ3Sv9YGpQdz3G+d/PojcFyeDTKvddzaGDcoors096kyaFm
         XZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwewGPMlyYgbBTwNYGVyidwgkkrwVgWPxHCzzjXixgo=;
        b=F2AoGxQvVQEiW8MeDNSp8QxAJxv+rdqsbnxJ6rT8dEwjDnUueYwFr8Ehs+0G4+nuFT
         Z5LhP/rhYrIqwsh1ijjqnvKeboC7lgdlFK0IsSeBIjmzKRiXcAbmEon+iX5hv0eBDdyz
         BtipX1A/sgDI6w7DAwOajzp7BnmoqV6M5P7Y15Yr+2ZHlZtBZKR3o9GhLYnfeJJUD477
         jZTRp4fi4H/EnxkYNn13NnfUGo5zbBA+6LCluu+9nE/Tqn/u8CLND38lk5MVgfgHEElW
         lZC8dDPSDGQG1/H9b0i5CJ6SyG6JAR2w6owhs1s7qANcOHBtsk924zZXuj63iJ42g/lf
         F0uQ==
X-Gm-Message-State: APjAAAUQzd1mpAUOzF/O5tjJIDoa4yogthpOSryrLJ2pcbQIoOCaHgK4
        h62xj1ZZpKCA05sqJ/dODYg=
X-Google-Smtp-Source: APXvYqyYJslodyhGFzqBviNM5lPDsibwuQIPqZZCElUafFxIeihOKuHyN8mtcSwzaa3GZBemjntIFw==
X-Received: by 2002:a17:90b:8b:: with SMTP id bb11mr29834025pjb.27.1579011205177;
        Tue, 14 Jan 2020 06:13:25 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d26sm17174619pgv.66.2020.01.14.06.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 06:13:24 -0800 (PST)
Date:   Tue, 14 Jan 2020 06:13:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, biabeniamin@outlook.com
Subject: Re: [PATCH v4 2/3] dt-binding: hwmon: Add documentation for ADM1177
Message-ID: <20200114141323.GA19598@roeck-us.net>
References: <20200114112159.25998-1-beniamin.bia@analog.com>
 <20200114112159.25998-2-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114112159.25998-2-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 01:21:58PM +0200, Beniamin Bia wrote:
> Documentation for ADM1177 was added.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
> Changes in v4:
> -complains about using tab instead of space fixed
> 
>  .../bindings/hwmon/adi,adm1177.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> new file mode 100644
> index 000000000000..2a9822075b36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,adm1177.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1177
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      The value of curent sense resistor in microohms. If not provided,
> +      the current reading and overcurrent alert is disabled.
> +
> +  adi,shutdown-threshold-microamp:
> +    description:
> +      Specifies the current level at which an over current alert occurs.
> +      If not provided, the overcurrent alert is configured to max ADC range
> +      based on shunt-resistor-micro-ohms.
> +
> +  adi,vrange-high-enable:
> +    description:
> +      Specifies which internal voltage divider to be used. A 1 selects
> +      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pwmon@5a {
> +                compatible = "adi,adm1177";
> +                reg = <0x5a>;
> +                shunt-resistor-micro-ohms = <50000>; /* 50 mOhm */
> +                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
> +                adi,vrange-high-enable;
> +        };
> +    };
> +...

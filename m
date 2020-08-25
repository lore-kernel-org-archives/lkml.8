Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96540C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B962074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382865;
	bh=Jc1yTj2k+TMe4kkbP/gEbLKCPGt2TGTJIwlnUB29iv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s+JQ3VdBB+yFsctpEpBFUnjwKYiYf4+L08RwFl14wXsAEq0MTci6LqjJEt27ikU0V
	 gru31W6f8XiMkveQS9RzQNF3xMeW1ki6HzH5O+FdfkxsdBc0X45NV6SQf0mOnbYbkz
	 fMZXpcDR2rPPYdoetcDqQBaewJyi6ZpLzLItXgGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHYTOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:14:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33765 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHYTOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:14:23 -0400
Received: by mail-io1-f67.google.com with SMTP id g14so13671641iom.0;
        Tue, 25 Aug 2020 12:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kXT8efqVig+LdM0yrUNVxG9QbnNoRGTPjf9llPDOwRE=;
        b=nIby3NiXyE2w705KoHFl+DkpTd1H2CJjBbqCUS+c3Xjs8VA9NGuZuxg2Qvajk4Vasy
         DqN+5Wguw2L+7pR8qGCJ86qJZwBRmmSBNOjyuha7cn/hWe7pmJncXLM5W/nZTJhe2RpD
         +XmsFPGMad4muSFfqqc9hGU+KS3iv7CT1TNDokr9MVqQ4tln2FUze6YgW0hnpgmq2U7K
         EmpULmtC35cZIwqdObeKOHM9H6r3qpfuzb6WXo4QgiP4l23nNQhMr45qW6u+SyEW0d8b
         5z0uX1Mt97+E83LNv/Lp87AGyBDKkWVNKbuMKN4k/FKKyIsUG76lVWoI0TXEHYpKHX5A
         9rIQ==
X-Gm-Message-State: AOAM531qR6OpoALNA+Nc2/iGvhrJtSsTecFADlZzAYGSh7hrg6XLxSZn
        68cx40tcTAiGOjJvrXr6Iw==
X-Google-Smtp-Source: ABdhPJyhmrq6L2ellWa/YRk71sLM4zWMKvwTlQe8Q4nMUBOQkfLv2+j6dZS/bqwkv9tf4ChqXUl/hw==
X-Received: by 2002:a6b:1885:: with SMTP id 127mr10161104ioy.205.1598382861817;
        Tue, 25 Aug 2020 12:14:21 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id i144sm1075486ioa.55.2020.08.25.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:14:21 -0700 (PDT)
Received: (nullmailer pid 1152461 invoked by uid 1000);
        Tue, 25 Aug 2020 19:14:19 -0000
Date:   Tue, 25 Aug 2020 13:14:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: lp87565: convert to yaml
Message-ID: <20200825191419.GA1144795@bogus>
References: <20200817145018.3992-1-luca@lucaceresoli.net>
 <20200817145018.3992-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817145018.3992-2-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 04:50:16PM +0200, Luca Ceresoli wrote:
> The definition of "xxx-in-supply" was generic, thus define in detail the
> possible cases for each chip variant.
> 
> While there also apply a few smaller improvements:
> 
>  - document that the only possible I2C slave address is 0x60 as per the
>    datasheet and fix the second example accordingly
>  - remove "MFD driver" from the title as it is implementation specific
>  - replace "PMIC" with "buck converter" in title as it is more informative
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4:
>  - split in two different bindings (Rob)
>  - remove "MFD driver" from title as it is implementation specific; also
>    replace "PMIC" with "buck converter" which is more informative
> 
> Changes in v3:
>  - fix yaml errors
> 
> Changes in v2:
>  - this patch replaces patch "regulator: lp87565: dt: remove duplicated
>    section" in RFC,v1 (Rob Herring)
>  - use capital letters consistently (Lee Jones)
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       | 79 -----------------
>  .../bindings/mfd/ti,lp87561-q1.yaml           | 68 +++++++++++++++
>  .../bindings/mfd/ti,lp87565-q1.yaml           | 85 +++++++++++++++++++
>  3 files changed, 153 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
> new file mode 100644
> index 000000000000..c0c56e9e5a06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,lp87561-q1.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,lp87561-q1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LP87561-Q1 single 4-phase output buck converter
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,lp87561-q1
> +
> +  reg:
> +    description: I2C slave address
> +    const: 0x60
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description:
> +      The first cell is the pin number.
> +      The second cell is is used to specify flags.
> +      See ../gpio/gpio.txt for more information.
> +    const: 2
> +
> +  buck3210-in-supply:
> +    description:
> +      Phandle to parent supply node for all the four BUCK converters.
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - buck3210-in-supply

additionalProperties: false

> +
> +examples:
> +  - |
> +    i2c@0 {
> +        reg = <0x0 0x100>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@60 {
> +            compatible = "ti,lp87561-q1";
> +            reg = <0x60>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            buck3210-in-supply = <&vsys_3v3>;
> +
> +            regulators {
> +                buck3210_reg: buck3210 {

This needs to be described:

regulators:
  type: object

  properties:
    buck3210:
      type: object
      $ref: /schemas/regulators/regulators.yaml#

  required:
    - buck3210

  additionalProperties: false

  
> +                    /* VDD_CORE */
> +                    regulator-name = "buck3210";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <800000>;
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
> new file mode 100644
> index 000000000000..1eafe0fb90cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,lp87565-q1.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,lp87565-q1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LP87565-Q1 / LP87565 dual 2-phase output buck converter
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,lp87565
> +      - const: ti,lp87565-q1
> +
> +  reg:
> +    description: I2C slave address
> +    const: 0x60
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description:
> +      The first cell is the pin number.
> +      The second cell is is used to specify flags.
> +      See ../gpio/gpio.txt for more information.
> +    const: 2
> +
> +  buck10-in-supply:
> +    description:
> +      Phandle to parent supply node for BUCK0 and BUCK1 converters.
> +
> +  buck23-in-supply:
> +    description:
> +      Phandle to parent supply node for BUCK2 and BUCK3 converters.
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - buck10-in-supply
> +  - buck23-in-supply
> +
> +examples:
> +  - |
> +    i2c@0 {
> +        reg = <0x0 0x100>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@60 {
> +            compatible = "ti,lp87565-q1";
> +            reg = <0x60>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            buck10-in-supply = <&vsys_3v3>;
> +            buck23-in-supply = <&vsys_3v3>;
> +
> +            regulators {
> +                buck10_reg: buck10 {
> +                    /* VDD_MPU */
> +                    regulator-name = "buck10";
> +                    regulator-min-microvolt = <850000>;
> +                    regulator-max-microvolt = <1250000>;
> +                    regulator-always-on;
> +                    regulator-boot-on;
> +                };
> +
> +                buck23_reg: buck23 {
> +                    /* VDD_GPU */
> +                    regulator-name = "buck23";
> +                    regulator-min-microvolt = <850000>;
> +                    regulator-max-microvolt = <1250000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> -- 
> 2.28.0
> 

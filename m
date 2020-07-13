Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AD32067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594666874;
	bh=lNjHWEi9F4KaCkAs+sv7rO9bpXQPeCIbirdMvRbjPZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1CaqztVVdUaZRk9gtRl2QEwGqo01AaRDunjvXAG7dxrP7w5WwpNne14S2oIMGjG54
	 DTj1mYfgopNOokeSvxgdiNMwZXKz57HKnVDoh7xk5TaCwJCdm6JkBZGhD33KtGVvVs
	 ykgJbajb1JXhpw92ODle8irQwOQWK+XZc78+fzeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGMTBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:01:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40506 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgGMTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:01:11 -0400
Received: by mail-io1-f66.google.com with SMTP id l17so3155848iok.7;
        Mon, 13 Jul 2020 12:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/PWhrPGWNyWZTiLQ2bidZ/laPwZFcNcW60Kk6Tdy/kk=;
        b=Q9cYwPuiL0WnusH1Q0XMlgS2aDm+gG/Uh+QmeXGklAXSFfz10jhyrZUTlDQwl3tDRC
         ydePMkkEwHjneV89Y61LA/TrdgMtJJ00SEwwJNG0LbCg4Y3DxW4OzL9D4daYX67FJ234
         Jj4Ghm0/zMHm/Gi3xku4EbVqneLQsl2889EXa/+jnj6DBLDsjmcZnHeuA7R1oYMmeMlB
         Bw+H7W/zZRjNRqA/bEbj0POjFumn0TcwIE85SDh2HZICzCH9rcNtkeDkGojhc51lLwUg
         g2uwKrQIRLdqvZrMAHQaooxFELsYLWWuwB/pYQ9GhZHG4roa0YSTs3sCsSuV/rGip17N
         u27g==
X-Gm-Message-State: AOAM5301Fbc8Fi/V+cHqOQiksxFy5fqXFiwlAze897G/Nur8BkgGlusv
        g0+xSXtmACK4qnDgT/qNBQT3Co8SWA==
X-Google-Smtp-Source: ABdhPJyfWSr+1YeWhcSIcED1aI/M6uEpq8MSvXybejQY06oAURXrIPqw0GhVRTxwRnIK6AFe0h8GEg==
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr1191433iok.43.1594666868544;
        Mon, 13 Jul 2020 12:01:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l22sm7935953ioc.24.2020.07.13.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:01:07 -0700 (PDT)
Received: (nullmailer pid 544567 invoked by uid 1000);
        Mon, 13 Jul 2020 19:01:07 -0000
Date:   Mon, 13 Jul 2020 13:01:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: lp87565: convert to yaml
Message-ID: <20200713190107.GA538448@bogus>
References: <20200622204329.11147-1-luca@lucaceresoli.net>
 <20200622204329.11147-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622204329.11147-3-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:43:27PM +0200, Luca Ceresoli wrote:
> The definition of "xxx-in-supply" was generic, thus define in detail the
> possible cases for each chip variant.
> 
> Also document that the only possible I2C slave address is 0x60 as per the
> datasheet and fix the second example accordingly.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
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
>  .../devicetree/bindings/mfd/lp87565.txt       |  79 ----------
>  .../devicetree/bindings/mfd/ti,lp875xx.yaml   | 142 ++++++++++++++++++
>  2 files changed, 142 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
> deleted file mode 100644
> index 41671e0dc26b..000000000000
> --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -TI LP87565 PMIC MFD driver
> -
> -Required properties:
> -  - compatible:	"ti,lp87565", "ti,lp87565-q1"
> -  - reg:		I2C slave address.
> -  - gpio-controller:	Marks the device node as a GPIO Controller.
> -  - #gpio-cells:	Should be two.  The first cell is the pin number and
> -			the second cell is used to specify flags.
> -			See ../gpio/gpio.txt for more information.
> -  - xxx-in-supply:	Phandle to parent supply node of each regulator
> -			populated under regulators node. xxx should match
> -			the supply_name populated in driver.
> -Example:
> -
> -lp87565_pmic: pmic@60 {
> -	compatible = "ti,lp87565-q1";
> -	reg = <0x60>;
> -	gpio-controller;
> -	#gpio-cells = <2>;
> -
> -	buck10-in-supply = <&vsys_3v3>;
> -	buck23-in-supply = <&vsys_3v3>;
> -
> -	regulators: regulators {
> -		buck10_reg: buck10 {
> -			/* VDD_MPU */
> -			regulator-name = "buck10";
> -			regulator-min-microvolt = <850000>;
> -			regulator-max-microvolt = <1250000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -		};
> -
> -		buck23_reg: buck23 {
> -			/* VDD_GPU */
> -			regulator-name = "buck23";
> -			regulator-min-microvolt = <850000>;
> -			regulator-max-microvolt = <1250000>;
> -			regulator-boot-on;
> -			regulator-always-on;
> -		};
> -	};
> -};
> -
> -TI LP87561 PMIC:
> -
> -This is a single output 4-phase regulator configuration
> -
> -Required properties:
> -  - compatible:	"ti,lp87561-q1"
> -  - reg:		I2C slave address.
> -  - gpio-controller:	Marks the device node as a GPIO Controller.
> -  - #gpio-cells:	Should be two.  The first cell is the pin number and
> -			the second cell is used to specify flags.
> -			See ../gpio/gpio.txt for more information.
> -  - xxx-in-supply:	Phandle to parent supply node of each regulator
> -			populated under regulators node. xxx should match
> -			the supply_name populated in driver.
> -Example:
> -
> -lp87561_pmic: pmic@62 {
> -	compatible = "ti,lp87561-q1";
> -	reg = <0x62>;
> -	gpio-controller;
> -	#gpio-cells = <2>;
> -
> -	buck3210-in-supply = <&vsys_3v3>;
> -
> -	regulators: regulators {
> -		buck3210_reg: buck3210 {
> -			/* VDD_CORE */
> -			regulator-name = "buck3210";
> -			regulator-min-microvolt = <800000>;
> -			regulator-max-microvolt = <800000>;
> -			regulator-always-on;
> -			regulator-boot-on;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml b/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
> new file mode 100644
> index 000000000000..2da703918d6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,lp875xx.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,lp875xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LP875xx PMIC MFD driver
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,lp87565
> +      - const: ti,lp87565-q1
> +      - const: ti,lp87561-q1
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
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,lp87565
> +              - ti,lp87565-q1
> +    then:
> +      properties:
> +        buck10-in-supply:
> +          description:
> +            Phandle to parent supply node for BUCK0 and BUCK1 converters.
> +
> +        buck23-in-supply:
> +          description:
> +            Phandle to parent supply node for BUCK2 and BUCK3 converters.
> +
> +      required:
> +        - buck10-in-supply
> +        - buck23-in-supply
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,lp87561-q1
> +    then:
> +      properties:
> +        buck3210-in-supply:
> +          description:
> +            Phandle to parent supply node for all the four BUCK converters.
> +
> +      required:
> +        - buck3210-in-supply

I think this should probably be 2 schema documents (and a 3rd for the 
next patch)...

> +
> +examples:
> +  - |
> +    /* TI LP87565-Q1 PMIC (dual 2-phase output configuration) */
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

The regulators also need to be documented.

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
> +  - |
> +    /* TI LP87561 PMIC (single 4-phase output configuration) */
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
> -- 
> 2.27.0
> 

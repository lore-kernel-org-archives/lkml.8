Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F332087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596230449;
	bh=hrR386mya+7AhdikIaM5Zv2gPJqKn2R7GamFkRVOCUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pVGk73UZ661FqOkU1Luq1HkO9pkD3aSQaCZgeF4G1fsXLQtI3WiRolMRy/wSVQIIF
	 pmtnq/1kEiE9zE7e6GLYHlGJtwcm24Zck6JmDTeg4RMWcEc9dThlwVEndltwua0RwA
	 aPab2wmrOB8H8G1FAM9KlSwDd88Ox8JsBl5Fnl78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgGaVUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 17:20:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40620 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgGaVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 17:20:48 -0400
Received: by mail-io1-f68.google.com with SMTP id l17so33021009iok.7;
        Fri, 31 Jul 2020 14:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QKHE5ZZtlYUXL39ZINHqOwftjY2XWxCeYjG1V0Yb5Cg=;
        b=rbB2P2w9zB+vnnAlh+Ld7gruj3F0TMDaFvkT87qsalZZMqYha/xEAVKyPF/kcYDNNv
         0YxjL/9DPnI95sOJseZXBPc2yl15WgOHcAqOjHtjbt4Ymsl5Y2iIQ12MHwGt961AEIiC
         LsANtX/vXh8WBuPicxxAP4EpOR0ax6GonZMKX0H29Vzm3sZouFlLAYXdp9tf7uMg8fgS
         48qg8K8kwVtXXoPy/RrU0cuKHjL3+SFMXzc5er6cJHJdo9P1jvc/+8x3dBwTs7l7FPYx
         hEP1e6gimZk+ljnfuVELvO5IpgfPXIPcnLGxahSeDq4XfjRjbyhBxb/cDAU22CLo1lqm
         JZPw==
X-Gm-Message-State: AOAM533wVduL3zQq7g15TI8gMCHu5WFDgaZceLMmlBKPkFD7kuTC9bj9
        oFCO0WxQFPrOKxgY0+vaJA==
X-Google-Smtp-Source: ABdhPJwu/O6vhDnWc9dQx3Uv3Xnb+nlbRHoqGZxKGaa+wS2/njrULfufBWeusR4jaT3Gd+PuisN1Dg==
X-Received: by 2002:a02:8792:: with SMTP id t18mr7163620jai.117.1596230446956;
        Fri, 31 Jul 2020 14:20:46 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j8sm5379444ilc.43.2020.07.31.14.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 14:20:45 -0700 (PDT)
Received: (nullmailer pid 812525 invoked by uid 1000);
        Fri, 31 Jul 2020 21:20:44 -0000
Date:   Fri, 31 Jul 2020 15:20:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: regulator: Convert mp886x to
 json-schema
Message-ID: <20200731212044.GB806331@bogus>
References: <20200729130839.10a9bf88@xhacker>
 <20200729131052.39e40311@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729131052.39e40311@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:10:52PM +0800, Jisheng Zhang wrote:
> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> Convert the mp886x binding to DT schema format using json-schema.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../devicetree/bindings/regulator/mp886x.txt  | 31 ----------
>  .../bindings/regulator/mps,mp886x.yaml        | 58 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
> deleted file mode 100644
> index e747000cebba..000000000000
> --- a/Documentation/devicetree/bindings/regulator/mp886x.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -Monolithic Power Systems MP8867/MP8869 voltage regulator
> -
> -Required properties:
> -- compatible: Must be one of the following.
> -	"mps,mp8867"
> -	"mps,mp8869"
> -- reg: I2C slave address.
> -- enable-gpios: enable gpios.
> -- mps,fb-voltage-divider: An array of two integers containing the resistor
> -  values R1 and R2 of the feedback voltage divider in kilo ohms.
> -
> -Optional properties:
> -- mps,switch-frequency: The valid switch frequency in Hertz. Available values
> -  are: 500000, 750000, 1000000, 1250000, 1500000
> -
> -Any property defined as part of the core regulator binding, defined in
> -./regulator.txt, can also be used.
> -
> -Example:
> -
> -	vcpu: regulator@62 {
> -		compatible = "mps,mp8869";
> -		regulator-name = "vcpu";
> -		regulator-min-microvolt = <700000>;
> -		regulator-max-microvolt = <850000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -		enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
> -		mps,fb-voltage-divider = <80 240>;
> -		reg = <0x62>;
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
> new file mode 100644
> index 000000000000..991f2de7eda8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mps,mp886x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power Systems MP8867/MP8869 voltage regulator
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>

Needs a $ref to regulator.yaml.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - mps,mp8867
> +      - mps,mp8869
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: GPIO to enable/disable the regulator.
> +    maxItems: 1
> +
> +  mps,fb-voltage-divider:
> +    description: An array of two integers containing the resistor

Sounds like a constraint. Add 'maxItems: 2'.

> +      values R1 and R2 of the feedback voltage divider in kilo ohms.
> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +
> +  mps,switch-frequency:
> +    description: The valid switch frequency in Hertz.
> +    enum: [500000, 750000, 1000000, 1250000, 1500000]
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

With -hz added, the type will already be defined, so you can drop the 
$ref.

> +
> +required:
> +  - compatible
> +  - reg
> +  - enable-gpios
> +  - mps,fb-voltage-divider
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        regulator@62 {
> +          compatible = "mps,mp8869";
> +          regulator-name = "vcpu";
> +          regulator-min-microvolt = <800000>;
> +          regulator-max-microvolt = <1150000>;
> +          enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
> +          mps,fb-voltage-divider = <80 240>;
> +          reg = <0x62>;
> +        };
> +    };
> +
> +...
> -- 
> 2.28.0.rc1
> 
> 

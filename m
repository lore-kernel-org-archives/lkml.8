Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18963207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590697927;
	bh=CRfdkdQgvygC9pOomJr1/Or2hRd+NOTYVugzIcjgl3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a87iS19r6Q/kgJKrFK4oELTW9/HojYNp1dpqap9o5EflNhUGIN8q3IhOdjuel5TF6
	 p2ba+0qtw/26Qmn32sUlzhutA5esOqBNYvlYImzqczoSkJkGTp/rY2M+AUQBohwE1M
	 XOLnk7pEmYVbaN5Jinusmb5LVZGhATr0j5dGLXWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407290AbgE1UcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:32:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41040 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407092AbgE1UcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:32:01 -0400
Received: by mail-io1-f65.google.com with SMTP id o5so31590125iow.8;
        Thu, 28 May 2020 13:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vdh9srAwYXFtjIshEOcBhDQcTxqtKhCVIrHTMTzmp34=;
        b=BMOo0BWEFwkORKcII7uLpB4Q7zENRtCqiTG1bLVQL4BbVgC5k6fTEx/h71CyerR7LD
         rr0G17AkZytoR3Ol1pNt6iiMoZ+Ei49I2Fal8z+vytqLGT/J4TMO9UteB7MMeAOCRzSZ
         TT4h7aVnZZ0WjsEqSDec5xxWnewtvOI0enqs56r4GScfSYCaXpkNFfZLDhUE71JYXnQg
         7yF8BXHjkG89GtUHKwwH43LNcX0FVIAUr9En4PWEl66Scw5HYMomIkLhY0dBOUtNeUNZ
         KerV9tMfN7f9L/k121RfVwAtJEfANQknM71kBQrGchlWe1Fq11dKxko4lvIBh+PdM5p7
         cBKg==
X-Gm-Message-State: AOAM531zQf0WU3kzSdcTWcf7Hhv01BGpXxVbEyrV8coWawpgtU96JvWT
        BE4sL8u0uEFED0CFjvHG+A==
X-Google-Smtp-Source: ABdhPJyOF7FY5SDHFkmgPZ1knyxYbp3Lx9cRl8FfkGpGj+XrAagpaMvcB2TF7s49/rmU7FnrJiHVfQ==
X-Received: by 2002:a05:6638:262:: with SMTP id x2mr4397106jaq.10.1590697919893;
        Thu, 28 May 2020 13:31:59 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j17sm3592551ilq.79.2020.05.28.13.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:31:59 -0700 (PDT)
Received: (nullmailer pid 628195 invoked by uid 1000);
        Thu, 28 May 2020 20:31:58 -0000
Date:   Thu, 28 May 2020 14:31:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, paul.liu@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] dt-bindings: regulator: Convert anatop regulator to
 json-schema
Message-ID: <20200528203158.GA624130@bogus>
References: <1589788505-18024-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589788505-18024-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 03:55:05PM +0800, Anson Huang wrote:
> Convert the anatop regulator binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../bindings/regulator/anatop-regulator.txt        | 40 ---------
>  .../bindings/regulator/anatop-regulator.yaml       | 94 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt b/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
> deleted file mode 100644
> index a3106c7..0000000
> --- a/Documentation/devicetree/bindings/regulator/anatop-regulator.txt
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -Anatop Voltage regulators
> -
> -Required properties:
> -- compatible: Must be "fsl,anatop-regulator"
> -- regulator-name: A string used as a descriptive name for regulator outputs
> -- anatop-reg-offset: Anatop MFD register offset
> -- anatop-vol-bit-shift: Bit shift for the register
> -- anatop-vol-bit-width: Number of bits used in the register
> -- anatop-min-bit-val: Minimum value of this register
> -- anatop-min-voltage: Minimum voltage of this regulator
> -- anatop-max-voltage: Maximum voltage of this regulator
> -
> -Optional properties:
> -- anatop-delay-reg-offset: Anatop MFD step time register offset
> -- anatop-delay-bit-shift: Bit shift for the step time register
> -- anatop-delay-bit-width: Number of bits used in the step time register
> -- vin-supply: The supply for this regulator
> -- anatop-enable-bit: Regulator enable bit offset
> -
> -Any property defined as part of the core regulator
> -binding, defined in regulator.txt, can also be used.
> -
> -Example:
> -
> -	regulator-vddpu {
> -		compatible = "fsl,anatop-regulator";
> -		regulator-name = "vddpu";
> -		regulator-min-microvolt = <725000>;
> -		regulator-max-microvolt = <1300000>;
> -		regulator-always-on;
> -		anatop-reg-offset = <0x140>;
> -		anatop-vol-bit-shift = <9>;
> -		anatop-vol-bit-width = <5>;
> -		anatop-delay-reg-offset = <0x170>;
> -		anatop-delay-bit-shift = <24>;
> -		anatop-delay-bit-width = <2>;
> -		anatop-min-bit-val = <1>;
> -		anatop-min-voltage = <725000>;
> -		anatop-max-voltage = <1300000>;
> -	};
> diff --git a/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> new file mode 100644
> index 0000000..a8c9dd0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/anatop-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Anatop Voltage Regulators
> +
> +maintainers:
> +  - Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> +
> +allOf:
> +  - $ref: "regulator.yaml#"
> +
> +properties:
> +  compatible:
> +    const: fsl,anatop-regulator
> +
> +  regulator-name:
> +    $ref: '/schemas/types.yaml#/definitions/string'
> +    description: string used as a descriptive name for regulator outputs

Standard property, right? It already has a definition.

> +
> +  anatop-reg-offset:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the anatop MFD register offset.
> +
> +  anatop-vol-bit-shift:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the bit shift for the register.
> +
> +  anatop-vol-bit-width:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the number of bits used in the register.
> +
> +  anatop-min-bit-val:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the minimum value of this register.
> +
> +  anatop-min-voltage:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the minimum voltage of this regulator.
> +
> +  anatop-max-voltage:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the maximum voltage of this regulator.
> +
> +  anatop-delay-reg-offset:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the anatop MFD step time register offset.
> +
> +  anatop-delay-bit-shift:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the bit shift for the step time register.
> +
> +  anatop-delay-bit-width:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing the number of bits used in the step time register.
> +
> +  anatop-enable-bit:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: u32 value representing regulator enable bit offset.
> +
> +  vin-supply:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: input supply phandle.
> +
> +required:
> +  - compatible
> +  - regulator-name
> +  - anatop-reg-offset
> +  - anatop-vol-bit-shift
> +  - anatop-vol-bit-width
> +  - anatop-min-bit-val
> +  - anatop-min-voltage
> +  - anatop-max-voltage

Add here:

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    regulator-vddpu {
> +        compatible = "fsl,anatop-regulator";
> +        regulator-name = "vddpu";
> +        regulator-min-microvolt = <725000>;
> +        regulator-max-microvolt = <1300000>;
> +        regulator-always-on;
> +        anatop-reg-offset = <0x140>;
> +        anatop-vol-bit-shift = <9>;
> +        anatop-vol-bit-width = <5>;
> +        anatop-delay-reg-offset = <0x170>;
> +        anatop-delay-bit-shift = <24>;
> +        anatop-delay-bit-width = <2>;
> +        anatop-min-bit-val = <1>;
> +        anatop-min-voltage = <725000>;
> +        anatop-max-voltage = <1300000>;
> +    };
> -- 
> 2.7.4
> 

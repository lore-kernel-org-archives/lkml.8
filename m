Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E543C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 531F92071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382920;
	bh=++TNgfQgU7cekmPgpRd08RtzZOIy+za4T6AsgmBS2Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rdrx3Rn1/AVHb2nVN38zE1ILf4ovsD5Fh+J5JwBU1APjjGWrqyRbzxUwtMUzQjAS7
	 US2xPQWWwG6AZ6aDRJ/AS8dr0VmTbBiU71/46898Wt/edeYvS2UG+Wf1kjaWnsiCF9
	 PtHTDY8K+Fwc2FtMvlRFfKAM606EyRH0U/OaYl4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHYTPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:15:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36101 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYTPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:15:16 -0400
Received: by mail-il1-f196.google.com with SMTP id f75so11096255ilh.3;
        Tue, 25 Aug 2020 12:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4q53AIX/rG5iea8Jk/u9V7O7POp188r0tZKz2KOPp0U=;
        b=ofK9GcbPIEXmb7G+7k36p0BivHjb+rKOBCSeCGF1HGFzInJMK8lwXkzbCSLFWCdVba
         uKwsxImsG5rW/XWo2NtgJutpeCANKE+jGdvIfxIGNLY76+I00Tnkw7yWG/jgKUv5d8/c
         0cABrUL+A+whr5knpxGomi4N7iEG4dkEwNAkImLSgDDlFv88TAatuURXiOGvlW9rO1l4
         1bo2JTCDZ5JkfIhZlnAex4EhDHFkMc+u6YTzowxj6tx4/AMKFNGPDE5joCrBVPGBrSFn
         o5sIoQch7nIyY9F65BHCzq+z5s35iNaNum48Kv2tBtmaI+z+DYMG9gYYjpedb9d6t9+B
         Ingw==
X-Gm-Message-State: AOAM533b0jFG0t/XXmeXrmxZCJQ4mxmycwTW/RxXybc3FBJCveiAjCWN
        S2S5rEXpygTX7FbWyMdxsA==
X-Google-Smtp-Source: ABdhPJwZ5TIRlgyfYLIl9A+r5yivQ6mgzW3MNpPfG1yxuRceQJqQ4Ek7rRl+8WhxiFDVPUgwEqtVNA==
X-Received: by 2002:a92:c98e:: with SMTP id y14mr10888366iln.138.1598382914010;
        Tue, 25 Aug 2020 12:15:14 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id j10sm4608061ioj.25.2020.08.25.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:15:13 -0700 (PDT)
Received: (nullmailer pid 1153858 invoked by uid 1000);
        Tue, 25 Aug 2020 19:15:10 -0000
Date:   Tue, 25 Aug 2020 13:15:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Lee Jones <lee.jones@linaro.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: mfd: add LP87524-Q1
Message-ID: <20200825191510.GA1152696@bogus>
References: <20200817145018.3992-1-luca@lucaceresoli.net>
 <20200817145018.3992-3-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817145018.3992-3-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 04:50:17PM +0200, Luca Ceresoli wrote:
> Add the LP87524-Q1 to the bindings along with an example. This is a variant
> of the LP87565-Q1 and LP87561-Q1 chips which already have bindings.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4:
>  - reformat as a standalone file
> 
> Changes in v3:
>  - fix yaml errors
> 
> Changes in v2:
>  - RFC,v1 was based on the txt file, rewrite for yaml
>  - use uppercase consistently in model names (Lee Jones)
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - replace "dt:" suffix with "dt-bindings:" prefix in subject line
> ---
>  .../bindings/mfd/ti,lp87524-q1.yaml           | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
> new file mode 100644
> index 000000000000..1193fcb19739
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,lp87524-q1.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,lp87524-q1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LP87524-Q1 four 1-phase output buck converter
> +
> +maintainers:
> +  - Keerthy <j-keerthy@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,lp87524-q1
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
> +  buck0-in-supply:
> +    description:
> +      Phandle to parent supply node for the BUCK0 converter.
> +
> +  buck1-in-supply:
> +    description:
> +      Phandle to parent supply node for the BUCK1 converter.
> +
> +  buck2-in-supply:
> +    description:
> +      Phandle to parent supply node for the BUCK2 converter.
> +
> +  buck3-in-supply:
> +    description:
> +      Phandle to parent supply node for the BUCK3 converter.
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - buck0-in-supply
> +  - buck1-in-supply
> +  - buck2-in-supply
> +  - buck3-in-supply
> +
> +examples:
> +  - |
> +    i2c@0 {
> +        reg = <0x0 0x100>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@60 {
> +            compatible = "ti,lp87524-q1";
> +            reg = <0x60>;
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +
> +            buck0-in-supply = <&vdd_5v0>;
> +            buck1-in-supply = <&vdd_5v0>;
> +            buck2-in-supply = <&vdd_5v0>;
> +            buck3-in-supply = <&vdd_5v0>;
> +
> +            regulators {
> +                buck0_reg: buck0 {

Here too, you need to describe all this.

> +                    regulator-name = "buck0";
> +                    regulator-min-microvolt = <3300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-always-on;
> +                };
> +
> +                buck1_reg: buck1 {
> +                    regulator-name = "buck1";
> +                    regulator-min-microvolt = <1350000>;
> +                    regulator-max-microvolt = <1350000>;
> +                    regulator-always-on;
> +                };
> +
> +                buck2_reg: buck2 {
> +                    regulator-name = "buck2";
> +                    regulator-min-microvolt = <950000>;
> +                    regulator-max-microvolt = <950000>;
> +                    regulator-always-on;
> +                };
> +
> +                buck3_reg: buck3 {
> +                    regulator-name = "buck3";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <1800000>;
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

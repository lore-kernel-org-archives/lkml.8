Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5CFC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B7F20674
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580744747;
	bh=F9PD/5RNRCAiZI4eLhMYS2sNrgM0OuBB8vFDHGnvn6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C/2G+204n49DaAdEhh4o79vphiagHpT/NmzFrRpoNvW5+rZLuJnwQGfFzu52kGYXy
	 amG2UTI7psA1gh3G34fZff3gc7igLeUexT2zcpDJqws06HCs0wlJeSHiclAgCQz/Ng
	 yuRnkhWXknJW+9N0NNBI2ZDa0rWh7hdR2in23Pz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgBCPpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:45:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39034 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBCPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:45:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id c84so17742716wme.4;
        Mon, 03 Feb 2020 07:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i4K3Yw7s0/p2VRy7WZBsheWIHTlpjbUAlC7ufzYvY3E=;
        b=IFt/XXLiqicBQoa2VVsY2BEXae2S3ppvHQGnwWW4zbDJUSmd6V7DJgTBJEcnc5Mx6D
         k2AwTvXtNTSZda/ydjjw5pQuOutuFKPygg9vnn9V/UzlUjh2le7HmATnoMcHAxg/ytcM
         8TOOapqWR1EyTXN9qHW2R0NANSL2WBt00LsGcEwP0AkA4O2fW4+zdk8eW0wGbwfAWbzd
         jl0/fGqo1crLmzCpR5DfGT8/gMSgIKqfpEFKYwYzqS8xZQGIp331mYyMFrB4P8loTbwt
         l/MqO8TC0D9t+MVeH2MQwt103geK0hinF+HnAiMmIBzOPVJCUQZJCv8Y3177NhOEdL9o
         hcbA==
X-Gm-Message-State: APjAAAVDDtVNyqCVZd3+xm5SK8CZfX/57XYOAvKdQLJOOKz2YcitW3BL
        jtr/wdCfYTkFPdBQe5a5ng==
X-Google-Smtp-Source: APXvYqzUC53KksT1fJG8MNOZOKWNr3IVl/W0eL/KQgTAaS4Tm5DvJl1BsknoQ94mvSkDJuxs3SUf1Q==
X-Received: by 2002:a1c:5441:: with SMTP id p1mr31595887wmi.161.1580744744243;
        Mon, 03 Feb 2020 07:45:44 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id f189sm25558921wmf.16.2020.02.03.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 07:45:43 -0800 (PST)
Received: (nullmailer pid 17059 invoked by uid 1000);
        Mon, 03 Feb 2020 15:45:42 -0000
Date:   Mon, 3 Feb 2020 15:45:42 +0000
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        mark.rutland@arm.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, yifeng.zhao@rock-chips.com
Subject: Re: [RFC PATCH v2 01/10] dt-bindings: mtd: add rockchip nand
 controller bindings
Message-ID: <20200203154542.GA27866@bogus>
References: <20200124163001.28910-1-jbx6244@gmail.com>
 <20200124163001.28910-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124163001.28910-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:29:52PM +0100, Johan Jonker wrote:
> Add the Rockchip NAND controller bindings.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../bindings/mtd/rockchip,nand-controller.yaml     | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> new file mode 100644
> index 000000000..5c725f972
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/rockchip,nand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip NAND Controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "nand-controller.yaml#"
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,px30-nand-controller
> +      - rockchip,rk3066-nand-controller
> +      - rockchip,rk3228-nand-controller
> +      - rockchip,rk3288-nand-controller
> +      - rockchip,rk3308-nand-controller
> +      - rockchip,rk3368-nand-controller
> +      - rockchip,rv1108-nand-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: hclk_nandc
> +      - const: clk_nandc
> +
> +patternProperties:
> +  "^nand@[a-f0-9]+$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3
> +
> +      nand-is-boot-medium: true
> +
> +      rockchip,idb-res-blk-num:

What is idb? Rather than define, maybe just 'rockchip,boot-blks'?

> +        minimum: 2

is there a max?

> +        default: 16
> +        allOf:
> +        - $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          For legacy devices where the bootrom can only handle 24 bit BCH/ECC.
> +          If specified it indicates the number of erase blocks in use by
> +          the bootloader that need a lower BCH/ECC setting.
> +          Only used in combination with 'nand-is-boot-medium'.
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3188-cru-common.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    nandc: nand-controller@10500000 {
> +      compatible = "rockchip,rk3066-nand-controller";
> +      reg = <0x10500000 0x4000>;
> +      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru HCLK_NANDC0>;
> +      clock-names = "hclk_nandc";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      nand@0 {
> +        reg = <0>;
> +        nand-is-boot-medium;
> +      };
> +    };
> +
> +...
> -- 
> 2.11.0
> 

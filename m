Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B851CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A2220720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589221647;
	bh=lDHar79Z4HHKrJBGwuXzy0YNiwMg8sKm3v01RezBD+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vXS0KfkPposB9ntekhsFcgiLLwFvoIoCmgVPzmUvBzevg6Y4/Tnsb4gwoqyJQtxEw
	 TGhwOUz1hzD1KfLGv+G8FaLA3OYb2SUMx0O7dreE3bforpf2MtENYcskWT26Dg9EQD
	 I1AHsIEyBMrUyNfL0rag5HLHqdIyH4IWIiM2OEaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgEKS10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:27:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44601 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729772AbgEKS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:27:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id j4so8344924otr.11;
        Mon, 11 May 2020 11:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0hPBkYeKIiodMWs/enk89cPCGVXGgMcnp/mkphaKHR0=;
        b=O6XgTj/V8prOCbfC1OnEO1b0FUTmpFXhSNlc8/KS/DG3awquhhvln+DUAAzrSijyIx
         Vx/RjdRGPBaIvgOpuzgPwBcw0VH7M0WilzlfLtclP/Vmc2RwqgLD/FTw3Fr6Oh8+3uPq
         PKS6XYjNYUCMmlO0mON27H1v1Dbrl8cqfYFrnFvoQ4aa3ZdKLdrlWBB/DDmGJ0FIc8Ir
         xvwQCMhB9zjt+GI0pyV/cIhIB1hzz02Q+GqzxbaxfsaYf0T/afYKx+M0LKlwdpXa6Zw1
         tPAWZQWWeb+x7DcFKjFLc5FstuN4rS6nofXUpd71HkONqXruv8lIhednHmLB+Dnk3qVU
         NzPg==
X-Gm-Message-State: AGi0Puatv+PTp7RUA8IMxHZXNwT1vtFl8tjz+4JuBkUZSgdIQRZH4EnJ
        h+N0vu9zMX2ifqsF5m7CGA==
X-Google-Smtp-Source: APiQypKkLLpfS5uFZ7qDGesr8w1obstysUYqHlic1hxCJgCQLeL+ae1OZe/dsWHP/TD49Qm1gGUNpg==
X-Received: by 2002:a9d:7858:: with SMTP id c24mr13282165otm.163.1589221644004;
        Mon, 11 May 2020 11:27:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e91sm2834465otb.40.2020.05.11.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:27:23 -0700 (PDT)
Received: (nullmailer pid 6693 invoked by uid 1000);
        Mon, 11 May 2020 15:37:12 -0000
Date:   Mon, 11 May 2020 10:37:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, arnd@arndb.de,
        brendanhiggins@google.com, tglx@linutronix.de,
        boris.brezillon@collabora.com, anders.roxell@linaro.org,
        masonccyang@mxic.com.tw, linux-mips@vger.kernel.org,
        hauke.mehrtens@intel.com, andriy.shevchenko@intel.com,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: Add YAML for Nand Flash
 Controller support
Message-ID: <20200511153712.GA25497@bogus>
References: <20200507001537.4034-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200507001537.4034-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507001537.4034-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 08:15:36AM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add YAML file for dt-bindings to support NAND Flash Controller
> on Intel's Lightning Mountain SoC.

The $subject should some how reflect this is for this SoC.

> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 85 ++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> new file mode 100644
> index 000000000000..69b592ae62f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/intel,lgm-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel LGM SoC NAND Controller Device Tree Bindings
> +
> +allOf:
> +  - $ref: "nand-controller.yaml"
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-nand-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    enum:
> +      - rx
> +      - tx
> +
> +  pinctrl-names: true
> +
> +patternProperties:
> +  "^pinctrl-[0-9]+$": true

Don't need the pinctrl properties. The tooling adds them.

> +
> +  "^nand@[a-f0-9]+$":
> +    type: object
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +
> +      nand-ecc-mode: true
> +
> +      nand-ecc-algo:
> +        const: hw
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - dmas
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/intel,lgm-clk.h>

Is this applied somewhere? It's missing in my check and will break the 
build.

> +    nand-controller@e0f00000 {
> +      compatible = "intel,nand-controller";
> +      reg = <0xe0f00000 0x100>,
> +            <0xe1000000 0x300>,
> +            <0xe1400000 0x8000>,
> +            <0xe1c00000 0x1000>;
> +      reg-names = "ebunand", "hsnand", "nand_cs0", "nand_cs1";
> +      clocks = <&cgu0 LGM_GCLK_EBU>;
> +      dma-names = "tx", "rx";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      #clock-cells = <1>;
> +
> +      nand@0 {
> +        reg = <0>;
> +        nand-on-flash-bbt;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +      };
> +    };
> +
> +...
> -- 
> 2.11.0
> 

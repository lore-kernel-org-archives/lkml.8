Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D747C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334FD20656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587586412;
	bh=K+GwvNqtPIj2LewkDBhiV1A/aYbBwgrGWX6IRuIs40w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BxESQJ/S/1RsrPIvecrF4cG+Gne03CfFA5aLXjUYmmLHDi6WuuUG2Cuhf8M1voo7X
	 J6VeKayB/HXOMFRJRZaibD3Ee4P9B1Y+8HNNL2ryu6YZBlcYVzRQpjpbbTwbxfSzmq
	 1PYLxo7/Ovs+q3/emPSyf37GGDGWX0XIwVMCDQTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgDVUNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:13:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43457 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgDVUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:13:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id g14so3342847otg.10;
        Wed, 22 Apr 2020 13:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FU28JBKGEW/8GQtu1EPA/t3igT0iC4W0GHS/U/6pah4=;
        b=V7dCPC0ZpML8QoKAXcbyONXtvrMqpCN04mbrUtoPRrodX9gVxpT9KvhBHXGFH+3EH0
         cGFrrvMOb0JRp8uKr78fX3M17qw/bI8C4i9qvc5vvXd/tUnvVIZ2m7n8FeV5IO2dIvcl
         srgSBOQQPD+FGlYTAaVLX3PTspygSYz+PRRBHLkIC+s5vYM2lyghUTN7euBMs2aV9Hem
         hg7aD36o2PpmhxjbmbTkpa8zVXZX+ni4yBAQIzTM+s9pf1f0cL/Z3oo13OjgoUyaMNCr
         7Jk9ZEEXDBMhrvID86ZeIDcVZHRiPC3/06iM2M2I6HE7jADrm6zObIY0xJKamoVUdHNv
         Pfjg==
X-Gm-Message-State: AGi0PubZ7hK3Aw6jekBoOzXxRQz0lZjpnb/FTJqYW7GNTd7pVk82ZOlF
        PDnM72NbSqzM3FnGVfUejyZ3S68=
X-Google-Smtp-Source: APiQypLq1juXk3wkyAmmhugjQWskZwTMMSVHNWayyrQVPc7tVA60BLU67e9v/cwDx0dAkBMdlJyA5A==
X-Received: by 2002:a9d:6b11:: with SMTP id g17mr712345otp.264.1587586407497;
        Wed, 22 Apr 2020 13:13:27 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t26sm33325otl.71.2020.04.22.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:13:26 -0700 (PDT)
Received: (nullmailer pid 20547 invoked by uid 1000);
        Wed, 22 Apr 2020 20:13:25 -0000
Date:   Wed, 22 Apr 2020 15:13:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH v10 1/7] dt-bindings: soc: Add Aspeed XDMA Engine
Message-ID: <20200422201325.GA12023@bogus>
References: <20200420202611.17776-1-eajames@linux.ibm.com>
 <20200420202611.17776-2-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420202611.17776-2-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:26:05PM -0500, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../devicetree/bindings/soc/aspeed/xdma.yaml  | 108 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 114 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml b/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
> new file mode 100644
> index 000000000000..428a575da1be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later)

Dual license new bindings please:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/aspeed/xdma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed AST25XX and AST26XX XDMA Engine
> +
> +maintainers:
> + - Eddie James <eajames@linux.ibm.com>
> +
> +description: |
> +  This binding describes the XDMA Engine embedded in the AST2500 and AST2600
> +  SOCs. The XDMA engine can perform automatic DMA operations over PCI between
> +  the SOC (acting as a BMC) and a host processor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2500-xdma
> +      - aspeed,ast2600-xdma
> +
> +  reg:
> +    items:
> +      - description: engine register space

That's all 'reg' properties. You don't need a description for a 
single entry. Just:

reg:
  maxItems: 1

> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    maxItems: 2
> +    items:
> +      - const: device
> +      - const: root-complex
> +
> +  interrupts-extended:

Just use 'interrupts'. The tools fix things up so both work.

> +    maxItems: 2
> +    items:
> +      - description: global interrupt for the XDMA engine
> +      - description: PCI-E reset or PERST interrupt
> +
> +  aspeed,scu:
> +    description: a reference to the System Control Unit node of the Aspeed SOC.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  aspeed,pcie-device:
> +    description: describes which PCI-E device the XDMA engine should use
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/string
> +      - oneOf:
> +        - items:
> +          - const: bmc
> +        - items:
> +          - const: vga

The oneOf (inclusive) can be just:

enum: [ bmc, vga ]

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - interrupts-extended
> +  - aspeed,scu
> +  - memory-region
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: aspeed,ast2600-xdma
> +then:
> +  required:
> +    - reset-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/aspeed-scu-ic.h>
> +    syscon: syscon@1e6e2000 {
> +        reg = <0x1e6e2000 0x1000>;
> +        ranges = <0 0x1e6e2000 0x1000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +        scu_ic0: interrupt-controller@560 {
> +            reg = <0x560 0x4>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +        };
> +    };
> +    xdma@1e6e7000 {
> +        compatible = "aspeed,ast2600-xdma";
> +        reg = <0x1e6e7000 0x100>;
> +        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +        resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
> +        reset-names = "device", "root-complex";
> +        interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
> +        aspeed,scu = <&syscon>;
> +        aspeed,pcie-device = "bmc";
> +        memory-region = <&vga_memory>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecd7def6ff4b..b1963e01a75e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2774,6 +2774,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>  F:	drivers/media/platform/aspeed-video.c
>  
> +ASPEED XDMA ENGINE DRIVER
> +M:	Eddie James <eajames@linux.ibm.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user@lists.sourceforge.net
> -- 
> 2.24.0
> 

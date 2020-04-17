Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC20FC38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92F620857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587140535;
	bh=CsFmhiTV85Efcl3S3vGKBX32p+XyVn5g1c1DCUQfYkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eI3i97GRYvwuyVXcMAxF9fxYCq3qws8qLrD9kgCIXN4oJiCA5r8J9qL/8qiwLxT+o
	 ZV6WjvutZkcPu/CtU4p1iRHgqnmD/mQl9loXoC+TiFjm1UcPgkayk8xGgK57Rpe97s
	 8qtA7tqa+y87NcD3niNTMRabSod6Xod7rcqcvXis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgDQQWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:22:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38553 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbgDQQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:22:13 -0400
Received: by mail-oi1-f196.google.com with SMTP id r66so2545559oie.5;
        Fri, 17 Apr 2020 09:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HeAHiyvWEUaF+aCLu1NaqGKApOTT6/8+xu5a7bTpKz8=;
        b=PA+0y0WiIDsjD3+EGV0qEkvRcX/46oY4XhQK4p3wdaRszKNM0rSjZmwqu/39x06GCN
         VWce6+0qf+rC4iGTLasV3bvtwtDM/Lm5jhkhf+ltMrmtJqf0Ho5a1O2u6nv23SwjJw9i
         /hOuD2iNDlBIixn9n1jgwcWTv+6IB5vgreX2s4r6jA8gLIJ3HXHsxz0qtqd5a+0x5jll
         PFcPx6/p/MIxYiAM6NxdczTm/1KMZF6eTmEFzazipAO7nCEHU2g0dpuh1VRKGPz71SQx
         4N2H6/PE/yvi4RgVum3toweEXDiV8/mC5H9gvEyTkG8r7zXBQ5blR6kV4um2BS64GA2U
         v+dg==
X-Gm-Message-State: AGi0PualtxPc+IOQj99uYIrvPvF6p3SUGhN7nioTYDQP/T3EPX2QdQWv
        59DZBV5+wGfBhEl3qfBisS8m2xY=
X-Google-Smtp-Source: APiQypIr+IqasDXVzw4cm+LyZdJBeCjzNk9h5xojT4id6JrVlp3WKVmJeu6fpY1NvWdWw1q23nYkxA==
X-Received: by 2002:a54:4085:: with SMTP id i5mr2810167oii.107.1587140532363;
        Fri, 17 Apr 2020 09:22:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v9sm4651042oto.72.2020.04.17.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:22:11 -0700 (PDT)
Received: (nullmailer pid 7462 invoked by uid 1000);
        Fri, 17 Apr 2020 16:22:11 -0000
Date:   Fri, 17 Apr 2020 11:22:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH v9 1/5] dt-bindings: soc: Add Aspeed XDMA Engine
Message-ID: <20200417162210.GA402@bogus>
References: <1587067419-5107-1-git-send-email-eajames@linux.ibm.com>
 <1587067419-5107-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587067419-5107-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:03:35PM -0500, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> Changes since v8:
>  - dropped Rob's tag since this has changed significantly since he last looked
>    it over.

If this is not merged soon, you're going to need to convert to schema.

>  .../devicetree/bindings/soc/aspeed/xdma.txt        | 45 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> new file mode 100644
> index 0000000..35d0507
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> @@ -0,0 +1,45 @@
> +Aspeed AST25XX and AST26XX XDMA Engine
> +
> +The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform automatic
> +DMA operations over PCI between the SOC (acting as a BMC) and a host processor.
> +
> +Required properties:
> + - compatible		: must be "aspeed,ast2500-xdma" or
> +			  "aspeed,ast2600-xdma"
> + - reg			: contains the address and size of the memory region
> +			  associated with the XDMA engine registers
> + - clocks		: clock specifier for the clock associated with the
> +			  XDMA engine
> + - resets		: reset specifier for the syscon reset associated with
> +			  the XDMA engine, and, for the AST2600, a second reset
> +			  associated with the PCI-E root complex
> + - reset-names		: required only for the AST2600; must be
> +			  "device", "root-complex"
> + - interrupts-extended	: two interrupt cells; the first specifies the global
> +			  interrupt for the XDMA engine and the second
> +			  specifies the PCI-E reset or PERST interrupt.
> + - aspeed,scu		: a phandle to the syscon node for the system control
> +			  unit of the SOC
> + - memory-region	: a phandle to the reserved memory region to be used by
> +			  the XDMA engine for DMA operations
> +
> +Optional properties:
> + - pcie-device		: should be either "bmc" or "vga", corresponding to
> +			  which device should be used by the XDMA engine for
> +			  DMA operations. If this property is not set, the XDMA
> +			  engine will use the BMC PCI-E device.

aspeed,pcie-device

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +Example:
> +
> +    xdma@1e6e7000 {
> +        compatible = "aspeed,ast2600-xdma";
> +        reg = <0x1e6e7000 0x100>;
> +        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +        resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
> +        reset-names = "device", "root-complex";
> +        interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
> +        aspeed,scu = <&syscon>;
> +        pcie-device = "bmc";
> +        memory-region = <&vga_memory>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5e10560..66f82a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2771,6 +2771,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/aspeed-video.txt
>  F:	drivers/media/platform/aspeed-video.c
>  
> +ASPEED XDMA ENGINE DRIVER
> +M:	Eddie James <eajames@linux.ibm.com>
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user@lists.sourceforge.net
> -- 
> 1.8.3.1
> 

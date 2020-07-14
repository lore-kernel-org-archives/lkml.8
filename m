Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C2DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C9C22518
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594747336;
	bh=m5SGCAj/F1LwjB4vaj3XG/lVPVHA3gnOWk7MlbYq2cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cKIXhwUHyColIelA4kN0RlK9mtPLBWTSzqsd959BWYnpxnncgoIY4Ywkbym0sH++5
	 aCA1Qk+lvDgPCVjZ14e5cJB1ozp05/D9quuU1pk/BVS6CuBneUpUarGyF+7qbvZxSZ
	 wvuEiSjrVm1EoG0E7kyKvCxeePbv8I1ACL5hYtJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgGNRWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:22:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35005 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:22:14 -0400
Received: by mail-io1-f67.google.com with SMTP id v8so18132033iox.2;
        Tue, 14 Jul 2020 10:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zIt5OZfKObqlXbh9Y2BY80CKEiDpSojHfWV57lWnUjc=;
        b=K7kXJkfIeVfGZHaCUqfdvyJ75SWPAx3mf95gHI7MWK62yDio07WDbWLpSOzBN96c7W
         Nn+EU2k1IAvI3BKaz7zrxL4fZXri2m2BPcpavhg4SXul1V3BRdL7EJivsbiP1lKTfXtu
         71lyhfQbq27+Z+D8M1j50G6c1iHeA0/NEEqAftaUfmj0rIm2p4neBU+RQ1Z16PpwSJb+
         PWUP8Uru6Bg+vRftTf7qB/tWr/VwaWTQT6ac7jmTQAiNFkbElWu+/Ir/XcrSoZL8b5xf
         Nn/9J4NPmRIhspl2Qilz2H2XJIR8lM7JchPL2qZroN7pBCQ6m3X1lBO2TFBWZR0nVnEh
         dKmw==
X-Gm-Message-State: AOAM532bD4Et09o3sz/Jp70AUfTRJSQBKNGPbUYVgrzdQr9FO+RMwZ+Q
        +G7DtPb+YMfKObu7SCUChw==
X-Google-Smtp-Source: ABdhPJzL0Eh1erToxXdqHVSulTFB+j8bwTNM76ArDHjnTAymGlqxWHZNJnvdzHTRcwcx65y6vf9Okg==
X-Received: by 2002:a05:6602:2d03:: with SMTP id c3mr5933280iow.188.1594747333291;
        Tue, 14 Jul 2020 10:22:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t12sm10207185ilo.80.2020.07.14.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:22:12 -0700 (PDT)
Received: (nullmailer pid 2562210 invoked by uid 1000);
        Tue, 14 Jul 2020 17:22:11 -0000
Date:   Tue, 14 Jul 2020 11:22:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt bindings: remoteproc: Add bindings for MT8183 APU
Message-ID: <20200714172211.GB2551057@bogus>
References: <20200713132927.24925-1-abailon@baylibre.com>
 <20200713132927.24925-2-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132927.24925-2-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:29:22PM +0200, Alexandre Bailon wrote:
> This adds dt bindings for the APU present in the MT8183.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../bindings/remoteproc/mtk,apu.yaml          | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> new file mode 100644
> index 000000000000..1d5fcc135617
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/mtk,apu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MT8183 Vision Processor Unit (VPU) devices

APU or VPU?

> +
> +description:
> +  This document defines the binding for the APU, a co-processor that could
> +  offload the CPU for machine learning and neural network.
> +
> +maintainers:
> +  - Alexandre Bailon <abailon@bayLibre.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8183-apu
> +
> +  reg:
> +    description:
> +      Address ranges of the APU MMIO.

Don't put generic descriptions for standard properties.

> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The interrupt number used to receive the interrupts from the DSP.
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      "Clocks for co-processor (See: ../clock/clock-bindings.txt)
> +      Three clocks are expected for AXI, IPU and JTAG.
> +      The JTAG clock seems to be required to run the DSP,
> +      even when JTAG is not in use."
> +    maxItems: 3

blank line between properties please.

> +  clock-names:
> +    description:
> +      The name of clocks, must be ipu, axi and jtag

That's what the schema says...

> +    items:
> +      - const: ipu
> +      - const: axi
> +      - const: jtag
> +
> +  iommu:
> +    description: "IOMMU (See: ../iommu/iommu.txt)"
> +    maxItems: 3
> +
> +  memory-region:
> +    description: "Reserved memory (See: ../reserved-memory/reserved-memory.txt)"
> +    maxItems: 1
> +
> +  power-domains:
> +    description: "Power domain (see: ../power/power_domain.txt)"
> +    maxItems: 1
> +
> +  pinctrl:
> +    description: pinctrl handles, required to configure pins for JTAG.
> +    maxItems: 2
> +
> +  pinctrl-names:
> +    description:
> +      pinctrl name, must be "default", "jtag".
> +      "default" must configure the pins when JTAG is disabled.
> +      "jtag" must configure the pins for JTAG operations.
> +    items:
> +      - const: default
> +      - const: jtag
> +    maxItems: 2

Don't need maxItems.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - iommu
> +  - memory-region
> +  - power-domains

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8183-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8183-larb-port.h>
> +    #include <dt-bindings/power/mt8183-power.h>
> +
> +    reserved-memory {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges;
> +
> +      vpu_ram: vpu_ram@0x60000000 {
> +        compatible = "shared-dma-pool";
> +        reg = <0 0x60000000 0 0x040000000>;
> +        no-map;
> +        linux,cma-default;
> +      };
> +    };
> +
> +    vpu0: vpu@0x19100000 {

vpu?

Drop the '0x'

> +      compatible = "mediatek,mt8183-apu";
> +      reg = <0 0x19180000 0 0x14000>;

The default cell size for examples is 1.

> +      reg-names = "mmio";
> +      interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_LOW>;
> +
> +      iommus = <&iommu M4U_PORT_IMG_IPUO>,
> +         <&iommu M4U_PORT_IMG_IPU3O>,
> +         <&iommu M4U_PORT_IMG_IPUI>;
> +
> +      clocks = <&ipu_core0 CLK_IPU_CORE0_AXI>,
> +         <&ipu_core0 CLK_IPU_CORE0_IPU>,
> +         <&ipu_core0 CLK_IPU_CORE0_JTAG>;
> +
> +      clock-names = "axi", "ipu", "jtag";

Doesn't match the schema which 'make dt_binding_check' will tell you.

> +
> +      power-domains = <&scpsys MT8183_POWER_DOMAIN_VPU_CORE0>;
> +      memory-region = <&vpu_ram>;
> +    };
> +...
> -- 
> 2.26.2
> 

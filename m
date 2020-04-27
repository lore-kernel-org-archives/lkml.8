Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45D4C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA755206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDNtRS5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgD0TtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0TtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:49:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23865C03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:49:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a31so88103pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jEerkCT9TzKSUHSlKdk8mBv+MQGjDxFrB8vo7AAG6JU=;
        b=aDNtRS5fEYc2xcdaMDa/QNBMD/BsPucouNMYbVlDpQONpV26D2tuBVwj6JPoc5/Pry
         KdGXM5xJoeKU5AMeIf3ENbpBb8KlonA9Xry72AnuALLKcto9mCZt2tnNRy4aGMsPWfNF
         jsOjGNOUiCnrmVh84ellq+Ju3o4+oa2iq0N4+NjBbrMsXHrJOZAJpYV6MLNtGPDq4ltU
         rZ0asxAM31wIIcsGC+b9xDyy47396WcXJRwX++XBx09cQgLMGOEzQNMSVSkz5Z0+v/vH
         6nn8y0dpauXUafz/9wvckLtOiO2Jas7HuErUVTf0Tao6GHYUB8h2BTtrojmEr9etkanl
         TLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEerkCT9TzKSUHSlKdk8mBv+MQGjDxFrB8vo7AAG6JU=;
        b=bPca6EFtvEI2StZJZ4Gu0IpVl1L/vD/xjY485B+POWAwdxgveoXq5+y/RHIYXjTRz2
         cP7uT1aniSBhPVxqsoINEqzMRMyIhqLrvKX4NYNTTKyyxt8uDF70Rmeccvi2vp6UpPQT
         p4O1KrsrRYN2dQr8i24Wv72t1UDkcrSlHAw/jUJx42hlFdnF2cCHZ7sQnLHvy3qegIzj
         ULE+ph0WmGNOS6aFt5Bjjw3ylKTKOikRqTeBCCrTHYa/I7ZqokojtJe34uEX50x/vJ3c
         oYYIG5rPlEi9oLsDTFUJ2mg5xUmZsAxpnIapss3sK82pxqhKkbi5Duh1eMNUPEUVl4jP
         NGKg==
X-Gm-Message-State: AGi0PuZen3wvAfMsT8QSirc0SxXI4XTkc2urE37znGHsmWbd6Qts8MiV
        IRDc6m4cjRW8ycxgItaRkoezxA==
X-Google-Smtp-Source: APiQypKoHMXhC7ldZltP3zeeHiihA+8rUs3muVExUWi1iQdL4LAmPnhL/gnjMXhSDCVSdoydpXLszw==
X-Received: by 2002:a17:90a:d703:: with SMTP id y3mr375417pju.75.1588016958305;
        Mon, 27 Apr 2020 12:49:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 184sm13502817pfy.144.2020.04.27.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 12:49:17 -0700 (PDT)
Date:   Mon, 27 Apr 2020 13:49:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: Add bindings for C66x DSPs
 on TI K3 SoCs
Message-ID: <20200427194915.GA10552@xps15>
References: <20200325201839.15896-1-s-anna@ti.com>
 <20200325201839.15896-2-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325201839.15896-2-s-anna@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

I have started to review this set - comments will come over the next few days.

On Wed, Mar 25, 2020 at 03:18:37PM -0500, Suman Anna wrote:
> Some Texas Instruments K3 family of SoCs have one of more Digital Signal
> Processor (DSP) subsystems that are comprised of either a TMS320C66x
> CorePac and/or a next-generation TMS320C71x CorePac processor subsystem.
> Add the device tree bindings document for the C66x DSP devices on these
> SoCs. The added example illustrates the DT nodes for the first C66x DSP
> device present on the K3 J721E family of SoCs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-dsp-rproc.yaml  | 180 ++++++++++++++++++
>  1 file changed, 180 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> new file mode 100644
> index 000000000000..416e3abe7937
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI K3 DSP devices
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description: |
> +  The TI K3 family of SoCs usually have one or more TI DSP Core sub-systems
> +  that are used to offload some of the processor-intensive tasks or algorithms,
> +  for achieving various system level goals.
> +
> +  These processor sub-systems usually contain additional sub-modules like
> +  L1 and/or L2 caches/SRAMs, an Interrupt Controller, an external memory
> +  controller, a dedicated local power/sleep controller etc. The DSP processor
> +  cores in the K3 SoCs are usually either a TMS320C66x CorePac processor or a
> +  TMS320C71x CorePac processor.
> +
> +  Each DSP Core sub-system is represented as a single DT node. Each node has a
> +  number of required or optional properties that enable the OS running on the
> +  host processor (Arm CorePac) to perform the device management of the remote
> +  processor and to communicate with the remote processor.
> +
> +properties:
> +  compatible:
> +    const: ti,j721e-c66-dsp
> +    description:
> +      Use "ti,j721e-c66-dsp" for C66x DSPs on K3 J721E SoCs
> +
> +  reg:
> +    description: |
> +      Should contain an entry for each value in 'reg-names'.
> +      Each entry should have the memory region's start address
> +      and the size of the region, the representation matching
> +      the parent node's '#address-cells' and '#size-cells' values.
> +    minItems: 3
> +    maxItems: 3
> +
> +  reg-names:
> +    description: |
> +      Should contain strings with the names of the specific internal
> +      internal memory regions, and should be defined in this order

The word "internal" is found twice in a row.

> +    maxItems: 3
> +    items:
> +      - const: l2sram
> +      - const: l1pram
> +      - const: l1dram
> +
> +  ti,sci:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Should be a phandle to the TI-SCI System Controller node
> +
> +  ti,sci-dev-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Should contain the TI-SCI device id corresponding to the DSP core.
> +      Please refer to the corresponding System Controller documentation
> +      for valid values for the DSP cores.
> +
> +  ti,sci-proc-ids:
> +    description: Should contain a single tuple of <proc_id host_id>.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +      - maxItems: 1
> +        items:
> +          items:
> +            - description: TI-SCI processor id for the DSP core device
> +            - description: TI-SCI host id to which processor control
> +                           ownership should be transferred to
> +
> +  resets:
> +    description: |
> +      Should contain the phandle to the reset controller node
> +      managing the resets for this device, and a reset
> +      specifier. Please refer to the following reset bindings
> +      for the reset argument specifier,
> +      Documentation/devicetree/bindings/reset/ti,sci-reset.txt
> +
> +  firmware-name:
> +    description: |
> +      Should contain the name of the default firmware image
> +      file located on the firmware search path
> +
> +  mboxes:
> +    description: |
> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +      communication with the remote processor. This property should match
> +      with the sub-mailbox node used in the firmware image. The specifier
> +      format is as per the bindings,
> +      Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> +
> +  memory-region:
> +    minItems: 2
> +    description: |
> +      phandle to the reserved memory nodes to be associated with the remoteproc
> +      device. There should be atleast two reserved memory nodes defined - the
> +      first one would be used for dynamic DMA allocations like vrings and vring
> +      buffers, and the remaining ones used for the firmware image sections. The
> +      reserved memory nodes should be carveout nodes, and should be defined as
> +      per the bindings in
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +
> +# Optional properties:
> +# --------------------
> +
> +  sram:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 1
> +    description: |
> +      pHandles to one or more reserved on-chip SRAM regions. The regions

s/pHandle/phandle

Thanks,
Mathieu

> +      should be defined as child nodes of the respective SRAM node, and
> +      should be defined as per the generic bindings in,
> +      Documentation/devicetree/bindings/sram/sram.yaml
> +
> +required:
> + - compatible
> + - reg
> + - reg-names
> + - ti,sci
> + - ti,sci-dev-id
> + - ti,sci-proc-ids
> + - resets
> + - firmware-name
> + - mboxes
> + - memory-region
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    //Example: J721E SoC
> +    /* DSP Carveout reserved memory nodes */
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges;
> +
> +        c66_0_dma_memory_region: c66-dma-memory@a6000000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0xa6000000 0x00 0x100000>;
> +            no-map;
> +        };
> +
> +        c66_0_memory_region: c66-memory@a6100000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x00 0xa6100000 0x00 0xf00000>;
> +            no-map;
> +        };
> +    };
> +
> +    cbass_main: interconnect@100000 {
> +        compatible = "simple-bus";
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges = <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
> +                 <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>; /* C66_1 */
> +
> +        /* J721E C66_0 DSP node */
> +        c66_0: dsp@4d80800000 {
> +            compatible = "ti,j721e-c66-dsp";
> +            reg = <0x4d 0x80800000 0x00 0x00048000>,
> +                  <0x4d 0x80e00000 0x00 0x00008000>,
> +                  <0x4d 0x80f00000 0x00 0x00008000>;
> +            reg-names = "l2sram", "l1pram", "l1dram";
> +            ti,sci = <&dmsc>;
> +            ti,sci-dev-id = <142>;
> +            ti,sci-proc-ids = <0x03 0xFF>;
> +            resets = <&k3_reset 142 1>;
> +            firmware-name = "j7-c66_0-fw";
> +            memory-region = <&c66_0_dma_memory_region>,
> +                            <&c66_0_memory_region>;
> +            mboxes = <&mailbox0_cluster3 &mbox_c66_0>;
> +        };
> +    };
> -- 
> 2.23.0
> 

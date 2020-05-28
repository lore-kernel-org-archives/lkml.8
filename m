Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A01A206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590700642;
	bh=w9EQj4uXrttdeEA1QnOc2iqN+7jHMKFcr778Lh2jxvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TFX5nnPI5u+c64Xx7iqLzlXQ18dIIUAJT/DJYcIcQh+cMN1tBuV/zW6RETvIlPe37
	 UQ25u6qfreT92rz20jkIIw2nDaEYAId6w/z+PNAzZY2CRn5egMM1kGT2RRec9V1bMT
	 cQ2+VU5H1otQL+pt3YnaQBrRgWy1XJcIenmfEJDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436503AbgE1VRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:17:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38030 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407473AbgE1VRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:17:16 -0400
Received: by mail-io1-f68.google.com with SMTP id d7so57796ioq.5;
        Thu, 28 May 2020 14:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+TqS7m/JgHBOxozCv+TMWYsXzg4EAp9FGtr063H8zmQ=;
        b=e9OE8PXeImdp73zy+f5XqViw0J/+1VMHM/x4IPnc+Cg/I77/xSvsLUTKlpFvR/mF+d
         /UefVMLaGLJ0HdlZrgnrJ+vQHZ6kNxPjuL1QWPd22dKZ4ZYy7HE3Iaqq9l5uXDSmlZcH
         fKfJqk0zvL5vHp0iWXK4pu6n34H32udw4bBHv+22ewR98PfSy8RR+V2dLoMkLQ5NeFOs
         m5TPtEflf3vABnVe9vWGVHVTNS/8estPnwhwyhJOfIi9TIKYnpKRdlhNlWzhMFOmfNVS
         BdMB2bziL4q2UAiqTRXDxfEbOipuioFCkxkoFrB/uJojAlmKgqMSB8mQr+xyiDh5tjAG
         f41A==
X-Gm-Message-State: AOAM530CFuM44CvjCjnf5+x8TXFzvUohESNG1afT7Sqfma/TVTIMbEPk
        8Jx0myWnh/yNaH8sHYF2oA==
X-Google-Smtp-Source: ABdhPJzARk90ztvxx/gdvNEIrY2JRoL+qqPXKEfDIuVIoN0XaThXMyPQd8haBzHcKWW6L/tkwe7jfw==
X-Received: by 2002:a6b:cac5:: with SMTP id a188mr4013104iog.145.1590700635021;
        Thu, 28 May 2020 14:17:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o18sm3648294ils.30.2020.05.28.14.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 14:17:14 -0700 (PDT)
Received: (nullmailer pid 701364 invoked by uid 1000);
        Thu, 28 May 2020 21:17:13 -0000
Date:   Thu, 28 May 2020 15:17:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, vkoul@kernel.org,
        manivannan.sadhasivam@linaro.org, dan.j.williams@intel.com,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: dmaengine: convert Actions Semi
 Owl SoCs bindings to yaml
Message-ID: <20200528211713.GA694871@bogus>
References: <1589912368-480-1-git-send-email-amittomer25@gmail.com>
 <1589912368-480-6-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589912368-480-6-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:49:23PM +0530, Amit Singh Tomar wrote:
> Converts the device tree bindings for the Actions Semi Owl SoCs DMA
> Controller over to YAML schemas.
> 
> It also adds new compatible string "actions,s700-dma".
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Change since v1:
> 	* Updated the description field to reflect
> 	  only the necessary information.
> 	* replaced the maxItems field with description for each 
>           controller attribute(except interrupts).
> 	* Replaced the clock macro with number to keep the example
>           as independent as possible.
> 	  	
>  New patch, was not there in RFC.
> ---
>  Documentation/devicetree/bindings/dma/owl-dma.txt  | 47 -------------
>  Documentation/devicetree/bindings/dma/owl-dma.yaml | 76 ++++++++++++++++++++++
>  2 files changed, 76 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dma/owl-dma.txt b/Documentation/devicetree/bindings/dma/owl-dma.txt
> deleted file mode 100644
> index 03e9bb12b75f..000000000000
> --- a/Documentation/devicetree/bindings/dma/owl-dma.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -* Actions Semi Owl SoCs DMA controller
> -
> -This binding follows the generic DMA bindings defined in dma.txt.
> -
> -Required properties:
> -- compatible: Should be "actions,s900-dma".
> -- reg: Should contain DMA registers location and length.
> -- interrupts: Should contain 4 interrupts shared by all channel.
> -- #dma-cells: Must be <1>. Used to represent the number of integer
> -              cells in the dmas property of client device.
> -- dma-channels: Physical channels supported.
> -- dma-requests: Number of DMA request signals supported by the controller.
> -                Refer to Documentation/devicetree/bindings/dma/dma.txt
> -- clocks: Phandle and Specifier of the clock feeding the DMA controller.
> -
> -Example:
> -
> -Controller:
> -                dma: dma-controller@e0260000 {
> -                        compatible = "actions,s900-dma";
> -                        reg = <0x0 0xe0260000 0x0 0x1000>;
> -                        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> -                                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> -                                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> -                                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> -                        #dma-cells = <1>;
> -                        dma-channels = <12>;
> -                        dma-requests = <46>;
> -                        clocks = <&clock CLK_DMAC>;
> -                };
> -
> -Client:
> -
> -DMA clients connected to the Actions Semi Owl SoCs DMA controller must
> -use the format described in the dma.txt file, using a two-cell specifier
> -for each channel.
> -
> -The two cells in order are:
> -1. A phandle pointing to the DMA controller.
> -2. The channel id.
> -
> -uart5: serial@e012a000 {
> -        ...
> -        dma-names = "tx", "rx";
> -        dmas = <&dma 26>, <&dma 27>;
> -        ...
> -};
> diff --git a/Documentation/devicetree/bindings/dma/owl-dma.yaml b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> new file mode 100644
> index 000000000000..82e7d261e967
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/owl-dma.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/owl-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi Owl SoCs DMA controller
> +
> +description: |
> +  The OWL DMA is a general-purpose direct memory access controller capable of
> +  supporting 10 and 12 independent DMA channels for S700 and S900 SoCs
> +  respectively.
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +allOf:
> +  - $ref: "dma-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,s900-dma
> +      - actions,s700-dma
> +
> +  reg:
> +    description:
> +      DMA registers location and length.

Don't need a description. Just need: 

maxItems: 1

> +
> +  interrupts:
> +    description:
> +      controller supports 4 interrupts, which are freely assignable to the
> +      DMA channels.
> +    maxItems: 4
> +
> +  "#dma-cells":
> +    const: 1
> +
> +  dma-channels:
> +    description:
> +      Physical channels supported.

Already defined in dma-controller.yaml. You need to add any constraints.
2^32 channels okay?

> +
> +  dma-requests:
> +    description:
> +      Number of DMA request signals supported by the controller.

Same here.

> +
> +  clocks:
> +    description:
> +      Phandle and Specifier of the clock feeding the DMA controller.

How many?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#dma-cells"
> +  - dma-channels
> +  - dma-requests
> +  - clocks

Add:

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    dma: dma-controller@e0260000 {
> +        compatible = "actions,s900-dma";
> +        reg = <0x0 0xe0260000 0x0 0x1000>;
> +        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +        #dma-cells = <1>;
> +        dma-channels = <12>;
> +        dma-requests = <46>;
> +        clocks = <&clock 22>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 

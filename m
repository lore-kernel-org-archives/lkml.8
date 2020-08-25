Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A22DC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EFB2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598392130;
	bh=HdWdCg5End0CQJcfKxWBW19NbLdV3wK4LQlQ8qpg/xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oXdQogCt57L5jGirzpw/MJUHwTg0EzLBrfAhbxKUbxaDvjRB37WzfeJGXM3NmEPra
	 7GQ+UycyVPvzSbwMSQsmZNfbrWt2Jzu9nvt9+KoNf4M4CYauP3q4m1fm5t4yDdmkFe
	 qLszv/tKNXrCpz2B8WKMlyn4DZ6DJDatLyaaY8NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHYVst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:48:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42541 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:48:48 -0400
Received: by mail-io1-f66.google.com with SMTP id g13so45619ioo.9;
        Tue, 25 Aug 2020 14:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQP52sLIM0MfnF4NggVw656j4jf7VJADZKCoTHNbNKI=;
        b=oqfUPgX+gjBxakDKpvrTAQSwUlYMUsVtv6Tfnxy30v26D+DiH400WcudOQ84Be+Fxe
         gtz8Zm3ZiBvSLnv/QesK1GgeOjZC4QTJXJGk8iacUc9K6bXfk5h3n9HChizhDdK2yIbe
         TBS67Dq2eNk4OpuHnTk0dNBYOFHPkJ4fjDx+VO5Ppa/DNRT5Vj9f/2xlM7DaSHrcb66p
         /HSL77Kz4WcaUtl2JQmGtO3LseCQSj9E3MYc1R5wMTt2RfBRfOd2DwqfP9H3HT1Muu0F
         6oLSahObcCzSe1e0qo/tbzA8W4vuYBNEx1fg/vo2Ax1+jNpb59mdzJhKDsGbFtjORZNd
         8piA==
X-Gm-Message-State: AOAM531NIDvbYZAGtueRMHADMnnzlgzCVjUGT+GTR+pFoPvU4dazS0oK
        0Byv+dkzhCEu3RbsQGFw5HCr7knbL3uN
X-Google-Smtp-Source: ABdhPJwIny58KBr2tW0qD6I6vbfQzkQqr7DvAVQaFDJyISwKyKf4dn22aFNXa8TQpK0wTX1V5yeJGQ==
X-Received: by 2002:a6b:5009:: with SMTP id e9mr10947465iob.156.1598392127545;
        Tue, 25 Aug 2020 14:48:47 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id t187sm23566iof.54.2020.08.25.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:48:47 -0700 (PDT)
Received: (nullmailer pid 1396452 invoked by uid 1000);
        Tue, 25 Aug 2020 21:48:42 -0000
Date:   Tue, 25 Aug 2020 15:48:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     maz@kernel.org, tglx@linutronix.de, jason@lakedaemon.net,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        alix.wu@mediatek.com, daniel@0x0f.com
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: Add MStar
 interrupt controller
Message-ID: <20200825214842.GA1367012@bogus>
References: <20200819034231.20726-1-mark-pk.tsai@mediatek.com>
 <20200819034231.20726-3-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819034231.20726-3-mark-pk.tsai@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:42:31AM +0800, Mark-PK Tsai wrote:
> Add binding for MStar interrupt controller.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  .../interrupt-controller/mstar,mst-intc.yaml  | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> new file mode 100644
> index 000000000000..6e383315e529
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings.

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/mstar,mst-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MStar Interrupt Controller
> +
> +maintainers:
> +  - Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> +
> +description: |+
> +  MStar, SigmaStar and Mediatek DTV SoCs contain multiple legacy
> +  interrupt controllers that routes interrupts to the GIC.
> +
> +  The HW block exposes a number of interrupt controllers, each
> +  can support up to 64 interrupts.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#

Drop this. It is applied based on node name matching already.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mstar,mst-intc
> +      - enum:
> +          - mediatek,mt58xx-intc

Normally, the 1st entry would be enum as that's where you'd add new 
compatibles (as the fallback is constant). But if you don't forsee any 
additions, just make both 'const'

> +
> +  interrupt-controller: true
> +
> +  "#address-cells":
> +    enum: [ 0, 1, 2 ]

This would normally be 0 in an interrupt controller. It's only relevant 
if you have an 'interrupt-map' which this is the parent for.

> +  "#size-cells":
> +    enum: [ 1, 2 ]

And this should be dropped.

> +
> +  "#interrupt-cells":
> +    const: 3
> +    description: |
> +      Use the same format as specified by GIC in arm,gic.yaml.

That's odd. You have the same SPI and PPI stuff?

> +
> +  reg:
> +    description: |
> +      Physical base address of the mstar interrupt controller
> +      registers and length of memory mapped region.

Drop this. That's every 'reg' property.

> +    minItems: 1

maxItems is more logical.

> +
> +  mstar,irqs-map-range:
> +    description: |
> +      The range of parent interrupt controller's interrupt lines
> +      that are hardwired to mstar interrupt controller.

Is this <start size> or <start end>?

Really, this should just use 'interrupts' even though that's a bit 
verbose. Or be implied by the compatible string. What's the maximum 
number of parent interrupts?

In any case, we really need to stop having vendor specific properties 
for this.

> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      minItems: 2
> +      maxItems: 2
> +
> +  mstar,intc-no-eoi:
> +    description: |

Don't need '|' if there's no formatting.

> +      Mark this controller has no End Of Interrupt(EOI) implementation.
> +      This is a empty, boolean property.

You can drop this line. The schema says this.

> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - mstar,irqs-map-range
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mst_intc0: interrupt-controller@1f2032d0 {
> +      compatible = "mstar,mst-intc", "mediatek,mt58xx-intc";
> +      interrupt-controller;
> +      #interrupt-cells = <3>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      interrupt-parent = <&gic>;
> +      reg = <0x1f2032d0 0x30>;
> +      mstar,irqs-map-range = <0 63>;

Is 0 a PPI or SPI? This property is making some assumption and wouldn't 
be able to support both types or another parent interrupt controller.

> +    };
> +...
> -- 
> 2.18.0

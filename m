Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C14C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BEC20838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598652396;
	bh=ir8kIhH779Cg1djVFRrFrhk0hFujbtY9nAXQzyLEqFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I3alM1NRvjRjvizXXrZNSna83MXoY7O4ZWO8cEkzt4mb1U9rvn/k1fKm6ULBVVrsV
	 dSm1efMYb9OQFBzQwobO9vlial2BO0HR7zj9e7i+Dk+RMCcEaupxpGyPamBRH5WO4y
	 KOkBq86PCBWHIOmQxYX6ZyjieQv94oOukzYo+aHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH1WGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:06:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35121 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1WGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:06:34 -0400
Received: by mail-io1-f65.google.com with SMTP id l8so588463ios.2;
        Fri, 28 Aug 2020 15:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39/6+NdecqvikGjg8YBo+lOCsS3fMVVJzywnwgJFjx0=;
        b=FKcWZKPWciE73V1oAHju7v1w0Ew+nSaDidOkvSEiWSQioxC7ongrN2k2ZxBK8TVMwb
         E5hmBusdHbvjg9ypZ0FnyILR2SOflnKoyzMdnt3xnyXQfH1uoI7EaaEEYgHkrYOZLXBf
         CFrjid5bAxqZJRTJUkiyT5VCeIRBpZm+2l88FK3MmKpFvMNctC/Jo1dU0bsYSmvKRWjZ
         bJohYOKmMchJZGujm40Wa87ir2d+oNvJWYvmeoYfhpSxipLcvsCVrtxEnCKsqDmLh9r/
         f2qK9Dr2HCMarjTPAkfahyFSNd1H8v1ulJNZfTkYuVQhNOOsFc+dg1wFhMy4vO4V0PK/
         94AA==
X-Gm-Message-State: AOAM531SAo56ve6KnaK63o6lY8ggZIfN66ofFg+M1Gyh+dtI548aP0mA
        27hACYvWAxcGjCjpxXJexg==
X-Google-Smtp-Source: ABdhPJwVv8s/hJTLnejTHw2Frk9tNzJBWfrJVda7OMvoSYV6El+lEe6dFH5QofuW1HtBydBRzeP9uw==
X-Received: by 2002:a05:6638:1393:: with SMTP id w19mr2971735jad.113.1598652393099;
        Fri, 28 Aug 2020 15:06:33 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v11sm342684ili.66.2020.08.28.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:06:32 -0700 (PDT)
Received: (nullmailer pid 3488084 invoked by uid 1000);
        Fri, 28 Aug 2020 22:06:30 -0000
Date:   Fri, 28 Aug 2020 16:06:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        cy_huang@richtek.com, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding
 documentation
Message-ID: <20200828220630.GB3482472@bogus>
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
 <1598610636-4939-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598610636-4939-2-git-send-email-u0084500@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:30:36PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add a devicetree binding documentation for the MT6360 Type-C driver.
> 
> usb typec: mt6360: Rename DT binding doument from mt6360 to mt636x
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/usb/mediatek,mt6360-tcpc.yaml         | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> new file mode 100644
> index 00000000..9e8ab0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/mediatek,mt6360-tcpc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek MT6360 Type-C Port Switch and Power Delivery controller DT bindings
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  Mediatek MT6360 is a multi-functional device. It integrates charger, ADC, flash, RGB indicators,
> +  regulators (BUCKs/LDOs), and TypeC Port Switch with Power Delivery controller.
> +  This document only describes MT6360 Type-C Port Switch and Power Delivery controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6360-tcpc
> +
> +  interrupts-extended:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: PD_IRQB
> +
> +patternProperties:
> +  "connector":

Also, this is not a pattern, so should be under 'properties', and it 
doesn't need quotes.

> +    type: object
> +    $ref: ../connector/usb-connector.yaml#
> +    description:
> +      Properties for usb c connector.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - interrupts-extended
> +  - interrupt-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/usb/pd.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        mt6360@34 {
> +            compatible = "mediatek,mt6360";
> +            reg = <0x34>;
> +
> +            tcpc {
> +                compatible = "mediatek,mt6360-tcpc";
> +                interrupts-extended = <&gpio26 3 IRQ_TYPE_LEVEL_LOW>;
> +                interrupt-names = "PD_IRQB";
> +
> +                connector {
> +                        compatible = "usb-c-connector";
> +                        label = "USB-C";
> +                        data-role = "dual";
> +                        power-role = "dual";
> +                        try-power-role = "sink";
> +                        source-pdos = <PDO_FIXED(5000, 1000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> +                        sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP)>;
> +                        op-sink-microwatt = <10000000>;
> +                };
> +            };
> +        };
> +    };
> +...
> -- 
> 2.7.4
> 

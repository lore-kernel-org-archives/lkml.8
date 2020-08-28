Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E2CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E1420838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598652326;
	bh=aitdIbpAnFb6/2uJBoQAsOYIPKKYlXuPzO6QzAqB+FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vZssxTcLHJum1QoxtuLgcTwY3gP3S9mnAPKeDqWtOwh/PhN8io79gl6abvKpPggUk
	 f0dyTkBzXmHweU4gpkYWk0VUE6xuMzw7gFncl5cojyEEzEh2up7poMfdQTsGiL3AU9
	 BTeK04IaIJTTd8rAVGXIh6FsVBP8IeNis6H8QMe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgH1WFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:05:25 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34300 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgH1WFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:05:24 -0400
Received: by mail-il1-f195.google.com with SMTP id t4so1961452iln.1;
        Fri, 28 Aug 2020 15:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hEjjUFT83iNRg02ncmXB05CfgHtGJIWhaDk9gjoB/yw=;
        b=OOilt4j1+KTw65U58gKzSPhkY50KfIrngoOMpxwsJSkNrFwRpnPucG0hfffWC3Qv7n
         HlFgD5GFWhNG+39UYSXnXkcV4m0oUUHsCmcirnDwS9ZpmCZ9N+uMBVLDYym0N4QTme3l
         GU69dZ/RaZWNpbdXN1/60dN/UB0wBYl20CanSa3Ow4Zm9+FE+eDsef72X6qOmdPg+OfD
         PwlnZjRZJqkguWzZIj6AvCBfhs02WBVKwJgJ6LhNcRSt0VdDxf7HOCzuH1pea4oBzxxU
         KmH/E+jc/yWaDGDqb6HMa1NZ1dhtdWdy1bUVv6EaPRX/6hFlhK+Q45+mgKzM8z7wFgBK
         Uo4w==
X-Gm-Message-State: AOAM533pnH4AdUJfiAmswB8MYGx0f1lSWzRSfNJnPgEqqiyeSYu5WJeY
        4L1sxDmsXsQGpHXE9fIewTry5UC2kebT
X-Google-Smtp-Source: ABdhPJxm/ppsdTb0g25vKmMiz/juduCbS2JSibG+yBa7cfosxhP0iu5fPruCrPy6GFCcFSyoZ/Y5fQ==
X-Received: by 2002:a05:6e02:13c6:: with SMTP id v6mr804659ilj.87.1598652323060;
        Fri, 28 Aug 2020 15:05:23 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id q23sm238341ior.47.2020.08.28.15.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:05:22 -0700 (PDT)
Received: (nullmailer pid 3486516 invoked by uid 1000);
        Fri, 28 Aug 2020 22:05:20 -0000
Date:   Fri, 28 Aug 2020 16:05:20 -0600
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
Message-ID: <20200828220520.GA3482472@bogus>
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

Use 'interrupts'. The tooling will automatically support 
'interrupts-extended'.

> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: PD_IRQB
> +
> +patternProperties:
> +  "connector":
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

Where's the data connections? The assumption of the binding is the USB 
(2 and 3) connections come from the parent if there's no graph to the 
USB controller(s).

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

Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4D6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC822088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590543440;
	bh=4cUIPDm/foJKaIkPtkzb20WhYpxDbx/mzQ/Z/SNEa/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M8H8bJMmbbUFgZN3Du5q4DKz73Md3VJE/d5IokBddIPJsIEKcqlhBsD14O5C+ej4X
	 S5d+wDV0YEPyaygJ+QVhjukH6MfH31aNGsZPdnRHtxb+9Q/2bEYc6gDjkDyvwjKIR9
	 TVc1JRlomVywMDiu6THDkFdrvRdXjFny6WWGEI0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgE0BhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:37:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38160 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgE0BhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:37:19 -0400
Received: by mail-io1-f65.google.com with SMTP id d7so24263322ioq.5;
        Tue, 26 May 2020 18:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xckD9+dHAmUGj7g+utINyA+rLaiLP9KqU3YumDLq3PE=;
        b=bdL4szCwQPS1O+4il3fB8+B60vX1HVZq0I6lFqMIeDu/69Gel3aZluxU8fQ8xqFftP
         KHGmW99MywSiSlvqiAuEqFOL340aDNpR1qigOzq+pFioOmHP4RzIaI+rOoPgYELlcA6t
         Dxj2jasEFstBk8H/+Tb1nHEWbksf4k5Mxwis44DNGD+G0mk93085QurFbqL/9a0CWIcI
         Pl/Snw2WBrEmN50tQPHRXoGccu8AykfPXAo69ziFcFG/kELu8HbUT0N4oQwDSepzHQJz
         5wGjtkXMaKnwBGwM8XDEU6UBtLY/Sur22iwlf7sK3XzEw1AdQNGQJi6SCUesk0pH1HII
         RvBQ==
X-Gm-Message-State: AOAM530Taip0fgDmRXPV39kfagEmRHfWDo+LHRzhjl2W96gPAma5KJnY
        71feu23kjv6fS3JusUxCLzqiAXs=
X-Google-Smtp-Source: ABdhPJyaK2mdTrxf61+oakEx9DGgvUIte6C7kK0Co/6Hn2/jE+Jnnd6DVBPrp3084vEYB9IfypTIrw==
X-Received: by 2002:a5e:d506:: with SMTP id e6mr19684901iom.184.1590543437064;
        Tue, 26 May 2020 18:37:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p7sm620988iob.7.2020.05.26.18.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 18:37:16 -0700 (PDT)
Received: (nullmailer pid 852830 invoked by uid 1000);
        Wed, 27 May 2020 01:37:15 -0000
Date:   Tue, 26 May 2020 19:37:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     balbi@kernel.org, vigneshr@ti.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: usb: convert keystone-usb.txt to YAML
Message-ID: <20200527013715.GA847644@bogus>
References: <20200513130709.10239-1-rogerq@ti.com>
 <20200513130709.10239-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513130709.10239-2-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:07:07PM +0300, Roger Quadros wrote:
> Convert keystone-usb documentation to YAML format.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/keystone-usb.txt  | 56 ----------------
>  .../bindings/usb/ti,keystone-dwc3.yaml        | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/keystone-usb.txt b/Documentation/devicetree/bindings/usb/keystone-usb.txt
> deleted file mode 100644
> index 77df82e36138..000000000000
> --- a/Documentation/devicetree/bindings/usb/keystone-usb.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -TI Keystone Soc USB Controller
> -
> -DWC3 GLUE
> -
> -Required properties:
> - - compatible: should be
> -		"ti,keystone-dwc3" for Keystone 2 SoCs
> -		"ti,am654-dwc3" for AM654 SoC
> - - #address-cells, #size-cells : should be '1' if the device has sub-nodes
> -   with 'reg' property.
> - - reg : Address and length of the register set for the USB subsystem on
> -   the SOC.
> - - interrupts : The irq number of this device that is used to interrupt the
> -   MPU.
> - - ranges: allows valid 1:1 translation between child's address space and
> -   parent's address space.
> -
> -SoC-specific Required Properties:
> -The following are mandatory properties for Keystone 2 66AK2HK, 66AK2L and 66AK2E
> -SoCs only:
> -
> -- clocks:		Clock ID for USB functional clock.
> -- clock-names:		Must be "usb".
> -
> -
> -The following are mandatory properties for 66AK2G and AM654:
> -
> -- power-domains:	Should contain a phandle to a PM domain provider node
> -			and an args specifier containing the USB device id
> -			value. This property is as per the binding,
> -			Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> -
> -Sub-nodes:
> -The dwc3 core should be added as subnode to Keystone DWC3 glue.
> -- dwc3 :
> -   The binding details of dwc3 can be found in:
> -   Documentation/devicetree/bindings/usb/dwc3.txt
> -
> -Example:
> -	usb: usb@2680000 {
> -		compatible = "ti,keystone-dwc3";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0x2680000 0x10000>;
> -		clocks = <&clkusb>;
> -		clock-names = "usb";
> -		interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> -		ranges;
> -
> -		dwc3@2690000 {
> -			compatible = "synopsys,dwc3";
> -			reg = <0x2690000 0x70000>;
> -			interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> -			usb-phy = <&usb_phy>, <&usb_phy>;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> new file mode 100644
> index 000000000000..14d2fe329b93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,keystone-dwc3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Keystone Soc USB Controller
> +
> +maintainers:
> +  - Roger Quadros <rogerq@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: "ti,keystone-dwc3"
> +      - const: "ti,am654-dwc3"

Use enum rather than oneOf+const.

> +
> +  reg:
> +    maxItems: 1
> +    description: Address and length of the register set for the USB subsystem on
> +      the SOC.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The irq number of this device that is used to interrupt the MPU.

No need for genericish descriptions when a single item.

> +
> +
> +  clocks:
> +    description: Clock ID for USB functional clock.

How many?

> +
> +  power-domains:
> +    description: Should contain a phandle to a PM domain provider node
> +      and an args specifier containing the USB device id
> +      value. This property is as per the binding,
> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt

How many?

> +
> +  dwc3:

This doesn't work because there's a unit address. You need a pattern.

> +    description: This is the node representing the DWC3 controller instance
> +      Documentation/devicetree/bindings/usb/dwc3.txt

type: object

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    usb: usb@2680000 {
> +      compatible = "ti,keystone-dwc3";
> +      #address-cells = <1>;
> +      #size-cells = <1>;

These have to be documented.

> +      reg = <0x2680000 0x10000>;
> +      clocks = <&clkusb>;
> +      clock-names = "usb";
> +      interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +      ranges;

This too.

> +
> +      dwc3@2690000 {
> +        compatible = "synopsys,dwc3";
> +        reg = <0x2690000 0x70000>;
> +        interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> +        usb-phy = <&usb_phy>, <&usb_phy>;
> +      };
> +    };
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

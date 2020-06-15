Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0662E208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592242922;
	bh=HdnWgcJ03gAfD1VQ+kJO14dYsTkMlReWaMNpu69mPL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lKL7d1/uPZjSXyHK3XghcMGb/6GGNcQdOQa6GorSMsgHkf+LH21A8APpce+wVkHsy
	 ErhTfywm7x1DRjKxDL+TdqVMreE0XmAypSODfhUs0LClxKAKDAeeL3Y5c8HIKqIJZT
	 USlmPhUmRPXZV/tN6aTMOQxHyQ3Ux++8YkpfGZO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbgFORmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:42:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46764 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgFORl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:41:59 -0400
Received: by mail-io1-f65.google.com with SMTP id t9so18825452ioj.13;
        Mon, 15 Jun 2020 10:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMpmhFEcqSXIab1ZqD47f2fH1FWApjPBtMrvK1o14Oo=;
        b=qHIbs8BW6gr1Ii8LGWb6TAwskikDUASz/af2O3F6V5iXK7Hq7UQHmzWGumBPHSUZY0
         O64KIHSXtU1JYYiOrx3af0NAestyy+FMBiYeSiKlvScC6NSlhXuhrbcJKHj5jg3/ooGH
         cfS4FkaOl7WTckKsMQGPXP06QLbjbL9dY5Su5ddwX8TvK0L0OTphBQJA/XFs/ZPVt8S/
         PpFCrOmpMloRUTht3Tokai2ZfAmb07w97MvHIBit2LLIrJ05WAza7S0JtPgUBEHUQKkn
         DDJvBB2rauhQ5eMoiZQyXiUkYEs0JHN1H326zW+K/VuCKRPAhsnh4MWEwswLyuQxWNkS
         aBrg==
X-Gm-Message-State: AOAM530dUEN6sr4FUc4VKrLE4aVHNu6MbVRTI+02XMloO1XOfNPVgVq7
        JTk3uRHYmO9JrLHWoXgrhw==
X-Google-Smtp-Source: ABdhPJzbVJjmZIYFseBxe+B3y3UPFiRRE+yWGYRph4XvFAwYRcecAH80ZNK4RkoiE8qSCHQ5Rd+BYw==
X-Received: by 2002:a05:6638:604:: with SMTP id g4mr23171216jar.80.1592242918695;
        Mon, 15 Jun 2020 10:41:58 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t189sm8220707iod.16.2020.06.15.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:41:58 -0700 (PDT)
Received: (nullmailer pid 2018089 invoked by uid 1000);
        Mon, 15 Jun 2020 17:41:56 -0000
Date:   Mon, 15 Jun 2020 11:41:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     balbi@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: usb: ti,keystone-dwc3.yaml: Improve
 schema
Message-ID: <20200615174156.GA2008179@bogus>
References: <20200602124055.1680-1-rogerq@ti.com>
 <5f81187b-0558-3815-051b-e40685fd047a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f81187b-0558-3815-051b-e40685fd047a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:52:15AM +0300, Roger Quadros wrote:
> There were some review comments after the patch was integrated.
> Address those.
> 
> Fixes: 1883a934e156 ("dt-bindings: usb: convert keystone-usb.txt to YAML")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
> 
> Changelog:
> v2
> - don't use quotes for enum/const string
> - use phandle instead of phandle-array for phys
> - add maxItems for phy-names
> 
>  .../bindings/usb/ti,keystone-dwc3.yaml        | 50 ++++++++++++++-----
>  1 file changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> index f127535feb0b..394e47d2f5d7 100644
> --- a/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
> @@ -11,64 +11,88 @@ maintainers:
>  properties:
>    compatible:
> -    oneOf:
> -      - const: "ti,keystone-dwc3"
> -      - const: "ti,am654-dwc3"
> +    items:
> +      - enum:
> +        - ti,keystone-dwc3
> +        - ti,am654-dwc3
>    reg:
>      maxItems: 1
> -    description: Address and length of the register set for the USB subsystem on
> -      the SOC.
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true

blank line

>    interrupts:
>      maxItems: 1
> -    description: The irq number of this device that is used to interrupt the MPU.
> -
>    clocks:
> +    $ref: /schemas/types.yaml#definitions/phandle-array

Common property. It already has a type and doesn't need to be 
redefined here.

Just "maxItems: 1" if it is a single clock is enough, or an 'items' list 
for each entry if more than 1.

>      description: Clock ID for USB functional clock.

Drop.

> +  assigned-clocks:
> +    $ref: /schemas/types.yaml#definitions/phandle-array


> +
> +  assigned-clock-parents:
> +    $ref: /schemas/types.yaml#definitions/phandle-array
> +
>    power-domains:
> +    $ref: /schemas/types.yaml#definitions/phandle-array

Same as 'clocks'.

>      description: Should contain a phandle to a PM domain provider node
>        and an args specifier containing the USB device id
>        value. This property is as per the binding,
>        Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>    phys:
> +    $ref: /schemas/types.yaml#/definitions/phandle

Same as 'clocks'.

>      description:
>        PHY specifier for the USB3.0 PHY. Some SoCs need the USB3.0 PHY
>        to be turned on before the controller.
>        Documentation/devicetree/bindings/phy/phy-bindings.txt
>    phy-names:
> +    maxItems: 1
>      items:
> -      - const: "usb3-phy"
> +      - const: usb3-phy

Don't need maxItems as that's implied by the length of 'items'.

> +
> +  dma-coherent: true
> -  dwc3:
> +  dma-ranges: true
> +
> +patternProperties:
> +  "usb@[a-f0-9]+$":
> +    type: object
>      description: This is the node representing the DWC3 controller instance
>        Documentation/devicetree/bindings/usb/dwc3.txt
>  required:
>    - compatible
>    - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
>    - interrupts
> -  - clocks
> +
> +additionalProperties: false
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -    usb: usb@2680000 {
> +    dwc3@2680000 {
>        compatible = "ti,keystone-dwc3";
>        #address-cells = <1>;
>        #size-cells = <1>;
>        reg = <0x2680000 0x10000>;
>        clocks = <&clkusb>;
> -      clock-names = "usb";
>        interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>        ranges;
> -      dwc3@2690000 {
> +      usb@2690000 {
>          compatible = "synopsys,dwc3";
>          reg = <0x2690000 0x70000>;
>          interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 

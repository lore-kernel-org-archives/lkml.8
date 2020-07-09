Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FF2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D7320672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594332672;
	bh=i4gEU3Jy5mL2Z9vP7rYPgGIlBm/BNckhMMbkDa2wMmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wb6jPAj2k/aK34T+udiT0wJ85LX+SyhcINDZv4ZaTeYqW7zstjQtKCP3wxDHqmYbh
	 z3vRljzlz4wSu+fVytehdvSSKHFEw4tHHZZbhyTZTV0VphU84tIo1opb1gb0HCIJt1
	 KWUDwBM9EuAk3rUrZIlX/Ae4bQ6/15COr/lr1vOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGIWLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:11:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38032 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:11:10 -0400
Received: by mail-io1-f65.google.com with SMTP id l1so4004090ioh.5;
        Thu, 09 Jul 2020 15:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bT3++BEYrjJIhXhzxTXtHnkKclhpqH+T88s6CFRclJo=;
        b=CswQIaPFF7yO7s2kqmjnqUNEjLtZBue0XA50JduhAGmpTial2flxV8NnZ53tiVBq3K
         6qwhM/zRC7S7hrBe3AqBVrWXlOD+LBYYF2X5qmHuxr/TRlqK+8G4UGVcvo8j6aaUlnrm
         NmAH2IsUPNa/fwDp86q/xvUEe0ofY27oCr4aLopOAr96Urr4wXlnmFFXhfjKFlp5/ABP
         fE4FIlBkZpWLoTUAiTYkzI2RPyr3q1nbVNYZcG1gplFT0EW7+u7UzpHrbV7KsDjtuw+p
         K7IhLvbfRuE9AwEEBOEm/DOW6TLdowr7HePw03uqR7q4o+Vk62RZYsSCdxkqjGHL6D1F
         eJ2A==
X-Gm-Message-State: AOAM5329/S4wBhbcB5eD5saL2zCOx+kh016WwI0AYTJLHtZyVm1TNU3a
        5qngspslNEycPcutt6NmFA==
X-Google-Smtp-Source: ABdhPJz4lRiz70zmxalQUoUYbGE8Rm547bR48XMoyyuw4D0hqYCx9U1AiTKXy2iCcGXC/viEMPy/cA==
X-Received: by 2002:a02:b0d5:: with SMTP id w21mr63608081jah.27.1594332669694;
        Thu, 09 Jul 2020 15:11:09 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id o7sm2824483ioo.4.2020.07.09.15.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:11:09 -0700 (PDT)
Received: (nullmailer pid 982246 invoked by uid 1000);
        Thu, 09 Jul 2020 22:11:05 -0000
Date:   Thu, 9 Jul 2020 16:11:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     simon@fire.lp0.eu, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Message-ID: <20200709221105.GA976808@bogus>
References: <20200619100035.4032596-1-noltari@gmail.com>
 <20200619100035.4032596-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619100035.4032596-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:00:34PM +0200, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v5: no changes.
>  v4: conditionally require 1/2 clocks and fix clock/reset values.
>  v3: no changes.
>  v2: phy-cells changed to 1.
> 
>  .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> new file mode 100644
> index 000000000000..f267da6193a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: BCM63xx USBH PHY
> +
> +maintainers:
> +  - Álvaro Fernández Rojas <noltari@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,bcm6318-usbh-phy
> +      - brcm,bcm6328-usbh-phy
> +      - brcm,bcm6358-usbh-phy
> +      - brcm,bcm6362-usbh-phy
> +      - brcm,bcm6368-usbh-phy
> +      - brcm,bcm63268-usbh-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: usbh
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - "#phy-cells"

You need:

additionalProperties: false

> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - brcm,bcm6318-usbh-phy
> +            - brcm,bcm63268-usbh-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 2

This doesn't work. The main schema will also be applied and it says 
there's 1. The main schema has to cover all the cases and then if/then 
schemas add constraints.

> +        clock-names:
> +          items:
> +            - const: usbh
> +            - const: usb_ref
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - brcm,bcm6318-usbh-phy
> +            - brcm,bcm6328-usbh-phy
> +            - brcm,bcm6362-usbh-phy
> +            - brcm,bcm63268-usbh-phy
> +    then:
> +      properties:
> +        power-domains:
> +          maxItems: 1
> +      required:
> +        - power-domains
> +
> +examples:
> +  - |
> +    usbh: usb-phy@10001700 {
> +      compatible = "brcm,bcm6368-usbh-phy";
> +      reg = <0x10001700 0x38>;
> +      clocks = <&periph_clk 15>;
> +      clock-names = "usbh";
> +      resets = <&periph_rst 12>;
> +      #phy-cells = <1>;
> +    };
> -- 
> 2.27.0
> 

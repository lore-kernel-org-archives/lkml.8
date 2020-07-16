Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10254C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11702076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594914369;
	bh=7T7+aec3b3QGQPctlJSnbMZtgTjJtaxTJ2P4f9xA4gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cY4LbwYZPnKeuVoZFnAcNv9siFPcIyzthBP6LIZ1z4oWt0AU+NJtV5vF7SdsN1MMB
	 FY0rX3Av3LCDCQNAzy7Sbz8K2Y8ZxUDUtzg9q1Cy3a2XhXH62AXroX4rXOIhbetC5Q
	 EhkiBV5jkTDyuOGkY8VL65uErD4tdLhSobAtpp7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgGPPqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:46:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:37593 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgGPPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:46:08 -0400
Received: by mail-il1-f193.google.com with SMTP id r12so5452263ilh.4;
        Thu, 16 Jul 2020 08:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=h94tFRUF4D5bdpqmTblQ19sOobDYu6cH5YoxhApuutc=;
        b=U07qLmlR+6xzLYL8SV981Mlz/KBwh+dp7i0SBP+P+dVdCrG1udWAZCscGb6w+eUtCc
         dKW+x/1s+VWosdcsCyY8BemzqqX2W8rcWifZnEdO67kFAq1/xWehv4feejcc1behf5S7
         u25jctGppCg0oZJuz71RwHX9ZFGcZV/JIn/uJ2eMOgIDXBz0L4Dbji+KojqqxQVSIf86
         Gl4kj+glCh5QLrqHnilhf9ZrEihDON2qOgkZeCDlplC4wxBrEyWtuL4R74RVP81tU64j
         98p+fE6iojbBHpl6eEbJ5RfIbP/ZWRWoYGDkux6Xp5vpqm9NQrygNPsTOtoc5nO0aNbd
         EgeA==
X-Gm-Message-State: AOAM5337q9Aqhr+mUqh8HoIQYZqNNZ1l2uqhb7fPc4OYnemANe66Dhqz
        2kunvrkG48k46H6s2RSJGw==
X-Google-Smtp-Source: ABdhPJx4fv59SMJ3mS2tApSIBDtdSxl4R1aVARuaCzbZSIcb/ZiZYaKPCzzHJT84CfHLcSwsclyD9Q==
X-Received: by 2002:a92:a04e:: with SMTP id b14mr5301547ilm.261.1594914367140;
        Thu, 16 Jul 2020 08:46:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w16sm3209593iom.27.2020.07.16.08.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:46:06 -0700 (PDT)
Received: (nullmailer pid 2403961 invoked by uid 1000);
        Thu, 16 Jul 2020 15:46:04 -0000
Date:   Thu, 16 Jul 2020 09:46:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     simon@arlott.org, jonas.gorski@gmail.com, kishon@ti.com,
        vkoul@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        krzk@kernel.org, gregkh@linuxfoundation.org, alcooperx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: add bcm63xx-usbh bindings
Message-ID: <20200716154604.GA2370346@bogus>
References: <20200715131803.1762064-1-noltari@gmail.com>
 <20200715131803.1762064-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715131803.1762064-2-noltari@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:18:02PM +0200, Álvaro Fernández Rojas wrote:
> Document BCM63xx USBH PHY bindings.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  v6: introduce changes suggested by Rob:
>   - Add another if case to device tree binding for SoCs with just 1 clock.
>   - Ignored "additionalProperties: false" suggestion since it triggers a
>     warning. This has been reported, but I haven't received any answer yet.

Ask your question here or I have to go look for it...

Looks like it is for 'clocks' though. The main schema has to define all 
the properties for 'additionalProperties: false'. More below...

>  v5: no changes.
>  v4: conditionally require 1/2 clocks and fix clock/reset values.
>  v3: no changes.
>  v2: phy-cells changed to 1.
> 
>  .../bindings/phy/brcm,bcm63xx-usbh-phy.yaml   | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> new file mode 100644
> index 000000000000..8ab0ab3154ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
> @@ -0,0 +1,97 @@
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
> +  resets:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - resets
> +  - "#phy-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - brcm,bcm6328-usbh-phy
> +            - brcm,bcm6358-usbh-phy
> +            - brcm,bcm6362-usbh-phy
> +            - brcm,bcm6368-usbh-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          items:
> +            - const: usbh

With the below changes, this can be:

then:
  properties:
    clocks:
      maxItems: 1
    clock-names:
      maxItems: 1
else:
  properties:
    clocks:
      minItems: 2
    clock-names:
      minItems: 2

> +      required:
> +        - clocks
> +        - clock-names

Looks like these are always required and can be at the top level.

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
> +        clock-names:
> +          items:
> +            - const: usbh
> +            - const: usb_ref

Move this to the main schema with {minItems: 1, maxItems: 2} for both.

> +      required:
> +        - clocks
> +        - clock-names
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

This can be in the main section.

> +      required:
> +        - power-domains

And then add to disallow power-domains:

else:
  properties:
    power-domains: false

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

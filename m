Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E10C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590706674;
	bh=U2n2x8JskdLoMluaOBdc7jVBri+3a93Wp0TsEvP5lAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EmSv+QTQzB6xyoVAnS0AbApTHTRqFMMMGNCneoAD+LTD+WwksRHTmJqRKK0dGIq4H
	 hA097ZukfxFyhA/EIZcCVUDDQsy2iy+5fMM6n8psOtj37VxEiaESuiMCeLcvXZc89s
	 TEg4P32zBm82r0fHGYpQxhhwr2NawWFEgULsEsDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437371AbgE1W5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:57:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45727 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437266AbgE1W5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:57:51 -0400
Received: by mail-io1-f65.google.com with SMTP id y5so284533iob.12;
        Thu, 28 May 2020 15:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4A67w1UWrqcRvidWlMOv3lJRuAexfTn44t8+Gt+Mvw=;
        b=QT3GzN3PzhMnUGX0zHXDKnR7H66FB1n4up1Kt3RUgaUkJKa5XUFGWAtpBN4x5wu72p
         dyGr8796AhOnOgJlROocG+gOxGKHWOeiTn9UZ9pYw0uRluKkipBM1PKIjNeqOYBzTCJ/
         vim1Hl7d7sI7/5E/jr2rrr3VMC9/7oVpUI8QM1OREEe/tmmkcXqbvDS3WX7N2C5vB62M
         z2nldpXkE3CFSIZc+Xjvq1eJLQ3b3p8WgprUl96mYa8jKzYS9tMW6C7nINEEKcz7uUEO
         ZsPsu5HMA/LYv6MgVVbmu0en0GrcucCSo3Z5AXjo/2R9Pd0BGNu6o31L01KXwcFXz+MB
         HAQQ==
X-Gm-Message-State: AOAM532lvRUKx20tFftP3HkwjSz1iYi01tOpVz77ZwwM2m16Y0W/Wvex
        dV3Sb8aXrk6MkGtYDDL02g==
X-Google-Smtp-Source: ABdhPJx6c5l7FsTPgjtXHegskhHp+62+vfCSYFInsfYA747A6V9kogbZxZQTlFTCLxnSzMDWjHCSPA==
X-Received: by 2002:a02:a99a:: with SMTP id q26mr4581344jam.61.1590706668793;
        Thu, 28 May 2020 15:57:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j2sm3060713ioo.8.2020.05.28.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 15:57:48 -0700 (PDT)
Received: (nullmailer pid 834510 invoked by uid 1000);
        Thu, 28 May 2020 22:57:47 -0000
Date:   Thu, 28 May 2020 16:57:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] dt-bindings: i2c: Convert i2c-pxa to json-schema
Message-ID: <20200528225747.GA830663@bogus>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
 <20200521091356.2211020-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091356.2211020-4-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:13:50AM +0200, Lubomir Rintel wrote:
> A conversion of the i2c-pxa binding to DT schema format using json-schema.
> 
> This also cleans ups some errors in the binding: The compatible string
> description suggested that "mmp" in "mrvl,mmp-twsi" is to be substituted
> with a processor model, which wouldn't be a right thing to do and indeed
> nobody seems to have been doing that. There also was "Recommended
> properties" section that included optional as well as mandatory
> properties. Missing mandatory properties were added to the example.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Add default GPL-2.0-only license tag
> - Fill in maintainers from MAINTAINERS file
> 
>  .../devicetree/bindings/i2c/i2c-pxa.txt       | 31 --------
>  .../devicetree/bindings/i2c/i2c-pxa.yaml      | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> deleted file mode 100644
> index c30783c0eca0..000000000000
> --- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* Marvell MMP I2C controller
> -
> -Required properties :
> -
> - - reg : Offset and length of the register set for the device
> - - compatible : should be "mrvl,mmp-twsi" where mmp is the name of a
> -   compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
> -   For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
> -   as shown in the example below.
> -   For the Armada 3700, the compatible should be "marvell,armada-3700-i2c".
> -
> -Recommended properties :
> -
> - - interrupts : the interrupt number
> - - mrvl,i2c-polling : Disable interrupt of i2c controller. Polling
> -   status register of i2c controller instead.
> - - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
> -
> -Examples:
> -	twsi1: i2c@d4011000 {
> -		compatible = "mrvl,mmp-twsi";
> -		reg = <0xd4011000 0x1000>;
> -		interrupts = <7>;
> -		mrvl,i2c-fast-mode;
> -	};
> -	
> -	twsi2: i2c@d4025000 {
> -		compatible = "mrvl,mmp-twsi";
> -		reg = <0xd4025000 0x1000>;
> -		interrupts = <58>;
> -	};
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml b/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
> new file mode 100644
> index 000000000000..19c81972243d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/i2c-pxa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MMP I2C controller bindings
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
> +  - if:
> +      not:
> +        required:
> +          - mrvl,i2c-polling
> +    then:
> +        required:
> +          - interrupts
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mrvl,mmp-twsi
> +      - mrvl,pxa-i2c
> +      - marvell,armada-3700-i2c
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    minItems: 1
> +
> +  mrvl,i2c-polling:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Disable interrupt of i2c controller. Polling status register of i2c
> +      controller instead.
> +
> +  mrvl,i2c-fast-mode:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Enable fast mode of i2c controller.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#address-cells'
> +  - '#size-cells'

Add: 

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/marvell,mmp2.h>
> +    i2c@d4011000 {
> +        compatible = "mrvl,mmp-twsi";
> +        reg = <0xd4011000 0x1000>;
> +        interrupts = <7>;
> +        clocks = <&soc_clocks MMP2_CLK_TWSI1>;
> +        mrvl,i2c-fast-mode;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };
> +
> +...
> -- 
> 2.26.2
> 

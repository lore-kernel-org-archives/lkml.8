Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8C6C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ECF24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579648575;
	bh=ayi0AQkHboqVmNH7AQabmgfP8IUvSerrd/s8Dg6irxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wt/3S+WRkI521gQUI18gmMvkD134gQSvEeKn/URW4ILNZk9N8WEsvQnHO8QbI7+PA
	 YfqfjIXS96E+VY3p/Dt0ncxa+WhW1Ols6x+GCbX54rD27mrmGhclJW85+jix7C+58l
	 l5fYOnES1bylElFp7UBoJDWbS4+iv4qfx0T1WA58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAUXQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:16:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38780 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAUXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:16:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so4616672oth.5;
        Tue, 21 Jan 2020 15:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/onuDQImRyHyeU+wg0RFJ08EsMO/XYMDEqGXXxAGX/0=;
        b=HJxAsjy0AgIAYJKRPoKyRiz9QTJqm+jX7vWKnFqkTzekhjLSAEsu0N/aK9t8nMjuxe
         jgyzcjxFw8uZDaQyynFG4H/8b7MkFal561CmRJxLF645yGkgYPSIdvkb3xEvW7mo2ORC
         Iol7yMt1mIs7XRxvMx2FabtejDyqrZgxcirnQh7y0BrJo2/nZYlD1S9YNWSMd4xAdDLH
         dmwggtX0yIStHzvb91iTdEo9ZF6iNsdLMmI6lvwrdteuB6Kw9pu4oBJlZno4DpYxgLWA
         3y6spyil3ChjtqQ1W+4TsbF4gurZ3UoE8RYZ+ItkBDG2jKeGBcZyEiHfeiuGTTKxtRYQ
         8/Bg==
X-Gm-Message-State: APjAAAV3S6h9PLpPSiWmlhzG8etOEAotHOYJdxF9mXeluLQBIGRqC4jk
        /gYEzx1LrcabZ/2UusRTVg==
X-Google-Smtp-Source: APXvYqxOlNxNPRDh0FtKVnyQTJJgPAUPOTjgcHJlh3jVqJyPvy6CPuylJEEv98kBW1xxBPmh2ODgOA==
X-Received: by 2002:a05:6830:1442:: with SMTP id w2mr5512997otp.143.1579648573545;
        Tue, 21 Jan 2020 15:16:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r23sm12462343oij.38.2020.01.21.15.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 15:16:12 -0800 (PST)
Received: (nullmailer pid 21706 invoked by uid 1000);
        Tue, 21 Jan 2020 23:16:11 -0000
Date:   Tue, 21 Jan 2020 17:16:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: usb: Convert jz4740-musb doc to YAML
Message-ID: <20200121231611.GA19164@bogus>
References: <20200115220008.91445-1-paul@crapouillou.net>
 <20200115220008.91445-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115220008.91445-2-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 07:00:04PM -0300, Paul Cercueil wrote:
> Convert ingenic,jz4740-musb.txt to ingenic,musb.yaml, and add the
> new ingenic,jz4770-musb compatible string in the process.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../bindings/usb/ingenic,jz4740-musb.txt      | 32 ---------
>  .../devicetree/bindings/usb/ingenic,musb.yaml | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ingenic,musb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
> deleted file mode 100644
> index 16808721f3ff..000000000000
> --- a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -Ingenic JZ4740 MUSB driver
> -
> -Required properties:
> -
> -- compatible: Must be "ingenic,jz4740-musb"
> -- reg: Address range of the UDC register set
> -- interrupts: IRQ number related to the UDC hardware
> -- interrupt-names: must be "mc"
> -- clocks: phandle to the "udc" clock
> -- clock-names: must be "udc"
> -- phys: phandle to the USB PHY
> -
> -Example:
> -
> -usb_phy: usb-phy@0 {
> -	compatible = "usb-nop-xceiv";
> -	#phy-cells = <0>;
> -};
> -
> -udc: usb@13040000 {
> -	compatible = "ingenic,jz4740-musb";
> -	reg = <0x13040000 0x10000>;
> -
> -	interrupt-parent = <&intc>;
> -	interrupts = <24>;
> -	interrupt-names = "mc";
> -
> -	clocks = <&cgu JZ4740_CLK_UDC>;
> -	clock-names = "udc";
> -
> -	phys = <&usb_phy>;
> -};
> diff --git a/Documentation/devicetree/bindings/usb/ingenic,musb.yaml b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
> new file mode 100644
> index 000000000000..f8902ee83e56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ingenic,musb.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ingenic,musb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic JZ47xx USB IP DT bindings
> +
> +maintainers:
> +  - Paul Cercueil <paul@crapouillou.net>
> +
> +properties:
> +  $nodename:
> +    pattern: '^usb@.*'
> +
> +  compatible:
> +    oneOf:
> +      - const: ingenic,jz4770-musb
> +      - const: ingenic,jz4740-musb

'enum' is preferred over a oneOf + const.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: udc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: mc
> +
> +  phys:
> +    description: PHY specifier for the USB PHY
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - phys
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/jz4740-cgu.h>
> +    usb_phy: usb-phy@0 {
> +      compatible = "usb-nop-xceiv";
> +      #phy-cells = <0>;
> +    };
> +
> +    udc: usb@13040000 {
> +      compatible = "ingenic,jz4740-musb";
> +      reg = <0x13040000 0x10000>;
> +
> +      interrupt-parent = <&intc>;
> +      interrupts = <24>;
> +      interrupt-names = "mc";
> +
> +      clocks = <&cgu JZ4740_CLK_UDC>;
> +      clock-names = "udc";
> +
> +      phys = <&usb_phy>;
> +    };
> -- 
> 2.24.1
> 

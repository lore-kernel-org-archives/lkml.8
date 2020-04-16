Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B1FC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4A3214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587049833;
	bh=rW0Bvw3mt3oRNulNWXsyEx1/+k3RkTc+dWy1wdwu6Qo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=USWK1ouLuhHsxkBbS70WUKy6KS/i1FqrdakYF+x44Ft67F6EUQu37qh3nIZEl0MsO
	 W+bifVQAPaBOnhxXryobhr5HqZryPVB3uR+xD/S0qqPki3k3xnHTv3KD0lSwbi/WAx
	 WWFD7BEZ8G+y4kVRim2Vl/LPMH7EAJKCitRhr/bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbgDPPKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:10:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394992AbgDPPJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:09:58 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB00D2222D;
        Thu, 16 Apr 2020 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587049797;
        bh=rW0Bvw3mt3oRNulNWXsyEx1/+k3RkTc+dWy1wdwu6Qo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hthOJdnrcdqI6mMre4jfYWe1srm1RKsINoBdel8L88TL63UL7K3qE/bZotnPScbWn
         HnOsPRTdKvhFS3sZg8Sa8cW+uDQcJnHjZ4cu3wQmtZy+UaGdKzJLq4jI/KslkaVkje
         ij4rmuwpBU4Da7u/hi//x2ybpLVxv4RFng/klKNI=
Received: by mail-qk1-f173.google.com with SMTP id x66so21581571qkd.9;
        Thu, 16 Apr 2020 08:09:56 -0700 (PDT)
X-Gm-Message-State: AGi0Pubq0O+1yFrA+WFAG7vEprpuqX1QRtwDhoXYHmI0NYZZuR1tIptP
        ccrWjrvJr34JPC2FJhoEnNiMG4WUx3s4TYKr6w==
X-Google-Smtp-Source: APiQypJ+bjQ0KgyMuk0uvkjJanAnJ0Z7kTZhk7t7vqPo6scnZ7torJnyQYrZi5/0Y+NTz2ZfLoR+oJzvFDzDKWw5KXQ=
X-Received: by 2002:a37:7dc6:: with SMTP id y189mr33611422qkc.223.1587049796040;
 Thu, 16 Apr 2020 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200416125207.425271-1-adrian.ratiu@collabora.com>
In-Reply-To: <20200416125207.425271-1-adrian.ratiu@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Apr 2020 10:09:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLyEjXjeADvxztT0kg6Sc-VASUeBPr0jJAwS39PckQjpw@mail.gmail.com>
Message-ID: <CAL_JsqLyEjXjeADvxztT0kg6Sc-VASUeBPr0jJAwS39PckQjpw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: dw_mipi_dsi.txt: convert to yaml
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 7:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> This converts the Synopsis MIPI DSI binding documentation to yaml and
> should be quite straightforward. I've added a missing ref clk and also
> added Mark and Rob as maintainers based on 'get_maintainer.pl' results.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  .../bindings/display/bridge/dw_mipi_dsi.txt   | 32 ---------
>  .../display/bridge/snps,dw-mipi-dsi.yaml      | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> deleted file mode 100644
> index b13adf30b8d3..000000000000
> --- a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -Synopsys DesignWare MIPI DSI host controller
> -============================================
> -
> -This document defines device tree properties for the Synopsys DesignWare MIPI
> -DSI host controller. It doesn't constitue a device tree binding specification
> -by itself but is meant to be referenced by platform-specific device tree
> -bindings.
> -
> -When referenced from platform device tree bindings the properties defined in
> -this document are defined as follows. The platform device tree bindings are
> -responsible for defining whether each optional property is used or not.
> -
> -- reg: Memory mapped base address and length of the DesignWare MIPI DSI
> -  host controller registers. (mandatory)
> -
> -- clocks: References to all the clocks specified in the clock-names property
> -  as specified in [1]. (mandatory)
> -
> -- clock-names:
> -  - "pclk" is the peripheral clock for either AHB and APB. (mandatory)
> -  - "px_clk" is the pixel clock for the DPI/RGB input. (optional)
> -
> -- resets: References to all the resets specified in the reset-names property
> -  as specified in [2]. (optional)
> -
> -- reset-names: string reset name, must be "apb" if used. (optional)
> -
> -- panel or bridge node: see [3]. (mandatory)
> -
> -[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> -[2] Documentation/devicetree/bindings/reset/reset.txt
> -[3] Documentation/devicetree/bindings/display/mipi-dsi-bus.txt
> diff --git a/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
> new file mode 100644
> index 000000000000..0ab4125eee30
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/snps,dw-mipi-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare MIPI DSI host controller
> +
> +maintainers:
> +  - Rob Herring <robh+dt@kernel.org>

No thanks, I don't know anything about this hardware. It should be the
owner for this binding, not who applies patches.

> +  - Mark Rutland <mark.rutland@arm.com>

Check current maintainers. Mark is not one anymore.

> +
> +description: |
> +  This document defines device tree properties for the Synopsys DesignWare MIPI
> +  DSI host controller. It doesn't constitue a device tree binding specification
> +  by itself but is meant to be referenced by platform-specific device tree
> +  bindings.
> +
> +  When referenced from platform device tree bindings the properties defined in
> +  this document are defined as follows. The platform device tree bindings are
> +  responsible for defining whether each property is required or optional.
> +

Need to reference ($ref) dsi-controller.yaml here.

> +properties:
> +  reg:
> +    description: |
> +      Memory mapped base address and length of the DesignWare MIPI DSI host
> +      controller registers.

Drop the description. That's every 'reg'. You need to say how many
regions (maxItems: 1?).

> +
> +  clocks:
> +    description: |
> +      References to all the clocks specified in the clock-names property as
> +      specified in Documentation/devicetree/bindings/clock/clock-bindings.txt

Drop

> +    items:
> +      - description: Module clock
> +      - description: DSI bus colck for either AHB and APB

typo

> +      - description: Pixel clock for the DPI/RGB input
> +    minItems: 2
> +    maxItems: 3

You can drop 'maxItems'. It's implied by the length of 'items'.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: pclk
> +      - const: px_clk
> +    minItems: 2
> +    maxItems: 3
> +
> +  resets:
> +    description: |
> +      References to all the resets specified in the reset-names property as
> +      specified in Documentation/devicetree/bindings/reset/reset.txt

Drop.

You need maxItems to define how many reset entries.

> +
> +  reset-names:
> +    const: apb
> +
> +patternProperties:
> +  "^panel@[0-3]$":
> +    type: object
> +    description: |
> +      A node containing the panel or bridge description as documented in

bridge? But the node name says panel only.

> +      Documentation/devicetree/bindings/display/mipi-dsi-bus.txt

Drop description.

> +
> +required:
> +  - reg
> +  - clocks
> +  - clock-names
> --
> 2.26.0
>

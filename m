Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F299C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA1B2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D2sXE9yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgDVBLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgDVBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:11:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B28BC0610D5;
        Tue, 21 Apr 2020 18:11:51 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90A24528;
        Wed, 22 Apr 2020 03:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1587517909;
        bh=JttfiURhrIhVwSVufhA9ryuXfJIG3R4ryYcC3Ir96HU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2sXE9yCZ0iY3aB6GQ2crR2lHriVzkBs1ATtZFAyXdVX6dyyGq9ibhhNqn9eYQ1cE
         uw7Jug73O0bv5f2gxT6ifTLbclhqFsys5nrzaVjsmCiMLzaZg3aUeYe5LMf6IdPCrU
         m1LyltkPtBTCjX0pGYA6BGkh5GR2YcMcTA7G+eP0=
Date:   Wed, 22 Apr 2020 04:11:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh@kernel.org>,
        Philippe CORNU <philippe.cornu@st.com>
Subject: Re: [PATCH v2] dt-bindings: display: dw_mipi_dsi.txt: convert to yaml
Message-ID: <20200422011136.GN5983@pendragon.ideasonboard.com>
References: <20200421105814.1364900-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421105814.1364900-1-adrian.ratiu@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thank you for the patch.

On Tue, Apr 21, 2020 at 01:58:14PM +0300, Adrian Ratiu wrote:
> This converts the Synopsis MIPI DSI binding documentation to yaml and
> should be quite straightforward. I've added a missing ref clk and also
> added Philippe as maintainer b/c he's the original txt author following
> the algorithm provided in Message-ID 20200420175909.GA5810@ravnborg.org.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Philippe CORNU <philippe.cornu@st.com>
> Cc: devicetree@vger.kernel.org
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes in v2:
>   - Removed unnecessary descriptions and maxItems (Rob)
>   - Changed maintainers entry / dropped Mark (Rob)
>   - Added dsi-controller.yaml ref (Rob)
> ---
>  .../bindings/display/bridge/dw_mipi_dsi.txt   | 32 -----------
>  .../display/bridge/snps,dw-mipi-dsi.yaml      | 56 +++++++++++++++++++
>  2 files changed, 56 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt b/Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt
> deleted file mode 100644
> index b13adf30b8d3b..0000000000000
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
> index 0000000000000..d9ab464f79ff4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/snps,dw-mipi-dsi.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/snps,dw-mipi-dsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare MIPI DSI host controller
> +
> +maintainers:
> +  - Philippe CORNU <philippe.cornu@st.com>
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
> +allOf:
> +  - $ref: ../dsi-controller.yaml#
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Module clock
> +      - description: DSI bus clock for either AHB and APB
> +      - description: Pixel clock for the DPI/RGB input
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: pclk
> +      - const: px_clk
> +    minItems: 2
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: apb

I think you can also add the ports property and its child port@0 and
port@1, as they're required in all cases.

> +
> +patternProperties:
> +  "^panel@[0-3]$":
> +    type: object
> +
> +required:
> +  - reg
> +  - clocks
> +  - clock-names

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70362C33CB0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468C3222C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578938360;
	bh=BvVwQDaXG7nwaYX7s05ct6eQ4sajxiQAfTIqBPjSazQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z+Nk+Y5/cFccjqxG3EF0eAeXbWZtQuB270z8x9Dn3cHnZkMZsma+IjCfYs+kz9pt2
	 29rypwpGHy/ZIZMuQ4I7wWOFNs4s4v3JAarBk2Om1dDyP5f9msBRvSbN7NRzE1oB9u
	 EDGmMnwjk7wpDSXDMo+K7M/qkeDNFzcRWtYOZPhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMR7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:59:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgAMR7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 12:59:19 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9A321744;
        Mon, 13 Jan 2020 17:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578938358;
        bh=BvVwQDaXG7nwaYX7s05ct6eQ4sajxiQAfTIqBPjSazQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TVamThhNpcOiouQ5EIgoTET4yaCryoc6Pao2h9UlS71C5yf1A+vYIZtyeIHNbHr+i
         ta/vR8+ga5cMTvxvM+Vg6JP5QpDwFZXGzXLuGw/l/e7ogDwkhmE1FFxF24YFj53zkO
         9HWJvIe5Sm2rqowNSujmvVhaRUa7DB6yBtPOGR+0=
Received: by mail-qv1-f45.google.com with SMTP id p2so4396027qvo.10;
        Mon, 13 Jan 2020 09:59:18 -0800 (PST)
X-Gm-Message-State: APjAAAX1Rejcsrk1NRhudNDHzKFlmqdItSqifz6Byu2MM8dKGjqkOrAR
        WlOG+g68eKci8saDzeFBwocSOdjIogIwSA7kww==
X-Google-Smtp-Source: APXvYqxkC/xxiGwV4y31SedhMvlakVHw6kIvrXmJKJotUeMzr4RJqQNYzfbp6MAF0rK3ARaJW3fvP0OPAZP7qCIIIFg=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr15796764qvu.136.1578938357304;
 Mon, 13 Jan 2020 09:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20191216095712.13266-14-kishon@ti.com> <20200102095631.1165-1-kishon@ti.com>
In-Reply-To: <20200102095631.1165-1-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Jan 2020 11:59:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJVmyXirczaWJb4hCsnVjXYt6ki22sBLe5D0240x4Xtzw@mail.gmail.com>
Message-ID: <CAL_JsqJVmyXirczaWJb4hCsnVjXYt6ki22sBLe5D0240x4Xtzw@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 3:54 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Add DT binding documentation for WIZ (SERDES wrapper). WIZ is *NOT* a
> PHY but a wrapper used to configure some of the input signals to the
> SERDES. It is used with both Sierra(16G) and Torrent(10G) serdes.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [jsarha@ti.com: Add separate compatible for Sierra(16G) and Torrent(10G)
>  SERDES]
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
> Changes from v4:
> *) Fixed the indentation as suggested by Rob v4
>
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 204 ++++++++++++++++++
>  1 file changed, 204 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> new file mode 100644
> index 000000000000..e010ea46b88d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
> @@ -0,0 +1,204 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI J721E WIZ (SERDES Wrapper)
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,j721e-wiz-16g
> +      - ti,j721e-wiz-10g
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +    description: clock-specifier to represent input to the WIZ
> +
> +  clock-names:
> +    items:
> +      - const: fck
> +      - const: core_ref_clk
> +      - const: ext_ref_clk
> +
> +  num-lanes:
> +    minimum: 1
> +    maximum: 4
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  assigned-clocks:
> +    maxItems: 2
> +
> +  assigned-clock-parents:
> +    maxItems: 2
> +
> +patternProperties:
> +  "^pll[0|1]-refclk$":
> +    type: object
> +    description: |
> +      WIZ node should have subnodes for each of the PLLs present in
> +      the SERDES.
> +    properties:
> +      clocks:
> +        maxItems: 2
> +        description: Phandle to clock nodes representing the two inputs to PLL.
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +      - assigned-clocks
> +      - assigned-clock-parents
> +
> +  "^cmn-refclk1?-dig-div$":
> +    type: object
> +    description:
> +      WIZ node should have subnodes for each of the PMA common refclock
> +      provided by the SERDES.
> +    properties:
> +      clocks:
> +        maxItems: 1
> +        description: Phandle to the clock node representing the input to the
> +          divider clock.
> +
> +      "#clock-cells":
> +        const: 0
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +
> +  "^refclk-dig$":
> +    type: object
> +    description: |
> +      WIZ node should have subnode for refclk_dig to select the reference
> +      clock source for the reference clock used in the PHY and PMA digital
> +      logic.
> +    properties:
> +      clocks:
> +        maxItems: 4
> +        description: Phandle to four clock nodes representing the inputs to
> +          refclk_dig
> +
> +      "#clock-cells":
> +        const: 0
> +
> +      assigned-clocks:
> +        maxItems: 1
> +
> +      assigned-clock-parents:
> +        maxItems: 1
> +
> +    required:
> +      - clocks
> +      - "#clock-cells"
> +      - assigned-clocks
> +      - assigned-clock-parents
> +
> +  "^serdes@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      WIZ node should have '1' subnode for the SERDES. It could be either
> +      Sierra SERDES or Torrent SERDES. Sierra SERDES should follow the
> +      bindings specified in
> +      Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> +      Torrent SERDES should follow the bindings specified in
> +      Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> +
> +required:
> +  - compatible
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - num-lanes
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#reset-cells"
> +  - ranges
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    wiz@5000000 {
> +           compatible = "ti,j721e-wiz-16g";
> +           #address-cells = <1>;
> +           #size-cells = <1>;
> +           power-domains = <&k3_pds 292 TI_SCI_PD_EXCLUSIVE>;
> +           clocks = <&k3_clks 292 5>, <&k3_clks 292 11>, <&dummy_cmn_refclk>;
> +           clock-names = "fck", "core_ref_clk", "ext_ref_clk";
> +           assigned-clocks = <&k3_clks 292 11>, <&k3_clks 292 0>;
> +           assigned-clock-parents = <&k3_clks 292 15>, <&k3_clks 292 4>;
> +           num-lanes = <2>;
> +           #reset-cells = <1>;
> +           ranges = <0x5000000 0x0 0x5000000 0x10000>;

This fails in linux-next:

Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.example.dts:30.16-59:
Warning (ranges_format): /example-0/wiz@50
00000:ranges: "ranges" property has invalid length (16 bytes) (parent
#address-cells == 1, child #address-cells == 1, #
size-cells == 1)

Please fix.

Rob

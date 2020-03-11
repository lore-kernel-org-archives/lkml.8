Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7761C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DFD2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583956401;
	bh=tdw1K1yZNkMlalSB2DrIpOQZ4ZujojveOndEdIh1POE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DXgogMqZhQCIEdPRXWxZtQ/Wbp6E6suf0vfEglEm16b0y3sQz4iwIsXpWSz/pdH+a
	 oT7HuGPxp2cf26bi1+vO9cTJhJhF4jXrY7Z5Y01Ies4h4ZGmVRXJa+dXGHo28aZH0r
	 oerns3QttbqTYuR6FlED/9svA4av3635ZkbXhSuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgCKTxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbgCKTxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:53:19 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D008C20738;
        Wed, 11 Mar 2020 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583956399;
        bh=tdw1K1yZNkMlalSB2DrIpOQZ4ZujojveOndEdIh1POE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mjp6ttGth2utmaXT57xPBZagIByGCbPpqqz+SQJ9Nuj4p33UyxfReRVBEu5glEa6e
         1+NviPHVfW6ruFOVdVCpBG/OuOlWbsNRRwVnIJm8xNtdAGDHjiZTgvOO+JXn7BRNSP
         dWslNT+B1zX/wTNv/N0TZ3Ty1l6/YnEplWO2QP30=
Received: by mail-qk1-f178.google.com with SMTP id f3so3384153qkh.1;
        Wed, 11 Mar 2020 12:53:17 -0700 (PDT)
X-Gm-Message-State: ANhLgQ19Qv59L+JezdnKvEntKNcwgFkFwo9t2gpV+x5Hk6Q29pIDajtk
        cqrHKhQCZbzXPUry7s+6v1bnfunZxu6v9N9udQ==
X-Google-Smtp-Source: ADFU+vucVpbYPdluXnU/rbjyy9j5DWdSrdu9Uo5rswhWT4MR6C36BDlqrvkEqWEYhW37ivNZ71WxhDQlWTYiNiRtkfg=
X-Received: by 2002:a37:2cc6:: with SMTP id s189mr4492038qkh.223.1583956396701;
 Wed, 11 Mar 2020 12:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com> <1580969461-16981-3-git-send-email-yamonkar@cadence.com>
In-Reply-To: <1580969461-16981-3-git-send-email-yamonkar@cadence.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 11 Mar 2020 14:53:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKRjJEJCr51HW178JSDmwEGMwfN-eHKDRkb482bQ2yALg@mail.gmail.com>
Message-ID: <CAL_JsqKRjJEJCr51HW178JSDmwEGMwfN-eHKDRkb482bQ2yALg@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] dt-bindings: phy: Add Cadence MHDP PHY bindings
 in YAML format.
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 12:11 AM Yuti Amonkar <yamonkar@cadence.com> wrote:
>
> - Add Cadence MHDP PHY bindings in YAML format.
> - Add Torrent PHY reference clock bindings.
> - Add sub-node bindings for each group of PHY lanes based on PHY type.
>   Each sub-node includes properties such as master lane number, link reset,
>   phy type, number of lanes etc.
> - Add reset support including PHY reset and individual lane reset.
> - Add a new compatible string used for TI SoCs using Torrent PHY.
> This will not affect ABI as the driver has never been functional,
> and therefore do not exist in any active use case.
>
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
>
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> new file mode 100644
> index 000000000000..9f94be1dce6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence Torrent SD0801 PHY binding for DisplayPort
> +
> +description:
> +  This binding describes the Cadence SD0801 PHY (also known as Torrent PHY)
> +  hardware included with the Cadence MHDP DisplayPort controller.
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,torrent-phy
> +      - ti,j721e-serdes-10g
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      PHY reference clock. Must contain an entry in clock-names.
> +
> +  clock-names:
> +    const: refclk
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: Offset of the Torrent PHY configuration registers.
> +      - description: Offset of the DPTX PHY configuration registers.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: torrent_phy
> +      - const: dptx_phy
> +
> +  resets:
> +    maxItems: 1
> +    description:
> +      Torrent PHY reset.
> +      See Documentation/devicetree/bindings/reset/reset.txt
> +
> +patternProperties:
> +  '^phy@[0-7]+$':
> +    type: object
> +    description:
> +      Each group of PHY lanes with a single master lane should be represented as a sub-node.
> +    properties:
> +      reg:
> +        description:
> +          The master lane number. This is the lowest numbered lane in the lane group.
> +
> +      resets:
> +        minItems: 1
> +        maxItems: 4
> +        description:
> +          Contains list of resets, one per lane, to get all the link lanes out of reset.
> +
> +      "#phy-cells":
> +        const: 0
> +
> +      cdns,phy-type:
> +        description:
> +          Specifies the type of PHY for which the group of PHY lanes is used.
> +          Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [1, 2, 3, 4, 5, 6]
> +
> +      cdns,num-lanes:
> +        description:
> +          Number of DisplayPort lanes.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [1, 2, 4]
> +        default: 4
> +
> +      cdns,max-bit-rate:
> +        description:
> +          Maximum DisplayPort link bit rate to use, in Mbps
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32
> +          - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
> +        default: 8100
> +
> +    required:
> +      - reg
> +      - resets
> +      - "#phy-cells"
> +      - cdns,phy-type
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - reg
> +  - reg-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/phy/phy.h>
> +    torrent_phy: phy@f0fb500000 {

The example still fails, now in linux-next:

Documentation/devicetree/bindings/phy/phy-cadence-torrent.example.dt.yaml:
phy@f0fb500000: '#phy-cells' is a required property

This is because of the node name 'phy' and this node is not a phy
provider (the child nodes are). Just use 'torrent-phy@...' here.

> +          compatible = "cdns,torrent-phy";
> +          reg = <0xf0 0xfb500000 0x0 0x00100000>,
> +                <0xf0 0xfb030a00 0x0 0x00000040>;
> +          reg-names = "torrent_phy", "dptx_phy";
> +          resets = <&phyrst 0>;
> +          clocks = <&ref_clk>;
> +          clock-names = "refclk";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          torrent_phy_dp: phy@0 {
> +                    reg = <0>;
> +                    resets = <&phyrst 1>, <&phyrst 2>,
> +                             <&phyrst 3>, <&phyrst 4>;
> +                    #phy-cells = <0>;
> +                    cdns,phy-type = <PHY_TYPE_DP>;
> +                    cdns,num-lanes = <4>;
> +                    cdns,max-bit-rate = <8100>;
> +          };
> +    };
> +...
> --
> 2.20.1
>

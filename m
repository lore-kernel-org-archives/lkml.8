Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62727C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B310207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgEKKPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:15:16 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:41358 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgEKKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:15:15 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5D1762001E;
        Mon, 11 May 2020 12:15:09 +0200 (CEST)
Date:   Mon, 11 May 2020 12:15:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     srk@48.io
Cc:     Andrzej Hajda <a.hajda@samsung.com>, Marek Vasut <marex@denx.de>,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Cross <xobs@kosagi.com>
Subject: Re: [PATCH 1/2] dt-bindings: it6251: add bindings for IT6251
 LVDS-to-eDP bridge
Message-ID: <20200511101508.GA7971@ravnborg.org>
References: <20200509111732.26102-1-srk@48.io>
 <20200509111732.26102-2-srk@48.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509111732.26102-2-srk@48.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=VwQbUJbxAAAA:8 a=YpGV6msqAAAA:8 a=e5mUnYsNAAAA:8
        a=gEfo2CItAAAA:8 a=_yH9q9Z6AjBviL3TOqQA:9 a=rbfOVJjzkGrPOjLs:21
        a=2oGGWDTR31z2Z5qq:21 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=7Sa5D-Tva0wx0rmpRu8Y:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=sptkURWiP4Gy88Gu7hUp:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard/Marek.

On Sat, May 09, 2020 at 01:17:31PM +0200, srk@48.io wrote:
> From: Marek Vasut <marex@denx.de>
> 
> Add DT bindings for ITE IT6251 LVDS-to-eDP bridge.

Looks good, just a few comments in the following.

	Sam
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Richard Marko <srk@48.io>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: devicetree@vger.kernel.org
> To: dri-devel@lists.freedesktop.org
> ---
>  .../bindings/display/bridge/ite,it6251.yaml   | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml
> new file mode 100644
> index 000000000000..8daa44a30fa1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6251.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/ite,it6251.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE IT6251 LVDS-to-eDP bridge bindings
> +
> +maintainers:
> +  - Marek Vasut <marex@denx.de>
> +  - Richard Marko <srk@48.io>
> +
> +description: |
> +  The IT6251 is a high-performance single-chip
> +  De-SSC LVDS to DisplayPort converter.
> +  Combined with LVDS receiver and DisplayPort Transmitter,
> +  the IT6251 supports LVDS input and DisplayPort 1.1a
> +  output by conversion function.
> +
> +properties:
> +  compatible:
> +    const: ite,it6251
> +
> +  reg:
> +    items:
> +      - description: I2C address of the bridge
> +      - description: I2C address of the LVDS part
> +
> +  reg-names:
> +    items:
> +      - const: bridge
> +      - const: lvds
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +      port@0:
> +        type: object
> +        description: |
> +         Video port for eDP output (typically panel).
port@0 is in most (all?) cases input today.
Take for example a look at: toshiba,tc358768.yaml
Could we do the same here?

> +
> +      port@1:
> +        type: object
> +        description: |
> +          Video port for LVDS input.
> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +    additionalProperties: false
> +
> +  power-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - power-supply
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
Add an extra level named "i2c" like we do in other bridge examples.
> +    it6251@5c {
My personal preference is 4 spaces for indent.
But 2 spaces is also fine.

> +      compatible = "ite,it6251";
> +      reg = <0x5c>, <0x5e>;
> +      reg-names = "bridge", "lvds";
> +      power-supply = <&reg_display>;
> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          bridge_out_edp0: endpoint {
> +            remote-endpoint = <&panel_in_edp0>;
> +          };
> +        };
> +
> +        port@1 {
> +          reg = <1>;
> +          bridge_in_lvds0: endpoint {
> +            remote-endpoint = <&lvds0_out>;
> +          };
> +        };
> +      };
> +    };

End with a line containing only "..."

This is an optional end-marker.
See lvds-codec.yaml for an example.

	Sam

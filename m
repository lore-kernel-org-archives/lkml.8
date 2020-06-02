Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD45C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA3520734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oB9Bh2Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFBXon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:44:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6FFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:44:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F35C52A4;
        Wed,  3 Jun 2020 01:44:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591141478;
        bh=0ojJhQ+5X0tRs/HVp41pNWAYkm+b2XP6CmfpaRpOLFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oB9Bh2UzB85GNEuF5w63S9wP8P5YAcCEe9txqwibAZuPp4H03fK/jnZJX2mby7zrq
         kPNfdyYlAWtwAmR282cd3qbaUIbNGgpDayWmngUgy9+GRvb/CFtL0lIDPFwpV5J09C
         xdNFBufSSNcU8AU0SCMeNDkNxPsIrvk1n4snIdyU=
Date:   Wed, 3 Jun 2020 02:44:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     sandor.yu@nxp.com
Cc:     a.hajda@samsung.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, heiko@sntech.de, hjc@rock-chips.com,
        dkos@cadence.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH 7/7] dt-bindings: display: Document Cadence MHDP HDMI/DP
 bindings
Message-ID: <20200602234422.GR6547@pendragon.ideasonboard.com>
References: <cover.1590982881.git.Sandor.yu@nxp.com>
 <9fa979f1099f7c02fd746f25002d8a652253d70f.1590982881.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fa979f1099f7c02fd746f25002d8a652253d70f.1590982881.git.Sandor.yu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandor,

Thank you for the patch.

On Mon, Jun 01, 2020 at 02:17:37PM +0800, sandor.yu@nxp.com wrote:
> From: Sandor Yu <Sandor.yu@nxp.com>
> 
> Document the bindings used for the Cadence MHDP HDMI/DP bridge.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml    | 46 +++++++++++++++
>  .../devicetree/bindings/display/imx/mhdp.yaml | 59 +++++++++++++++++++

Please split the patch in two.

>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/mhdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 000000000000..aa23feba744a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause))
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP TX Encoder
> +
> +maintainers:
> +  - Sandor Yu <Sandoryu@nxp.com>
> +
> +description: |
> +  Cadence MHDP Controller supports one or more of the protocols,
> +  such as HDMI and DisplayPort.
> +  Each protocol requires a different FW binaries.
> +
> +  This document defines device tree properties for the Cadence MHDP Encoder
> +  (CDNS MHDP TX). It doesn't constitue a device tree binding
> +  specification by itself but is meant to be referenced by platform-specific
> +  device tree bindings.
> +
> +  When referenced from platform device tree bindings the properties defined in
> +  this document are defined as follows. The platform device tree bindings are
> +  responsible for defining whether each property is required or optional.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +    description: Memory mapped base address and length of the MHDP TX registers.
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    - const: plug_in
> +      description: Hotplug detect interrupter for cable plugin event.
> +    - const: plug_out
> +      description: Hotplug detect interrupter for cable plugout event.

Does the IP core really have two different interrupt lines, one for
hot-plug and one for hot-unplug ? That's a very unusual design.

> +
> +  port:
> +    type: object
> +    description: |
> +      The connectivity of the MHDP TX with the rest of the system is
> +      expressed in using ports as specified in the device graph bindings defined
> +      in Documentation/devicetree/bindings/graph.txt. The numbering of the ports
> +      is platform-specific.
> diff --git a/Documentation/devicetree/bindings/display/imx/mhdp.yaml b/Documentation/devicetree/bindings/display/imx/mhdp.yaml
> new file mode 100644
> index 000000000000..17850cfd1cb1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/imx/mhdp.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/mhdp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP Encoder
> +
> +maintainers:
> +  - Sandor Yu <Sandoryu@nxp.com>
> +
> +description: |
> +  The MHDP transmitter is a Cadence HD Display TX controller IP
> +  with a companion PHY IP.
> +  The MHDP supports one or more of the protocols,
> +  such as HDMI(1.4 & 2.0), DisplayPort(1.2).
> +  switching between the two modes (HDMI and DisplayPort)
> +  requires reloading the appropriate FW

Does the IP core integrated in the imx8mp SoCs (as that is what this
binding targets) support both HDMI and DP ? If not this should be
reworded to be more specific to the SoC.

> +
> +  These DT bindings follow the Cadence MHDP TX bindings defined in
> +  Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml with the
> +  following device-specific properties.
> +
> +Properties:

Have you tried validating this with make dt_binding_check ? See
Documentation/devicetree/writing-schema.rst for more information.

> +  compatible:
> +    enum:
> +      - nxp,imx8mq-cdns-hdmi
> +      - nxp,imx8mq-cdns-dp
> +
> +  reg: See cdns,mhdp.yaml.

This isn't how bindings are referenced. You need to reference the parent
binding with $ref, either globally, or on an individual property basis.

> +
> +  interrupts: See cdns,mhdp.yaml.
> +
> +  interrupt-names: See cdns,mhdp.yaml.

That's it ? No clocks, no power domains, no resets, no PHYs (especially
given that you mention a PHY companion IP above) ?

> +
> +  ports: See cdns,mhdp.yaml.

This isn't correct. Please soo of-graph.txt. If can have either one port
node, or one ports node that contains one of more port subnodes. In this
case you need at least two ports, one for the input to the HDMI encoder,
and one for the HDMI output. The latter should be connected to a DT node
representing the HDMI connector. Yuo can search for "hdmi-connector" in
the .dts files in the kernel for plenty of examples.

> +
> +Required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - ports
> +
> +Example:
> +  - |
> +    mhdp: mhdp@32c00000 {
> +      compatible = "nxp,imx8mq-cdns-hdmi";
> +      reg = <0x32c00000 0x100000>;
> +      interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                   <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "plug_in", "plug_out";
> +
> +      ports {
> +        mhdp_in: endpoint {
> +          remote-endpoint = <&dcss_out>;
> +        };
> +      };
> +    };

-- 
Regards,

Laurent Pinchart

Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475A8C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ECE2051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584671725;
	bh=ilmHEwPWRPj4TcOpnxaJISvvNhZupHK136FrxxNG0T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=icIItbvFlFz26mfDySdIRU0u2UX3KjeTUlBzesb3Xsxt8smyTgnT0ZfaTMuAqE/7n
	 JCYqfCXY5z7Yepjlqq1zA6cIz2Rtw6oBGKzgK3Vh1oDfxLG2BjMn9lbu2I1zVGbjHJ
	 WueuzAkeih1hbPDzGOF5J9+Kd581f2jEGaL2VqZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCTCfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:35:24 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41678 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgCTCfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:35:24 -0400
Received: by mail-il1-f196.google.com with SMTP id l14so4252366ilj.8;
        Thu, 19 Mar 2020 19:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Sq6oKLWDfJ+N+DDKC8RQHWKWhsyZ667cL6sIzF8qaQ=;
        b=IawZQNN/uUQdqmFGqDjmWrYOSTAEejBpK4S5CsCvNgf0vZscPI1b7KqROlFsDBBFa9
         /HQmLq/IQrNIDBJOYRWTD3hN0s6NumpzHV4B0RFfuPN30iEjSSErZbQOCQ2rgtcec2mR
         dzYdYhtWJIPPRv6XEaQG5kQkInDp5wXgEAQnL1Ve+I4xOZAV//UbD6bQiUu0brE9pdo/
         PVvET+Ogp206fl3Xva71lRWMU+11ivL9N8IvofU2erf6UWu9QtMLZMxSILC1R3btgvV2
         GoRdnqM3rT4TBEkQb+bVn1Ys1FCaxo3SqrULaK1wOpzQdGI4CFoQJ/uVSm3XLxhYGb/L
         UDZQ==
X-Gm-Message-State: ANhLgQ076TRYQdeBaQGtRVZiPGYBxQDVjS6kbzPM0dgZgW4FRy53JfQk
        jHCk7kUMjkvIrA4liKsv8A==
X-Google-Smtp-Source: ADFU+vsVm+nifF98caUWQnSmDG2GKEgK2WvKO90v12PmyqZXcnTLBJgtj6xphBjSTbngRtG43Fwzbw==
X-Received: by 2002:a92:dc06:: with SMTP id t6mr6053887iln.89.1584671722918;
        Thu, 19 Mar 2020 19:35:22 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j23sm1339289ioa.10.2020.03.19.19.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:35:22 -0700 (PDT)
Received: (nullmailer pid 10779 invoked by uid 1000);
        Fri, 20 Mar 2020 02:35:20 -0000
Date:   Thu, 19 Mar 2020 20:35:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200320023520.GA18490@bogus>
References: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
 <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:32:50PM +0200, Laurent Pinchart wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> Processing System Gigabit Transceiver which provides PHY capabilities to
> USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v5:
> 
> - Document clocks and clock-names properties
> - Document resets and reset-names properties
> - Replace subnodes with an additional entry in the PHY cells
> - Drop lane frequency PHY cell, replaced by reference clock phandle
> - Convert bindings to YAML
> - Reword the subject line
> - Drop Rob's R-b as the bindings have significantly changed
> - Drop resets and reset-names properties
> ---
>  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 104 ++++++++++++++++++
>  include/dt-bindings/phy/phy.h                 |   1 +
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> new file mode 100644
> index 000000000000..9948e4a60e45
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: GPL-2.0

For new bindings:

(GPL-2.0-only OR BSD-2-Clause)

Though I guess Anurag needs to agree.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/xlnx,zynqmp-psgtr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx ZynqMP Gigabit Transceiver PHY Device Tree Bindings
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +
> +description: |
> +  This binding describes the Xilinx ZynqMP Gigabit Transceiver (GTR) PHY. The
> +  GTR provides four lanes and is used by USB, SATA, PCIE, Display port and
> +  Ethernet SGMII controllers.
> +
> +properties:
> +  "#phy-cells":
> +    const: 4
> +    description: |
> +      The cells contain the following arguments.
> +
> +      - description: The GTR lane
> +        minimum: 0
> +        maximum: 3
> +      - description: The PHY type
> +        enum:
> +          - PHY_TYPE_DP
> +          - PHY_TYPE_PCIE
> +          - PHY_TYPE_SATA
> +          - PHY_TYPE_SGMII
> +          - PHY_TYPE_USB
> +      - description: The PHY instance
> +        minimum: 0
> +        maximum: 1 # for DP, SATA or USB
> +        maximum: 3 # for PCIE or SGMII
> +      - description: The reference clock number
> +        minimum: 0
> +        maximum: 3

Humm, interesting almost json-schema. I guess it's fine as-is.

I would like to figure out how to apply a schema like this to the 
consumer nodes. We'd have to look up the phandle, get that node's 
compatible, find the provider's schema, find #.*-cells property, and 
extract a schema from it. Actually, doesn't sound too hard.

> +
> +  compatible:
> +    enum:
> +      - xlnx,zynqmp-psgtr-v1.1
> +      - xlnx,zynqmp-psgtr
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      Clock for each PS_MGTREFCLK[0-3] reference clock input. Unconnected
> +      inputs shall not have an entry.
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      pattern: "^ref[0-3]$"
> +
> +  reg:
> +    items:
> +      - description: SERDES registers block
> +      - description: SIOU registers block
> +
> +  reg-names:
> +    items:
> +      - const: serdes
> +      - const: siou
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +if:
> +  properties:
> +    compatible:
> +      const: xlnx,zynqmp-psgtr
> +
> +then:
> +  properties:
> +    xlnx,tx-termination-fix:
> +      description: |
> +        Include this for fixing functional issue with the TX termination
> +        resistance in GT, which can be out of spec for the XCZU9EG silicon
> +        version.
> +      type: boolean
> +
> +additionalProperties: false

This won't work with 'xlnx,tx-termination-fix'. You need to move it to 
the main properties section and then do:

if:
  properties:
    compatible:
      const: xlnx,zynqmp-psgtr-v1.1

then:
  properties:
    xlnx,tx-termination-fix: false

I think this would also work:

  not:
    required:
      - xlnx,tx-termination-fix
> +
> +examples:
> +  - |
> +    phy: phy@fd400000 {
> +      compatible = "xlnx,zynqmp-psgtr-v1.1";
> +      reg = <0x0 0xfd400000 0x0 0x40000>,
> +            <0x0 0xfd3d0000 0x0 0x1000>;
> +      reg-names = "serdes", "siou";
> +      clocks = <&refclks 3>, <&refclks 2>, <&refclks 0>;
> +      clock-names = "ref1", "ref2", "ref3";
> +      #phy-cells = <4>;
> +      status = "okay";

Drop status in examples.

> +    };
> +
> +...
> diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
> index 1f3f866fae7b..f6bc83b66ae9 100644
> --- a/include/dt-bindings/phy/phy.h
> +++ b/include/dt-bindings/phy/phy.h
> @@ -17,5 +17,6 @@
>  #define PHY_TYPE_USB3		4
>  #define PHY_TYPE_UFS		5
>  #define PHY_TYPE_DP		6
> +#define PHY_TYPE_SGMII		7
>  
>  #endif /* _DT_BINDINGS_PHY */
> -- 
> Regards,
> 
> Laurent Pinchart
> 

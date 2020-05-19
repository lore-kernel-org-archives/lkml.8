Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33433C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130BB20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EbYPn7i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgESI3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:29:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55896 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgESI3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:29:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04J8T9oa106526;
        Tue, 19 May 2020 03:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589876949;
        bh=ZiduhVOg5MMMMQdQPVOx0auXP9xGjDBpjLfphpPRrss=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EbYPn7i53B1QGcA2r/+RQRlTWtyxlor4rw10b0cp8uhtGkE8HL93a7eUlZlwNSoFL
         Fx0guQY6HuTlr638BDdIXyqmFdMtP6gSXLorQBqud0plwxDEcKKkSYdQXypm4YCsZl
         qh1CZyLHE70MsG/ywJJmNVUORye1yP1pHI9p02FU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04J8T9sJ091602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 03:29:09 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 03:29:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 03:29:08 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04J8T5Vj037768;
        Tue, 19 May 2020 03:29:06 -0500
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>
CC:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        <devicetree@vger.kernel.org>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-2-laurent.pinchart@ideasonboard.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <eaeba80e-9082-2eeb-8c66-7ef28b7fb895@ti.com>
Date:   Tue, 19 May 2020 13:59:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513172239.26444-2-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2020 10:52 PM, Laurent Pinchart wrote:
> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> 
> Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> Processing System Gigabit Transceiver which provides PHY capabilities to
> USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Need RobH Ack for this to be merged.

Thanks
Kishon
> ---
> Changes since v7:
> 
> - Switch to GPL-2.0-only OR BSD-2-Clause
> 
> Changes since v6:
> 
> - Fixed specification of compatible-dependent xlnx,tx-termination-fix
>   property
> - Dropped status property from example
> - Use 4 spaces to indent example
> 
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
>  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++++++++++++++++++
>  include/dt-bindings/phy/phy.h                 |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> new file mode 100644
> index 000000000000..09e3cde7ebca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +  xlnx,tx-termination-fix:
> +    description: |
> +      Include this for fixing functional issue with the TX termination
> +      resistance in GT, which can be out of spec for the XCZU9EG silicon
> +      version.
> +    type: boolean
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
> +      const: xlnx,zynqmp-psgtr-v1.1
> +
> +then:
> +  properties:
> +    xlnx,tx-termination-fix: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    phy: phy@fd400000 {
> +        compatible = "xlnx,zynqmp-psgtr-v1.1";
> +        reg = <0x0 0xfd400000 0x0 0x40000>,
> +              <0x0 0xfd3d0000 0x0 0x1000>;
> +        reg-names = "serdes", "siou";
> +        clocks = <&refclks 3>, <&refclks 2>, <&refclks 0>;
> +        clock-names = "ref1", "ref2", "ref3";
> +        #phy-cells = <4>;
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
> 

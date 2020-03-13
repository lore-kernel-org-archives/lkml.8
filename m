Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8389C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A47206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q8JtAEqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCMLJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:09:31 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45860 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMLJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:09:31 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02DB9Rl9116314;
        Fri, 13 Mar 2020 06:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584097767;
        bh=Gcba3nSrASmOMxPn5/+FGEYyz7Y0+H63Cau6YWzzsfI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q8JtAEqZ0Vo8O5HyQZARU8EY5pYSNsgL3rcDdn3U4rkjXRd+pMvW/9Q0YjOXPuTrF
         vlrVDldujyvuHTFbRIvMP4o85hP0JxGZHlqynKujRHkhkwe4HhjtGy/o1FVs44DFnO
         Kupm59OYnYlKEdBlqiPWlWG2ys23da0cpvNRtvvk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02DB9Qq3032533
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 06:09:27 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 06:09:26 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 06:09:26 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02DB9ObY004979;
        Fri, 13 Mar 2020 06:09:25 -0500
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
CC:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>
References: <20200311103252.17514-1-laurent.pinchart@ideasonboard.com>
 <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57072adb-9967-f5d1-7a3d-af713e8c35cd@ti.com>
Date:   Fri, 13 Mar 2020 16:44:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311103252.17514-2-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rob

On 11/03/20 4:02 pm, Laurent Pinchart wrote:
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

Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713ABC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F36A217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583200256;
	bh=lY6ZrjhDlN1j85h/TOkiTQ/iHmFeIsO4PApWF1Rmrjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PTe0LqBWPYXeFxSsMAopsshTixmEW248z5woRKiMj4mO6eVQRceIHP/tM5P9fF1q2
	 Yy6uCZvGn2ChMyz2ARX8pjvgqhh3OFkbPPCLMNPQz0w0+2iyOkLGR7gjn6M5G639Aj
	 rg5rqoGJh6g/DIaXq+o7sXtnkSeUWxiiJqzuwfQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCCBuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:50:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41037 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgCCBuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:50:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id v19so1416462ote.8;
        Mon, 02 Mar 2020 17:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KMUxxlPO5Os6mERZg3D76gb3GOfXFpUmopnkrPy85hg=;
        b=r6/PfZqdPbevh5NcpxTy+nXY+EG2DiKjLc34s9igd5iJHwhoBJadL3eOE5AlJHMiup
         N69zxJqFuyOQ4LaBP7oK429YrB9jh1H0UpvKusLw3Rqz4vjeJY4iBz/GLesye4pqK1pT
         et5Hd/+g3fNs8DXeoOwAa0Lpk4Thk1ySxO7ZRFIBMcX82LGvkAIEhW1KxG4ULkzm5Alr
         X0mbrJFUCqSSKJqb3KB7kZKEMb+L71MsIx504KefhJYPmLrxFtWG3VA3Ri+Dpr2f/OYF
         UagaCW9HZu8NF/64eVcmjV2jOnhlTsD7h5hOXDhd1JR8pGBvcMXEEhYBc/RzsUAt8vsN
         8DXw==
X-Gm-Message-State: ANhLgQ11+dCLx3zA7gZ58tTVb8SATBOWI4vgU4UuQRMbXFd+T4NpD72x
        t9F53uz4Ey4uO097UBH+sw==
X-Google-Smtp-Source: ADFU+vsPCc6sWeWA21x9KhNUp3w2MR16z6AzUfhQK9Jzso83vGqrq7mRuHwOEamVpKaqgj2MRg+QTA==
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr1718711otr.79.1583200253483;
        Mon, 02 Mar 2020 17:50:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f1sm7219481otq.4.2020.03.02.17.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:50:52 -0800 (PST)
Received: (nullmailer pid 6654 invoked by uid 1000);
        Tue, 03 Mar 2020 01:50:51 -0000
Date:   Mon, 2 Mar 2020 19:50:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add YAML schemas for Intel
 Combophy
Message-ID: <20200303015051.GA780@bogus>
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <9f049a5fccd080bd5d8e9a697b96d4c40a413a0a.1583127977.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f049a5fccd080bd5d8e9a697b96d4c40a413a0a.1583127977.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 04:43:24PM +0800, Dilip Kota wrote:
> Combophy subsystem provides PHY support to various
> controllers, viz. PCIe, SATA and EMAC.
> Adding YAML schemas for the same.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v4:
>   No changes.
> 
> Changes on v3:
> 
>  Add include/dt-bindings/phy/phy-intel-combphy.h for phy modes.
>  Add SoC specific compatible "intel,combophy-lgm".
>  Correct the nodename pattern.
>  clocks description removed and add maxItems entry.
>  Remove "simple-bus" as it expects minimum one address
>   cell and size cell in the children node. Call devm_of_platform_populate()
>   in the driver to perform "simple-bus" functionality.
> 
> Changes on v2:
> 
>  Add custom 'select'
>  Pass hardware instance entries with phandles and
>    remove cell-index and bid entries
>  Clock, register address space, are same for the children.
>    So move them to parent node.
>  Two PHY instances cannot run in different modes,
>    so move the phy-mode entry to parent node.
>  Add second child entry in the DT example.
> 
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 123 +++++++++++++++++++++
>  include/dt-bindings/phy/phy-intel-combophy.h       |  10 ++
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>  create mode 100644 include/dt-bindings/phy/phy-intel-combophy.h
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> new file mode 100644
> index 000000000000..f9bae37fab17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/intel,combo-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel ComboPhy Subsystem
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +description: |
> +  Intel Combophy subsystem supports PHYs for PCIe, EMAC and SATA
> +  controllers. A single Combophy provides two PHY instances.
> +
> +properties:
> +  $nodename:
> +    pattern: "combophy(@.*|-[0-9a-f])*$"
> +
> +  compatible:
> +    items:
> +      - const: intel,combophy-lgm
> +      - const: intel,combo-phy
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reg:
> +    items:
> +      - description: ComboPhy core registers
> +      - description: PCIe app core control registers
> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: app
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: core
> +
> +  intel,syscfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: Chip configuration registers handle and ComboPhy instance id
> +
> +  intel,hsio:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: HSIO registers handle and ComboPhy instance id on NOC
> +
> +  intel,aggregation:
> +    type: boolean
> +    description: |
> +      Specify the flag to configure ComboPHY in dual lane mode.
> +
> +  intel,phy-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Mode of the two phys in ComboPhy.
> +      See dt-bindings/phy/phy-intel-combophy.h for values.
> +
> +patternProperties:
> +  "^phy@[0-9]+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: intel,phydev
> +
> +      "#phy-cells":
> +        const: 0
> +
> +      resets:
> +        description: |
> +          reset handle according to the PHY mode.
> +          See ../reset/reset.txt for details.
> +
> +    required:
> +      - compatible
> +      - "#phy-cells"
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - reg-names
> +  - intel,syscfg
> +  - intel,hsio
> +  - intel,phy-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/phy/phy-intel-combophy.h>
> +    combophy@d0a00000 {
> +        compatible = "intel,combophy-lgm", "intel,combo-phy";
> +        clocks = <&cgu0 1>;
> +        reg = <0xd0a00000 0x40000>,
> +              <0xd0a40000 0x1000>;
> +        reg-names = "core", "app";
> +        resets = <&rcu0 0x50 6>,
> +                 <&rcu0 0x50 17>;
> +        reset-names = "phy", "core";
> +        intel,syscfg = <&sysconf 0>;
> +        intel,hsio = <&hsiol 0>;
> +        intel,phy-mode = <COMBO_PHY_PCIE>;
> +
> +        phy@0 {

You need a 'reg' property to go with a unit-address.

Really, I'd just simplify this to make parent 'resets' be 4 entries and 
put '#phy-cells = <1>;' in the parent. Then you don't need these child 
nodes.

> +            compatible = "intel,phydev";
> +            #phy-cells = <0>;
> +            resets = <&rcu0 0x50 23>;
> +        };
> +
> +        phy@1 {
> +            compatible = "intel,phydev";
> +            #phy-cells = <0>;
> +            resets = <&rcu0 0x50 24>;
> +        };
> +    };
> diff --git a/include/dt-bindings/phy/phy-intel-combophy.h b/include/dt-bindings/phy/phy-intel-combophy.h
> new file mode 100644
> index 000000000000..bd7f6377f4ef
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-intel-combophy.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _DT_BINDINGS_INTEL_COMBOPHY
> +#define _DT_BINDINGS_INTEL_COMBOPHY
> +
> +#define COMBO_PHY_PCIE	0
> +#define COMBO_PHY_XPCS	1
> +#define COMBO_PHY_SATA	2

Use the PHY_TYPE_* defines we already have and extend as you need to.

> +
> +#endif /* _DT_BINDINGS_INTEL_COMBOPHY*/
> -- 
> 2.11.0
> 

Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05341C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25732084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578950726;
	bh=NkUE8z5Tm7eUYlTSBrC30F4W/PL1bcCe7Kzu6YA9Z3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FxgslQPo8OSKDJwSNK/oFMrI5hA8yeYm3p21Hx5hh/FB0RM6sIvnzL2JCAxIv/Yxm
	 bl4e5/2aUyqX09kuoiGqxWrFFSVG27iPB1dIP6S9QkC4Aj5qW6MAyJ43RYIcBPUVbE
	 67MjJrTdZJQNOyRNMC8aisDNUIO+zEgV7RzAM3KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMVZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:25:26 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42816 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgAMVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:25:25 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so9745659oin.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 13:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kdq9aN9RfFQuJmNV+vqMSqQdkkLqzs/g4fONHkpv+9g=;
        b=ZEBOaelpBjRisEFOExvJwXUji56MohBiL2UQjjuH0Hi2V2eylVWDbEx1/m+uMxXjU8
         6zPtgBmhBGbk5tQlQoXsQqMSOvF74wfE083g3dw3fcR/9DEL/jL3SMznLH1JwoUHCIpB
         r/85aou4WYVczVJ8vY1+rbFlGBeI6xf9iYxLK1/VXCdsFgT06lY7meTeuzdzIOv3cnVC
         CWBomqTClJZthyTU7E3P6gSg7BYxAWO2SijqlAL1aMhtJPbe4d+CPy/yDEKkvqkefcJF
         2t0NIXDRqDs0wsV4ImByhQzMBnuA3ASmeuFtbDpTBZyB+TO2hxPIw+pLPz9sqkrqMHew
         uHOA==
X-Gm-Message-State: APjAAAWta3uWUXWffg/P8gqdrveSZ1yLGuErXpLVXIA0Xs4/NW6rO1hc
        LCCyjXBN1sMeRprfOL32dUDtHyk=
X-Google-Smtp-Source: APXvYqypYyWd4u3pL2en60NXVnrTrllxjH2K/Xr6yVtxz6DFONhpij+4vnzlvpvcqmLVhc5hOfsWjA==
X-Received: by 2002:aca:458:: with SMTP id 85mr14713741oie.56.1578950724425;
        Mon, 13 Jan 2020 13:25:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a74sm3944882oii.37.2020.01.13.13.25.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:25:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221998
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 15:22:52 -0600
Date:   Mon, 13 Jan 2020 15:22:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [v3 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
Message-ID: <20200113212252.GA3120@bogus>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 04:22:09PM +0000, Lad Prabhakar wrote:
> This patch adds the bindings for the R-Car PCIe endpoint driver.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml

Fails 'make dt_binding_check':

Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml: $id: 
path/filename 'pci/rcar-pcie-ep.yaml' doesn't match actual filename

> 
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> new file mode 100644
> index 000000000000..99c2a1174463
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car PCIe Endpoint
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a774c0-pcie-ep
> +      - const: renesas,rcar-gen3-pcie-ep
> +
> +  reg:
> +    maxItems: 5
> +
> +  reg-names:
> +    items:
> +      - const: apb-base
> +      - const: memory0
> +      - const: memory1
> +      - const: memory2
> +      - const: memory3
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +
> +  max-functions:
> +    minimum: 1
> +    maximum: 6
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - resets
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - max-functions
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a774c0-sysc.h>
> +
> +     pcie0_ep: pcie-ep@fe000000 {
> +            compatible = "renesas,r8a774c0-pcie-ep",
> +                         "renesas,rcar-gen3-pcie-ep";
> +            reg = <0 0xfe000000 0 0x80000>,
> +                  <0x0 0xfe100000 0 0x100000>,
> +                  <0x0 0xfe200000 0 0x200000>,
> +                  <0x0 0x30000000 0 0x8000000>,
> +                  <0x0 0x38000000 0 0x8000000>;
> +            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> +            resets = <&cpg 319>;
> +            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> +            clocks = <&cpg CPG_MOD 319>;
> +            clock-names = "pcie";
> +            max-functions = /bits/ 8 <1>;
> +    };
> -- 
> 2.20.1
> 

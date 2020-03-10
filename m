Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22834C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D766721655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583874549;
	bh=aO/230DCKti683rP0qoBVP61iOvZbUB9+GrbuunBBek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vQ8+z0Da1O7u6taTn0EnwdqLkxdy8W+YK5ROuOuSAU0MDLOjC12Zrao87WuFo4bHh
	 Ne187z6/9LtMz/bwhjeAGIblNwc5lFNqN2Uy5+B134U2KTAQu75SmS/MxLGsue0kTQ
	 2SCvvovld2E43UgbeDyF1y0mG4M9DpSldsFSgCD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCJVJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:09:07 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37258 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgCJVJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 17:09:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id w13so4967855oih.4;
        Tue, 10 Mar 2020 14:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GfhqlgMKmzN4IuxVJjHneTo0nfEVjjRSeSr65YkBw7o=;
        b=Aj/pjqHjph9rl9vnbfZAAvUpxO3Ydpqvxj7o+/Pjy81RqxFEto9s36rxJ9Ktjg/dVa
         2u4waJP4xTvzgv9l6LabOIF1M+QsOKB3zCMzj4/fmEgVqQEp91eZ0q8ynKhf42gmJsiR
         mwNitWbopDaSDeeDkKbCR2I5YSoNmywuwd8KKRrJiWjKCXlzSDEajXhzQ2kVFSoolTZC
         RrRIcILOZQu08A0ZjmYhNMZYxngCXvz0YqIeHPIPw5Dkz5rjxssYNuglb6XIOMsXt6hQ
         VmnzPbvj+9yCbso5oOBR43ja1Ij7HGY39rr32u/rsQZL+Aeyauk5BdgdDAeJAkQYgCd4
         kcUw==
X-Gm-Message-State: ANhLgQ1/TXWEFPVChmDXDwnvD3WbqviHFw2OhmTNw6LZhMjz2sdTGeQm
        uiZF8KvYooXSrbkyqCMBaA==
X-Google-Smtp-Source: ADFU+vuo4t0V5T26kso3ujaflSD82gWJtxIt/gxBCOgVp/HDNHLnUFS+kxRXLGet1zlCiae3LTR2EQ==
X-Received: by 2002:aca:b205:: with SMTP id b5mr2682151oif.21.1583874546307;
        Tue, 10 Mar 2020 14:09:06 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h3sm2131748otr.4.2020.03.10.14.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:09:05 -0700 (PDT)
Received: (nullmailer pid 18143 invoked by uid 1000);
        Tue, 10 Mar 2020 21:09:04 -0000
Date:   Tue, 10 Mar 2020 16:09:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     t-kristo@ti.com, kishon@ti.com, nm@ti.com, nsekhar@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
Message-ID: <20200310210904.GA11275@bogus>
References: <20200303101722.26052-1-rogerq@ti.com>
 <20200303101722.26052-4-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303101722.26052-4-rogerq@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:17:19PM +0200, Roger Quadros wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 27 ++++++++++++
>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index cbaadee5bfdc..c5d54af37e91 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
>   */
>  #include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/mux/mux.h>
> +#include <dt-bindings/mux/mux-j721e-wiz.h>
>  
>  &cbass_main {
>  	msmc_ram: sram@70000000 {
> @@ -19,6 +21,31 @@
>  		};
>  	};
>  
> +	scm_conf: scm-conf@100000 {
> +		compatible = "syscon", "simple-mfd", "ti,j721e-system-controller";

Wrong ordering. Most significant first.

> +		reg = <0 0x00100000 0 0x1c000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x00100000 0x1c000>;
> +
> +		serdes_ln_ctrl: serdes-ln-ctrl@4080 {

Your syscon.yaml change is not valid if you have child nodes. Do a 
specific binding for this block.

> +			compatible = "mmio-mux";
> +			reg = <0x00004080 0x50>;
> +			#mux-control-cells = <1>;
> +			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> +					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> +					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> +					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
> +					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
> +					/* SERDES4 lane0/1/2/3 select */
> +			idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
> +				      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
> +				      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
> +				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
> +				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
> +		};
> +	};
> +
>  	gic500: interrupt-controller@1800000 {
>  		compatible = "arm,gic-v3";
>  		#address-cells = <2>;
> diff --git a/include/dt-bindings/mux/mux-j721e-wiz.h b/include/dt-bindings/mux/mux-j721e-wiz.h
> new file mode 100644
> index 000000000000..fd1c4ea9fc7f
> --- /dev/null
> +++ b/include/dt-bindings/mux/mux-j721e-wiz.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for J721E WIZ.
> + */
> +
> +#ifndef _DT_BINDINGS_J721E_WIZ
> +#define _DT_BINDINGS_J721E_WIZ
> +
> +#define SERDES0_LANE0_QSGMII_LANE1	0x0
> +#define SERDES0_LANE0_PCIE0_LANE0	0x1
> +#define SERDES0_LANE0_USB3_0_SWAP	0x2
> +
> +#define SERDES0_LANE1_QSGMII_LANE2	0x0
> +#define SERDES0_LANE1_PCIE0_LANE1	0x1
> +#define SERDES0_LANE1_USB3_0		0x2
> +
> +#define SERDES1_LANE0_QSGMII_LANE3	0x0
> +#define SERDES1_LANE0_PCIE1_LANE0	0x1
> +#define SERDES1_LANE0_USB3_1_SWAP	0x2
> +#define SERDES1_LANE0_SGMII_LANE0	0x3
> +
> +#define SERDES1_LANE1_QSGMII_LANE4	0x0
> +#define SERDES1_LANE1_PCIE1_LANE1	0x1
> +#define SERDES1_LANE1_USB3_1		0x2
> +#define SERDES1_LANE1_SGMII_LANE1	0x3
> +
> +#define SERDES2_LANE0_PCIE2_LANE0	0x1
> +#define SERDES2_LANE0_SGMII_LANE0	0x3
> +#define SERDES2_LANE0_USB3_1_SWAP	0x2
> +
> +#define SERDES2_LANE1_PCIE2_LANE1	0x1
> +#define SERDES2_LANE1_USB3_1		0x2
> +#define SERDES2_LANE1_SGMII_LANE1	0x3
> +
> +#define SERDES3_LANE0_PCIE3_LANE0	0x1
> +#define SERDES3_LANE0_USB3_0_SWAP	0x2
> +
> +#define SERDES3_LANE1_PCIE3_LANE1	0x1
> +#define SERDES3_LANE1_USB3_0		0x2
> +
> +#define SERDES4_LANE0_EDP_LANE0		0x0
> +#define SERDES4_LANE0_QSGMII_LANE5	0x2
> +
> +#define SERDES4_LANE1_EDP_LANE1		0x0
> +#define SERDES4_LANE1_QSGMII_LANE6	0x2
> +
> +#define SERDES4_LANE2_EDP_LANE2		0x0
> +#define SERDES4_LANE2_QSGMII_LANE7	0x2
> +
> +#define SERDES4_LANE3_EDP_LANE3		0x0
> +#define SERDES4_LANE3_QSGMII_LANE8	0x2
> +
> +#endif /* _DT_BINDINGS_J721E_WIZ */
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

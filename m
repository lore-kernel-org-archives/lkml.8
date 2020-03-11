Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C5FC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E039720873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583914884;
	bh=xOsCy17pMnIpN8H6F7yfTfdZSqkG2zR+BQaWBdsM8Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GRhi2OkcFPwYH2FS/FNYVh2xe9DEkEZqYZvvf8wwemvw0XSxQzA2noIXVEDa/+E8y
	 6neI0R7iUwg3E0KUr3+N/exPOSNnXc83Oq0vcK/tQ7q8qIp9eTlTpYOhNz8NmYsN4V
	 3URVPT0B5WHun16+EPhoV9Cu8vjvMXEizC3g6FGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgCKIVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgCKIVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:21:23 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AABB20866;
        Wed, 11 Mar 2020 08:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583914882;
        bh=xOsCy17pMnIpN8H6F7yfTfdZSqkG2zR+BQaWBdsM8Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EQFu+RDgOck99iq5cpUODmlkEEvvRJB9iQ8d/Pcc/SkS8NJ2/c0WYgYces3+rwr0+
         Ie/m2HlmM+BB8bcRVCxWun+TT3lToNZdm4w0YFJfKLS8FHbFVNREAAFvwZIda3r+0H
         VjDJeZpVanZ/rWZKdhv7D2IwZoPQ5nhqHw1GHj1I=
Date:   Wed, 11 Mar 2020 16:21:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, michael@walle.cc, leoyang.li@nxp.com,
        Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv7] arm64: dts: ls1028a: Add PCIe controller DT nodes
Message-ID: <20200311082117.GA29269@dragon>
References: <20200302042305.15639-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302042305.15639-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 12:23:05PM +0800, Zhiqiang Hou wrote:
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
> 
> LS1028a implements 2 PCIe 3.0 controllers.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Tested-by: Michael Walle <michael@walle.cc>
> ---
> V7:
>  - Rebased the patch to the latest code base.
>  - Added property 'iommu-map'.
> 
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 41c9633293fb..3f31641dcced 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -717,6 +717,60 @@
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> +		pcie@3400000 {

Please keep nodes sorted in unit-address.

Shawn

> +			compatible = "fsl,ls1028a-pcie";
> +			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +			interrupt-names = "pme", "aer";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			num-viewport = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
> +				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +			status = "disabled";
> +		};
> +
> +		pcie@3500000 {
> +			compatible = "fsl,ls1028a-pcie";
> +			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pme", "aer";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			num-viewport = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000   /* downstream I/O */
> +				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
> +			status = "disabled";
> +		};
> +
>  		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
>  			compatible = "pci-host-ecam-generic";
>  			reg = <0x01 0xf0000000 0x0 0x100000>;
> -- 
> 2.17.1
> 

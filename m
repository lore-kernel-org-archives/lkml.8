Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D722C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51A0B22CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGRVIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 17:08:52 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48267 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgGRVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 17:08:52 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 60014240005;
        Sat, 18 Jul 2020 21:08:48 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Nowicki <tn@semihalf.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com, Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v4 4/4] arm64: dts: marvell: add SMMU support
In-Reply-To: <20200715070649.18733-5-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com> <20200715070649.18733-5-tn@semihalf.com>
Date:   Sat, 18 Jul 2020 23:08:48 +0200
Message-ID: <87k0z0350f.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Nowicki <tn@semihalf.com> writes:

> From: Marcin Wojtas <mw@semihalf.com>
>
> Add IOMMU node for Marvell AP806 based SoCs together with platform
> and PCI device Stream ID mapping.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 +++++++++++++
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++++
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 +++++++++
>  3 files changed, 86 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040.dtsi b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
> index 47247215770d..7a3198cd7a07 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-7040.dtsi
> @@ -14,3 +14,31 @@
>  	compatible = "marvell,armada7040", "marvell,armada-ap806-quad",
>  		     "marvell,armada-ap806";
>  };
> +
> +&smmu {
> +	status = "okay";
> +};
> +
> +&cp0_pcie0 {
> +	iommu-map =
> +		<0x0   &smmu 0x480 0x20>,
> +		<0x100 &smmu 0x4a0 0x20>,
> +		<0x200 &smmu 0x4c0 0x20>;
> +	iommu-map-mask = <0x031f>;
> +};
> +
> +&cp0_sata0 {
> +	iommus = <&smmu 0x444>;
> +};
> +
> +&cp0_sdhci0 {
> +	iommus = <&smmu 0x445>;
> +};
> +
> +&cp0_usb3_0 {
> +	iommus = <&smmu 0x440>;
> +};
> +
> +&cp0_usb3_1 {
> +	iommus = <&smmu 0x441>;
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> index 7699b19224c2..79e8ce59baa8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> @@ -15,6 +15,18 @@
>  		     "marvell,armada-ap806";
>  };
>  
> +&smmu {
> +	status = "okay";
> +};
> +
> +&cp0_pcie0 {
> +	iommu-map =
> +		<0x0   &smmu 0x480 0x20>,
> +		<0x100 &smmu 0x4a0 0x20>,
> +		<0x200 &smmu 0x4c0 0x20>;
> +	iommu-map-mask = <0x031f>;
> +};
> +
>  /* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
>   * in CP master is not connected (by package) to the oscillator. So
>   * disable it. However, the RTC clock in CP slave is connected to the
> @@ -23,3 +35,31 @@
>  &cp0_rtc {
>  	status = "disabled";
>  };
> +
> +&cp0_sata0 {
> +	iommus = <&smmu 0x444>;
> +};
> +
> +&cp0_sdhci0 {
> +	iommus = <&smmu 0x445>;
> +};
> +
> +&cp0_usb3_0 {
> +	iommus = <&smmu 0x440>;
> +};
> +
> +&cp0_usb3_1 {
> +	iommus = <&smmu 0x441>;
> +};
> +
> +&cp1_sata0 {
> +	iommus = <&smmu 0x454>;
> +};
> +
> +&cp1_usb3_0 {
> +	iommus = <&smmu 0x450>;
> +};
> +
> +&cp1_usb3_1 {
> +	iommus = <&smmu 0x451>;
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 7f9b9a647717..12e477f1aeb9 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -56,6 +56,24 @@
>  			compatible = "simple-bus";
>  			ranges = <0x0 0x0 0xf0000000 0x1000000>;
>  
> +			smmu: iommu@5000000 {
> +				compatible = "marvell,ap806-smmu-500", "arm,mmu-500";
> +				reg = <0x100000 0x100000>;
> +				dma-coherent;
> +				#iommu-cells = <1>;
> +				#global-interrupts = <1>;
> +				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
>  			gic: interrupt-controller@210000 {
>  				compatible = "arm,gic-400";
>  				#interrupt-cells = <3>;
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

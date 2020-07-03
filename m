Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DDDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E22720836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGCJQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:16:54 -0400
Received: from foss.arm.com ([217.140.110.172]:40904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGCJQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:16:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EA1B2F;
        Fri,  3 Jul 2020 02:16:53 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EC3E3F68F;
        Fri,  3 Jul 2020 02:16:51 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] arm64: dts: marvell: add SMMU support
To:     Tomasz Nowicki <tn@semihalf.com>, will@kernel.org, joro@8bytes.org,
        gregory.clement@bootlin.com, robh+dt@kernel.org, hannah@marvell.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
References: <20200702201633.22693-1-tn@semihalf.com>
 <20200702201633.22693-5-tn@semihalf.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ba29e839-79e0-7189-f735-d457544135e4@arm.com>
Date:   Fri, 3 Jul 2020 10:16:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200702201633.22693-5-tn@semihalf.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 21:16, Tomasz Nowicki wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> Add IOMMU node for Marvell AP806 based SoCs together with platform
> and PCI device Stream ID mapping.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> ---
>   arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 36 +++++++++++++++++++
>   arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 17 +++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> index 7699b19224c2..25c1df709f72 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> @@ -23,3 +23,39 @@
>   &cp0_rtc {
>   	status = "disabled";
>   };
> +
> +&cp0_usb3_0 {
> +	iommus = <&smmu 0x440>;
> +};
> +
> +&cp0_usb3_1 {
> +	iommus = <&smmu 0x441>;
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
> +
> +&cp0_pcie0 {
> +	iommu-map =
> +		<0x0   &smmu 0x480 0x20>,
> +		<0x100 &smmu 0x4a0 0x20>,
> +		<0x200 &smmu 0x4c0 0x20>;
> +	iommu-map-mask = <0x031f>;

Nice! I do like a good compressed mapping :D

> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index 7f9b9a647717..ded8b8082d79 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -56,6 +56,23 @@
>   			compatible = "simple-bus";
>   			ranges = <0x0 0x0 0xf0000000 0x1000000>;
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

I'd recommend you have the node disabled by default here, then 
explicitly enable it in armada-8040.dtsi where you add the Stream IDs. 
Otherwise it will also end up enabled for 8020, 70x0, etc. where 
disable_bypass will then catastrophically break everything.

Robin.

> +			};
> +
>   			gic: interrupt-controller@210000 {
>   				compatible = "arm,gic-400";
>   				#interrupt-cells = <3>;
> 

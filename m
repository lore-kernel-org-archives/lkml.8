Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4216C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C206520828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgCDV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:27:41 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42315 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbgCDV1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:27:41 -0500
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1C0AE60002;
        Wed,  4 Mar 2020 21:27:38 +0000 (UTC)
Date:   Wed, 4 Mar 2020 22:27:37 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, tsahee@annapurnalabs.com,
        antoine.tenart@bootlin.com, mchehab+samsung@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dwmw@amazon.co.uk,
        benh@amazon.com, ronenk@amazon.com, talel@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, eitan@amazon.com
Subject: Re: [PATCH v4 6/6] arm64: dts: amazon: add Amazon's Annapurna Labs
 Alpine v3 support
Message-ID: <20200304212737.GN3179@kwain>
References: <20200225112926.16518-1-hhhawa@amazon.com>
 <20200225112926.16518-7-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225112926.16518-7-hhhawa@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry, I'm a bit late to the party...

On Tue, Feb 25, 2020 at 01:29:26PM +0200, Hanna Hawa wrote:
> diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> +     arch-timer {                                                    

Please use 'timer' instead.

> +             compatible = "arm,armv8-timer";                         
> +             interrupts = <GIC_PPI 0xd IRQ_TYPE_LEVEL_LOW>,          
> +                          <GIC_PPI 0xe IRQ_TYPE_LEVEL_LOW>,          
> +                          <GIC_PPI 0xb IRQ_TYPE_LEVEL_LOW>,          
> +                          <GIC_PPI 0xa IRQ_TYPE_LEVEL_LOW>;          
> +     };

> +		gic: interrupt-controller@f0000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;

No need for this.

> +			interrupt-controller;
> +			reg = <0x0 0xf0800000 0 0x10000>,
> +			      <0x0 0xf0a00000 0 0x200000>,
> +			      <0x0 0xf0000000 0 0x2000>,
> +			      <0x0 0xf0010000 0 0x1000>,
> +			      <0x0 0xf0020000 0 0x2000>;

Please add comments here, see alpine-v2.dtsi (or other dtsi in
arch/arm64).

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		msix: msix@fbe00000 {
> +			compatible = "al,alpine-msix";
> +			reg = <0x0 0xfbe00000 0x0 0x100000>;
> +			interrupt-controller;
> +			msi-controller;
> +			al,msi-base-spi = <160>;
> +			al,msi-num-spis = <800>;
> +			interrupt-parent = <&gic>;
> +		};
> +
> +		uart0: serial@fd883000 {

Looking at the Alpine v2 dtsi, this node was put in an io-fabric bus. It
seems to me the Alpine v3 dtsi is very similar. Would it apply as well?

> +			compatible = "ns16550a";
> +			reg = <0x0 0xfd883000 0x0 0x1000>;
> +			clock-frequency = <0>;

Is the frequency set to 0 on purpose? Or is it set by a firmware at boot
time (if so please add a comment)?

> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;

Since you're enabling this node explicitly in the dts, you can set it to
disabled by default.

> +		};
> +
> +		pcie@fbd00000 {

Please order the nodes in increasing order.

> +			compatible = "pci-host-ecam-generic";
> +			device_type = "pci";
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			#interrupt-cells = <1>;
> +			reg = <0x0 0xfbd00000 0x0 0x100000>;
> +			interrupt-map-mask = <0xf800 0 0 7>;
> +			/* 8 x legacy interrupts for SATA only */
> +			interrupt-map = <0x4000 0 0 1 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x4800 0 0 1 &gic 0 58 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x5000 0 0 1 &gic 0 59 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x5800 0 0 1 &gic 0 60 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x6000 0 0 1 &gic 0 61 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x6800 0 0 1 &gic 0 62 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x7000 0 0 1 &gic 0 63 IRQ_TYPE_LEVEL_HIGH>,
> +					<0x7800 0 0 1 &gic 0 64 IRQ_TYPE_LEVEL_HIGH>;
> +			ranges = <0x02000000 0x0 0xfe000000 0x0 0xfe000000 0x0 0x1000000>;
> +			bus-range = <0x00 0x00>;
> +			msi-parent = <&msix>;
> +		};
> +	};
> +};

The rest of the series looks good.

Thanks!
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

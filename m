Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D74C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014222063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGHUjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:39:20 -0400
Received: from foss.arm.com ([217.140.110.172]:36594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGHUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:39:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D36D1FB;
        Wed,  8 Jul 2020 13:39:19 -0700 (PDT)
Received: from bogus (unknown [10.37.8.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29D93F66E;
        Wed,  8 Jul 2020 13:39:15 -0700 (PDT)
Date:   Wed, 8 Jul 2020 21:39:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: keembay: Add device tree for Keem Bay SoC
Message-ID: <20200708203913.GC31671@bogus>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
 <20200616155613.121242-7-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616155613.121242-7-daniele.alessandrelli@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 04:56:12PM +0100, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Add initial device tree for Intel Movidius SoC code-named Keem Bay.
> 
> This initial DT includes nodes for Cortex-A53 cores, UARTs, timers, GIC,
> PSCI, PMU, and Keem Bay SCMI mailbox.
> 
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> ---
>  MAINTAINERS                                |   1 +
>  arch/arm64/boot/dts/intel/keembay-soc.dtsi | 172 +++++++++++++++++++++
>  2 files changed, 173 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/keembay-soc.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b919aa8b1bd..610907bf391b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1959,6 +1959,7 @@ M:	Paul J. Murphy <paul.j.murphy@intel.com>
>  M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/keembay.yaml
> +F:	arch/arm64/boot/dts/intel/keembay-soc.dtsi
>  F:	include/dt-bindings/clock/keembay-clocks.h
>  F:	include/dt-bindings/power/keembay-power.h
>  
> diff --git a/arch/arm64/boot/dts/intel/keembay-soc.dtsi b/arch/arm64/boot/dts/intel/keembay-soc.dtsi
> new file mode 100644
> index 000000000000..bd0a48f24e09
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/keembay-soc.dtsi
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020, Intel Corporation.
> + *
> + * Device tree describing Keem Bay SoC.
> + */
> +
> +#include <dt-bindings/clock/keembay-clocks.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/keembay-power.h>
> +
> +/ {
> +	compatible = "intel,keembay";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			clocks = <&scmi_dvfs 0>;
> +		};
> +
> +		cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			clocks = <&scmi_dvfs 0>;
> +		};
> +
> +		cpu@2 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			clocks = <&scmi_dvfs 0>;
> +		};
> +
> +		cpu@3 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			clocks = <&scmi_dvfs 0>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	firmware: firmware {
> +
> +		scmi: scmi {
> +			compatible = "arm,scmi";

The above must be changed to "arm,scmi-smc".
Add "arm,smc-id = <sip_id_for_this>" and drop mboxes.

-- 
Regards,
Sudeep

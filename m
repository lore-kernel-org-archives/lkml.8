Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1669C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4E32074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCMUmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:42:39 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:38667 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCMUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:42:39 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7B93A240007;
        Fri, 13 Mar 2020 20:42:36 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/4] arm64: dts: marvell: Fix cpu compatible for AP807-quad
In-Reply-To: <2f56a89b8f88583b60446050efc523a781556e3a.1583445235.git.amit.kucheria@linaro.org>
References: <cover.1583445235.git.amit.kucheria@linaro.org> <2f56a89b8f88583b60446050efc523a781556e3a.1583445235.git.amit.kucheria@linaro.org>
Date:   Fri, 13 Mar 2020 21:42:36 +0100
Message-ID: <87pndgx9z7.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

> make -k ARCH=arm64 dtbs_check shows the following errors. Fix them by
> removing the "arm,armv8" compatible.
>
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@0: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long CHECK
> arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dt.yaml
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@1: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@100: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@100: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@101: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9130-db.dt.yaml:
> cpu@101: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
>
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@0: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@1: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@100: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@100: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@101: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9131-db.dt.yaml:
> cpu@101: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
>
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@0: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@0: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@1: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@1: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@100: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@100: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@101: compatible: Additional items are not allowed ('arm,armv8' was
> unexpected)
> /home/amit/work/builds/build-check/arch/arm64/boot/dts/marvell/cn9132-db.dt.yaml:
> cpu@101: compatible: ['arm,cortex-a72', 'arm,armv8'] is too long
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
> index 840466e143b47..68782f161f122 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
> @@ -17,7 +17,7 @@
>  
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a72", "arm,armv8";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x000>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>;
> @@ -32,7 +32,7 @@
>  		};
>  		cpu1: cpu@1 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a72", "arm,armv8";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x001>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>;
> @@ -47,7 +47,7 @@
>  		};
>  		cpu2: cpu@100 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a72", "arm,armv8";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>;
> @@ -62,7 +62,7 @@
>  		};
>  		cpu3: cpu@101 {
>  			device_type = "cpu";
> -			compatible = "arm,cortex-a72", "arm,armv8";
> +			compatible = "arm,cortex-a72";
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			#cooling-cells = <2>;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

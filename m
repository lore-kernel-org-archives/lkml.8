Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C2BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB397246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1MdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:33:25 -0500
Received: from foss.arm.com ([217.140.110.172]:37544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1MdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:33:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68224B2;
        Fri, 28 Feb 2020 04:33:24 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800F53F7B4;
        Fri, 28 Feb 2020 04:33:23 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: fix cpu compatible property for
 rk3308
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200228084827.16198-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6a6beced-a8cb-448e-a4b2-331cd09d0c61@arm.com>
Date:   Fri, 28 Feb 2020 12:33:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228084827.16198-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2020 8:48 am, Johan Jonker wrote:
> A test with the command below gives for example these errors:
> 
> arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: cpu@0: compatible:
> Additional items are not allowed ('arm,armv8' was unexpected)
> arch/arm64/boot/dts/rockchip/rk3308-evb.dt.yaml: cpu@0: compatible:
> ['arm,cortex-a35', 'arm,armv8']
> is too long
> 
> Fix these errors by removing the last argument of
> the cpu compatible property in rk3308.dtsi.

Bah, seems this snuck in a couple of releases after we blitzed the last 
of these from the tree :)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> make ARCH=arm64
> dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/cpus.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index 116f1900e..3bd5bc860 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -40,7 +40,7 @@
>   
>   		cpu0: cpu@0 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x0>;
>   			enable-method = "psci";
>   			clocks = <&cru ARMCLK>;
> @@ -53,7 +53,7 @@
>   
>   		cpu1: cpu@1 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x1>;
>   			enable-method = "psci";
>   			operating-points-v2 = <&cpu0_opp_table>;
> @@ -63,7 +63,7 @@
>   
>   		cpu2: cpu@2 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x2>;
>   			enable-method = "psci";
>   			operating-points-v2 = <&cpu0_opp_table>;
> @@ -73,7 +73,7 @@
>   
>   		cpu3: cpu@3 {
>   			device_type = "cpu";
> -			compatible = "arm,cortex-a35", "arm,armv8";
> +			compatible = "arm,cortex-a35";
>   			reg = <0x0 0x3>;
>   			enable-method = "psci";
>   			operating-points-v2 = <&cpu0_opp_table>;
> 

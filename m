Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096EEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C5B2074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 21:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgGEVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 17:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGEVLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 17:11:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD20C061794;
        Sun,  5 Jul 2020 14:11:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 7643F2A2D58
Subject: Re: [PATCH v1] arm64: dts: actions: Fix smp Bringing up secondary
 CPUs
To:     Matheus Castello <matheus@castello.eng.br>, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org
Cc:     devicetree@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "kernel@collabora.com" <kernel@collabora.com>,
        lkcamp@lists.libreplanetbr.org
References: <20200705191944.404933-1-matheus@castello.eng.br>
From:   Helen Koike <helen.koike@collabora.com>
Message-ID: <6e42b5fe-8e30-42e9-3cf9-160eb5e0af6f@collabora.com>
Date:   Sun, 5 Jul 2020 18:11:36 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200705191944.404933-1-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

On 7/5/20 4:19 PM, Matheus Castello wrote:
> Change the enable-method to fix the failed to boot errors:
> 
> [    0.040330] smp: Bringing up secondary CPUs ...
> [    0.040683] psci: failed to boot CPU1 (-22)
> [    0.040691] CPU1: failed to boot: -22
> [    0.041062] psci: failed to boot CPU2 (-22)
> [    0.041071] CPU2: failed to boot: -22
> [    0.041408] psci: failed to boot CPU3 (-22)
> [    0.041417] CPU3: failed to boot: -22
> [    0.041443] smp: Brought up 1 node, 1 CPU
> [    0.041451] SMP: Total of 1 processors activated.
> 
> Tested on Caninos Labrador v3 based on Actions Semi S700.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>

I tested on the Caninos Labrador v3, and I don't get this errors anymore with this patch,
and I have all 4 CPUs:

[    0.076961] smp: Brought up 1 node, 4 CPUs
[    0.574290] SMP: Total of 4 processors activated.

Full boot log without your patch: http://ix.io/2qYU
Full boot log with your patch: http://ix.io/2qYV

Tested-by: Helen Koike <helen.koike@collabora.com>

Thanks
Helen

> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> --
> 2.27.0
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 2006ad5424fa..b28dbbcad27b 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -14,37 +14,50 @@ / {
>  	#size-cells = <2>;
> 
>  	cpus {
> -		#address-cells = <2>;
> +		#address-cells = <1>;
>  		#size-cells = <0>;
> -
> +
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x0>;
> -			enable-method = "psci";
> +			reg = <0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
>  		};
> 
>  		cpu1: cpu@1 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x1>;
> -			enable-method = "psci";
> +			reg = <0x1>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
>  		};
> 
>  		cpu2: cpu@2 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x2>;
> -			enable-method = "psci";
> +			reg = <0x2>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
>  		};
> 
>  		cpu3: cpu@3 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a53";
> -			reg = <0x0 0x3>;
> -			enable-method = "psci";
> +			reg = <0x3>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0 0x1f000020>;
> +			next-level-cache = <&L2>;
>  		};
>  	};
> +
> +	L2: l2-cache {
> +		compatible = "cache";
> +		cache-level = <2>;
> +	};
> 
>  	reserved-memory {
>  		#address-cells = <2>;
> 

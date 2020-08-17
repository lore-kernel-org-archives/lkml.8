Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02215C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAE220758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597651370;
	bh=GFEJS3Rr7vYY2tqPLGzJrpsNU961dcnYNV4ZC8aZQJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dp/pm+biab3mt+TM8zwLvlnr1OfPFCrkVMW7sTqier6LHW3uge9vBhYbxNDgurndN
	 RVmZH721d8KJeFBdqJxxymjM1UC/Qf3tJ5Fo0BxFayN/Xnnph6owtf67J4+972xpD1
	 PjDrPxxiwrDA2knvpUwBCtDBqJTHbac567Be2eLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHQICt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgHQICs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:02:48 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD9220758;
        Mon, 17 Aug 2020 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597651367;
        bh=GFEJS3Rr7vYY2tqPLGzJrpsNU961dcnYNV4ZC8aZQJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oWSW8ITpIE5G5BZuEXLG7Uhsc/3cXKV8I5Z98gLgTxD1NLb/kxTgGK/sEL5EMJMF0
         SRrkxMpMFAgSQghzqRVOK6pMgfgcB50mOGDYcbUfz2hPpAu7sIxj79djDpHrNycQBa
         irGiwtgQOfy2cMmsJPxLYIHGzlm/9crR5OlfVaoQ=
Date:   Mon, 17 Aug 2020 16:02:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     andy.tang@nxp.com, amit.kucheria@linaro.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] arm64: dts: ls1088a: add more thermal zone support
Message-ID: <20200817080233.GC16951@dragon>
References: <20200715064909.9161-1-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715064909.9161-1-andy.tang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 02:49:08PM +0800, andy.tang@nxp.com wrote:
> From: Yuantian Tang <andy.tang@nxp.com>
> 
> There are 2 thermal zones in ls1088a soc. Add the other thermal zone
> node to enable it.
> Also update the values in calibration table to make the temperatures
> monitored more precise.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v2:
> 	- remove useless alert trip

@Amit, looks good to you?

Shawn

> 
>  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 94 +++++++++++--------
>  1 file changed, 56 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 169f4742ae3b..b961a896ede7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -130,19 +130,19 @@
>  	};
>  
>  	thermal-zones {
> -		cpu_thermal: cpu-thermal {
> +		core-cluster {
>  			polling-delay-passive = <1000>;
>  			polling-delay = <5000>;
>  			thermal-sensors = <&tmu 0>;
>  
>  			trips {
> -				cpu_alert: cpu-alert {
> +				core_cluster_alert: core-cluster-alert {
>  					temperature = <85000>;
>  					hysteresis = <2000>;
>  					type = "passive";
>  				};
>  
> -				cpu_crit: cpu-crit {
> +				core-cluster-crit {
>  					temperature = <95000>;
>  					hysteresis = <2000>;
>  					type = "critical";
> @@ -151,7 +151,7 @@
>  
>  			cooling-maps {
>  				map0 {
> -					trip = <&cpu_alert>;
> +					trip = <&core_cluster_alert>;
>  					cooling-device =
>  						<&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  						<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> @@ -164,6 +164,20 @@
>  				};
>  			};
>  		};
> +
> +		soc {
> +			polling-delay-passive = <1000>;
> +			polling-delay = <5000>;
> +			thermal-sensors = <&tmu 1>;
> +
> +			trips {
> +				soc-crit {
> +					temperature = <95000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
>  	};
>  
>  	timer {
> @@ -210,45 +224,49 @@
>  			compatible = "fsl,qoriq-tmu";
>  			reg = <0x0 0x1f80000 0x0 0x10000>;
>  			interrupts = <0 23 0x4>;
> -			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x30062>;
> +			fsl,tmu-range = <0xb0000 0x9002a 0x6004c 0x70062>;
>  			fsl,tmu-calibration =
>  				/* Calibration data group 1 */
> -				<0x00000000 0x00000026
> -				0x00000001 0x0000002d
> -				0x00000002 0x00000032
> -				0x00000003 0x00000039
> -				0x00000004 0x0000003f
> -				0x00000005 0x00000046
> -				0x00000006 0x0000004d
> -				0x00000007 0x00000054
> -				0x00000008 0x0000005a
> -				0x00000009 0x00000061
> -				0x0000000a 0x0000006a
> -				0x0000000b 0x00000071
> +				<0x00000000 0x00000023
> +				0x00000001 0x0000002a
> +				0x00000002 0x00000030
> +				0x00000003 0x00000037
> +				0x00000004 0x0000003d
> +				0x00000005 0x00000044
> +				0x00000006 0x0000004a
> +				0x00000007 0x00000051
> +				0x00000008 0x00000057
> +				0x00000009 0x0000005e
> +				0x0000000a 0x00000064
> +				0x0000000b 0x0000006b
>  				/* Calibration data group 2 */
> -				0x00010000 0x00000025
> -				0x00010001 0x0000002c
> -				0x00010002 0x00000035
> -				0x00010003 0x0000003d
> -				0x00010004 0x00000045
> -				0x00010005 0x0000004e
> -				0x00010006 0x00000057
> -				0x00010007 0x00000061
> -				0x00010008 0x0000006b
> -				0x00010009 0x00000076
> +				0x00010000 0x00000022
> +				0x00010001 0x0000002a
> +				0x00010002 0x00000032
> +				0x00010003 0x0000003a
> +				0x00010004 0x00000042
> +				0x00010005 0x0000004a
> +				0x00010006 0x00000052
> +				0x00010007 0x0000005a
> +				0x00010008 0x00000062
> +				0x00010009 0x0000006a
>  				/* Calibration data group 3 */
> -				0x00020000 0x00000029
> -				0x00020001 0x00000033
> -				0x00020002 0x0000003d
> -				0x00020003 0x00000049
> -				0x00020004 0x00000056
> -				0x00020005 0x00000061
> -				0x00020006 0x0000006d
> +				0x00020000 0x00000021
> +				0x00020001 0x0000002b
> +				0x00020002 0x00000035
> +				0x00020003 0x00000040
> +				0x00020004 0x0000004a
> +				0x00020005 0x00000054
> +				0x00020006 0x0000005e
>  				/* Calibration data group 4 */
> -				0x00030000 0x00000021
> -				0x00030001 0x0000002a
> -				0x00030002 0x0000003c
> -				0x00030003 0x0000004e>;
> +				0x00030000 0x00000010
> +				0x00030001 0x0000001c
> +				0x00030002 0x00000027
> +				0x00030003 0x00000032
> +				0x00030004 0x0000003e
> +				0x00030005 0x00000049
> +				0x00030006 0x00000054
> +				0x00030007 0x00000060>;
>  			little-endian;
>  			#thermal-sensor-cells = <1>;
>  		};
> -- 
> 2.17.1
> 

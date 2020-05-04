Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579AAC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A002073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="mXiBIoZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgEDM1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:27:45 -0400
Received: from vps.xff.cz ([195.181.215.36]:43168 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDM1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1588595263; bh=cx1Wq/7T8zSIWAw0CJ2Ua2ok9FxZ6uruVV53kd6Dou4=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=mXiBIoZOCJxM3zaUrAN4zaH8dozS+wugPfYFvbDlIjp3zLG4XBLIyhhJz4rhHADEo
         VMr3vz52gep9H+nxz8AUrjIzyhWGN0/C51/3xjztVvV4foOiBsNM2nyYx4a31Y6OaJ
         dxr++0U8NgHVCpCXO3Tr5TQuIaT1nm4zsgsosEmw=
Date:   Mon, 4 May 2020 14:27:42 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>
Subject: Re: [linux-sunxi] [PATCH v2] arm64: dts: allwinner: h6: Use dummy
 regulator for Tanix TX6
Message-ID: <20200504122742.er2jd67bvrn2rfgp@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>
References: <20200428142629.8950-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428142629.8950-1-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On Tue, Apr 28, 2020 at 04:26:29PM +0200, Clément Péron wrote:
> Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> voltage to meet OPP table, the DVFS is not working as expected.
> 
> Avoid to introduce a new dedicated OPP Table where voltage are
> equals to the fixed regulator as it will only duplicate all the OPPs.
> Instead remove the fixed regulator so the DVFS framework will create
> dummy regulator and will have the same behavior.
> 
> Add some comments to explain this in the device-tree.
> 
> Reported-by: Piotr Oniszczuk <warpme@o2.pl>
> Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6")
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index be81330db14f..3e96fcb317ea 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -48,7 +48,15 @@
>  };
>  
>  &cpu0 {
> -	cpu-supply = <&reg_vdd_cpu_gpu>;
> +	/*
> +	 * Don't specify the CPU regulator, as it's a fixed
> +	 * regulator DVFS will not work as it is intructed
> +	 * to reach a voltage which can't be reached.
> +	 * Not specifying a regulator will create a dummy
> +	 * regulator allowing all OPPs.
> +	 *
> +	 * cpu-supply = <&reg_vdd_cpu_gpu>;
> +	 */

reg_vdd_cpu_gpu has 

    regulator-min-microvolt = <1135000>;
    regulator-max-microvolt = <1135000>;

top OPP is:

    opp@1800000000 {
            clock-latency-ns = <244144>; /* 8 32k periods */
            opp-hz = /bits/ 64 <1800000000>;

            opp-microvolt-speed0 = <1160000>;
            opp-microvolt-speed1 = <1100000>;
            opp-microvolt-speed2 = <1100000>;
    };

So I guess ignoring the voltage and not disabling this OPP may or may not work
based on SoC bin.

On Orange Pi One, there's a regulator that supports two voltages (that can't
support all the listed OPPs for H3), and cpufreq-dt can deal with that
automagically, if you specify OPP voltages via a tripplet of [prefered min max].
Kernell will log this in dmesg on boot:

[    0.672440] core: _opp_supported_by_regulators: OPP minuV: 1320000 maxuV: 1320000, not supported by regulator
[    0.672454] cpu cpu0: _opp_add: OPP not supported by regulators (1104000000)
[    0.672523] core: _opp_supported_by_regulators: OPP minuV: 1320000 maxuV: 1320000, not supported by regulator
[    0.672530] cpu cpu0: _opp_add: OPP not supported by regulators (1200000000)
[    0.672621] core: _opp_supported_by_regulators: OPP minuV: 1340000 maxuV: 1340000, not supported by regulator
[    0.672628] cpu cpu0: _opp_add: OPP not supported by regulators (1296000000)
[    0.672712] core: _opp_supported_by_regulators: OPP minuV: 1400000 maxuV: 1400000, not supported by regulator
[    0.672719] cpu cpu0: _opp_add: OPP not supported by regulators (1368000000)

And the list of available OPPs will be reduced at runtime to a supportable
set by the CPU regulator.

If you look at:

  https://megous.com/git/linux/commit/?h=ths-5.7&id=d231770195913cf543c0cf9539deee2ecec06680

you'll see a bunch of OPPs for H3 that are specified as a range. So
for example if you want 480MHz, and your regulator can't produce
1.04V exactly, cpufreq will set the voltage to something supportable
in the range.

I think the proper fix is to fix the OPP table for H6, so that it uses
voltage ranges for each OPP and not a single fixed voltage, to support
boards that don't have the standard PMIC that goes with H6.

regards,
	o.

>  };
>  
>  &de {
> @@ -68,7 +76,13 @@
>  };
>  
>  &gpu {
> -	mali-supply = <&reg_vdd_cpu_gpu>;
> +	/*
> +	 * Don't specify the GPU regulator, see comment
> +	 * above for the CPU supply.
> +	 *
> +	 * mali-supply = <&reg_vdd_cpu_gpu>;
> +	 */
> +
>  	status = "okay";
>  };
>  
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200428142629.8950-1-peron.clem%40gmail.com.

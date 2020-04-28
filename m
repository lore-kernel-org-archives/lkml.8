Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A376C83009
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DEB21BE5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgD1PVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:21:39 -0400
Received: from foss.arm.com ([217.140.110.172]:54022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgD1PVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B23530E;
        Tue, 28 Apr 2020 08:21:32 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72243F305;
        Tue, 28 Apr 2020 08:21:30 -0700 (PDT)
Subject: Re: [PATCH v2] arm64: dts: allwinner: h6: Use dummy regulator for
 Tanix TX6
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>,
        linux-arm-kernel@lists.infradead.org
References: <20200428142629.8950-1-peron.clem@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <98246e5d-ebef-bcb5-f0b8-d74b3834b835@arm.com>
Date:   Tue, 28 Apr 2020 16:21:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428142629.8950-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-28 3:26 pm, Clément Péron wrote:
> Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> voltage to meet OPP table, the DVFS is not working as expected.

Hmm, isn't that really a bug in the DVFS code? I guess it's just blindly 
propagating -EINVAL from the fixed regulators not implementing 
set_voltage, but AFAICS it has no real excuse not to be cleverer and 
still allow switching frequency as long as the voltage *is* high enough 
for the given OPP. I wonder how well it works if the regulator is 
programmable but shared with other consumers... that case probably can't 
be hacked around in DT.

Robin.

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
>   .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index be81330db14f..3e96fcb317ea 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -48,7 +48,15 @@
>   };
>   
>   &cpu0 {
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
>   };
>   
>   &de {
> @@ -68,7 +76,13 @@
>   };
>   
>   &gpu {
> -	mali-supply = <&reg_vdd_cpu_gpu>;
> +	/*
> +	 * Don't specify the GPU regulator, see comment
> +	 * above for the CPU supply.
> +	 *
> +	 * mali-supply = <&reg_vdd_cpu_gpu>;
> +	 */
> +
>   	status = "okay";
>   };
>   
> 

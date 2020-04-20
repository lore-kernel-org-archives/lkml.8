Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595F3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFF520857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="VcwCEC+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgDTNqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:46:06 -0400
Received: from vps.xff.cz ([195.181.215.36]:57450 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgDTNqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1587390364; bh=lXFLLXv67CfUewvpws4scaGtSsPitz7siYHsuT7MR54=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=VcwCEC+Pfk0c/2AlQG1Fl8KKx5I7xrpdLVyQih6u2kxXdRe0i6NvuWdkX5cmjkT2y
         6jWeLwUS+6eoVpXnlt2omWpLTfAOLJ+P7WQoOP6D+mAKELXW6IUjImlyGYGo+kJMoy
         5YPHVmuBQuWv+0p4MoSqIjXB6sUFTf5RjvWI/akc=
Date:   Mon, 20 Apr 2020 15:46:04 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v5 2/9] arm64: dts: allwinner: h6: Add thermal trip
 points/cooling map
Message-ID: <20200420134604.bkjp66fjiggses7a@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200420130021.3841-1-peron.clem@gmail.com>
 <20200420130021.3841-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420130021.3841-3-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 20, 2020 at 03:00:14PM +0200, Clément Péron wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> This enables passive cooling by down-regulating CPU voltage
> and frequency.

Does this not produce a lot of warnings for you during compilation?

regards,
	o.

> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 370e77b86fe1..60da1627772b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -964,6 +964,30 @@
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 0>;
> +
> +			trips {
> +				cpu_alert: cpu-alert {
> +					temperature = <85000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu-crit {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		gpu-thermal {
> -- 
> 2.20.1
> 

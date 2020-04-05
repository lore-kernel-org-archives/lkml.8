Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74559C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E9D20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="eW2k5TeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgDELYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:24:11 -0400
Received: from vps.xff.cz ([195.181.215.36]:37452 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgDELYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1586085849; bh=QY9Q7XhPkDOAvJvjFhI09s7uaGOfN/GI8egEfmyZajg=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=eW2k5TeS8ZTpaYYemfbZP+CQujIJUdxTTMBMfsdm58FNEmhftEgEqRJqr0nWSSO+z
         apZfhPIxZEVNsgdEgbVZIPUfRwvtgy9dNdH9HdavAbgnPesVTrAM/8g+GKrTjbF+L2
         3+YcWOpPNMIZQ1eDXEIX5+flxI9N0TT29MajBtgU=
Date:   Sun, 5 Apr 2020 13:24:09 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 3/7] arm64: dts: allwinner: h6: set thermal
 polling time
Message-ID: <20200405112409.gl6kn7cjakwludf6@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
 <20200405104913.22806-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200405104913.22806-4-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Apr 05, 2020 at 12:49:09PM +0200, Clément Péron wrote:
> Add reasonable thermal polling time for Allwinner H6.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index d4d3963705f5..c3e4f09f60ce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -905,8 +905,8 @@
>  
>  	thermal-zones {
>  		cpu-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
> +			polling-delay-passive = <100>;
> +			polling-delay = <1000>;
>  			thermal-sensors = <&ths 0>;

This is not necessary, and will not do anything useful, since the driver
uses interrupts to update the thermal zone's temperature. Please keep the
values at 0.

With your settings the thermal zone would just add a polling timer in addition
to being updated every 250ms via THS interrupt. The real thermal measurements
are available every 250ms anyway, so setting a smaller period here will not do
anything useful, and 1s period will not lead to slower updates either.

Values of 0 mean tell the thermal zone to rely on thermal driver to update
the thermal zone by itself (via interrupt) and to not poll.

regards,
	o.

>  			trips {
> @@ -935,8 +935,8 @@
>  		};
>  
>  		gpu-thermal {
> -			polling-delay-passive = <0>;
> -			polling-delay = <0>;
> +			polling-delay-passive = <100>;
> +			polling-delay = <1000>;
>  			thermal-sensors = <&ths 1>;
>  		};
>  	};
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200405104913.22806-4-peron.clem%40gmail.com.

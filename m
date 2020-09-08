Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99016C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F6B21D1A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599550424;
	bh=PVSSlZ7Uaf8BkjWldKCFBALWWbApIq8zDDF8hQ5P0tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gKpFY7ijhWU0rYedHG+Bg/GtTEoxzJhc/qjmq1qeB/QPLduV5knWJMMnLlaofWNs8
	 tF8UUExMOlzH+unT3QLdoA8WsLtdl76FXdDQdsStIDz8RPmuhIewJL43AYj8fpxAAk
	 4GJKYBq4+4PhB+CeCaIjhPLLFtRaSIb4io+kwkBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgIHHdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgIHHdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:33:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F1E218AC;
        Tue,  8 Sep 2020 07:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599550416;
        bh=PVSSlZ7Uaf8BkjWldKCFBALWWbApIq8zDDF8hQ5P0tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VaselhRfYKFR7jx3vh6moUnhaMD7gSgAEyQEgiqk7aW9rmkZ4yYb+4kGU4tjPfnXI
         syIkg3Ahe1Zb/Phl3r5TwMHTlr1hcVt0HlevnPJiI0aj+zpIGgtoWgo0L3+fNL9V4u
         i7SZDaKVgrGxQ/L/D+LcAwozWhhlTTsxt5LQ/SMA=
Received: by pali.im (Postfix)
        id 9D231617; Tue,  8 Sep 2020 09:33:33 +0200 (CEST)
Date:   Tue, 8 Sep 2020 09:33:33 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Simplify v7 ethernet
 port labeling
Message-ID: <20200908073333.i4mpjfcay42kkhq5@pali>
References: <20200908073050.535919-1-a.heider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200908073050.535919-1-a.heider@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 September 2020 09:30:50 Andre Heider wrote:
> Now that the switch ports have a label in the .dtsi, simplify the whole
> "switch0" block for the v7 dts files.
> 
> Signed-off-by: Andre Heider <a.heider@gmail.com>

Thank you, looks good!

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> 
> This goes on top of Pali's patch:
> "arm64: dts: marvell: espressobin: Add ethernet switch aliases"
> 
> The resulting .dtb files are the same.
> 
>  .../armada-3720-espressobin-v7-emmc.dts        | 18 +++++-------------
>  .../dts/marvell/armada-3720-espressobin-v7.dts | 18 +++++-------------
>  2 files changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 215d2f702623..61d49d6a2a2a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -28,20 +28,12 @@ aliases {
>  	};
>  };
>  
> -&switch0 {
> -	ports {
> -		switch0port1: port@1 {
> -			reg = <1>;
> -			label = "lan1";
> -			phy-handle = <&switch0phy0>;
> -		};
> +&switch0port1 {
> +	label = "lan1";
> +};
>  
> -		switch0port3: port@3 {
> -			reg = <3>;
> -			label = "wan";
> -			phy-handle = <&switch0phy2>;
> -		};
> -	};
> +&switch0port3 {
> +	label = "wan";
>  };
>  
>  /* U11 */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index b6f4af8ebafb..44dbe9a21cc7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -27,18 +27,10 @@ aliases {
>  	};
>  };
>  
> -&switch0 {
> -	ports {
> -		switch0port1: port@1 {
> -			reg = <1>;
> -			label = "lan1";
> -			phy-handle = <&switch0phy0>;
> -		};
> +&switch0port1 {
> +	label = "lan1";
> +};
>  
> -		switch0port3: port@3 {
> -			reg = <3>;
> -			label = "wan";
> -			phy-handle = <&switch0phy2>;
> -		};
> -	};
> +&switch0port3 {
> +	label = "wan";
>  };
> -- 
> 2.28.0
> 

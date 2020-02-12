Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB01C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8801720848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="YHPiQ7g5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBLMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:25:13 -0500
Received: from vps.xff.cz ([195.181.215.36]:54674 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbgBLMZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1581510311; bh=Md1F98Lg+g/HU1RRReO7O1H/L3IW/4YK8o6LZMkQlyM=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=YHPiQ7g5CDLI2SQwq8GbZn1D1eBXr70YPQR6bVa+d8uRZlFDYzj/d6kGABbpizLYx
         s61V7ay7LF4Q60uP1Aoc6WlgxdDEvrqbG/yPn9WA4UEHL/P45m+lixnFAw/NlymuD+
         +COVYAETOIrwnsbPjmE1VON8OCYRIGg8cScOyv6k=
Date:   Wed, 12 Feb 2020 13:25:11 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v2] arm64: dts: allwinner: h6: orangepi-3:
 Add eMMC node
Message-ID: <20200212122511.5gr6m4ppmytq4ajj@core.my.home>
Mail-Followup-To: Jernej Skrabec <jernej.skrabec@siol.net>,
        mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200210174007.118575-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210174007.118575-1-jernej.skrabec@siol.net>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 10, 2020 at 06:40:07PM +0100, Jernej Skrabec wrote:
> OrangePi 3 can optionally have 8 GiB eMMC (soldered on board). Because
> those pins are dedicated to eMMC exclusively, node can be added for both
> variants (with and without eMMC). Kernel will then scan bus for presence
> of eMMC and act accordingly.

Tested-by: Ondrej Jirman <megous@megous.com> (on a variant without eMMC)

It didn't magically add extra 8GiB of storage, but it didn't break anything
either. :)

regards,
	o.

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
> Changes since v1:
> - don't make separate DT just for -emmc variant - add node to existing
>   orangepi 3 DT
> 
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> index c311eee52a35..1e0abd9d047f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
> @@ -144,6 +144,15 @@ brcm: sdio-wifi@1 {
>  	};
>  };
>  
> +&mmc2 {
> +	vmmc-supply = <&reg_cldo1>;
> +	vqmmc-supply = <&reg_bldo2>;
> +	cap-mmc-hw-reset;
> +	non-removable;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
>  &ohci0 {
>  	status = "okay";
>  };
> -- 
> 2.25.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200210174007.118575-1-jernej.skrabec%40siol.net.

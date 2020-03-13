Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8E8205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgCMUaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:30:17 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59585 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:30:16 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 88FC2FF808;
        Fri, 13 Mar 2020 20:30:06 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>, jason@lakedaemon.net,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: add ethernet alias
In-Reply-To: <20200227165232.11263-1-tmn505@gmail.com>
References: <20200227165232.11263-1-tmn505@gmail.com>
Date:   Fri, 13 Mar 2020 21:30:06 +0100
Message-ID: <875zf8yp4h.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

> The maker of this board and its variants, stores MAC address in U-Boot
> environment. Add alias for bootloader to recognise, to which ethernet
> node inject the factory MAC address.
>
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index c8e2e993c69c..42e992f9c8a5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -11,6 +11,12 @@
>  #include "armada-372x.dtsi"
>  
>  / {
> +	aliases {
> +		ethernet0 = &eth0;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
>  	chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

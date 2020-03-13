Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9784C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918242074B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCMUfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:35:31 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40789 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCMUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:35:31 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3A460240009;
        Fri, 13 Mar 2020 20:35:27 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] arm64: dts: marvell: fix non-existed cpu referrence in armada-ap806-dual.dtsi
In-Reply-To: <20200209212016.27062-1-vadym.kochan@plvision.eu>
References: <20200209212016.27062-1-vadym.kochan@plvision.eu>
Date:   Fri, 13 Mar 2020 21:35:26 +0100
Message-ID: <87v9n8xab5.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadym,

> armada-ap806-dual.dtsi includes armada-ap806.dtsi which describes
> thermal zones for 4 cpus but only cpu0 and cpu1 only exists for dual
> configuration, this makes dtb compilation fail. Fix it by removing
> thermal zone nodes for non-existed cpus for dual configuration.
>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> index 09849558a776..fcab5173fe67 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> @@ -53,4 +53,9 @@
>  			cache-sets = <512>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		/delete-node/ ap-thermal-cpu2;
> +		/delete-node/ ap-thermal-cpu3;
> +	};
>  };
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

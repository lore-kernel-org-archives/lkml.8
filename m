Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F21C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6FB205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCMUc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:32:59 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:49123 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgCMUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:32:59 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 327F51C0005;
        Fri, 13 Mar 2020 20:32:57 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: marvell: build ESPRESSObin variants
In-Reply-To: <20200227164842.11116-2-tmn505@gmail.com>
References: <20200227164842.11116-1-tmn505@gmail.com> <20200227164842.11116-2-tmn505@gmail.com>
Date:   Fri, 13 Mar 2020 21:32:56 +0100
Message-ID: <87zhckxafb.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

> The commit adding ESPRESSObin variants didn't include those in Makefile to
> be built.
>
> Fixes: 447b878935 ("arm64: dts: marvell: add ESPRESSObin variants")
> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>


Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> index f1b5127f0b89..3e5f2e7a040c 100644
> --- a/arch/arm64/boot/dts/marvell/Makefile
> +++ b/arch/arm64/boot/dts/marvell/Makefile
> @@ -2,6 +2,9 @@
>  # Mvebu SoC Family
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7.dtb
> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
>  dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

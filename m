Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7788AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538A820809
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEQQXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 12:23:40 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58055 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgEQQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 12:23:39 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8471020002;
        Sun, 17 May 2020 16:23:28 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: clarify maintenance of ARM Dove drivers
In-Reply-To: <20200328134304.7317-1-lukas.bulwahn@gmail.com>
References: <20200328134304.7317-1-lukas.bulwahn@gmail.com>
Date:   Sun, 17 May 2020 18:23:28 +0200
Message-ID: <87blmmh6nz.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

> Commit 44e259ac909f ("ARM: dove: create a proper PMU driver for power
> domains, PMU IRQs and resets") introduced new drivers for the ARM Dove SOC,
> but did not add those drivers to the existing entry ARM/Marvell
> Dove/MV78xx0/Orion SOC support in MAINTAINERS. Hence, these drivers were
> considered to be part of "THE REST".
>
> Clarify now that these drivers are maintained by the ARM/Marvell
> Dove/MV78xx0/Orion SOC support maintainers.

> Also order the T: entry to the
> place it belongs to, while at it.

In 5.7-rc1 Linus took care of it, so I removed this part ofthe commit
log.

>
> This was identified with a small script that finds all files only belonging
> to "THE REST" according to the current MAINTAINERS file, and I acted upon
> its output.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>


Applied on mvebu/arm

Thanks,

Gregory


> ---
> applies cleanly on current master and on next-20200327
>
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8b8abe756ae0..38fff0374082 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1979,6 +1979,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>  M:	Gregory Clement <gregory.clement@bootlin.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> +T:	git git://git.infradead.org/linux-mvebu.git
>  F:	Documentation/devicetree/bindings/soc/dove/
>  F:	arch/arm/mach-dove/
>  F:	arch/arm/mach-mv78xx0/
> @@ -1986,7 +1987,7 @@ F:	arch/arm/mach-orion5x/
>  F:	arch/arm/plat-orion/
>  F:	arch/arm/boot/dts/dove*
>  F:	arch/arm/boot/dts/orion5x*
> -T:	git git://git.infradead.org/linux-mvebu.git
> +F:	drivers/soc/dove/
>  
>  ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
>  M:	Jason Cooper <jason@lakedaemon.net>
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332E4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F93821569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgAURNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:13:49 -0500
Received: from [167.172.186.51] ([167.172.186.51]:33326 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729080AbgAURNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:13:48 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9F8C1DFB9D;
        Tue, 21 Jan 2020 17:13:55 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id egpkrthuXcvC; Tue, 21 Jan 2020 17:13:55 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F3CF4DFE6D;
        Tue, 21 Jan 2020 17:13:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fa5bH0yR5lYx; Tue, 21 Jan 2020 17:13:54 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 92789DFB9D;
        Tue, 21 Jan 2020 17:13:54 +0000 (UTC)
Date:   Tue, 21 Jan 2020 18:13:43 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/20] ARM: mmp: Drop unneeded select of COMMON_CLK
Message-ID: <20200121171343.GA171627@furthur.local>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-13-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121103722.1781-13-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:37:15AM +0100, Geert Uytterhoeven wrote:
> Support for Marvell MMP ARMv5 platforms depends on ARCH_MULTI_V5, and
> thus on ARCH_MULTIPLATFORM.
> As the latter selects COMMON_CLK, there is no need for MACH_MMP_DT to
> select COMMON_CLK.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

Thank you
Lubo

> ---
> All patches in this series are independent of each other.
> Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be
> 
>  arch/arm/mach-mmp/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
> index b58a03b18bdef14c..6fe1550f43ec6aef 100644
> --- a/arch/arm/mach-mmp/Kconfig
> +++ b/arch/arm/mach-mmp/Kconfig
> @@ -110,7 +110,6 @@ config MACH_MMP_DT
>  	depends on ARCH_MULTI_V5
>  	select PINCTRL
>  	select PINCTRL_SINGLE
> -	select COMMON_CLK
>  	select ARCH_HAS_RESET_CONTROLLER
>  	select CPU_MOHAWK
>  	help
> -- 
> 2.17.1
> 

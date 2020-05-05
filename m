Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35845C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16348206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgEEPuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:50:06 -0400
Received: from v6.sk ([167.172.42.174]:40488 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgEEPuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:50:06 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8809B610CA;
        Tue,  5 May 2020 15:49:33 +0000 (UTC)
Date:   Tue, 5 May 2020 17:49:30 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: mmp: Replace <linux/clk-provider.h> by
 <linux/of_clk.h>
Message-ID: <20200505154930.GC1997@furthur.local>
References: <20200505154536.4099-1-geert+renesas@glider.be>
 <20200505154536.4099-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154536.4099-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:45:36PM +0200, Geert Uytterhoeven wrote:
> The Marvell MMP platform code is not a clock provider, and just needs to
> call of_clk_init().
> 
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
> v2:
>   - Add Reviewed-by.
> ---
>  arch/arm/mach-mmp/mmp-dt.c  | 2 +-
>  arch/arm/mach-mmp/mmp2-dt.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
> index 91214996acecc9fb..3f43c0867dcae4ed 100644
> --- a/arch/arm/mach-mmp/mmp-dt.c
> +++ b/arch/arm/mach-mmp/mmp-dt.c
> @@ -8,7 +8,7 @@
>  
>  #include <linux/irqchip.h>
>  #include <linux/of_platform.h>
> -#include <linux/clk-provider.h>
> +#include <linux/of_clk.h>
>  #include <linux/clocksource.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
> index 510c762ddc484c40..34a5fe4b3949167e 100644
> --- a/arch/arm/mach-mmp/mmp2-dt.c
> +++ b/arch/arm/mach-mmp/mmp2-dt.c
> @@ -9,7 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_platform.h>
> -#include <linux/clk-provider.h>
> +#include <linux/of_clk.h>
>  #include <linux/clocksource.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> -- 
> 2.17.1
> 

Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBA6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05872465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 20:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAVUd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 15:33:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:42414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgAVUd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 15:33:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83EC1AFBB;
        Wed, 22 Jan 2020 20:33:24 +0000 (UTC)
Subject: Re: [PATCH 01/20] ARM: actions: Drop unneeded select of COMMON_CLK
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <c1a790fa-4c60-b054-0f85-412f40e0dec9@suse.de>
Date:   Wed, 22 Jan 2020 21:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.01.20 um 11:37 schrieb Geert Uytterhoeven:
> Support for Actions Semi SoCs depends on ARCH_MULTI_V7, and thus on
> ARCH_MULTIPLATFORM.
> As the latter selects COMMON_CLK, there is no need for ARCH_ACTIONS to
> select COMMON_CLK.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Andreas Färber <afaerber@suse.de>

Reviewed-by: Andreas Färber <afaerber@suse.de>

> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> All patches in this series are independent of each other.
> Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be
> 
>   arch/arm/mach-actions/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-actions/Kconfig b/arch/arm/mach-actions/Kconfig
> index b5e0ac965ec0dd10..00fb4babccdd991b 100644
> --- a/arch/arm/mach-actions/Kconfig
> +++ b/arch/arm/mach-actions/Kconfig
> @@ -7,7 +7,6 @@ menuconfig ARCH_ACTIONS
>   	select ARM_GLOBAL_TIMER
>   	select CACHE_L2X0
>   	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> -	select COMMON_CLK
>   	select GENERIC_IRQ_CHIP
>   	select HAVE_ARM_SCU if SMP
>   	select HAVE_ARM_TWD if SMP

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

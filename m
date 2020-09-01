Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D1C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE5B206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgIANgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:36:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55092 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgIANeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:34:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id BDFD8281E3A
Subject: Re: [PATCH v2 1/4] ARM: exynos: clear L310_AUX_CTRL_NS_LOCKDOWN in
 default l2c_aux_val
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
Message-ID: <c0509b5f-a064-2e73-7e04-51f41a56d222@collabora.com>
Date:   Tue, 1 Sep 2020 14:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <267a81e550a0b5d479c82b5908e2a2caa4c9c874.1597061474.git.guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Russell,

On 10/08/2020 13:22, Guillaume Tucker wrote:
> The L310_AUX_CTRL_NS_LOCKDOWN flag is set during the L2C enable
> sequence.  There is no need to set it in the default register value,
> this was done before support for it was implemented in the code.  It
> is not set in the hardware initial value either.
> 
> Clean this up by removing this flag from the default l2c_aux_val, and
> add it to the l2c_aux_mask to print an alert message if it was already
> set before the kernel initialisation.
> 
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
> 
> Notes:
>     v2: fix flag name L310_AUX_CTRL_NS_LOCKDOWN
> 
>  arch/arm/mach-exynos/exynos.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I believe this v2 series has addressed all previous comments and
you were waiting for the 5.9 merge window to end.  The patches
all still apply cleanly on v5.9-rc3.  Do you want me to resend
the series anyway or is there anything else needed at this point?

Maybe one thing that wasn't completely clear in v1 was whether
patch 2/4 was the right approach.  I've explained the reason
behind it but didn't get a final reply from Russell[1].

Best wishes,
Guillaume


[1] https://lore.kernel.org/lkml/46fa1159-fcd6-b528-b8e8-2fba048236b2@collabora.com/


> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 36c37444485a..a96f3353a0c1 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -193,8 +193,8 @@ static void __init exynos_dt_fixup(void)
>  }
>  
>  DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
> -	.l2c_aux_val	= 0x3c400000,
> -	.l2c_aux_mask	= 0xc20fffff,
> +	.l2c_aux_val	= 0x38400000,
> +	.l2c_aux_mask	= 0xc60fffff,
>  	.smp		= smp_ops(exynos_smp_ops),
>  	.map_io		= exynos_init_io,
>  	.init_early	= exynos_firmware_init,
> 


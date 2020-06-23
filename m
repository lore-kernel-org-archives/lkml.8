Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A0CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655CA2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbgFWPTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:19:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40972 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732781AbgFWPTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:19:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id D2BD52A0D7C
Subject: Re: krzysztof/for-next bisection: baseline.dmesg.crit on
 bcm2837-rpi-3-b
To:     kernelci-results@groups.io, Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>
References: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <17e2a135-274d-19d5-be26-58ec106cf0b5@collabora.com>
Date:   Tue, 23 Jun 2020 16:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5ef21053.1c69fb81.b80ec.8649@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 15:23, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> krzysztof/for-next bisection: baseline.dmesg.crit on bcm2837-rpi-3-b
> 
> Summary:
>   Start:      d6fe116541b7 Merge branch 'next/soc' into for-next
>   Plain log:  https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-gd6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.txt
>   HTML log:   https://storage.kernelci.org/krzysztof/for-next/v5.8-rc1-14-gd6fe116541b7/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html
>   Result:     5b17a04addc2 ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       krzysztof
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
>   Branch:     for-next
>   Target:     bcm2837-rpi-3-b
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
>   Test case:  baseline.dmesg.crit

The "crit" kernel message is:

[   17.566555] hwmon hwmon1: Undervoltage detected!

which does not seem to have anything to do with the patch found
by the bisection.  Also, the bcm2837-rpi-3-b uses Cortex-A53
cores and no L2C-310 cache.

This undervoltage issue is actually an intermittent issue that
was already present before.  See next-20200616:

  https://kernelci.org/test/case/id/5ee880c10e8d4cd38797bf52/
  https://storage.kernelci.org/next/master/next-20200616/arm64/defconfig/gcc-8/lab-baylibre/baseline-bcm2837-rpi-3-b.html#L708

I'll still take a closer look to be sure this is actually noise.
The same revision built without CONFIG_RAMDOMIZE_BASE=y passed
fine, although I don't see how this could be related:

  https://kernelci.org/test/plan/id/5ef1ccb2d9df2557d597bf20/

Maybe the rpi-3-b could get an undervoltage depending on the
address where the kernel was loaded, and somehow my patch would
make this more likely?  It sounds so far-fetched...

This is so ironic - after 6 months with no false positives in
kernelci bisections, and this rpi-3-b issue too random to ever
cause a bisection to succeed, I get this report which landed a
commit that I made, one week after enabling public bisection
email reports again.  It must be trying to tell me something :)

Guillaume


> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 5b17a04addc29201dc142c8d2c077eb7745d2e35
> Author: Guillaume Tucker <guillaume.tucker@collabora.com>
> Date:   Fri Jun 12 14:58:37 2020 +0100
> 
>     ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
>     
>     This "alert" error message can be seen on exynos4412-odroidx2:
>     
>         L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
>         L2C: platform provided aux values permit register corruption.
>     
>     Followed by this plain error message:
>     
>         L2C-310: enabling full line of zeros but not enabled in Cortex-A9
>     
>     To fix it, don't set the L310_AUX_CTRL_FULL_LINE_ZERO flag (bit 0) in
>     the default value of l2c_aux_val.  It may instead be enabled when
>     applicable by the logic in l2c310_enable() if the attribute
>     "arm,full-line-zero-disable" was set in the device tree.
>     
>     The initial commit that introduced this default value was in v2.6.38
>     commit 1cf0eb799759 ("ARM: S5PV310: Add L2 cache init function in
>     cpu.c").
>     
>     However, the code to set the L310_AUX_CTRL_FULL_LINE_ZERO flag and
>     manage that feature was added much later and the default value was not
>     updated then.  So this seems to have been a subtle oversight
>     especially since enabling it only in the cache and not in the A9 core
>     doesn't actually prevent the platform from running.  According to the
>     TRM, the opposite would be a real issue, if the feature was enabled in
>     the A9 core but not in the cache controller.
>     
>     Reported-by: "kernelci.org bot" <bot@kernelci.org>
>     Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>     Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index 7a8d1555db40..36c37444485a 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -193,7 +193,7 @@ static void __init exynos_dt_fixup(void)
>  }
>  
>  DT_MACHINE_START(EXYNOS_DT, "Samsung Exynos (Flattened Device Tree)")
> -	.l2c_aux_val	= 0x3c400001,
> +	.l2c_aux_val	= 0x3c400000,
>  	.l2c_aux_mask	= 0xc20fffff,
>  	.smp		= smp_ops(exynos_smp_ops),
>  	.map_io		= exynos_init_io,
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [b0953d8b7cdb39493e67cff4b20b0ebe3a2bba92] Merge branch 'next/drivers' into for-next
> git bisect good b0953d8b7cdb39493e67cff4b20b0ebe3a2bba92
> # bad: [d6fe116541b73a56110310c39a270c99766cd909] Merge branch 'next/soc' into for-next
> git bisect bad d6fe116541b73a56110310c39a270c99766cd909
> # bad: [5b17a04addc29201dc142c8d2c077eb7745d2e35] ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
> git bisect bad 5b17a04addc29201dc142c8d2c077eb7745d2e35
> # first bad commit: [5b17a04addc29201dc142c8d2c077eb7745d2e35] ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val
> -------------------------------------------------------------------------------
> 


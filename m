Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D2CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384A5218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgBFKA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:00:29 -0500
Received: from foss.arm.com ([217.140.110.172]:56630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgBFKA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:00:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7581FB;
        Thu,  6 Feb 2020 02:00:28 -0800 (PST)
Received: from [10.1.36.209] (e121487-lin.cambridge.arm.com [10.1.36.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315B43F6CF;
        Thu,  6 Feb 2020 02:00:26 -0800 (PST)
Subject: Re: [PATCH] arm: make kexec depend on MMU
To:     Stefan Agner <stefan@agner.ch>, linux@armlinux.org.uk
Cc:     Michal Hocko <mhocko@suse.com>, arnd@arndb.de,
        linus.walleij@linaro.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        benjamin.gaignard@linaro.org, mchehab+samsung@kernel.org,
        armlinux@m.disordat.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>
References: <5b595d37283f043df78259221f2b7d18e0cb0ce5.1580942558.git.stefan@agner.ch>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <14e4919a-0089-c2e7-567c-1e7fcfef9769@arm.com>
Date:   Thu, 6 Feb 2020 10:00:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5b595d37283f043df78259221f2b7d18e0cb0ce5.1580942558.git.stefan@agner.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/20 10:43 PM, Stefan Agner wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> arm nommu config with KEXEC enabled doesn't compile
> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
> use in this function)
>              crash_size, SECTION_SIZE);
> 
> since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
> over one year without anybody noticing. I have only noticed beause of
> my testing nommu config which somehow gained CONFIG_KEXEC without
> an intention. This suggests that nobody is actually using KEXEC
> on nommu ARM configs. It is even a question whether kexec works with
> nommu.
> 
> Make KEXEC depend on MMU to make this clear. If somebody wants to enable
> there will be probably more things to take care.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 96dab76da3b3..59ce8943151f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1906,6 +1906,7 @@ config KEXEC
>  	bool "Kexec system call (EXPERIMENTAL)"
>  	depends on (!SMP || PM_SLEEP_SMP)
>  	depends on !CPU_V7M
> +	depends on MMU
>  	select KEXEC_CORE
>  	help
>  	  kexec is a system call that implements the ability to shutdown your
> 

Vincenzo sent similar patch [1] some time ago. I prefer his patch since CPU_V7M already imply !MMU.

[1] https://lore.kernel.org/linux-arm-kernel/20200110123125.51092-1-vincenzo.frascino@arm.com/T/

Cheers
Vladimir

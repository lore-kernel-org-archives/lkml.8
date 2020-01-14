Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B1C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAA42187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgANNoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:44:32 -0500
Received: from foss.arm.com ([217.140.110.172]:52428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbgANNoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:44:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E6841435;
        Tue, 14 Jan 2020 05:44:31 -0800 (PST)
Received: from [240.8.37.10] (unknown [10.37.8.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DA943F534;
        Tue, 14 Jan 2020 05:44:27 -0800 (PST)
Subject: Re: [PATCH] arm: Fix Kexec compilation issue.
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200110123125.51092-1-vincenzo.frascino@arm.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <27d511d6-90de-02f1-733b-e177462dffab@arm.com>
Date:   Tue, 14 Jan 2020 13:44:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200110123125.51092-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 12:31 PM, Vincenzo Frascino wrote:
> To perform the reserve_crashkernel() operation kexec uses SECTION_SIZE to
> find a memblock in a range.
> SECTION_SIZE is not defined for nommu systems. Trying to compile kexec in
> these conditions results in a build error:
> 
>   linux/arch/arm/kernel/setup.c: In function ‘reserve_crashkernel’:
>   linux/arch/arm/kernel/setup.c:1016:25: error: ‘SECTION_SIZE’ undeclared
>      (first use in this function); did you mean ‘SECTIONS_WIDTH’?
>              crash_size, SECTION_SIZE);
>                          ^~~~~~~~~~~~
>                          SECTIONS_WIDTH
>   linux/arch/arm/kernel/setup.c:1016:25: note: each undeclared identifier
>      is reported only once for each function it appears in
>   linux/scripts/Makefile.build:265: recipe for target 'arch/arm/kernel/setup.o'
>      failed
> 
> Make KEXEC depend on MMU to fix the compilation issue.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ba75e3661a41..bc99582bdc85 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1904,7 +1904,7 @@ config XIP_DEFLATED_DATA
>  config KEXEC
>  	bool "Kexec system call (EXPERIMENTAL)"
>  	depends on (!SMP || PM_SLEEP_SMP)
> -	depends on !CPU_V7M
> +	depends on MMU
>  	select KEXEC_CORE
>  	help
>  	  kexec is a system call that implements the ability to shutdown your
> 

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir

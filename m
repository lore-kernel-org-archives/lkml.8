Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BC0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105824680
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgBNLzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:55:24 -0500
Received: from foss.arm.com ([217.140.110.172]:60256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgBNLzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:55:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27A791FB;
        Fri, 14 Feb 2020 03:55:24 -0800 (PST)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88C1F3F68F;
        Fri, 14 Feb 2020 03:55:21 -0800 (PST)
Subject: Re: [patch V2 04/17] ARM: vdso: Compile high resolution parts
 conditionally
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
References: <20200207123847.339896630@linutronix.de>
 <20200207124402.622587341@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <9e6dda40-66ee-f4cc-9931-da3bb832472c@arm.com>
Date:   Fri, 14 Feb 2020 11:55:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207124402.622587341@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 12:38 PM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> If the architected timer is disabled in the kernel configuration then let
> the core VDSO code drop the high resolution parts at compile time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm/include/asm/vdso/gettimeofday.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- a/arch/arm/include/asm/vdso/gettimeofday.h
> +++ b/arch/arm/include/asm/vdso/gettimeofday.h
> @@ -106,6 +106,12 @@ static __always_inline int clock_getres3
>  	return ret;
>  }
>  
> +static inline bool arm_vdso_hres_capable(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM_ARCH_TIMER);
> +}
> +#define __arch_vdso_hres_capable arm_vdso_hres_capable
> +
>  static __always_inline u64 __arch_get_hw_counter(int clock_mode)
>  {
>  #ifdef CONFIG_ARM_ARCH_TIMER
> 

-- 
Regards,
Vincenzo

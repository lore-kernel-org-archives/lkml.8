Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7534D2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593697949;
	bh=DoDqXqmrd3oM09yjqOF1BqRub857Xf66aLnPbcmfgw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rcA2wnqXJbgkt7vLALGZqJv1ck74o2CNsmIyFboAQK9feiDfexBDyB/2xSijNlns9
	 Qgaa0fMIWdjHt8aDb/REgWEL9swXxSrXYrs0xrHTn6M9ieXnD3ZSWfni4ZYNwexQc5
	 jSi36tLkF0XTbFE8qxx4Txo1mUxgP45ay61AzYkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgGBNw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgGBNw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:52:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3B8620772;
        Thu,  2 Jul 2020 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593697947;
        bh=DoDqXqmrd3oM09yjqOF1BqRub857Xf66aLnPbcmfgw8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y2kvmOQO+uHgsfEzN56+/cG89ZHvlaemE2rI9ilz0cLz65/8Ja7mrD8oCpuyqBp1J
         Sh+9xqh0UHs0RyKSS/PZ/RG/K6bA3qRe8DgueFqkEXoq548z/SPsbuqbyDZINv4Pc0
         6MrNv6thF7kIg1GCGpvuovO/3p8Nuv7JF9rMpAU4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jqzdZ-008QCW-Cp; Thu, 02 Jul 2020 14:52:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Jul 2020 14:52:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 2/3] arm64: arch_timer: Allow an workaround descriptor to
 provide vdso_clock_mode
In-Reply-To: <20200702102859.GC15391@C02TD0UTHF1T.local>
References: <20200701161824.1346732-1-maz@kernel.org>
 <20200701161824.1346732-3-maz@kernel.org>
 <20200702102859.GC15391@C02TD0UTHF1T.local>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <82ce7e37d05dd184c2e225e5384ce77e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, daniel.lezcano@linaro.org, vincenzo.frascino@arm.com, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02 11:28, Mark Rutland wrote:
> On Wed, Jul 01, 2020 at 05:18:23PM +0100, Marc Zyngier wrote:
>> As we are about to disable the vdso for compat tasks in some 
>> circumstances,
>> let's allow a workaround descriptor to provide the vdso_clock_mode 
>> that
>> matches the platform.
>> 
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/include/asm/arch_timer.h  | 3 +++
>>  drivers/clocksource/arm_arch_timer.c | 3 +++
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/arch_timer.h 
>> b/arch/arm64/include/asm/arch_timer.h
>> index 7ae54d7d333a..fb8dfcbf9c01 100644
>> --- a/arch/arm64/include/asm/arch_timer.h
>> +++ b/arch/arm64/include/asm/arch_timer.h
>> @@ -18,6 +18,8 @@
>>  #include <linux/smp.h>
>>  #include <linux/types.h>
>> 
>> +#include <vdso/clocksource.h>
>> +
>>  #include <clocksource/arm_arch_timer.h>
>> 
>>  #if IS_ENABLED(CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND)
>> @@ -58,6 +60,7 @@ struct arch_timer_erratum_workaround {
>>  	u64 (*read_cntvct_el0)(void);
>>  	int (*set_next_event_phys)(unsigned long, struct clock_event_device 
>> *);
>>  	int (*set_next_event_virt)(unsigned long, struct clock_event_device 
>> *);
>> +	enum vdso_clock_mode vdso_clock_mode;
>>  };
>> 
>>  DECLARE_PER_CPU(const struct arch_timer_erratum_workaround *,
>> diff --git a/drivers/clocksource/arm_arch_timer.c 
>> b/drivers/clocksource/arm_arch_timer.c
>> index ecf7b7db2d05..f828835c568f 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -566,6 +566,9 @@ void arch_timer_enable_workaround(const struct 
>> arch_timer_erratum_workaround *wa
>>  	if (wa->read_cntvct_el0) {
>>  		clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
>>  		vdso_default = VDSO_CLOCKMODE_NONE;
>> +	} else {
>> +		clocksource_counter.vdso_clock_mode = wa->vdso_clock_mode;
>> +		vdso_default = wa->vdso_clock_mode;
>>  	}
> 
> I fear that we're liable to forget to set vdso_clock_mode on new errata
> that don't need a read_cntvct_el0 hook, and if so we'll happen to set
> these to 0 (i.e. VDSO_CLOCKMODE_NONE).
> 
> For now could we instead have a boolan disable_compat_vdso, with this
> being:
> 
> | if (wa->read_cntvct_el0) {
> | 	clocksource_counter.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
> | 	vdso_default = VDSO_CLOCKMODE_NONE;
> | } else if (wa->disable_compat_vdso) {
> | 	clocksource_counter.vdso_clock_mode = 
> VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT;
> | 	vdso_default = wa->vdso_clock_mode = 
> VDSO_CLOCKMODE_ARCHTIMER_NOCOMPAT;
> | }

Sure, that'd work too.

> Do we need to handle the comination of a workaround seeting NONE and 
> one
> setting ARCHTIMER_NOCOMPAT?

Not yet. Probably coming any time now. Which is why we may need to
look into per-CPU vdso data pages (Broonie has a series that could
be of some use, apparently).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

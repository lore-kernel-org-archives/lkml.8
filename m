Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD92EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B092206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mosTvM7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgFDWWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgFDWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:22:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB192C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 15:22:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w1so7901088qkw.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WMbuqCGZ4U7gkzf8wgJjJKXqrS683D6BVYhR2YaCFvI=;
        b=mosTvM7hfnes04XAjK0vKbC8Z1KVEcFGQfqteZc8O+06xb7LKwQkX0Sn4YZPpWESD9
         gnv2O5P4idk1bMSo0KXJo1s8zN9HY/cxKUWxToYTlkyC/2rOrtCb3PuDPID4KXweQrUa
         Ea3yYXn+mkp8JpjPIClau9PXRFF6enegDtHGHbPadqSwcZYqy/CtO0lFmxkHGgA/XzV6
         FWb4zAF8d9nQ9sirjRDUI+b1RXxxYQZHMJN4XbLdt/RCIjSwaRB1ejuRJg8D+ElFXAx2
         oIP7XqmK84y/eyzpU5TemecPAXibcVskU9jR19pwOqAq1qfI1uPK4lVT82hGfjsmy71Y
         TuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WMbuqCGZ4U7gkzf8wgJjJKXqrS683D6BVYhR2YaCFvI=;
        b=QZMeHs9A1rciD+yvrXPsRA0SFMe/ZSVPB7WHSlAOazDFmjTNvfz7Ug9+jpktYR0XY2
         URM+rDc/MRH8gExSHCinvxfiSz9A8patrbHrYJU97S/vp2X3Zkga5KlfG0rhMoh7Sy/b
         G5+U5AX2PawPHgB5C0J5T2mCh1kbQVxx5pmi9S0b7driNM1tiDBkZnB6z9lKF+uveTjN
         d6TMLGzhvsk7GIi7S6uPat/0IO6X+KZu+p0Ov6AwBH2btaUiHow4uLfcatjfi7dXWYf/
         azsoYWISI8ZE8CFz/TAJEvHqysTNg02HwBbBAmOuYJHL3F7UCWGFCvO3ITPXYjSto0Ej
         K+3w==
X-Gm-Message-State: AOAM533VgSiRdVdywuBA7gnJC9VF2V1Nfsspll44cEAK0q7SKTozKERY
        /uwGyJOjYBFLkx8UfzzXgSfOYd9jh6lOwA==
X-Google-Smtp-Source: ABdhPJyPuz66Kl3DZjo299zTjMkDiiix91BHQ107FfLlhY0zcRZiHT5oiBJflmnYAtMgLEaBuzEmzA==
X-Received: by 2002:a05:620a:4e2:: with SMTP id b2mr7097631qkh.16.1591309356594;
        Thu, 04 Jun 2020 15:22:36 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id r30sm6224898qtb.87.2020.06.04.15.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 15:22:35 -0700 (PDT)
Subject: Re: v5.7: new core kernel option missing help text
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200603173150.GB1551@shell.armlinux.org.uk>
 <jhjh7vshvwl.mognet@arm.com> <20200603184500.GC1551@shell.armlinux.org.uk>
 <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
 <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com>
 <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org>
 <jhjeeqvi3m1.mognet@arm.com> <20200604092901.GE1551@shell.armlinux.org.uk>
 <jhjbllzhzg9.mognet@arm.com>
 <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com>
 <jhja71ij0xr.mognet@arm.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <2d17fa1e-d925-5ed7-2761-bd3a8c18a14a@linaro.org>
Date:   Thu, 4 Jun 2020 18:22:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <jhja71ij0xr.mognet@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/20 11:38 AM, Valentin Schneider wrote:
> 
> On 04/06/20 14:05, Thara Gopinath wrote:
>> On Thu, 4 Jun 2020 at 06:56, Valentin Schneider <valentin.schneider@arm.com>
>>>
>>> Right, s/defconfig/arch kconfig/ or somesuch.
>>>
>>
>>   CPU_FREQ_THERMAL also has to be enabled for this to be effective.
>> Since arm64 defconfig enables  CPU_FREQ_THERMAL  (by enabling CPU_THERMAL),
>> it should be ok to enable it in arm64/Kconfig. (same with arm/Kconfig)
>>
>> Another option is to select the  SCHED_THERMAL_PRESSURE when
>> CPU_FREQ_THERMAL
>> is enabled in drivers/thermal/Kconfig.
>>
> 
> So interestingly while arch_set_thermal_pressure() (which just writes to a
> pcpu variable) is defined in sched/core.c, arch_scale_thermal_pressure()
> (which just returns aforementionned pcpu variable) is defined in
> arch_topology...
> 
> I'm thinking at this point we might as well turn the
> arch_scale_thermal_pressure() stub into what arch_topology does. This would
> effectively let any architecture use thermal pressure, providing they use
> cpufreq cooling.
> 
> If we want to keep changes contained to Kconfigs, for now I think the
> safest would be:

Thanks Valentin. This looks good to me for now. Although, I want to 
state that the thermal pressure can be set by some other entity other 
than cpufreq cooling as well. But currently only cpufreq cooling handles 
it. So for now the below looks good.

> 
> ---
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 16fbf74030fe..1e92080dc275 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -46,6 +46,7 @@ config ARM
>          select EDAC_ATOMIC_SCRUB
>          select GENERIC_ALLOCATOR
>          select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
> +	select SCHED_THERMAL_PRESSURE if GENERIC_ARCH_TOPOLOGY
>          select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>          select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>          select GENERIC_CPU_AUTOPROBE
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 552d36cacc05..cc1944fbae51 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -98,6 +98,7 @@ config ARM64
>          select FRAME_POINTER
>          select GENERIC_ALLOCATOR
>          select GENERIC_ARCH_TOPOLOGY
> +	select SCHED_THERMAL_PRESSURE
>          select GENERIC_CLOCKEVENTS
>          select GENERIC_CLOCKEVENTS_BROADCAST
>          select GENERIC_CPU_AUTOPROBE
> diff --git a/init/Kconfig b/init/Kconfig
> index 74a5ac65644f..ba846f6e805b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -439,8 +439,11 @@ config HAVE_SCHED_AVG_IRQ
>          depends on SMP
> 
>   config SCHED_THERMAL_PRESSURE
> -	bool "Enable periodic averaging of thermal pressure"
> +	def_bool n
>          depends on SMP
> +	depends on CPU_FREQ_THERMAL
> +	help
> +	  <helpful thing here>
> 
>   config BSD_PROCESS_ACCT
>          bool "BSD Process Accounting"
> ---
> 
> 
> 
>> Warm Regards
>> Thara

-- 
Warm Regards
Thara

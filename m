Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9366CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3EE20823
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXA08T4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgFEHDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgFEHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:03:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8658C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 00:03:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so5142457lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Co2UPjoUty+9+lwyKbI6wKV9XsBItgK3tIfpuC7GLdQ=;
        b=mXA08T4Px/zQB81VkGn7HG3AhkR0XrmT0ss3HPMv3jkDTiRW7baCX/YM6rMDJSWlHT
         9N+0VB5TY8Nn0V8M+rZrudJ0yCrH9GcGXuTdU8CI6u8wMEsuPPqvGpKuOmeAkcZwjnsJ
         mmCIfL1WQHmXoj/PHZN4kx3xjkJmy5aPWMKsEw1tJQoQuzz+hv/dUvclwhMP9pcadwkl
         ur3ivdDP0aycE+rGIvJ7GdAtjbr35TeMqIslQS9gtSMOKffdMwmFCbvcW4LbXs0ilegO
         bHRoGdf79XMlynOVHxBrLEChR30F+k0sGThgEUWJJHkUrQhZg+FRJuYKDr787dhyeuCC
         d2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Co2UPjoUty+9+lwyKbI6wKV9XsBItgK3tIfpuC7GLdQ=;
        b=HGcbjYB9ySKLi2OnrDhyeLxnC6IJS4p3X/t1v1LHAZNRIWN6zEAFkHFnxuBz2/KVcT
         PokodDhZ2IFacQizGXlqhqOWP6rSyqJoC5OmRMbO8usQRK33KD0pfJW6ZatZMBJoHyvU
         bmv/xYtMdcDFgIPkfjbOsp57AMJKkdJ4p5EA6Dpo+8lPAbUuoaedZY1YFWu7r/G6QJ/b
         GBmYQw/Cdg+Tz4F3gwL0Htc8OOuaiCDsD1m9xa0WzRiLZfioPGrjLY+DZqpkn9yckwA6
         +1MIBL2xjGUTPcs3/TjGExwA7u49r8Sd/8THToIxuynjz4eMbAOkYofK8V9qwSnqudaP
         ZTsQ==
X-Gm-Message-State: AOAM53047fhcl6y9kPGLeSbXIb2sO8GaA3UPGMBuLV0BnHIvdht+Z0h/
        RBdudRjLcZX+tG+eX20q6MKaUs5kjMocd0On2+rFWQ==
X-Google-Smtp-Source: ABdhPJyZIh7mlg6JkmFyaneYgxcJc4C7K9a7I7+a+ELo8+d1V7hVPPLenDbiy9k9J6WpV6Bq/K5BR2MbU+HGZ31zycg=
X-Received: by 2002:a19:2250:: with SMTP id i77mr4607252lfi.133.1591340603159;
 Fri, 05 Jun 2020 00:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com>
 <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com>
 <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com>
 <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org> <jhjeeqvi3m1.mognet@arm.com>
 <20200604092901.GE1551@shell.armlinux.org.uk> <jhjbllzhzg9.mognet@arm.com>
 <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com> <jhja71ij0xr.mognet@arm.com>
In-Reply-To: <jhja71ij0xr.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Jun 2020 09:03:11 +0200
Message-ID: <CAKfTPtCPSk8wAyVeFDeywbUF6qQcjKw2OsvweW3MLLLdOdK+oQ@mail.gmail.com>
Subject: Re: v5.7: new core kernel option missing help text
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 17:38, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 04/06/20 14:05, Thara Gopinath wrote:
> > On Thu, 4 Jun 2020 at 06:56, Valentin Schneider <valentin.schneider@arm.com>
> >>
> >> Right, s/defconfig/arch kconfig/ or somesuch.
> >>
> >
> >  CPU_FREQ_THERMAL also has to be enabled for this to be effective.
> > Since arm64 defconfig enables  CPU_FREQ_THERMAL  (by enabling CPU_THERMAL),
> > it should be ok to enable it in arm64/Kconfig. (same with arm/Kconfig)
> >
> > Another option is to select the  SCHED_THERMAL_PRESSURE when
> > CPU_FREQ_THERMAL
> > is enabled in drivers/thermal/Kconfig.
> >
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
>
> ---
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 16fbf74030fe..1e92080dc275 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -46,6 +46,7 @@ config ARM
>         select EDAC_ATOMIC_SCRUB
>         select GENERIC_ALLOCATOR
>         select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
> +       select SCHED_THERMAL_PRESSURE if GENERIC_ARCH_TOPOLOGY

I think that SCHED_THERMAL_PRESSURE depends on ARM_CPU_TOPOLOGY but
not on GENERIC_ARCH_TOPOLOGY.
ARM_CPU_TOPOLOGY is used to define arch_scale_thermal_pressure for arm
architecture
and we only use the header file of the generic arch_topology.h.
Function like arch_set_thermal_pressure() is in sched/core.c

>         select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>         select GENERIC_CPU_AUTOPROBE
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 552d36cacc05..cc1944fbae51 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -98,6 +98,7 @@ config ARM64
>         select FRAME_POINTER
>         select GENERIC_ALLOCATOR
>         select GENERIC_ARCH_TOPOLOGY
> +       select SCHED_THERMAL_PRESSURE
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_CLOCKEVENTS_BROADCAST
>         select GENERIC_CPU_AUTOPROBE
> diff --git a/init/Kconfig b/init/Kconfig
> index 74a5ac65644f..ba846f6e805b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -439,8 +439,11 @@ config HAVE_SCHED_AVG_IRQ
>         depends on SMP
>
>  config SCHED_THERMAL_PRESSURE
> -       bool "Enable periodic averaging of thermal pressure"
> +       def_bool n
>         depends on SMP
> +       depends on CPU_FREQ_THERMAL
> +       help
> +         <helpful thing here>
>
>  config BSD_PROCESS_ACCT
>         bool "BSD Process Accounting"
> ---
>
>
>
> > Warm Regards
> > Thara

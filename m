Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BE6206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFEJqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:46:15 -0400
Received: from foss.arm.com ([217.140.110.172]:52782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgFEJqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:46:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2729A2B;
        Fri,  5 Jun 2020 02:46:14 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62EC23F52E;
        Fri,  5 Jun 2020 02:46:13 -0700 (PDT)
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com> <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com> <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com> <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org> <jhjeeqvi3m1.mognet@arm.com> <20200604092901.GE1551@shell.armlinux.org.uk> <jhjbllzhzg9.mognet@arm.com> <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com> <jhja71ij0xr.mognet@arm.com> <CAKfTPtCPSk8wAyVeFDeywbUF6qQcjKw2OsvweW3MLLLdOdK+oQ@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
In-reply-to: <CAKfTPtCPSk8wAyVeFDeywbUF6qQcjKw2OsvweW3MLLLdOdK+oQ@mail.gmail.com>
Date:   Fri, 05 Jun 2020 10:46:04 +0100
Message-ID: <jhj8sh1j15v.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/06/20 08:03, Vincent Guittot wrote:
> On Thu, 4 Jun 2020 at 17:38, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> ---
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 16fbf74030fe..1e92080dc275 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -46,6 +46,7 @@ config ARM
>>         select EDAC_ATOMIC_SCRUB
>>         select GENERIC_ALLOCATOR
>>         select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>> +       select SCHED_THERMAL_PRESSURE if GENERIC_ARCH_TOPOLOGY
>
> I think that SCHED_THERMAL_PRESSURE depends on ARM_CPU_TOPOLOGY but
> not on GENERIC_ARCH_TOPOLOGY.
> ARM_CPU_TOPOLOGY is used to define arch_scale_thermal_pressure for arm
> architecture
> and we only use the header file of the generic arch_topology.h.
> Function like arch_set_thermal_pressure() is in sched/core.c
>

You're right, oh well... Let me spend a bit more time on this and I'll
send actual patches.

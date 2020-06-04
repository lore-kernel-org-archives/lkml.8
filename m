Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2060C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA1F206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgFDPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:38:47 -0400
Received: from foss.arm.com ([217.140.110.172]:46030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgFDPir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:38:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7230D1FB;
        Thu,  4 Jun 2020 08:38:46 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AED9A3F305;
        Thu,  4 Jun 2020 08:38:45 -0700 (PDT)
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com> <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com> <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com> <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org> <jhjeeqvi3m1.mognet@arm.com> <20200604092901.GE1551@shell.armlinux.org.uk> <jhjbllzhzg9.mognet@arm.com> <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
In-reply-to: <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com>
Date:   Thu, 04 Jun 2020 16:38:40 +0100
Message-ID: <jhja71ij0xr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/06/20 14:05, Thara Gopinath wrote:
> On Thu, 4 Jun 2020 at 06:56, Valentin Schneider <valentin.schneider@arm.com>
>>
>> Right, s/defconfig/arch kconfig/ or somesuch.
>>
>
>  CPU_FREQ_THERMAL also has to be enabled for this to be effective.
> Since arm64 defconfig enables  CPU_FREQ_THERMAL  (by enabling CPU_THERMAL),
> it should be ok to enable it in arm64/Kconfig. (same with arm/Kconfig)
>
> Another option is to select the  SCHED_THERMAL_PRESSURE when
> CPU_FREQ_THERMAL
> is enabled in drivers/thermal/Kconfig.
>

So interestingly while arch_set_thermal_pressure() (which just writes to a
pcpu variable) is defined in sched/core.c, arch_scale_thermal_pressure()
(which just returns aforementionned pcpu variable) is defined in
arch_topology...

I'm thinking at this point we might as well turn the
arch_scale_thermal_pressure() stub into what arch_topology does. This would
effectively let any architecture use thermal pressure, providing they use
cpufreq cooling.

If we want to keep changes contained to Kconfigs, for now I think the
safest would be:

---
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 16fbf74030fe..1e92080dc275 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -46,6 +46,7 @@ config ARM
        select EDAC_ATOMIC_SCRUB
        select GENERIC_ALLOCATOR
        select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
+	select SCHED_THERMAL_PRESSURE if GENERIC_ARCH_TOPOLOGY
        select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
        select GENERIC_CLOCKEVENTS_BROADCAST if SMP
        select GENERIC_CPU_AUTOPROBE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 552d36cacc05..cc1944fbae51 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,7 @@ config ARM64
        select FRAME_POINTER
        select GENERIC_ALLOCATOR
        select GENERIC_ARCH_TOPOLOGY
+	select SCHED_THERMAL_PRESSURE
        select GENERIC_CLOCKEVENTS
        select GENERIC_CLOCKEVENTS_BROADCAST
        select GENERIC_CPU_AUTOPROBE
diff --git a/init/Kconfig b/init/Kconfig
index 74a5ac65644f..ba846f6e805b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -439,8 +439,11 @@ config HAVE_SCHED_AVG_IRQ
        depends on SMP

 config SCHED_THERMAL_PRESSURE
-	bool "Enable periodic averaging of thermal pressure"
+	def_bool n
        depends on SMP
+	depends on CPU_FREQ_THERMAL
+	help
+	  <helpful thing here>

 config BSD_PROCESS_ACCT
        bool "BSD Process Accounting"
---



> Warm Regards
> Thara

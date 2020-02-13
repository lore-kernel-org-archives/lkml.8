Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7565FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E36E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="za3rTGuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgBMM0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:26:00 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39328 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMM0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:26:00 -0500
Received: by mail-vk1-f193.google.com with SMTP id t129so1509718vkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 04:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9OAQr7LoJ7FysjO3RNUdQHAVxo4VqZp7WZsTWIAp+U=;
        b=za3rTGuOnSDnmFdxj8VAeh6VbheBiDSorET9lsV9J155E17dBflM5Xa9yAtAtLXMEi
         9sqlhC2kF38nbcDs/pGUEtArCN2mKNq0gAKiD7Rfb51LiekGYAIq1V+7izfDNnXhCK/f
         cVxutZZ2DCdaJAJTtmtv8/sB9cMCsNRQxOhvq/gkQRCN3MRcat5b6l4Xjo3kCIYfLDZM
         gJSDN6HyELXmqWSciasKZ9Joi3OKM9OsfrioBPAGfLuj6a4xFniu8RelliOtSsSPj6HV
         NYksR+LMCkDHzxsKVjrC00nC3T+Fingk5iyd9+BE3JjF11VWM7gzZUG3nlqaNnb353DA
         k45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9OAQr7LoJ7FysjO3RNUdQHAVxo4VqZp7WZsTWIAp+U=;
        b=UllCEj8PKfY1Ehr5g8AdLukdRCDz8CMAFWvjk3p4f0B+WU5verst6oVeyLibYhIsZr
         q2KGKECl4dDIpbXjXVVcug3YEpGdKpO6+NWMxJFghDdGvBcNcjzq1S3oDdT94fzXr5tF
         kP+pOXm5BEdCZ2xqD5SGZ+rjQgPJbtkAfFGZhwjEuKui42B35FlZI266v13K4/8Rj3gq
         woAW6nP0it7h6oEhaInens9i7Wjmx2n5wcgEzooe4y/BmHBPD/aqXAevSiY4Egp2uegZ
         /98JwMilSZ2aAWMjXQFJ0iCUv+WbrllgEEZs3+OOXJ7yUHCI6sAAxUVyf3SrIWTa4pkx
         +ieg==
X-Gm-Message-State: APjAAAUcx+FU+aWFy7qnkKlsv4kMN8Y9oHcqiSFY8c+7gPOPAhzpxMOG
        N0YFjlLeSst6X19lnpBcNiqp8qLCEWQTOoIXWpOtqA==
X-Google-Smtp-Source: APXvYqxsuxYSXPiHZ4iLR27psVWCXL6kFFq0BEbhNoMUh8EG5yW9x4+cRmT9OrPpHEInL8yQKRZeXBglBQMFpDg607o=
X-Received: by 2002:ac5:c7a9:: with SMTP id d9mr1812766vkn.79.1581596758533;
 Thu, 13 Feb 2020 04:25:58 -0800 (PST)
MIME-Version: 1.0
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org> <1580250967-4386-4-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1580250967-4386-4-git-send-email-thara.gopinath@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 13 Feb 2020 17:55:47 +0530
Message-ID: <CAHLCerMEieWMyk8RcM-y8c3Usq_e5CTYJ4AqhCQOzihRTUWbTg@mail.gmail.com>
Subject: Re: [Patch v9 3/8] arm,arm64,drivers:Add infrastructure to store and
 update instantaneous thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, ionela.voinescu@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, qperret@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, corbet@lwn.net,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 4:06 AM Thara Gopinath
<thara.gopinath@linaro.org> wrote:
>
> Add architecture specific APIs to update and track thermal pressure on a
> per cpu basis. A per cpu variable thermal_pressure is introduced to keep
> track of instantaneous per cpu thermal pressure. Thermal pressure is the
> delta between maximum capacity and capped capacity due to a thermal event.

s/capped/decreased to have consistent use throughout the series e.g. in patch 1.

Though personally, I like "capped capacity"  in which case
s/decreased/capped in patch 1 and elsewhere.

>
> topology_get_thermal_pressure can be hooked into the scheduler specified
> arch_cpu_thermal_capacity to retrieve instantaneous thermal pressure of a
> cpu.
>
> arch_set_thermal_pressure can be used to update the thermal pressure.
>
> Considering topology_get_thermal_pressure reads thermal_pressure and
> arch_set_thermal_pressure writes into thermal_pressure, one can argue for
> some sort of locking mechanism to avoid a stale value.  But considering
> topology_get_thermal_pressure can be called from a system critical path
> like scheduler tick function, a locking mechanism is not ideal. This means
> that it is possible the thermal_pressure value used to calculate average
> thermal pressure for a cpu can be stale for upto 1 tick period.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>
> v6->v7:
>         - Changed the input argument in arch_set_thermal_pressure from
>           capped capacity to delta capacity(thermal pressure) as per
>           Ionela's review comments.
>
>  arch/arm/include/asm/topology.h   |  3 +++
>  arch/arm64/include/asm/topology.h |  3 +++

Any particular reason to enable this for arm/arm64 in this patch
itself? I'd have enabled them in two separate patches after this one.

>  drivers/base/arch_topology.c      | 11 +++++++++++
>  include/linux/arch_topology.h     | 10 ++++++++++
>  4 files changed, 27 insertions(+)
>
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 8a0fae9..3a50a19 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -16,6 +16,9 @@
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>
> +/* Replace task scheduler's default thermal pressure retrieve API */
> +#define arch_cpu_thermal_pressure topology_get_thermal_pressure
> +
>  #else
>
>  static inline void init_cpu_topology(void) { }
> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
> index a4d945d..a70896f 100644
> --- a/arch/arm64/include/asm/topology.h
> +++ b/arch/arm64/include/asm/topology.h
> @@ -25,6 +25,9 @@ int pcibus_to_node(struct pci_bus *bus);
>  /* Enable topology flag updates */
>  #define arch_update_cpu_topology topology_update_cpu_topology
>
> +/* Replace task scheduler's default thermal pressure retrieve API */
> +#define arch_cpu_thermal_pressure topology_get_thermal_pressure
> +
>  #include <asm-generic/topology.h>
>
>  #endif /* _ASM_ARM_TOPOLOGY_H */
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 6119e11..68dfa49 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -42,6 +42,17 @@ void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>         per_cpu(cpu_scale, cpu) = capacity;
>  }
>
> +DEFINE_PER_CPU(unsigned long, thermal_pressure);
> +
> +void arch_set_thermal_pressure(struct cpumask *cpus,
> +                              unsigned long th_pressure)
> +{
> +       int cpu;

<snip>

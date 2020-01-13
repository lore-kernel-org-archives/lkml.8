Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9418C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A264D207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC9na/wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMMq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:46:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31441 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgAMMq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578919586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CbMAfem5Ss8Ci2UJmhbyTfN/uSIHjLn3PvTSYxt9p8M=;
        b=WC9na/wGz+KRR3/aEh41yJ60ejB/Ha/8Hr6cCvLkMubM6fmHrPXAXOU6Kgm6JPkvopY9tm
        hpnbEX8QN9vzRacBt8FCUj+T0rLkRMXXQc23Mo+9IPt1w3UkN3OnP0iRxfV6ZErfxqMjbG
        Wil68z9CsRRF1c9RSZjnc9yCCfQ6rSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-GKV-WnExPyyLax3jtjzkVw-1; Mon, 13 Jan 2020 07:46:23 -0500
X-MC-Unique: GKV-WnExPyyLax3jtjzkVw-1
Received: by mail-wm1-f69.google.com with SMTP id w205so2481842wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:46:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CbMAfem5Ss8Ci2UJmhbyTfN/uSIHjLn3PvTSYxt9p8M=;
        b=G9g9ExJ28ylJal4o3PodU9y/6dv+3H/soT+YAXSU5KQzaIyee1YwlwqGEFKxhEAO3/
         yiLqe+bHX1VhN240m1sHx6Qr6Sf0UAt0NNet25UKWT+r+Sr+dwa1uVPEQY2YaFHWjkpZ
         pdiBpT+Pl4RwOiWB+FnbETL//qwx87qLazhnmm79p8u1tD8YZJHLXraTIVM1uUWZCVmE
         X/CtMd3r3030II/3wm8o9GGvwjwB7kIj0/1Uc8AkyLgJ1Eq+8OfpQGAPISGjM9AyNufG
         uOi7Gn18oT29LtkaeS68kgIF7EupOfY8yPKEAih81l6mLNkp3Ez+JHdoW7IzNc/15boq
         IrIg==
X-Gm-Message-State: APjAAAXmnh/T7+i2bkFa9crWq0qsQwH5JLVaBd2Oqg2XNP0U2abxawkV
        haX0GBuD1tAU22YkzWPDlJEk85CjWO2rJ1VuAISykSa2r3Xif4CGruMdPY72/Pp5R7QhFka20Ol
        /jou/NpuzENgQHWfKO8gmQ6v5
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr19975934wma.34.1578919582630;
        Mon, 13 Jan 2020 04:46:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNqm8aT82U7lmbH3xT2luKza3YJZmmwPAiDVQcaPLgZNf+kTaP2+9Df1eeBgiv6wnoD25UFg==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr19975910wma.34.1578919582399;
        Mon, 13 Jan 2020 04:46:22 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t190sm14016652wmt.44.2020.01.13.04.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 04:46:21 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC v3 1/3] reboot: support hotplug CPUs before reboot
In-Reply-To: <20200113120157.85798-2-hsinyi@chromium.org>
References: <20200113120157.85798-1-hsinyi@chromium.org> <20200113120157.85798-2-hsinyi@chromium.org>
Date:   Mon, 13 Jan 2020 13:46:20 +0100
Message-ID: <87r203plr7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> Currently system reboots uses architecture specific codes (smp_send_stop)
> to offline non reboot CPUs. Most architecture's implementation is looping
> through all non reboot online CPUs and call ipi function to each of them. Some
> architecture like arm64, arm, and x86... would set offline masks to cpu without
> really offline them. This causes some race condition and kernel warning comes
> out sometimes when system reboots.
>
> This patch adds a config REBOOT_HOTPLUG_CPU, which would hotplug cpus in
> migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> checking online cpus would be an empty loop. If architecture don't enable this
> config, or some cpus somehow fails to offline, it would fallback to ipi
> function.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  arch/Kconfig        |  6 ++++++
>  include/linux/cpu.h |  3 +++
>  kernel/cpu.c        | 19 +++++++++++++++++++
>  kernel/reboot.c     |  8 ++++++++
>  4 files changed, 36 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 48b5e103bdb0..a043b9be1499 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -52,6 +52,12 @@ config OPROFILE_EVENT_MULTIPLEX
>  
>  	  If unsure, say N.
>  
> +config REBOOT_HOTPLUG_CPU
> +	bool "Support for hotplug CPUs before reboot"
> +	depends on HOTPLUG_CPU
> +	help
> +	  Say Y to do a full hotplug on secondary CPUs before reboot.

I'm not sure this should be a configurable option, e.g. in case this is
a good approach in general, why not just use CONFIG_HOTPLUG_CPU in the
code? 

> +
>  config HAVE_OPROFILE
>  	bool
>  
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 1ca2baf817ed..3bf5ab289954 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -118,6 +118,9 @@ extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
>  int cpu_down(unsigned int cpu);
> +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> +extern void offline_secondary_cpus(int primary);
> +#endif
>  
>  #else /* CONFIG_HOTPLUG_CPU */
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c706af713fb..52afc47dd56a 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1057,6 +1057,25 @@ int cpu_down(unsigned int cpu)
>  }
>  EXPORT_SYMBOL(cpu_down);
>  
> +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> +void offline_secondary_cpus(int primary)
> +{
> +	int i, err;
> +
> +	cpu_maps_update_begin();
> +
> +	for_each_online_cpu(i) {
> +		if (i == primary)
> +			continue;
> +		err = _cpu_down(i, 0, CPUHP_OFFLINE);
> +		if (err)
> +			pr_warn("Failed to offline cpu %d\n", i);
> +	}
> +	cpu_hotplug_disabled++;
> +
> +	cpu_maps_update_done();
> +}
> +#endif

This looks like a simplified version of freeze_secondary_cpus(), can
they be merged?


>  #else
>  #define takedown_cpu		NULL
>  #endif /*CONFIG_HOTPLUG_CPU*/
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index c4d472b7f1b4..fda84794ce46 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -7,6 +7,7 @@
>  
>  #define pr_fmt(fmt)	"reboot: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/ctype.h>
>  #include <linux/export.h>
>  #include <linux/kexec.h>
> @@ -220,7 +221,9 @@ void migrate_to_reboot_cpu(void)
>  	/* The boot cpu is always logical cpu 0 */
>  	int cpu = reboot_cpu;
>  
> +#if !IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
>  	cpu_hotplug_disable();
> +#endif
>  
>  	/* Make certain the cpu I'm about to reboot on is online */
>  	if (!cpu_online(cpu))
> @@ -231,6 +234,11 @@ void migrate_to_reboot_cpu(void)
>  
>  	/* Make certain I only run on the appropriate processor */
>  	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +
> +	/* Hotplug other cpus if possible */
> +#if IS_ENABLED(CONFIG_REBOOT_HOTPLUG_CPU)
> +	offline_secondary_cpus(cpu);
> +#endif
>  }
>  
>  /**

-- 
Vitaly


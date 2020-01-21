Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D30C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F0824653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAUQuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:50:35 -0500
Received: from foss.arm.com ([217.140.110.172]:45782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgAUQuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:50:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EA1F328;
        Tue, 21 Jan 2020 08:50:34 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F36C3F6C4;
        Tue, 21 Jan 2020 08:50:33 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:50:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] arm: arm64: Don't use disable_nonboot_cpus()
Message-ID: <20200121165030.xksivf6mrhsaynq2@e107158-lin.cambridge.arm.com>
References: <20191125112754.25223-1-qais.yousef@arm.com>
 <20191125112754.25223-4-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125112754.25223-4-qais.yousef@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/19 11:27, Qais Yousef wrote:
> disable_nonboot_cpus() is not safe to use when doing machine_down(),
> because it relies on freeze_secondary_cpus() which in return is
> a suspend/resume related freeze and could abort if the logic detects any
> pending activities that can prevent finishing the offlining process.
> 
> Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> is an othogonal config to rely on to ensure this function works
> correctly.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Russell King <linux@armlinux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will@kernel.org>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---

Ping :)

I'm missing ACKs on this patch and patch 4 for arm64. Hopefully none should be
controversial.

Thanks!

--
Qais Yousef

>  arch/arm/kernel/reboot.c    | 4 ++--
>  arch/arm64/kernel/process.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
> index bb18ed0539f4..58ad1a70f770 100644
> --- a/arch/arm/kernel/reboot.c
> +++ b/arch/arm/kernel/reboot.c
> @@ -88,11 +88,11 @@ void soft_restart(unsigned long addr)
>   * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
>   * kexec'd kernel to use any and all RAM as it sees fit, without having to
>   * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
> - * functionality embodied in disable_nonboot_cpus() to achieve this.
> + * functionality embodied in smp_shutdown_nonboot_cpus() to achieve this.
>   */
>  void machine_shutdown(void)
>  {
> -	disable_nonboot_cpus();
> +	smp_shutdown_nonboot_cpus(0);
>  }
>  
>  /*
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 71f788cd2b18..3bcc9bfc581e 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -141,11 +141,11 @@ void arch_cpu_idle_dead(void)
>   * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
>   * kexec'd kernel to use any and all RAM as it sees fit, without having to
>   * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
> - * functionality embodied in disable_nonboot_cpus() to achieve this.
> + * functionality embodied in smpt_shutdown_nonboot_cpus() to achieve this.
>   */
>  void machine_shutdown(void)
>  {
> -	disable_nonboot_cpus();
> +	smp_shutdown_nonboot_cpus(0);
>  }
>  
>  /*
> -- 
> 2.17.1
> 

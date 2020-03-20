Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4266C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB85B20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCTLEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:04:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47438 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbgCTLEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:04:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E08431B;
        Fri, 20 Mar 2020 04:04:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53BF53F85E;
        Fri, 20 Mar 2020 04:04:33 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:04:31 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 04/15] arm: Don't use disable_nonboot_cpus()
Message-ID: <20200320110430.jozfyrqqx272266u@e107158-lin.cambridge.arm.com>
References: <20200223192942.18420-1-qais.yousef@arm.com>
 <20200223192942.18420-5-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200223192942.18420-5-qais.yousef@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/20 19:29, Qais Yousef wrote:
> disable_nonboot_cpus() is not safe to use when doing machine_down(),
> because it relies on freeze_secondary_cpus() which in turn is
> a suspend/resume related freeze and could abort if the logic detects any
> pending activities that can prevent finishing the offlining process.
> 
> Beside disable_nonboot_cpus() is dependent on CONFIG_PM_SLEEP_SMP which
> is an othogonal config to rely on to ensure this function works
> correctly.
> 
> Use `reboot_cpu` variable instead of hardcoding 0 as the reboot cpu.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> CC: Russell King <linux@armlinux.org.uk>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---

Hi Russel

Does the updated version look good to you now?

Thanks

--
Qais Yousef

>  arch/arm/kernel/reboot.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
> index bb18ed0539f4..0ce388f15422 100644
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
> +	smp_shutdown_nonboot_cpus(reboot_cpu);
>  }
>  
>  /*
> -- 
> 2.17.1
> 

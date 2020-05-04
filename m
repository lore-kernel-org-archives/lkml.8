Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58749C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4295D20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgEDMnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:43:35 -0400
Received: from foss.arm.com ([217.140.110.172]:43492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgEDMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:43:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61B061FB;
        Mon,  4 May 2020 05:43:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3803F71F;
        Mon,  4 May 2020 05:43:27 -0700 (PDT)
Date:   Mon, 4 May 2020 13:43:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Drop boot_cpu_data
Message-ID: <20200504124321.GA73375@C02TD0UTHF1T.local>
References: <1588595400-4560-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588595400-4560-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 06:00:00PM +0530, Anshuman Khandual wrote:
> A global boot_cpu_data is not really required. Lets drop this.

I don't think it's true that this isn't required today.

One reason that we have both boot_cpu_data and a cpu_data variable for
CPU0 is that CPU0 itself can be hotplugged out then back in, and this
allows us to detect if CPU0's features have changed (e.g. due to FW
failing to configure it appropriately, or real physical hotplug
occurring).

So NAK to the patch as it stands. If we're certain we capture all of
those details even without boot_cpu_data, then we should make other
changes to make that clear (e.g. removing it as an argument to
update_cpu_features()).

Thanks,
Mark.

> While here, rename the local variable as boot_cpu_info when it is
> fetched for the boot cpu.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Based on 5.7-rc4
> 
>  arch/arm64/kernel/cpuinfo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index a515d8f3639e..dabcdc132e56 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -31,7 +31,6 @@
>   * values depending on configuration at or after reset.
>   */
>  DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
> -static struct cpuinfo_arm64 boot_cpu_data;
>  
>  static const char *icache_policy_str[] = {
>  	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> @@ -393,15 +392,16 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>  void cpuinfo_store_cpu(void)
>  {
>  	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
> +	struct cpuinfo_arm64 *boot_cpu_info = &per_cpu(cpu_data, 0);
> +
>  	__cpuinfo_store_cpu(info);
> -	update_cpu_features(smp_processor_id(), info, &boot_cpu_data);
> +	update_cpu_features(smp_processor_id(), info, boot_cpu_info);
>  }
>  
>  void __init cpuinfo_store_boot_cpu(void)
>  {
> -	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
> -	__cpuinfo_store_cpu(info);
> +	struct cpuinfo_arm64 *boot_cpu_info = &per_cpu(cpu_data, 0);
>  
> -	boot_cpu_data = *info;
> -	init_cpu_features(&boot_cpu_data);
> +	__cpuinfo_store_cpu(boot_cpu_info);
> +	init_cpu_features(boot_cpu_info);
>  }
> -- 
> 2.20.1
> 

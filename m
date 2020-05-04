Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051FEC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDAD208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 12:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgEDMnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 08:43:55 -0400
Received: from foss.arm.com ([217.140.110.172]:43520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgEDMny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:43:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 276E01FB;
        Mon,  4 May 2020 05:43:54 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113593F71F;
        Mon,  4 May 2020 05:43:52 -0700 (PDT)
Date:   Mon, 4 May 2020 13:43:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Move device_initcall() near
 cpuinfo_regs_init()
Message-ID: <20200504124350.GB73375@C02TD0UTHF1T.local>
References: <1588595377-4503-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588595377-4503-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 05:59:37PM +0530, Anshuman Khandual wrote:
> This moves device_initcall() near cpuinfo_regs_init() making the calling
> sequence clear. Besides it is a standard practice to have device_initcall()
> (any __initcall for that matter) just after the function it actually calls.
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

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> Based on 5.7-rc4
> 
>  arch/arm64/kernel/cpuinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 86136075ae41..a515d8f3639e 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -311,6 +311,8 @@ static int __init cpuinfo_regs_init(void)
>  	}
>  	return 0;
>  }
> +device_initcall(cpuinfo_regs_init);
> +
>  static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  {
>  	unsigned int cpu = smp_processor_id();
> @@ -403,5 +405,3 @@ void __init cpuinfo_store_boot_cpu(void)
>  	boot_cpu_data = *info;
>  	init_cpu_features(&boot_cpu_data);
>  }
> -
> -device_initcall(cpuinfo_regs_init);
> -- 
> 2.20.1
> 

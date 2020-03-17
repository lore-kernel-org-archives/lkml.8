Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC07C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3469F2073C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCQMKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:10:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgCQMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:10:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52B6A30E;
        Tue, 17 Mar 2020 05:10:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6613F534;
        Tue, 17 Mar 2020 05:10:53 -0700 (PDT)
Date:   Tue, 17 Mar 2020 12:10:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     will@kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200317121050.GH8831@lakrids.cambridge.arm.com>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317114708.109283-1-yaohongbo@huawei.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Catalin and LAKML]

Mark.

On Tue, Mar 17, 2020 at 07:47:08PM +0800, Hongbo Yao wrote:
> Kpti cannot be disabled from the kernel cmdline after the commit
> 09e3c22a("arm64: Use a variable to store non-global mappings decision").
> 
> Bring back the missing check of kpti= command-line option to fix the
> case where the SPE driver complains the missing "kpti-off" even it has
> already been set.
> 
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  arch/arm64/include/asm/mmu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 3c9533322558..ebbc0d3ac2f7 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -34,7 +34,8 @@ extern bool arm64_use_ng_mappings;
>  
>  static inline bool arm64_kernel_unmapped_at_el0(void)
>  {
> -	return arm64_use_ng_mappings;
> +	return arm64_use_ng_mappings &&
> +		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
>  }
>  
>  typedef void (*bp_hardening_cb_t)(void);
> -- 
> 2.20.1
> 

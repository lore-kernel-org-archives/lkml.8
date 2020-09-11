Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0790C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79A8D21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgIKHGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:06:23 -0400
Received: from foss.arm.com ([217.140.110.172]:54522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgIKHGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:06:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67647113E;
        Fri, 11 Sep 2020 00:06:21 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6763F73C;
        Fri, 11 Sep 2020 00:06:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 3/3] arm64/mm: Unitify CONT_PMD_SHIFT
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
References: <20200910095936.20307-1-gshan@redhat.com>
 <20200910095936.20307-3-gshan@redhat.com>
Message-ID: <1af39001-8d8f-b573-8159-666999d25543@arm.com>
Date:   Fri, 11 Sep 2020 12:35:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200910095936.20307-3-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2020 03:29 PM, Gavin Shan wrote:
> Similar to how CONT_PTE_SHIFT is determined, this introduces a new
> kernel option (CONFIG_CONT_PMD_SHIFT) to determine CONT_PMD_SHIFT.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/Kconfig                     |  6 ++++++
>  arch/arm64/include/asm/pgtable-hwdef.h | 10 ++--------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7ec30dd56300..d58e17fe9473 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -217,6 +217,12 @@ config ARM64_CONT_PTE_SHIFT
>  	default 7 if ARM64_16K_PAGES
>  	default 4
>  
> +config ARM64_CONT_PMD_SHIFT
> +	int
> +	default 5 if ARM64_64K_PAGES
> +	default 5 if ARM64_16K_PAGES
> +	default 4
> +
>  config ARCH_MMAP_RND_BITS_MIN
>         default 14 if ARM64_64K_PAGES
>         default 16 if ARM64_16K_PAGES
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 6c9c67f62551..94b3f2ac2e9d 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -82,17 +82,11 @@
>   * Contiguous page definitions.
>   */
>  #define CONT_PTE_SHIFT		(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
> -#ifdef CONFIG_ARM64_64K_PAGES
> -#define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
> -#elif defined(CONFIG_ARM64_16K_PAGES)
> -#define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
> -#else
> -#define CONT_PMD_SHIFT		(4 + PMD_SHIFT)
> -#endif
> -
>  #define CONT_PTES		(1 << (CONT_PTE_SHIFT - PAGE_SHIFT))
>  #define CONT_PTE_SIZE		(CONT_PTES * PAGE_SIZE)
>  #define CONT_PTE_MASK		(~(CONT_PTE_SIZE - 1))
> +
> +#define CONT_PMD_SHIFT		(CONFIG_ARM64_CONT_PMD_SHIFT + PMD_SHIFT)
>  #define CONT_PMDS		(1 << (CONT_PMD_SHIFT - PMD_SHIFT))
>  #define CONT_PMD_SIZE		(CONT_PMDS * PMD_SIZE)
>  #define CONT_PMD_MASK		(~(CONT_PMD_SIZE - 1))
> 

This is cleaner and more uniform. Did not see any problem while
running some quick hugetlb tests across multiple page size configs
after applying all patches in this series.

Adding this new configuration ARM64_CONT_PMD_SHIFT makes sense, as
it eliminates existing constant values that are used in an ad hoc
manner, while computing contiguous page table entry properties.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

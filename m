Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D1E221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgIKHBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:01:40 -0400
Received: from foss.arm.com ([217.140.110.172]:54384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKHB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:01:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC7EA113E;
        Fri, 11 Sep 2020 00:01:26 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55FF3F73C;
        Fri, 11 Sep 2020 00:01:24 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v2 2/3] arm64/mm: Unitify CONT_PTE_SHIFT
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
References: <20200910095936.20307-1-gshan@redhat.com>
 <20200910095936.20307-2-gshan@redhat.com>
Message-ID: <f2093b0e-88eb-5afc-2452-8a06db593b14@arm.com>
Date:   Fri, 11 Sep 2020 12:30:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200910095936.20307-2-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/10/2020 03:29 PM, Gavin Shan wrote:
> CONT_PTE_SHIFT actually depends on CONFIG_ARM64_CONT_SHIFT. It's
> reasonable to reflect the dependency:

Also always better to avoid direct numerical such as 5, 7, 4. A config
option with a right name (even with constant values), gives them some
meaning.

> 
>    * This renames CONFIG_ARM64_CONT_SHIFT to CONFIG_ARM64_CONT_PTE_SHIFT,
>      so that we can introduce CONFIG_ARM64_CONT_PMD_SHIFT later.

Agreed.

> 
>    * CONT_{SHIFT, SIZE, MASK}, defined in page-def.h are removed as they
>      are not used by anyone.

Makes sense.

> 
>    * CONT_PTE_SHIFT is determined by CONFIG_ARM64_CONT_PTE_SHIFT.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/Kconfig                     | 2 +-
>  arch/arm64/include/asm/page-def.h      | 5 -----
>  arch/arm64/include/asm/pgtable-hwdef.h | 4 +---
>  3 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 6d232837cbee..7ec30dd56300 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -211,7 +211,7 @@ config ARM64_PAGE_SHIFT
>  	default 14 if ARM64_16K_PAGES
>  	default 12
>  
> -config ARM64_CONT_SHIFT
> +config ARM64_CONT_PTE_SHIFT
>  	int
>  	default 5 if ARM64_64K_PAGES
>  	default 7 if ARM64_16K_PAGES
> diff --git a/arch/arm64/include/asm/page-def.h b/arch/arm64/include/asm/page-def.h
> index f99d48ecbeef..2403f7b4cdbf 100644
> --- a/arch/arm64/include/asm/page-def.h
> +++ b/arch/arm64/include/asm/page-def.h
> @@ -11,13 +11,8 @@
>  #include <linux/const.h>
>  
>  /* PAGE_SHIFT determines the page size */
> -/* CONT_SHIFT determines the number of pages which can be tracked together  */

This does not get added back in <pgtable-hwdef.h>, would you please
add one comment, for both CONT_PTE_SHIFT and CONT_PMD_SHIFT in their
respective patches.

>  #define PAGE_SHIFT		CONFIG_ARM64_PAGE_SHIFT
> -#define CONT_SHIFT		CONFIG_ARM64_CONT_SHIFT
>  #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
>  #define PAGE_MASK		(~(PAGE_SIZE-1))
>  
> -#define CONT_SIZE		(_AC(1, UL) << (CONT_SHIFT + PAGE_SHIFT))
> -#define CONT_MASK		(~(CONT_SIZE-1))
> -
>  #endif /* __ASM_PAGE_DEF_H */
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 8a399e666837..6c9c67f62551 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -81,14 +81,12 @@
>  /*
>   * Contiguous page definitions.
>   */
> +#define CONT_PTE_SHIFT		(CONFIG_ARM64_CONT_PTE_SHIFT + PAGE_SHIFT)
>  #ifdef CONFIG_ARM64_64K_PAGES
> -#define CONT_PTE_SHIFT		(5 + PAGE_SHIFT)
>  #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
>  #elif defined(CONFIG_ARM64_16K_PAGES)
> -#define CONT_PTE_SHIFT		(7 + PAGE_SHIFT)
>  #define CONT_PMD_SHIFT		(5 + PMD_SHIFT)
>  #else
> -#define CONT_PTE_SHIFT		(4 + PAGE_SHIFT)
>  #define CONT_PMD_SHIFT		(4 + PMD_SHIFT)
>  #endif
>  
> 

Looks good to me and there are no obvious regressions as well.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

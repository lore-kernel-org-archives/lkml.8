Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F33AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D37620663
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbgEVPu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:50:28 -0400
Received: from foss.arm.com ([217.140.110.172]:38456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730109AbgEVPu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:50:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFB5755D;
        Fri, 22 May 2020 08:50:27 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 060423F305;
        Fri, 22 May 2020 08:50:23 -0700 (PDT)
Date:   Fri, 22 May 2020 16:50:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 2/6] arm64: Add level-hinted TLB invalidation helper
Message-ID: <20200522155017.GG26492@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-3-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423135656.2712-3-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 09:56:52PM +0800, Zhenyu Ye wrote:
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index bc3949064725..5f9f189bc6d2 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -10,6 +10,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/bitfield.h>
>  #include <linux/mm_types.h>
>  #include <linux/sched.h>
>  #include <asm/cputype.h>
> @@ -59,6 +60,35 @@
>  		__ta;						\
>  	})
>  
> +#define TLBI_TTL_MASK	GENMASK_ULL(47, 44)
> +
> +#define __tlbi_level(op, addr, level)					\
> +	do {								\

Nitpick: move "do {" on the same line as __tlbi_level() to reduce the
indentation levels of the whole block.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

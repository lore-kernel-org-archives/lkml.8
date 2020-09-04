Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD41C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E02220791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgIDIrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:47:52 -0400
Received: from foss.arm.com ([217.140.110.172]:46228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgIDIrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:47:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD4D1045;
        Fri,  4 Sep 2020 01:47:51 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674BE3F66F;
        Fri,  4 Sep 2020 01:47:50 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm/ptdump: Add address markers for BPF regions
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1599208259-11191-1-git-send-email-anshuman.khandual@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ca0504d8-55d2-a561-23aa-88b7d2b917d8@arm.com>
Date:   Fri, 4 Sep 2020 09:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599208259-11191-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2020 09:30, Anshuman Khandual wrote:
> Kernel virtual region [BPF_JIT_REGION_START..BPF_JIT_REGION_END] is missing
> from address_markers[], hence relevant page table entries are not displayed
> with /sys/kernel/debug/kernel_page_tables. This adds those missing markers.
> While here, also rename arch/arm64/mm/dump.c which sounds bit ambiguous, as
> arch/arm64/mm/ptdump.c instead.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

LGTM

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   arch/arm64/mm/Makefile             | 2 +-
>   arch/arm64/mm/{dump.c => ptdump.c} | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>   rename arch/arm64/mm/{dump.c => ptdump.c} (99%)
> 
> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
> index d91030f0ffee..2a1d275cd4d7 100644
> --- a/arch/arm64/mm/Makefile
> +++ b/arch/arm64/mm/Makefile
> @@ -4,7 +4,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
>   				   ioremap.o mmap.o pgd.o mmu.o \
>   				   context.o proc.o pageattr.o
>   obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
> -obj-$(CONFIG_PTDUMP_CORE)	+= dump.o
> +obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
>   obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
>   obj-$(CONFIG_NUMA)		+= numa.o
>   obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
> diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/ptdump.c
> similarity index 99%
> rename from arch/arm64/mm/dump.c
> rename to arch/arm64/mm/ptdump.c
> index 0b8da1cc1c07..265284dc942d 100644
> --- a/arch/arm64/mm/dump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -41,6 +41,8 @@ static struct addr_marker address_markers[] = {
>   	{ 0 /* KASAN_SHADOW_START */,	"Kasan shadow start" },
>   	{ KASAN_SHADOW_END,		"Kasan shadow end" },
>   #endif
> +	{ BPF_JIT_REGION_START,		"BPF start" },
> +	{ BPF_JIT_REGION_END,		"BPF end" },
>   	{ MODULES_VADDR,		"Modules start" },
>   	{ MODULES_END,			"Modules end" },
>   	{ VMALLOC_START,		"vmalloc() area" },
> 


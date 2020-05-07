Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0935C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EEA20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGK4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:56:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgEGK4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:56:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C7ED1FB;
        Thu,  7 May 2020 03:56:32 -0700 (PDT)
Received: from [10.37.12.117] (unknown [10.37.12.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93C723F68F;
        Thu,  7 May 2020 03:56:26 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm/arm64: release kvm->mmu_lock in loop to prevent
 starvation
To:     giangyi@amazon.com, maz@kernel.org
Cc:     james.morse@arm.com, julien.thierry.kdev@gmail.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
References: <20200415084229.29992-1-giangyi@amazon.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <0e448ae0-af4c-3f0a-2dd5-6ab86c0d60c0@arm.com>
Date:   Thu, 7 May 2020 12:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200415084229.29992-1-giangyi@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2020 09:42 AM, Jiang Yi wrote:
> Do cond_resched_lock() in stage2_flush_memslot() like what is done in
> unmap_stage2_range() and other places holding mmu_lock while processing
> a possibly large range of memory.
> 
> Signed-off-by: Jiang Yi <giangyi@amazon.com>
> ---
>   virt/kvm/arm/mmu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e3b9ee268823..7315af2c52f8 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -417,16 +417,19 @@ static void stage2_flush_memslot(struct kvm *kvm,
>   	phys_addr_t next;
>   	pgd_t *pgd;
>   
>   	pgd = kvm->arch.pgd + stage2_pgd_index(kvm, addr);
>   	do {
>   		next = stage2_pgd_addr_end(kvm, addr, end);
>   		if (!stage2_pgd_none(kvm, *pgd))
>   			stage2_flush_puds(kvm, pgd, addr, next);
> +
> +		if (next != end)
> +			cond_resched_lock(&kvm->mmu_lock);
>   	} while (pgd++, addr = next, addr != end);
>   }

Given that this is called under the srcu_lock this looks
good to me:

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>   
>   /**
>    * stage2_flush_vm - Invalidate cache for pages mapped in stage 2
>    * @kvm: The struct kvm pointer
>    *
>    * Go through the stage 2 page tables and invalidate any cache lines
> 


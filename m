Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA123C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEE3204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgFJLhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:37:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbgFJLgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:36:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E0CB1FB;
        Wed, 10 Jun 2020 04:36:30 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4303B3F66F;
        Wed, 10 Jun 2020 04:36:29 -0700 (PDT)
Date:   Wed, 10 Jun 2020 12:36:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shyam Thombre <sthombre@codeaurora.org>
Cc:     will.deacon@arm.com, ard.biesheuvel@arm.com, mark.rutland@arm.com,
        anshuman.khandual@arm.com, sashal@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: reset address tag set by kasan sw tagging
Message-ID: <20200610113626.GI26099@gaia>
References: <1591787384-5823-1-git-send-email-sthombre@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591787384-5823-1-git-send-email-sthombre@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 04:39:44PM +0530, Shyam Thombre wrote:
> KASAN sw tagging sets a random tag of 8 bits in the top byte of the pointer
> returned by the memory allocating functions. So for the functions unaware
> of this change, the top 8 bits of the address must be reset which is done
> by the function arch_kasan_reset_tag().
> 
> Signed-off-by: Shyam Thombre <sthombre@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e7fbc62..eae7655 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -723,6 +723,7 @@ int kern_addr_valid(unsigned long addr)
>  	pmd_t *pmdp, pmd;
>  	pte_t *ptep, pte;
>  
> +	addr = arch_kasan_reset_tag(addr);
>  	if ((((long)addr) >> VA_BITS) != -1UL)
>  		return 0;

It would be interesting to know what fails without this patch. The only
user seems to be read_kcore() and, at a quick look, I don't see how it
can generate tagged addresses.

-- 
Catalin

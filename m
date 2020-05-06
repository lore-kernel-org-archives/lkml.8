Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8551C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66F220714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588751001;
	bh=CNBwwDwBOdMK1xYnzJC73BfdILtwbAZgrZjht4vqeyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3bMaWTEc5HiFlhRdKJKp5Jhri1z4Wjg+Aqu9pk1HHmGvc0AdmoilYhJtZc6+NHRl
	 6Kj4+9Nh0uMK0SkR0ZQgOk0OT+K+HhjcH2Is/6fOYzCoe10+eYQtNxbs+eVpYPHs/y
	 U2Bx7WAUVzzn8NBXvEpJzOkeniCZZttkPp89dcBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgEFHnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgEFHnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:43:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5D2206E6;
        Wed,  6 May 2020 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751000;
        bh=CNBwwDwBOdMK1xYnzJC73BfdILtwbAZgrZjht4vqeyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUUm8BzZ8znSKBEEsbsVuGQDziUF1EF3dxO8+Wevy2T47Isn6Mbj360Qi8dfDWRM6
         fC4aJjGy4P7u43fwidS4zRE7/mmwnuYl1NTJYv7o/rTJqRtli2t/D66lUvn+IkgD+N
         dqEi3vJpYxPZOSFMOjzlXG1EF17kaCVBRkm2E5zM=
Date:   Wed, 6 May 2020 08:43:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
Message-ID: <20200506074315.GD7021@willie-the-truck>
References: <1588745534-24418-1-git-send-email-anshuman.khandual@arm.com>
 <1588745534-24418-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588745534-24418-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:42:12AM +0530, Anshuman Khandual wrote:
> Platform specific huge_ptep_get() is required only when fetching the huge
> PTE involves more than just dereferencing the page table pointer. This is
> not the case on arm64 platform. Hence huge_ptep_pte() can be dropped along
> with it's __HAVE_ARCH_HUGE_PTEP_GET subscription.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/hugetlb.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 2eb6c234d594..b88878ddc88b 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -17,12 +17,6 @@
>  extern bool arch_hugetlb_migration_supported(struct hstate *h);
>  #endif
>  
> -#define __HAVE_ARCH_HUGE_PTEP_GET
> -static inline pte_t huge_ptep_get(pte_t *ptep)
> -{
> -	return READ_ONCE(*ptep);
> -}

Hmm, I'm nervous about dropping the READ_ONCE() here. We added them after
running into page-table issues with THP [1] and it's really important to
use them consistently to avoid hitting that again.

If the generic code used READ_ONCE(), I'd be happy to switch to it.

Will

[1] https://lore.kernel.org/lkml/1506527369-19535-1-git-send-email-will.deacon@arm.com/

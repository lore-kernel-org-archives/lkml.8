Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7307C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962EC20768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594980508;
	bh=gCGv+BOdErj4My2s2UtMojCmurB5s1x7zRohk6RLUzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLeKFnSXHICERN+olt1WlEzjgFpYXlUf/OL2M+YP7vGEZfG3J9h1EXti9mVCI5z/G
	 SvOZM6Tk8P9yp5RVOpOhDHlr/zBptfSJweQofFmYk27pDKmz5ZwSL2juNv4jJQ2vwx
	 6sHwOM8agkYLl6QMeUr3uQM5bOyLOmG8j+SObbNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgGQKI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgGQKI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:08:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0072F20768;
        Fri, 17 Jul 2020 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594980505;
        bh=gCGv+BOdErj4My2s2UtMojCmurB5s1x7zRohk6RLUzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6hU5MZXfGTBkrenCHz4AuJpso3SHUOFQjex6kcXUXbdJ0/KjKb9tVTA1Epy43buQ
         vfq+qI4mSA5Ly1blOiEypsLlhD6v7X4YvSs8qQF0AxQJTREqfX6PU2C7UAHpU7OQca
         DW7fjdkZfS3Bpq/Man22UEi3CfmOdVHI7pHAippk=
Date:   Fri, 17 Jul 2020 11:08:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, xuyu@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [v2 PATCH] mm: avoid access flag update TLB flush for retried
 page fault
Message-ID: <20200717100820.GB8673@willie-the-truck>
References: <1594848990-55657-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594848990-55657-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:36:30AM +0800, Yang Shi wrote:
> Recently we found regression when running will_it_scale/page_fault3 test
> on ARM64.  Over 70% down for the multi processes cases and over 20% down
> for the multi threads cases.  It turns out the regression is caused by commit
> 89b15332af7c0312a41e50846819ca6613b58b4c ("mm: drop mmap_sem before
> calling balance_dirty_pages() in write fault").
> 
> The test mmaps a memory size file then write to the mapping, this would
> make all memory dirty and trigger dirty pages throttle, that upstream
> commit would release mmap_sem then retry the page fault.  The retried
> page fault would see correct PTEs installed by the first try then update
> dirty bit and clear read-only bit and flush TLBs for ARM.  The regression is
> caused by the excessive TLB flush.  It is fine on x86 since x86 doesn't
> clear read-only bit so there is no need to flush TLB for this case.
> 
> The page fault would be retried due to:
> 1. Waiting for page readahead
> 2. Waiting for page swapped in
> 3. Waiting for dirty pages throttling
> 
> The first two cases don't have PTEs set up at all, so the retried page
> fault would install the PTEs, so they don't reach there.  But the #3
> case usually has PTEs installed, the retried page fault would reach the
> dirty bit and read-only bit update.  But it seems not necessary to
> modify those bits again for #3 since they should be already set by the
> first page fault try.
> 
> Of course the parallel page fault may set up PTEs, but we just need care
> about write fault.  If the parallel page fault setup a writable and dirty
> PTE then the retried fault doesn't need do anything extra.  If the
> parallel page fault setup a clean read-only PTE, the retried fault should
> just call do_wp_page() then return as the below code snippet shows:
> 
> if (vmf->flags & FAULT_FLAG_WRITE) {
>         if (!pte_write(entry))
>             return do_wp_page(vmf);
> }
> 
> With this fix the test result get back to normal.
> 
> Fixes: 89b15332af7c ("mm: drop mmap_sem before calling balance_dirty_pages() in write fault")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Reported-by: Xu Yu <xuyu@linux.alibaba.com>
> Debugged-by: Xu Yu <xuyu@linux.alibaba.com>
> Tested-by: Xu Yu <xuyu@linux.alibaba.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> v2: * Incorporated the comment from Will Deacon.
>     * Updated the commit log per the discussion.
> 
>  mm/memory.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 87ec87c..e93e1da 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4241,8 +4241,14 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	if (vmf->flags & FAULT_FLAG_WRITE) {
>  		if (!pte_write(entry))
>  			return do_wp_page(vmf);
> -		entry = pte_mkdirty(entry);
>  	}
> +
> +	if (vmf->flags & FAULT_FLAG_TRIED)
> +		goto unlock;
> +
> +	if (vmf->flags & FAULT_FLAG_WRITE)
> +		entry = pte_mkdirty(entry);
> +


Thanks, this looks better to me.

Andrew -- please can you update the version in your tree?

Cheers,

Will

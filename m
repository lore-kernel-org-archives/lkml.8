Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74726C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1EA2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594195207;
	bh=0r+QvI5jh8QG7OsaTwnkEK/DAUV2jZcvDC3ZHZ6VbGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fEeA29czHvBkiRU4CRuBF+QOVK8ZZHEhZ2FzAkch4BKI2/q+6sTdRWw1yo1B1aHb9
	 O5EML+z4ZdH3VV0hh0uELTC8htonqQYtzau9ZamZjIvLgypmCO8/m3/6LwhMOZCHAs
	 te8R2mz9Kr8Vl/s+gySNrm+EjTNjZJ8DkSbEYiHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgGHIAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgGHIAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:00:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1213620672;
        Wed,  8 Jul 2020 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594195204;
        bh=0r+QvI5jh8QG7OsaTwnkEK/DAUV2jZcvDC3ZHZ6VbGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIha1NjJVhWDtXJkjzvcQ1HzPxx4TQJTigYw/zH2OaO0VK62aVoV2Iyx+K0s6xVWo
         i+uJOexYHRqEeMA1eG5p2bOHVWKMGg0s9bjT9HTTnCbSy7dyQ/tqTrXZl5D55fIqpR
         c8JxYpPzyPmY4f/7DIBCw5s9SDyb+TaSwnq9Blg0=
Date:   Wed, 8 Jul 2020 09:00:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, xuyu@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] mm: avoid access flag update TLB flush for retried
 page fault
Message-ID: <20200708075959.GA25498@willie-the-truck>
References: <1594148072-91273-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594148072-91273-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:54:32AM +0800, Yang Shi wrote:
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
> access flags and flush TLBs.  The regression is caused by the excessive
> TLB flush.  It is fine on x86 since x86 doesn't need flush TLB for
> access flag update.
> 
> The page fault would be retried due to:
> 1. Waiting for page readahead
> 2. Waiting for page swapped in
> 3. Waiting for dirty pages throttling
> 
> The first two cases don't have PTEs set up at all, so the retried page
> fault would install the PTEs, so they don't reach there.  But the #3
> case usually has PTEs installed, the retried page fault would reach the
> access flag update.  But it seems not necessary to update access flags
> for #3 since retried page fault is not real "second access", so it
> sounds safe to skip access flag update for retried page fault.
> 
> With this fix the test result get back to normal.
> 
> Reported-by: Xu Yu <xuyu@linux.alibaba.com>
> Debugged-by: Xu Yu <xuyu@linux.alibaba.com>
> Tested-by: Xu Yu <xuyu@linux.alibaba.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> I'm not sure if this is safe for non-x86 machines, we did some tests on arm64, but
> there may be still corner cases not covered.
> 
>  mm/memory.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 87ec87c..3d4e671 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4241,8 +4241,13 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	if (vmf->flags & FAULT_FLAG_WRITE) {
>  		if (!pte_write(entry))
>  			return do_wp_page(vmf);
> -		entry = pte_mkdirty(entry);
>  	}
> +
> +	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vmf->flags & FAULT_FLAG_TRIED))
> +		entry = pte_mkdirty(entry); 
> +	else if (vmf->flags & FAULT_FLAG_TRIED)
> +		goto unlock;
> +

Can you rewrite this as:

	if (vmf->flags & FAULT_FLAG_TRIED)
		goto unlock;

	if (vmf->flags & FAULT_FLAG_WRITE)
		entry = pte_mkdirty(entry);

? (I'm half-asleep this morning and there are people screaming and shouting
outside my window, so this might be rubbish)

If you _can_make that change, then I don't understand why the existing
pte_mkdirty() line needs to move at all. Couldn't you just add:

	if (vmf->flags & FAULT_FLAG_TRIED)
		goto unlock;

after the existing "vmf->flags & FAULT_FLAG_WRITE" block?

Will

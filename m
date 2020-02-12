Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74804C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFEA20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBLKWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:22:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:51938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLKWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:22:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 73FB0AC46;
        Wed, 12 Feb 2020 10:22:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C3D541E0E01; Wed, 12 Feb 2020 11:22:06 +0100 (CET)
Date:   Wed, 12 Feb 2020 11:22:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200212102206.GE25573@quack2.suse.cz>
References: <20200211001958.170261-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211001958.170261-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-02-20 16:19:58, Minchan Kim wrote:
> Basically, fault handler releases mmap_sem before requesting readahead
> and then it is supposed to retry lookup the page from page cache with
> FAULT_FLAG_TRIED so that it avoids the live lock of infinite retry.
> 
> However, what happens if the fault handler find a page from page
> cache and the page has readahead marker but are waiting under
> writeback? Plus one more condition, it happens under mm_populate
> which repeats faulting unless it encounters error. So let's assemble
> conditions below.
> 
> __mm_populate
> for (...)
>   get_user_pages(faluty_address)
>     handle_mm_fault
>       filemap_fault
>         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> 	it will return VM_FAULT_RETRY
>   continue with faulty_address
> 
> IOW, it will repeat fault retry logic until the page will be written
> back in the long run. It makes big spike latency of several seconds.
> 
> This patch solves the issue by turning off fault retry logic in second
> trial.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> It was orignated from code review once I have seen several user reports
> but didn't confirm yet it's the root cause.

Yes, I think the immediate problem is actually elsewhere but I agree that
__mm_populate() should follow the general protocol of retrying only once
so your change should make it more robust. The patch looks good to me, you
can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
>  mm/gup.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 1b521e0ac1de..b3f825092abf 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1196,6 +1196,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  	struct vm_area_struct *vma = NULL;
>  	int locked = 0;
>  	long ret = 0;
> +	bool tried = false;
>  
>  	end = start + len;
>  
> @@ -1226,14 +1227,18 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
>  		 * double checks the vma flags, so that it won't mlock pages
>  		 * if the vma was already munlocked.
>  		 */
> -		ret = populate_vma_page_range(vma, nstart, nend, &locked);
> +		ret = populate_vma_page_range(vma, nstart, nend,
> +						tried ? NULL : &locked);
>  		if (ret < 0) {
>  			if (ignore_errors) {
>  				ret = 0;
>  				continue;	/* continue at next VMA */
>  			}
>  			break;
> -		}
> +		} else if (ret == 0)
> +			tried = true;
> +		else
> +			tried = false;
>  		nend = nstart + ret * PAGE_SIZE;
>  		ret = 0;
>  	}
> -- 
> 2.25.0.225.g125e21ebc7-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

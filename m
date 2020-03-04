Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A445CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9F42073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583283542;
	bh=pBkv+zMpJnUHutM5TIKA7m+caWpqu0XAtFt3DpoXfP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=beXyYWMV3S1hc3vVY++jWPYJwonRXg9FhTJPwhtFMZVqiPLSNAe5Pmp0wODKilC9J
	 JIFHpMDrDK6Dt42y/tXS/2JdgnG4Pdgi9+dX7alDukx2HN0TME4YFYhby1a1QiBzZ+
	 F8sHR4WDeyCITyoBiDGzLwcvZNZbAD5VCN/F0qfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgCDA7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgCDA7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:59:00 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1BD420728;
        Wed,  4 Mar 2020 00:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583283540;
        bh=pBkv+zMpJnUHutM5TIKA7m+caWpqu0XAtFt3DpoXfP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cIEzDdbbbEFjL4w0k0SH481f3kjJzoI3WEPvR42mCswUUfFd22+Q3oxT2d7i4u2YK
         mHchKcRaDuxTpV1oOGOBRAy5BKCrCuh4tF3L34FLQCUdwYV4k9MmoGZuJ+m0HbZ1IF
         DaewpvraIeBODt7TnfBWu/LovTJHb/g8NCkSLNxo=
Date:   Tue, 3 Mar 2020 16:58:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Add PageLayzyFree() helper functions for MADV_FREE
Message-Id: <20200303165859.7440f23d388503ca77fdb6c2@linux-foundation.org>
In-Reply-To: <20200303033738.281908-1-ying.huang@intel.com>
References: <20200303033738.281908-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 11:37:38 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> Now PageSwapBacked() is used as the helper function to check whether
> pages have been freed lazily via MADV_FREE.  This isn't very obvious.
> So Dave suggested to add PageLazyFree() family helper functions to
> improve the code readability.
> 
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -498,6 +498,31 @@ static __always_inline int PageKsm(struct page *page)
>  TESTPAGEFLAG_FALSE(Ksm)
>  #endif
>  
> +/*
> + * For pages freed lazily via MADV_FREE.  lazyfree pages are clean
> + * anonymous pages.  They have SwapBacked flag cleared to distinguish
> + * with normal anonymous pages
> + */
> +static __always_inline int PageLazyFree(struct page *page)
> +{
> +	page = compound_head(page);
> +	return PageAnon(page) && !PageSwapBacked(page);
> +}
> +
> +static __always_inline void SetPageLazyFree(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageTail(page), page);
> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> +	ClearPageSwapBacked(page);
> +}
> +
> +static __always_inline void ClearPageLazyFree(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(PageTail(page), page);
> +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> +	SetPageSwapBacked(page);
> +}

These BUG_ONs aren't present in the current code and are
unchangelogged.

And they aren't free!

before:

q:/usr/src/25> size -t mm/rmap.o mm/swap.o mm/vmscan.o 
   text    data     bss     dec     hex filename
  41580    4211     192   45983    b39f mm/rmap.o
  50684    9259    1184   61127    eec7 mm/swap.o
 117728   46775     128  164631   28317 mm/vmscan.o
 209992   60245    1504  271741   4257d (TOTALS)

after:

   text    data     bss     dec     hex filename
  42035    4299     192   46526    b5be mm/rmap.o
  51091    9347    1184   61622    f0b6 mm/swap.o
 118132   46775     128  165035   284ab mm/vmscan.o
 211258   60421    1504  273183   42b1f (TOTALS)

ALso, if they actually trigger, Linus goes berserk.

If you have some special reason to add these assertions, please do it
as a (changelogged!) followup patch and I'll keep it as a linux-next only thing.



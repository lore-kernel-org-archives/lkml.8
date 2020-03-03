Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD36DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16802166E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 06:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2GjwNv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgCCGME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 01:12:04 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37181 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCCGME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 01:12:04 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so1904619otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 22:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gq/3yKSGvZrh++9IegruTZ10brzhg9cnheydTKKfza0=;
        b=G2GjwNv9lN32Lho4nclFA19SKiJf2vjcB7YJjjntip7ZmL5NB/zTb/C/qNY5lF6ohw
         xZj1d9Zi7FmqdQZP39pTh9yYMxTUvzFIcHglxvFcGwF2O7ni1gGwXEMzXiOnov+FjUso
         nUchSYqjnJAklZ5PZRIgMGmxymmWzexAS+H10mnAsEqYk3yVUvnucz40TBPtAih4G6wx
         hXCY/2/ylat0wl7M3+Rb+47FdzfxkjQh5XYvf078iLuRVx8M4xgHSSA/dwzEzDiY3RV2
         uFFB/3ZGqHlE64cWHlQxtSnz45fbgCfMDMDCQoif5QBxjpoqK8iO7s0AzfqBttW6ntZn
         ascw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gq/3yKSGvZrh++9IegruTZ10brzhg9cnheydTKKfza0=;
        b=gwKnq9BUgMiaKMYXKzzgVjV6M6OnKXQS2YWWNSfOF61bEwEurR6WgmY1b+3zxfuHN/
         QDngOHjcFfq4q3/hoIg3glh+F3Rcu2pjVKdbwPI7+j52IoE7RfTdqrsFlFqUbhDzc1Jh
         lhCYM2Ed3tEBW0WOhG2ztn9+0o8uYIdGHF8UMrwxHWoBRrKC0jZ/unZn8MlQTFWQ2HID
         auzK0ynMFo8XyPa9I/6kDwa6yxiJGxq/+4iKz1Ke9zV1iar/P4+pXnYhr07yvRuBm54t
         a75qQtavABj42Zfe1bUBUSle+MlMIXt4z4ApYWkMidcjIH2v/exBKJJ4jyr2iNevOaKL
         csTw==
X-Gm-Message-State: ANhLgQ3czrlbBMdV6aHw5b58G5jglTcAfZwjR6ki4RmTYB13U6RWA71D
        vKniSqHsD52RysbBkiqUyNs27Q==
X-Google-Smtp-Source: ADFU+vv95CXgWq8Xutk77esPJtjt3xQD8GBhtSJlxQcGmNWM+9/c8qSQT4iINbrY94/MJlh9qRtClw==
X-Received: by 2002:a05:6830:114:: with SMTP id i20mr2230238otp.320.1583215922975;
        Mon, 02 Mar 2020 22:12:02 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x69sm3512317oix.50.2020.03.02.22.12.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Mar 2020 22:12:02 -0800 (PST)
Date:   Mon, 2 Mar 2020 22:11:45 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm, migrate: Check return value of try_to_unmap()
In-Reply-To: <20200303033645.280694-1-ying.huang@intel.com>
Message-ID: <alpine.LSU.2.11.2003022150540.1344@eggly.anvils>
References: <20200303033645.280694-1-ying.huang@intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> During the page migration, try_to_unmap() is called to replace the
> page table entries with the migration entries.  Now its return value
> is ignored, that is generally OK in most cases.  But in theory, it's
> possible that try_to_unmap() return false (failure) for the page
> migration after arch_unmap_one() is called in unmap code.  Even if
> without arch_unmap_one(), it makes code more robust for the future
> code changing to check the return value.

No. This patch serves no purpose, and introduces a bug.

More robust? Robustness is provided by the later expected_count
checks, with freezing where necessary.

Saving time by not going further if try_to_unmap() failed?
That's done by the page_mapped() checks immediately following
the try_to_unmap() calls (just out of sight in two cases).

> 
> Known issue: I don't know what is the appropriate error code for
> try_to_unmap() failure.  Whether EIO is OK?

-EAGAIN is the rc already being used for this case,
and which indicates that retries may be appropriate
(but they're often scary overkill).

> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> ---
>  mm/migrate.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3900044cfaa6..981f8374a6ef 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1116,8 +1116,11 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  		/* Establish migration ptes */
>  		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
>  				page);
> -		try_to_unmap(page,
> -			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
> +		if (!try_to_unmap(page,
> +			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS)) {
> +			rc = -EIO;
> +			goto out_unlock_both;

No: even if try_to_unmap() says that it did not entirely succeed,
it may have unmapped some ptes, inserting migration entries in their
place. Those need to be replaced by proper ptes before the page is
unlocked, which page_was_mapped 1 and remove_migration_ptes() do;
but this goto skips those.
 
> +		}
>  		page_was_mapped = 1;
>  	}
>  
> @@ -1337,8 +1340,11 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  		goto put_anon;
>  
>  	if (page_mapped(hpage)) {
> -		try_to_unmap(hpage,
> -			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
> +		if (!try_to_unmap(hpage,
> +			TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS)) {
> +			rc = -EIO;
> +			goto unlock_both;

Same as above.

> +		}
>  		page_was_mapped = 1;
>  	}
>  
> @@ -1349,6 +1355,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  		remove_migration_ptes(hpage,
>  			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
>  
> +unlock_both:
>  	unlock_page(new_hpage);
>  
>  put_anon:
> @@ -2558,8 +2565,7 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
>  			continue;
>  
>  		if (page_mapped(page)) {
> -			try_to_unmap(page, flags);
> -			if (page_mapped(page))
> +			if (!try_to_unmap(page, flags))
>  				goto restore;
>  		}
>  
> -- 
> 2.25.0

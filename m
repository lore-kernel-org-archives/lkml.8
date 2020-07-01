Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E76C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CDE2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKjEzZQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgGAIrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGAIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:47:14 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA75C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:47:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a6so7085504pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bbtVmqRQKnV7gZcGZd0l56GROoC3zXrhRnq45f6YfIg=;
        b=QKjEzZQ7ep9R5lyPR977W/4cilb+bUE2jaLRq8w53cf23udngzV7h1jqZyvmjoINWu
         +V5eV/zt+dRZ53m3aPB0cPp1ng9wLxOLW+Dn89bLeEbf+0sac+uaDlWKpHiV9ZcvXxVW
         CvRLGIE1KWyUrizx2NfLV25zwyxyWtxzSoZ2AwOIoMgEsQipPK5DA9wBKg187sEyYRjZ
         NY094uOn257AW3hEuMn7iXfIy1Ux58R5/+C6qdgrzdgRIA8YkBdAi1hQ5fXOzlRpGVxH
         wptYdG6pp4JnDxoEYrhyTC+ZohTbjERKEhNI/gD7yi9dieLqW3/C7ERMdiWwk7N/U3DN
         lRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bbtVmqRQKnV7gZcGZd0l56GROoC3zXrhRnq45f6YfIg=;
        b=BFOe0ebdrx8G+utqxJgq15BsKgR7Wab2s2KdEmX10BCefCPp/G2WZ3yLVwXsMiAy+b
         DJddql2HjHivvKDo+pJuiKVOOFeCG7gAFQesGhJJUskzB7yQzOUf/SZAPV9DbeEq+r82
         C1Bll6Czd0htdFJNCO4GvEEHy7IvUJorAxuDITwdcYy2HsFg7UcxNYJCwsvjDT3plf2p
         TnRIofKfTKjWBluTbArkO5D0/RBpZ8xNPkoT1q3kFbkPhy1qWYOtBfcahgELgt8omhxY
         E7zpcjshT9rYb90WMdNWmKFyX46cR66pIjNqcxAqL4KtMiIsMIdM+qybV1fiNofjAjo+
         7mJw==
X-Gm-Message-State: AOAM533BQ3suqRLDHz9kU/L5o+L1w9oLUsOAzPpCRnwB/2ctkIiYfMV8
        dsT/IrV3bGMVDnAWwrfDPzv4W0gXjwp4
X-Google-Smtp-Source: ABdhPJyvy6Cjpf6XOZKQgkSEm7jovCp3XCE+P7Hulhq7qkGSkRnHqnxx7u8qYSxPfpK1g5H9scXtmVJALJ5A
X-Received: by 2002:a63:1f09:: with SMTP id f9mr18504939pgf.324.1593593233273;
 Wed, 01 Jul 2020 01:47:13 -0700 (PDT)
Date:   Wed, 01 Jul 2020 01:47:11 -0700
In-Reply-To: <20200629234507.CA0FDE19@viggo.jf.intel.com>
Message-Id: <xr93lfk38vw0.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200629234503.749E5340@viggo.jf.intel.com> <20200629234507.CA0FDE19@viggo.jf.intel.com>
Subject: Re: [RFC][PATCH 2/8] mm/migrate: Defer allocating new page until needed
From:   Greg Thelen <gthelen@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        kbusch@kernel.org, yang.shi@linux.alibaba.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
>
> Migrating pages had been allocating the new page before it was actually
> needed. Subsequent operations may still fail, which would have to handle
> cleaning up the newly allocated page when it was never used.
>
> Defer allocating the page until we are actually ready to make use of
> it, after locking the original page. This simplifies error handling,
> but should not have any functional change in behavior. This is just
> refactoring page migration so the main part can more easily be reused
> by other code.

Is there any concern that the src page is now held PG_locked over the
dst page allocation, which might wander into
reclaim/cond_resched/oom_kill?  I don't have a deadlock in mind.  I'm
just wondering about the additional latency imposed on unrelated threads
who want access src page.

> #Signed-off-by: Keith Busch <keith.busch@intel.com>

Is commented Signed-off-by intentional?  Same applies to later patches.

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>
>  b/mm/migrate.c |  148 ++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 75 insertions(+), 73 deletions(-)
>
> diff -puN mm/migrate.c~0007-mm-migrate-Defer-allocating-new-page-until-needed mm/migrate.c
> --- a/mm/migrate.c~0007-mm-migrate-Defer-allocating-new-page-until-needed	2020-06-29 16:34:37.896312607 -0700
> +++ b/mm/migrate.c	2020-06-29 16:34:37.900312607 -0700
> @@ -1014,56 +1014,17 @@ out:
>  	return rc;
>  }
>  
> -static int __unmap_and_move(struct page *page, struct page *newpage,
> -				int force, enum migrate_mode mode)
> +static int __unmap_and_move(new_page_t get_new_page,
> +			    free_page_t put_new_page,
> +			    unsigned long private, struct page *page,
> +			    enum migrate_mode mode,
> +			    enum migrate_reason reason)
>  {
>  	int rc = -EAGAIN;
>  	int page_was_mapped = 0;
>  	struct anon_vma *anon_vma = NULL;
>  	bool is_lru = !__PageMovable(page);
> -
> -	if (!trylock_page(page)) {
> -		if (!force || mode == MIGRATE_ASYNC)
> -			goto out;
> -
> -		/*
> -		 * It's not safe for direct compaction to call lock_page.
> -		 * For example, during page readahead pages are added locked
> -		 * to the LRU. Later, when the IO completes the pages are
> -		 * marked uptodate and unlocked. However, the queueing
> -		 * could be merging multiple pages for one bio (e.g.
> -		 * mpage_readpages). If an allocation happens for the
> -		 * second or third page, the process can end up locking
> -		 * the same page twice and deadlocking. Rather than
> -		 * trying to be clever about what pages can be locked,
> -		 * avoid the use of lock_page for direct compaction
> -		 * altogether.
> -		 */
> -		if (current->flags & PF_MEMALLOC)
> -			goto out;
> -
> -		lock_page(page);
> -	}
> -
> -	if (PageWriteback(page)) {
> -		/*
> -		 * Only in the case of a full synchronous migration is it
> -		 * necessary to wait for PageWriteback. In the async case,
> -		 * the retry loop is too short and in the sync-light case,
> -		 * the overhead of stalling is too much
> -		 */
> -		switch (mode) {
> -		case MIGRATE_SYNC:
> -		case MIGRATE_SYNC_NO_COPY:
> -			break;
> -		default:
> -			rc = -EBUSY;
> -			goto out_unlock;
> -		}
> -		if (!force)
> -			goto out_unlock;
> -		wait_on_page_writeback(page);
> -	}
> +	struct page *newpage;
>  
>  	/*
>  	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
> @@ -1082,6 +1043,12 @@ static int __unmap_and_move(struct page
>  	if (PageAnon(page) && !PageKsm(page))
>  		anon_vma = page_get_anon_vma(page);
>  
> +	newpage = get_new_page(page, private);
> +	if (!newpage) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Block others from accessing the new page when we get around to
>  	 * establishing additional references. We are usually the only one
> @@ -1091,11 +1058,11 @@ static int __unmap_and_move(struct page
>  	 * This is much like races on refcount of oldpage: just don't BUG().
>  	 */
>  	if (unlikely(!trylock_page(newpage)))
> -		goto out_unlock;
> +		goto out_put;
>  
>  	if (unlikely(!is_lru)) {
>  		rc = move_to_new_page(newpage, page, mode);
> -		goto out_unlock_both;
> +		goto out_unlock;
>  	}
>  
>  	/*
> @@ -1114,7 +1081,7 @@ static int __unmap_and_move(struct page
>  		VM_BUG_ON_PAGE(PageAnon(page), page);
>  		if (page_has_private(page)) {
>  			try_to_free_buffers(page);
> -			goto out_unlock_both;
> +			goto out_unlock;
>  		}
>  	} else if (page_mapped(page)) {
>  		/* Establish migration ptes */
> @@ -1131,15 +1098,9 @@ static int __unmap_and_move(struct page
>  	if (page_was_mapped)
>  		remove_migration_ptes(page,
>  			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
> -
> -out_unlock_both:
> -	unlock_page(newpage);
>  out_unlock:
> -	/* Drop an anon_vma reference if we took one */
> -	if (anon_vma)
> -		put_anon_vma(anon_vma);
> -	unlock_page(page);
> -out:
> +	unlock_page(newpage);
> +out_put:
>  	/*
>  	 * If migration is successful, decrease refcount of the newpage
>  	 * which will not free the page because new page owner increased
> @@ -1150,12 +1111,20 @@ out:
>  	 * state.
>  	 */
>  	if (rc == MIGRATEPAGE_SUCCESS) {
> +		set_page_owner_migrate_reason(newpage, reason);
>  		if (unlikely(!is_lru))
>  			put_page(newpage);
>  		else
>  			putback_lru_page(newpage);
> +	} else if (put_new_page) {
> +		put_new_page(newpage, private);
> +	} else {
> +		put_page(newpage);
>  	}
> -
> +out:
> +	/* Drop an anon_vma reference if we took one */
> +	if (anon_vma)
> +		put_anon_vma(anon_vma);
>  	return rc;
>  }
>  
> @@ -1203,8 +1172,7 @@ static ICE_noinline int unmap_and_move(n
>  				   int force, enum migrate_mode mode,
>  				   enum migrate_reason reason)
>  {
> -	int rc = MIGRATEPAGE_SUCCESS;
> -	struct page *newpage = NULL;
> +	int rc = -EAGAIN;
>  
>  	if (!thp_migration_supported() && PageTransHuge(page))
>  		return -ENOMEM;
> @@ -1219,17 +1187,57 @@ static ICE_noinline int unmap_and_move(n
>  				__ClearPageIsolated(page);
>  			unlock_page(page);
>  		}
> +		rc = MIGRATEPAGE_SUCCESS;
>  		goto out;
>  	}
>  
> -	newpage = get_new_page(page, private);
> -	if (!newpage)
> -		return -ENOMEM;
> +	if (!trylock_page(page)) {
> +		if (!force || mode == MIGRATE_ASYNC)
> +			return rc;
>  
> -	rc = __unmap_and_move(page, newpage, force, mode);
> -	if (rc == MIGRATEPAGE_SUCCESS)
> -		set_page_owner_migrate_reason(newpage, reason);
> +		/*
> +		 * It's not safe for direct compaction to call lock_page.
> +		 * For example, during page readahead pages are added locked
> +		 * to the LRU. Later, when the IO completes the pages are
> +		 * marked uptodate and unlocked. However, the queueing
> +		 * could be merging multiple pages for one bio (e.g.
> +		 * mpage_readpages). If an allocation happens for the
> +		 * second or third page, the process can end up locking
> +		 * the same page twice and deadlocking. Rather than
> +		 * trying to be clever about what pages can be locked,
> +		 * avoid the use of lock_page for direct compaction
> +		 * altogether.
> +		 */
> +		if (current->flags & PF_MEMALLOC)
> +			return rc;
> +
> +		lock_page(page);
> +	}
> +
> +	if (PageWriteback(page)) {
> +		/*
> +		 * Only in the case of a full synchronous migration is it
> +		 * necessary to wait for PageWriteback. In the async case,
> +		 * the retry loop is too short and in the sync-light case,
> +		 * the overhead of stalling is too much
> +		 */
> +		switch (mode) {
> +		case MIGRATE_SYNC:
> +		case MIGRATE_SYNC_NO_COPY:
> +			break;
> +		default:
> +			rc = -EBUSY;
> +			goto out_unlock;
> +		}
> +		if (!force)
> +			goto out_unlock;
> +		wait_on_page_writeback(page);
> +	}
> +	rc = __unmap_and_move(get_new_page, put_new_page, private,
> +			      page, mode, reason);
>  
> +out_unlock:
> +	unlock_page(page);
>  out:
>  	if (rc != -EAGAIN) {
>  		/*
> @@ -1269,9 +1277,8 @@ out:
>  		if (rc != -EAGAIN) {
>  			if (likely(!__PageMovable(page))) {
>  				putback_lru_page(page);
> -				goto put_new;
> +				goto done;
>  			}
> -
>  			lock_page(page);
>  			if (PageMovable(page))
>  				putback_movable_page(page);
> @@ -1280,13 +1287,8 @@ out:
>  			unlock_page(page);
>  			put_page(page);
>  		}
> -put_new:
> -		if (put_new_page)
> -			put_new_page(newpage, private);
> -		else
> -			put_page(newpage);
>  	}
> -
> +done:
>  	return rc;
>  }
>  
> _

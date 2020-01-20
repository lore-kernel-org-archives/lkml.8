Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CADC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF8F2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579515725;
	bh=B7OQkzXUq5qScMVr914olXmFCHhkCMFuuBAwdKnwr9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L1w/so4vfLbLHWQQO/S4r7VXhXupwHO4PCujZsZFYDlq1x1YS9oz9AEUpC7p73axR
	 vl+XNS97aqZ/8FMN9cgw9dOV4KoSDrW6LStfdKkVnrW/5sL+U0814DCBGr1eDNAyaJ
	 1U3AkHuw7MWxo7uFVK320bhkC+q4qFIVd6P1SqoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgATKWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:22:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36982 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgATKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:22:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so14113028wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 02:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbm5di5vXHtzwgB8Y6nBPj8ah0P3MuQdgmNtWPBOPP4=;
        b=cifplJrmxCLeoQOHj1nyYB12kR9m0Br7hTSQvmpOUpi6g9EgAS5Aq6BJuwS20bo4l+
         w6kmCtWLRig9YtQx3b+3nz2CA51ULYfU69skZy44JyrKxPtre2rq/i+jw2tZw/kI9Vll
         aoBn9FHlnskWe1g2ptLPsSgy2WUzFH62/ymNUA3zF1Fm81kmdVv3o9sCdhQiANNqOrLx
         8puEyuDlATyG2tjvADTTxjFYOhoA9LlQqgdVHDGC9pWN4Ws289qYmJjpz0YzqXjNHdRr
         /Lk7Y5VBXsmf9reD/UysCipfG9wc2xl9vUg0vvshzRhgBv2oqvujAufMjW25d+6Xfl90
         TuFQ==
X-Gm-Message-State: APjAAAX44J2QvaMXPLVYgpT+PEQlnuhYUlk8i6wg2YFNMlo8WxGdo0mz
        8UX3U/AZbjZB9j70056EtAk=
X-Google-Smtp-Source: APXvYqxWG4IEGru8SBnEIah91uAMRY5UJooyI81T4dEpFUbo1FSWo1ptoJ0EbASvpa8WdykUIBkTSQ==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr17740668wmj.96.1579515721753;
        Mon, 20 Jan 2020 02:22:01 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n189sm329608wme.33.2020.01.20.02.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:22:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:22:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rientjes@google.com
Subject: Re: [Patch v2 3/4] mm/page_alloc.c: pass all bad reasons to
 bad_page()
Message-ID: <20200120102200.GW18451@dhcp22.suse.cz>
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-4-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120030415.15925-4-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 11:04:14, Wei Yang wrote:
> Now we can pass all bad reasons to __dump_page().

And we do we want to do that? The dump of the page will tell us the
whole story so a single and the most important reason sounds like a
better implementation. The code is also more subtle because each caller
of the function has to be aware of how many reasons there might be.
Not to mention that you need a room for 5 pointers on the stack and this
and page allocator might be called from deeper call chains.

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/page_alloc.c | 52 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a43b9d2482f2..a7b793c739fc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -609,7 +609,7 @@ static inline int __maybe_unused bad_range(struct zone *zone, struct page *page)
>  }
>  #endif
>  
> -static void bad_page(struct page *page, const char *reason,
> +static void bad_page(struct page *page, int nr, const char **reason,
>  		unsigned long bad_flags)
>  {
>  	static unsigned long resume;
> @@ -638,7 +638,7 @@ static void bad_page(struct page *page, const char *reason,
>  
>  	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
>  		current->comm, page_to_pfn(page));
> -	__dump_page(page, 1, &reason);
> +	__dump_page(page, nr, reason);
>  	bad_flags &= page->flags;
>  	if (bad_flags)
>  		pr_alert("bad because of flags: %#lx(%pGp)\n",
> @@ -1027,27 +1027,25 @@ static inline bool page_expected_state(struct page *page,
>  
>  static void free_pages_check_bad(struct page *page)
>  {
> -	const char *bad_reason;
> -	unsigned long bad_flags;
> -
> -	bad_reason = NULL;
> -	bad_flags = 0;
> +	const char *bad_reason[5];
> +	unsigned long bad_flags = 0;
> +	int nr = 0;
>  
>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
> -		bad_reason = "nonzero mapcount";
> +		bad_reason[nr++] = "nonzero mapcount";
>  	if (unlikely(page->mapping != NULL))
> -		bad_reason = "non-NULL mapping";
> +		bad_reason[nr++] = "non-NULL mapping";
>  	if (unlikely(page_ref_count(page) != 0))
> -		bad_reason = "nonzero _refcount";
> +		bad_reason[nr++] = "nonzero _refcount";
>  	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
> -		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
> +		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
>  		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
>  	}
>  #ifdef CONFIG_MEMCG
>  	if (unlikely(page->mem_cgroup))
> -		bad_reason = "page still charged to cgroup";
> +		bad_reason[nr++] = "page still charged to cgroup";
>  #endif
> -	bad_page(page, bad_reason, bad_flags);
> +	bad_page(page, nr, bad_reason, bad_flags);
>  }
>  
>  static inline int free_pages_check(struct page *page)
> @@ -1062,6 +1060,7 @@ static inline int free_pages_check(struct page *page)
>  
>  static int free_tail_pages_check(struct page *head_page, struct page *page)
>  {
> +	const char *reason;
>  	int ret = 1;
>  
>  	/*
> @@ -1078,7 +1077,8 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
>  	case 1:
>  		/* the first tail page: ->mapping may be compound_mapcount() */
>  		if (unlikely(compound_mapcount(page))) {
> -			bad_page(page, "nonzero compound_mapcount", 0);
> +			reason = "nonzero compound_mapcount";
> +			bad_page(page, 1, &reason, 0);
>  			goto out;
>  		}
>  		break;
> @@ -1090,17 +1090,20 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
>  		break;
>  	default:
>  		if (page->mapping != TAIL_MAPPING) {
> -			bad_page(page, "corrupted mapping in tail page", 0);
> +			reason = "corrupted mapping in tail page";
> +			bad_page(page, 1, &reason, 0);
>  			goto out;
>  		}
>  		break;
>  	}
>  	if (unlikely(!PageTail(page))) {
> -		bad_page(page, "PageTail not set", 0);
> +		reason = "PageTail not set";
> +		bad_page(page, 1, &reason, 0);
>  		goto out;
>  	}
>  	if (unlikely(compound_head(page) != head_page)) {
> -		bad_page(page, "compound_head not consistent", 0);
> +		reason = "compound_head not consistent";
> +		bad_page(page, 1, &reason, 0);
>  		goto out;
>  	}
>  	ret = 0;
> @@ -2041,29 +2044,30 @@ static inline void expand(struct zone *zone, struct page *page,
>  
>  static void check_new_page_bad(struct page *page)
>  {
> -	const char *bad_reason = NULL;
> +	const char *bad_reason[5];
>  	unsigned long bad_flags = 0;
> +	int nr = 0;
>  
>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
> -		bad_reason = "nonzero mapcount";
> +		bad_reason[nr++] = "nonzero mapcount";
>  	if (unlikely(page->mapping != NULL))
> -		bad_reason = "non-NULL mapping";
> +		bad_reason[nr++] = "non-NULL mapping";
>  	if (unlikely(page_ref_count(page) != 0))
> -		bad_reason = "nonzero _refcount";
> +		bad_reason[nr++] = "nonzero _refcount";
>  	if (unlikely(page->flags & __PG_HWPOISON)) {
>  		/* Don't complain about hwpoisoned pages */
>  		page_mapcount_reset(page); /* remove PageBuddy */
>  		return;
>  	}
>  	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_PREP)) {
> -		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
> +		bad_reason[nr++] = "PAGE_FLAGS_CHECK_AT_PREP flag set";
>  		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
>  	}
>  #ifdef CONFIG_MEMCG
>  	if (unlikely(page->mem_cgroup))
> -		bad_reason = "page still charged to cgroup";
> +		bad_reason[nr++] = "page still charged to cgroup";
>  #endif
> -	bad_page(page, bad_reason, bad_flags);
> +	bad_page(page, 1, bad_reason, bad_flags);
>  }
>  
>  /*
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs

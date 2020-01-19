Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5FDC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB075206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkuRsCH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgASWGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:06:21 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43474 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgASWGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:06:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so14495923pga.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 14:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=68HQTriyud3hSemdZ3Q5jhIfxQrwWHJ5pRMS4dq0wH4=;
        b=vkuRsCH1P3C+DUNAUhzEgCBECKKeqKhCK/U8NoCXNlAe8O/VJP0308w1PmiKQCdHtf
         Fadeo2zJOmWsGV8wFcFP60rHrCO7h9Y40+6hboeoewf/L54XRNXwhiC7Ho3i8/FEZ3MO
         QhTKyo81adpCj40y8XFNUXPMD3GR2zC+R1YZqcrB/wo9SUpdUC6HEkLPzI+fhly21zq1
         6yEhow4DUHXrj980YdSOWTzSD2llmjzz1H+JwjZeJwWkpXcOfY/yD+sD2vAwvFBETwku
         Yslteojgp6Ed6MHgZj2K1XBm0909AUsO4+STO9hrd5OZAJs+x/yCLtCHmXo27B75A5/b
         39Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=68HQTriyud3hSemdZ3Q5jhIfxQrwWHJ5pRMS4dq0wH4=;
        b=W4hmjuYQhyj1FfskiPQxSOKU88wOhYxV1fsHL70Pqr3jVWzyAgHIg4bS71CiQ6tqgz
         8aQxs8pDMURpR5WY1Oy2x6/EFigo4nAjxvJC+gEbRP3NQR8wqeV92vEmpUJs53cgh3hL
         ofTE3p2OkKEKAkPZG+nZ5JRxEZEMhnJLkcLinBqkzk4AIZDaRWtasxRKAFSwfLowwu8x
         UtRs0F2P0rfMYwmgzerq1oPDrEfG1T9mAiC1sH4T401htddA51HUKaNw5bGrqTuwMlXJ
         80Gb8lJgmpU4sAAvR6nAXcz7hxkydWYUrn+nb3y8v71VUQtbfn4eOPpZCg/jfJQ0rjH8
         Yijg==
X-Gm-Message-State: APjAAAVO2ab/dbUUqmGK9wq3uXTOe2vOdIZJ3C5Ildpcy1T9lK3uKZET
        OG3tnRESjXHerRrHRboBe7iKHIaevjA=
X-Google-Smtp-Source: APXvYqy3T98OD/R+OoQiqnE1AoxgXq5IgcVJqBU+5qmWJWnDGcqCuNoDfQANOX9bvmYkBEF260DSBQ==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr55969557pgp.6.1579471580087;
        Sun, 19 Jan 2020 14:06:20 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b12sm36019062pfi.157.2020.01.19.14.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 14:06:19 -0800 (PST)
Date:   Sun, 19 Jan 2020 14:06:18 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm/page_alloc.c: extract commom part to check page
In-Reply-To: <20200119131408.23247-2-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001191401240.43388@chino.kir.corp.google.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com> <20200119131408.23247-2-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020, Wei Yang wrote:

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d047bf7d8fd4..8cd06729169f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1025,13 +1025,9 @@ static inline bool page_expected_state(struct page *page,
>  	return true;
>  }
>  
> -static void free_pages_check_bad(struct page *page)
> +static inline const char *__check_page(struct page *page)
>  {
> -	const char *bad_reason;
> -	unsigned long bad_flags;
> -
> -	bad_reason = NULL;
> -	bad_flags = 0;
> +	const char *bad_reason = NULL;
>  
>  	if (unlikely(atomic_read(&page->_mapcount) != -1))
>  		bad_reason = "nonzero mapcount";
> @@ -1039,14 +1035,23 @@ static void free_pages_check_bad(struct page *page)
>  		bad_reason = "non-NULL mapping";
>  	if (unlikely(page_ref_count(page) != 0))
>  		bad_reason = "nonzero _refcount";
> -	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
> -		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
> -		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
> -	}
>  #ifdef CONFIG_MEMCG
>  	if (unlikely(page->mem_cgroup))
>  		bad_reason = "page still charged to cgroup";
>  #endif
> +	return bad_reason;
> +}
> +
> +static void free_pages_check_bad(struct page *page)
> +{
> +	const char *bad_reason = NULL;
> +	unsigned long bad_flags = 0;
> +
> +	bad_reason = __check_page(page);
> +	if (unlikely(page->flags & PAGE_FLAGS_CHECK_AT_FREE)) {
> +		bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
> +		bad_flags = PAGE_FLAGS_CHECK_AT_FREE;
> +	}
>  	bad_page(page, bad_reason, bad_flags);
>  }
>  
> @@ -2044,12 +2049,7 @@ static void check_new_page_bad(struct page *page)
>  	const char *bad_reason = NULL;
>  	unsigned long bad_flags = 0;
>  
> -	if (unlikely(atomic_read(&page->_mapcount) != -1))
> -		bad_reason = "nonzero mapcount";
> -	if (unlikely(page->mapping != NULL))
> -		bad_reason = "non-NULL mapping";
> -	if (unlikely(page_ref_count(page) != 0))
> -		bad_reason = "nonzero _refcount";
> +	bad_reason = __check_page(page);
>  	if (unlikely(page->flags & __PG_HWPOISON)) {
>  		bad_reason = "HWPoisoned (hardware-corrupted)";
>  		bad_flags = __PG_HWPOISON;
> @@ -2061,10 +2061,6 @@ static void check_new_page_bad(struct page *page)
>  		bad_reason = "PAGE_FLAGS_CHECK_AT_PREP flag set";
>  		bad_flags = PAGE_FLAGS_CHECK_AT_PREP;
>  	}
> -#ifdef CONFIG_MEMCG
> -	if (unlikely(page->mem_cgroup))
> -		bad_reason = "page still charged to cgroup";
> -#endif
>  	bad_page(page, bad_reason, bad_flags);
>  }
>  

I think this is compounding a previous problem in these functions: these 
are all "if" clauses, not "else if" clauses so they are presumably ordered 
based on least significant to most significant (we only see the last 
bad_reason that we find).  For the page->mem_cgroup check, this leaves 
bad_flags set but it doesn't match bad_reason.

Could you instead fix the problem with these functions so that we actually 
list *all* the problems with the page rather than only the last 
conditional that is true?

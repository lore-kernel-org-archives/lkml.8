Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A2C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559302073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgATGLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:11:10 -0500
Received: from foss.arm.com ([217.140.110.172]:56094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgATGLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:11:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE5C31B;
        Sun, 19 Jan 2020 22:11:09 -0800 (PST)
Received: from [10.162.16.78] (p8cg001049571a15.blr.arm.com [10.162.16.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 234B83F52E;
        Sun, 19 Jan 2020 22:14:40 -0800 (PST)
Subject: Re: [Patch v2 1/4] mm: enable dump several reasons for __dump_page()
To:     Wei Yang <richardw.yang@linux.intel.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-2-richardw.yang@linux.intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <8426f31b-606e-deca-acbe-dd59b193e113@arm.com>
Date:   Mon, 20 Jan 2020 11:42:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200120030415.15925-2-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/20/2020 08:34 AM, Wei Yang wrote:
> This is a preparation to dump all reasons during check page.

This really makes sense rather then just picking the reason from
the last "if" statement.

> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  include/linux/mmdebug.h |  2 +-
>  mm/debug.c              | 11 ++++++-----
>  mm/page_alloc.c         |  2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 2ad72d2c8cc5..f0a612db8bae 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -10,7 +10,7 @@ struct vm_area_struct;
>  struct mm_struct;
>  
>  extern void dump_page(struct page *page, const char *reason);
> -extern void __dump_page(struct page *page, const char *reason);
> +extern void __dump_page(struct page *page, int num, const char **reason);
>  void dump_vma(const struct vm_area_struct *vma);
>  void dump_mm(const struct mm_struct *mm);
>  
> diff --git a/mm/debug.c b/mm/debug.c
> index 0461df1207cb..a8ac6f951f9f 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -42,11 +42,11 @@ const struct trace_print_flags vmaflag_names[] = {
>  	{0, NULL}
>  };
>  
> -void __dump_page(struct page *page, const char *reason)
> +void __dump_page(struct page *page, int num, const char **reason)
>  {
>  	struct address_space *mapping;
>  	bool page_poisoned = PagePoisoned(page);
> -	int mapcount;
> +	int mapcount, i;
>  
>  	/*
>  	 * If struct page is poisoned don't access Page*() functions as that
> @@ -97,8 +97,9 @@ void __dump_page(struct page *page, const char *reason)
>  			sizeof(unsigned long), page,
>  			sizeof(struct page), false);
>  
> -	if (reason)
> -		pr_warn("page dumped because: %s\n", reason);
> +	pr_warn("page dumped because:\n");
> +	for (i = 0; i < num; i++)
> +		pr_warn("\t%s\n", reason[i]);

We should have a NR_BAD_PAGE_REASONS or something to cap this iteration
and also check reason[i] for non-NULL before trying to print the array.
There might be call sites like the following which will be problematic
otherwise.

split_huge_page_to_list() -> dump_page(head, NULL)

>  
>  #ifdef CONFIG_MEMCG
>  	if (!page_poisoned && page->mem_cgroup)

While here, will it be better to move the above debug print block after
mem_cgroup block instead ?

> @@ -108,7 +109,7 @@ void __dump_page(struct page *page, const char *reason)
>  
>  void dump_page(struct page *page, const char *reason)
>  {
> -	__dump_page(page, reason);
> +	__dump_page(page, 1, &reason);
>  	dump_page_owner(page);
>  }
>  EXPORT_SYMBOL(dump_page);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d047bf7d8fd4..0cf6218aaba7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -638,7 +638,7 @@ static void bad_page(struct page *page, const char *reason,
>  
>  	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
>  		current->comm, page_to_pfn(page));
> -	__dump_page(page, reason);
> +	__dump_page(page, 1, &reason);
>  	bad_flags &= page->flags;
>  	if (bad_flags)
>  		pr_alert("bad because of flags: %#lx(%pGp)\n",
> 

Do we still need to have bad_flags ? After consolidating all reasons making
a page bad should not we just print page->flags unconditionally each time and
let the user decipher it instead. __dump_page() will print page->flags for
each case (atleast after the new patch from Vlastimil). AFAICS, the only
place currently consuming bad_flags is bad_page() which seems redundant after
first calling __dump_page().

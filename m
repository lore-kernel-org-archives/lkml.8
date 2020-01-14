Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C9C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15854207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579008925;
	bh=DcEXgaibemI8vByOF3DvoC3Gw68QT+yvZJZ3HMR3lyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KM2d/iaD0QFdl9UOgjzg0TkIbymT02E7zptpLGNQ+Qkhyg+wGJ4gekPFichhknX+p
	 RJ1scZWWui4EAuRBoB77/ANoNXxP9h6UI8ybfweZP19wjb0NVP2AkIKkXJEPaF6pEf
	 gPTlxlBXcDUjAtMjz6akGwjElX8ifsL4b2h2SIfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgANNfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:35:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55554 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgANNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:35:24 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so13794565wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8VqjYHbpabchJbxExbEKyshv65LeYUyVLG0yJ6Bwpk=;
        b=JGHhoNu/1mNs9zXCdvmDtgT1jrAuyvWlU8y2R1neGeFOtaJGEn+453LRW1WxypwQ0A
         qi4y2A9fIu4rYuo/syP2i8rYeCZU9HBrBirEmPcHHZoXiplQ1pekv7NaJyuiQKSFHbdr
         gqX6+a0VgMI6RGJF+gXgpEwhBylgoOG4A6XgrlZd2QNdExpwN/kV+ZkGuyZIPOpWcJJw
         cZRazgINlzgLc34ooTyFrvwaUBFnNOdev4wKhCYYLbVFVWx9nTgtPQ08ulNTzomQUyGl
         1gLcVwJk1t1JW+6zCCJQ7TCpEAJ/aQjBaA9PhSQHi3VQBHeYcgecqfKIs99spu2j4ahV
         auyA==
X-Gm-Message-State: APjAAAXwVZbFewQ6pV4hLu0OPbKHSVBho+fQDabSC3m7p42L2liRi27G
        yztSJUwCf2kbGeAJOwC/1sk=
X-Google-Smtp-Source: APXvYqzKZG/y8qrPgY7GJDcPUYO4tOMrcmQHLyBQabjDUrZEj7dqWfVnwXF91bHinYIOW1Wv6l/aLA==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr26493328wmb.53.1579008921620;
        Tue, 14 Jan 2020 05:35:21 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m126sm19116112wmf.7.2020.01.14.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:35:20 -0800 (PST)
Date:   Tue, 14 Jan 2020 14:35:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm, debug: always print flags in dump_page()
Message-ID: <20200114133520.GO19428@dhcp22.suse.cz>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
 <20200114091013.GD19428@dhcp22.suse.cz>
 <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
 <20200114113230.GM19428@dhcp22.suse.cz>
 <9f884d5c-ca60-dc7b-219c-c081c755fab6@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f884d5c-ca60-dc7b-219c-c081c755fab6@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-01-20 13:04:31, Vlastimil Babka wrote:
[...]
> >From 7b673c45bc16526586ae8ea6fba416a547baa04e Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 14 Jan 2020 12:52:48 +0100
> Subject: [PATCH] mm, debug: always print flags in dump_page()
> 
> Commit 76a1850e4572 ("mm/debug.c: __dump_page() prints an extra line")
> inadvertently removed printing of page flags for pages that are neither
> anon nor ksm nor have a mapping. Fix that.
> 
> Using pr_cont() again would be a solution, but the commit explicitly removed
> its use. Avoiding the danger of mixing up split lines from multiple CPUs might
> be beneficial for near-panic dumps like this, so fix this without reintroducing
> pr_cont().
> 
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reported-by: Michal Hocko <mhocko@kernel.org>
> Fixes: 76a1850e4572 ("mm/debug.c: __dump_page() prints an extra line")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/debug.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 0461df1207cb..6a52316af839 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -47,6 +47,7 @@ void __dump_page(struct page *page, const char *reason)
>  	struct address_space *mapping;
>  	bool page_poisoned = PagePoisoned(page);
>  	int mapcount;
> +	char *type = "";
>  
>  	/*
>  	 * If struct page is poisoned don't access Page*() functions as that
> @@ -78,9 +79,9 @@ void __dump_page(struct page *page, const char *reason)
>  			page, page_ref_count(page), mapcount,
>  			page->mapping, page_to_pgoff(page));
>  	if (PageKsm(page))
> -		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +		type = "ksm ";
>  	else if (PageAnon(page))
> -		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +		type = "anon ";
>  	else if (mapping) {
>  		if (mapping->host && mapping->host->i_dentry.first) {
>  			struct dentry *dentry;
> @@ -88,10 +89,11 @@ void __dump_page(struct page *page, const char *reason)
>  			pr_warn("%ps name:\"%pd\"\n", mapping->a_ops, dentry);
>  		} else
>  			pr_warn("%ps\n", mapping->a_ops);
> -		pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  	}
>  	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) != __NR_PAGEFLAGS + 1);
>  
> +	pr_warn("%sflags: %#lx(%pGp)\n", type, page->flags, &page->flags);
> +
>  hex_only:
>  	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
>  			sizeof(unsigned long), page,
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs

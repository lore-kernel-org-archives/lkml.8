Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BBC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722A524676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579001555;
	bh=yZiEqE5euko9vq5wSphId4s8qSoSJ6qnsbC7MMTGYz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M3jDX6BrOwtVeET1CxIPt5if/gERR1yM4UACCIy1VWIZuCtOsidaARTWrgU98hwro
	 lcFR/PKNKSex37I+lx1FUzV0vxktXCXBqHVMjiX++vAIqrFVtIUcRSJXASNXz4oznT
	 +blj5IWX4OozLa1X1LsPmffHBO5O7eHjTA3fXg3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgANLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:32:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37127 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:32:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so13301060wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:32:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pNR3NFApkzwBRWUY1yWsS3r7ps19YeFIKgoV6SnxNc8=;
        b=HtGrddSQCNZl+i8pJWmLQ2naEFW7CFQ8saRw6earkn7JYDbbk0iB3OvyC+d6LV5dHv
         93Xac5L/2n8D6Q/FWIho+/09mYYXI1c+x2VzinGHTJC+w9CMoaiyRqb0bmler2LNwj4n
         hots9gdK0SvTqMYh0pf+8SlDgQWH7TWMHHFKHYe6F01SX3zlpm9yoQ0Zk5uu9MZGtyTk
         SK7rk7vaJB/RQtZYLz0MHwtXJJxeeNfgJLxLUQD3CTCtsPtCFj4ms/c6zU66VsE78U7s
         VAJ13BTpZ59Fa6bA2t3Mnq2D5hyskPVDMg97lDY+4cTj4kdtqLk2zTy2I9TO2LuNT0d8
         oIQw==
X-Gm-Message-State: APjAAAXMBsDlnEDVyMhESAu83TbF6st4C1pJh1apfqm64mo2l8Ngh9DO
        Mv5a/xx65PCz2KYTqRovF8K4ucIY
X-Google-Smtp-Source: APXvYqzMygljDOCWMN+Awr2DOrnrV+6E4eJIgx4LYtBx2oLAFvTdD/Hh+4vOZ4XSMGuAOORRG836ow==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr25570568wml.115.1579001552048;
        Tue, 14 Jan 2020 03:32:32 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i11sm19629688wrs.10.2020.01.14.03.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 03:32:30 -0800 (PST)
Date:   Tue, 14 Jan 2020 12:32:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
Message-ID: <20200114113230.GM19428@dhcp22.suse.cz>
References: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
 <6A58E80B-7A5F-4CAD-ACF1-89BCCBE4D3B1@lca.pw>
 <a0bfcebe-a0f4-95ef-0973-8edd3780d013@redhat.com>
 <f6487dc1-c962-67aa-131e-2eec4f6ca686@arm.com>
 <20200114091013.GD19428@dhcp22.suse.cz>
 <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3ff7fc-2f6b-d8e5-85a5-078f0e1a0daf@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-01-20 11:23:52, Vlastimil Babka wrote:
> On 1/14/20 10:10 AM, Michal Hocko wrote:
> > [Cc Ralph]
> >> The reason is dump_page() does not print page->flags universally
> >> and only does so for KSM, Anon and File pages while excluding
> >> reserved pages at boot. Wondering should not we make printing
> >> page->flags universal ?
> > 
> > We used to do that and this caught me as a surprise when looking again.
> > This is a result of 76a1850e4572 ("mm/debug.c: __dump_page() prints an
> > extra line") which is a cleanup patch and I suspect this result was not
> > anticipated.
> > 
> > The following will do the trick but I cannot really say I like the code
> > duplication. pr_cont in this case sounds like a much cleaner solution to
> > me.
> 
> How about this then?

Yes makes sense as well.

> diff --git mm/debug.c mm/debug.c
> index 0461df1207cb..6a52316af839 100644
> --- mm/debug.c
> +++ mm/debug.c
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
> 

-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F39CC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB38020784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585840187;
	bh=3N7+NNJpAWSrD8CrNViUPsqTTLPWpB3tFKMxnpsOmw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VrdS/jxVof8MwSXCAgVyED7gxJUHyB9QTzwVWhZoADaKwY6UGtJAKD2OoB3NNLOpS
	 ELnlStHyt7IV51Ybu60OlDMiYeSpYUWjTzDP5ckAGkgJ0IwrpGWPdHj8thW5YWzx9z
	 n8EEDEy77VAuj5P4UUyFCnkUcyLFDm+puEGUo2os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbgDBPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:09:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39128 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbgDBPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:09:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id e9so4043196wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IzmBnhtvMbCjV8tzRzlpiEgx3qo8Ajloo9hkC5XA5sI=;
        b=dTaAIhujTaxPptTfEVZLGym6aZGpcLL1ZBiLQakUzTDaf0qHcPEBvLhvso1Q6w7PiO
         V6wson48dCJXQVu4NYo2DoMOKx/mOk8lLjHQEOpknRERlo4Jhp9/2vNgSxvOdIUZHgyl
         RvmaKTdNJuRbq0rpE4HTW+WxKCdtIIeqNYnNQf/J6GLvE9W2pCbIuJUA9n0gTkPlD0C3
         71RCtqIL7JQY5G/8EZopns+vnMT8VcW1cisOz0O94eVS0yyLwS/e3cOK7Wax/y5+ucHb
         GI/BodVW9K5kgY/hADOeZWxL1nAtJj7ZqXGr0Ru7UI846l5HJDIebSGy1en97CSXYFoB
         oVZg==
X-Gm-Message-State: AGi0Pub56HmimFEzNeQuWYXCrlfzW46oO5lXW8l/wCSiJuD3Kw1lqp9W
        CoYgjCjBlbBcd58VAfDFZes=
X-Google-Smtp-Source: APiQypJn2MGOY4VurMh/qrWnCC2gpzdDH1iz7GRuT1DvPLJWl5+4x4WcSSJ6AjPePFQjIrTTUmNtRQ==
X-Received: by 2002:a1c:2d95:: with SMTP id t143mr3942988wmt.89.1585840183917;
        Thu, 02 Apr 2020 08:09:43 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id j6sm8350963wrb.4.2020.04.02.08.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:09:43 -0700 (PDT)
Date:   Thu, 2 Apr 2020 17:09:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATVH v1 RESEND] mm: remove unused
 free_bootmem_with_active_regions
Message-ID: <20200402150942.GT22681@dhcp22.suse.cz>
References: <20200402143455.5145-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402143455.5145-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 22:34:55, Baoquan He wrote:
> Since commit 397dc00e249ec64e10 ("mips: sgi-ip27: switch from DISCONTIGMEM
> to SPARSEMEM"), the last caller of free_bootmem_with_active_regions() was
> gone. Now no user calls it any more.
> 
> Let's remove it.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> RESEND:
>   To add linux-mm to CC list.
> 
>  include/linux/mm.h |  4 ----
>  mm/page_alloc.c    | 25 -------------------------
>  2 files changed, 29 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1cd8b8f8534d..9c093f7c751d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2363,8 +2363,6 @@ static inline unsigned long get_num_physpages(void)
>   * 	memblock_add_node(base, size, nid)
>   * free_area_init_nodes(max_zone_pfns);
>   *
> - * free_bootmem_with_active_regions() calls free_bootmem_node() for each
> - * registered physical page range.  Similarly
>   * sparse_memory_present_with_active_regions() calls memory_present() for
>   * each range when SPARSEMEM is enabled.
>   *
> @@ -2380,8 +2378,6 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
>  extern void get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn);
>  extern unsigned long find_min_pfn_with_active_regions(void);
> -extern void free_bootmem_with_active_regions(int nid,
> -						unsigned long max_low_pfn);
>  extern void sparse_memory_present_with_active_regions(int nid);
>  
>  #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 138a56c0f48f..2892ebeaa6c9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6356,31 +6356,6 @@ int __meminit __early_pfn_to_nid(unsigned long pfn,
>  }
>  #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
>  
> -/**
> - * free_bootmem_with_active_regions - Call memblock_free_early_nid for each active range
> - * @nid: The node to free memory on. If MAX_NUMNODES, all nodes are freed.
> - * @max_low_pfn: The highest PFN that will be passed to memblock_free_early_nid
> - *
> - * If an architecture guarantees that all ranges registered contain no holes
> - * and may be freed, this this function may be used instead of calling
> - * memblock_free_early_nid() manually.
> - */
> -void __init free_bootmem_with_active_regions(int nid, unsigned long max_low_pfn)
> -{
> -	unsigned long start_pfn, end_pfn;
> -	int i, this_nid;
> -
> -	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, &this_nid) {
> -		start_pfn = min(start_pfn, max_low_pfn);
> -		end_pfn = min(end_pfn, max_low_pfn);
> -
> -		if (start_pfn < end_pfn)
> -			memblock_free_early_nid(PFN_PHYS(start_pfn),
> -					(end_pfn - start_pfn) << PAGE_SHIFT,
> -					this_nid);
> -	}
> -}
> -
>  /**
>   * sparse_memory_present_with_active_regions - Call memory_present for each active range
>   * @nid: The node to call memory_present for. If MAX_NUMNODES, all nodes will be used.
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs

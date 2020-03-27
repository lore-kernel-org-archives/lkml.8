Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4243CC2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6A020717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585296376;
	bh=ySO2MVgrf0i+U0lCrWCF6pCKjSI3HsjB5OuWmX4u4J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ohy63aUSGHQ37phqvYjY/yJ1vUsyWYiYhZVLzXcsXvfvSZZEpJvf8mtp7V4uHZuNS
	 y76uOdUVomK85HgNexhCIvUQ1C2+zN9WRN6qne/iLveA2RQVGDNPZrtXfH4P3YKP7k
	 94X4iwzLMzVhY+Q1Oml9NnH7GqUt0p4yb0nLyuvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgC0IGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:06:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35401 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgC0IGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:06:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id f74so329554wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 01:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+hDXOm5WCnsUpdgGd5tCD0aAXh23Ryn8Dpip6SfJKPc=;
        b=KSvzC/PuBG0XYxlkIHuMZ1T3IKii/7KyF5jzt9aKihx4r3kT4wxV9JdxYOVz4dzAsD
         lPivgzjouQOGGC8M1LA/h7vy0/bvCBgE33yHlyfl+N8erQDRkqmGWpCExvAGZscLL2fq
         +tTuZuAPd8kK73UcIyHuaed2/A7DabJ6PZOujkdlxFePGoboTyroUj18O1guqwl+Nk7P
         eOQrRWE8RdM/YvUDRclX7J8l96nNlyh6YYS+DPiknwtN0RdC1xA2UJu8/lEfp3xlt80B
         hP+BnZlVxe00YBfY8H5z8rXw1XjEPhrDgWT4fPmumMh3r/mEvKK5PTzoBg1ZBq3hPwg1
         NsOA==
X-Gm-Message-State: ANhLgQ2BbLpIheOyYQdKk2T7118EjECEFmM23BM3Hw1AXVp8LuiUWdXt
        5JESkzl++asO9U4kLL4r4XI=
X-Google-Smtp-Source: ADFU+vvnAH4CRXXIAOBtQnVbBi/VjSxTmWVj5FtZIhmC1Z9N3RoP18VJ1K/CRLtKMZm+FgtwydUveg==
X-Received: by 2002:a1c:a908:: with SMTP id s8mr4293370wme.133.1585296372162;
        Fri, 27 Mar 2020 01:06:12 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id p13sm7363912wru.3.2020.03.27.01.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 01:06:11 -0700 (PDT)
Date:   Fri, 27 Mar 2020 09:06:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Aslan Bakirov <aslan@fb.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        guro@fb.com, hannes@cmpxchg.org
Subject: Re: [PATCH 2/2] mm: hugetlb: Use node interface of cma
Message-ID: <20200327080610.GV27965@dhcp22.suse.cz>
References: <20200326212718.3798742-1-aslan@fb.com>
 <20200326212718.3798742-2-aslan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326212718.3798742-2-aslan@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-03-20 14:27:18, Aslan Bakirov wrote:
> With introduction of numa node interface for CMA, this patch is for using that
> interface for allocating memory on numa nodes if NUMA is configured.
> This will be more efficient  and cleaner because first, instead of iterating
> mem range of each numa node, cma_declare_contigueous_nid() will do
> its own address finding if we pass 0 for  both min_pfn and max_pfn,
> second, it can also handle caseswhere NUMA is not configured
> by passing NUMA_NO_NODE as an argument.
> 
> In addition, checking if desired size of memory is available or not,
> is happening in cma_declare_contiguous_nid()  because base and
> limit will be determined there, since 0(any) for  base and
> 0(any) for limit is passed as argument to the function.

This looks much better than the original patch. Can we simply squash
your and Roman's patch in the mmotm tree and post it for the review in
one piece? It would be slightly easier to review that way.

> Signed-off-by: Aslan Bakirov <aslan@fb.com>

Thanks!

> ---
>  mm/hugetlb.c | 40 +++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b9f0c903c4cf..62989220c4ff 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5573,42 +5573,24 @@ void __init hugetlb_cma_reserve(int order)
>  
>  	reserved = 0;
>  	for_each_node_state(nid, N_ONLINE) {
> -		unsigned long min_pfn = 0, max_pfn = 0;
>  		int res;
> -#ifdef CONFIG_NUMA
> -		unsigned long start_pfn, end_pfn;
> -		int i;
>  
> -		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> -			if (!min_pfn)
> -				min_pfn = start_pfn;
> -			max_pfn = end_pfn;
> -		}
> -#else
> -		min_pfn = min_low_pfn;
> -		max_pfn = max_low_pfn;
> -#endif
>  		size = min(per_node, hugetlb_cma_size - reserved);
>  		size = round_up(size, PAGE_SIZE << order);
> -
> -		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
> -			pr_warn("hugetlb_cma: cma_area is too big, please try less than %lu MiB\n",
> -				round_down(((max_pfn - min_pfn) << PAGE_SHIFT) *
> -					   nr_online_nodes / 2 / SZ_1M,
> -					   PAGE_SIZE << order));
> -			break;
> -		}
> -
> -		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> -					     PFN_PHYS(max_pfn),
> +		
> +		
> +#ifndef CONFIG_NUMA
> +		nid = NUMA_NO_NODE
> +#endif		
> +		res = cma_declare_contiguous_nid(0, size,
> +					     0, 
>  					     PAGE_SIZE << order,
>  					     0, false,
> -					     "hugetlb", &hugetlb_cma[nid]);
> +					     "hugetlb", &hugetlb_cma[nid], nid);		
> +
>  		if (res) {
> -			phys_addr_t begpa = PFN_PHYS(min_pfn);
> -			phys_addr_t endpa = PFN_PHYS(max_pfn);
> -			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap)\n",
> -				__func__, res, nid, &begpa, &endpa);
> +			pr_warn("%s: reservation failed: err %d, node %d\n",
> +				__func__, res, nid);
>  			break;
>  		}
>  
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs

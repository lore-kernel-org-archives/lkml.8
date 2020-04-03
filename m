Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EFAC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74E62077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585910217;
	bh=kp6xbiJ44r4v7ema3LzxnDg62Zr4pbCL1fUx7ZUe3F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lGyQqWoLsalnPtN/Qh7TWzrY2LPKNS5jbw8OZ3WRntCcSc3PTFN0W/AcIGe8qwwCO
	 KXr56XtpJec1ecNMXyjsIrKwsQ4Im/jiQ6uKYZ3MMbyesAj4MXPLFQykmUL5MwEhue
	 MQPX/uPt1YRJ8VbBkpQVHtoicEJ5qlHcYB4fhRgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390541AbgDCKgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:36:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33678 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:36:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so7970537wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 03:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T00fOEaSfVQZvteNm45+ejbBVsW27ZWpyHUWye58+sw=;
        b=PyY5bOnZdGFztXNhY3xt7ePVdjZOFxlp7rvYXa+XQQ/vzPCd5wFkGEbwZr520LVKHH
         5ujbAb3f+jlKH2hCKY2FZijosINQX03SPTJKfIRq9IFvr+RwWQRAOqfckA2jjXRqg2I5
         vMyl0FaQX+YGP59jxs2QFLjNCGYd+aDjgLvYBV0rxvkOOHgILdZpmJkM3lI9Qnb/u/Vr
         XC9EziKsgrviLiJIJAMoVuOV5KUB8Jtg0CGhKmErW6tLlpWnahZJeZeKzOl/5fkjFhXW
         8pj6mVRrgDzWbBvKVHx8a4cNthREq1VHLVkDrGnLVDXlFEP+mr+rJa3t3TR41SF7/ipv
         u4lA==
X-Gm-Message-State: AGi0PuanAN6zCRgLgLDpKopoi1+7uGhS4Mb8kwbf/sVE/WrJizcg1aPO
        +EoC4cm5vz+t6BzBNLlVTp4=
X-Google-Smtp-Source: APiQypJZKnMBt4mLRQia4ePd2MHVn1gbcWbjMjRqb4YtFMcIN4y9RELiYh945OqrPKDgJ8gB91IcHA==
X-Received: by 2002:adf:91c3:: with SMTP id 61mr8191556wri.384.1585910213400;
        Fri, 03 Apr 2020 03:36:53 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id g186sm11418219wmg.36.2020.04.03.03.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 03:36:52 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:36:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Aslan Bakirov <aslan@fb.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        guro@fb.com, hannes@cmpxchg.org
Subject: Re: [PATCH 2/2] mm: hugetlb: Use node interface of cma
Message-ID: <20200403103651.GA22681@dhcp22.suse.cz>
References: <20200403101843.406634-1-aslan@fb.com>
 <20200403101843.406634-2-aslan@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403101843.406634-2-aslan@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-04-20 03:18:43, Aslan Bakirov wrote:
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

I have asked to merge this one with the original patch from Roman
several times but it seems this is not going to happen. But whatever.

You have likely missed my review feedback http://lkml.kernel.org/r/20200402172404.GV22681@dhcp22.suse.cz.
The ifdef CONFIG_NUMA for the nid definition is pointless.

> Signed-off-by: Aslan Bakirov <aslan@fb.com>

After fixing that, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

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
> 2.24.1

-- 
Michal Hocko
SUSE Labs

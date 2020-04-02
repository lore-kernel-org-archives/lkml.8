Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DA9C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355712078B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585848251;
	bh=QRxk5qzPbsHgYvvfvQaMgH88VEqcmn/DBBUnvptetWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ltL/Ql2y9SjovIJLoEaosfFk0JEInpGtJl7a+oRZo7eNSP6Y3cCOyJNfgHCQe/tcu
	 oDgkgwn7wn9Nxc/4GSEfPsSfH9Nlec8GCM/4lChdormTvr9GLHa83ifr4lX38vaS6e
	 senMFVuPTvaogHXHn5g7JK9Gu6dni5caxPeB6kao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgDBRYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:24:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37566 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732970AbgDBRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:24:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so5234299wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gaMt57vPOGEf104iF+Okoz30/leVUnWlYWQaZv9joEs=;
        b=DNJQBzgs2T4851pBZ9qtjY/2r8inpNWlnKz45ODIcL4jiBpYGCS1g0SCrpd9dyFX2x
         QPNfF8OsovlKhKl7aXQ/dO0d5UzmPPcfvcSKOaWZgSo7ofMTIlBLnP84POFrtydNc5IE
         EDJzVL5Aj3uwLpCZ6ERglwz+0uKWdrNKiNC0duw7zJJTuY6Fg5DVIlYhkLEMGt5zHyIn
         CY6v8bCIU75TLRJM6B856WC9pRiXBf8xICMQeKEvfrJeKldlGk+qlr7y8x3GUMMI434p
         kqYNyGJhuBoWOn1lK5yb/H9X367jgfA7CUcZ6DXp3oeV0eesZXbDDQaCfrhQmu8fFWFd
         TJgQ==
X-Gm-Message-State: AGi0PuYu93dsAscpjW/AdbgmPXpybXP4UBUIuiAUCNZVJbvijgUclxDJ
        qnJYOe9At1b/PNARLSNbOt4=
X-Google-Smtp-Source: APiQypJS5BBtet99zjncxG5VPVNNr9mscplYuCzxjsRdatXKvNHcZ1fWM/moVUdNiy2BoQkZZNFs0g==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr4440369wrt.408.1585848246012;
        Thu, 02 Apr 2020 10:24:06 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id 195sm8083093wmb.8.2020.04.02.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:24:05 -0700 (PDT)
Date:   Thu, 2 Apr 2020 19:24:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Aslan Bakirov <aslan@fb.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        hannes@cmpxchg.org
Subject: Re: [PATCH 2/2] mm: hugetlb: Use node interface of cma
Message-ID: <20200402172404.GV22681@dhcp22.suse.cz>
References: <20200326212718.3798742-1-aslan@fb.com>
 <20200326212718.3798742-2-aslan@fb.com>
 <20200327080610.GV27965@dhcp22.suse.cz>
 <20200327144155.GA194089@carbon.DHCP.thefacebook.com>
 <20200327151339.GF10449@dhcp22.suse.cz>
 <bc4af092-fb30-c8af-564c-ab2c0986109e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4af092-fb30-c8af-564c-ab2c0986109e@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-04-20 17:20:01, Vlastimil Babka wrote:
[...]
> FWIW, for review purposes, this is Roman's patch with all followups from
> mmotm/next (hopefully didn't miss any) and then squashed with patch 2/2 from
> this thread. It can be applied like this:
> 
> - checkout v5.6
> - apply patch 1/2 from this thread
> - apply below

Thanks!

> ----8<----
> >From dc10a593f2b8dfc7be920b4b088a8d55068fc6bc Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Thu, 2 Apr 2020 13:49:04 +1100
> Subject: [PATCH] mm: hugetlb: optionally allocate gigantic hugepages using cma
> 
> Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at
> runtime") has added the run-time allocation of gigantic pages.  However it
> actually works only at early stages of the system loading, when the
> majority of memory is free.  After some time the memory gets fragmented by
> non-movable pages, so the chances to find a contiguous 1 GB block are
> getting close to zero.  Even dropping caches manually doesn't help a lot.
> 
> At large scale rebooting servers in order to allocate gigantic hugepages
> is quite expensive and complex.  At the same time keeping some constant
> percentage of memory in reserved hugepages even if the workload isn't
> using it is a big waste: not all workloads can benefit from using 1 GB
> pages.
> 
> The following solution can solve the problem:
> 1) On boot time a dedicated cma area* is reserved. The size is passed
>    as a kernel argument.
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area
> 
> In this case gigantic hugepages can be allocated successfully with a high
> probability, however the memory isn't completely wasted if nobody is using
> 1GB hugepages: it can be used for pagecache, anon memory, THPs, etc.
> 
> * On a multi-node machine a per-node cma area is allocated on each node.
>   Following gigantic hugetlb allocation are using the first available
>   numa node if the mask isn't specified by a user.
> 
> Usage:
> 1) configure the kernel to allocate a cma area for hugetlb allocations:
>    pass hugetlb_cma=10G as a kernel argument
> 
> 2) allocate hugetlb pages as usual, e.g.
>    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 
> If the option isn't enabled or the allocation of the cma area failed,
> the current behavior of the system is preserved.
> 
> x86 and arm-64 are covered by this patch, other architectures can be
> trivially added later.
> 
> Link: http://lkml.kernel.org/r/20200311220920.2487528-1-guro@fb.com
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Tested-by: Andreas Schaufler <andreas.schaufler@gmx.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Andreas Schaufler <andreas.schaufler@gmx.de>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Joonsoo Kim <js1304@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> mm: hugetlb: Use node interface of cma
> 
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
> 
> Signed-off-by: Aslan Bakirov <aslan@fb.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Minor nit below. For the squashed version feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  arch/arm64/mm/init.c                          |  6 ++
>  arch/x86/kernel/setup.c                       |  4 +
>  include/linux/hugetlb.h                       |  8 ++
>  mm/hugetlb.c                                  | 98 +++++++++++++++++++
>  5 files changed, 123 insertions(+)
> 

[...]

> +	reserved = 0;
> +	for_each_node_state(nid, N_ONLINE) {
> +		int res;
> +
> +		size = min(per_node, hugetlb_cma_size - reserved);
> +		size = round_up(size, PAGE_SIZE << order);
> +		
> +		
> +#ifndef CONFIG_NUMA
> +		nid = NUMA_NO_NODE
> +#endif		

This can be dropped. UMA will simply use node 0 and the memblock
allocator will just do the right thing.

> +		res = cma_declare_contiguous_nid(0, size,
> +					     0, 
> +					     PAGE_SIZE << order,
> +					     0, false,
> +					     "hugetlb", &hugetlb_cma[nid], nid);		
> +
> +		if (res) {
> +			pr_warn("%s: reservation failed: err %d, node %d\n",
> +				__func__, res, nid);
> +			break;
> +		}
> +
> +		reserved += size;
> +		pr_info("hugetlb_cma: reserved %lu MiB on node %d\n",
> +			size / SZ_1M, nid);
> +
> +		if (reserved >= hugetlb_cma_size)
> +			break;
> +	}
> +}
> +
> +#endif /* CONFIG_CMA */
> -- 
> 2.26.0

-- 
Michal Hocko
SUSE Labs

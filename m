Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DBEC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8F82078B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585322025;
	bh=ZSzMiuMV7j96JcvaLpUsbqRTO9JsipV1flRs3cdzOO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BmXww9+vOfSZvo2NXJhsyYOQUZ7UYJGlXUSlTPnTMZPzvxMrGlxxvVtIN7haksJIt
	 FPoZnltjoroED3xDScHAfLPXEVxKpzwvSNvtJ1V7bB8DaO7wHqBVMYeAPEZ5rtJC2t
	 d2e5FjitUmZbo/qiA5Yj7FICTgqngZBnMydbRRWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0PNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:13:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45587 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgC0PNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:13:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so11776602wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 08:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TD24+hkutpMgt0iPw/rGYPKhqAHDpVhUJ7yNPUmJv4=;
        b=Pa5VCKHtvH7fObw1IvXNRMOWFGTncDKbPv//FjQILO1DycXybIOyKwn+UBmacAOa1Z
         M+dCXDrCZ/5KFPNVNIKNFYQJvrgkLCwofKmABAbfuV0lU6ZVjGqc2L2sLH90Rb5tiUdO
         eOs2bZuisds78vQ03LvKPfKKAua55C5vRZsCT+DYTDvKR5/SP/pKs7fzkR2lBC/PI7Mt
         7nj1/oL9nkdkQoyjwdzuyx9gMUrKkzwP6JgosLZEiWy4/bjf8fmg28kwdNsiVmheDidH
         /7LL3Q/AUK6Zu63h3BMUwagU8RTOpU6voHOGfWX586A5X8a3C1boet0G1RZmXtr0gZ11
         hFCQ==
X-Gm-Message-State: ANhLgQ2u0VcHgnE5pKMPlHhOb9nDBdYMVBEvHYi6gzky7d4GyDn9iR8d
        XY2c/xIrmHU7sJZbqoElwAQ7eSdg
X-Google-Smtp-Source: ADFU+vuFDQZOAvDdzskDCqOh1TSEBOaR5tfJzf39uuVDjLzoiSLd2rIgYTp6c3l01It/gbPVl10ZDw==
X-Received: by 2002:a05:6000:1090:: with SMTP id y16mr14692648wrw.281.1585322022026;
        Fri, 27 Mar 2020 08:13:42 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id k15sm8658889wrm.55.2020.03.27.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 08:13:41 -0700 (PDT)
Date:   Fri, 27 Mar 2020 16:13:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Aslan Bakirov <aslan@fb.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, riel@surriel.com, hannes@cmpxchg.org
Subject: Re: [PATCH 2/2] mm: hugetlb: Use node interface of cma
Message-ID: <20200327151339.GF10449@dhcp22.suse.cz>
References: <20200326212718.3798742-1-aslan@fb.com>
 <20200326212718.3798742-2-aslan@fb.com>
 <20200327080610.GV27965@dhcp22.suse.cz>
 <20200327144155.GA194089@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327144155.GA194089@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27-03-20 07:41:55, Roman Gushchin wrote:
> On Fri, Mar 27, 2020 at 09:06:10AM +0100, Michal Hocko wrote:
> > On Thu 26-03-20 14:27:18, Aslan Bakirov wrote:
> > > With introduction of numa node interface for CMA, this patch is for using that
> > > interface for allocating memory on numa nodes if NUMA is configured.
> > > This will be more efficient  and cleaner because first, instead of iterating
> > > mem range of each numa node, cma_declare_contigueous_nid() will do
> > > its own address finding if we pass 0 for  both min_pfn and max_pfn,
> > > second, it can also handle caseswhere NUMA is not configured
> > > by passing NUMA_NO_NODE as an argument.
> > > 
> > > In addition, checking if desired size of memory is available or not,
> > > is happening in cma_declare_contiguous_nid()  because base and
> > > limit will be determined there, since 0(any) for  base and
> > > 0(any) for limit is passed as argument to the function.
> > 
> > This looks much better than the original patch. Can we simply squash
> > your and Roman's patch in the mmotm tree and post it for the review in
> > one piece? It would be slightly easier to review that way.
> 
> I'm glad you liked it! I agree, it's much nicer now, thanks to Aslan!
> 
> I think it's simpler to keep it as a separate patch, because there was
> already a fix by Randy Dunlap on top of my original version.

Why would be squashing all those into a single one be a problem. I will
not insist of course but I would much rather see a single patch which is
easy to review and doesn't contain any intermediate hacks to prevent
from compile time issues than 3 patches with the last one removing hacks
and a large part of the implementation. You can easily record the
multiple authors can be easily recorded in the s-o-b chain.

> > > Signed-off-by: Aslan Bakirov <aslan@fb.com>
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> 
> Thanks!
> 
> > 
> > Thanks!
> > 
> > > ---
> > >  mm/hugetlb.c | 40 +++++++++++-----------------------------
> > >  1 file changed, 11 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index b9f0c903c4cf..62989220c4ff 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -5573,42 +5573,24 @@ void __init hugetlb_cma_reserve(int order)
> > >  
> > >  	reserved = 0;
> > >  	for_each_node_state(nid, N_ONLINE) {
> > > -		unsigned long min_pfn = 0, max_pfn = 0;
> > >  		int res;
> > > -#ifdef CONFIG_NUMA
> > > -		unsigned long start_pfn, end_pfn;
> > > -		int i;
> > >  
> > > -		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > > -			if (!min_pfn)
> > > -				min_pfn = start_pfn;
> > > -			max_pfn = end_pfn;
> > > -		}
> > > -#else
> > > -		min_pfn = min_low_pfn;
> > > -		max_pfn = max_low_pfn;
> > > -#endif
> > >  		size = min(per_node, hugetlb_cma_size - reserved);
> > >  		size = round_up(size, PAGE_SIZE << order);
> > > -
> > > -		if (size > ((max_pfn - min_pfn) << PAGE_SHIFT) / 2) {
> > > -			pr_warn("hugetlb_cma: cma_area is too big, please try less than %lu MiB\n",
> > > -				round_down(((max_pfn - min_pfn) << PAGE_SHIFT) *
> > > -					   nr_online_nodes / 2 / SZ_1M,
> > > -					   PAGE_SIZE << order));
> > > -			break;
> > > -		}
> > > -
> > > -		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
> > > -					     PFN_PHYS(max_pfn),
> > > +		
> > > +		
> > > +#ifndef CONFIG_NUMA
> > > +		nid = NUMA_NO_NODE
> > > +#endif		
> > > +		res = cma_declare_contiguous_nid(0, size,
> > > +					     0, 
> > >  					     PAGE_SIZE << order,
> > >  					     0, false,
> > > -					     "hugetlb", &hugetlb_cma[nid]);
> > > +					     "hugetlb", &hugetlb_cma[nid], nid);		
> > > +
> > >  		if (res) {
> > > -			phys_addr_t begpa = PFN_PHYS(min_pfn);
> > > -			phys_addr_t endpa = PFN_PHYS(max_pfn);
> > > -			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap)\n",
> > > -				__func__, res, nid, &begpa, &endpa);
> > > +			pr_warn("%s: reservation failed: err %d, node %d\n",
> > > +				__func__, res, nid);
> > >  			break;
> > >  		}
> > >  
> > > -- 
> > > 2.17.1
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs

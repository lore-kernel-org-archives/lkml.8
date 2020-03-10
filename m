Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B152C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FCE21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583861864;
	bh=Yss8GtactVyqtKUgKTqqIPvBiJL+Pm4RF4KBiwr12ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z01mEA93/53+QckPYA7TV/vBYF05Aw6cuYdw69UxrnSdOOcGd8rxDssE57zQIT8jj
	 c8kTrQi7m4JBiwiYvTx24TRddnfgSpznNbvrERLfj0T2/uBnKMUrCSV1TLSur+LknL
	 AYgHKPUS5vLbPK0wlZnkSJZInvt4aVMsOrCWXLH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgCJRhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:37:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50767 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:37:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id a5so2382547wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jugY1Nf3CufQZkDFT05apdS40zYN+FeXe0bfIW9g3ro=;
        b=kvy2ho9JbdRRAA5QWQBLCOSA6uLYrXtkTRgOL2rGqnBNG4Iww0ew5bIzfW6gBw69G5
         CmyHneK5eET5U9w9Vrwwbulsx+7gaRle3fVkLjyQ8DZGfVxSq+UDIOs4PaGz8nCQDswb
         oiCoUb6uz9d1tFVBQkSojcCN8vIQ6sj511dXJAO6QD2Z2CQOcCgpFbdzsbr6H3LiCz7/
         Ws+TuinlQA7YccxevTaI9PTZFJ88R0MIgVw0P+iXGJ3G7qgIRVCDpZcZEju3PuZfZlie
         OOSgFD0fOvAYVrtgyiNYN6RYk6RWqZB8LRRgZel62Id/LbSNSztvxvGN5CkgjOa5RUd2
         s20w==
X-Gm-Message-State: ANhLgQ3NLcHIGR1lmFGgdh8HD9+Ldgc7XFw7eRqHr0/zAQxgI6WpLsM2
        c9fF8lzhQG3by99XdJS0KSw=
X-Google-Smtp-Source: ADFU+vvZ2CQS4ziwKXm0n/KU6Q4DJKoDwZEqBReNJdls11/tAY8wRDLKYKcwxqmow79W57+WuhldhQ==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr3129868wmc.18.1583861861293;
        Tue, 10 Mar 2020 10:37:41 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id q1sm25472778wrx.19.2020.03.10.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:37:40 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:37:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310173738.GW8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310084544.GY8447@dhcp22.suse.cz>
 <20200310172559.GA85000@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310172559.GA85000@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 10:25:59, Roman Gushchin wrote:
> Hello, Michal!
> 
> On Tue, Mar 10, 2020 at 09:45:44AM +0100, Michal Hocko wrote:
[...]
> > > +	for_each_node_state(nid, N_ONLINE) {
> > > +		unsigned long min_pfn = 0, max_pfn = 0;
> > > +
> > > +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> > > +			if (!min_pfn)
> > > +				min_pfn = start_pfn;
> > > +			max_pfn = end_pfn;
> > > +		}
> > 
> > Do you want to compare the range to the size?
> 
> You mean add a check that the range is big enough?

Yes, size and forgot to mention alignment.

> > But besides that, I
> > believe this really needs to be much more careful. I believe you do not
> > want to eat a considerable part of the kernel memory because the
> > resulting configuration will really struggle (yeah all the low mem/high
> > mem problems all over again).
> 
> Well, so far I was focused on a particular case when the target cma size
> is significantly smaller than the total RAM size (~5-10%). What is the right
> thing to do here? Fallback to the current behavior if the requested size is
> more than x% of total memory? 1/2? How do you think?

I would start by excluding restricted kernel zones (<ZONE_NORMAL).
Cutting off 1G of ZONE_DMA32 might be a real problem.
 
> We've discussed it with Rik in private, and he expressed an idea to start
> with ~50% always and then shrink it on-demand. Something that we might
> have here long-term.

I would start simple. Simply make it a documented behavior. And if
somebody really cares enough then we can make something more clever.
Until then just avoid zone as mentioned above. This would require that
you do few changes 1) allow fallback from CMA allocation failure 2) do
not bail out initialization on CMA reservation failure.
-- 
Michal Hocko
SUSE Labs

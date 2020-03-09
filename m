Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D450FC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5FC2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583756811;
	bh=WEXMUfu9aj8Ir8p0D8RZawdUyMB/1qzEb6TvNUKMDUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZMbqPF1eSQlq8lA9+QxD8mGcdBXb2hoMJZ3q8fvIu1UIioZTds4gxsiv6Zk0TkWNA
	 RbaUfwFB6R5dUSwye3kxUb/OPX5IunzBG3ghOy55j+DZqzBmqym35kCnWqd6UE0iqg
	 CVursCjSI8+Nm2t/L4kG0raL9g2oPXGnxWh0Dnrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgCIM0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:26:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35256 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCIM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:26:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so10862976wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKhaaNVti6SfxxTFgbT+erOBA/XhG2I7RA0RYVnVfIc=;
        b=O3XdM7V+tdNE592FuxuXbfJVEwbu4BBv4vFNFQyrBBvpPIl+7JBL2pp7C4Lqu12PgR
         Pi5PKYrfpD0i8dhWsXMoN9nD9iC/nTsl3GoWyN1hJWx2+1sT5JW8wyOItyAHbv7buXWg
         IHtHNaEHiR4JLYJkBjiuAkXR/HJPrZKCxjmC4DHgipnPKsBQnySqSVJX4IYYUtcLi/HX
         Zp50NY+vT0eiTIVCL8wDYK7o4CF3vzRk4tV1k34FdqhoPcXE7Jnj4XpQNiXaTYGslQ2M
         1w+hTjOE7o2ImFJ5Lqg7H8wAaiABhn5lXTyEd+m58RUynT6DCJ3YtneunJMDqQrSUMCN
         00ow==
X-Gm-Message-State: ANhLgQ0s+rvp4pjwgz/qL9XNmjqZfd/+AbTScDCkVM6KSf/vlULsJ413
        iu8jRbIIdWC4B04Uj+RgFMU=
X-Google-Smtp-Source: ADFU+vtPwmhVB9+ErnryVhj01l+eUA6nQE5i1+BIr2Uuo9ns096ZP99v5nPot69toVGyNrdmnPm+8A==
X-Received: by 2002:adf:ed06:: with SMTP id a6mr7689322wro.346.1583756808305;
        Mon, 09 Mar 2020 05:26:48 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t193sm597696wmt.14.2020.03.09.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 05:26:47 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:26:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200309122646.GM8447@dhcp22.suse.cz>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309113658.bctbw35e73ahhgbu@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309113658.bctbw35e73ahhgbu@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-03-20 14:36:58, Kirill A. Shutemov wrote:
> On Mon, Mar 09, 2020 at 10:06:30AM +0100, Michal Hocko wrote:
> > On Mon 09-03-20 03:08:20, Kirill A. Shutemov wrote:
> > > On Fri, Mar 06, 2020 at 05:03:53PM -0800, Cannon Matthews wrote:
> > > > Reimplement clear_gigantic_page() to clear gigabytes pages using the
> > > > non-temporal streaming store instructions that bypass the cache
> > > > (movnti), since an entire 1GiB region will not fit in the cache anyway.
> > > > 
> > > > Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
> > > > average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
> > > > and optimizing the control flow over the constituent small pages, this
> > > > can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
> > > > taking only 34 seconds on average, or 67ms/GiB.
> > > > 
> > > > The assembly code for the __clear_page_nt routine is more or less
> > > > taken directly from the output of gcc with -O3 for this function with
> > > > some tweaks to support arbitrary sizes and moving memory barriers:
> > > > 
> > > > void clear_page_nt_64i (void *page)
> > > > {
> > > >   for (int i = 0; i < GiB /sizeof(long long int); ++i)
> > > >     {
> > > >       _mm_stream_si64 (((long long int*)page) + i, 0);
> > > >     }
> > > >   sfence();
> > > > }
> > > > 
> > > > Tested:
> > > > 	Time to `mlock()` a 512GiB region on broadwell CPU
> > > > 				AVG time (s)	% imp.	ms/page
> > > > 	clear_page_erms		133.584		-	261
> > > > 	clear_page_nt		34.154		74.43%	67
> > > 
> > > Some macrobenchmark would be great too.
> > > 
> > > > An earlier version of this code was sent as an RFC patch ~July 2018
> > > > https://patchwork.kernel.org/patch/10543193/ but never merged.
> > > 
> > > Andi and I tried to use MOVNTI for large/gigantic page clearing back in
> > > 2012[1]. Maybe it can be useful.
> > > 
> > > That patchset is somewhat more complex trying to keep the memory around
> > > the fault address hot in cache. In theory it should help to reduce latency
> > > on the first access to the memory.
> > > 
> > > I was not able to get convincing numbers back then for the hardware of the
> > > time. Maybe it's better now.
> > > 
> > > https://lore.kernel.org/r/1345470757-12005-1-git-send-email-kirill.shutemov@linux.intel.com
> > 
> > Thanks for the reminder. I've had only a very vague recollection. Your
> > series had a much wider scope indeed. Since then we have gained
> > process_huge_page which tries to optimize normal huge pages.
> > 
> > Gigantic huge pages are a bit different. They are much less dynamic from
> > the usage POV in my experience. Micro-optimizations for the first access
> > tends to not matter at all as it is usually pre-allocation scenario.
> 
> The page got cleared not on reservation, but on allocation, including page
> fault time. Keeping the page around the fault address can still be
> beneficial.

You are right of course. What I meant to say that GB pages backed
workloads I have seen tend to pre-allocate during the startup so they do
not realy on lazy initialization duing #PF. This is slightly easier to
handle for resource that is essentially impossible to get on-demand so
an early failure is easier to handle.

If there are workloads which can benefit from page fault
microptimizations then all good but this can be done on top and
demonstrate by numbers. It is much more easier to demonstrate the speed
up on pre-initialization workloads. That's all I wanted to say here.
-- 
Michal Hocko
SUSE Labs

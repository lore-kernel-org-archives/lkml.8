Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4762CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158B2206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIDHmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:42:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgIDHmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:42:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBDB1ABC1;
        Fri,  4 Sep 2020 07:42:09 +0000 (UTC)
Date:   Fri, 4 Sep 2020 09:42:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200904074207.GC15277@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-09-20 09:25:27, Roman Gushchin wrote:
> On Thu, Sep 03, 2020 at 09:32:54AM +0200, Michal Hocko wrote:
> > On Wed 02-09-20 14:06:12, Zi Yan wrote:
> > > From: Zi Yan <ziy@nvidia.com>
> > > 
> > > Hi all,
> > > 
> > > This patchset adds support for 1GB THP on x86_64. It is on top of
> > > v5.9-rc2-mmots-2020-08-25-21-13.
> > > 
> > > 1GB THP is more flexible for reducing translation overhead and increasing the
> > > performance of applications with large memory footprint without application
> > > changes compared to hugetlb.
> > 
> > Please be more specific about usecases. This better have some strong
> > ones because THP code is complex enough already to add on top solely
> > based on a generic TLB pressure easing.
> 
> Hello, Michal!
> 
> We at Facebook are using 1 GB hugetlbfs pages and are getting noticeable
> performance wins on some workloads.

Let me clarify. I am not questioning 1GB (or large) pages in general. I
believe it is quite clear that there are usecases which hugely benefit
from them.  I am mostly asking for the transparent part of it which
traditionally means that userspace mostly doesn't have to care and get
them. 2MB THPs have established certain expectations mostly a really    
aggressive pro-active instanciation. This has bitten us many times and
create a "you need to disable THP to fix your problem whatever that is"
cargo cult. I hope we do not want to repeat that mistake here again.

> Historically we allocated gigantic pages at the boot time, but recently moved
> to cma-based dynamic approach. Still, hugetlbfs interface requires more management
> than we would like to do. 1 GB THP seems to be a better alternative. So I definitely
> see it as a very useful feature.
> 
> Given the cost of an allocation, I'm slightly skeptical about an automatic
> heuristics-based approach, but if an application can explicitly mark target areas
> with madvise(), I don't see why it wouldn't work.

An explicit opt-in sounds much more appropriate to me as well. If we go
with a specific API then I would not make it 1GB pages specific. Why
cannot we have an explicit interface to "defragment" address space
range into large pages and the kernel would use large pages where
appropriate? Or is the additional copying prohibitively expensive?
-- 
Michal Hocko
SUSE Labs

Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F6F21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIIHPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:15:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:37262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIHPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:15:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4B847B661;
        Wed,  9 Sep 2020 07:15:19 +0000 (UTC)
Date:   Wed, 9 Sep 2020 09:15:17 +0200
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
Message-ID: <20200909071517.GB7348@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200904074207.GC15277@dhcp22.suse.cz>
 <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
 <20200907072014.GD30144@dhcp22.suse.cz>
 <3CDAD67E-23A1-4D84-BF19-FFE1CF956779@nvidia.com>
 <20200908195859.GC567128@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908195859.GC567128@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-09-20 12:58:59, Roman Gushchin wrote:
> On Tue, Sep 08, 2020 at 11:09:25AM -0400, Zi Yan wrote:
> > On 7 Sep 2020, at 3:20, Michal Hocko wrote:
> > 
> > > On Fri 04-09-20 14:10:45, Roman Gushchin wrote:
> > >> On Fri, Sep 04, 2020 at 09:42:07AM +0200, Michal Hocko wrote:
> > > [...]
> > >>> An explicit opt-in sounds much more appropriate to me as well. If we go
> > >>> with a specific API then I would not make it 1GB pages specific. Why
> > >>> cannot we have an explicit interface to "defragment" address space
> > >>> range into large pages and the kernel would use large pages where
> > >>> appropriate? Or is the additional copying prohibitively expensive?
> > >>
> > >> Can you, please, elaborate a bit more here? It seems like madvise(MADV_HUGEPAGE)
> > >> provides something similar to what you're describing, but there are lot
> > >> of details here, so I'm probably missing something.
> > >
> > > MADV_HUGEPAGE is controlling a preference for THP to be used for a
> > > particular address range. So it looks similar but the historical
> > > behavior is to control page faults as well and the behavior depends on
> > > the global setup.
> > >
> > > I've had in mind something much simpler. Effectively an API to invoke
> > > khugepaged (like) functionality synchronously from the calling context
> > > on the specific address range. It could be more aggressive than the
> > > regular khugepaged and create even 1G pages (or as large THPs as page
> > > tables can handle on the particular arch for that matter).
> > >
> > > As this would be an explicit call we do not have to be worried about
> > > the resulting latency because it would be an explicit call by the
> > > userspace.  The default khugepaged has a harder position there because
> > > has no understanding of the target address space and cannot make any
> > > cost/benefit evaluation so it has to be more conservative.
> > 
> > Something like MADV_HUGEPAGE_SYNC? It would be useful, since users have
> > better and clearer control of getting huge pages from the kernel and
> > know when they will pay the cost of getting the huge pages.

The name is not really that important. The crucial design decisions are
- THP allocation time - #PF and/or madvise context
- lazy/sync instantiation
- huge page sizes controllable by the userspace?
- aggressiveness - how hard to try
- internal fragmentation - allow to create THPs on sparsely or unpopulated
  ranges
- do we need some sort of access control or privilege check as some THPs
  would be a really scarce (like those that require pre-reservation).

> > I would think the suggestion is more about the huge page control options
> > currently provided by the kernel do not have predictable performance
> > outcome, since MADV_HUGEPAGE is a best-effort option and does not tell
> > users whether the marked virtual address range is backed by huge pages
> > or not when the madvise returns. MADV_HUGEPAGE_SYNC would provide a
> > deterministic result to users on whether the huge page(s) are formed
> > or not.
> 
> Yeah, I agree with Michal here, we need a more straightforward interface.
> 
> The hard question here is how hard the kernel should try to allocate
> a gigantic page and how fast it should give up and return an error?
> I'd say to try really hard if there are some chances to succeed,
> so that if an error is returned, there are no more reasons to retry.
> Any objections/better ideas here?

If this is going to be an explicit interface like madvise then I would
follow the same semantic as hugetlb pages allocation - aka try as hard
as feasible (whatever that means).

> Given that we need to pass a page size, we probably need either to introduce
> a new syscall (madvise2?) with an additional argument, or add a bunch
> of new madvise flags, like MADV_HUGEPAGE_SYNC + encoded 2MB, 1GB etc.

Do we really need to bother userspace with making decision about the
page size? I would expect that the userspace only cares to get huge
pages backed memory range. The larger the pages the better. It is up to
the kernel to make the resource control here. Afterall THPs can be
split/reclaimed under a memory pressure so we do not want to make any
promises about pages backing any mapping.
-- 
Michal Hocko
SUSE Labs

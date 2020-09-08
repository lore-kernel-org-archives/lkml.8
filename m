Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E71FC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115C82076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgIHTRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:17:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbgIHQDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 779DCB6AC;
        Tue,  8 Sep 2020 14:35:06 +0000 (UTC)
Date:   Tue, 8 Sep 2020 16:35:03 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200908143503.GE26850@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-09-20 10:05:11, Zi Yan wrote:
> On 8 Sep 2020, at 7:57, David Hildenbrand wrote:
> 
> > On 03.09.20 18:30, Roman Gushchin wrote:
> >> On Thu, Sep 03, 2020 at 05:23:00PM +0300, Kirill A. Shutemov wrote:
> >>> On Wed, Sep 02, 2020 at 02:06:12PM -0400, Zi Yan wrote:
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> Hi all,
> >>>>
> >>>> This patchset adds support for 1GB THP on x86_64. It is on top of
> >>>> v5.9-rc2-mmots-2020-08-25-21-13.
> >>>>
> >>>> 1GB THP is more flexible for reducing translation overhead and increasing the
> >>>> performance of applications with large memory footprint without application
> >>>> changes compared to hugetlb.
> >>>
> >>> This statement needs a lot of justification. I don't see 1GB THP as viable
> >>> for any workload. Opportunistic 1GB allocation is very questionable
> >>> strategy.
> >>
> >> Hello, Kirill!
> >>
> >> I share your skepticism about opportunistic 1 GB allocations, however it might be useful
> >> if backed by an madvise() annotations from userspace application. In this case,
> >> 1 GB THPs might be an alternative to 1 GB hugetlbfs pages, but with a more convenient
> >> interface.
> >
> > I have concerns if we would silently use 1~GB THPs in most scenarios
> > where be would have used 2~MB THP. I'd appreciate a trigger to
> > explicitly enable that - MADV_HUGEPAGE is not sufficient because some
> > applications relying on that assume that the THP size will be 2~MB
> > (especially, if you want sparse, large VMAs).
> 
> This patchset is not intended to silently use 1GB THP in place of 2MB THP.
> First of all, there is a knob /sys/kernel/mm/transparent_hugepage/enable_1GB
> to enable 1GB THP explicitly. Also, 1GB THP is allocated from a reserved CMA
> region (although I had alloc_contig_pages as a fallback, which can be removed
> in next version), so users need to add hugepage_cma=nG kernel parameter to
> enable 1GB THP allocation. If a finer control is necessary, we can add
> a new MADV_HUGEPAGE_1GB for 1GB THP.

A global knob is insufficient. 1G pages will become a very precious
resource as it requires a pre-allocation (reservation). So it really has
to be an opt-in and the question is whether there is also some sort of
access control needed.

-- 
Michal Hocko
SUSE Labs

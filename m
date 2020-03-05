Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7F1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8904B208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCEKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:49:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEKtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:49:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE45BB1FF;
        Thu,  5 Mar 2020 10:49:05 +0000 (UTC)
Date:   Thu, 5 Mar 2020 10:48:59 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200305104859.GG3772@suse.de>
References: <20200228094954.GB3772@suse.de>
 <87h7z76lwf.fsf@yhuang-dev.intel.com>
 <20200302151607.GC3772@suse.de>
 <87zhcy5hoj.fsf@yhuang-dev.intel.com>
 <20200303080945.GX4380@dhcp22.suse.cz>
 <87o8td4yf9.fsf@yhuang-dev.intel.com>
 <20200303085805.GB4380@dhcp22.suse.cz>
 <87ftep4pzy.fsf@yhuang-dev.intel.com>
 <20200304095802.GE16139@dhcp22.suse.cz>
 <87blpc2wxj.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87blpc2wxj.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:15:20PM +0800, Huang, Ying wrote:
> In which situation the cost to reconstruct MADV_FREE pages can be higher
> than the cost to allocate file cache page and read from disk?  Heavy
> contention on mmap_sem?
> 

MADV_FREE should be anonymous only

if (behavior == MADV_FREE)
                return madvise_free_single_vma(vma, start, end);

.....

static int madvise_free_single_vma(struct vm_area_struct *vma,
                        unsigned long start_addr, unsigned long end_addr)
{
        struct mm_struct *mm = vma->vm_mm;
        struct mmu_notifier_range range;
        struct mmu_gather tlb;

        /* MADV_FREE works for only anon vma at the moment */
        if (!vma_is_anonymous(vma))
                return -EINVAL

So the question is not applicable. For anonymous memory, the cost of
updating a PTE is lower than allocating a page, zeroing it and updating
the PTE.

It has been repeatedly stated now for almost a week that a semantic
change to MADV_FREE should be based on a problem encountered by a real
application that can benefit from the new semantics. I think the only
concrete outcome has been that userspace potentially benefits if the total
number of MADV_FREE pages is reported globally. Even that is marginal as
smaps has the information to tell the difference between high RSS due to
a memory leak and high RSS usage due to MADV_FREE. The /proc/vmstats for
MADV_FREE are of marginal benefit given that they do not tell us much
about the current number of MADV_FREE pages in the system.

-- 
Mel Gorman
SUSE Labs

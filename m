Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2821BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8E823119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgHFQpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:45:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbgHFQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE658B60B;
        Thu,  6 Aug 2020 15:53:28 +0000 (UTC)
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        cai@lca.pw, kirill@shutemov.name, rppt@linux.ibm.com,
        william.kucharski@oracle.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <ac97deea-4638-badd-9495-c9ca313837bb@suse.cz>
 <20200806134851.GN23808@casper.infradead.org>
 <790ae9a4-6874-ac34-d2a2-28a2137335cb@suse.cz>
 <20200806153938.GO23808@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <da00f435-a867-0108-8855-872019d85d44@suse.cz>
Date:   Thu, 6 Aug 2020 17:53:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806153938.GO23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 5:39 PM, Matthew Wilcox wrote:
>> >> +++ b/mm/huge_memory.c
>> >> @@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>> >>  	 * Set PG_double_map before dropping compound_mapcount to avoid
>> >>  	 * false-negative page_mapped().
>> >>  	 */
>> >> -	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
>> >> +	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
>> > 
>> > I'm a little nervous about this one.  The page does actually come from
>> > pmd_page(), and today that's guaranteed to be a head page.  But I'm
>> > not convinced that's going to still be true in twenty years.  With the
>> > current THP patchset, I won't allocate pages larger than PMD order, but
>> > I can see there being interest in tracking pages in chunks larger than
>> > 2MB in the future.  And then pmd_page() might well return a tail page.
>> > So it might be a good idea to not convert this one.
>> 
>> Hmm the function converts the compound mapcount of the whole page to a
>> HPAGE_PMD_NR of base pages. If suddenly the compound page was bigger than a pmd,
>> then I guess this wouldn't work properly anymore without changes anyway?
>> Maybe we could stick something like VM_BUG_ON(PageTransHuge(page)) there as
>> "enforced documentation" for now?
> 
> I think it would work as-is.  But also I may have totally misunderstood it.
> I'll write this declaratively and specifically for x86 (PMD order is 9)
> ... tell me when I've made a mistake ;-)
> 
> This function is for splitting the PMD.  We're leaving the underlying
> page intact and just changing the page table.  So if, say, we have an
> underlying 4MB page (and maybe the pages are mapped as PMDs in this
> process), we might get subpage number 512 of this order-10 page.  We'd
> need to check the DoubleMap bit on subpage 1, and the compound_mapcount
> also stored in page 1, but we'd only want to spread the mapcount out
> over the 512 subpages from 512-1023; we wouldn't want to spread it out
> over 0-511 because they aren't affected by this particular PMD.

Yeah, and then we decrease the compound mapcount, which is a counter of "how
many times is this compound page mapped as a whole". But we only removed (the
second) half of the compound mapping, so imho that would be wrong?

> Having to reason about stuff like this is why I limited the THP code to
> stop at PMD order ... I don't want to make my life even more complicated
> than I have to!

Kirill might correct me but I'd expect the THP code right now has baked in many
assumptions about THP pages being exactly HPAGE_PMD_ORDER large?


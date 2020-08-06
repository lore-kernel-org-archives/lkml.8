Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84308C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91642086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgHFQyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:54:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:32940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbgHFQxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:53:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36FEEADE1;
        Thu,  6 Aug 2020 15:13:22 +0000 (UTC)
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <790ae9a4-6874-ac34-d2a2-28a2137335cb@suse.cz>
Date:   Thu, 6 Aug 2020 17:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806134851.GN23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/20 3:48 PM, Matthew Wilcox wrote:
> On Thu, Aug 06, 2020 at 01:45:11PM +0200, Vlastimil Babka wrote:
>> How about this additional patch now that we have head_mapcoun()? (I wouldn't
>> go for squashing as the goal and scope is too different).
> 
> I like it.  It bothers me that the compiler doesn't know that
> compound_head(compound_head(x)) == compound_head(x).  I updated
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=32911 with a request to be
> able to tell the compiler that compound_head() is idempotent.

Yeah it would be nice to get the benefits everywhere automatically. But I guess
the compiler would have to discard the idempotence assumptions if there are
multiple consecutive (perhaps hidden behind page flag access)
compound_head(page) from a function, as soon as we modify the struct page somewhere.

>> The bloat-o-meter difference without DEBUG_VM is the following:
>> 
>> add/remove: 0/0 grow/shrink: 1/4 up/down: 32/-56 (-24)
>> Function                                     old     new   delta
>> __split_huge_pmd                            2867    2899     +32
>> shrink_page_list                            3860    3847     -13
>> reuse_swap_page                              762     748     -14
>> page_trans_huge_mapcount                     153     139     -14
>> total_mapcount                               187     172     -15
>> Total: Before=8687306, After=8687282, chg -0.00%
> 
> That's great.  I'm expecting improvements from my thp_head() macro when
> that lands (currently in Andrew's tree).  I have been reluctant to replace
> current callers of compound_head() with thp_head(), but I suspect PF_HEAD
> could use thp_head() and save a few bytes on a tinyconfig build.
> 
>> +++ b/mm/huge_memory.c
>> @@ -2125,7 +2125,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>  	 * Set PG_double_map before dropping compound_mapcount to avoid
>>  	 * false-negative page_mapped().
>>  	 */
>> -	if (compound_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
>> +	if (head_mapcount(page) > 1 && !TestSetPageDoubleMap(page)) {
> 
> I'm a little nervous about this one.  The page does actually come from
> pmd_page(), and today that's guaranteed to be a head page.  But I'm
> not convinced that's going to still be true in twenty years.  With the
> current THP patchset, I won't allocate pages larger than PMD order, but
> I can see there being interest in tracking pages in chunks larger than
> 2MB in the future.  And then pmd_page() might well return a tail page.
> So it might be a good idea to not convert this one.

Hmm the function converts the compound mapcount of the whole page to a
HPAGE_PMD_NR of base pages. If suddenly the compound page was bigger than a pmd,
then I guess this wouldn't work properly anymore without changes anyway?
Maybe we could stick something like VM_BUG_ON(PageTransHuge(page)) there as
"enforced documentation" for now?

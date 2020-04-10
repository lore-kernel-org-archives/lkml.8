Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D30C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3722078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YR5eyfo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDJU7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:59:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11642 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgDJU7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:59:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e90ddc30000>; Fri, 10 Apr 2020 13:57:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 13:59:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Apr 2020 13:59:24 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 20:59:24 +0000
Received: from [10.2.58.92] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 20:59:23 +0000
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Zi Yan" <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
 <5a57635b-ed75-8f09-6f0c-5623f557fc55@nvidia.com>
 <20200410155543.i66uz6pbynfvkhak@box>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <df772934-b5e5-8578-9b47-3f17bf9b8896@nvidia.com>
Date:   Fri, 10 Apr 2020 13:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410155543.i66uz6pbynfvkhak@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586552259; bh=dHoA1k9mKwqUEJvIqE8t2lTAlLxHEnsPs/2JvY1QEfA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YR5eyfo8yuM8+eBqGSdQf/vGo9aFZN/X4/sU2R8SNHDn8Xr/EWvcCAu+v1As6IdPB
         VUGphyaMMVjhV/TztbSJQQzR8922URTiUq8ik1oisCOpzFTpNGDeUd1PQTP6+7bwhE
         /dOquuMHWHiPzrhf008TSdtaYvD24OFiWHNckLTfv9SWL/k4Q6et1GmXpMA9UZOztu
         ioQwEklmD7N8e4Q6MV4Cbe6D1WTmLXNQQ0DMPEVNcJqSGnY9CYV8/fZQbSfRWFMQMV
         W9O/Q56JGFlRYJn+DpdHCsBVVFAIYWTPTP2RpA+2nlW2DE3yApWYdEfpEOUd8n9AXB
         D3n0aCxXrfdwg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/20 8:55 AM, Kirill A. Shutemov wrote:
...
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 57ff287caf6b..1e7e6543ebca 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -581,11 +581,18 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>    		}
>>>    		/*
>>> -		 * cannot use mapcount: can't collapse if there's a gup pin.
>>> -		 * The page must only be referenced by the scanned process
>>> -		 * and page swap cache.
>>> +		 * Check if the page has any GUP (or other external) pins.
>>> +		 *
>>> +		 * The page table that maps the page has been already unlinked
>>> +		 * from the page table tree and this process cannot get
>>> +		 * additinal pin on the page.
>>
>>
>> I'd recommend this wording instead, for the last two lines:
>>
>> 		 * from the page table tree. Therefore, this page will not
>> 		 * normally receive any additional pins.
> 
> I guess I'm not clear enough.
> 
> The point is that the page cannot get any new pins from this process. It
> can get new pin from other process after the check. But it is fine because
> if the page is mapped multiple times it has to be write-protected (CoW
> after fork()) and we can rely that page's content will not change under
> us.
> 
> Does it make sense? Wording suggestions are welcome.


I think I understood what you were saying. The problem is that was ignoring
a couple of points, especially in an RDMA situation: 1) the page can be
pinned by various drivers, on behalf of other processes, even if the original
process is being torn down, and 2) it doesn't really matter which process pins
a page--the end result is that it's pinned.

So that's why I changed the comment to be much milder: "this page will not
normally receive any additional pins". "Normally" means "in a non-RDMA
setup, for example".

Or am I missing some other point here?

> 
>>> +		 *
>>> +		 * New pins can come later if the page is shared across fork,
>>> +		 * but not for the this process. It is fine. The other process
>>> +		 * cannot write to the page, only trigger CoW.
>>>    		 */
>>> -		if (page_count(page) != 1 + PageSwapCache(page)) {
>>> +		if (total_mapcount(page) + PageSwapCache(page) !=
>>> +				page_count(page)) {
>>
>>
>> I think it's time to put that logic ( "does this page have any extra references")
>> into a small function. It's already duplicated once below. And the documentation is
>> duplicated as well.
> 
> Fair enough.
> 
> But comments have to stay where they are. Because the context is
> different. The first time we check speculatively, before the page table is
> unlinked from the page table tree and this check is inherintly racy.
> Unlike the second one.


Right. Let's take another look at them after you point out to me why my response above
is all wrong... :)

> 
>> I took a quick peek at this patch because, after adding pin_user_pages*() APIs earlier
>> to complement get_user_pages*(), I had a moment of doubt here: what if I'd done  it in
>> a way that required additional logic here? Fortunately, that's not the case: all
>> pin_user_pages() calls on huge pages take a "primary/real" refcount, in addition
>> to scribbling into the compound_pincount_ptr() area. whew. :)
>>
>>
>>
>>>    			unlock_page(page);
>>>    			result = SCAN_PAGE_COUNT;
>>>    			goto out;
>>> @@ -672,7 +679,6 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>>>    		} else {
>>>    			src_page = pte_page(pteval);
>>>    			copy_user_highpage(page, src_page, address, vma);
>>> -			VM_BUG_ON_PAGE(page_mapcount(src_page) != 1, src_page);
>>>    			release_pte_page(src_page);
>>>    			/*
>>>    			 * ptl mostly unnecessary, but preempt has to
>>> @@ -1206,12 +1212,9 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
>>>    			goto out_unmap;
>>>    		}
>>> -		/*
>>> -		 * cannot use mapcount: can't collapse if there's a gup pin.
>>> -		 * The page must only be referenced by the scanned process
>>> -		 * and page swap cache.
>>> -		 */
>>> -		if (page_count(page) != 1 + PageSwapCache(page)) {
>>> +		/* Check if the page has any GUP (or other external) pins */
>>> +		if (total_mapcount(page) + PageSwapCache(page) !=
>>> +				page_count(page)) {>   			result = SCAN_PAGE_COUNT;
>>>    			goto out_unmap;
>>>    		}
>>>

thanks,
-- 
John Hubbard
NVIDIA

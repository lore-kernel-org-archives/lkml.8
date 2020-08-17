Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA49C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77082087D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgHQDEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:04:33 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50029 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbgHQDE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:04:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5wd.eG_1597633465;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5wd.eG_1597633465)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 11:04:26 +0800
Date:   Mon, 17 Aug 2020 11:04:25 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200817030425.GA25240@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
 <20200811065406.GC4793@dhcp22.suse.cz>
 <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
 <20200813114638.GJ9477@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813114638.GJ9477@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 01:46:38PM +0200, Michal Hocko wrote:
>On Tue 11-08-20 14:43:28, Mike Kravetz wrote:
>> On 8/10/20 11:54 PM, Michal Hocko wrote:
>> > 
>> > I have managed to forgot all the juicy details since I have made that
>> > change. All that remains is that the surplus pages accounting was quite
>> > tricky and back then I didn't figure out a simpler method that would
>> > achieve the consistent look at those counters. As mentioned above I
>> > suspect this could lead to pre-mature allocation failures while the
>> > migration is ongoing.
>> 
>> It is likely lost in the e-mail thread, but the suggested change was to
>> alloc_surplus_huge_page().  The code which allocates the migration target
>> (alloc_migrate_huge_page) will not be changed.  So, this should not be
>> an issue.
>
>OK, I've missed that obviously.
>
>> >                       Sure quite unlikely to happen and the race window
>> > is likely very small. Maybe this is even acceptable but I would strongly
>> > recommend to have all this thinking documented in the changelog.
>> 
>> I wrote down a description of what happens in the two different approaches
>> "temporary page" vs "surplus page".  It is at the very end of this e-mail.
>> When looking at the details, I came up with what may be an even better
>> approach.  Why not just call the low level routine to free the page instead
>> of going through put_page/free_huge_page?  At the very least, it saves a
>> lock roundtrip and there is no need to worry about the counters/accounting.
>> 
>> Here is a patch to do that.  However, we are optimizing a return path in
>> a race condition that we are unlikely to ever hit.  I 'tested' it by allocating
>> an 'extra' page and freeing it via this method in alloc_surplus_huge_page.
>> 
>> >From 864c5f8ef4900c95ca3f6f2363a85f3cb25e793e Mon Sep 17 00:00:00 2001
>> From: Mike Kravetz <mike.kravetz@oracle.com>
>> Date: Tue, 11 Aug 2020 12:45:41 -0700
>> Subject: [PATCH] hugetlb: optimize race error return in
>>  alloc_surplus_huge_page
>> 
>> The routine alloc_surplus_huge_page() could race with with a pool
>> size change.  If this happens, the allocated page may not be needed.
>> To free the page, the current code will 'Abuse temporary page to
>> workaround the nasty free_huge_page codeflow'.  Instead, directly
>> call the low level routine that free_huge_page uses.  This works
>> out well because the page is new, we hold the only reference and
>> already hold the hugetlb_lock.
>> 
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 590111ea6975..ac89b91fba86 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1923,14 +1923,17 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>>  	/*
>>  	 * We could have raced with the pool size change.
>>  	 * Double check that and simply deallocate the new page
>> -	 * if we would end up overcommiting the surpluses. Abuse
>> -	 * temporary page to workaround the nasty free_huge_page
>> -	 * codeflow
>> +	 * if we would end up overcommiting the surpluses.
>>  	 */
>>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>> -		SetPageHugeTemporary(page);
>> +		/*
>> +		 * Since this page is new, we hold the only reference, and
>> +		 * we already hold the hugetlb_lock call the low level free
>> +		 * page routine.  This saves at least a lock roundtrip.
>> +		 */
>> +		(void)put_page_testzero(page); /* don't call destructor */
>> +		update_and_free_page(h, page);
>>  		spin_unlock(&hugetlb_lock);
>> -		put_page(page);
>>  		return NULL;
>>  	} else {
>>  		h->surplus_huge_pages++;
>
>Yes this makes sense. I would have to think about this more to be
>confident and give Acked-by but this looks sensible from a quick glance.
>

If it is ok, I would like to send v2 without this one to give more time
for a discussion?

>Thanks!
>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me

Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F59C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2DFC20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TFHqF71W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgFVJk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:40:28 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:61328 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgFVJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:40:27 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200622094025epoutp02eb66776922f48da7e66f603b8dd4c819~a1EhJI8T82050720507epoutp026
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:40:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200622094025epoutp02eb66776922f48da7e66f603b8dd4c819~a1EhJI8T82050720507epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1592818825;
        bh=A4AGWMlm9l2I2qTabktmMDMUD/HXo3xMtnah4m8F9aA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=TFHqF71WUHlub2b9x7GEKWFGkkv7H+GmmkBs9BqYv7CTtzeaOTSShJMJcecJPcAxw
         iyaWFYnYGpUOu3TWMmmjPWrlfl4FvIHKo9JHkpOVcy1lBRgFuPEzjy0EKr69R5izE3
         i0/ElepOa+T6shM+hkRmQ9ynwdbaSF1Uh5mPlxN0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200622094022epcas1p23dd4cd3675ad3105d9191ac34f8ba658~a1EedMFtj0317703177epcas1p2p;
        Mon, 22 Jun 2020 09:40:22 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 49r4C85WkTzMqYkV; Mon, 22 Jun
        2020 09:40:20 +0000 (GMT)
X-AuditID: b6c32a36-16fff70000004a59-3a-5ef07c84fc8b
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.07.19033.48C70FE5; Mon, 22 Jun 2020 18:40:20 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Reply-To: jaewon31.kim@samsung.com
From:   =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
To:     Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?B?6rmA7J6s7JuQ?= <jaewon31.kim@samsung.com>
CC:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        =?UTF-8?B?7J207Jqp7YOd?= <ytk.lee@samsung.com>,
        =?UTF-8?B?6rmA7LKg66+8?= <cmlaika.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20200622091107.GC31426@dhcp22.suse.cz>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734@epcms1p6>
Date:   Mon, 22 Jun 2020 18:40:20 +0900
X-CMS-MailID: 20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmnm5LzYc4g8Yz2hZz1q9hszj/4Beb
        xcp559gsVm/ytejePJPRovf9KyaLy7vmsFncW/Of1WLyu2eMFjuW7mOyeP1tGbPFsq/v2S1m
        N/YxWjxez+3A53H4zXtmj52z7rJ7bFrVyeax6dMkdo8TM36zeLzfd5XNo2/LKkaPMwuOsHts
        Pl3tsfWXncfnTXIB3FE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2
        Si4+AbpumTlAPygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCgwNCvSKE3OLS/PS
        9ZLzc60MDQyMTIEqE3IyVt14zlRwQL7i9Lf1rA2MT0S7GDk5JARMJBY1XmHsYuTiEBLYwSix
        /Mcs1i5GDg5eAUGJvzuEQWqEBYIl1n9cwgRiCwkoSZz9cYUdIm4tsX/RDLA4m4ClxPabExlB
        bBGBaIkpp9vYQWYyC5xikbjyawIbxDJeiRntT1kgbGmJ7cu3gjVwAh2xYEYjVI2oxM3Vb9lh
        7PfH5jNC2CISrffOMkPYghIPfu6GiktJXN63iQXkZgmBeokNt/NA9koINDBKdJz8wgoR15f4
        c5If4i1fiW0LK0A6WQRUJRY+mAA10UViW+9VsFeYBeQltr+dwwxSziygKbF+lz5EiaLEzt9z
        GSFK+CTefe1hhXlqx7wnTBC2mkTLs69QcRmJv/+eQR3gIbG+QR0SgOsZJRpuuExgVJiFCOZZ
        SPbOQti7gJF5FaNYakFxbnpqsWGBEXLMbmIEJ2Ytsx2Mk95+0DvEyMTBeIhRgoNZSYT3dcC7
        OCHelMTKqtSi/Pii0pzU4kOMpkAfT2SWEk3OB+aGvJJ4Q1MjY2NjCxMzczNTYyVxXjWZC3FC
        AumJJanZqakFqUUwfUwcnFINTFEaF+cvkqla5bKvYln8uxubPm56uPuIUr1p0y+GFve3Ezx/
        GDCbHTfaKfRlaUDi1l8rzNz2vz+13fhQTee2l4d2iOl/53mk2tXGde/m7n0M/OUGMzjeRt/b
        epvbXmaFdrKzcbv6xrcqVy9wXk3KnWW56rMYJ8uDOs4vfDk9YkHRs9UmpF3xPeFw7ZZrpcy+
        fqMH3sfW71x93tE7/P7SfJW7UsbLnyi+OGY0Vfz1v1axmZMfbd3nseOf/dXZt9fejbjyzcxq
        77IZ+l43PjTseb/hn9/DyBX7Jn++d317XVu59Ap7/Vsll2W261yY2rJTeLHBo/Ct/TYPXQ56
        CGc/uLXl5trDy6O6T+V+TFvV2xpyTYmlOCPRUIu5qDgRALe6C1JVBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca
References: <20200622091107.GC31426@dhcp22.suse.cz>
        <20200619235958.11283-1-jaewon31.kim@samsung.com>
        <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcms1p6>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat 20-06-20 08:59:58, Jaewon Kim wrote:
>[...]
>> @@ -3502,19 +3525,12 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>>          const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
>>  
>>          /* free_pages may go negative - that's OK */
>> -        free_pages -= (1 << order) - 1;
>> +        free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
>>  
>>          if (alloc_flags & ALLOC_HIGH)
>>                  min -= min / 2;
>>  
>> -        /*
>> -         * If the caller does not have rights to ALLOC_HARDER then subtract
>> -         * the high-atomic reserves. This will over-estimate the size of the
>> -         * atomic reserve but it avoids a search.
>> -         */
>> -        if (likely(!alloc_harder)) {
>> -                free_pages -= z->nr_reserved_highatomic;
>> -        } else {
>> +        if (unlikely(alloc_harder)) {
>>                  /*
>>                   * OOM victims can try even harder than normal ALLOC_HARDER
>>                   * users on the grounds that it's definitely going to be in
>[...]
>> @@ -3582,25 +3591,22 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
>>                                  unsigned long mark, int highest_zoneidx,
>>                                  unsigned int alloc_flags)
>>  {
>> -        long free_pages = zone_page_state(z, NR_FREE_PAGES);
>> -        long cma_pages = 0;
>> +        long free_pages;
>> +        long unusable_free;
>>  
>> -#ifdef CONFIG_CMA
>> -        /* If allocation can't use CMA areas don't use free CMA pages */
>> -        if (!(alloc_flags & ALLOC_CMA))
>> -                cma_pages = zone_page_state(z, NR_FREE_CMA_PAGES);
>> -#endif
>> +        free_pages = zone_page_state(z, NR_FREE_PAGES);
>> +        unusable_free = __zone_watermark_unusable_free(z, order, alloc_flags);
>>  
>>          /*
>>           * Fast check for order-0 only. If this fails then the reserves
>> -         * need to be calculated. There is a corner case where the check
>> -         * passes but only the high-order atomic reserve are free. If
>> -         * the caller is !atomic then it'll uselessly search the free
>> -         * list. That corner case is then slower but it is harmless.
>> +         * need to be calculated.
>>           */
>> -        if (!order && (free_pages - cma_pages) >
>> -                                mark + z->lowmem_reserve[highest_zoneidx])
>> -                return true;
>> +        if (!order) {
>> +                long fast_free = free_pages - unusable_free;
>> +
>> +                if (fast_free > mark + z->lowmem_reserve[highest_zoneidx])
>> +                        return true;
>> +        }
> 
>There is no user of unusable_free for order > 0. With you current code
>__zone_watermark_unusable_free would be called twice for high order
>allocations unless compiler tries to be clever..

Yes you're right.
Following code could be moved only for order-0.
 unusable_free = __zone_watermark_unusable_free(z, order, alloc_flags);
Let me fix it at v5.

> 
>But more importantly, I have hard time to follow why we need both
>zone_watermark_fast and zone_watermark_ok now. They should be
>essentially the same for anything but order == 0. For order 0 the
>only difference between the two is that zone_watermark_ok checks for
>ALLOC_HIGH resp ALLOC_HARDER, ALLOC_OOM. So what is exactly fast about
>the former and why do we need it these days?
> 

I think the author, Mel, may ansewr. But I think the wmark_fast may
fast by 1) not checking more condition about wmark and 2) using inline
rather than function. According to description on commit 48ee5f3696f6,
it seems to bring about 4% improvement.

>> 
>>          return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
>>                                          free_pages);
>> -- 
>> 2.17.1
>> 
> 
>-- 
>Michal Hocko
>SUSE Labs
> 

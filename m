Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AFEC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6931A246A1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJ/OAz4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgB1Eak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:30:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44984 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbgB1Eaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:30:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S4Na26161848;
        Fri, 28 Feb 2020 04:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KTD2MwGfCaijYMLxV6P9PVRsBGDO+149svqDMWIIaTc=;
 b=DJ/OAz4LOO0+kkQ6asr1Ob4qa3ggs43H1ZoNce6ufJE3t8BVK2EMv85mKz/saclWawPq
 oiLHPf56/oe+E9LkFR/DuJ4d/1zf9vZ2hN2YpS8prQGF6UQFLVUknUH2j+8UFHOruVJr
 5/9xU4FhPN+DZ6tjyxvBDJG5acMIiqHFHPlX6JRyrPx5iOnkICkFKTFkfSiPtD3UGR/1
 zvdkcNKUE5HilIzBDABg3VF9ZNCnNcV9gc9c3Bj6G5DZbl55uhtfyKT9kykzEulrTegg
 Zwx5qmg+fIDlVAv0GwpX/oOWtWhPjkczZakrfg2zv3j5anvpsWq3KVkIBL0oiWt3H/8k bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ydcsnqj7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 04:30:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S4MNUS037729;
        Fri, 28 Feb 2020 04:30:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ydcsccge9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 04:30:09 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01S4U5N6021999;
        Fri, 28 Feb 2020 04:30:05 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 20:30:05 -0800
Subject: Re: [PATCH v2 2/2] mm,thp,compaction,cma: allow THP migration for CMA
 allocations
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        mhocko@kernel.org, vbabka@suse.cz, mgorman@techsingularity.net,
        rientjes@google.com, aarcange@redhat.com, ziy@nvidia.com
References: <cover.1582321646.git.riel@surriel.com>
 <20200227213238.1298752-2-riel@surriel.com>
 <df83c62f-209f-b1fd-3a5c-c81c82cb2606@oracle.com>
 <7800e98e3688c124ac3672284b87d67321e1c29e.camel@surriel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c1b450f2-59ac-c6e0-3a99-f51bdebbe9c9@oracle.com>
Date:   Thu, 27 Feb 2020 20:30:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7800e98e3688c124ac3672284b87d67321e1c29e.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 5:21 PM, Rik van Riel wrote:
> On Thu, 2020-02-27 at 15:41 -0800, Mike Kravetz wrote:
>> On 2/27/20 1:32 PM, Rik van Riel wrote:
>>>
>>> +++ b/mm/page_alloc.c
>>> @@ -8253,14 +8253,19 @@ struct page *has_unmovable_pages(struct
>>> zone *zone, struct page *page,
>>>  
>>>  		/*
>>>  		 * Hugepages are not in LRU lists, but they're movable.
>>> +		 * THPs are on the LRU, but need to be counted as
>>> #small pages.
>>>  		 * We need not scan over tail pages because we don't
>>>  		 * handle each tail page individually in migration.
>>>  		 */
>>> -		if (PageHuge(page)) {
>>> +		if (PageHuge(page) || PageTransCompound(page)) {
>>>  			struct page *head = compound_head(page);
>>>  			unsigned int skip_pages;
>>>  
>>> -			if
>>> (!hugepage_migration_supported(page_hstate(head)))
>>> +			if (PageHuge(page) &&
>>> +			    !hugepage_migration_supported(page_hstate(h
>>> ead)))
>>> +				return page;
>>> +
>>> +			if (!PageLRU(head) && !__PageMovable(head))
>>
>> Pretty sure this is going to be true for hugetlb pages.  So, this
>> will change
>> behavior and make all hugetlb pages look unmovable.  Perhaps, only
>> check this
>> condition for THP pages?
> 
> Does that need to be the following, then?
> 
>      if (PageTransHuge(head) && !PageHuge(page) && !PageLRU(head) &&
> !__PageMovable(head))
>                  return page;

Yes, that is what I would suggest.  Results of a simple test on small VM.

Unmodified Kernel
-----------------
# cat /sys/devices/system/memory/memory*/removable | grep 1 | wc -l
50
# hugeadm --hard --pool-pages-min DEFAULT:4G
# cat /sys/devices/system/memory/memory*/removable | grep 1 | wc -l
50

V2 patches
----------
# cat /sys/devices/system/memory/memory*/removable | grep 1 | wc -l
50
# hugeadm --hard --pool-pages-min DEFAULT:4G
# cat /sys/devices/system/memory/memory*/removable | grep 1 | wc -l
14

V2 patches + above modification
-------------------------------
# cat /sys/devices/system/memory/memory*/removable | grep 1 | wc -l
50
# hugeadm --hard --pool-pages-min DEFAULT:4G
# cat /sys/devices/system/memory/memory*/removable | grep 1 | wc -l
50

> That's an easy one liner I would be happy to send in
> if everybody agrees that should fix things :)

Another option might be to make hugetlb pages more like other pages and
__SetPageMovable on movable hugetlb pages.  This could be used instead
of hugepage_migration_supported() calls.  That is only a quick thought
and would be beyond the scope of this patch.  If people think that is
worth doing, and I have not overlooked something,  I could look into it
separately.
-- 
Mike Kravetz

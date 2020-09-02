Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA3C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8341620684
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eKS/uT96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgIBR0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:26:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIBR0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:26:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082HOu3j086686;
        Wed, 2 Sep 2020 17:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=5be8iFJXOcgcgdFZzn/kuNfFoTvUiJear07v/iHmf8Y=;
 b=eKS/uT96dz8tO+/BHDz346JQjUJh8G3u8GhMtCj6zEflcIKH9R71c6Fi0l++3sxe73E7
 WgjMsuciWeljsc6Kn4czu21+C4aD+K5DdIIt5BtrozXTVUCOOVfCwXKmci8eB1VSxAlR
 PZDhrv7pu5gIMTqZMqjlSox7QWPRR9gSlmLFfkrF/cVGbmWLhwiQr+QuKnQ3yrMJmH38
 F3qvHtetXkt6iaAV+MM4dW5Cg3ruXurq6NoCYD47kUdOzCqRfSn6rCTYJTDtln3RtZjT
 zI3N//crkiX8yY6trQFpnDGif1qFRSCOI3o08kel3r9TIGoC9Dk3uATM9dCobAsjdN0c Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eer43sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 17:25:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082HPlwD089347;
        Wed, 2 Sep 2020 17:25:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 3380y03r2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 17:25:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082HPnxr000972;
        Wed, 2 Sep 2020 17:25:49 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 10:25:49 -0700
Subject: Re: [Patch v4 5/7] mm/hugetlb: a page from buddy is not on any list
To:     Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com
References: <20200901014636.29737-1-richard.weiyang@linux.alibaba.com>
 <20200901014636.29737-6-richard.weiyang@linux.alibaba.com>
 <fd89ad4a-ef8d-e54e-8769-d6b15c40cc43@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <6e9aebdf-a7a9-fb60-eadf-02088602cfdd@oracle.com>
Date:   Wed, 2 Sep 2020 10:25:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <fd89ad4a-ef8d-e54e-8769-d6b15c40cc43@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009020165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 3:49 AM, Vlastimil Babka wrote:
> On 9/1/20 3:46 AM, Wei Yang wrote:
>> The page allocated from buddy is not on any list, so just use list_add()
>> is enough.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> Reviewed-by: Baoquan He <bhe@redhat.com>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  mm/hugetlb.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 441b7f7c623e..c9b292e664c4 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2405,7 +2405,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>>  			h->resv_huge_pages--;
>>  		}
>>  		spin_lock(&hugetlb_lock);
>> -		list_move(&page->lru, &h->hugepage_activelist);
>> +		list_add(&page->lru, &h->hugepage_activelist);
> 
> Hmm, how does that list_move() actually not crash today?
> Page has been taken from free lists, thus there was list_del() and page->lru
> should be poisoned.
> list_move() does __list_del_entry() which will either detect the poison with
> CONFIG_DEBUG_LIST, or crash accessing the poison, no?
> Am I missing something or does it mean this code is actually never executed in wild?
> 

There is not enough context in the diff, but the hugetlb page was not taken
from the free list.  Rather, it was just created by a call to
alloc_buddy_huge_page_with_mpol().  As part of the allocation/creation
prep_new_huge_page will be called which will INIT_LIST_HEAD(&page->lru).

-- 
Mike Kravetz

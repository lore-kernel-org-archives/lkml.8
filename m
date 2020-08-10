Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6730C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 756DC2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wFE09kFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHJUa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:30:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59168 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHJUa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:30:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AKSNWr141825;
        Mon, 10 Aug 2020 20:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iA9Wi67iEbryFosoUJVMZupk10m8PgMdmdqGBL1LZDU=;
 b=wFE09kFYV4sDSN00655fmxzqycCU2ueUu4rucIWZctv11YzIBKn2ciVyOo1hESL+Kred
 9xfy4R1D0bCcpQQcspPrqlINYQ2ahB2eiSXiWY0IYkl9FYP1XUXTYHTlR3b9Zn3mIxww
 Cd4FfG1h+oE5b3vNOy1yZLsZRB+wtqBfzZNzmg8fr8ThiX1eLV2lxyLXlVEIgb0ZwfQQ
 v7kDAmQyxMsAi1e3XR38YTVTEFE6Fb086jOqNJrhcZV1JLIbfgGX6E0kZgmyYF3GJv63
 aABR65+VYa0cLjHWS9ouYcchf1vVYe/IPDP/+ivAA9loHTq+5MYpuaZDKZovv0oBY4MU ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32t2ydf81k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 20:30:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AKSN38022671;
        Mon, 10 Aug 2020 20:28:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32t5yxctta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 20:28:48 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07AKSlrc027925;
        Mon, 10 Aug 2020 20:28:48 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 20:28:47 +0000
Subject: Re: [PATCH 02/10] mm/hugetlb: make sure to get NULL when list is
 empty
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-3-richard.weiyang@linux.alibaba.com>
 <20200807124951.GM14854@MiWiFi-R3L-srv>
 <20200807142800.GA14692@L-31X9LVDL-1304.local>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9cf6749d-3a0a-480a-ef76-ae8cf5413a90@oracle.com>
Date:   Mon, 10 Aug 2020 13:28:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807142800.GA14692@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 7:28 AM, Wei Yang wrote:
> On Fri, Aug 07, 2020 at 08:49:51PM +0800, Baoquan He wrote:
>> On 08/07/20 at 05:12pm, Wei Yang wrote:
>>> list_first_entry() may not return NULL even when the list is empty.
>>>
>>> Let's make sure the behavior by using list_first_entry_or_null(),
>>> otherwise it would corrupt the list.
>>>
>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>> ---
>>>  mm/hugetlb.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 62ec74f6d03f..0a2f3851b828 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -237,7 +237,8 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
>>>  	VM_BUG_ON(resv->region_cache_count <= 0);
>>
>>
>> We have had above line, is it possible to be NULL from list_first_entry?
>>
>>>  
>>>  	resv->region_cache_count--;
>>> -	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
>>> +	nrg = list_first_entry_or_null(&resv->region_cache,
>>> +			struct file_region, link);
>>>  	VM_BUG_ON(!nrg);
> 
> Or we can remove this VM_BUG_ON()?
> 

I would prefer that we just remove the 'VM_BUG_ON(!nrg)'.  Code elsewhere
is responsible for making sure there is ALWAYS an entry in the cache.  That
is why the 'VM_BUG_ON(resv->region_cache_count <= 0)' is at the beginning
of the routine.

-- 
Mike Kravetz

Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F87C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8C9206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYo6R5xN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHKATV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:19:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43226 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgHKATU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:19:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07B0IT66100079;
        Tue, 11 Aug 2020 00:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=lVPgkjQT85W+RcU/RogyTKUwwWula5UdGKEr/TamCCs=;
 b=nYo6R5xNgZOh/Mykxz9RynBciy9EqfcsCpYRx5Zpqs1KQrABaXhrrfi5ya8EpLg6T2ip
 kTs9mB++SbSVGruptFyDvFU3ncWnloDLmkGoES4UE2nzaYaYE4i9mz3oOKCGIJxZJNM7
 8ZiO8CmqNd3GLDpEClI9fCGE99c3oHEm6519e7urFee5tz3ZvQHZr0DCp0ixNtEt+HH2
 VcS7LU1ruwC2xOQRU67To/1sysch45y5n1seYB8KVqW8wRxFZqg6/fSsCcM4bmVugExU
 jUBaCep7Xe89RnaISbfIYwwhBUyq2uL1kbIkD4ZlvQhRaiaEeXgAXlunSetWpB0vVblV Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ydg2fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 00:19:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07B0HPGS193253;
        Tue, 11 Aug 2020 00:19:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32u3h0hxxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 00:19:09 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07B0J7pb030676;
        Tue, 11 Aug 2020 00:19:08 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 00:19:07 +0000
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
To:     Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>, mhocko@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
Date:   Mon, 10 Aug 2020 17:19:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810021737.GV14854@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=2 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=2 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/20 7:17 PM, Baoquan He wrote:
> On 08/07/20 at 05:12pm, Wei Yang wrote:
>> Let's always increase surplus_huge_pages and so that free_huge_page
>> could decrease it at free time.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  mm/hugetlb.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 1f2010c9dd8d..a0eb81e0e4c5 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1913,21 +1913,19 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>>  		return NULL;
>>  
>>  	spin_lock(&hugetlb_lock);
>> +
>> +	h->surplus_huge_pages++;
>> +	h->surplus_huge_pages_node[page_to_nid(page)]++;
>> +
>>  	/*
>>  	 * We could have raced with the pool size change.
>>  	 * Double check that and simply deallocate the new page
>> -	 * if we would end up overcommiting the surpluses. Abuse
>> -	 * temporary page to workaround the nasty free_huge_page
>> -	 * codeflow
>> +	 * if we would end up overcommiting the surpluses.
>>  	 */
>> -	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>> -		SetPageHugeTemporary(page);
> 
> Hmm, the temporary page way is taken intentionally in
> commit 9980d744a0428 ("mm, hugetlb: get rid of surplus page accounting tricks").
> From code, this is done inside hugetlb_lock holding, and the code flow
> is straightforward, should be safe. Adding Michal to CC.
> 

I remember when the temporary page code was added for page migration.
The use of temporary page here was added at about the same time.  Temporary
page does have one advantage in that it will not CAUSE surplus count to
exceed overcommit.  This patch could cause surplus to exceed overcommit
for a very short period of time.  However, do note that for this to happen
the code needs to race with a pool resize which itself could cause surplus
to exceed overcommit.

IMO both approaches are valid.
- Advantage of temporary page is that it can not cause surplus to exceed
  overcommit.  Disadvantage is as mentioned in the comment 'abuse of temporary
  page'.
- Advantage of this patch is that it uses existing counters.  Disadvantage
  is that it can momentarily cause surplus to exceed overcommit.

Unless someone has a strong opinion, I prefer the changes in this patch.
-- 
Mike Kravetz

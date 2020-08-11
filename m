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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6030DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1852076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wEha7Jun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHKXZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:25:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58726 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKXZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:25:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BNMv5X073414;
        Tue, 11 Aug 2020 23:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kYoEsqvgJKIdvthmqzZiNVuMGc9bSpgBaN/D+aq9KUU=;
 b=wEha7Jun9jZHToqyfxg5zFUNVo7Q7qRe3EeQEABvypuQSBT4QI0oC53JOijWSucDtJ9l
 7JHuq02xBrOoA7PfmzenCEe51j1BAq8nANJ3qAVdkrMPjYrn64BHt6GbkVNNMmxfxBto
 GwlbdXtYtxejuQQB/masd3wbN6nXzioSLsRTNoo+iYCs5nzU8jD4PiOhRErH5M3+c1qH
 D7E2Scc+v9ez8d9ZtFN1/4ubzLKiTEDPK/1/XDEBstIOBpMGR14+JUrgI5jvm+phxMkN
 /T9wWT/cgHZM32Nw6SxLG0lGhpVwOebiij3nEguevJzlvpgQqs0m6XVAq00EmoXBpO47 Uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32smpnfm68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 23:25:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07BNJZ66043088;
        Tue, 11 Aug 2020 23:25:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32u3h2ckbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 23:25:04 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07BNP2hd027654;
        Tue, 11 Aug 2020 23:25:03 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 23:25:02 +0000
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
 <20200811065406.GC4793@dhcp22.suse.cz>
 <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
 <20200811231932.GA33666@L-31X9LVDL-1304.local>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5125772b-2939-e71f-da4a-374cb74c9061@oracle.com>
Date:   Tue, 11 Aug 2020 16:25:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811231932.GA33666@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=2 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9710 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 4:19 PM, Wei Yang wrote:
> On Tue, Aug 11, 2020 at 02:43:28PM -0700, Mike Kravetz wrote:
>> Subject: [PATCH] hugetlb: optimize race error return in
>> alloc_surplus_huge_page
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
>> mm/hugetlb.c | 13 ++++++++-----
>> 1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 590111ea6975..ac89b91fba86 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1923,14 +1923,17 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>> 	/*
>> 	 * We could have raced with the pool size change.
>> 	 * Double check that and simply deallocate the new page
>> -	 * if we would end up overcommiting the surpluses. Abuse
>> -	 * temporary page to workaround the nasty free_huge_page
>> -	 * codeflow
>> +	 * if we would end up overcommiting the surpluses.
>> 	 */
>> 	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
>> -		SetPageHugeTemporary(page);
>> +		/*
>> +		 * Since this page is new, we hold the only reference, and
>> +		 * we already hold the hugetlb_lock call the low level free
>> +		 * page routine.  This saves at least a lock roundtrip.
> 
> The change looks good to me, while I may not understand the "lock roundtrip".
> You mean we don't need to release the hugetlb_lock?

Correct.
Normally we would free the page via free_huge_page() processing.  To do that
we need to drop hugetlb_lock and call put_page/free_huge_page which will
need to acquire the hugetlb_lock again.
-- 
Mike Kravetz

> 
>> +		 */
>> +		(void)put_page_testzero(page); /* don't call destructor */
>> +		update_and_free_page(h, page);
>> 		spin_unlock(&hugetlb_lock);
>> -		put_page(page);
>> 		return NULL;
>> 	} else {
>> 		h->surplus_huge_pages++;
>> -- 
>> 2.25.4

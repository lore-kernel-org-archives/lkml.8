Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E303C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC2220771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m28HDV4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgGVQQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:16:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35096 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGVQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:16:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MFuVwQ190232;
        Wed, 22 Jul 2020 16:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uPAPFWdtI0KQEaKyHfYLGNdcmjbd8o6N+HGuwvE/79A=;
 b=m28HDV4bWX/I0XDBy/fQ2oq3s+klNc5FVa8kc6cPr7fT0Ra11o0t7v054Re8GYjCOwQ4
 Xhx06ojHaOD+oNA4Jvsq4bU3KtWk4kZ/LLB0iIFPPMCZyZirP8e7YAme69i7kNinqUJK
 nkFMEkzj+0AJvY0nqvAWlLfm99LlleZRAZVb8GzPEFu6CE0LwfdTRX0lcobD/JiBwlKP
 stKw/5YcgWckPkTS/j0AZ/4pq799LvtcF0UAdhgHA9lErY3/QunhGjW4i4T1DnQfji9B
 2kNDM8bmoZrVNbwrs1FRB5TLZiJjqCRRgcN8JY9EFXDuMcfMPe+pQ8SUQl97QYuC3NPx JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32brgrmasw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 16:16:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MFwB5Z096647;
        Wed, 22 Jul 2020 16:16:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32erheh1b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 16:16:00 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06MGFxPT013028;
        Wed, 22 Jul 2020 16:15:59 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 09:15:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 5/5] mm/hugetl.c: warn out if expected count of huge pages
 adjustment is not achieved
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-6-bhe@redhat.com>
 <c5eb3692-2d05-d6dc-437d-21e51705560e@oracle.com>
 <20200722084913.GO32539@MiWiFi-R3L-srv>
Message-ID: <05d5dfde-4c1f-8f62-9526-a9a81c5ffdc1@oracle.com>
Date:   Wed, 22 Jul 2020 09:15:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200722084913.GO32539@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=2
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=2 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 1:49 AM, Baoquan He wrote:
> On 07/20/20 at 05:38pm, Mike Kravetz wrote:
>>> +	if (count != h->max_huge_pages) {
>>> +		char buf[32];
>>> +
>>> +		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
>>> +		pr_warn("HugeTLB: %s %lu of page size %s failed. Only %s %lu hugepages.\n",
>>> +			count > old_max ? "increasing" : "decreasing",
>>> +			abs(count - old_max), buf,
>>> +			count > old_max ? "increased" : "decreased",
>>> +			abs(old_max - h->max_huge_pages));
>>> +	}
>>>  	spin_unlock(&hugetlb_lock);
>>
>> I would prefer if we drop the lock before logging the message.  That would
>> involve grabbing the value of h->max_huge_pages before dropping the lock.
> 
> Do you think the below change is OK to you to move the message logging
> after lock dropping? If yes, I will repost with updated patches.
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6a9b7556ce5b..b5aa32a13569 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2661,7 +2661,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			      nodemask_t *nodes_allowed)
>  {
> -	unsigned long min_count, ret, old_max;
> +	unsigned long min_count, ret, old_max, new_max;
>  	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
>  
>  	/*
> @@ -2780,7 +2780,10 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	}
>  out:
>  	h->max_huge_pages = persistent_huge_pages(h);
> -	if (count != h->max_huge_pages) {
> +	new_max = h->max_huge_pages;
> +	spin_unlock(&hugetlb_lock);
> +
> +	if (count != new_max) {
>  		char buf[32];
>  
>  		string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> @@ -2788,9 +2791,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			count > old_max ? "increasing" : "decreasing",
>  			abs(count - old_max), buf,
>  			count > old_max ? "increased" : "decreased",
> -			abs(old_max - h->max_huge_pages));
> +			abs(old_max - new_max));
>  	}
> -	spin_unlock(&hugetlb_lock);
>  
>  	NODEMASK_FREE(node_alloc_noretry);

Yes, that looks better.  Thank you.

-- 
Mike Kravetz

Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70BAC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B404F2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xYrPmKxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGORyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:54:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45690 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGORyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:54:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FGvwPu045673;
        Wed, 15 Jul 2020 16:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ySvnLAKibIKrCI95yKZmOin0mAO3iUBF2SDonTOgiX0=;
 b=xYrPmKxGZfvFxOqIpElVFiktRYwsOKkT0bHSmvjM8NifpdUwKjJixyRVC1y+mFoZTVV0
 jRayhCHA7dLI/G6zYZpnKRj0Nc6XACkYUy+ay+gfe3ui2XOW5pnroxxXAESX2mrPuAsC
 d9nm0TMw6eHQbfXgH0i6l//QzxBTbQTE67cYV8nbuXmj8VZW+pHRyKfHcroqQhryWdpJ
 Q/YJF+NEZn6ZQS6FWYabg4cb/VNbT1eEa0aakt6wLISjSg9DgOZzum966IgmGBFaq+LM
 J8bLbZeKF/unOaRxLPNxhlQz4dHszcTx+AWjNrvzav3TIIJH9GXDbM08wfuRh8aRsuYJ Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 327s65jvdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 16:59:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FGwh9Y004902;
        Wed, 15 Jul 2020 16:59:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 327qc1b55g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 16:59:32 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FGxQq3009148;
        Wed, 15 Jul 2020 16:59:27 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 09:59:26 -0700
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Will Deacon <will@kernel.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        Roman Gushchin <guro@fb.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
Date:   Wed, 15 Jul 2020 09:59:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715081822.GA5683@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 1:18 AM, Will Deacon wrote:
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index f24acb3af741..a0007d1d12d2 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3273,6 +3273,9 @@ void __init hugetlb_add_hstate(unsigned int order)
>>  	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
>>  					huge_page_size(h)/1024);
> 
> (nit: you can also make hugetlb_cma_reserve() static and remote its function
> prototypes from hugetlb.h)

Yes thanks.  I threw this together pretty quickly.

> 
>> +	if (order >= MAX_ORDER && hugetlb_cma_size)
>> +		hugetlb_cma_reserve(order);
> 
> Although I really like the idea of moving this out of the arch code, I don't
> quite follow the check against MAX_ORDER here -- it looks like a bit of a
> hack to try to intercept the "PUD_SHIFT - PAGE_SHIFT" order which we
> currently pass to hugetlb_cma_reserve(). Maybe we could instead have
> something like:
> 
> 	#ifndef HUGETLB_CMA_ORDER
> 	#define HUGETLB_CMA_ORDER	(PUD_SHIFT - PAGE_SHIFT)
> 	#endif
> 
> and then just do:
> 
> 	if (order == HUGETLB_CMA_ORDER)
> 		hugetlb_cma_reserve(order);
> 
> ? Is there something else I'm missing?
> 

Well, the current hugetlb CMA code only kicks in for gigantic pages as
defined by the hugetlb code. For example, the code to allocate a page
from CMA is in the routine alloc_gigantic_page().  alloc_gigantic_page()
is called from alloc_fresh_huge_page() which starts with:

        if (hstate_is_gigantic(h))
                page = alloc_gigantic_page(h, gfp_mask, nid, nmask);
        else
                page = alloc_buddy_huge_page(h, gfp_mask,
                                nid, nmask, node_alloc_noretry);

and, hstate_is_gigantic is,

static inline bool hstate_is_gigantic(struct hstate *h)
{
        return huge_page_order(h) >= MAX_ORDER;
}

So, everything in the existing code really depends on the hugetlb definition
of gigantic page (order >= MAX_ORDER).  The code to check for
'order >= MAX_ORDER' in my proposed patch is just following the same
convention.

I think the current dependency on the hugetlb definition of gigantic page
may be too simplistic if using CMA for huegtlb pages becomes more common.
Some architectures (sparc, powerpc) have more than one gigantic pages size.
Currently there is no way to specify that CMA should be used for one and
not the other.  In addition, I could imagine someone wanting to reserve/use
CMA for non-gigantic (PMD) sized pages.  There is no mechainsm for that today.

I honestly have not heard about many use cases for this CMA functionality.
When support was initially added, it was driven by a specific use case and
the 'all gigantic pages use CMA if defined' implementation was deemed
sufficient.  If there are more use cases, or this seems too simple we can
revisit that decision.

>> +
>>  	parsed_hstate = h;
>>  }
>>  
>> @@ -5647,7 +5650,10 @@ void __init hugetlb_cma_reserve(int order)
>>  	unsigned long size, reserved, per_node;
>>  	int nid;
>>  
>> -	cma_reserve_called = true;
>> +	if (cma_reserve_called)
>> +		return;
>> +	else
>> +		cma_reserve_called = true;
> 
> (nit: don't need the 'else' here)

Yes, duh!

-- 
Mike Kravetz

Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0760EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6B2206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FvP75sPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbgF3Qhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:37:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44974 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbgF3Qhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:37:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UGNhsQ020571;
        Tue, 30 Jun 2020 16:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ewYdjojVC93tCg3UT6Oa+SXr42PA5Lh+ZYRd+YHHiIQ=;
 b=FvP75sPJ9ve43af6dy5B2vqDN6xPAR+T1R+CdFECYuEaAQM5dkU5CGshoiv3hNei0toB
 Ddu54VWLXbeUThq8t9+Mo1RFfKbJaAtcTLli56KZ2oqlunppKJrYkBtcA5iUGKEtcFyD
 xCyz7kl+y7p/ZQadLyokCVIGmCICKj5BiVl7Kfz/L+xtQMcT4UuNtATIDsr/RHkwIuOf
 t4dynU+mf537E/+xMK7Ua8Dx0Tb3jCDERAgpK0iwG6TgP132LGK4rg9q67+PnKDRzpir
 cL0QFYdZdA+jWyUUYtK0upflvnU+rmiVwJewV/22aiJgnMHTfNERnVGTGREWBP2BfXsJ Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31ywrbkw78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 16:37:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UGMqu8098168;
        Tue, 30 Jun 2020 16:37:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31y52j5m54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 16:37:21 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UGbIs0019025;
        Tue, 30 Jun 2020 16:37:19 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 16:37:18 +0000
Subject: Re: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA
 aware
To:     Joonsoo Kim <js1304@gmail.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
 <20200626072324.GT1320@dhcp22.suse.cz>
 <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
 <20200629075510.GA32461@dhcp22.suse.cz>
 <CAAmzW4PFEEs0FGe+XMHzRdXr0LpdF3TZZG2L3E+opRyZWDZ48A@mail.gmail.com>
 <20200630064256.GB2369@dhcp22.suse.cz>
 <CAAmzW4MFw_Xd_3rV8OVL_8jXfhUWT2v69xEFHaVLY4NKZPhD1A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <eebb68b9-99f8-3f55-9b35-59fe8ddd1b75@oracle.com>
Date:   Tue, 30 Jun 2020 09:37:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4MFw_Xd_3rV8OVL_8jXfhUWT2v69xEFHaVLY4NKZPhD1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 12:22 AM, Joonsoo Kim wrote:
> 2020년 6월 30일 (화) 오후 3:42, Michal Hocko <mhocko@kernel.org>님이 작성:
>>
>> On Tue 30-06-20 15:30:04, Joonsoo Kim wrote:
>>> 2020년 6월 29일 (월) 오후 4:55, Michal Hocko <mhocko@kernel.org>님이 작성:
>> [...]
>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>> index 57ece74e3aae..c1595b1d36f3 100644
>>>> --- a/mm/hugetlb.c
>>>> +++ b/mm/hugetlb.c
>>>> @@ -1092,10 +1092,14 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>>>>  /* Movability of hugepages depends on migration support. */
>>>>  static inline gfp_t htlb_alloc_mask(struct hstate *h)
>>>>  {
>>>> +       gfp_t gfp;
>>>> +
>>>>         if (hugepage_movable_supported(h))
>>>> -               return GFP_HIGHUSER_MOVABLE;
>>>> +               gfp = GFP_HIGHUSER_MOVABLE;
>>>>         else
>>>> -               return GFP_HIGHUSER;
>>>> +               gfp = GFP_HIGHUSER;
>>>> +
>>>> +       return current_gfp_context(gfp);
>>>>  }
>>>>
>>>>  static struct page *dequeue_huge_page_vma(struct hstate *h,
>>>>
>>>> If we even fix this general issue for other allocations and allow a
>>>> better CMA exclusion then it would be implemented consistently for
>>>> everybody.
>>>
>>> Yes, I have reviewed the memalloc_nocma_{} APIs and found the better way
>>> for CMA exclusion. I will do it after this patch is finished.
>>>
>>>> Does this make more sense to you are we still not on the same page wrt
>>>> to the actual problem?
>>>
>>> Yes, but we have different opinions about it. As said above, I will make
>>> a patch for better CMA exclusion after this patchset. It will make
>>> code consistent.
>>> I'd really appreciate it if you wait until then.
>>
>> As I've said I would _prefer_ simplicity over "correctness" if it is only
>> partial and hard to reason about from the userspace experience but this
>> is not something I would _insist_ on. If Mike as a maintainer of the
>> code is ok with that then I will not stand in the way.
> 
> Okay.

I was OK with Joonsoo's original patch which is why I Ack'ed it.  However,
my sense of simplicity and style may not be the norm as I have spent too
much time with the hugetlbfs code. :)  That is why I did not chime in and
let Michal and Joonsoo discuss.  I can see both sides of the issue.  For
now, I am OK to go with Joonsoo's patch as long as the issue below is
considered in the the next patchset.
-- 
Mike Kravetz

>> But please note that a missing current_gfp_context inside
>> htlb_alloc_mask is a subtle bug. I do not think it matters right now but
>> with a growing use of scoped apis this might actually hit some day so I
>> believe we want to have it in place.
> 
> Okay. I will keep in mind and consider it when fixing CMA exclusion on the
> other patchset.
> 
> Thanks.

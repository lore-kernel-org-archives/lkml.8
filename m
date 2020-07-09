Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCBAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853D320739
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vVxCjmLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgGIA21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:28:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48470 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGIA20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:28:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0690H2wh050436;
        Thu, 9 Jul 2020 00:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9wTlfNWUhlBkv+3kQoqpAPAkBwg2Ychc+A1txd54KuU=;
 b=vVxCjmLY1DJD+ZYztlW4afOBJx4N3WOMrod3i7UV9opN5Na3qUH6t6IwRovloNxd+oR7
 5XdpVgit8DYh4N8vkmBF90jD07Saqr6UZN2D1T+x9zjOWBBHHyhnUNtDKJk+rN1REqPd
 JT6LJen/FND+EBq1vUOu8Eon8rsC7i67vvBmyR9jmLwbb/FavgU8toGcPk7awCsx4xCu
 Ia6oxZk7X/pgDFjwRkfXvuS1BQZqQtVsoERYKEVgrK6YdzpK995Q3GPmURE17sQ9l7+L
 oM3jL9bmkvrD8azhhWYR264bfZq+qtxwsg/KV0ehBh1aBAN8SEeCr9dxt3WWEX8hBZzw jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 325k369j4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 00:27:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0690JGGa034775;
        Thu, 9 Jul 2020 00:27:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 325k3fxw3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 00:27:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0690ROtj016228;
        Thu, 9 Jul 2020 00:27:24 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 17:27:23 -0700
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
To:     Joonsoo Kim <js1304@gmail.com>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
 <20200708071602.GB16543@js1304-desktop>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d170cede-7972-7c95-0666-e2743a1c70cd@oracle.com>
Date:   Wed, 8 Jul 2020 17:27:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708071602.GB16543@js1304-desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 12:16 AM, Joonsoo Kim wrote:
> On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
>> On 7/7/20 9:44 AM, js1304@gmail.com wrote:
>>> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>>
<...>
>>> This patch makes the deque function on hugetlb CMA aware and skip CMA
>>> pages if newly added skip_cma argument is passed as true.
>>
>> Hmm, can't you instead change dequeue_huge_page_node_exact() to test the PF_
>> flag and avoid adding bool skip_cma everywhere?
> 
> Okay! Please check following patch.
>>
>> I think that's what Michal suggested [1] except he said "the code already does
>> by memalloc_nocma_{save,restore} API". It needs extending a bit though, AFAICS.
>> __gup_longterm_locked() indeed does the save/restore, but restore comes before
>> check_and_migrate_cma_pages() and thus new_non_cma_page() is called, so an
>> adjustment is needed there, but that's all?
>>
>> Hm the adjustment should be also done because save/restore is done around
>> __get_user_pages_locked(), but check_and_migrate_cma_pages() also calls
>> __get_user_pages_locked(), and that call not being between nocma save and
>> restore is thus also a correctness issue?
> 
> Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
> would not cause any problem.
> 
> ------------------>8-------------------
> From bcfc57e3c6f2df1ad2940308b89d740cd3f0fba8 Mon Sep 17 00:00:00 2001
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Date: Wed, 8 Jul 2020 14:39:26 +0900
> Subject: [PATCH] mm/hugetlb: make hugetlb migration callback CMA aware
> 
<...>
> 
> This patch makes new_non_cma_page() uses memalloc_nocma_{save,restore}
> to exclude CMA memory rather than manually clearing __GFP_MOVABLE. And,
> this patch also makes the deque function on hugetlb CMA aware. In the
> deque function, CMA memory is skipped if PF_MEMALLOC_NOCMA flag is set
> by memalloc_nocma_{save,restore}.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

I did ACK the previous version of the patch, but I like this much better.
I assume there will be a new version built on top of Michal's patch to
change the placement of memalloc_nocma_restore calls in __gup_longterm_locked.

-- 
Mike Kravetz

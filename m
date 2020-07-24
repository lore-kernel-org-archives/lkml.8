Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821EC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71371206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZbkSRuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGXRlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:41:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXRlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:41:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OHRg9d169013;
        Fri, 24 Jul 2020 17:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Fr8EKy7VqOliLP6BaZi+i9GsbdCbaRb1CNW+FV6l/Qw=;
 b=FZbkSRuMFauOjlwa5atPu5dfKM4qj/c1bf9cRfMxq4lzJJ0jxO42JMeKfEEuYUhJN2FR
 OvUvkt+2fa+3x180kuZfyBFTsvIzYyFFYb2hItRPohRrQvU7u1aSUCxPaepM9GTvmylO
 +qThWreG7xVEXQKOfKKjpd+KTsfoq51tIun0f8raXDg7Wb1XCfgAYpPvCDtC2UWRzUEi
 okdv9kWEitbRiwZQh+VZYiLymribSItP0Q/AnzfR7XPcoInLijdOWe9YUcL3nxATd+7R
 ppw9lWm6pflionKuq8VVAoZaxwMA83GylAHIlWvX5UiBnqDhzPfTVvzUrDpzOUwCZFEB bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32d6kt4mq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 17:41:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OHOPPg130870;
        Fri, 24 Jul 2020 17:41:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32ft2vpw9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 17:41:22 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06OHfFfj017456;
        Fri, 24 Jul 2020 17:41:16 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 17:41:15 +0000
Subject: Re: [PATCH v2] mm/hugetlb: add mempolicy check in the reservation
 routine
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        mhocko@kernel.org
Cc:     rientjes@google.com, mgorman@suse.de, walken@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
References: <20200724100306.33457-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <609f2de6-b91f-0018-cf98-18524a34b5d2@oracle.com>
Date:   Fri, 24 Jul 2020 10:41:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200724100306.33457-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 3:03 AM, Muchun Song wrote:
> In the reservation routine, we only check whether the cpuset meets
> the memory allocation requirements. But we ignore the mempolicy of
> MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> memory allocation may fail due to mempolicy restrictions and receives
> the SIGBUS signal. This can be reproduced by the follow steps.
> 
>  1) Compile the test case.
>     cd tools/testing/selftests/vm/
>     gcc map_hugetlb.c -o map_hugetlb
> 
>  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
>     system. Each node will pre-allocate one huge page.
>     echo 2 > /proc/sys/vm/nr_hugepages
> 
>  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
>     numactl --membind=0 ./map_hugetlb 4
> 
> With this patch applied, the mmap will fail in the step 3) and throw
> "mmap: Cannot allocate memory".
> 
> Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Michal has already provides some good suggestions.

> @@ -3653,7 +3666,7 @@ static int hugetlb_acct_memory(struct hstate *h, long delta)
>  		if (gather_surplus_pages(h, delta) < 0)
>  			goto out;
>  
> -		if (delta > cpuset_mems_nr(h->free_huge_pages_node)) {
> +		if (delta > allowed_mems_nr(h)) {
>  			return_unused_surplus_pages(h, delta);
>  			goto out;
>  		}

There is a big comment before this code in hugetlb_acct_memory.  The comment
only talks about cpusets.  We should probably update that to include mempolicy
as well.  It could be as simple as s/cpuset/cpuset or mempolicy/.
-- 
Mike Kravetz

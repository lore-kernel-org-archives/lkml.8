Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B305C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0526A2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 22:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JqfkR9u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHGWZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:25:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGWZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 18:25:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077MNFKR166634;
        Fri, 7 Aug 2020 22:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oPFJKyZLYAc3VzVUyvou3SVCM5tsGRrnygBBMWBaWi8=;
 b=JqfkR9u7pcoIxTZRu7RsIlMJmdCvxLOfvLfMLzJWds90cTGFcBigcS6dYE6ypx95mni7
 Mpi8AGY7JIuIZkHBc/4bAIUjNl9z7Ae/4gcMyrMhqqTPlRsfIAmqEQ9YJoBoN3EeJBTZ
 rtLHe8A9fHoHc1k+w/+l4bGLDJPW0cPJByzloQ9aGK+w/FM3tOv+y38fc3C9UlcAraEf
 WTm8lICr3nnV7lv02oiIlc3gbBPu6kfHRVdPAr5q6CH8c7UB036cMhF7uY9y0r8Hh+Hf
 gNWwE8CM/4Lmytdb6aaQNl/8wpQ73BgM3mgx5xjEtNWBjSVxBBoAfukdZ+Uu8YPR57BC cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32r6fxtwjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 07 Aug 2020 22:25:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 077MO2tO122450;
        Fri, 7 Aug 2020 22:25:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32r6cygxjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Aug 2020 22:25:47 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 077MPjmM026290;
        Fri, 7 Aug 2020 22:25:45 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Aug 2020 22:25:45 +0000
Subject: Re: [PATCH 00/10] mm/hugetlb: code refine and simplification
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5b954f2d-0b51-c3bd-db8a-610580272d3d@oracle.com>
Date:   Fri, 7 Aug 2020 15:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9706 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008070151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 2:12 AM, Wei Yang wrote:
> Following are some cleanup for hugetlb.
> 
> Simple test with tools/testing/selftests/vm/map_hugetlb pass.
> 
> Wei Yang (10):
>   mm/hugetlb: not necessary to coalesce regions recursively
>   mm/hugetlb: make sure to get NULL when list is empty
>   mm/hugetlb: use list_splice to merge two list at once
>   mm/hugetlb: count file_region to be added when regions_needed != NULL
>   mm/hugetlb: remove the redundant check on non_swap_entry()
>   mm/hugetlb: remove redundant huge_pte_alloc() in hugetlb_fault()
>   mm/hugetlb: a page from buddy is not on any list
>   mm/hugetlb: return non-isolated page in the loop instead of break and
>     check
>   mm/hugetlb: narrow the hugetlb_lock protection area during preparing
>     huge page
>   mm/hugetlb: not necessary to abuse temporary page to workaround the
>     nasty free_huge_page
> 
>  mm/hugetlb.c | 101 ++++++++++++++++++++++-----------------------------
>  1 file changed, 44 insertions(+), 57 deletions(-)

Thanks Wei Yang!

I'll take a look at these next week.
-- 
Mike Kravetz

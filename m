Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A26C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A6B204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSXZNxJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgHXV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:57:23 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXV5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:57:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OLnHBA073517;
        Mon, 24 Aug 2020 21:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=A/PnfWbsJd7N4fG0fbCbbTnDOO65Xs5d+iKgr3JCUgQ=;
 b=BSXZNxJr0wXqAwuFszBTcYEBKJ7Ej103vFkbbEgePFPFHuPfJTmzSIRf28DXKPFyUxqh
 6W4gQcYos0VZiE8+/cA0QeNSnzb8GHTuUQ+C0eAZD6eT8Izc1Xlfdjrx3nHqa9D97SxK
 oYwLXgOBks5k5UhR9xOXzrpS1sYrIuPARzOIg8kVb2EPsiAU8MzKAHpMPw1LUQwngWRl
 EgHfnTMiY9IbiA7r5Y/oUKpPwgWiAvfkcLd0AvceWPsQbM9nTJRXONRCCepFV1QiWfzr
 LCvK1G/7UD9UWinkUegV3CbOQu6k/OptRt79F12BhwVI64OkXf4BGn+48p9Me0KjaUlZ dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6tnnvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 21:57:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OLu8BK032110;
        Mon, 24 Aug 2020 21:57:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 333ru5v8bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 21:57:15 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OLvDQu010932;
        Mon, 24 Aug 2020 21:57:14 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 14:57:12 -0700
Subject: Re: [PATCH v2 0/4] mm/hugetlb: Small cleanup and improvement
To:     akpm@linux-foundation.org
Cc:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, david@redhat.com
References: <20200723032248.24772-1-bhe@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9cdac49f-bec3-2230-2432-5ea2d83608b5@oracle.com>
Date:   Mon, 24 Aug 2020 14:57:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723032248.24772-1-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Unless someone objects, can you add patches 1-3 of this series to your tree.
They have been reviewed and are fairly simple cleanups.
-- 
Mike Kravetz

On 7/22/20 8:22 PM, Baoquan He wrote:
> v1 is here:
> https://lore.kernel.org/linux-mm/20200720062623.13135-1-bhe@redhat.com/
> 
> Patch 1~3 are small clean up.
> 
> Patch 4 is adding warning message when the number of persistent huge
> pages is not changed to the exact value written to the sysfs or proc
> nr_hugepages file.
> 
> v1->v2:
>   Drop the old patch 1/5 in v1 post, which was thought as typo, while
>   actually another kind of abbreviation.
> 
>   Updated patch log of patch 4 which is rephrased by Mike. And move the
>   added message logging code after the hugetlb_lock dropping, this is
>   suggested by Mike.
> 
> 
> Baoquan He (4):
>   mm/hugetlb.c: make is_hugetlb_entry_hwpoisoned return bool
>   mm/hugetlb.c: Remove the unnecessary non_swap_entry()
>   doc/vm: fix typo in the hugetlb admin documentation
>   mm/hugetl.c: warn out if expected count of huge pages adjustment is
>     not achieved
> 
>  Documentation/admin-guide/mm/hugetlbpage.rst |  2 +-
>  mm/hugetlb.c                                 | 27 +++++++++++++++-----
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 

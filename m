Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF345C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73C12173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VfUuBat9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBRXnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:43:21 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58074 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRXnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:43:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01INhCcV136753;
        Tue, 18 Feb 2020 23:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0m00BguRlLekOA8EI0mqAMtdAPqsM6dw3X+VwmV1jKU=;
 b=VfUuBat95GLBnl5Z0MvUS0geiN7taCy0N45hIa6gtaEbyeak1SvFKOOnFA9exgIZL3ah
 PT8jtQd1wC2kv9ZBc6pkGrZOJS3OlH3iXmlGbSAqDKNgFvZRlALIfm4bIgvFZx8PzD5M
 m+c8KBsuMeYP68QLynXnnrxX1lOrLFSs4gEbmD54qHNNXw6wid8IMUQGFa3se9To7Rgy
 3uwzk3Xm/eZnvHVHam5VyHut89CKYltM5H8rrDlB/Ujh16MhsCOr5dh44NeYOr5Sq35y
 GThuOCNTfOavz9NJhO8HEhPEfQxv66Hy+un8DXCD3hJQ/Lb8c9cirs2Nxry2JJbH0TZ8 fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2y8e1hn2ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 23:43:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01INgA4b071778;
        Tue, 18 Feb 2020 23:43:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2y6tetf960-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 23:43:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01INhCCS018965;
        Tue, 18 Feb 2020 23:43:12 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 15:43:12 -0800
Subject: Re: [PATCH -next] mm/hugetlb: Fix file_region entry allocations
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
References: <20200218222658.132101-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <67aa82a8-3c8d-d1eb-7e83-4f722b1eeb2a@oracle.com>
Date:   Tue, 18 Feb 2020 15:43:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218222658.132101-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=2 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/20 2:26 PM, Mina Almasry wrote:
> Commit a9e443086489e ("hugetlb: disable region_add file_region
> coalescing") introduced a bug with adding file_region entries
> that is fixed here:
> 
> 1. Refactor file_region entry allocation logic into 1 function called
>    from region_add and region_chg since the code is now identical.
> 2. region_chg only modifies resv->adds_in_progress after the regions
>    have been allocated. In the past it used to increment
>    adds_in_progress and then drop the lock, which would confuse racing
>    region_add calls into thinking they need to allocate entries when
>    they are not allowed.
> 3. In region_add, only try to allocate regions when
>    actual_regions_needed > in_regions_needed. This is not causing a bug
>    but is better for cleanliness and reasoning about the code.
> 
> Tested using ltp hugemmap0* tests, and libhugetlbfs tests.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Fixes: Commit a9e443086489e ("hugetlb: disable region_add file_region
> coalescing")
> 
> ---
>  mm/hugetlb.c | 149 +++++++++++++++++++++++++--------------------------
>  1 file changed, 74 insertions(+), 75 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8171d2211be77..3d5b48ae8971f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -439,6 +439,66 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  	return add;
>  }
> 
> +/* Must be called with resv->lock acquired. Will drop lock to allocate entries.
> + */
> +static int allocate_file_region_entries(struct resv_map *resv,
> +					int regions_needed)
> +{

I think this is going to need annotation for the lock or sparse is going
throw a warning.  See,

https://lore.kernel.org/linux-mm/20200214204741.94112-7-jbi.octave@gmail.com/

Other than that, looks good.  Sorry I missed that race in the review.
-- 
Mike Kravetz

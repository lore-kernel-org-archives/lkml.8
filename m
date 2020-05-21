Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37000C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBDD20759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bne3se7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgEUS5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:57:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54472 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgEUS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:57:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LIlpXl109518;
        Thu, 21 May 2020 18:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bIXaKlPDsTn5lduwqqi3zoH+qIUEItuqSMh/uAdNECY=;
 b=Bne3se7S/3/7PtAMQsR8a50JGDgMIjAcfe9fnR1gwo1QMas0RJDVZI/F4OfvwprfCKWx
 CW7rAIojZimOW0c9LbfXn/r5OjvLA3Eo46oHqiS1tRWhrYE4BLm6AtEbxIjd01fHf+zW
 rT7grRVerxIarPT46MhTk7qHop+clmR0xbGmo9LbQsFMplAsEiiFV/GEXP+w3veNjBI4
 E+/05BkTjY1oiajEXwZry5I1Lbu/abhvp/q+2CTv7XPF5U8KGaQ4RX7YAxziBb7Rgx2v
 79XiPCSLFnAi4wcUzER2bi73vXLnxWn7ktKJgS6mflc54Em8yNkaq8tLnQGOHJIYBFaI hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284ma6w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 18:57:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04LImWcZ008213;
        Thu, 21 May 2020 18:57:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 314gm9rt5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 May 2020 18:57:09 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04LIv6Ew011246;
        Thu, 21 May 2020 18:57:07 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 May 2020 11:57:06 -0700
Subject: Re: [PATCH 03/11] mm/hugetlb: introduce alloc_control structure to
 simplify migration target allocation APIs
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3499673c-d103-bb69-5f38-8cce8e659a85@oracle.com>
Date:   Thu, 21 May 2020 11:57:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005210136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005210136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 6:20 PM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Currently, page allocation functions for migration requires some arguments.
> More worse, in the following patch, more argument will be needed to unify
> the similar functions. To simplify them, in this patch, unified data
> structure that controls allocation behaviour is introduced.

As a followup to Roman's question and your answer about adding a suffix/prefix
to the new structure.  It 'may' be a bit confusing as alloc_context is already
defined and *ac is passsed around for page allocations.  Perhaps, this new
structure could somehow have migrate in the name as it is all about allocating
migrate targets?

> 
> For clean-up, function declarations are re-ordered.
> 
> Note that, gfp_mask handling on alloc_huge_page_(node|nodemask) is
> slightly changed, from ASSIGN to OR. It's safe since caller of these
> functions doesn't pass extra gfp_mask except htlb_alloc_mask().
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Patch makes sense.

> diff --git a/mm/migrate.c b/mm/migrate.c
> index a298a8c..94d2386 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1526,10 +1526,15 @@ struct page *new_page_nodemask(struct page *page,
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
>  
> -	if (PageHuge(page))
> -		return alloc_huge_page_nodemask(
> -				page_hstate(compound_head(page)),
> -				preferred_nid, nodemask);
> +	if (PageHuge(page)) {
> +		struct hstate *h = page_hstate(page);

I assume the removal of compound_head(page) was intentional?  Just asking
because PageHuge will look at head page while page_hstate will not.  So,
if passed a non-head page things could go bad.

-- 
Mike Kravetz

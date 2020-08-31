Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEC6C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A6D20866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cz52yAqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHaXHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:07:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgHaXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:07:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VN5bL5139463;
        Mon, 31 Aug 2020 23:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6VvA3Sy4jRYP0jUdhmWPVdQeqbWyGzNjLOExWc14ShU=;
 b=Cz52yAqNBTmSkgpiGEtA9LNi4QM/kwlgqBAPdUVmpKaFbdOO+zAO6kRqA5p9AJqfcoT8
 4nRMfMKAkrPUud7WwHYJHU+zO97EkqAXg6Cv0CH1ff5Q1Rtt6j+x1O5rT4sMOLT1vjAm
 Nd4qxtyfnW8dAERIhz8+Ug62flctRGYgoBPQUFzEPt/sa8c2ba4XY8qxC1i3nVRzCQUD
 E1g/hRgYRH+4sxmvsyVCkOUYqluou0v7f0jKdlaZaWdtCG0LMVgkNO9ZptisZAGZRSlz
 2cEIs6BEx+bgIAsjVVqz2qYv9Dax1uaBVjMtRpPjy6oPvoLxjBOlcMUE6hvpqRci0oIA bA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 337qrhg2gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 23:06:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VN6YmD175256;
        Mon, 31 Aug 2020 23:06:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3380x1jhcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 23:06:56 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07VN6t0i002632;
        Mon, 31 Aug 2020 23:06:55 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 16:06:55 -0700
Subject: Re: [Patch v3 7/7] mm/hugetlb: take the free hpage during the
 iteration directly
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com
References: <20200831022351.20916-1-richard.weiyang@linux.alibaba.com>
 <20200831022351.20916-8-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d36e57db-b02f-fd75-6c0c-734635f58ff5@oracle.com>
Date:   Mon, 31 Aug 2020 16:06:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831022351.20916-8-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=2 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/20 7:23 PM, Wei Yang wrote:
> Function dequeue_huge_page_node_exact() iterates the free list and
> return the first valid free hpage.
> 
> Instead of break and check the loop variant, we could return in the loop
> directly. This could reduce some redundant check.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7b3357c1dcec..709be7ab65af 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1040,21 +1040,17 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  		if (nocma && is_migrate_cma_page(page))
>  			continue;
>  
> -		if (!PageHWPoison(page))
> +		if (PageHWPoison(page))
>  			break;

Previously, when encountering a PageHWPoison(page) the loop would continue
and check the next page in the list.  It now breaks the loop and returns
NULL.  Is not this a change in behavior?  Perhaps you want to change that
break to a continue.  Or, restructure in some other way.
-- 
Mike Kravetz

> +
> +		list_move(&page->lru, &h->hugepage_activelist);
> +		set_page_refcounted(page);
> +		h->free_huge_pages--;
> +		h->free_huge_pages_node[nid]--;
> +		return page;
>  	}
>  
> -	/*
> -	 * if 'non-isolated free hugepage' not found on the list,
> -	 * the allocation fails.
> -	 */
> -	if (&h->hugepage_freelists[nid] == &page->lru)
> -		return NULL;
> -	list_move(&page->lru, &h->hugepage_activelist);
> -	set_page_refcounted(page);
> -	h->free_huge_pages--;
> -	h->free_huge_pages_node[nid]--;
> -	return page;
> +	return NULL;
>  }
>  
>  static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask, int nid,
> 

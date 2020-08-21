Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A3EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8102120724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XNkgb7Rs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgHUNPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:15:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgHUNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:15:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LDCKZ7044099;
        Fri, 21 Aug 2020 13:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=48t+JyaxUG+IiwX0HOyopf5UdpGg/IM7foZd1KSrLCc=;
 b=XNkgb7RsDkvwpB4+y6cZIRRx1y+ShUsmuWUFDjAoTG+r8zo1FnIKquCAyRPHq251tMTK
 +Gh63ZtewoUojaiLKo7Jmrf4vCk7BQRowhV3TdN/3rPP1K3tYufIb59cOjhOclSzLflO
 3x9ra3ckgTtvCFRJYFPfGdg1tubbye8gqrYi4OUtleA++Go36mVGAuU/9fsaj9DWPlgY
 cYjosORm9WIdR8R6HvipPtrh5FGnODGrqbj6s1VWYyF7IkklVeoYHvSCukQ8IX2WGFUs
 Hp3Pzh2xNSxfhh0MpD6RJlGM7R+tI5Y2xJZt1JjqtxJ5C0S5PCM7LZBHukS2xLnGImo5 jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74rnyxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 13:15:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LD95Ow116592;
        Fri, 21 Aug 2020 13:15:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsn2jbak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 13:15:15 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07LDFBMK029772;
        Fri, 21 Aug 2020 13:15:12 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 13:15:11 +0000
Date:   Fri, 21 Aug 2020 16:15:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tomer Samara <tomersamara98@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Riley Andrews <riandrews@android.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Laura Abbott <labbott@redhat.com>,
        Martijn Coenen <maco@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v3 1/2] staging: android: Remove BUG_ON from
 ion_page_pool.c
Message-ID: <20200821131502.GU1793@kadam>
References: <cover.1597865771.git.tomersamara98@gmail.com>
 <2e6c71ad168f92170ef856922b9a0c8dd0f85e11.1597865771.git.tomersamara98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6c71ad168f92170ef856922b9a0c8dd0f85e11.1597865771.git.tomersamara98@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=2 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=2 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:38:47PM +0300, Tomer Samara wrote:
> BUG_ON() is removed at ion_page_pool.c and add error handleing to
> ion_page_pool_shrink
> 
> Fixes the following issue:
> Avoid crashing the kernel - try using WARN_ON & recovery code ratherthan BUG() or BUG_ON().
> 
> Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> ---
>  drivers/staging/android/ion/ion_page_pool.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index 0198b886d906..ae2bc57bcbe8 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -46,11 +46,13 @@ static struct page *ion_page_pool_remove(struct ion_page_pool *pool, bool high)
>  	struct page *page;
>  
>  	if (high) {
> -		BUG_ON(!pool->high_count);
> +		if (!pool->high_count)
> +			return NULL;

I looked at the callers and it's trivial to verify that these conditions
are impossible.  Just delete the BUG_ON() checks.

>  		page = list_first_entry(&pool->high_items, struct page, lru);
>  		pool->high_count--;
>  	} else {
> -		BUG_ON(!pool->low_count);
> +		if (!pool->low_count)
> +			return NULL;
>  		page = list_first_entry(&pool->low_items, struct page, lru);
>  		pool->low_count--;
>  	}
> @@ -65,7 +67,8 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
>  {
>  	struct page *page = NULL;
>  
> -	BUG_ON(!pool);
> +	if (!pool)
> +		return NULL;

This one is slightly harder to verify...  But really I would prefer that
we just deleted it as well.  If we had a NULL dereference here then that
would give a pretty straight forward stack trace to debug.

>  
>  	mutex_lock(&pool->mutex);
>  	if (pool->high_count)
> @@ -82,7 +85,8 @@ struct page *ion_page_pool_alloc(struct ion_page_pool *pool)
>  
>  void ion_page_pool_free(struct ion_page_pool *pool, struct page *page)
>  {
> -	BUG_ON(pool->order != compound_order(page));
> +	if (pool->order != compound_order(page))
> +		return;

Is returning really the correct way to handle this bug?  I suggest,
just change BUG_ON() to a WARN_ON().

>  
>  	ion_page_pool_add(pool, page);
>  }
> @@ -124,6 +128,8 @@ int ion_page_pool_shrink(struct ion_page_pool *pool, gfp_t gfp_mask,
>  			break;
>  		}
>  		mutex_unlock(&pool->mutex);
> +		if (!page)
> +			break;

This change is no longer required if we delete the changes earlier as
I suggest.  This change illustrates how when we start handling
impossible conditions then we just have to keep on imagining more and
more impossible conditions.  When we start trying to write code for
situations which we know are impossible that is an unending task.

>  		ion_page_pool_free_pages(pool, page);
>  		freed += (1 << pool->order);
>  	}

regards,
dan carpenter


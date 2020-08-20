Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E590FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72AA207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oQ8GMOKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHTA2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:28:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33084 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHTA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:28:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07K0SagY005582;
        Thu, 20 Aug 2020 00:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=vel+smFQdJIkcUoSS2CWHtxEjDOkisx508rK5q+tszw=;
 b=oQ8GMOKQj3nvNCXllKq06pgp7nljxgmLsZOFUAWIQZjrZCSZ6GuzO46lvWP41EnYuSPY
 cw2lDQeua2PlKOPdh7qgqR9YYkVXNM08W/bWsh6dkRJauc5ne8LYXcbgYPC/2Gk8zQFx
 YLZ2wkT0owFDf0ms5SIcnNtNu8IeUn5pL5alkfGKzfVu6MDwNymJjIb1cZLMCRYvYOxG
 4SCYSFq45I84YuUpOyQX144qCbnDn5XL5tepHZaFvFaUomiFuzmxn9iEwt6KiO+RzkFP
 +zW2pCjWOanPgMZJTr4x+Q6khCteM45RfV51037sAwOVwv6+eezPIN67qIvbI2sH9Tfs lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32x74rdfx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 00:28:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07K0NpLD031106;
        Thu, 20 Aug 2020 00:26:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 330pvmprrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 00:26:35 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07K0QYdT014310;
        Thu, 20 Aug 2020 00:26:34 GMT
Received: from [10.74.109.193] (/10.74.109.193)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Aug 2020 17:26:34 -0700
Subject: Re: [RFC PATCH] xen/gntdev.c: Convert get_user_pages*() to
 pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>, jgross@suse.com,
        sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
References: <1597725140-8310-1-git-send-email-jrdr.linux@gmail.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <82366a3d-db55-68eb-7f29-935b511dace4@oracle.com>
Date:   Wed, 19 Aug 2020 20:26:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597725140-8310-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/18/20 12:32 AM, Souptick Joarder wrote:
> In 2019, we introduced pin_user_pages*() and now we are converting
> get_user_pages*() to the new API as appropriate. [1] & [2] could
> be referred for more information. This is case 5 as per document [1].
>
> [1] Documentation/core-api/pin_user_pages.rst
>
> [2] "Explicit pinning of user-space pages":
>         https://lwn.net/Articles/807108/
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/xen/gntdev.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 64a9025a..e480509 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -730,7 +730,7 @@ static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
>  	unsigned long xen_pfn;
>  	int ret;
>  
> -	ret = get_user_pages_fast(addr, 1, writeable ? FOLL_WRITE : 0, &page);
> +	ret = pin_user_pages_fast(addr, 1, writeable ? FOLL_WRITE : 0, &page);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -744,10 +744,7 @@ static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
>  
>  static void gntdev_put_pages(struct gntdev_copy_batch *batch)
>  {
> -	unsigned int i;
> -
> -	for (i = 0; i < batch->nr_pages; i++)
> -		put_page(batch->pages[i]);
> +	unpin_user_pages(batch->pages, batch->nr_pages);


There seems to be a bug in the original code (just like there was in
privcmd.c that you fixed earlier) --- when gntdev_get_page() is called
with writeable=true then the page needs to be marked dirty before being
put.


You can add a `bool writeable` to gntdev_copy_batch and set it in
gntdev_grant_copy_seg() (and drop `writeable` argument to
gntdev_get_page()) and then, based on batch->writeable, use either
unpin_user_pages() or unpin_user_pages_dirty_lock().


(But to fix this in stable branches please make first patch call
set_page_dirty_lock() for each page like you did in previous series)


-boris


>  	batch->nr_pages = 0;
>  }
>  

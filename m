Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F83C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7DE2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Heon1BcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgERGY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:24:59 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15809 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgERGY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:24:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec229ae0000>; Sun, 17 May 2020 23:22:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 17 May 2020 23:24:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 17 May 2020 23:24:59 -0700
Received: from [10.2.48.175] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 06:24:58 +0000
Subject: Re: [PATCH] orangefs: convert get_user_pages() --> pin_user_pages()
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        <devel@lists.orangefs.org>
References: <20200518060139.2828423-1-jhubbard@nvidia.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <582e6272-ca21-6300-19dd-7776e21ce002@nvidia.com>
Date:   Sun, 17 May 2020 23:24:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518060139.2828423-1-jhubbard@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589782958; bh=l/FdtWfrvi/C3me9+/gpM2PcBKmwGcSy8/CNv2P2SqA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Heon1BcT9rnkVW92QlNOPPn9x8Si22vngp1+Xyj+o00ULC/EeCq8F7ZPhZi+SdQ/h
         q5ExPUV9SalajhkZ0ljXnbddbI4qkwzNowCn5IW/PcG8ZVwxnTP044fA5vnspN8KuQ
         G9m6D/T+6+Ghpcmq7lF8eOUPdr/bYEJjIiR7lPX91erq1f4DcISSmawpSH528UP5Lj
         DNy3LYzB2zVIASX/vkheEADYTUJuhhTHPLfT7AWwO8/0vaLdVZJ+iwoWQPExK1Lzob
         ezE1OlpMc1xo4W0daQH8vPEK8xJkBQ/XV3HU9UjGRtFGGKnB4359emQdNp577gJQdT
         cSDQKoAjD8hdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-17 23:01, John Hubbard wrote:
> This code was using get_user_pages*(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages*() + put_page() calls to
> pin_user_pages*() + unpin_user_pages() calls.

Oops, actually, maybe that description is wrong. This is probably
closer to "Case 1: Direct IO"...right? I don't see an O_DIRECT
anywhere, but there is an ioctl to do ORANGEFS_DEV_MAP, which seems
like effectively it's doing Direct IO.

(I got lulled into commit log complacency, due to sending quite a few
non-filesystem patches that were Case 2.)


thanks,
-- 
John Hubbard
NVIDIA

> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>      https://lwn.net/Articles/807108/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
>   fs/orangefs/orangefs-bufmap.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/orangefs/orangefs-bufmap.c b/fs/orangefs/orangefs-bufmap.c
> index 2bb916d68576..538e839590ef 100644
> --- a/fs/orangefs/orangefs-bufmap.c
> +++ b/fs/orangefs/orangefs-bufmap.c
> @@ -168,10 +168,7 @@ static DEFINE_SPINLOCK(orangefs_bufmap_lock);
>   static void
>   orangefs_bufmap_unmap(struct orangefs_bufmap *bufmap)
>   {
> -	int i;
> -
> -	for (i = 0; i < bufmap->page_count; i++)
> -		put_page(bufmap->page_array[i]);
> +	unpin_user_pages(bufmap->page_array, bufmap->page_count);
>   }
>   
>   static void
> @@ -268,7 +265,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
>   	int offset = 0, ret, i;
>   
>   	/* map the pages */
> -	ret = get_user_pages_fast((unsigned long)user_desc->ptr,
> +	ret = pin_user_pages_fast((unsigned long)user_desc->ptr,
>   			     bufmap->page_count, FOLL_WRITE, bufmap->page_array);
>   
>   	if (ret < 0)
> @@ -280,7 +277,7 @@ orangefs_bufmap_map(struct orangefs_bufmap *bufmap,
>   
>   		for (i = 0; i < ret; i++) {
>   			SetPageError(bufmap->page_array[i]);
> -			put_page(bufmap->page_array[i]);
> +			unpin_user_page(bufmap->page_array[i]);
>   		}
>   		return -ENOMEM;
>   	}
> 

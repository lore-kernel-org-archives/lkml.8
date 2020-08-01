Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F645C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9ED2076C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 12:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgHAMFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 08:05:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45707 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHAMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 08:05:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id r19so34951553ljn.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 05:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OLG7ItAoYmN7hbuX8EPhVN+JREx1wwvbMlVFaToyRYs=;
        b=BxPnQvRWcJiy6NaRy0KjMeSBDx+2iUSv11H3IBqb141MMnb2jjAXWahZAcEfQSIeqO
         3u0F4cU8v8k5k4+Os/CEH6wjBgYvZEdKWYDg9OOSEus0WzKmBYP1S3ZWj/3sIEjyUeSC
         edJOPRDDao3KkhQg+WAfoEFP1n8acVVdd8QqGPX1lFvzrDwLdGSR4jgHfelqJQWCABno
         xtMrHQINGH0OunL+Xn4N40IodAStHaQI9rthNg7Y0VJ+q7Yds34XPrS8OevSwdFz8gpq
         qiVOVZrbAEC4+KsUXXyopqRfEsBZKfvZTi5sswTwCwPKANt6QEo2Uifr3yV8zsaeNy2t
         WWwg==
X-Gm-Message-State: AOAM532GAu6Q+hzoxmvE69c7JK8jeQOPRIeyuH24t5SVmF4r0SU/VJfH
        llX+YtHpiiq0sPliRd6cjLXWy6LiRG8=
X-Google-Smtp-Source: ABdhPJyFxGGM4eke2ocMldO+y6VDyJKIRDixrr8Htw2n4cKIPnieFniNcb430JXXH2oXfqVE9JWeZw==
X-Received: by 2002:a2e:8897:: with SMTP id k23mr3622693lji.355.1596283507352;
        Sat, 01 Aug 2020 05:05:07 -0700 (PDT)
Received: from [10.68.32.192] (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.gmail.com with ESMTPSA id v10sm2668127lfo.11.2020.08.01.05.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2020 05:05:06 -0700 (PDT)
Subject: Re: [PATCH] gfs2: Use kvmalloc instead of opencoded kmalloc/vmalloc
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org
References: <20200731212818.10782-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <777bd9d1-35b0-842a-83df-55792126c652@linux.com>
Date:   Sat, 1 Aug 2020 15:05:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731212818.10782-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please, skip this patch. I missed that kvmalloc checks (flags & GFP_KERNEL) == GFP_KERNEL
before calling vmalloc.

P.S.: previous mail was filtered because of html tags.

Thanks,
Denis

On 8/1/20 12:28 AM, Denis Efremov wrote:
> Use kvmalloc instead of opencoded kmalloc/vmalloc condition.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  fs/gfs2/dir.c   | 23 ++++-------------------
>  fs/gfs2/quota.c |  5 +----
>  2 files changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index c0f2875c946c..5d2a708fae9c 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -352,9 +352,7 @@ static __be64 *gfs2_dir_get_hash_table(struct gfs2_inode *ip)
>  		return ERR_PTR(-EIO);
>  	}
>  
> -	hc = kmalloc(hsize, GFP_NOFS | __GFP_NOWARN);
> -	if (hc == NULL)
> -		hc = __vmalloc(hsize, GFP_NOFS);
> +	hc = kvmalloc(hsize, GFP_NOFS);
>  
>  	if (hc == NULL)
>  		return ERR_PTR(-ENOMEM);
> @@ -1320,18 +1318,6 @@ static int do_filldir_main(struct gfs2_inode *dip, struct dir_context *ctx,
>  	return 0;
>  }
>  
> -static void *gfs2_alloc_sort_buffer(unsigned size)
> -{
> -	void *ptr = NULL;
> -
> -	if (size < KMALLOC_MAX_SIZE)
> -		ptr = kmalloc(size, GFP_NOFS | __GFP_NOWARN);
> -	if (!ptr)
> -		ptr = __vmalloc(size, GFP_NOFS);
> -	return ptr;
> -}
> -
> -
>  static int gfs2_set_cookies(struct gfs2_sbd *sdp, struct buffer_head *bh,
>  			    unsigned leaf_nr, struct gfs2_dirent **darr,
>  			    unsigned entries)
> @@ -1409,7 +1395,8 @@ static int gfs2_dir_read_leaf(struct inode *inode, struct dir_context *ctx,
>  	 * 99 is the maximum number of entries that can fit in a single
>  	 * leaf block.
>  	 */
> -	larr = gfs2_alloc_sort_buffer((leaves + entries + 99) * sizeof(void *));
> +	larr = kvmalloc_array(leaves + entries + 99,
> +			      sizeof(void *), GFP_NOFS);
>  	if (!larr)
>  		goto out;
>  	darr = (struct gfs2_dirent **)(larr + leaves);
> @@ -1985,9 +1972,7 @@ static int leaf_dealloc(struct gfs2_inode *dip, u32 index, u32 len,
>  
>  	memset(&rlist, 0, sizeof(struct gfs2_rgrp_list));
>  
> -	ht = kzalloc(size, GFP_NOFS | __GFP_NOWARN);
> -	if (ht == NULL)
> -		ht = __vmalloc(size, GFP_NOFS | __GFP_NOWARN | __GFP_ZERO);
> +	ht = kvzalloc(size, GFP_NOFS);
>  	if (!ht)
>  		return -ENOMEM;
>  
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 4b67d47a7e00..204b34f38e5c 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1362,10 +1362,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>  	bm_size = DIV_ROUND_UP(sdp->sd_quota_slots, 8 * sizeof(unsigned long));
>  	bm_size *= sizeof(unsigned long);
>  	error = -ENOMEM;
> -	sdp->sd_quota_bitmap = kzalloc(bm_size, GFP_NOFS | __GFP_NOWARN);
> -	if (sdp->sd_quota_bitmap == NULL)
> -		sdp->sd_quota_bitmap = __vmalloc(bm_size, GFP_NOFS |
> -						 __GFP_ZERO);
> +	sdp->sd_quota_bitmap = kvzalloc(bm_size, GFP_NOFS);
>  	if (!sdp->sd_quota_bitmap)
>  		return error;
>  
> 

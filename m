Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC39C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335BA2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgFRPvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgFRPvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:51:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC243C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:51:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jlwpE-0005mk-KY; Thu, 18 Jun 2020 17:51:36 +0200
Message-ID: <be88faf0aa10d1c71dbf2c22e6c72623d4598a0c.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/etnaviv: convert get_user_pages() -->
 pin_user_pages()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Thu, 18 Jun 2020 17:51:34 +0200
In-Reply-To: <20200525234946.512848-1-jhubbard@nvidia.com>
References: <20200525234946.512848-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 25.05.2020, 16:49 -0700 schrieb John Hubbard:
> This code was using get_user_pages*(), in a "Case 2" scenario
> (DMA/RDMA), using the categorization from [1]. That means that it's
> time to convert the get_user_pages*() + put_page() calls to
> pin_user_pages*() + unpin_user_pages() calls.
> 
> There is some helpful background in [2]: basically, this is a small
> part of fixing a long-standing disconnect between pinning pages, and
> file systems' use of those pages.
> 
> [1] Documentation/core-api/pin_user_pages.rst
> 
> [2] "Explicit pinning of user-space pages":
>     https://lwn.net/Articles/807108/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Thanks, I've applied this to etnaviv/next.

Regards,
Lucas

> ---
> 
> Hi,
> 
> Changes since v1:
> 
> * Rebased onto Linux 5.7-rc7
> 
> * Added: Lucas Stach
> 
> thanks
> John Hubbard
> NVIDIA
> 
> 
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index dc9ef302f517..0f4578dc169d 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -675,10 +675,10 @@ static int etnaviv_gem_userptr_get_pages(struct etnaviv_gem_object *etnaviv_obj)
>  		uint64_t ptr = userptr->ptr + pinned * PAGE_SIZE;
>  		struct page **pages = pvec + pinned;
>  
> -		ret = get_user_pages_fast(ptr, num_pages,
> +		ret = pin_user_pages_fast(ptr, num_pages,
>  					  !userptr->ro ? FOLL_WRITE : 0, pages);
>  		if (ret < 0) {
> -			release_pages(pvec, pinned);
> +			unpin_user_pages(pvec, pinned);
>  			kvfree(pvec);
>  			return ret;
>  		}
> @@ -702,7 +702,7 @@ static void etnaviv_gem_userptr_release(struct etnaviv_gem_object *etnaviv_obj)
>  	if (etnaviv_obj->pages) {
>  		int npages = etnaviv_obj->base.size >> PAGE_SHIFT;
>  
> -		release_pages(etnaviv_obj->pages, npages);
> +		unpin_user_pages(etnaviv_obj->pages, npages);
>  		kvfree(etnaviv_obj->pages);
>  	}
>  }


Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C43C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A177A205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWb4w42s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgENPKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:10:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55914 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgENPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589469018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pjhe0pPWagjeT8zPWsmNJcDalOvlFIp0hZiIQ1AouMs=;
        b=EWb4w42sCOcnYhGYOe40sZZCmz91eFbt+SaF25SYXtxaVwTq/04QcFM5RB/RWcM9BdXFgd
        vyEpgcTRsZ+WJrF9jzC1H8oQcT6lRDQqQK3dIWXPbAgWkLwKZHzR/Iw/7vI38zvqHP/2Cz
        L4Pw07eNBg+knnImXfVYpy/eb5NdXww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-9qhINdNxM-GCPK0shab-Cg-1; Thu, 14 May 2020 11:10:14 -0400
X-MC-Unique: 9qhINdNxM-GCPK0shab-Cg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32D14800053;
        Thu, 14 May 2020 15:10:13 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B8F85C1BE;
        Thu, 14 May 2020 15:10:12 +0000 (UTC)
Date:   Thu, 14 May 2020 23:10:09 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH v2] mm, page_alloc: reset the zone->watermark_boost early
Message-ID: <20200514151009.GC4922@MiWiFi-R3L-srv>
References: <1589457511-4255-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589457511-4255-1-git-send-email-charante@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/20 at 05:28pm, Charan Teja Reddy wrote:
> Updating the zone watermarks by any means, like min_free_kbytes,
> water_mark_scale_factor e.t.c, when ->watermark_boost is set will result
> into the higher low and high watermarks than the user asked.
> 
> Below are the steps pursued to reproduce the problem on system setup
> of Android kernel running on Snapdragon hardware.
> 1) Default settings of the system are as below:
>    #cat /proc/sys/vm/min_free_kbytes = 5162
>    #cat /proc/zoneinfo | grep -e boost -e low -e "high " -e min -e Node
> 	Node 0, zone   Normal
> 		min      797
> 		low      8340
> 		high     8539
> 
> 2) Monitor the zone->watermark_boost(by adding a debug print in
> the kernel) and whenever it is greater than zero value, write the
> same value of min_free_kbytes obtained from step 1.
>    #echo 5162 > /proc/sys/vm/min_free_kbytes
> 
> 3) Then read the zone watermarks in the system while the
> ->watermark_boost is zero. This should show the same values of
> watermarks as step 1 but shown a higher values than asked.
>    #cat /proc/zoneinfo | grep -e boost -e low -e "high " -e min -e Node
> 	Node 0, zone   Normal
> 		min      797
> 		low      21148
> 		high     21347
> 
> These higher values are because of updating the zone watermarks using
> the macro min_wmark_pages(zone) which also adds the
> zone->watermark_boost.
> 	#define min_wmark_pages(z) (z->_watermark[WMARK_MIN] +
> 					z->watermark_boost)
> 
> So the steps that lead to the issue is like below:
> 1) On the extfrag event, watermarks are boosted by storing the required
> value in ->watermark_boost.
> 
> 2) User tries to update the zone watermarks level in the system through
> min_free_kbytes or watermark_scale_factor.

> 
> 3) Later, when kswapd woke up, it resets the zone->watermark_boost to
> zero.
> 
> In step 2), we use the min_wmark_pages() macro to store the watermarks
> in the zone structure thus the values are always offsetted by
> ->watermark_boost value. This can be avoided by resetting the
> ->watermark_boost to zero before it is used.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
> 
> v2: Improve the commit message
> 
> v1: (https://patchwork.kernel.org/patch/11540751/)
> 
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cef05d3..d001d61 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7761,9 +7761,9 @@ static void __setup_per_zone_wmarks(void)
>  			    mult_frac(zone_managed_pages(zone),
>  				      watermark_scale_factor, 10000));
>  
> +		zone->watermark_boost = 0;
>  		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
>  		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
> -		zone->watermark_boost = 0;

Yeah, watermark_boost is a temporary value which is used for reclaim,
and will be reset after reclaim finished. Here we should respect the
watermark setting from user.

This fix looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>



>  
>  		spin_unlock_irqrestore(&zone->lock, flags);
>  	}
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 


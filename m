Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D20EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF3C22D3E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlLKpGkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgHGMxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgHGMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWhoxI+xwZ03QCZkTxfCmHgWyAvOMiqULGB6In4p2DU=;
        b=FlLKpGkSRqv8+4+Ko4lfIkdRPnW/KwaP94nmzTe+J5EbjD5sfB0Oo5v9ExXamDPL0wrgM4
        f3EqNfnCIlM6RurfUHTIniAU04VExQIzlQB0buqs8vZl5+I2TdWvzWBuXT2N+2xRqxmWWz
        icf4qAuUs/gnXTrsE718YQ3bqNRKpCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-LCW4CS3DNJCeMDx-LZicVA-1; Fri, 07 Aug 2020 08:53:33 -0400
X-MC-Unique: LCW4CS3DNJCeMDx-LZicVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 861798064AB;
        Fri,  7 Aug 2020 12:53:32 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB1C8380;
        Fri,  7 Aug 2020 12:53:30 +0000 (UTC)
Date:   Fri, 7 Aug 2020 20:53:27 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] mm/hugetlb: use list_splice to merge two list at
 once
Message-ID: <20200807125327.GN14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-4-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-4-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> Instead of add allocated file_region one by one to region_cache, we
> could use list_splice to merge two list at once.
> 
> Also we know the number of entries in the list, increase the number
> directly.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 0a2f3851b828..929256c130f9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -443,11 +443,8 @@ static int allocate_file_region_entries(struct resv_map *resv,
>  
>  		spin_lock(&resv->lock);
>  
> -		list_for_each_entry_safe(rg, trg, &allocated_regions, link) {
> -			list_del(&rg->link);
> -			list_add(&rg->link, &resv->region_cache);
> -			resv->region_cache_count++;
> -		}
> +		list_splice(&allocated_regions, &resv->region_cache);
> +		resv->region_cache_count += to_allocate;

Looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  	}
>  
>  	return 0;
> -- 
> 2.20.1 (Apple Git-117)
> 
> 


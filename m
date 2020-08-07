Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A6320866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJjp/Lu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHGMrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:47:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgHGMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5HNmVJ8V8YqANDRCCq7OAfYAdNsm7pdSjptbXuLNE0k=;
        b=OJjp/Lu8X3Iy9XiLvChyTbGSOb0enmQWW4lisq03DV7CzmpvbqW99nGzyNCHydkEthZ2eG
        PKZa4vBT/vWQysg1ldVu1tBSYX2rWyxIwXkSJxkeFBYa951FJZtq8XKgT5ivVzZSsA+FQ4
        7b+nREbuv6sIGUoHevczwSpYiitZ6gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-1Op-OR8AM2uKyD_-Fdpo6g-1; Fri, 07 Aug 2020 08:47:05 -0400
X-MC-Unique: 1Op-OR8AM2uKyD_-Fdpo6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3DC01800D4A;
        Fri,  7 Aug 2020 12:47:04 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F9426111F;
        Fri,  7 Aug 2020 12:47:03 +0000 (UTC)
Date:   Fri, 7 Aug 2020 20:47:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/hugetlb: not necessary to coalesce regions
 recursively
Message-ID: <20200807124701.GL14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-2-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-2-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> Per my understanding, we keep the regions ordered and would always
> coalesce regions properly. So the task to keep this property is just
> to coalesce its neighbour.
> 
> Let's simplify this.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 590111ea6975..62ec74f6d03f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -307,8 +307,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  		list_del(&rg->link);
>  		kfree(rg);
>  
> -		coalesce_file_region(resv, prg);
> -		return;
> +		rg = prg;
>  	}
>  
>  	nrg = list_next_entry(rg, link);
> @@ -318,9 +317,6 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  
>  		list_del(&rg->link);
>  		kfree(rg);
> -
> -		coalesce_file_region(resv, nrg);

I agree with the change. But this change the original behaviour of
coalesce_file_region, not sure if there's any reason we need to do that,
maybe Mike can give a judgement. Personally,

Reviewed-by: Baoquan He <bhe@redhat.com>

> -		return;
>  	}
>  }
>  
> -- 
> 2.20.1 (Apple Git-117)
> 
> 


Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C70320866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aw66hVFQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgHGMuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:50:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52602 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725792AbgHGMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PFMpCHyvwGa8Ud+s2C9Dt9Z5yJ/jvYtcmcoYAlDhqCc=;
        b=Aw66hVFQX4h25qqtTGv5aa+53FugHT0tozMBbqIiDnnuA/uxcE6/iMO+Pvu6zCHzJuLD3s
        p2tXSUG9q/UBB7armuwhOt8Acz7lsp+NKZUGiZD4FFNyRQgA5BUjnXXva7m07HgK0IUoBc
        3pZE9fWU2HvG1TSrda4MMZgKhZbbF3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-AulHBLTONrOL5hk-Wkzxcw-1; Fri, 07 Aug 2020 08:49:58 -0400
X-MC-Unique: AulHBLTONrOL5hk-Wkzxcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA569800404;
        Fri,  7 Aug 2020 12:49:56 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 547355DA33;
        Fri,  7 Aug 2020 12:49:54 +0000 (UTC)
Date:   Fri, 7 Aug 2020 20:49:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] mm/hugetlb: make sure to get NULL when list is
 empty
Message-ID: <20200807124951.GM14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-3-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-3-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> list_first_entry() may not return NULL even when the list is empty.
> 
> Let's make sure the behavior by using list_first_entry_or_null(),
> otherwise it would corrupt the list.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 62ec74f6d03f..0a2f3851b828 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -237,7 +237,8 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
>  	VM_BUG_ON(resv->region_cache_count <= 0);


We have had above line, is it possible to be NULL from list_first_entry?

>  
>  	resv->region_cache_count--;
> -	nrg = list_first_entry(&resv->region_cache, struct file_region, link);
> +	nrg = list_first_entry_or_null(&resv->region_cache,
> +			struct file_region, link);
>  	VM_BUG_ON(!nrg);
>  	list_del(&nrg->link);
>  
> -- 
> 2.20.1 (Apple Git-117)
> 
> 


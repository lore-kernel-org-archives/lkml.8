Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1787CC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE68920BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 01:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjoHPFos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbgDABjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:39:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37901 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731588AbgDABjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 21:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585705171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpTcpzESNPrH0LZvld1mYi37cP1xR490vGjF7yZ6KoM=;
        b=MjoHPFoseizw/GoQ/LAah+JTMGN12chJCrA/kYcGgGUmeHTyqO077Cup4AbjYa6ai3QttL
        GVf179AnBPVC8Ha7CUEBkbtYWf6WAlfKumlsg+oZaxx1aw4MUt/KO5PghxfW0T3waDJ2tu
        hREl4ZjtltYJxSz0eyHj1gJPpeM+XjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-nTC3C9ADPyeq-Q5O8m01bA-1; Tue, 31 Mar 2020 21:39:27 -0400
X-MC-Unique: nTC3C9ADPyeq-Q5O8m01bA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2303118C8C00;
        Wed,  1 Apr 2020 01:39:26 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63D4460BE1;
        Wed,  1 Apr 2020 01:39:25 +0000 (UTC)
Date:   Wed, 1 Apr 2020 09:39:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: use update_lru_size() in update_lru_sizes()
Message-ID: <20200401013922.GB2129@MiWiFi-R3L-srv>
References: <20200331221550.1011-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331221550.1011-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/20 at 10:15pm, Wei Yang wrote:
> We already defined the helper update_lru_size().
> 
> Let's use this to reduce code duplication.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  mm/vmscan.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f92858e5c2e3..a4fdf3dc8887 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1603,10 +1603,7 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
>  		if (!nr_zone_taken[zid])
>  			continue;
>  
> -		__update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
> -#ifdef CONFIG_MEMCG
> -		mem_cgroup_update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);
> -#endif
> +		update_lru_size(lruvec, lru, zid, -nr_zone_taken[zid]);

A nice clean up.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  	}
>  
>  }
> -- 
> 2.23.0
> 
> 


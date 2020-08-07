Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEDCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7656E20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeEbSjK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHGMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:55:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23753 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgHGMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596804956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LS/ZaYM/wwYTlZosLwIbbs9log8ReAyycGphMRra64=;
        b=OeEbSjK8JQVHZ49wAFnFVgpbkcgQKuyO5ZYu2YuP8q056elF4v47OXNCq9CbmFzbUKvWSG
        TLuOMmHTrFCFaBnP74O6yjZloC0XzN1jiqCfAoEU0A0AyxEZVhR3c/Oh24f2v8wCZmvXd7
        J13gRyK0rFXr0RPpelCB6ard9IRhDn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-NcAF5KR6PDmTZ3XYhVq67g-1; Fri, 07 Aug 2020 08:55:55 -0400
X-MC-Unique: NcAF5KR6PDmTZ3XYhVq67g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DABD8800470;
        Fri,  7 Aug 2020 12:55:53 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EF565DA33;
        Fri,  7 Aug 2020 12:55:52 +0000 (UTC)
Date:   Fri, 7 Aug 2020 20:55:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] mm/hugetlb: remove the redundant check on
 non_swap_entry()
Message-ID: <20200807125550.GP14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-6-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-6-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> Migration and hwpoison entry is a subset of non_swap_entry().
> 
> Remove the redundant check on non_swap_entry().
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Hmm, I have posted one patch to do the same thing, got reivewed by
people.

https://lore.kernel.org/linux-mm/20200723104636.GS32539@MiWiFi-R3L-srv/

> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d775e514eb2e..f5f04e89000d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3778,7 +3778,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
>  	if (huge_pte_none(pte) || pte_present(pte))
>  		return false;
>  	swp = pte_to_swp_entry(pte);
> -	if (non_swap_entry(swp) && is_migration_entry(swp))
> +	if (is_migration_entry(swp))
>  		return true;
>  	else
>  		return false;
> @@ -3791,7 +3791,7 @@ static int is_hugetlb_entry_hwpoisoned(pte_t pte)
>  	if (huge_pte_none(pte) || pte_present(pte))
>  		return 0;
>  	swp = pte_to_swp_entry(pte);
> -	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
> +	if (is_hwpoison_entry(swp))
>  		return 1;
>  	else
>  		return 0;
> -- 
> 2.20.1 (Apple Git-117)
> 
> 


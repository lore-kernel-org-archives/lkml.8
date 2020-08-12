Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D81CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638DF20771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVRkze2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgHLFkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 01:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgHLFkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 01:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597210843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjQCImwrKKAQU3JlwtdjkqTIDAo/dvR77KpYtYakGUs=;
        b=MVRkze2iQR/FBTpy53Oam6KzZ5sZXt3QQLUh6X2Gkxk4qr6wEB0npFYpExiD8Rl4Ig30bk
        3yvzz2GThxRL7bV+Jot6K6R/NXnZd6lpvwTClgnU6HU0w/3Uv8uKYv0GTER/7Knska8QDD
        hxBnZnTdw9rK0wsn4AkVjx5Gkbb8IWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-ejtbnAT5P5yGMymPcfsSEg-1; Wed, 12 Aug 2020 01:40:41 -0400
X-MC-Unique: ejtbnAT5P5yGMymPcfsSEg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 302A61005504;
        Wed, 12 Aug 2020 05:40:40 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 377D360C84;
        Wed, 12 Aug 2020 05:40:37 +0000 (UTC)
Date:   Wed, 12 Aug 2020 13:40:35 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200812054035.GD10792@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
 <20200810021737.GV14854@MiWiFi-R3L-srv>
 <129cc03e-c6d5-24f8-2f3c-f5a3cc821e76@oracle.com>
 <20200811015148.GA10792@MiWiFi-R3L-srv>
 <20200811065406.GC4793@dhcp22.suse.cz>
 <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9d1e13-7455-0c4e-1f94-0c859c36c0bb@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/20 at 02:43pm, Mike Kravetz wrote:
> Here is a patch to do that.  However, we are optimizing a return path in
> a race condition that we are unlikely to ever hit.  I 'tested' it by allocating
> an 'extra' page and freeing it via this method in alloc_surplus_huge_page.
> 
> From 864c5f8ef4900c95ca3f6f2363a85f3cb25e793e Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Tue, 11 Aug 2020 12:45:41 -0700
> Subject: [PATCH] hugetlb: optimize race error return in
>  alloc_surplus_huge_page
> 
> The routine alloc_surplus_huge_page() could race with with a pool
> size change.  If this happens, the allocated page may not be needed.
> To free the page, the current code will 'Abuse temporary page to
> workaround the nasty free_huge_page codeflow'.  Instead, directly
> call the low level routine that free_huge_page uses.  This works
> out well because the page is new, we hold the only reference and
> already hold the hugetlb_lock.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 590111ea6975..ac89b91fba86 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1923,14 +1923,17 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	/*
>  	 * We could have raced with the pool size change.
>  	 * Double check that and simply deallocate the new page
> -	 * if we would end up overcommiting the surpluses. Abuse
> -	 * temporary page to workaround the nasty free_huge_page
> -	 * codeflow
> +	 * if we would end up overcommiting the surpluses.
>  	 */
>  	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> -		SetPageHugeTemporary(page);
> +		/*
> +		 * Since this page is new, we hold the only reference, and
> +		 * we already hold the hugetlb_lock call the low level free
> +		 * page routine.  This saves at least a lock roundtrip.
> +		 */
> +		(void)put_page_testzero(page); /* don't call destructor */
> +		update_and_free_page(h, page);

Yeah, taking this code change, or keeping the temporary page way as is,
both looks good.

>  		spin_unlock(&hugetlb_lock);
> -		put_page(page);
>  		return NULL;
>  	} else {
>  		h->surplus_huge_pages++;


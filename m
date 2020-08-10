Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27ECC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD64B20709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsqQJx/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHJCRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:17:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52743 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgHJCRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597025868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2MnT5kb+LpTU4V51q+u3lkSdfkwWI/8ULUd0tphg34=;
        b=gsqQJx/s0+FYTig0nF6q4YeYaTSSsNzLsnFm57i7SDxK7IZoOkQ8DMOU1KysJFGREkQS2b
        y39KHC/d/8FcGkbRg74VDAEEi+fzz6QGBVMiwFHD/BOtlYSI/ltcKgnB0FBtzb8kzGj2ww
        jGOL4H7s7ZVkf8+3q1PjQeCgcDVgJyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-ZRZezdKVMHCGu7w2amQERw-1; Sun, 09 Aug 2020 22:17:45 -0400
X-MC-Unique: ZRZezdKVMHCGu7w2amQERw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1EF1800404;
        Mon, 10 Aug 2020 02:17:43 +0000 (UTC)
Received: from localhost (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 438345F1E4;
        Mon, 10 Aug 2020 02:17:40 +0000 (UTC)
Date:   Mon, 10 Aug 2020 10:17:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>, mhocko@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm/hugetlb: not necessary to abuse temporary page
 to workaround the nasty free_huge_page
Message-ID: <20200810021737.GV14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-11-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> Let's always increase surplus_huge_pages and so that free_huge_page
> could decrease it at free time.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f2010c9dd8d..a0eb81e0e4c5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1913,21 +1913,19 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  		return NULL;
>  
>  	spin_lock(&hugetlb_lock);
> +
> +	h->surplus_huge_pages++;
> +	h->surplus_huge_pages_node[page_to_nid(page)]++;
> +
>  	/*
>  	 * We could have raced with the pool size change.
>  	 * Double check that and simply deallocate the new page
> -	 * if we would end up overcommiting the surpluses. Abuse
> -	 * temporary page to workaround the nasty free_huge_page
> -	 * codeflow
> +	 * if we would end up overcommiting the surpluses.
>  	 */
> -	if (h->surplus_huge_pages >= h->nr_overcommit_huge_pages) {
> -		SetPageHugeTemporary(page);

Hmm, the temporary page way is taken intentionally in
commit 9980d744a0428 ("mm, hugetlb: get rid of surplus page accounting tricks").
From code, this is done inside hugetlb_lock holding, and the code flow
is straightforward, should be safe. Adding Michal to CC.


> +	if (h->surplus_huge_pages > h->nr_overcommit_huge_pages) {
>  		spin_unlock(&hugetlb_lock);
>  		put_page(page);
>  		return NULL;
> -	} else {
> -		h->surplus_huge_pages++;
> -		h->surplus_huge_pages_node[page_to_nid(page)]++;
>  	}
>  
>  out_unlock:
> -- 
> 2.20.1 (Apple Git-117)
> 
> 


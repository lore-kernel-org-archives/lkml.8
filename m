Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6174FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1DD22D2C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SD0Ka1A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHGNMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:12:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48189 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgHGNMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596805934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWWhix4iLlIv8Eh/yS1VGX8cFoAQVQWfFsfEg6TWH78=;
        b=SD0Ka1A7eTMYXG37mdA2sQY+TXK66XS96FoTYjDKzrpkQ3sS0G4lqKMY3jUrhwBXkQj2Hr
        pmsDnwp16SaLiApNiZpceGWOiueHtzu9SAPX1owAWnd1HVAWSt/QLzA5589Htx0d6ztOGo
        fAKS4cqIBdbhNpm3mVXd07dvlyBwx68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-KLTXhLBmMg283fbQYZRAHA-1; Fri, 07 Aug 2020 09:12:12 -0400
X-MC-Unique: KLTXhLBmMg283fbQYZRAHA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 609381800D4A;
        Fri,  7 Aug 2020 13:12:11 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEAD81DB;
        Fri,  7 Aug 2020 13:12:10 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:12:08 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] mm/hugetlb: narrow the hugetlb_lock protection
 area during preparing huge page
Message-ID: <20200807131208.GT14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-10-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-10-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> set_hugetlb_cgroup_[rsvd] just manipulate page local data, which is not
> necessary to be protected by hugetlb_lock.
> 
> Let's take this out.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 9473eb6800e9..1f2010c9dd8d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1494,9 +1494,9 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  {
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> -	spin_lock(&hugetlb_lock);
>  	set_hugetlb_cgroup(page, NULL);
>  	set_hugetlb_cgroup_rsvd(page, NULL);
> +	spin_lock(&hugetlb_lock);

Looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
>  	spin_unlock(&hugetlb_lock);
> -- 
> 2.20.1 (Apple Git-117)
> 
> 


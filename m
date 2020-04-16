Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B20CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B330206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587005929;
	bh=rQigxixSDs+dCK5RAkj+qC1sYZkMkckPug+3KMi9k5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KIn+RJ/Sh7EXX98KgW752o5TIICC4ZjWhRA3IC8nwcQZ9pkvNTdnHGDZoQPHQaLDt
	 iLGTj+JiajhrJbOeb7Si/clinVfpVvepcjZixrj+bMNEhkCd4o4bUMSMjrQlIXslkk
	 l2NXu7vUzpFVFZYaWOn1ML1pknZCZvkIgJP0A/RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbgDPC6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbgDPC6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:58:43 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F437206F9;
        Thu, 16 Apr 2020 02:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587005922;
        bh=rQigxixSDs+dCK5RAkj+qC1sYZkMkckPug+3KMi9k5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VTCGhOdWESWZMgOFOGaBWb3FHZxCpiNo9+5o5kxwbGkx+eBkDICfzwW6Iug+9iS5u
         yGiF0lXPMvcgVRAMXp70oDXjoMNZD2GK59tSbCfdnR/lgqPZZqrtbDwkgob0Kqa+Te
         xdp/WemLu7/GJ0Oef8yiRYhLk/Lm+pY0fgC89Wyc=
Date:   Wed, 15 Apr 2020 19:58:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Markus.Elfring@web.de, david@redhat.com, ktkhai@virtuozzo.com,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v4] mm/ksm: Fix NULL pointer dereference when KSM zero
 page is enabled
Message-Id: <20200415195841.da4361916f662a0136a271a5@linux-foundation.org>
In-Reply-To: <20200416025034.29780-1-songmuchun@bytedance.com>
References: <20200416025034.29780-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 10:50:34 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The find_mergeable_vma can return NULL. In this case, it leads
> to a crash when we access vm_mm(its offset is 0x40) later in
> write_protect_page. And this case did happen on our server. The
> following call trace is captured in kernel 4.19 with the following
> patch applied and KSM zero page enabled on our server.
> 
>   commit e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")
> 
> So add a vma check to fix it.
>
> ...
>
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2112,8 +2112,15 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)
> 
>  		down_read(&mm->mmap_sem);
>  		vma = find_mergeable_vma(mm, rmap_item->address);
> -		err = try_to_merge_one_page(vma, page,
> -					    ZERO_PAGE(rmap_item->address));
> +		if (vma)
> +			err = try_to_merge_one_page(vma, page,
> +					ZERO_PAGE(rmap_item->address));
> +		else
> +			/**
> +			 * If the vma is out of date, we do not need to
> +			 * continue.
> +			 */
> +			err = 0;
>  		up_read(&mm->mmap_sem);
>  		/*
>  		 * In case of failure, the page was not really empty, so we

Thanks.

It's conventional to put braces around multi-line blocks such as this.

Also, /** is specifically used to introduce kerneldoc comments.  This
comment is not a kerneldoc one so use /*.

--- a/mm/ksm.c~mm-ksm-fix-null-pointer-dereference-when-ksm-zero-page-is-enabled-v4-fix
+++ a/mm/ksm.c
@@ -2112,15 +2112,16 @@ static void cmp_and_merge_page(struct pa
 
 		down_read(&mm->mmap_sem);
 		vma = find_mergeable_vma(mm, rmap_item->address);
-		if (vma)
+		if (vma) {
 			err = try_to_merge_one_page(vma, page,
 					ZERO_PAGE(rmap_item->address));
-		else
-			/**
+		} else {
+			/*
 			 * If the vma is out of date, we do not need to
 			 * continue.
 			 */
 			err = 0;
+		}
 		up_read(&mm->mmap_sem);
 		/*
 		 * In case of failure, the page was not really empty, so we
_


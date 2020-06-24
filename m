Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231E120823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593024805;
	bh=HKslfhNl7tpZaCgmctNjhn1V/l+XNf4uwEwavirR290=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SQgLTxNbKpN8D3a9JliMOicXWxaL3i8oDuUgQEVYqQZZ5B+h5i3eD2bu+SI+1UPHh
	 9IW5DVmwZR+Qi99BlOf1td1QMfwS7u57E/Nzp0ZZmQZZU1zDVLxd/7cWW4Ni3rbefS
	 TaZcS86bDrKZV93drWRivn8gXiflvjhxKQTPaXfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406174AbgFXSxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406139AbgFXSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:53:19 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FA520823;
        Wed, 24 Jun 2020 18:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593024798;
        bh=HKslfhNl7tpZaCgmctNjhn1V/l+XNf4uwEwavirR290=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HlnPOjetBcFqHdrq8LMZASzOmK8BPv6UmpdDbgMfkmZtg+ksWMcnQ5XEcWc7fnBRG
         bt/Qk+sTWwmhAjgam/0aNcgNVhbN7y2g8QIUyqCK2AHUu/Xel7zJ5oPEexSEc/9hpY
         WbHIcirhJNSFY2E02EGTcBZl2CyWIC39PCD6y3f0=
Date:   Wed, 24 Jun 2020 11:53:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, riel@surriel.com, shakeelb@google.com,
        gavin.dg@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: filemap: clear idle flag for writes
Message-Id: <20200624115317.792d8fc6369d421d2898ab2f@linux-foundation.org>
In-Reply-To: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1593020612-13051-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 01:43:32 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Since commit bbddabe2e436aa7869b3ac5248df5c14ddde0cbf ("mm: filemap:
> only do access activations on reads"), mark_page_accessed() is called
> for reads only.  But the idle flag is cleared by mark_page_accessed() so
> the idle flag won't get cleared if the page is write accessed only.
> 
> Basically idle page tracking is used to estimate workingset size of
> workload, noticeable size of workingset might be missed if the idle flag
> is not maintained correctly.
> 
> It seems good enough to just clear idle flag for write operations.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -41,6 +41,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/psi.h>
>  #include <linux/ramfs.h>
> +#include <linux/page_idle.h>
>  #include "internal.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -1630,6 +1631,11 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>  
>  	if (fgp_flags & FGP_ACCESSED)
>  		mark_page_accessed(page);
> +	else if (fgp_flags & FGP_WRITE) {
> +		/* Clear idle flag for buffer write */
> +		if (page_is_idle(page))
> +			clear_page_idle(page);
> +	}
>  
>  no_page:
>  	if (!page && (fgp_flags & FGP_CREAT)) {

The kerneldoc comment for pagecache_get_page() could do with some
updating - it fails to mention FGP_WRITE, FGP_NOFS and FGP_NOWAIT.

This change seems correct but also will have runtime effects.  What are
they?

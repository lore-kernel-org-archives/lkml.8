Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77658C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FEA2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lqGKXtlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbgGaCjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgGaCjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:39:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 19:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VZM0Jaz0r8Nd0WXkw0o7x3RyZS062vROpdAGgxL4yX0=; b=lqGKXtlLZL9Y5ZCpxbnFOKMh83
        zJdet99OP7eKANoCiZ4zmyhhsP5kiplyQ0gXQPp85CDydeARf+ehuMFOUEpGPEDqixufs+ZnUELoD
        mn+HZv5/Q2YK1vEzctbu4yPtplOTB6imZ48Ms2zk+hsFZsv5XI9FMxZgn/US4/Vxw1x0FCKhLAvwt
        X584x13Sw8d6k4RrmjH+vqOdPcjVj0v8BdaN0f26LP1j3B+gpTPUIRV8RdLX3dyGGPjanXV/KZLhj
        0h0glCo/PGuuP8ix0KMLsmHmg56qLrbEv9fYFB0SkhsFxlxOAlJrzg4DPbd0Wc1nOEJqtTgAFBvZ5
        1zhfBB8A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Kwk-0002qf-4p; Fri, 31 Jul 2020 02:38:58 +0000
Date:   Fri, 31 Jul 2020 03:38:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     qiang.zhang@windriver.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/dmapool.c: add WARN_ON() in dma_pool_destroy
Message-ID: <20200731023858.GO23808@casper.infradead.org>
References: <20200731023939.19206-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731023939.19206-1-qiang.zhang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:39:39AM +0800, qiang.zhang@windriver.com wrote:
> The pool is being destroyed, all page which in the pool,
> should be free. if some page is still be use by somebody,
> we should not just output error logs, also should also add
> a warning message.

There's already a warning message.  What value does this actually have?

> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
> ---
>  mm/dmapool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index f9fb9bbd733e..8f4dc53dde5b 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -285,7 +285,7 @@ void dma_pool_destroy(struct dma_pool *pool)
>  		struct dma_page *page;
>  		page = list_entry(pool->page_list.next,
>  				  struct dma_page, page_list);
> -		if (is_page_busy(page)) {
> +		if (WARN_ON(is_page_busy(page))) {
>  			if (pool->dev)
>  				dev_err(pool->dev,
>  					"dma_pool_destroy %s, %p busy\n",
> -- 
> 2.26.2
> 

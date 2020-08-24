Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44833C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B5A20897
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296731;
	bh=ruAaLHXCUgvFAIHtl74jpOBw0Y8uv95WYxQPoUYU1cY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qRbg120iZc5BE+AEIuefiscyrGrL0TiTupDzPcfcIhkZN8Xjrm5uS4QiV2/X2huxT
	 nOgZGW4x2vmJTqHCCIALQdUeL3t+a80yeNziyP4YA05KP+CtvmfQkrq2Z8hJ8dgIYv
	 Yc9lKJn7vHCU/Exg+VAt35nDwIle1bAnBzSj03Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHXTSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgHXTSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:18:41 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AC120578;
        Mon, 24 Aug 2020 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296721;
        bh=ruAaLHXCUgvFAIHtl74jpOBw0Y8uv95WYxQPoUYU1cY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NedftIdrJSSiWqFW1zJ5dFmP61Pu/QmDrouLYmttdGPY33KM++6Saxqxq+SmyfGfN
         Qh64t3Q9lqnThGaAwsG1e0Jkjk86fDm6q0F0h4UOyEcyWd0zGGFzg9U9foXOGdeXjP
         DJURi9DXi/CdIz1nILadUy+sbGVFU+bu6aoUF0Fo=
Date:   Mon, 24 Aug 2020 12:18:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/mempool: Add 'else' to split mutually exclusive case
Message-Id: <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
In-Reply-To: <20200824115354.7879-1-linmiaohe@huawei.com>
References: <20200824115354.7879-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 07:53:54 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Add else to split mutually exclusive case and avoid some unnecessary check.
> 
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -60,9 +60,8 @@ static void check_element(mempool_t *pool, void *element)
>  	/* Mempools backed by slab allocator */
>  	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
>  		__check_element(pool, element, ksize(element));
> -
>  	/* Mempools backed by page allocator */
> -	if (pool->free == mempool_free_pages) {
> +	else if (pool->free == mempool_free_pages) {
>  		int order = (int)(long)pool->pool_data;
>  		void *addr = kmap_atomic((struct page *)element);
>  

It doesn't seem to change code generation (compiler is smart), but I
think it helps readability.


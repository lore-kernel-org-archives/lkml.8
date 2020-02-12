Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BEC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992A721569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581547971;
	bh=czm5xq+x3zJ0qiiciKQ7bQR74vUISbw6BSBaEMWk+v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s4dLhiB/tWArYtoKp5cQgM383TvaBrC5JRZptcyfzIMBPHTJGLyUHwB5tasLKy0TP
	 Foo0knSw0IvY+AZqb3rifBKHSNctX8hHVFvZ1u3vgxidedhU+57k8wZJHF/RO3+vfo
	 Fbmi0G/DA+HY58wy1j5Mi9M+221hfUBlqx1IHZm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgBLWwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgBLWwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:52:50 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD0F21569;
        Wed, 12 Feb 2020 22:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581547968;
        bh=czm5xq+x3zJ0qiiciKQ7bQR74vUISbw6BSBaEMWk+v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zuNm1oa0KqzLmGecolzIK96Aen9gbLKh539V852DcgfooBlUqDHM8Dh1WhGN+RCPc
         4EJ8rxzhQiP7/9z5DXF9mrG7La8PdWlR8B7b9wdPi+4o3G3lHbzCHXms0sBjRzMwyE
         53NBNngLXNx2L9ebFt9dI1YLuLNOQIInbDyUkTtc=
Date:   Wed, 12 Feb 2020 14:52:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
Message-Id: <20200212145247.bf89431272038de53dd9d975@linux-foundation.org>
In-Reply-To: <20200201031502.92218-1-wenyang@linux.alibaba.com>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Feb 2020 11:15:02 +0800 Wen Yang <wenyang@linux.alibaba.com> wrote:

> The lock, protecting the node partial list, is taken when couting the free
> objects resident in that list. It introduces locking contention when the
> page(s) is moved between CPU and node partial lists in allocation path
> on another CPU. So reading "/proc/slabinfo" can possibily block the slab
> allocation on another CPU for a while, 200ms in extreme cases. If the
> slab object is to carry network packet, targeting the far-end disk array,
> it causes block IO jitter issue.
> 
> This fixes the block IO jitter issue by caching the total inuse objects in
> the node in advance. The value is retrieved without taking the node partial
> list lock on reading "/proc/slabinfo".
> 
> ...
>
> @@ -1768,7 +1774,9 @@ static void free_slab(struct kmem_cache *s, struct page *page)
>  
>  static void discard_slab(struct kmem_cache *s, struct page *page)
>  {
> -	dec_slabs_node(s, page_to_nid(page), page->objects);
> +	int inuse = page->objects;
> +
> +	dec_slabs_node(s, page_to_nid(page), page->objects, inuse);

Is this right?  dec_slabs_node(..., page->objects, page->objects)?

If no, we could simply pass the page* to inc_slabs_node/dec_slabs_node
and save a function argument.

If yes then why?

>  	free_slab(s, page);
>  }
>  


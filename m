Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FEE2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgHQJUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:20:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9822 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbgHQJUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:20:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FC7371CC3DB3C292129;
        Mon, 17 Aug 2020 17:19:58 +0800 (CST)
Received: from [10.174.179.61] (10.174.179.61) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 17:19:54 +0800
Subject: Re: [PATCH] mm/slub: make add_full() condition more explicit
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <liu.xiang6@zte.com.cn>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200811020240.1231-1-wuyun.wu@huawei.com>
From:   Abel Wu <wuyun.wu@huawei.com>
Message-ID: <40c24455-02fd-4b4c-7740-bb7d2af0f5c7@huawei.com>
Date:   Mon, 17 Aug 2020 17:19:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <20200811020240.1231-1-wuyun.wu@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping :)

On 2020/8/11 10:02, wuyun.wu@huawei.com wrote:
> From: Abel Wu <wuyun.wu@huawei.com>
> 
> The commit below is incomplete, as it didn't handle the add_full() part.
> commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")
> 
> This patch checks for SLAB_STORE_USER instead of kmem_cache_debug(),
> since that should be the only context in which we need the list_lock for
> add_full().
> 
> Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f226d66408ee..df93a5a0e9a4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2182,7 +2182,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>  		}
>  	} else {
>  		m = M_FULL;
> -		if (kmem_cache_debug(s) && !lock) {
> +#ifdef CONFIG_SLUB_DEBUG
> +		if ((s->flags & SLAB_STORE_USER) && !lock) {
>  			lock = 1;
>  			/*
>  			 * This also ensures that the scanning of full
> @@ -2191,6 +2192,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>  			 */
>  			spin_lock(&n->list_lock);
>  		}
> +#endif
>  	}
>  
>  	if (l != m) {
> 

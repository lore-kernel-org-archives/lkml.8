Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A426C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F512082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQKnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgFQKnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A349FAAE8;
        Wed, 17 Jun 2020 10:43:52 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Use kmem_cache_zalloc() instead of
 kmem_cache_alloc() with flag GFP_ZERO.
To:     Yi Wang <wang.yi59@zte.com.cn>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
References: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <41628185-039e-6cb2-b615-dd5e8af338e7@suse.cz>
Date:   Wed, 17 Jun 2020 12:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 9:15 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Use kmem_cache_zalloc instead of manually calling kmem_cache_alloc
> with flag GFP_ZERO.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6d45488..1fa62d9 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -656,7 +656,7 @@ extern void *__kmalloc_node_track_caller(size_t, gfp_t, int, unsigned long);
>   */
>  static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
>  {
> -	return kmem_cache_alloc(k, flags | __GFP_ZERO);
> +	return kmem_cache_zalloc(k, flags);

Did you test this patch?

>  }
>  
>  /**
> 


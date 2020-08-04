Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2ADB208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgHDRSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:18:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbgHDRSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:18:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B5F6AE3A;
        Tue,  4 Aug 2020 17:19:06 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] slab: Add naive detection of double free
To:     Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org
Cc:     Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200625215548.389774-1-keescook@chromium.org>
 <20200625215548.389774-3-keescook@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c4424700-3502-90d1-b73a-2d5b6f7256c8@suse.cz>
Date:   Tue, 4 Aug 2020 19:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200625215548.389774-3-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/20 11:55 PM, Kees Cook wrote:
> Similar to commit ce6fa91b9363 ("mm/slub.c: add a naive detection
> of double free or corruption"), add a very cheap double-free check
> for SLAB under CONFIG_SLAB_FREELIST_HARDENED. With this added, the
> "SLAB_FREE_DOUBLE" LKDTM test passes under SLAB:
> 
>   lkdtm: Performing direct entry SLAB_FREE_DOUBLE
>   lkdtm: Attempting double slab free ...
>   ------------[ cut here ]------------
>   WARNING: CPU: 2 PID: 2193 at mm/slab.c:757 ___cache _free+0x325/0x390
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

No idea how much it helps in practice wrt security, but implementation-wise it
seems fine, so:

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Maybe you don't want to warn just once, though? We had similar discussion on
cache_to_obj().

> ---
>  mm/slab.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index ebac5e400ad0..bbff6705ab2b 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -749,6 +749,16 @@ static void drain_alien_cache(struct kmem_cache *cachep,
>  	}
>  }
>  
> +/* &alien->lock must be held by alien callers. */
> +static __always_inline void __free_one(struct array_cache *ac, void *objp)
> +{
> +	/* Avoid trivial double-free. */
> +	if (IS_ENABLED(CONFIG_SLAB_FREELIST_HARDENED) &&
> +	    WARN_ON_ONCE(ac->avail > 0 && ac->entry[ac->avail - 1] == objp))
> +		return;
> +	ac->entry[ac->avail++] = objp;
> +}
> +
>  static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
>  				int node, int page_node)
>  {
> @@ -767,7 +777,7 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
>  			STATS_INC_ACOVERFLOW(cachep);
>  			__drain_alien_cache(cachep, ac, page_node, &list);
>  		}
> -		ac->entry[ac->avail++] = objp;
> +		__free_one(ac, objp);
>  		spin_unlock(&alien->lock);
>  		slabs_destroy(cachep, &list);
>  	} else {
> @@ -3457,7 +3467,7 @@ void ___cache_free(struct kmem_cache *cachep, void *objp,
>  		}
>  	}
>  
> -	ac->entry[ac->avail++] = objp;
> +	__free_one(ac, objp);
>  }
>  
>  /**
> 


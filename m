Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA9DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0598208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgHDRPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:15:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:58736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgHDRPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BBA3AE3A;
        Tue,  4 Aug 2020 17:15:58 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to
 include SLAB
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
 <20200625215548.389774-2-keescook@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f1e30aa8-f8ca-5cf9-e71e-83cc26516666@suse.cz>
Date:   Tue, 4 Aug 2020 19:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200625215548.389774-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/20 11:55 PM, Kees Cook wrote:
> Include SLAB caches when performing kmem_cache pointer verification. A
> defense against such corruption[1] should be applied to all the
> allocators. With this added, the "SLAB_FREE_CROSS" and "SLAB_FREE_PAGE"
> LKDTM tests now pass on SLAB:
> 
>   lkdtm: Performing direct entry SLAB_FREE_CROSS
>   lkdtm: Attempting cross-cache slab free ...
>   ------------[ cut here ]------------
>   cache_from_obj: Wrong slab cache. lkdtm-heap-b but object is from lkdtm-heap-a
>   WARNING: CPU: 2 PID: 2195 at mm/slab.h:530 kmem_cache_free+0x8d/0x1d0
>   ...
>   lkdtm: Performing direct entry SLAB_FREE_PAGE
>   lkdtm: Attempting non-Slab slab free ...
>   ------------[ cut here ]------------
>   virt_to_cache: Object is not a Slab page!
>   WARNING: CPU: 1 PID: 2202 at mm/slab.h:489 kmem_cache_free+0x196/0x1d0
> 
> Additionally clean up neighboring Kconfig entries for clarity,
> readability, and redundant option removal.
> 
> [1] https://github.com/ThomasKing2014/slides/raw/master/Building%20universal%20Android%20rooting%20with%20a%20type%20confusion%20vulnerability.pdf
> 
> Fixes: 598a0717a816 ("mm/slab: validate cache membership under freelist hardening")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  init/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index a46aa8f3174d..7542d28c6f61 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1885,9 +1885,8 @@ config SLAB_MERGE_DEFAULT
>  	  command line.
>  
>  config SLAB_FREELIST_RANDOM
> -	default n
> +	bool "Randomize slab freelist"
>  	depends on SLAB || SLUB
> -	bool "SLAB freelist randomization"
>  	help
>  	  Randomizes the freelist order used on creating new pages. This
>  	  security feature reduces the predictability of the kernel slab
> @@ -1895,12 +1894,14 @@ config SLAB_FREELIST_RANDOM
>  
>  config SLAB_FREELIST_HARDENED
>  	bool "Harden slab freelist metadata"
> -	depends on SLUB
> +	depends on SLAB || SLUB
>  	help
>  	  Many kernel heap attacks try to target slab cache metadata and
>  	  other infrastructure. This options makes minor performance
>  	  sacrifices to harden the kernel slab allocator against common
> -	  freelist exploit methods.
> +	  freelist exploit methods. Some slab implementations have more
> +	  sanity-checking than others. This option is most effective with
> +	  CONFIG_SLUB.
>  
>  config SHUFFLE_PAGE_ALLOCATOR
>  	bool "Page allocator randomization"
> 


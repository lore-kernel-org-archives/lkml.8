Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA77C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF6C20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hujs8iqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbgHOWFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbgHOVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84478C0A3BFB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:52:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v5so3341250plo.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DkuPBAVHx3cth8w3eFKEZSaG/hl3FQz11+r5yt96mWw=;
        b=hujs8iqhV27fN/CbCBhJeKz2ue7hEwtKiiwN0eTc437DIYzVtNVIHUja64EkFieIDT
         h4mrY7eu3rHnbu4msD4vlw0B0DCzONvQ5WTNXlhZQGlrC9ZO5/ZBGRa7v3devOEqLfB9
         x7XRU86YvvU2+/xQYWQ4JkGUkVPdPcRwvZIJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkuPBAVHx3cth8w3eFKEZSaG/hl3FQz11+r5yt96mWw=;
        b=O4v3HMYn8DHNeWUlBp7Cr/5ypCn3W15sbYG8CHX+3QfqzKE3XqGM9Rn0GrKf8Qu9so
         rZOlxuYtgBXHDtkm1RM2tX1YzO8Ncf+Gk07xzw7ZSvSrM25xutk2viCSHwV9EU8fcEls
         fDdaLZm1wwPmt/oyG399YI7CiDjNv1UwTiWDqx4VUQqk06DgmuKMxOEesD1eeX8fKT+p
         ckWuCB4a+ZCOucWZw9fHSUhQU6d9JhZugbt5Ff+oYUhGct0ySssCg3baQD7qAjcHSQjd
         BAQpS+t8/wVnD1DzAbkLPnEmUAmMl7akXwI1U/7sLzB8vtQ186NaK+lCTZIN857ZZ8Mj
         /uXQ==
X-Gm-Message-State: AOAM532Lqj7o5F8QDUuhAV5MeWFrHnchPkafdCrmKmIwVyqcbirMZLz7
        FdSOC4+AFxcn+wJfcSghkGMKgQ==
X-Google-Smtp-Source: ABdhPJyie9OB9WSJsHACzDZMnYAByIlBFZmAlw11F8duCnj7WyCCvneQAPtXFV6MZDmr5Yw9TQvRGg==
X-Received: by 2002:a17:90a:1749:: with SMTP id 9mr6560678pjm.127.1597510351412;
        Sat, 15 Aug 2020 09:52:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm12732251pfu.2.2020.08.15.09.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:52:30 -0700 (PDT)
Date:   Sat, 15 Aug 2020 09:52:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        notify@kernel.org
Subject: Re: [PATCH RFC 1/2] mm: Extract SLAB_QUARANTINE from KASAN
Message-ID: <202008150939.A994680@keescook>
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-2-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813151922.1093791-2-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:19:21PM +0300, Alexander Popov wrote:
> Heap spraying is an exploitation technique that aims to put controlled
> bytes at a predetermined memory location on the heap. Heap spraying for
> exploiting use-after-free in the Linux kernel relies on the fact that on
> kmalloc(), the slab allocator returns the address of the memory that was
> recently freed. Allocating a kernel object with the same size and
> controlled contents allows overwriting the vulnerable freed object.
> 
> Let's extract slab freelist quarantine from KASAN functionality and
> call it CONFIG_SLAB_QUARANTINE. This feature breaks widespread heap
> spraying technique used for exploiting use-after-free vulnerabilities
> in the kernel code.
> 
> If this feature is enabled, freed allocations are stored in the quarantine
> and can't be instantly reallocated and overwritten by the exploit
> performing heap spraying.

It may be worth clarifying that this is specifically only direct UAF and
doesn't help with spray-and-overflow-into-a-neighboring-object attacks
(i.e. both tend to use sprays, but the former doesn't depend on a write
overflow).

> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  include/linux/kasan.h      | 107 ++++++++++++++++++++-----------------
>  include/linux/slab_def.h   |   2 +-
>  include/linux/slub_def.h   |   2 +-
>  init/Kconfig               |  11 ++++
>  mm/Makefile                |   3 +-
>  mm/kasan/Makefile          |   2 +
>  mm/kasan/kasan.h           |  75 +++++++++++++-------------
>  mm/kasan/quarantine.c      |   2 +
>  mm/kasan/slab_quarantine.c |  99 ++++++++++++++++++++++++++++++++++
>  mm/slub.c                  |   2 +-
>  10 files changed, 216 insertions(+), 89 deletions(-)
>  create mode 100644 mm/kasan/slab_quarantine.c
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 087fba34b209..b837216f760c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -42,32 +42,14 @@ void kasan_unpoison_task_stack(struct task_struct *task);
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
>  
> -void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> -			slab_flags_t *flags);
> -
>  void kasan_poison_slab(struct page *page);
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object);
>  void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  					const void *object);
>  
> -void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
> -						gfp_t flags);
>  void kasan_kfree_large(void *ptr, unsigned long ip);
>  void kasan_poison_kfree(void *ptr, unsigned long ip);
> -void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
> -					size_t size, gfp_t flags);
> -void * __must_check kasan_krealloc(const void *object, size_t new_size,
> -					gfp_t flags);
> -
> -void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
> -					gfp_t flags);
> -bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> -
> -struct kasan_cache {
> -	int alloc_meta_offset;
> -	int free_meta_offset;
> -};
>  
>  /*
>   * These functions provide a special case to support backing module
> @@ -107,10 +89,6 @@ static inline void kasan_disable_current(void) {}
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>  
> -static inline void kasan_cache_create(struct kmem_cache *cache,
> -				      unsigned int *size,
> -				      slab_flags_t *flags) {}
> -
>  static inline void kasan_poison_slab(struct page *page) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>  					void *object) {}
> @@ -122,17 +100,65 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>  	return (void *)object;
>  }
>  
> +static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> +static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> +static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> +static inline void kasan_remove_zero_shadow(void *start, unsigned long size) {}
> +static inline void kasan_unpoison_slab(const void *ptr) {}
> +
> +static inline int kasan_module_alloc(void *addr, size_t size)
> +{
> +	return 0;
> +}
> +
> +static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> +{
> +	return 0;
> +}
> +
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_KASAN */
> +
> +struct kasan_cache {
> +	int alloc_meta_offset;
> +	int free_meta_offset;
> +};
> +
> +#if defined(CONFIG_KASAN) || defined(CONFIG_SLAB_QUARANTINE)
> +
> +void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +			slab_flags_t *flags);
> +void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
> +						gfp_t flags);
> +void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
> +					size_t size, gfp_t flags);
> +void * __must_check kasan_krealloc(const void *object, size_t new_size,
> +					gfp_t flags);
> +void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
> +					gfp_t flags);
> +bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +
> +#else /* CONFIG_KASAN || CONFIG_SLAB_QUARANTINE */
> +
> +static inline void kasan_cache_create(struct kmem_cache *cache,
> +				      unsigned int *size,
> +				      slab_flags_t *flags) {}
> +
>  static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
>  {
>  	return ptr;
>  }
> -static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> +
>  static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
>  				size_t size, gfp_t flags)
>  {
>  	return (void *)object;
>  }
> +
>  static inline void *kasan_krealloc(const void *object, size_t new_size,
>  				 gfp_t flags)
>  {
> @@ -144,43 +170,28 @@ static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>  {
>  	return object;
>  }
> +
>  static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  				   unsigned long ip)
>  {
>  	return false;
>  }
> -
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
> -static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> -
> -static inline int kasan_add_zero_shadow(void *start, unsigned long size)
> -{
> -	return 0;
> -}
> -static inline void kasan_remove_zero_shadow(void *start,
> -					unsigned long size)
> -{}
> -
> -static inline void kasan_unpoison_slab(const void *ptr) { }
> -static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> -
> -#endif /* CONFIG_KASAN */
> +#endif /* CONFIG_KASAN || CONFIG_SLAB_QUARANTINE */
>  
>  #ifdef CONFIG_KASAN_GENERIC
> -
>  #define KASAN_SHADOW_INIT 0
> -
> -void kasan_cache_shrink(struct kmem_cache *cache);
> -void kasan_cache_shutdown(struct kmem_cache *cache);
>  void kasan_record_aux_stack(void *ptr);
> -
>  #else /* CONFIG_KASAN_GENERIC */
> +static inline void kasan_record_aux_stack(void *ptr) {}
> +#endif /* CONFIG_KASAN_GENERIC */
>  
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_SLAB_QUARANTINE)
> +void kasan_cache_shrink(struct kmem_cache *cache);
> +void kasan_cache_shutdown(struct kmem_cache *cache);
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_SLAB_QUARANTINE */
>  static inline void kasan_cache_shrink(struct kmem_cache *cache) {}
>  static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
> -static inline void kasan_record_aux_stack(void *ptr) {}
> -
> -#endif /* CONFIG_KASAN_GENERIC */
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_SLAB_QUARANTINE */

In doing this extraction, I wonder if function naming should be changed?
If it's going to live a new life outside of KASAN proper, maybe call
these functions quarantine_cache_*()? But perhaps that's too much
churn...

>  #ifdef CONFIG_KASAN_SW_TAGS
>  
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index 9eb430c163c2..fc7548f27512 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -72,7 +72,7 @@ struct kmem_cache {
>  	int obj_offset;
>  #endif /* CONFIG_DEBUG_SLAB */
>  
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) || defined(CONFIG_SLAB_QUARANTINE)
>  	struct kasan_cache kasan_info;
>  #endif
>  
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index 1be0ed5befa1..71020cee9fd2 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -124,7 +124,7 @@ struct kmem_cache {
>  	unsigned int *random_seq;
>  #endif
>  
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) || defined(CONFIG_SLAB_QUARANTINE)
>  	struct kasan_cache kasan_info;
>  #endif
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index d6a0b31b13dc..de5aa061762f 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1931,6 +1931,17 @@ config SLAB_FREELIST_HARDENED
>  	  sanity-checking than others. This option is most effective with
>  	  CONFIG_SLUB.
>  
> +config SLAB_QUARANTINE
> +	bool "Enable slab freelist quarantine"
> +	depends on !KASAN && (SLAB || SLUB)
> +	help
> +	  Enable slab freelist quarantine to break heap spraying technique
> +	  used for exploiting use-after-free vulnerabilities in the kernel
> +	  code. If this feature is enabled, freed allocations are stored
> +	  in the quarantine and can't be instantly reallocated and
> +	  overwritten by the exploit performing heap spraying.
> +	  This feature is a part of KASAN functionality.
> +

To make this available to distros, I think this needs to be more than
just a CONFIG. I'd love to see this CONFIG control the availability, but
have a boot param control a ro-after-init static branch for these
functions (like is done for init_on_alloc, hardened usercopy, etc). Then
the branch can be off by default for regular distro users, and more
cautious folks could enable it with a boot param without having to roll
their own kernels.

> [...]
> +struct kasan_track {
> +	u32 pid;

pid_t?

> +	depot_stack_handle_t stack;
> +};
> [...]
> +#if defined(CONFIG_KASAN_GENERIC) && \
> +	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB)) || \
> +	defined(CONFIG_SLAB_QUARANTINE)

This seems a bit messy. Perhaps an invisible CONFIG to do this logic and
then the files can test for that? CONFIG_USE_SLAB_QUARANTINE or
something?

> [...]
> + * Heap spraying is an exploitation technique that aims to put controlled
> + * bytes at a predetermined memory location on the heap. Heap spraying for
> + * exploiting use-after-free in the Linux kernel relies on the fact that on
> + * kmalloc(), the slab allocator returns the address of the memory that was
> + * recently freed. Allocating a kernel object with the same size and
> + * controlled contents allows overwriting the vulnerable freed object.
> + *
> + * If freed allocations are stored in the quarantine, they can't be
> + * instantly reallocated and overwritten by the exploit performing
> + * heap spraying.

I would clarify this with the details of what is actually happening: the
allocation isn't _moved_ to a quarantine, yes? It's only marked as not
available for allocation?

> + */
> +
> +#include <linux/kasan.h>
> +#include <linux/bug.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include "../slab.h"
> +#include "kasan.h"
> +
> +void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +			slab_flags_t *flags)
> +{
> +	cache->kasan_info.alloc_meta_offset = 0;
> +
> +	if (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> +	     cache->object_size < sizeof(struct kasan_free_meta)) {
> +		cache->kasan_info.free_meta_offset = *size;
> +		*size += sizeof(struct kasan_free_meta);
> +		BUG_ON(*size > KMALLOC_MAX_SIZE);

Please don't use BUG_ON()[1].

Interesting!

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on

-- 
Kees Cook

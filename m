Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C2C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B9020857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sxto6yV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEAWBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAWBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:01:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211DC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 15:01:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ms17so449721pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T6li7RP0nNmM/rAdvvN6+PcfoPgJq4NN8pqOv5gUJa8=;
        b=Sxto6yV4sfv9B9gDti6Qo1WPgv6DCiJYs9s5aUw6Sj/QCrEyNhCMPaNKevWD1wvn/m
         fW3djuswak172TroKWRGCyWaWLA2awkaCJ84DV6tT6Nawpzi9bdygmUaUJOdDbxL/h32
         fZks3VUbNfKmUpM8Vs62G0GqVaqca8ZjOcAWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T6li7RP0nNmM/rAdvvN6+PcfoPgJq4NN8pqOv5gUJa8=;
        b=rjNm+R7i5+iS8Q+hvjJejCH18ql04d7RoGUFFFdktVi6pjiJ9x2c5gurRmwTsS8Fi9
         Iv/AIHNLTSJFr9rUzP07otzkoguuy47tDCskwf5fR7cAYBPfQwR+Xr8u649JI2xr2miT
         Je2k9Mrrhtr8XLqTGUjxXnxIM7DowBDiRKQdawBZB9S47j7RqRRxgdOrhgb+NStssVG0
         OrW5aaCFgGX5QY0LAe8KNjJA5LUcbmZLbTLzKF9T89rMEBrX5sAGHHPG6H/zk4pZcxfw
         gn1iLPubVcO90Mja0fXNZcjbp/Q8nJtzo1Pel1EfoTj3wbNsKwNv3fsKvpPSd43pv0ne
         mGPw==
X-Gm-Message-State: AGi0PuZw2hrZP0TvUsqO7MJIDQBhLLT8JsFUM8pEZBO+G5PwCne3zDgf
        e1v0llnYrj4xAuzJe+B/mtupGg==
X-Google-Smtp-Source: APiQypKS4i5bf3/UWMqYK0p0O2fN2Ms5Dg3dfylczCQAxDkqrBV/VWw0HOTclTuU9egptEqnAbsfQA==
X-Received: by 2002:a17:90a:24a7:: with SMTP id i36mr2109358pje.32.1588370466589;
        Fri, 01 May 2020 15:01:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s27sm137576pgo.42.2020.05.01.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 15:01:05 -0700 (PDT)
Date:   Fri, 1 May 2020 15:01:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] mm/slub: Fix incorrect interpretation of s->offset
Message-ID: <202005011459.5C3E13F4@keescook>
References: <20200429135328.26976-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429135328.26976-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 09:53:28AM -0400, Waiman Long wrote:
> In a couple of places in the slub memory allocator, the code uses
> "s->offset" as a check to see if the free pointer is put right after the
> object. That check is no longer true with commit 3202fa62fb43 ("slub:
> relocate freelist pointer to middle of object").
> 
> As a result, echoing "1" into the validate sysfs file, e.g. of dentry,
> may cause a bunch of "Freepointer corrupt" error reports like the
> following to appear with the system in panic afterwards.
> 
> [   38.579769] =============================================================================
> [   38.580845] BUG dentry(666:pmcd.service) (Tainted: G    B): Freepointer corrupt
> [   38.581948] -----------------------------------------------------------------------------
> 
> To fix it, use the check "s->offset == s->inuse" in the new helper
> function freeptr_outside_object() instead. Also add another helper function
> get_info_end() to return the end of info block (inuse + free pointer
> if not overlapping with object).
> 
> Fixes: 3202fa62fb43 ("slub: relocate freelist pointer to middle of object")
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks! Nice catch. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  mm/slub.c | 45 ++++++++++++++++++++++++++++++---------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
>  [v3: Change function name to freeptr_outside_object(), update check & add comment]
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9bf44955c4f1..b762450fc9f0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -551,15 +551,32 @@ static void print_section(char *level, char *text, u8 *addr,
>  	metadata_access_disable();
>  }
>  
> +/*
> + * See comment in calculate_sizes().
> + */
> +static inline bool freeptr_outside_object(struct kmem_cache *s)
> +{
> +	return s->offset >= s->inuse;
> +}
> +
> +/*
> + * Return offset of the end of info block which is inuse + free pointer if
> + * not overlapping with object.
> + */
> +static inline unsigned int get_info_end(struct kmem_cache *s)
> +{
> +	if (freeptr_outside_object(s))
> +		return s->inuse + sizeof(void *);
> +	else
> +		return s->inuse;
> +}
> +
>  static struct track *get_track(struct kmem_cache *s, void *object,
>  	enum track_item alloc)
>  {
>  	struct track *p;
>  
> -	if (s->offset)
> -		p = object + s->offset + sizeof(void *);
> -	else
> -		p = object + s->inuse;
> +	p = object + get_info_end(s);
>  
>  	return p + alloc;
>  }
> @@ -686,10 +703,7 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
>  		print_section(KERN_ERR, "Redzone ", p + s->object_size,
>  			s->inuse - s->object_size);
>  
> -	if (s->offset)
> -		off = s->offset + sizeof(void *);
> -	else
> -		off = s->inuse;
> +	off = get_info_end(s);
>  
>  	if (s->flags & SLAB_STORE_USER)
>  		off += 2 * sizeof(struct track);
> @@ -782,7 +796,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>   * object address
>   * 	Bytes of the object to be managed.
>   * 	If the freepointer may overlay the object then the free
> - * 	pointer is the first word of the object.
> + *	pointer is at the middle of the object.
>   *
>   * 	Poisoning uses 0x6b (POISON_FREE) and the last byte is
>   * 	0xa5 (POISON_END)
> @@ -816,11 +830,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct page *page,
>  
>  static int check_pad_bytes(struct kmem_cache *s, struct page *page, u8 *p)
>  {
> -	unsigned long off = s->inuse;	/* The end of info */
> -
> -	if (s->offset)
> -		/* Freepointer is placed after the object. */
> -		off += sizeof(void *);
> +	unsigned long off = get_info_end(s);	/* The end of info */
>  
>  	if (s->flags & SLAB_STORE_USER)
>  		/* We also have user information there */
> @@ -907,7 +917,7 @@ static int check_object(struct kmem_cache *s, struct page *page,
>  		check_pad_bytes(s, page, p);
>  	}
>  
> -	if (!s->offset && val == SLUB_RED_ACTIVE)
> +	if (!freeptr_outside_object(s) && val == SLUB_RED_ACTIVE)
>  		/*
>  		 * Object and freepointer overlap. Cannot check
>  		 * freepointer while object is allocated.
> @@ -3587,6 +3597,11 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  		 *
>  		 * This is the case if we do RCU, have a constructor or
>  		 * destructor or are poisoning the objects.
> +		 *
> +		 * The assumption that s->offset >= s->inuse means free
> +		 * pointer is outside of the object is used in the
> +		 * freeptr_outside_object() function. If that is no
> +		 * longer true, the function needs to be modified.
>  		 */
>  		s->offset = size;
>  		size += sizeof(void *);
> -- 
> 2.18.1
> 

-- 
Kees Cook

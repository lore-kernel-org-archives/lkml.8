Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DEAC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B03216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6CJtK8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgEAV3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:29:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60527 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726333AbgEAV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588368568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ypI/E3zn8fmAPe3GyyyHKXmBOUI7feD3BZfJdMnsdoE=;
        b=R6CJtK8Q7ZpSP9d/23s+MUm2av2bwiPWdkRaIJkvjEQyH7/c9xOZLA1MGOUlC9x9LiURm+
        3D+lIOPhNG0OGKzoyvuNh+mv+ZiAiFVnYX+QCbcpNBzabHrgiIrqa2O2IU+NYHWtgjmR72
        k7NtSmC02hzdVwv/ukgghtJqAs1jZME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-KhZuis_bO_K715ZYxP1zbw-1; Fri, 01 May 2020 17:29:23 -0400
X-MC-Unique: KhZuis_bO_K715ZYxP1zbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B025C100CCCE;
        Fri,  1 May 2020 21:29:21 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6741A5C1BE;
        Fri,  1 May 2020 21:29:15 +0000 (UTC)
Date:   Fri, 1 May 2020 17:29:12 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] mm/slub: Fix incorrect interpretation of s->offset
Message-ID: <20200501212912.GC27720@optiplex-lnx>
References: <20200429135328.26976-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429135328.26976-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> 
Acked-by: Rafael Aquini <aquini@redhat.com>


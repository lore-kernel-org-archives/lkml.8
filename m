Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DE8C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1F92063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6ZJzATV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbgDBHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:52:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42938 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDBHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:52:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id 22so1370718pfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YDhcDFzxnB0LzwhhhavzuQofpQqoxKbtsiZ2UHnUGxU=;
        b=A6ZJzATVZMdYm6aYjzbAsFnbVu+/ukE/HUOrWoX6wNSXH7TjId503hbalZIcER3qhr
         Y5qB/1CFmXiQvAttlkjKxpgOTqSerdCjb/TPzMe6QvKL8r5gTbbRJSL4V6e2L7JhAA5B
         DOCsSudHTl/uKCgBkojQz+0LCaSqXe0yQNm4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YDhcDFzxnB0LzwhhhavzuQofpQqoxKbtsiZ2UHnUGxU=;
        b=P/uk1wDAl39031mnTqdBVUF3y11o3JteBAmy8DY0to8r6Cz9qhXXXYtgJiRqbtaBQU
         4+myu8wAh3KzwT/ksQ93tNgjkeQBrJ53BNQ4uYWVuPG8m0FB9YfIpi4tdVMM2uB4uhLc
         t8OS03b9LZ/C9MBaB2e1XLjSVT9ge7n7ZNpW9T60aab5hG99jJ1kZQ13Z8GY5TdIcyAk
         EsmF9tzhwzFIkoyQPmLKVEhgInqYrLwoGTI0T427S/cfbRR6k6mwAIwQHQ32KxIzQPCv
         xUpIycNb4h/h/5TPrquJZe7iFcIjeJOgbzs+62INORezZ2u97Ki9dQDawQuY16WaV2Dg
         AlrA==
X-Gm-Message-State: AGi0PubugdDnUXc54hWexxmL7cALDpuwrX0lY9GCj2hxou2hhbMc4twC
        8ifHZ5VUq4WZCh9hQvgrEib5Jw==
X-Google-Smtp-Source: APiQypKB4nOuEy27sAy36sblXB+uB0SHnxgxvV5A0l19f7PmP5vbDtzIT9/IOshcLycLAXLiPPMwyg==
X-Received: by 2002:a63:8c13:: with SMTP id m19mr2113657pgd.44.1585813937373;
        Thu, 02 Apr 2020 00:52:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14sm3216861pje.19.2020.04.02.00.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:52:16 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:52:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 3/4] drm/i915/gem: Replace user_access_begin by
 user_write_access_begin
Message-ID: <202004020051.649C6B8@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <6da6fa391c0d6344cc9ff99a69fcaa65666f3947.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da6fa391c0d6344cc9ff99a69fcaa65666f3947.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:18AM +0000, Christophe Leroy wrote:
> When i915_gem_execbuffer2_ioctl() is using user_access_begin(),
> that's only to perform unsafe_put_user() so use
> user_write_access_begin() in order to only open write access.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Why is this split from the other conversions?

Reviewed-by: Kees Cook <keescook@chromium.org>


> ---
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> index 7643a30ba4cd..4be8205a70b6 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -1611,14 +1611,14 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  		 * happened we would make the mistake of assuming that the
>  		 * relocations were valid.
>  		 */
> -		if (!user_access_begin(urelocs, size))
> +		if (!user_write_access_begin(urelocs, size))
>  			goto end;
>  
>  		for (copied = 0; copied < nreloc; copied++)
>  			unsafe_put_user(-1,
>  					&urelocs[copied].presumed_offset,
>  					end_user);
> -		user_access_end();
> +		user_write_access_end();
>  
>  		eb->exec[i].relocs_ptr = (uintptr_t)relocs;
>  	}
> @@ -1626,7 +1626,7 @@ static int eb_copy_relocations(const struct i915_execbuffer *eb)
>  	return 0;
>  
>  end_user:
> -	user_access_end();
> +	user_write_access_end();
>  end:
>  	kvfree(relocs);
>  	err = -EFAULT;
> @@ -2991,7 +2991,8 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>  		 * And this range already got effectively checked earlier
>  		 * when we did the "copy_from_user()" above.
>  		 */
> -		if (!user_access_begin(user_exec_list, count * sizeof(*user_exec_list)))
> +		if (!user_write_access_begin(user_exec_list,
> +					     count * sizeof(*user_exec_list)))
>  			goto end;
>  
>  		for (i = 0; i < args->buffer_count; i++) {
> @@ -3005,7 +3006,7 @@ i915_gem_execbuffer2_ioctl(struct drm_device *dev, void *data,
>  					end_user);
>  		}
>  end_user:
> -		user_access_end();
> +		user_write_access_end();
>  end:;
>  	}
>  
> -- 
> 2.25.0
> 

-- 
Kees Cook

Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FBFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D33208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="To/PTKyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbgDBHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:51:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33209 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgDBHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:51:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id jz1so3075653pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owhhf3a9xckUQID1JH+AKO8BSZ4NJugRxsKf3U+q8a4=;
        b=To/PTKyAFWucW5+IMeI2yi98pK//fDkr9nURGXPB17w0/PjgZQutmOJPXBxJS6aOyb
         JYGBNOdjcAr9HZAqhAdyZOIdT5Tivgr6CUdMbwXIijjZrQWlDNDrUNWj90OmRbf+aa/R
         kx8ivj8JL7Zxeosa4D/msz2M4hZMX1zrEuhV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owhhf3a9xckUQID1JH+AKO8BSZ4NJugRxsKf3U+q8a4=;
        b=eOjrCKlsaWC6XAJsrimqD2FE6lomH3/sYAeJIvdu+TTKJrGiodRHv+6IrEv9tdoOSY
         81WP9f2I1Jk9QcYbzgPffaEA2G7XdCkwKXbOwI/a4CXV368HCRp8Jck2lczvlGyP5cPC
         BydG/EUgpJ8pa4+1AknEPx1hxPvI1yqA/TMV/nqb7bHkm7SO+b1r8dsVvnnZ5HG6bT/u
         msuNBe7kPjoengdTeJndH0q90ICvliEw0iqtNzKK4cJRUZrZAQwgcPB/fAOzD8xaGZeY
         hqcJXJTHulJiaZKGjgoI1KYVFn7awG8oyWplEncx7wz9cHVpfYd2ILK7OSdWosp0rIrH
         YYxQ==
X-Gm-Message-State: AGi0PuYU1Z30pgpQ7j41BoHQSbRG8M/dV4ZY6x4ynEWvgxM2E9C0G8f3
        fGmfO4QRaG1Zg1S+5MgN3oiJhw==
X-Google-Smtp-Source: APiQypIfH5wxyPKEeGYBq6xLBeIa4cScD3yEDdZlF7pyVXcqSyqcGnUNxxgPH/tPwVIGmLIypwE60A==
X-Received: by 2002:a17:90a:228c:: with SMTP id s12mr2380534pjc.68.1585813888074;
        Thu, 02 Apr 2020 00:51:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 71sm3162361pfv.8.2020.04.02.00.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 00:51:27 -0700 (PDT)
Date:   Thu, 2 Apr 2020 00:51:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND 2/4] uaccess: Selectively open read or write user
 access
Message-ID: <202004020047.401CEBED2@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <25040ad2d2a2cef45a2442b0e934141987e11b71.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25040ad2d2a2cef45a2442b0e934141987e11b71.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:17AM +0000, Christophe Leroy wrote:
> [...]
> diff --git a/kernel/compat.c b/kernel/compat.c
> index 843dd17e6078..705ca7e418c6 100644
> --- a/kernel/compat.c
> +++ b/kernel/compat.c
> @@ -199,7 +199,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!user_access_begin(umask, bitmap_size / 8))
> +	if (!user_write_access_begin(umask, bitmap_size / 8))

This looks mismatched: should be user_read_access_begin()?

>  		return -EFAULT;
>  
>  	while (nr_compat_longs > 1) {
> @@ -211,11 +211,11 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>  	}
>  	if (nr_compat_longs)
>  		unsafe_get_user(*mask, umask++, Efault);
> -	user_access_end();
> +	user_read_access_end();
>  	return 0;
>  
>  Efault:
> -	user_access_end();
> +	user_read_access_end();
>  	return -EFAULT;
>  }

(These correctly end read access.)

>  
> @@ -228,7 +228,7 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	bitmap_size = ALIGN(bitmap_size, BITS_PER_COMPAT_LONG);
>  	nr_compat_longs = BITS_TO_COMPAT_LONGS(bitmap_size);
>  
> -	if (!user_access_begin(umask, bitmap_size / 8))
> +	if (!user_read_access_begin(umask, bitmap_size / 8))

And ..._write_... here?

>  		return -EFAULT;
>  
>  	while (nr_compat_longs > 1) {
> @@ -239,10 +239,10 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>  	}
>  	if (nr_compat_longs)
>  		unsafe_put_user((compat_ulong_t)*mask, umask++, Efault);
> -	user_access_end();
> +	user_write_access_end();
>  	return 0;
>  Efault:
> -	user_access_end();
> +	user_write_access_end();
>  	return -EFAULT;
>  }

(These correctly end write access.)


All the others look correct. With the above fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

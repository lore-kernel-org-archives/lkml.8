Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84422078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="S/zHyEvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbgFHXqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387926AbgFHXqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:46:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF135C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 16:46:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so7283415plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 16:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=iRKtJjvaQvpnLM0n+hJpxV6DfePNZchTxPVDLSTVu8c=;
        b=S/zHyEvUx+sUo9VJAGoikLFmQ8yXiskJr9oedH3gDecer15IJF1oujQhfHY9ATccD/
         wCfR8ZJVYO4Um1P352QjhgIfffE39js8oH6d0u9906b8AzRFKodOCZdFARiAAtm2Nz6/
         5+XRsM0iD8SEAuo8Xi4geDjkXxSZACNl8vGk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iRKtJjvaQvpnLM0n+hJpxV6DfePNZchTxPVDLSTVu8c=;
        b=rsWVW0xwA+hNVrb9E6/xkoW2Z9DWTxqXS98/ZFnjo6L2XQLqh3hFjKKz1IfFg7RXI0
         ecMm7Dt5FbaWy/6UQBmi+pYmZrJVIqtsf781XcFtr7pg4sdJTqrS+EOfLyAzEqWl7RPk
         PorqCtMQAntMoncA5Z5KoWrtrJ4pUTcJ1iChY78hCSxjrZdoXCUtLqd12N/02kUkWq+F
         t2kvsdrLomFY2VU99fctxPE04hCBlfIQKX5oU3FLzO0IHO42m6IRYVzlcdEtN21x11Qy
         At17JCPctuKegVBhEseHy5xpbb/XNemmWK0xexBFBgygp4+wajtEZgiDtuS88+QZMUUO
         MLKw==
X-Gm-Message-State: AOAM532eFt0+MdfetUHBKGYsujiJWy67hLeTK2izzoO5QQz+sr7Re1fP
        Ys2gakOOo0bL+u0+mxumWzM1/A==
X-Google-Smtp-Source: ABdhPJwSG9hRTF5ASaEVoR0Wdaot7wXqmy+nRJ88drukMdnIatQ3MTgLkt5dLOIgfhOrFEerX3xNqw==
X-Received: by 2002:a17:90b:3116:: with SMTP id gc22mr1628561pjb.195.1591659972111;
        Mon, 08 Jun 2020 16:46:12 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-5964-9b5a-12eb-7d57.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5964:9b5a:12eb:7d57])
        by smtp.gmail.com with ESMTPSA id o21sm8181130pfp.12.2020.06.08.16.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 16:46:11 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Gow <davidgow@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 72/72] string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
In-Reply-To: <20200608232500.3369581-72-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org> <20200608232500.3369581-72-sashal@kernel.org>
Date:   Tue, 09 Jun 2020 09:46:08 +1000
Message-ID: <87ftb5t933.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

There's nothing inherently wrong with these patches being backported,
but they fix a bug that doesn't cause a crash and only affects debug
kernels compiled with KASAN and FORTIFY_SOURCE. Personally I wouldn't
change a core header file in a stable kernel for that. Perhaps I'm too
risk-averse.

Regards,
Daniel

> From: Daniel Axtens <dja@axtens.net>
>
> [ Upstream commit 47227d27e2fcb01a9e8f5958d8997cf47a820afc ]
>
> The memcmp KASAN self-test fails on a kernel with both KASAN and
> FORTIFY_SOURCE.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the operands.
> However, these functions often directly invoke __builtin_foo() once they
> have performed the fortify check.  Using __builtins may bypass KASAN
> checks if the compiler decides to inline it's own implementation as
> sequence of instructions, rather than emit a function call that goes out
> to a KASAN-instrumented implementation.
>
> Why is only memcmp affected?
> ============================
>
> Of the string and string-like functions that kasan_test tests, only memcmp
> is replaced by an inline sequence of instructions in my testing on x86
> with gcc version 9.2.1 20191008 (Ubuntu 9.2.1-9ubuntu2).
>
> I believe this is due to compiler heuristics.  For example, if I annotate
> kmalloc calls with the alloc_size annotation (and disable some fortify
> compile-time checking!), the compiler will replace every memset except the
> one in kmalloc_uaf_memset with inline instructions.  (I have some WIP
> patches to add this annotation.)
>
> Does this affect other functions in string.h?
> =============================================
>
> Yes. Anything that uses __builtin_* rather than __real_* could be
> affected. This looks like:
>
>  - strncpy
>  - strcat
>  - strlen
>  - strlcpy maybe, under some circumstances?
>  - strncat under some circumstances
>  - memset
>  - memcpy
>  - memmove
>  - memcmp (as noted)
>  - memchr
>  - strcpy
>
> Whether a function call is emitted always depends on the compiler.  Most
> bugs should get caught by FORTIFY_SOURCE, but the missed memcmp test shows
> that this is not always the case.
>
> Isn't FORTIFY_SOURCE disabled with KASAN?
> ========================================-
>
> The string headers on all arches supporting KASAN disable fortify with
> kasan, but only when address sanitisation is _also_ disabled.  For example
> from x86:
>
>  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>  /*
>   * For files that are not instrumented (e.g. mm/slub.c) we
>   * should use not instrumented version of mem* functions.
>   */
>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
>  #define memmove(dst, src, len) __memmove(dst, src, len)
>  #define memset(s, c, n) __memset(s, c, n)
>
>  #ifndef __NO_FORTIFY
>  #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
>  #endif
>
>  #endif
>
> This comes from commit 6974f0c4555e ("include/linux/string.h: add the
> option of fortified string.h functions"), and doesn't work when KASAN is
> enabled and the file is supposed to be sanitised - as with test_kasan.c
>
> I'm pretty sure this is not wrong, but not as expansive it should be:
>
>  * we shouldn't use __builtin_memcpy etc in files where we don't have
>    instrumentation - it could devolve into a function call to memcpy,
>    which will be instrumented. Rather, we should use __memcpy which
>    by convention is not instrumented.
>
>  * we also shouldn't be using __builtin_memcpy when we have a KASAN
>    instrumented file, because it could be replaced with inline asm
>    that will not be instrumented.
>
> What is correct behaviour?
> ==========================
>
> Firstly, there is some overlap between fortification and KASAN: both
> provide some level of _runtime_ checking. Only fortify provides
> compile-time checking.
>
> KASAN and fortify can pick up different things at runtime:
>
>  - Some fortify functions, notably the string functions, could easily be
>    modified to consider sub-object sizes (e.g. members within a struct),
>    and I have some WIP patches to do this. KASAN cannot detect these
>    because it cannot insert poision between members of a struct.
>
>  - KASAN can detect many over-reads/over-writes when the sizes of both
>    operands are unknown, which fortify cannot.
>
> So there are a couple of options:
>
>  1) Flip the test: disable fortify in santised files and enable it in
>     unsanitised files. This at least stops us missing KASAN checking, but
>     we lose the fortify checking.
>
>  2) Make the fortify code always call out to real versions. Do this only
>     for KASAN, for fear of losing the inlining opportunities we get from
>     __builtin_*.
>
> (We can't use kasan_check_{read,write}: because the fortify functions are
> _extern inline_, you can't include _static_ inline functions without a
> compiler warning. kasan_check_{read,write} are static inline so we can't
> use them even when they would otherwise be suitable.)
>
> Take approach 2 and call out to real versions when KASAN is enabled.
>
> Use __underlying_foo to distinguish from __real_foo: __real_foo always
> refers to the kernel's implementation of foo, __underlying_foo could be
> either the kernel implementation or the __builtin_foo implementation.
>
> This is sometimes enough to make the memcmp test succeed with
> FORTIFY_SOURCE enabled. It is at least enough to get the function call
> into the module. One more fix is needed to make it reliable: see the next
> patch.
>
> Fixes: 6974f0c4555e ("include/linux/string.h: add the option of fortified string.h functions")
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Tested-by: David Gow <davidgow@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Daniel Micay <danielmicay@gmail.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Link: http://lkml.kernel.org/r/20200423154503.5103-3-dja@axtens.net
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 3d43329c20be..315fef3aff4e 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -238,6 +238,31 @@ void __read_overflow3(void) __compiletime_error("detected read beyond size of ob
>  void __write_overflow(void) __compiletime_error("detected write beyond size of object passed as 1st parameter");
>  
>  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> +
> +#ifdef CONFIG_KASAN
> +extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
> +extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
> +extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
> +extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
> +extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
> +extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
> +extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
> +#else
> +#define __underlying_memchr	__builtin_memchr
> +#define __underlying_memcmp	__builtin_memcmp
> +#define __underlying_memcpy	__builtin_memcpy
> +#define __underlying_memmove	__builtin_memmove
> +#define __underlying_memset	__builtin_memset
> +#define __underlying_strcat	__builtin_strcat
> +#define __underlying_strcpy	__builtin_strcpy
> +#define __underlying_strlen	__builtin_strlen
> +#define __underlying_strncat	__builtin_strncat
> +#define __underlying_strncpy	__builtin_strncpy
> +#endif
> +
>  __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
>  {
>  	size_t p_size = __builtin_object_size(p, 0);
> @@ -245,14 +270,14 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
>  		__write_overflow();
>  	if (p_size < size)
>  		fortify_panic(__func__);
> -	return __builtin_strncpy(p, q, size);
> +	return __underlying_strncpy(p, q, size);
>  }
>  
>  __FORTIFY_INLINE char *strcat(char *p, const char *q)
>  {
>  	size_t p_size = __builtin_object_size(p, 0);
>  	if (p_size == (size_t)-1)
> -		return __builtin_strcat(p, q);
> +		return __underlying_strcat(p, q);
>  	if (strlcat(p, q, p_size) >= p_size)
>  		fortify_panic(__func__);
>  	return p;
> @@ -266,7 +291,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
>  	/* Work around gcc excess stack consumption issue */
>  	if (p_size == (size_t)-1 ||
>  	    (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
> -		return __builtin_strlen(p);
> +		return __underlying_strlen(p);
>  	ret = strnlen(p, p_size);
>  	if (p_size <= ret)
>  		fortify_panic(__func__);
> @@ -299,7 +324,7 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
>  			__write_overflow();
>  		if (len >= p_size)
>  			fortify_panic(__func__);
> -		__builtin_memcpy(p, q, len);
> +		__underlying_memcpy(p, q, len);
>  		p[len] = '\0';
>  	}
>  	return ret;
> @@ -312,12 +337,12 @@ __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
>  	size_t p_size = __builtin_object_size(p, 0);
>  	size_t q_size = __builtin_object_size(q, 0);
>  	if (p_size == (size_t)-1 && q_size == (size_t)-1)
> -		return __builtin_strncat(p, q, count);
> +		return __underlying_strncat(p, q, count);
>  	p_len = strlen(p);
>  	copy_len = strnlen(q, count);
>  	if (p_size < p_len + copy_len + 1)
>  		fortify_panic(__func__);
> -	__builtin_memcpy(p + p_len, q, copy_len);
> +	__underlying_memcpy(p + p_len, q, copy_len);
>  	p[p_len + copy_len] = '\0';
>  	return p;
>  }
> @@ -329,7 +354,7 @@ __FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
>  		__write_overflow();
>  	if (p_size < size)
>  		fortify_panic(__func__);
> -	return __builtin_memset(p, c, size);
> +	return __underlying_memset(p, c, size);
>  }
>  
>  __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
> @@ -344,7 +369,7 @@ __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
>  	}
>  	if (p_size < size || q_size < size)
>  		fortify_panic(__func__);
> -	return __builtin_memcpy(p, q, size);
> +	return __underlying_memcpy(p, q, size);
>  }
>  
>  __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
> @@ -359,7 +384,7 @@ __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
>  	}
>  	if (p_size < size || q_size < size)
>  		fortify_panic(__func__);
> -	return __builtin_memmove(p, q, size);
> +	return __underlying_memmove(p, q, size);
>  }
>  
>  extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
> @@ -385,7 +410,7 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
>  	}
>  	if (p_size < size || q_size < size)
>  		fortify_panic(__func__);
> -	return __builtin_memcmp(p, q, size);
> +	return __underlying_memcmp(p, q, size);
>  }
>  
>  __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
> @@ -395,7 +420,7 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
>  		__read_overflow();
>  	if (p_size < size)
>  		fortify_panic(__func__);
> -	return __builtin_memchr(p, c, size);
> +	return __underlying_memchr(p, c, size);
>  }
>  
>  void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
> @@ -426,11 +451,22 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
>  	size_t p_size = __builtin_object_size(p, 0);
>  	size_t q_size = __builtin_object_size(q, 0);
>  	if (p_size == (size_t)-1 && q_size == (size_t)-1)
> -		return __builtin_strcpy(p, q);
> +		return __underlying_strcpy(p, q);
>  	memcpy(p, q, strlen(q) + 1);
>  	return p;
>  }
>  
> +/* Don't use these outside the FORITFY_SOURCE implementation */
> +#undef __underlying_memchr
> +#undef __underlying_memcmp
> +#undef __underlying_memcpy
> +#undef __underlying_memmove
> +#undef __underlying_memset
> +#undef __underlying_strcat
> +#undef __underlying_strcpy
> +#undef __underlying_strlen
> +#undef __underlying_strncat
> +#undef __underlying_strncpy
>  #endif
>  
>  /**
> -- 
> 2.25.1

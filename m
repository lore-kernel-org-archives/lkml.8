Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D9AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4370120936
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJurAnuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgIHRoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:44:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42243 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726708AbgIHRnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599587024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OlhyRHow0mNg4gsAl5rIy+BF+1K1rpI/mYyts6piHUg=;
        b=ZJurAnuJ3x18ofUU2Jq7lod07VTJpddj1he6E5quMnoel4BdaBGUJIG3ogOYAoqT9+xmtT
        sLsatMtmxsvVrtm9g+ZsopJ9/uZZBhNhJYYhShaDeeKRtzRp8L3E7Aofs3abLnkw6y7xu3
        aatiiugD5/+0K2gQfdHX2ab1eQCGHqI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-y9BoPNbrMcmIs3dI_4JMmg-1; Tue, 08 Sep 2020 13:43:40 -0400
X-MC-Unique: y9BoPNbrMcmIs3dI_4JMmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35E5C10BBECF;
        Tue,  8 Sep 2020 17:43:37 +0000 (UTC)
Received: from treble (ovpn-117-163.rdu2.redhat.com [10.10.117.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 837335C1C4;
        Tue,  8 Sep 2020 17:43:31 +0000 (UTC)
Date:   Tue, 8 Sep 2020 12:43:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200908174329.ryfprry62e4tuodw@treble>
References: <bef9e78f9486d2a06c3e026d401511ffa117b0da.1598973982.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bef9e78f9486d2a06c3e026d401511ffa117b0da.1598973982.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

Any objection to merging this patch?

On Tue, Sep 01, 2020 at 10:30:19AM -0500, Josh Poimboeuf wrote:
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
> 
> There are some issues with the current implementation:
> 
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")
> 
> - copy_to_user() and friends should also have a speculation barrier,
>   because a speculative write to a user-controlled address can still
>   populate the cache line with the original data.
> 
> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>   pointer masking can be used instead.
> 
> Remove all existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing.
> 
> barrier_nospec() is now unused, and can be removed.
> 
> Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> v2:
> - fix 32-bit build
> 
>  Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
>  arch/x86/include/asm/barrier.h                |  3 --
>  arch/x86/include/asm/checksum_32.h            |  6 ++--
>  arch/x86/include/asm/futex.h                  |  5 +++
>  arch/x86/include/asm/uaccess.h                | 31 ++++++++++++-------
>  arch/x86/include/asm/uaccess_64.h             | 16 +++++-----
>  arch/x86/lib/csum-wrappers_64.c               |  6 ++--
>  arch/x86/lib/getuser.S                        | 10 +++---
>  arch/x86/lib/putuser.S                        |  8 +++++
>  arch/x86/lib/usercopy_32.c                    |  6 ++--
>  arch/x86/lib/usercopy_64.c                    |  4 +--
>  lib/iov_iter.c                                |  2 +-
>  12 files changed, 60 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index e05e581af5cf..849c613afb35 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -426,9 +426,9 @@ Spectre variant 1
>     <spec_ref2>` to avoid any usable disclosure gadgets. However, it may
>     not cover all attack vectors for Spectre variant 1.
>  
> -   Copy-from-user code has an LFENCE barrier to prevent the access_ok()
> -   check from being mis-speculated.  The barrier is done by the
> -   barrier_nospec() macro.
> +   Usercopy code uses user pointer masking to prevent the access_ok()
> +   check from being mis-speculated in the success path with a kernel
> +   address.  The masking is done by the uaccess_mask_ptr() macro.
>  
>     For the swapgs variant of Spectre variant 1, LFENCE barriers are
>     added to interrupt, exception and NMI entry where needed.  These
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 7f828fe49797..d158ea1fa250 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -48,9 +48,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  /* Override the default implementation from linux/nospec.h. */
>  #define array_index_mask_nospec array_index_mask_nospec
>  
> -/* Prevent speculative execution past this barrier. */
> -#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
> -
>  #define dma_rmb()	barrier()
>  #define dma_wmb()	barrier()
>  
> diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
> index 11624c8a9d8d..d2bbea5b0334 100644
> --- a/arch/x86/include/asm/checksum_32.h
> +++ b/arch/x86/include/asm/checksum_32.h
> @@ -56,8 +56,8 @@ static inline __wsum csum_and_copy_from_user(const void __user *src,
>  			*err_ptr = -EFAULT;
>  		return sum;
>  	}
> -	ret = csum_partial_copy_generic((__force void *)src, dst,
> -					len, sum, err_ptr, NULL);
> +	ret = csum_partial_copy_generic((__force void *)uaccess_mask_ptr(src),
> +					dst, len, sum, err_ptr, NULL);
>  	user_access_end();
>  
>  	return ret;
> @@ -185,7 +185,7 @@ static inline __wsum csum_and_copy_to_user(const void *src,
>  
>  	might_sleep();
>  	if (user_access_begin(dst, len)) {
> -		ret = csum_partial_copy_generic(src, (__force void *)dst,
> +		ret = csum_partial_copy_generic(src, (__force void *)uaccess_mask_ptr(dst),
>  						len, sum, NULL, err_ptr);
>  		user_access_end();
>  		return ret;
> diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
> index f9c00110a69a..89e7e37c2b25 100644
> --- a/arch/x86/include/asm/futex.h
> +++ b/arch/x86/include/asm/futex.h
> @@ -59,6 +59,8 @@ static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *o
>  	if (!user_access_begin(uaddr, sizeof(u32)))
>  		return -EFAULT;
>  
> +	uaddr = uaccess_mask_ptr(uaddr);
> +
>  	switch (op) {
>  	case FUTEX_OP_SET:
>  		unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
> @@ -94,6 +96,9 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  
>  	if (!user_access_begin(uaddr, sizeof(u32)))
>  		return -EFAULT;
> +
> +	uaddr = uaccess_mask_ptr(uaddr);
> +
>  	asm volatile("\n"
>  		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
>  		"2:\n"
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index ecefaffd15d4..e697b42d0533 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/compiler.h>
>  #include <linux/kasan-checks.h>
> +#include <linux/nospec.h>
>  #include <linux/string.h>
>  #include <asm/asm.h>
>  #include <asm/page.h>
> @@ -96,6 +97,15 @@ static inline bool pagefault_disabled(void);
>  	likely(!__range_not_ok(addr, size, user_addr_max()));		\
>  })
>  
> +/*
> + * Sanitize a uaccess pointer such that it becomes NULL if it's not a valid
> + * user pointer.  This blocks speculative dereferences of user-controlled
> + * pointers.
> + */
> +#define uaccess_mask_ptr(ptr) \
> +	(__typeof__(ptr)) array_index_nospec((__force unsigned long)ptr, user_addr_max())
> +
> +
>  /*
>   * These are the main single-value transfer routines.  They automatically
>   * use the right size if we just have the right pointer type.
> @@ -119,11 +129,6 @@ extern int __get_user_bad(void);
>  
>  #define __uaccess_begin() stac()
>  #define __uaccess_end()   clac()
> -#define __uaccess_begin_nospec()	\
> -({					\
> -	stac();				\
> -	barrier_nospec();		\
> -})
>  
>  /*
>   * This is the smallest unsigned integer type that can fit a value
> @@ -357,7 +362,7 @@ do {									\
>  	__label__ __pu_label;					\
>  	int __pu_err = -EFAULT;					\
>  	__typeof__(*(ptr)) __pu_val = (x);			\
> -	__typeof__(ptr) __pu_ptr = (ptr);			\
> +	__typeof__(ptr) __pu_ptr = uaccess_mask_ptr(ptr);	\
>  	__typeof__(size) __pu_size = (size);			\
>  	__uaccess_begin();					\
>  	__put_user_size(__pu_val, __pu_ptr, __pu_size, __pu_label);	\
> @@ -371,9 +376,9 @@ __pu_label:							\
>  ({									\
>  	int __gu_err;							\
>  	__inttype(*(ptr)) __gu_val;					\
> -	__typeof__(ptr) __gu_ptr = (ptr);				\
> +	__typeof__(ptr) __gu_ptr = uaccess_mask_ptr(ptr);		\
>  	__typeof__(size) __gu_size = (size);				\
> -	__uaccess_begin_nospec();					\
> +	__uaccess_begin();						\
>  	__get_user_size(__gu_val, __gu_ptr, __gu_size, __gu_err);	\
>  	__uaccess_end();						\
>  	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
> @@ -482,7 +487,7 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
>  {
>  	if (unlikely(!access_ok(ptr,len)))
>  		return 0;
> -	__uaccess_begin_nospec();
> +	__uaccess_begin();
>  	return 1;
>  }
>  #define user_access_begin(a,b)	user_access_begin(a,b)
> @@ -491,14 +496,16 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
>  #define user_access_save()	smap_save()
>  #define user_access_restore(x)	smap_restore(x)
>  
> -#define unsafe_put_user(x, ptr, label)	\
> -	__put_user_size((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
> +#define unsafe_put_user(x, ptr, label)						\
> +	__put_user_size((__typeof__(*(ptr)))(x), uaccess_mask_ptr(ptr),		\
> +			sizeof(*(ptr)), label)
>  
>  #define unsafe_get_user(x, ptr, err_label)					\
>  do {										\
>  	int __gu_err;								\
>  	__inttype(*(ptr)) __gu_val;						\
> -	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), __gu_err);		\
> +	__get_user_size(__gu_val, uaccess_mask_ptr(ptr), sizeof(*(ptr)),	\
> +			__gu_err);						\
>  	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
>  	if (unlikely(__gu_err)) goto err_label;					\
>  } while (0)
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index bc10e3dc64fe..ef859e1ae956 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -47,7 +47,7 @@ copy_user_generic(void *to, const void *from, unsigned len)
>  }
>  
>  static __always_inline __must_check unsigned long
> -copy_to_user_mcsafe(void *to, const void *from, unsigned len)
> +copy_to_user_mcsafe(void __user *to, const void *from, size_t len)
>  {
>  	unsigned long ret;
>  
> @@ -57,7 +57,7 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
>  	 * handle exceptions / faults.  memcpy_mcsafe() may fall back to
>  	 * memcpy() which lacks this handling.
>  	 */
> -	ret = __memcpy_mcsafe(to, from, len);
> +	ret = __memcpy_mcsafe((__force void *)uaccess_mask_ptr(to), from, len);
>  	__uaccess_end();
>  	return ret;
>  }
> @@ -65,20 +65,20 @@ copy_to_user_mcsafe(void *to, const void *from, unsigned len)
>  static __always_inline __must_check unsigned long
>  raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
>  {
> -	return copy_user_generic(dst, (__force void *)src, size);
> +	return copy_user_generic(dst, (__force void *)uaccess_mask_ptr(src), size);
>  }
>  
>  static __always_inline __must_check unsigned long
>  raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
>  {
> -	return copy_user_generic((__force void *)dst, src, size);
> +	return copy_user_generic((__force void *)uaccess_mask_ptr(dst), src, size);
>  }
>  
>  static __always_inline __must_check
>  unsigned long raw_copy_in_user(void __user *dst, const void __user *src, unsigned long size)
>  {
> -	return copy_user_generic((__force void *)dst,
> -				 (__force void *)src, size);
> +	return copy_user_generic((__force void *)uaccess_mask_ptr(dst),
> +				 (__force void *)uaccess_mask_ptr(src), size);
>  }
>  
>  extern long __copy_user_nocache(void *dst, const void __user *src,
> @@ -93,14 +93,14 @@ __copy_from_user_inatomic_nocache(void *dst, const void __user *src,
>  				  unsigned size)
>  {
>  	kasan_check_write(dst, size);
> -	return __copy_user_nocache(dst, src, size, 0);
> +	return __copy_user_nocache(dst, uaccess_mask_ptr(src), size, 0);
>  }
>  
>  static inline int
>  __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
>  {
>  	kasan_check_write(dst, size);
> -	return __copy_user_flushcache(dst, src, size);
> +	return __copy_user_flushcache(dst, uaccess_mask_ptr(src), size);
>  }
>  
>  unsigned long
> diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
> index ee63d7576fd2..d677b91a7e84 100644
> --- a/arch/x86/lib/csum-wrappers_64.c
> +++ b/arch/x86/lib/csum-wrappers_64.c
> @@ -52,8 +52,8 @@ csum_and_copy_from_user(const void __user *src, void *dst,
>  			len -= 2;
>  		}
>  	}
> -	isum = csum_partial_copy_generic((__force const void *)src,
> -				dst, len, isum, errp, NULL);
> +	isum = csum_partial_copy_generic((__force const void *)uaccess_mask_ptr(src),
> +					 dst, len, isum, errp, NULL);
>  	user_access_end();
>  	if (unlikely(*errp))
>  		goto out_err;
> @@ -108,7 +108,7 @@ csum_and_copy_to_user(const void *src, void __user *dst,
>  	}
>  
>  	*errp = 0;
> -	ret = csum_partial_copy_generic(src, (void __force *)dst,
> +	ret = csum_partial_copy_generic(src, (void __force *)uaccess_mask_ptr(dst),
>  					len, isum, NULL, errp);
>  	user_access_end();
>  	return ret;
> diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
> index c8a85b512796..90ae5be8af23 100644
> --- a/arch/x86/lib/getuser.S
> +++ b/arch/x86/lib/getuser.S
> @@ -40,7 +40,7 @@ SYM_FUNC_START(__get_user_1)
>  	mov PER_CPU_VAR(current_task), %_ASM_DX
>  	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
>  	jae bad_get_user
> -	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
> +	sbb %_ASM_DX, %_ASM_DX		/* uaccess_mask_ptr() */
>  	and %_ASM_DX, %_ASM_AX
>  	ASM_STAC
>  1:	movzbl (%_ASM_AX),%edx
> @@ -56,7 +56,7 @@ SYM_FUNC_START(__get_user_2)
>  	mov PER_CPU_VAR(current_task), %_ASM_DX
>  	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
>  	jae bad_get_user
> -	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
> +	sbb %_ASM_DX, %_ASM_DX		/* uaccess_mask_ptr() */
>  	and %_ASM_DX, %_ASM_AX
>  	ASM_STAC
>  2:	movzwl -1(%_ASM_AX),%edx
> @@ -72,7 +72,7 @@ SYM_FUNC_START(__get_user_4)
>  	mov PER_CPU_VAR(current_task), %_ASM_DX
>  	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
>  	jae bad_get_user
> -	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
> +	sbb %_ASM_DX, %_ASM_DX		/* uaccess_mask_ptr() */
>  	and %_ASM_DX, %_ASM_AX
>  	ASM_STAC
>  3:	movl -3(%_ASM_AX),%edx
> @@ -89,7 +89,7 @@ SYM_FUNC_START(__get_user_8)
>  	mov PER_CPU_VAR(current_task), %_ASM_DX
>  	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
>  	jae bad_get_user
> -	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
> +	sbb %_ASM_DX, %_ASM_DX		/* uaccess_mask_ptr() */
>  	and %_ASM_DX, %_ASM_AX
>  	ASM_STAC
>  4:	movq -7(%_ASM_AX),%rdx
> @@ -102,7 +102,7 @@ SYM_FUNC_START(__get_user_8)
>  	mov PER_CPU_VAR(current_task), %_ASM_DX
>  	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
>  	jae bad_get_user_8
> -	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
> +	sbb %_ASM_DX, %_ASM_DX		/* uaccess_mask_ptr() */
>  	and %_ASM_DX, %_ASM_AX
>  	ASM_STAC
>  4:	movl -7(%_ASM_AX),%edx
> diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
> index 7c7c92db8497..a4384b0ce013 100644
> --- a/arch/x86/lib/putuser.S
> +++ b/arch/x86/lib/putuser.S
> @@ -38,6 +38,8 @@ SYM_FUNC_START(__put_user_1)
>  	ENTER
>  	cmp TASK_addr_limit(%_ASM_BX),%_ASM_CX
>  	jae .Lbad_put_user
> +	sbb %_ASM_BX, %_ASM_BX		/* uaccess_mask_ptr() */
> +	and %_ASM_BX, %_ASM_CX
>  	ASM_STAC
>  1:	movb %al,(%_ASM_CX)
>  	xor %eax,%eax
> @@ -52,6 +54,8 @@ SYM_FUNC_START(__put_user_2)
>  	sub $1,%_ASM_BX
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
> +	sbb %_ASM_BX, %_ASM_BX		/* uaccess_mask_ptr() */
> +	and %_ASM_BX, %_ASM_CX
>  	ASM_STAC
>  2:	movw %ax,(%_ASM_CX)
>  	xor %eax,%eax
> @@ -66,6 +70,8 @@ SYM_FUNC_START(__put_user_4)
>  	sub $3,%_ASM_BX
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
> +	sbb %_ASM_BX, %_ASM_BX		/* uaccess_mask_ptr() */
> +	and %_ASM_BX, %_ASM_CX
>  	ASM_STAC
>  3:	movl %eax,(%_ASM_CX)
>  	xor %eax,%eax
> @@ -80,6 +86,8 @@ SYM_FUNC_START(__put_user_8)
>  	sub $7,%_ASM_BX
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
> +	sbb %_ASM_BX, %_ASM_BX		/* uaccess_mask_ptr() */
> +	and %_ASM_BX, %_ASM_CX
>  	ASM_STAC
>  4:	mov %_ASM_AX,(%_ASM_CX)
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
> index 7d290777246d..185ae8f56477 100644
> --- a/arch/x86/lib/usercopy_32.c
> +++ b/arch/x86/lib/usercopy_32.c
> @@ -68,7 +68,7 @@ clear_user(void __user *to, unsigned long n)
>  {
>  	might_fault();
>  	if (access_ok(to, n))
> -		__do_clear_user(to, n);
> +		__do_clear_user(uaccess_mask_ptr(to), n);
>  	return n;
>  }
>  EXPORT_SYMBOL(clear_user);
> @@ -331,7 +331,7 @@ do {									\
>  
>  unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
>  {
> -	__uaccess_begin_nospec();
> +	__uaccess_begin();
>  	if (movsl_is_ok(to, from, n))
>  		__copy_user(to, from, n);
>  	else
> @@ -344,7 +344,7 @@ EXPORT_SYMBOL(__copy_user_ll);
>  unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
>  					unsigned long n)
>  {
> -	__uaccess_begin_nospec();
> +	__uaccess_begin();
>  #ifdef CONFIG_X86_INTEL_USERCOPY
>  	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
>  		n = __copy_user_intel_nocache(to, from, n);
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index b0dfac3d3df7..abe5d2d1c49a 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -51,7 +51,7 @@ EXPORT_SYMBOL(__clear_user);
>  unsigned long clear_user(void __user *to, unsigned long n)
>  {
>  	if (access_ok(to, n))
> -		return __clear_user(to, n);
> +		return __clear_user(uaccess_mask_ptr(to), n);
>  	return n;
>  }
>  EXPORT_SYMBOL(clear_user);
> @@ -108,7 +108,7 @@ EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
>  long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
>  {
>  	unsigned long flushed, dest = (unsigned long) dst;
> -	long rc = __copy_user_nocache(dst, src, size, 0);
> +	long rc = __copy_user_nocache(dst, uaccess_mask_ptr(src), size, 0);
>  
>  	/*
>  	 * __copy_user_nocache() uses non-temporal stores for the bulk
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 5e40786c8f12..175cc8320220 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -642,7 +642,7 @@ static int copyout_mcsafe(void __user *to, const void *from, size_t n)
>  {
>  	if (access_ok(to, n)) {
>  		instrument_copy_to_user(to, from, n);
> -		n = copy_to_user_mcsafe((__force void *) to, from, n);
> +		n = copy_to_user_mcsafe(to, from, n);
>  	}
>  	return n;
>  }
> -- 
> 2.25.4
> 

-- 
Josh


Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4666C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A61420825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgESM0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:26:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:25240 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgESM0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:26:22 -0400
IronPort-SDR: blC5HPqsB6gBmfw5Dl8RgQAV2nPOL8tYKuM9Xt9xfnu2xkBfvc36fZUdqw22i9wPlQlWtlJGVb
 2F7p6oeLMicg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 05:26:21 -0700
IronPort-SDR: xLjlnrR3VX3TuxCIA8Xk3FVSSHC/bDgKA+1UJSpzDFYQ04S7jiCRI3o0vWWw1FvFte1W/DAOx3
 FXm0ZNtSsWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="373711843"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2020 05:26:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jb1K9-007dLD-KQ; Tue, 19 May 2020 15:26:21 +0300
Date:   Tue, 19 May 2020 15:26:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] vsprintf: don't obfuscate NULL and error pointers
Message-ID: <20200519122621.GD1634618@smile.fi.intel.com>
References: <20200519112657.17098-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519112657.17098-1-idryomov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 01:26:57PM +0200, Ilya Dryomov wrote:
> I don't see what security concern is addressed by obfuscating NULL
> and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> of sites where %p is used (over 10000) and the fact that NULL pointers
> aren't uncommon, it probably wouldn't take long for an attacker to
> find the hash that corresponds to 0.  Although harder, the same goes
> for most common error values, such as -1, -2, -11, -14, etc.
> 
> The NULL part actually fixes a regression: NULL pointers weren't
> obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> dereferencing invalid pointers") which went into 5.2.  I'm tacking
> the IS_ERR() part on here because error pointers won't leak kernel
> addresses and printing them as pointers shouldn't be any different
> from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> debugging based on existing pr_debug and friends excruciating.
> 
> Note that the "always print 0's for %pK when kptr_restrict == 2"
> behaviour which goes way back is left as is.
> 
> Example output with the patch applied:
> 
>                             ptr         error-ptr              NULL
> %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000
> 
> Fixes: 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid pointers")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  lib/test_printf.c | 19 ++++++++++++++++++-
>  lib/vsprintf.c    |  7 +++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> Hi Petr,
> 
> This just came up again, please consider sending this to Linus
> for 5.7.
> 
> Prior discussion was split in three threads and revolved around the
> vision for how lib/test_printf.c should be structured between Rasmus
> and yourself.  The fix itself wasn't disputed and has several acks.
> 
> If you want to restructure the test suite before adding any new
> test cases, v1 doesn't have them, but I'm reposting with test cases
> because I think it's best to add them right away to prevent further
> regressions.
> 
> v3:
> - don't use EAGAIN macro in error_pointer() test case as the
>   actual error code varies between architectures
> 
> v2:
> - fix null_pointer() test case (it didn't catch the original
>   regression because test_hashed() doesn't really test much)
>   and add error_pointer() test case
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 2d9f520d2f27..6b1622f4d7c2 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -214,6 +214,7 @@ test_string(void)
>  #define PTR_STR "ffff0123456789ab"
>  #define PTR_VAL_NO_CRNG "(____ptrval____)"
>  #define ZEROS "00000000"	/* hex 32 zero bits */
> +#define ONES "ffffffff"		/* hex 32 one bits */
>  
>  static int __init
>  plain_format(void)
> @@ -245,6 +246,7 @@ plain_format(void)
>  #define PTR_STR "456789ab"
>  #define PTR_VAL_NO_CRNG "(ptrval)"
>  #define ZEROS ""
> +#define ONES ""
>  
>  static int __init
>  plain_format(void)
> @@ -330,14 +332,28 @@ test_hashed(const char *fmt, const void *p)
>  	test(buf, fmt, p);
>  }
>  
> +/*
> + * NULL pointers aren't hashed.
> + */
>  static void __init
>  null_pointer(void)
>  {
> -	test_hashed("%p", NULL);
> +	test(ZEROS "00000000", "%p", NULL);
>  	test(ZEROS "00000000", "%px", NULL);
>  	test("(null)", "%pE", NULL);
>  }
>  
> +/*
> + * Error pointers aren't hashed.
> + */
> +static void __init
> +error_pointer(void)
> +{
> +	test(ONES "fffffff5", "%p", ERR_PTR(-11));
> +	test(ONES "fffffff5", "%px", ERR_PTR(-11));
> +	test("(efault)", "%pE", ERR_PTR(-11));
> +}
> +
>  #define PTR_INVALID ((void *)0x000000ab)
>  
>  static void __init
> @@ -649,6 +665,7 @@ test_pointer(void)
>  {
>  	plain();
>  	null_pointer();
> +	error_pointer();
>  	invalid_pointer();
>  	symbol_ptr();
>  	kernel_ptr();
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 7c488a1ce318..f0f0522cd5a7 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -794,6 +794,13 @@ static char *ptr_to_id(char *buf, char *end, const void *ptr,
>  	unsigned long hashval;
>  	int ret;
>  
> +	/*
> +	 * Print the real pointer value for NULL and error pointers,
> +	 * as they are not actual addresses.
> +	 */
> +	if (IS_ERR_OR_NULL(ptr))
> +		return pointer_string(buf, end, ptr, spec);
> +
>  	/* When debugging early boot use non-cryptographically secure hash. */
>  	if (unlikely(debug_boot_weak_hash)) {
>  		hashval = hash_long((unsigned long)ptr, 32);
> -- 
> 2.19.2
> 

-- 
With Best Regards,
Andy Shevchenko



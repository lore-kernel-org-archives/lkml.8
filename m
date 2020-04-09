Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3F920753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDIRmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:42:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:37967 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDIRmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:42:35 -0400
IronPort-SDR: SylA84Z0KW8olGt8RouNqchdi3shocSTc2sdkPBF24ots+V2wcMkIu38l2iH6QNmmxTqpk1zya
 OxIaZHnRT5Yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 10:42:33 -0700
IronPort-SDR: v8mMBOGSho6jXgQYVkBnhThOfiLso799i5EjEBsMSGg4MCflJUfL6nlKyvFiMSQHbwQzoU2K6B
 3xDMEqtquTDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="398649802"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2020 10:42:31 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jMbCD-00H1dm-QZ; Thu, 09 Apr 2020 20:42:33 +0300
Date:   Thu, 9 Apr 2020 20:42:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] lib/math: avoid trailing '\n' hidden in pr_fmt()
Message-ID: <20200409174233.GL3676135@smile.fi.intel.com>
References: <20200409163234.22830-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409163234.22830-1-christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 06:32:34PM +0200, Christophe JAILLET wrote:
> pr_xxx() functions usually have '\n' at the end of the logging message.
> Here, this '\n' is added via the 'pr_fmt' macro.
> 
> In order to be more consistent with other files, use a more standard
> convention and put these '\n' back in the messages themselves and remove it
> from the pr_fmt macro.
> 
> While at it, use __func__ instead of hardcoding a function name in the
> last message.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  lib/math/prime_numbers.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
> index 052f5b727be7..d42cebf7407f 100644
> --- a/lib/math/prime_numbers.c
> +++ b/lib/math/prime_numbers.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -#define pr_fmt(fmt) "prime numbers: " fmt "\n"
> +#define pr_fmt(fmt) "prime numbers: " fmt
>  
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -253,7 +253,7 @@ static void dump_primes(void)
>  
>  	if (buf)
>  		bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
> -	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s",
> +	pr_info("primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s\n",
>  		p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
>  
>  	rcu_read_unlock();
> @@ -273,7 +273,7 @@ static int selftest(unsigned long max)
>  		bool fast = is_prime_number(x);
>  
>  		if (slow != fast) {
> -			pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!",
> +			pr_err("inconsistent result for is-prime(%lu): slow=%s, fast=%s!\n",
>  			       x, slow ? "yes" : "no", fast ? "yes" : "no");
>  			goto err;
>  		}
> @@ -282,14 +282,14 @@ static int selftest(unsigned long max)
>  			continue;
>  
>  		if (next_prime_number(last) != x) {
> -			pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu",
> +			pr_err("incorrect result for next-prime(%lu): expected %lu, got %lu\n",
>  			       last, x, next_prime_number(last));
>  			goto err;
>  		}
>  		last = x;
>  	}
>  
> -	pr_info("selftest(%lu) passed, last prime was %lu", x, last);
> +	pr_info("%s(%lu) passed, last prime was %lu\n", __func__, x, last);
>  	return 0;
>  
>  err:
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko



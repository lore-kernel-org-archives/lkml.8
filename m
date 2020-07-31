Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC0420829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731963AbgGaIxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:53:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:26910 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731442AbgGaIxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:53:43 -0400
IronPort-SDR: qIKDb51ICZUKA8k5LIIMzOBgfWzWGtLLWZdiGdvbWfDsNnft8BjuCKq1Upw9xh2JufStLcQK7p
 xJMMACXuYzbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139309445"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="139309445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 01:53:41 -0700
IronPort-SDR: yyfBDct6Obqupft3NDNGQ27SziobH1mPne5EdykN2TR7XBXi2bQ3TCe/X5+1cvP3W661GMlh9x
 rwbWVhONr1/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="329189869"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2020 01:53:38 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1QnK-005H6q-Sz; Fri, 31 Jul 2020 11:53:38 +0300
Date:   Fri, 31 Jul 2020 11:53:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kars Mulder <kerneldev@karsmulder.nl>
Cc:     linux-kernel@vger.kernel.org, Eldad Zack <eldad@fogrefinery.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] kstrto*: correct documentation references to
 simple_strto*()
Message-ID: <20200731085338.GG3703480@smile.fi.intel.com>
References: <1ee1-5f234c00-f3-165a6440@234394593>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee1-5f234c00-f3-165a6440@234394593>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:38:58AM +0200, Kars Mulder wrote:
> The documentation of the kstrto*() functions reference the simple_strtoull
> function by "used as a replacement for [the obsolete] simple_strtoull".
> All these functions describes themselves as replacements for the function
> simple_strtoull, even though a function like kstrtol() would be more aptly
> described as a replacement of simple_strtol().
> 
> Fix these references by making the documentation of kstrto*() reference
> the closest simple_strto*() equivalent available. The functions
> kstrto[u]int() do not have direct simple_strto[u]int() equivalences, so
> these are made to refer to simple_strto[u]l() instead.
> 
> Furthermore, add parentheses after function names, as is standard in
> kernel documentation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 4c925d6031f71 ("kstrto*: add documentation")
> Signed-off-by: Kars Mulder <kerneldev@karsmulder.nl>
> 
> ---
>  include/linux/kernel.h | 4 ++--
>  lib/kstrtox.c          | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 82d91547d122..2d6050f12c64 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -346,7 +346,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the simple_strtoull. Return code must be checked.
> + * Used as a replacement for the simple_strtoul(). Return code must be checked.
>  */
>  static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
>  {
> @@ -374,7 +374,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the simple_strtoull. Return code must be checked.
> + * Used as a replacement for the simple_strtol(). Return code must be checked.
>   */
>  static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
>  {
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 1006bf70bf74..252ac414ba9a 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -115,7 +115,7 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> + * Used as a replacement for the obsolete simple_strtoull(). Return code must
>   * be checked.
>   */
>  int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
> @@ -139,7 +139,7 @@ EXPORT_SYMBOL(kstrtoull);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> + * Used as a replacement for the obsolete simple_strtoll(). Return code must
>   * be checked.
>   */
>  int kstrtoll(const char *s, unsigned int base, long long *res)
> @@ -211,7 +211,7 @@ EXPORT_SYMBOL(_kstrtol);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> + * Used as a replacement for the obsolete simple_strtoul(). Return code must
>   * be checked.
>   */
>  int kstrtouint(const char *s, unsigned int base, unsigned int *res)
> @@ -242,7 +242,7 @@ EXPORT_SYMBOL(kstrtouint);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull. Return code must
> + * Used as a replacement for the obsolete simple_strtol(). Return code must
>   * be checked.
>   */
>  int kstrtoint(const char *s, unsigned int base, int *res)
> --
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko



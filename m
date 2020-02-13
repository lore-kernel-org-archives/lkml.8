Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0972AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC215217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgBMJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:36:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:37870 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMJgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:36:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 01:36:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="347697106"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2020 01:36:44 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j2AvO-0016A1-2o; Thu, 13 Feb 2020 11:36:46 +0200
Date:   Thu, 13 Feb 2020 11:36:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, tobin@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] lib/string: update match_string() doc-strings with
 correct behavior
Message-ID: <20200213093646.GY10400@smile.fi.intel.com>
References: <20200212144723.21884-1-alexandru.ardelean@analog.com>
 <20200213072722.8249-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213072722.8249-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:27:22AM +0200, Alexandru Ardelean wrote:
> There were a few attempts at changing behavior of the match_string()
> helpers (i.e. 'match_string()' & 'sysfs_match_string()'), to change &
> extend the behavior according to the doc-string.
> 
> But the simplest approach is to just fix the doc-strings. The current
> behavior is fine as-is, and some bugs were introduced trying to fix it.
> 
> As for extending the behavior, new helpers can always be introduced if
> needed.
> 
> The match_string() helpers behave more like 'strncmp()' in the sense that
> they go up to n elements or until the first NULL element in the array of
> strings.
> 
> This change updates the doc-strings with this info.

Thanks, looks good to me now.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  lib/string.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/lib/string.c b/lib/string.c
> index f607b967d978..6012c385fb31 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -699,6 +699,14 @@ EXPORT_SYMBOL(sysfs_streq);
>   * @n:		number of strings in the array or -1 for NULL terminated arrays
>   * @string:	string to match with
>   *
> + * This routine will look for a string in an array of strings up to the
> + * n-th element in the array or until the first NULL element.
> + *
> + * Historically the value of -1 for @n, was used to search in arrays that
> + * are NULL terminated. However, the function does not make a distinction
> + * when finishing the search: either @n elements have been compared OR
> + * the first NULL element was found.
> + *
>   * Return:
>   * index of a @string in the @array if matches, or %-EINVAL otherwise.
>   */
> @@ -727,6 +735,14 @@ EXPORT_SYMBOL(match_string);
>   *
>   * Returns index of @str in the @array or -EINVAL, just like match_string().
>   * Uses sysfs_streq instead of strcmp for matching.
> + *
> + * This routine will look for a string in an array of strings up to the
> + * n-th element in the array or until the first NULL element.
> + *
> + * Historically the value of -1 for @n, was used to search in arrays that
> + * are NULL terminated. However, the function does not make a distinction
> + * when finishing the search: either @n elements have been compared OR
> + * the first NULL element was found.
>   */
>  int __sysfs_match_string(const char * const *array, size_t n, const char *str)
>  {
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko



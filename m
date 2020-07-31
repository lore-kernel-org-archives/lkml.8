Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7550720829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731985AbgGaIzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:55:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:41906 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731442AbgGaIzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:55:31 -0400
IronPort-SDR: BBBlt642vWrM5ZPobpU6T6fIq0qDLMaiNDsYo4eVI3RYeSZUO2kwYx45qIxbfYA+QH0z3ewrFM
 7Zgo3gkwlYog==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169859896"
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="169859896"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 01:55:30 -0700
IronPort-SDR: nmb+XMoh02PUfQprcyXyK12f7cs2TJZ1rnJC+wHXlxz0GZKdWy7TrE/C5yDmNNPxGzzrkwFHxR
 YzCCCsT7x3hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,417,1589266800"; 
   d="scan'208";a="304882293"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2020 01:55:28 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k1Qp5-005H7g-ML; Fri, 31 Jul 2020 11:55:27 +0300
Date:   Fri, 31 Jul 2020 11:55:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kars Mulder <kerneldev@karsmulder.nl>
Cc:     linux-kernel@vger.kernel.org, Eldad Zack <eldad@fogrefinery.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>, Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] kstrto*: do not describe simple_strto*() as
 obsolete/replaced
Message-ID: <20200731085527.GH3703480@smile.fi.intel.com>
References: <1ee1-5f234c00-f3-165a6440@234394593>
 <29b9-5f234c80-13-4e3aa200@244003027>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b9-5f234c80-13-4e3aa200@244003027>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:40:29AM +0200, Kars Mulder wrote:
> The documentation of the kstrto*() functions describes kstrto*() as
> "replacements" of the "obsolete" simple_strto*() functions. Both of
> these terms are inaccurate: they're not replacements because they have
> different behaviour, and the simple_strto*() are not obsolete because
> there are cases where they have benefits over kstrto*().
> 
> Remove usage of the terms "replacement" and "obsolete" in reference
> to simple_strto*(), and instead use the term "preferred over".

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 4c925d6031f71 ("kstrto*: add documentation")
> Fixes: 885e68e8b7b13 ("kernel.h: update comment about simple_strto<foo>() functions")
> Signed-off-by: Kars Mulder <kerneldev@karsmulder.nl>
> 
> ---
>  include/linux/kernel.h |  4 ++--
>  lib/kstrtox.c          | 12 ++++--------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 2d6050f12c64..35fd7e0e3f04 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -346,7 +346,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the simple_strtoul(). Return code must be checked.
> + * Preferred over simple_strtoul(). Return code must be checked.
>  */
>  static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
>  {
> @@ -374,7 +374,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the simple_strtol(). Return code must be checked.
> + * Preferred over simple_strtol(). Return code must be checked.
>   */
>  static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
>  {
> diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> index 252ac414ba9a..a14ccf905055 100644
> --- a/lib/kstrtox.c
> +++ b/lib/kstrtox.c
> @@ -115,8 +115,7 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoull(). Return code must
> - * be checked.
> + * Preferred over simple_strtoull(). Return code must be checked.
>   */
>  int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
>  {
> @@ -139,8 +138,7 @@ EXPORT_SYMBOL(kstrtoull);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoll(). Return code must
> - * be checked.
> + * Preferred over simple_strtoll(). Return code must be checked.
>   */
>  int kstrtoll(const char *s, unsigned int base, long long *res)
>  {
> @@ -211,8 +209,7 @@ EXPORT_SYMBOL(_kstrtol);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtoul(). Return code must
> - * be checked.
> + * Preferred over simple_strtoul(). Return code must be checked.
>   */
>  int kstrtouint(const char *s, unsigned int base, unsigned int *res)
>  {
> @@ -242,8 +239,7 @@ EXPORT_SYMBOL(kstrtouint);
>   * @res: Where to write the result of the conversion on success.
>   *
>   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> - * Used as a replacement for the obsolete simple_strtol(). Return code must
> - * be checked.
> + * Preferred over simple_strtol(). Return code must be checked.
>   */
>  int kstrtoint(const char *s, unsigned int base, int *res)
>  {
> --
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko



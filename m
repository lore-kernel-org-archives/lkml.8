Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB8C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DF820714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgBLQqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:46:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:64817 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBLQqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:46:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 08:46:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,433,1574150400"; 
   d="scan'208";a="226920523"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2020 08:46:30 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j1v9f-000yCc-3l; Wed, 12 Feb 2020 18:46:27 +0200
Date:   Wed, 12 Feb 2020 18:46:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        keescook@chromium.org, tobin@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] lib/string: update match_string() doc-strings with
 correct behavior
Message-ID: <20200212164627.GU10400@smile.fi.intel.com>
References: <20200212144723.21884-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212144723.21884-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:47:23PM +0200, Alexandru Ardelean wrote:
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
> 
> Some references to the previous attempts (in no particular order):
>   https://lore.kernel.org/lkml/20190508111913.7276-1-alexandru.ardelean@analog.com/
>   https://lore.kernel.org/lkml/20190625130104.29904-1-alexandru.ardelean@analog.com/
>   https://lore.kernel.org/lkml/20190422083257.21805-1-alexandru.ardelean@analog.com/

...

>  /**
>   * match_string - matches given string in an array
>   * @array:	array of strings
> - * @n:		number of strings in the array or -1 for NULL terminated arrays
> + * @n:		number of strings in the array to compare

But this change won't be helpful, it actually hides the part of behaviour that
is being used.

>   * @string:	string to match with
>   *
> + * This routine will look for a string in an array of strings up to the
> + * n-th element in the array or until the first NULL element.
> + *

Perhaps this needs to be rephrased. Because now it has completely hidden the -1 case.

>   * Return:
>   * index of a @string in the @array if matches, or %-EINVAL otherwise.
>   */

Ditto for the second part.

-- 
With Best Regards,
Andy Shevchenko



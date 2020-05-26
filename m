Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE29C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD73E20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgEZHE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:04:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:8968 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730279AbgEZHE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:04:56 -0400
IronPort-SDR: UnhNrubU9g9QDXY28c6E4K/dWn5RhLOEgT3u8YdBJeLYlucF0J9IWc+hBkbPe+L0TT30otoCm7
 am3oddrcINzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 00:04:56 -0700
IronPort-SDR: B611kmOgwwE11wl4NpbiHCfzPGJ3u5qywipKQwB48fOpRx4YlqewqbcMG9PQFqHVWiAEOGXwaG
 zjDbvYZiCyNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,436,1583222400"; 
   d="scan'208";a="284335349"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 26 May 2020 00:04:54 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdTdx-008wJQ-Su; Tue, 26 May 2020 10:04:57 +0300
Date:   Tue, 26 May 2020 10:04:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: use the same mechanism for get_count_order[_long]
Message-ID: <20200526070457.GI1634618@smile.fi.intel.com>
References: <20200525215958.21653-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525215958.21653-1-richard.weiyang@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 09:59:58PM +0000, Wei Yang wrote:
> These two functions share the same logic.

So, same comment. Please, add test first, make sure it works on current kernel,
then after your patch applied, and send it as a series, thanks!

P.S. W/o test code looks good, but based on my experience I'm very suspicious
about "small" changes that may lead to big issues. Hope you understand my point.

> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/linux/bitops.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 5b5609e81a84..80703ef27aee 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -188,12 +188,10 @@ static inline unsigned fls_long(unsigned long l)
>  
>  static inline int get_count_order(unsigned int count)
>  {
> -	int order;
> +	if (count == 0)
> +		return -1;
>  
> -	order = fls(count) - 1;
> -	if (count & (count - 1))
> -		order++;
> -	return order;
> +	return fls(--count);
>  }
>  
>  /**
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko



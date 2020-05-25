Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A34942071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404195AbgEYPcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:32:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:15120 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404117AbgEYPcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:32:15 -0400
IronPort-SDR: S9Fx4ajfGqhgqzo84fzOZniEiEYWXdH0rjRzZ3oAe+ab3KrAkfmSeVBv3vl5DTq1WRhYz1y7Bc
 X7k5RhCAVXtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 08:32:15 -0700
IronPort-SDR: p+bdVQOGmBhaDsJ21DrxF7LQs9nd6Wdqqg3jlOcTyeNeNoubxtYMpcwPFyN0gOkt+qoR7yRrQM
 Zum3xcRZwJWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="468078384"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2020 08:32:13 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdF5M-008ofk-F1; Mon, 25 May 2020 18:32:16 +0300
Date:   Mon, 25 May 2020 18:32:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Yang <richard.weiyang@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: simplify get_count_order_long()
Message-ID: <20200525153216.GD1634618@smile.fi.intel.com>
References: <20200524123551.9469-1-richard.weiyang@gmail.com>
 <20200525091458.GK1634618@smile.fi.intel.com>
 <20200525144312.mbw2z3ydncyasvss@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525144312.mbw2z3ydncyasvss@master>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:43:12PM +0000, Wei Yang wrote:
> On Mon, May 25, 2020 at 12:14:58PM +0300, Andy Shevchenko wrote:
> >On Sun, May 24, 2020 at 12:35:51PM +0000, Wei Yang wrote:
> >> These two cases could be unified into one.
> >
> >Care to provide a test case which supports your change?
> >
> 
> Hmm.. where should I put the test? tools/testing/selftests/ ?

I guess into test_bitops.c [1]? I though it eventually should make kernel, but I don't see it.

Andrew, can you apply that or do you need Jesse to resend?

[1]: https://lore.kernel.org/lkml/20200310221747.2848474-2-jesse.brandeburg@intel.com/

> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> ---
> >>  include/linux/bitops.h | 5 +----
> >>  1 file changed, 1 insertion(+), 4 deletions(-)
> >> 
> >> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> >> index 9acf654f0b19..5b5609e81a84 100644
> >> --- a/include/linux/bitops.h
> >> +++ b/include/linux/bitops.h
> >> @@ -206,10 +206,7 @@ static inline int get_count_order_long(unsigned long l)
> >>  {
> >>  	if (l == 0UL)
> >>  		return -1;
> >> -	else if (l & (l - 1UL))
> >> -		return (int)fls_long(l);
> >> -	else
> >> -		return (int)fls_long(l) - 1;
> >> +	return (int)fls_long(--l);
> >>  }
> >
> >-- 
> >With Best Regards,
> >Andy Shevchenko
> >
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
With Best Regards,
Andy Shevchenko



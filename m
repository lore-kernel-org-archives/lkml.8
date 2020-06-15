Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099232065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgFOJmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:42:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:6942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbgFOJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:42:38 -0400
IronPort-SDR: offu+noN/EwC/fQxuogZJLdlOO1OufjZXxh1p0bgzF+ignXowEcyNErSMb1pmyB1Ebc8aVzF6T
 80vABSUKY48w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 02:42:38 -0700
IronPort-SDR: M3NQ27sl+1uzBgjc/0gwl/4D5/lK1lE8ZEDfL9tPW7X8ZCAJIdDSY3J3fkfKQv59xc63JTaRnr
 QTqD6CN/EBvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="475956346"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 02:42:36 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jkldW-00DXOY-VP; Mon, 15 Jun 2020 12:42:38 +0300
Date:   Mon, 15 Jun 2020 12:42:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bitmap: Fix bitmap_cut() for partial overlapping case
Message-ID: <20200615094238.GR2428291@smile.fi.intel.com>
References: <cover.1592155364.git.sbrivio@redhat.com>
 <003e38d4428cd6091ef00b5b03354f1bd7d9091e.1592155364.git.sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003e38d4428cd6091ef00b5b03354f1bd7d9091e.1592155364.git.sbrivio@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 07:40:53PM +0200, Stefano Brivio wrote:
> Yury Norov reports that bitmap_cut() will not produce the right outcome
> if src and dst partially overlap, with src pointing at some location
> after dst, because the memmove() affects src before we store the bits
> that we need to keep, that is, the bits preceding the cut -- as long as
> we the beginning of the cut is not aligned to a long.
> 
> Fix this by storing those bits before the memmove().
> 
> Note that this is just a theoretical concern so far, as the only user
> of this function, pipapo_drop() from the nftables set back-end
> implemented in net/netfilter/nft_set_pipapo.c, always supplies entirely
> overlapping src and dst.

LGTM as long as test cases are passed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Yury Norov <yury.norov@gmail.com>
> Fixes: 2092767168f0 ("bitmap: Introduce bitmap_cut(): cut bits and shift remaining")
> Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
> ---
> v2: No changes
> 
>  lib/bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 89260aa342d6..c5712e8f4c38 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -211,13 +211,13 @@ void bitmap_cut(unsigned long *dst, const unsigned long *src,
>  	unsigned long keep = 0, carry;
>  	int i;
>  
> -	memmove(dst, src, len * sizeof(*dst));
> -
>  	if (first % BITS_PER_LONG) {
>  		keep = src[first / BITS_PER_LONG] &
>  		       (~0UL >> (BITS_PER_LONG - first % BITS_PER_LONG));
>  	}
>  
> +	memmove(dst, src, len * sizeof(*dst));
> +
>  	while (cut--) {
>  		for (i = first / BITS_PER_LONG; i < len; i++) {
>  			if (i < len - 1)
> -- 
> 2.27.0
> 

-- 
With Best Regards,
Andy Shevchenko



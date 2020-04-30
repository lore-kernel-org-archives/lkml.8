Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A261C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AC12166E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgD3VYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:24:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:51418 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgD3VYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:24:14 -0400
IronPort-SDR: ojCHCygKZP267MKtt84Z2Ed6iGkr0lVqWQmLWntTVLOlCFnhVTyGwRkXVsbFx9+GcBY3ZaeDrw
 kYMgG4kBUnqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 14:24:12 -0700
IronPort-SDR: Df7fajOEj/tSyneF9JgWSfkmFSgTUO/AJCWyEyuqP4sIDUhH2Gh1ZRARhBNSCthaiL+g72hSEZ
 RN8wUzEqy0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="405551477"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga004.jf.intel.com with ESMTP; 30 Apr 2020 14:24:12 -0700
Date:   Thu, 30 Apr 2020 14:24:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: Handle error at earliest for incorrect
 nr_pages value
Message-ID: <20200430212411.GB582335@iweiny-DESK2.sc.intel.com>
References: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588277518-21425-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:41:58AM +0530, Souptick Joarder wrote:
> As per documentation, pin_user_pages_fast() & get_user_pages_fast()
> will return 0, if nr_pages <= 0. But this can be figure out only after
> going inside the internal_get_user_pages_fast().

Why is nr_pages not unsigned?  I seem to have convinced myself before that
there was a good reason for it but really what is the point of calling either
of these functions with nr_pages not > 0?

> 
> This can be handled early. Adding a check for the same.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  mm/gup.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 50681f0..a13aaa6 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2817,6 +2817,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  	 */
>  	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
>  		return -EINVAL;
> +	if (nr_pages <= 0)
> +		return 0;

I think the documentation may be wrong here...  Is there a caller who expects a
return of 0 for this behavior?

It seems like these should be a warn on and return -EINVAL.  I just don't see
the use case here.

Ira

>  
>  	/*
>  	 * The caller may or may not have explicitly set FOLL_GET; either way is
> @@ -2854,6 +2856,8 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
>  	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>  	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
>  		return -EINVAL;
> +	if (nr_pages <= 0)
> +		return 0;
>  
>  	gup_flags |= FOLL_PIN;
>  	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
> -- 
> 1.9.1
> 
> 

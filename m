Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA4BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7136E207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHSRo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:44:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:39258 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHSRoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:44:54 -0400
IronPort-SDR: gqJnFc+apa+36RHMbFsCMg/QYWjtcBONZlB4fTbz5TpUWLH5wAHGEOMUr8Jog8Bs4gXLAAWFcl
 DLEo723cOH5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142984162"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="142984162"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 10:44:53 -0700
IronPort-SDR: lvWAKSOz/gYMlM8RHyPflbusPtjx/GMfDwuX4T8/btt5FTlvvXnv7z4AlyTB542e7y+X1acUpf
 Aee+KmKw5f4Q==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="472320725"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 10:44:53 -0700
Date:   Wed, 19 Aug 2020 10:44:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup: don't permit users to call get_user_pages with
 FOLL_LONGTERM
Message-ID: <20200819174452.GA104589@iweiny-DESK2.sc.intel.com>
References: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819110100.23504-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:01:00PM +1200, Barry Song wrote:
> gug prohibits users from calling get_user_pages() with FOLL_PIN. But it
> allows users to call get_user_pages() with FOLL_LONGTERM only. It seems
> insensible.
> 
> since FOLL_LONGTERM is a stricter case of FOLL_PIN, we should prohibit
> users from calling get_user_pages() with FOLL_LONGTERM while not with
> FOLL_PIN.
> 
> mm/gup_benchmark.c used to be the only user who did this improperly.
> But it has been fixed by moving to use pin_user_pages().
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

Seems reasonable to me.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  mm/gup.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index ae096ea7583f..4da669f79566 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1789,6 +1789,25 @@ static long __get_user_pages_remote(struct mm_struct *mm,
>  				       gup_flags | FOLL_TOUCH | FOLL_REMOTE);
>  }
>  
> +static bool is_valid_gup_flags(unsigned int gup_flags)
> +{
> +	/*
> +	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> +	 * never directly by the caller, so enforce that with an assertion:
> +	 */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +		return false;
> +	/*
> +	 * FOLL_PIN is a prerequisite to FOLL_LONGTERM. Another way of saying
> +	 * that is, FOLL_LONGTERM is a specific case, more restrictive case of
> +	 * FOLL_PIN.
> +	 */
> +	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
> +		return false;
> +
> +	return true;
> +}
> +
>  /**
>   * get_user_pages_remote() - pin user pages in memory
>   * @mm:		mm_struct of target mm
> @@ -1854,11 +1873,7 @@ long get_user_pages_remote(struct mm_struct *mm,
>  		unsigned int gup_flags, struct page **pages,
>  		struct vm_area_struct **vmas, int *locked)
>  {
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that with an assertion:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +	if (!is_valid_gup_flags(gup_flags))
>  		return -EINVAL;
>  
>  	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
> @@ -1904,11 +1919,7 @@ long get_user_pages(unsigned long start, unsigned long nr_pages,
>  		unsigned int gup_flags, struct page **pages,
>  		struct vm_area_struct **vmas)
>  {
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that with an assertion:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +	if (!is_valid_gup_flags(gup_flags))
>  		return -EINVAL;
>  
>  	return __gup_longterm_locked(current->mm, start, nr_pages,
> @@ -2810,11 +2821,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast_only);
>  int get_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
>  {
> -	/*
> -	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
> -	 * never directly by the caller, so enforce that:
> -	 */
> -	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
> +	if (!is_valid_gup_flags(gup_flags))
>  		return -EINVAL;
>  
>  	/*
> -- 
> 2.27.0
> 
> 
> 

Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C900BC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E232073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgATG0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:26:43 -0500
Received: from foss.arm.com ([217.140.110.172]:56178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgATG0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:26:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EBC031B;
        Sun, 19 Jan 2020 22:26:43 -0800 (PST)
Received: from [10.162.16.78] (p8cg001049571a15.blr.arm.com [10.162.16.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BFC23F52E;
        Sun, 19 Jan 2020 22:30:14 -0800 (PST)
Subject: Re: [Patch v2 2/4] mm/page_alloc.c: bad_[reason|flags] is not
 necessary when PageHWPoison
To:     Wei Yang <richardw.yang@linux.intel.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rientjes@google.com
References: <20200120030415.15925-1-richardw.yang@linux.intel.com>
 <20200120030415.15925-3-richardw.yang@linux.intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3e7b4045-cd22-552a-c28d-1605a97bbdf7@arm.com>
Date:   Mon, 20 Jan 2020 11:58:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200120030415.15925-3-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/20/2020 08:34 AM, Wei Yang wrote:
> Since function returns directly, bad_[reason|flags] is not used any
> where.
> 
> This is a following cleanup for commit e570f56cccd21 ("mm:
> check_new_page_bad() directly returns in __PG_HWPOISON case")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Acked-by: David Rientjes <rientjes@google.com>
> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0cf6218aaba7..a43b9d2482f2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2051,8 +2051,6 @@ static void check_new_page_bad(struct page *page)
>  	if (unlikely(page_ref_count(page) != 0))
>  		bad_reason = "nonzero _refcount";
>  	if (unlikely(page->flags & __PG_HWPOISON)) {
> -		bad_reason = "HWPoisoned (hardware-corrupted)";
> -		bad_flags = __PG_HWPOISON;
>  		/* Don't complain about hwpoisoned pages */
>  		page_mapcount_reset(page); /* remove PageBuddy */
>  		return;

This bail out condition should be the first in the function
check_new_page_bad() before evaluating bad_[reason|flags]
as they will never be used.

> 

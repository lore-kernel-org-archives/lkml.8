Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE48C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BAE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgDMO7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:59:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:44171 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgDMO7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:59:37 -0400
IronPort-SDR: u5Gxx2Xwnw5YqXkn4KIxiIq4+p1S56TRFc+RMwgSrKiiOLLtk0grLtV6Jv6o+qlGNH4WO3IOAB
 8AkTqolE5hHw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 07:59:35 -0700
IronPort-SDR: aI6JttEEMa41lRBY8hOt/RYwq8ioflIi4h97v53mJHsF34Js3T9zjSVwSanM/mCzFcMSJ3fNoU
 TvivJygdSS/A==
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="453180994"
Received: from ahduyck-mobl1.amr.corp.intel.com (HELO [10.254.29.128]) ([10.254.29.128])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 07:59:35 -0700
Subject: Re: [RFC PATCH 1/4] mm: reduce the impaction of page reporing worker
To:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200412090756.GA19574@open-light-1.localdomain>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <c0bd9b1b-a0e7-5c88-ab99-e867ef25c935@linux.intel.com>
Date:   Mon, 13 Apr 2020 07:59:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412090756.GA19574@open-light-1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2020 2:08 AM, liliangleo wrote:
> When scaning the free list, 'page_reporting_cycle' may hold the
> zone->lock for a long time when there are no reported page in the
> free list. Setting PAGE_REPORTING_MIN_ORDER to a lower oder will
> make this issue worse.
> 
> Two ways were used to reduce the impact:
>     1. Release zone lock periodicly
>     2. Yield cpu voluntarily if needed.
> 
> Signed-off-by: liliangleo <liliangleo@didiglobal.com>

One of the reasons why I had limited this to no lower than pageblock 
order was in order to keep number of pages we would have to walk in each 
list on the smaller side.

Also the lock ends up being released every time we report a batch of 
pages. It might make more sense to look at calling cond_resched after a 
batch as been submitted rather than try to introduce a new loop around 
page_reporting_cycle.

> ---
>   mm/page_reporting.c | 35 ++++++++++++++++++++++++++++++++---
>   1 file changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 3bbd471cfc81..3a7084e508e1 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -6,11 +6,14 @@
>   #include <linux/export.h>
>   #include <linux/delay.h>
>   #include <linux/scatterlist.h>
> +#include <linux/sched.h>
>   
>   #include "page_reporting.h"
>   #include "internal.h"
>   
>   #define PAGE_REPORTING_DELAY	(2 * HZ)
> +#define MAX_SCAN_NUM 1024
> +
>   static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>   
>   enum {
> @@ -115,7 +118,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>   	unsigned int page_len = PAGE_SIZE << order;
>   	struct page *page, *next;
>   	long budget;
> -	int err = 0;
> +	int err = 0, scan_cnt = 0;
>   
>   	/*
>   	 * Perform early check, if free area is empty there is
> @@ -145,8 +148,14 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>   	/* loop through free list adding unreported pages to sg list */
>   	list_for_each_entry_safe(page, next, list, lru) {
>   		/* We are going to skip over the reported pages. */
> -		if (PageReported(page))
> +		if (PageReported(page)) {
> +			if (++scan_cnt >= MAX_SCAN_NUM) {
> +				err = scan_cnt;
> +				break;
> +			}
>   			continue;
> +		}
> +
>   
>   		/*
>   		 * If we fully consumed our budget then update our

Why add yet another loopvariable, why not just move our budget test to 
before the PageReported check and then increase the value?

> @@ -219,6 +228,26 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
>   	return err;
>   }
>   
> +static int
> +reporting_order_type(struct page_reporting_dev_info *prdev, struct zone *zone,
> +		     unsigned int order, unsigned int mt,
> +		     struct scatterlist *sgl, unsigned int *offset)
> +{
> +	int ret = 0;
> +	unsigned long total = 0;
> +
> +	might_sleep();
> +	do {
> +		cond_resched();
> +		ret = page_reporting_cycle(prdev, zone, order, mt,
> +					   sgl, offset);
> +		if (ret > 0)
> +			total += ret;
> +	} while (ret > 0 && total < zone->free_area[order].nr_free);
> +
> +	return ret;
> +}
> +

The idea behind page reporting is it is supposed to happen while the 
system is idle. As such we don't need to be in a hurry. I would get rid 
of the loop and just let the natural placing take over so that we are 
only processing something like 1/8 of the nr_free with each pass.

>   static int
>   page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>   			    struct scatterlist *sgl, struct zone *zone)
> @@ -245,7 +274,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>   			if (is_migrate_isolate(mt))
>   				continue;
>   
> -			err = page_reporting_cycle(prdev, zone, order, mt,
> +			err = reporting_order_type(prdev, zone, order, mt,
>   						   sgl, &offset);
>   			if (err)
>   				return err;
> 

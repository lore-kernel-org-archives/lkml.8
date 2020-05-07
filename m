Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C8CC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6472080D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BEAn+G0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGI3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:29:22 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:32731 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgEGI3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588840160; x=1620376160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=kQdkQWchIS0juDhlAm9sTzb/ZBV6GvvpTp81oVs0nKE=;
  b=BEAn+G0JIzpEBYAEcZNgB1Q5leuF89dE011gS/M02OB4CzkROfYmkE4E
   vpOA1i0Nq/W7xiAkVtuQRzim9MoY33TAPk4IoviU/l4U7OPCN8NoRezoD
   8N+lCgAhxGGrh24lezDB4rm729RGZEB3pvrLRq6ayurHIjtDInom10NkX
   Q=;
IronPort-SDR: aDOPUNuQuXya77sm5jk5VJKoaxwv11GiEZNQu/vbh/VIVfIMR81jxSQod3FfgthFPlRBQvsxsb
 2h6C+r1o7xHg==
X-IronPort-AV: E=Sophos;i="5.73,363,1583193600"; 
   d="scan'208";a="33513335"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 May 2020 08:29:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id 4DA2C283958;
        Thu,  7 May 2020 08:29:14 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 08:29:13 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.175) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 May 2020 08:28:57 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <Jonathan.Cameron@Huawei.com>, SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 06/16] mm/damon: Split regions into 4 subregions if possible
Date:   Thu, 7 May 2020 10:28:36 +0200
Message-ID: <20200507082836.32145-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505110815.10532-7-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.175]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 13:08:05 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Suppose that there are a very wide and cold region and a hot region, and
> both regions are identified by DAMON.  And then, the middle small region
> inside the very wide and cold region becomes hot.  DAMON will not be
> able to identify this new region because the adaptive regions adjustment
> mechanism splits each region to only two subregions.
> 
> This commit modifies the logic to split each region to 4 subregions if
> possible so that such problematic region can eventually identified.

As you can check with the 'Evaluations' section in the cover letter of this
patchset, the extend of the slowdown DAMON's recording feature made to the
target workload has doulbed (0.55% with v9, 1.02% with this patchset).  It's
still just a small number, but the worst case slowdown is 5.29%.  It was only
1.88% before.  I suspect this patch is the reason, as this is the only one
major change we made after v9.

For the reason, I would like to make this patch to split each region into 3 sub
regions instead of 4 subregions.  It will reduce the overhead a little bit
while still allow the corner case regions be eventually detected.  If you have
other concerns or opinions, please let me know.


Thanks,
SeongJae Park

> 
> Suggested-by: James Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  mm/damon.c | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/damon.c b/mm/damon.c
> index cec946197e13..342f905927a0 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -650,26 +650,32 @@ static void damon_split_region_at(struct damon_ctx *ctx,
>  	damon_insert_region(new, r, damon_next_region(r));
>  }
>  
> -/* Split every region in the given task into two randomly-sized regions */
> -static void damon_split_regions_of(struct damon_ctx *ctx, struct damon_task *t)
> +/* Split every region in the given task into 'nr_subs' regions */
> +static void damon_split_regions_of(struct damon_ctx *ctx,
> +				     struct damon_task *t, int nr_subs)
>  {
>  	struct damon_region *r, *next;
> -	unsigned long sz_orig_region, sz_left_region;
> +	unsigned long sz_region, sz_sub = 0;
> +	int i;
>  
>  	damon_for_each_region_safe(r, next, t) {
> -		sz_orig_region = r->vm_end - r->vm_start;
> -
> -		/*
> -		 * Randomly select size of left sub-region to be at least
> -		 * 10 percent and at most 90% of original region
> -		 */
> -		sz_left_region = ALIGN_DOWN(damon_rand(1, 10) * sz_orig_region
> -					    / 10, MIN_REGION);
> -		/* Do not allow blank region */
> -		if (sz_left_region == 0 || sz_left_region >= sz_orig_region)
> -			continue;
> -
> -		damon_split_region_at(ctx, r, sz_left_region);
> +		sz_region = r->vm_end - r->vm_start;
> +
> +		for (i = 0; i < nr_subs - 1 &&
> +				sz_region > 2 * MIN_REGION; i++) {
> +			/*
> +			 * Randomly select size of left sub-region to be at
> +			 * least 10 percent and at most 90% of original region
> +			 */
> +			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
> +					sz_region / 10, MIN_REGION);
> +			/* Do not allow blank region */
> +			if (sz_sub == 0 || sz_sub >= sz_region)
> +				continue;
> +
> +			damon_split_region_at(ctx, r, sz_sub);
> +			sz_region = sz_sub;
> +		}
>  	}
>  }
>  
> @@ -687,14 +693,18 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
>  {
>  	struct damon_task *t;
>  	unsigned int nr_regions = 0;
> +	int nr_subregions = 2;
>  
>  	damon_for_each_task(ctx, t)
>  		nr_regions += nr_damon_regions(t);
>  	if (nr_regions > ctx->max_nr_regions / 2)
>  		return;
>  
> +	if (nr_regions < ctx->max_nr_regions / 4)
> +		nr_subregions = 4;
> +
>  	damon_for_each_task(ctx, t)
> -		damon_split_regions_of(ctx, t);
> +		damon_split_regions_of(ctx, t, nr_subregions);
>  }
>  
>  /*
> -- 
> 2.17.1
> 

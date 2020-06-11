Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFCE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ACtukHbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFKHV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:21:57 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:65496 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgFKHV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591860116; x=1623396116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=gbwl00sZTTSjLuUZulKop0b+V9Sx0+rsx4pCs5Nq0lo=;
  b=ACtukHbvYXS+z3a7d0MnlJa8Hh936RetravYgr9mlrOylqMs7rKB0PJy
   he5xYkQ5c/elJQG6Z2OjNIT2ATAk5ogJiJyuujAuGOJG3pMxXbJBMDkSx
   Y7/vxHd/JW/CAWCasf7qZvcfMYd8HCzJlsfSWkOXsaGLqrgz6ZO6q2XQB
   E=;
IronPort-SDR: bWmJZjixXQ/lp7pRHOuMbjeyIC51eduFj2sS8M98LomNN+XGp4GAQDgA/H1L1ZWVjVl2+LFXaB
 /7cCpTuP3zsQ==
X-IronPort-AV: E=Sophos;i="5.73,499,1583193600"; 
   d="scan'208";a="43218139"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Jun 2020 07:21:45 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 984F3A2212;
        Thu, 11 Jun 2020 07:21:42 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 07:21:41 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.34) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 11 Jun 2020 07:21:23 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <vrd@amazon.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v15 03/14] mm/damon: Implement region based sampling
Date:   Thu, 11 Jun 2020 09:21:00 +0200
Message-ID: <20200611072100.5283-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e9c0655b-0b6c-46b2-275d-22bdcd01c66f@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 22:36:00 +0200 <vrd@amazon.com> wrote:

> On 6/8/20 1:40 PM, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit implements DAMON's basic access check and region based
> > sampling mechanisms.  This change would seems make no sense, mainly
> > because it is only a part of the DAMON's logics.  Following two commits
> > will make more sense.
> > 
[...]
> > +
> > +/*
> > + * Find three regions separated by two biggest unmapped regions
> > + *
> > + * vma		the head vma of the target address space
> > + * regions	an array of three 'struct region's that results will be saved
> > + *
> > + * This function receives an address space and finds three regions in it which
> > + * separated by the two biggest unmapped regions in the space.  Please refer to
> > + * below comments of 'damon_init_regions_of()' function to know why this is
> > + * necessary.
> > + *
> > + * Returns 0 if success, or negative error code otherwise.
> > + */
> > +static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
> > +		struct region regions[3])
> > +{
> > +	struct region gap = {0}, first_gap = {0}, second_gap = {0};
> > +	struct vm_area_struct *last_vma = NULL;
> > +	unsigned long start = 0;
> > +
> > +	/* Find two biggest gaps so that first_gap > second_gap > others */
> > +	for (; vma; vma = vma->vm_next) {
> 
> Since vm_area_struct already maintains information about the largest gap below this vma
> in the mm_rb rbtree, walking the vma via mm_rb instead of the linked list, and skipping
> the ones with don't fit the gap requirement via vma->rb_subtree_gap helps avoid the
> extra comparisons in this function.

Thanks for the idea!

> 
> I measured the following implementation to be considerably faster as the number of
> vmas grows for a process damon would attach to:
> 
> -static int damon_three_regions_in_vmas(struct vm_area_struct *vma,
> +static int damon_three_regions_in_vmas(struct rb_root *root,
>  		struct region regions[3])
>  {
> +	struct rb_node *nd = NULL;
>  	struct region gap = {0}, first_gap = {0}, second_gap = {0};
> -	struct vm_area_struct *last_vma = NULL;

I like this cleanup.  I'm so wonder how I forgot using '->vm_prev'. :)

> +	struct vm_area_struct *vma = NULL;
>  	unsigned long start = 0;
>  
>  	/* Find two biggest gaps so that first_gap > second_gap > others */
> -	for (; vma; vma = vma->vm_next) {
> -		if (!last_vma) {
> -			start = vma->vm_start;
> -			last_vma = vma;
> +	for (nd = rb_first(root); nd; nd = rb_next(nd)) {
> +		vma = rb_entry(nd, struct vm_area_struct, vm_rb);

This seems meaningless to me.  This will iterate the vma tree in address order,
as same to the old code.  Moreover, 'rb_next()' and 'rb_entry()' might be
slower than the direct reference of '->vm_next'.

> +
> +		if (vma->rb_subtree_gap < sz_region(&second_gap)) {
> +			/*
> +			 * Skip this vma if the largest gap at this vma is still
> +			 * smaller than what we have encountered so far.
> +			 */
>  			continue;

This means we are skipping this node only.  It would make no big difference
from the old code, as we still iterate all nodes.

Rather than that, by the definition of the '->rb_subtree_gap', we could skip
all vmas in the subtree.  For example:

	vma = rb_entry(rb_last(vma->vm_rb), struct vm_area_struct, vm_rb);
	continue;

Nevertheless, this function is not the performance critical point, as this will
be called only once for the initial time in this patch, and the followup
patches will make this function to be called for every regions update interval,
which defaults to 1 second.  The followup patches will also allow users set the
interval large enough and even configure their own optimized version.  For the
reason, I concern simpleness ratherthan performance here.

That said, your fundamental idea obviously makes sense and the changes for that
would be subtle.  I will update this patch in abovely modified way and do some
test.

If I missed something, please let me know.


Thanks,
SeongJae Park

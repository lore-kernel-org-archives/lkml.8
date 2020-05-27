Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03143207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Uwidm5gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388415AbgE0LYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:24:04 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:37203 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbgE0LYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590578644; x=1622114644;
  h=from:to:cc:subject:date:message-id:in-reply-to;
  bh=SkdBTkPCPw//6+7hB1TmldA7QK1WyjU32WH5kGThkZg=;
  b=Uwidm5giGnOUVT9LYR1TwxCZRVSdpLB8aJEsUD0yn3e5gcHB4oCMT+NE
   ui8dcJ2yV2XjQktsiGlIkRAp+/6FZ7+Fly52OyeGj+5aOSR9VdRUHyk0k
   4tCVnnf+2SEx0mo6zWFTOEoL5fYCoDQvpSfOit4ld95ux57D0/Mj38zd+
   8=;
IronPort-SDR: ULXY+sQjRAGIg3KjwbDeavDGN2BDCGTjaN+5spJFUrnzsGMxqVRp/hvA/kB2mle1GBuaq8i8oW
 UmZk2pPDMJeA==
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="46374162"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 May 2020 11:24:03 +0000
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (pdx2-ws-svc-lb17-vlan2.amazon.com [10.247.140.66])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 311CCA1DED;
        Wed, 27 May 2020 11:23:59 +0000 (UTC)
Received: from uc85b765ebdd8595b4b67.ant.amazon.com (localhost [127.0.0.1])
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id 04RBNvc0027204;
        Wed, 27 May 2020 13:23:57 +0200
Received: (from foersleo@localhost)
        by uc85b765ebdd8595b4b67.ant.amazon.com (8.15.2/8.15.2/Submit) id 04RBNvtd027203;
        Wed, 27 May 2020 13:23:57 +0200
From:   Leonard Foerster <foersleo@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, irogers@google.com,
        jolsa@redhat.com, kirill@shutemov.name, mark.rutland@arm.com,
        mgorman@suse.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        sblbir@amazon.com, shakeelb@google.com, shuah@kernel.org,
        sj38.park@gmail.com, snu@amazon.de, vbabka@suse.cz,
        vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 05/15] mm/damon: Adaptively adjust regions
Date:   Wed, 27 May 2020 13:23:56 +0200
Message-Id: <1590578636-27155-1-git-send-email-foersleo@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20200525091512.30391-6-sjpark@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25T11:15:02+02:00 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> At the beginning of the monitoring, DAMON constructs the initial regions
> by evenly splitting the memory mapped address space of the process into
> the user-specified minimal number of regions.  In this initial state,
> the assumption of the regions (pages in same region have similar access
> frequencies) is normally not kept and thus the monitoring quality could
> be low.  To keep the assumption as much as possible, DAMON adaptively
> merges and splits each region.
> 
> For each ``aggregation interval``, it compares the access frequencies of
> adjacent regions and merges those if the frequency difference is small.
> Then, after it reports and clears the aggregated access frequency of
> each region, it splits each region into two regions if the total number
> of regions is smaller than the half of the user-specified maximum number
> of regions.
> 
> In this way, DAMON provides its best-effort quality and minimal overhead
> while keeping the bounds users set for their trade-off.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
> [...]
> +/*
> + * splits every target region into two randomly-sized regions
> + *
> + * This function splits every target region into two random-sized regions if
> + * current total number of the regions is equal or smaller than half of the
> + * user-specified maximum number of regions.  This is for maximizing the
> + * monitoring accuracy under the dynamically changeable access patterns.  If a
> + * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
> + * it.
> + */
> +static void kdamond_split_regions(struct damon_ctx *ctx)
> +{
> +	struct damon_task *t;
> +	unsigned int nr_regions = 0;
> +	static unsigned int last_nr_regions;
> +	int nr_subregions = 2;
> +
> +	damon_for_each_task(t, ctx)
> +		nr_regions += nr_damon_regions(t);
> +
> +	if (nr_regions > ctx->max_nr_regions / 2)
> +		return;
> +
> +	/* If number of regions is not changed, we are maybe in corner case */
> +	if (last_nr_regions == nr_regions &&
> +			nr_regions < ctx->max_nr_regions / 3)
> +		nr_subregions = 3;
> +
> +	damon_for_each_task(t, ctx)
> +		damon_split_regions_of(ctx, t, nr_subregions);
> +
> +	if (!last_nr_regions)
> +		last_nr_regions = nr_regions;

So we are only setting last_nr_regions once when we first come along
here (when last_nr_regions == 0). Thus we are checking from now on if
nr_regions is the same as nr_regions was before the first ever split. So
we are doing the three-way split whenever nr_regions has come to the
initial number of regions. Is this actually what we want? The naming
suggests that we want to check against the number before the last split
to detect if we have moved into a spot where we are splitting and
merging back and forth between two states (this is the corner case we
are talking about?).

Or am I misunderstanding the intention here?

Leonard

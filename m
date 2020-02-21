Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B68C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7D208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SolkEdh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgBUNwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:52:22 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28289 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgBUNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582293142; x=1613829142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=TtBhTe+Xk+Dj8T9pKB7s2pqvj4w2Mw9Dz/MJKOk2uyo=;
  b=SolkEdh6yBGn93WVFggoGJP/RSG+YIpuqY/51VtGaA0f6NYtGh7x41sq
   JTtlIRv/m2HWgl8bOQFDV7Y6pKWl7weRKFbO0rpmzPJIHuSK4o2eAtWP4
   yG0UJlF4se87lJYYop5pXgULn5Cnx5VRFNdANRYP+Cwx3iyQ8AnmnsTOW
   k=;
IronPort-SDR: 89UMV0sd3/ZhGS2vJ8ck00hlSuyDYSrGH2TmQNJ4+L6eQe/dBDCECyVQ0zLGu1ZiGpUIAKVgrZ
 T4DoVvCD6RMQ==
X-IronPort-AV: E=Sophos;i="5.70,468,1574121600"; 
   d="scan'208";a="18321703"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Feb 2020 13:52:18 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id B3E2CA2D93;
        Fri, 21 Feb 2020 13:52:09 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 21 Feb 2020 13:52:09 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.118) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 21 Feb 2020 13:51:57 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/14] mm/damon: Implement region based sampling
Date:   Fri, 21 Feb 2020 14:51:42 +0100
Message-ID: <20200221135142.8182-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217102544.29012-3-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.118]
X-ClientProxiedBy: EX13D30UWC001.ant.amazon.com (10.43.162.128) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 11:25:32 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit implements DAMON's basic access check and region based
> sampling mechanisms.  This change would seems make no sense, mainly
> because it is only a part of the DAMON's logics.  Following two commits
> will make more sense.
> 
[...]
> +/*
> + * Check whether the given region has accessed since the last check
> + *
> + * mm	'mm_struct' for the given virtual address space
> + * r	the region to be checked
> + */
> +static void kdamond_check_access(struct damon_ctx *ctx,
> +			struct mm_struct *mm, struct damon_region *r)
> +{
> +	pte_t *pte = NULL;
> +	pmd_t *pmd = NULL;
> +	spinlock_t *ptl;
> +
> +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> +		goto mkold;
> +
> +	/* Read the page table access bit of the page */
> +	if (pte && pte_young(*pte))
> +		r->nr_accesses++;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	else if (pmd && pmd_young(*pmd))
> +		r->nr_accesses++;
> +#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +	spin_unlock(ptl);
> +
> +mkold:
> +	/* mkold next target */
> +	r->sampling_addr = damon_rand(ctx, r->vm_start, r->vm_end);
> +
> +	if (follow_pte_pmd(mm, r->sampling_addr, NULL, &pte, &pmd, &ptl))
> +		return;
> +
> +	if (pte) {
> +		if (pte_young(*pte)) {
> +			clear_page_idle(pte_page(*pte));
> +			set_page_young(pte_page(*pte));
> +		}
> +		*pte = pte_mkold(*pte);
> +	}
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	else if (pmd) {
> +		if (pmd_young(*pmd)) {
> +			clear_page_idle(pmd_page(*pmd));
> +			set_page_young(pte_page(*pte));

Oops, This should be `set_page_young(pmd_page(*pmd))`.  Will fix in next spin.


Thanks,
SeongJae Park

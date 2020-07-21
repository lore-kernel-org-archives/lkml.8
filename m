Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C510C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4DF206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nSS8H5CI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgGUObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGUObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:31:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64933C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tvGZd0v1SeMgk23O6CYm8+moWpoxBTXKQ3cBxy3ez6Y=; b=nSS8H5CIDb4RAy12BXqahloGm6
        1cn3mOmfOyMPQ9e/ih9YWGsEIyuOc0NB0EXYFMCE8KU5IpTOW953Ui/TsH/+0nPJoWcO39VuTjfN/
        ypJJgPbYZbDp7fIJPzKkkON2KGhuX8gpQIr3sHLqQ+9OEuaqx90GWh418KqcsoJNbLFctWqwc1L73
        P+4/OJaPyZ5wbL48Wpy/k6FEfhA7mdr9la0NmTB1hyvBu0f8fe7nnJYxoat/NlEJzoGPI6C+uA4OL
        kh021KeUp9a7B+pklqEkG8l4iFTEqfK1+YMH+XWp3YiCDlY1p8Y5SND0vcs4SrG4XPCVHeAKT8BXN
        Tuo1WSfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxtIV-0000R9-4u; Tue, 21 Jul 2020 14:31:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBD98304D28;
        Tue, 21 Jul 2020 16:31:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A056E25E22791; Tue, 21 Jul 2020 16:31:10 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:31:10 +0200
From:   peterz@infradead.org
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V6 09/14] perf/x86/intel: Support TopDown metrics on Ice
 Lake
Message-ID: <20200721143110.GL119549@hirez.programming.kicks-ass.net>
References: <20200717140554.22863-1-kan.liang@linux.intel.com>
 <20200717140554.22863-10-kan.liang@linux.intel.com>
 <20200721124042.GX10769@hirez.programming.kicks-ass.net>
 <e9f855ad-e4bd-8766-29b6-d251c859d58f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9f855ad-e4bd-8766-29b6-d251c859d58f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:23:36AM -0400, Liang, Kan wrote:

> Patch 13 forces the slots event to be part of a metric group. In patch 7,
> for a metric group, we only update the values once with slots event.
> I think the normal case mentioned above should not happen.
> 
> +	/* Only need to call update_topdown_event() once for group read. */
> +	if ((cpuc->txn_flags & PERF_PMU_TXN_READ) &&
> +	    !is_slots_event(event))
> +		return;
> +
> +	perf_pmu_disable(event->pmu);
> +	x86_pmu.update_topdown_event(event);
> +	perf_pmu_enable(event->pmu);

Ah, I missed that.

That also requires SLOTS to be the leader so that it will be the first
read. Did we enforce that somewhere?

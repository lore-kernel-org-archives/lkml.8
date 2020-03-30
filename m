Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081B4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF8320578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r8YuM3LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgC3KoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:44:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgC3KoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Au9PCJ+qQtBKqtEbKqD0ox6LxPDdzqBdGmcvgdWSqWA=; b=r8YuM3LI5Y1cBLkKkJilTJjfpl
        9shIiVMjxN6SEH6TC++T+RqtgH/XNLpJuF++hxtFoLLCy/nfDmdjsLzuZCb2rRGlT+Q+0/ZhKjuS4
        FyYwY3GwJrg3R4DHt8uAG4fM1XD6H6Lar/przZhXxgzwEg8hWwbKVyHGTHWWuqdVf0X2EGhzf3z54
        dOBcxlEDJNuCZatD5W54Vz8dcUI3In8jzKhy1dX/+2aVT39B20ejH+VZwMcASh0fn/CF7EfscPitx
        jDAhDTwQu9mCQZT6h9EGoXrdIj+AVjUiijjHWkLNmFcrCpZ2dBtHk3dshgTho2f7cphkVsuJtYPai
        2SZMOj7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIrtz-0000Xo-Hn; Mon, 30 Mar 2020 10:44:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9DC1C306C54;
        Mon, 30 Mar 2020 12:44:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87C672856DC10; Mon, 30 Mar 2020 12:44:15 +0200 (CEST)
Date:   Mon, 30 Mar 2020 12:44:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        yun.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v3] sched/fair: Fix race between runtime distribution and
 assignment
Message-ID: <20200330104415.GF20696@hirez.programming.kicks-ass.net>
References: <20200325092602.22471-1-changhuaixin@linux.alibaba.com>
 <20200327032625.53856-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327032625.53856-1-changhuaixin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:26:25AM +0800, Huaixin Chang wrote:
> Currently, there is a potential race between distribute_cfs_runtime()
> and assign_cfs_rq_runtime(). Race happens when cfs_b->runtime is read,
> distributes without holding lock and finds out there is not enough
> runtime to charge against after distribution. Because
> assign_cfs_rq_runtime() might be called during distribution, and use
> cfs_b->runtime at the same time.
> 
> Fibtest is the tool to test this race. Assume all gcfs_rq is throttled
> and cfs period timer runs, slow threads might run and sleep, returning
> unused cfs_rq runtime and keeping min_cfs_rq_runtime in their local
> pool. If all this happens sufficiently quickly, cfs_b->runtime will drop
> a lot. If runtime distributed is large too, over-use of runtime happens.
> 
> A runtime over-using by about 70 percent of quota is seen when we
> test fibtest on a 96-core machine. We run fibtest with 1 fast thread and
> 95 slow threads in test group, configure 10ms quota for this group and
> see the CPU usage of fibtest is 17.0%, which is far more than the
> expected 10%.
> 
> On a smaller machine with 32 cores, we also run fibtest with 96
> threads. CPU usage is more than 12%, which is also more than expected
> 10%. This shows that on similar workloads, this race do affect CPU
> bandwidth control.
> 
> Solve this by holding lock inside distribute_cfs_runtime().
> 
> Fixes: c06f04c70489 ("sched: Fix potential near-infinite distribute_cfs_runtime() loop")
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> Reviewed-by: Ben Segall <bsegall@google.com>

Thanks!

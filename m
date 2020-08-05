Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325AE2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eftEKmga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgHEQtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgHEQsi (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66197C03461D
        for <Linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gt9NJuA9NqxmEUokFcw04m2QCDlb3+WQJaB6tPto9FA=; b=eftEKmgaThAuFa0orFvtGPAOiu
        s8pj8/SncERZwwqVyJQhJ7T2c+Z61TwMviUEWCveyF4i1kyZyfA8uy1LiTvm6llCjAjC6PoIO9Aqx
        U4j7p+wBzYOO/G+gNMiKJOAADsh2Xbb2XvdbOAODuX/3ovwz0OsGhu7kl+93TvAADgGq/6ZtZQ6jo
        FQ2Dqvu2Ys1XYrpC2A1gBL+XBkHvPb33oK2xvW7VF+olR5C6Q44hsdi24a4iQWr6dDFZq03+ysi0D
        s9sPHaTP6sEPY2nVSo4qoNdf08vAMqGe69DUF7K5976e8/Ex2hnMrZyLwETLlHY2PVe8k62sybSKB
        BJulv18Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Iyj-0003Pb-27; Wed, 05 Aug 2020 12:57:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0685F300F7A;
        Wed,  5 Aug 2020 14:57:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA00821493853; Wed,  5 Aug 2020 14:57:07 +0200 (CEST)
Date:   Wed, 5 Aug 2020 14:57:07 +0200
From:   peterz@infradead.org
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200805125707.GC35926@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805124454.GP2657@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 02:44:54PM +0200, peterz@infradead.org wrote:

> How's this?

Clearly I didn't even hold it near a compiler...

> ---
>  kernel/events/core.c | 38 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7c436d705fbd..3e4e328b521a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6988,23 +6988,49 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  	return callchain ?: &__empty_callchain;
>  }
>  
> +/*
> + * Due to interrupt latency (skid), we may enter the kernel before taking the
> + * PMI, even if the PMU is configured to only count user events. To avoid
> + * leaking kernel addresses, use task_pt_regs(), when available.
> + */
> +static struct pt_regs *sanitize_sample_regs(struct perf_event *event, struct pt_regs *regs)
> +{
> +	struct pt_regs *sample_regs = regs;
> +
> +	/* user only */
> +	if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
> +	    !event->attr.exclude_host   || !event->attr.exclude_guest)
> +		return sample_regs;
> +
> +	if (sample_regs(regs))
> +		return sample_regs;

That wants to he:

	if (user_regs(regs))
		return sample_regs;

> +
> +	if (!(current->flags & PF_KTHREAD)) {

s/{//

> +		sample_regs = task_pt_regs(current);
> +	else
> +		instruction_pointer_set(regs, -1L);
> +
> +	return sample_regs;
> +}

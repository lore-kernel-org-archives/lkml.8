Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5DC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444E520754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 13:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mq6P+tfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCUNZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 09:25:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54456 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgCUNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 09:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uOfIGIpRB2lO24/37Hp09bZWL3HJHLXJIpo1yxUaj/8=; b=Mq6P+tfvYLvEqgQFJ6nHXYxg4u
        lSNr6e/11mnwLyEY3LyWYwg8ippufaIhEQAss5BIVESSJU1QO2aDbyhn2krrkFga8vs1aE8jcSsvF
        YMQO8bJ/edvesCOelMsUvxXIKar7fy3dtNpD4hoiJHaxQTEd1gTS1fwz2dsHMu3IdCPYZd/NV04EZ
        1ORI9bJyJroPPrei5yXxwD4gx096PvwIApv6aeb2jJQtxFo4MjimPetwG6kK96SKcNOUYzuaBtuKN
        VZfYL8yxEmqqYFb5moD9sy/P4sn+pT1IRZ8K1qX29v8X4dm2xHhuWV29SLw2/J7jYzBtQMcekaB07
        MDQMyDkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFe7p-0000XK-8L; Sat, 21 Mar 2020 13:25:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7B743010CF;
        Sat, 21 Mar 2020 14:25:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84E1820CF2170; Sat, 21 Mar 2020 14:25:15 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:25:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf/cgroup: correct indirection in perf_less_group_idx
Message-ID: <20200321132515.GI20696@hirez.programming.kicks-ass.net>
References: <20200321013839.197114-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321013839.197114-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:38:39PM -0700, Ian Rogers wrote:
> The void* in perf_less_group_idx is to a cell in the array which points
> at a perf_event*, as such it is a perf_event**.
> 
> Fixes: 6eef8a7116de ("perf/core: Use min_heap in visit_groups_merge()")
> Author: John Sperbeck <jsperbeck@google.com>

That doesn't make sense, did he write the patch? Then there needs to be
a From: him and a SoB: him, If he reported the issue, it should be
Reported-by: him.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d22e4ba59dfa..a758c2311c53 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3503,7 +3503,8 @@ static void cpu_ctx_sched_out(struct perf_cpu_context *cpuctx,
>  
>  static bool perf_less_group_idx(const void *l, const void *r)
>  {
> -	const struct perf_event *le = l, *re = r;
> +	const struct perf_event *le = *(const struct perf_event **)l;
> +	const struct perf_event *re = *(const struct perf_event **)r;

How did this not insta explode?

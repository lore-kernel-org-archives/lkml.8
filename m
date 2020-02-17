Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02BBC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A543B214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AnkzS/6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgBQQ3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:29:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgBQQ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:29:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=veED7Jo7kFQ/SN9gWCAQtt2HrY+pVqH2/vInXfWPRo8=; b=AnkzS/6J+lSGXkA6ViCUhD9O1n
        sZuKPZQAoyYiNUld4BxSAqmJN2xJd2x0ulIS1KAaB12Gd+VH0s1kF95byFh/navbNX410DJpe9lsY
        7E+P5fBV2OEDxGRdytWuRf3A4PohIIgfH4bEhoXMSll3JryDCt4/IkbYfxi0e9CbQmAhu+wchvfIh
        mD87h3rNybVQWMUCQh/5vZCEvsrSMvF7HB06IqrMXhKhi2lfAor5O3SazKScpAzfAunq7Z3qCfy1Y
        kGpinGYeSKh8kDMtd8w3CDNfzn5ewc4WkOIxlJDhHvicjCOAzBwtjzom5crwRn3dmxUIhpzzmtdxo
        AM6bfGbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3jGs-0006bd-Cd; Mon, 17 Feb 2020 16:29:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4FC8301A66;
        Mon, 17 Feb 2020 17:27:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF0402B910516; Mon, 17 Feb 2020 17:29:19 +0100 (CET)
Date:   Mon, 17 Feb 2020 17:29:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 2/6] lib: introduce generic min-heap
Message-ID: <20200217162919.GO14879@hirez.programming.kicks-ass.net>
References: <20200214075133.181299-1-irogers@google.com>
 <20200214075133.181299-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214075133.181299-3-irogers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 11:51:29PM -0800, Ian Rogers wrote:
> Supports push, pop and converting an array into a heap. If the sense of
> the compare function is inverted then it can provide a max-heap.

+whitespace

> Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
-whitespace

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/linux/min_heap.h | 135 +++++++++++++++++++++++++++
>  lib/Kconfig.debug        |  10 ++
>  lib/Makefile             |   1 +
>  lib/test_min_heap.c      | 194 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 340 insertions(+)
>  create mode 100644 include/linux/min_heap.h
>  create mode 100644 lib/test_min_heap.c
> 
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> new file mode 100644
> index 000000000000..0f04f49c0779
> --- /dev/null
> +++ b/include/linux/min_heap.h
> @@ -0,0 +1,135 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MIN_HEAP_H
> +#define _LINUX_MIN_HEAP_H
> +
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct min_heap - Data structure to hold a min-heap.
> + * @data: Start of array holding the heap elements.
> + * @size: Number of elements currently in the heap.
> + * @cap: Maximum number of elements that can be held in current storage.
> + */
> +struct min_heap {
> +	void *data;
> +	int size;
> +	int cap;
> +};
> +
> +/**
> + * struct min_heap_callbacks - Data/functions to customise the min_heap.
> + * @elem_size: The size of each element in bytes.
> + * @cmp: Partial order function for this heap 'less'/'<' for min-heap,
> + *       'greater'/'>' for max-heap.

Since the thing is now called min_heap, 's/cmp/less/g'. cmp in C is a
-1,0,1 like thing.

> + * @swp: Swap elements function.
> + */
> +struct min_heap_callbacks {
> +	int elem_size;
> +	bool (*cmp)(const void *lhs, const void *rhs);
> +	void (*swp)(void *lhs, void *rhs);
> +};
> +
> +/* Sift the element at pos down the heap. */
> +static __always_inline
> +void min_heapify(struct min_heap *heap, int pos,
> +		const struct min_heap_callbacks *func)
> +{
> +	void *left_child, *right_child, *parent, *large_or_smallest;

's/large_or_smallest/smallest/g' ?

> +	u8 *data = (u8 *)heap->data;

void * has byte sized arithmetic

> +
> +	for (;;) {
> +		if (pos * 2 + 1 >= heap->size)
> +			break;
> +
> +		left_child = data + ((pos * 2 + 1) * func->elem_size);
> +		parent = data + (pos * func->elem_size);

> +		large_or_smallest = parent;
> +		if (func->cmp(left_child, large_or_smallest))
> +			large_or_smallest = left_child;

		smallest = parent;
		if (func->less(left_child, smallest);
			smallest = left_child;

Makes sense, no?

> +
> +		if (pos * 2 + 2 < heap->size) {
> +			right_child = data + ((pos * 2 + 2) * func->elem_size);
> +			if (func->cmp(right_child, large_or_smallest))
> +				large_or_smallest = right_child;
> +		}
> +		if (large_or_smallest == parent)
> +			break;
> +		func->swp(large_or_smallest, parent);
> +		if (large_or_smallest == left_child)
> +			pos = (pos * 2) + 1;
> +		else
> +			pos = (pos * 2) + 2;

> +/*
> + * Remove the minimum element and then push the given element. The
> + * implementation performs 1 sift (O(log2(size))) and is therefore more
> + * efficient than a pop followed by a push that does 2.
> + */
> +static __always_inline
> +void min_heap_pop_push(struct min_heap *heap,
> +		const void *element,
> +		const struct min_heap_callbacks *func)
> +{
> +	memcpy(heap->data, element, func->elem_size);
> +	min_heapify(heap, 0, func);
> +}

I still think this is a mightly weird primitive. I think I simply did:

	*evt = perf_event_group(next);
	if (*evt)
		min_heapify(..);


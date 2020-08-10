Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26BAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5C3206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xAW5FcQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHJVjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgHJVjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:39:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2093AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hoTZDamH9RBu89/0GyC18Jgld6Af8o5uEZX/Hml9wGw=; b=xAW5FcQDFhz7/yW7hmZuUtT32J
        U2dFMVYtOgSAT1D40ZFVK1Im8j+WYSnHSa47yvJG8QodMrsi8PG1Ss7rXJh2uImVHntHyoNSkD2EX
        +urlczm5B7quQLS6o+sGFfF7vtGzE4ozSMa2eUqbF+sjxmhd7KlKBfqIJ3aCFsGcR2i/YEwJapclm
        aDDASjA/KVW4CrzLspyD23LzjSbx98hf612Gq6ZN+/kxpo0RFF0+WQkTRyGePwOMc7vUfaODh0/Fq
        RvLqaqgbvsmzMQuR+4r6vUISb9xFBHTx39INCp+hmAB5BqkkPzquQ/nfD76+EGi3V3ONtMQWtLg4X
        r3okyMmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5FVf-00055J-62; Mon, 10 Aug 2020 21:39:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89E16980D39; Mon, 10 Aug 2020 23:39:09 +0200 (CEST)
Date:   Mon, 10 Aug 2020 23:39:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH V6 01/16] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20200810213909.GJ3982@worktop.programming.kicks-ass.net>
References: <20200810212436.8026-1-kan.liang@linux.intel.com>
 <20200810212436.8026-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810212436.8026-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:24:21PM -0700, Kan Liang wrote:
> Current perf can report both virtual addresses and physical addresses,
> but not the page size. Without the page size information of the utilized
> page, users cannot decide whether to promote/demote large pages to
> optimize memory usage.
> 
> Add a new sample type for the data page size.
> 
> Current perf already has a facility to collect data virtual addresses.
> A page walker is required to walk the pages tables and calculate the
> page size from a given virtual address.
> 
> On some platforms, e.g., X86, the page walker is invoked in an NMI
> handler. So the page walker must be IRQ-safe and low overhead. Besides,
> the page walker should work for both user and kernel virtual address.
> The existing generic page walker, e.g., walk_page_range_novma(), is a
> little bit complex and doesn't guarantee the IRQ-safe. The follow_page()
> is only for user-virtual address.
> 
> Add a new function perf_get_page_size() to walk the page tables and
> calculate the page size. In the function:
> - Interrupts have to be disabled to prevent any teardown of the page
>   tables.
> - The size of a normal page is from the pre-defined page size macros.
> - The size of a compound page is retrieved from the helper function,
>   page_size().
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

>  /* default value for data source */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 52ca2093831c..32484accc7a3 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -143,8 +143,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>  	PERF_SAMPLE_AUX				= 1U << 20,
>  	PERF_SAMPLE_CGROUP			= 1U << 21,
> +	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
>  
> -	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 23,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };

> @@ -7151,6 +7269,9 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	}
>  #endif
>  
> +	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
> +		data->data_page_size = perf_get_page_size(data->addr);
> +

We could just require SAMPLE_DATA_PAGE requires SAMPLE_ADDR.

Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41BC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746252077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSHHxChO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgATJXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:23:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgATJXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4uEiMVm/2RivzprYXuYQzMtYidTlX8YQdwZ9M5LzWJ4=; b=XSHHxChOVmqtgqoywdk9bNqWL
        I4EuDnnLiBTMkuhcDZ/9nrRIMupvn9VaQBoObNgj5yAoEuIiRwQUsxTtvr/6TIF/QyIfNrrogywW2
        DkePG5DtROgRlLevwB956wgkpcf8Q0SOpdXSggLzBjF0GnprkFVykDJGNnkDqK5LYj5zTpX03c8/4
        uj1Mbao42UwkxwlMaN/UxdmoFpYDfb3HSV9E5B3whDka9yetIOkpKcOYVeutQJIx3MZyjxjfGxMPx
        r9Iwq/zeSwKAPj/svpkg/Ci9jJlx3IZLHvee8RzUlUhhMZPIswiYsKqX/Ir3OwnqHQMWB6G187i9U
        PcGFdo5sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itTGx-0007mM-57; Mon, 20 Jan 2020 09:23:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BBD4305D3F;
        Mon, 20 Jan 2020 10:21:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F3FF2041FB24; Mon, 20 Jan 2020 10:23:00 +0100 (CET)
Date:   Mon, 20 Jan 2020 10:23:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     eranian@google.com, acme@redhat.com, mingo@kernel.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, vitaly.slobodskoy@intel.com,
        pavel.gerasimov@intel.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V5 1/2] perf/core: Add new branch sample type for
 HW index of raw branch records
Message-ID: <20200120092300.GK14879@hirez.programming.kicks-ass.net>
References: <20200116155757.19624-1-kan.liang@linux.intel.com>
 <20200116155757.19624-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116155757.19624-2-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 07:57:56AM -0800, kan.liang@linux.intel.com wrote:

>  struct perf_branch_stack {
>  	__u64				nr;
> +	__u64				hw_idx;
>  	struct perf_branch_entry	entries[0];
>  };

The above and below order doesn't match.

> @@ -849,7 +853,11 @@ enum perf_event_type {
>  	 *	  char                  data[size];}&& PERF_SAMPLE_RAW
>  	 *
>  	 *	{ u64                   nr;
> -	 *        { u64 from, to, flags } lbr[nr];} && PERF_SAMPLE_BRANCH_STACK
> +	 *        { u64 from, to, flags } lbr[nr];
> +	 *
> +	 *        # only available if PERF_SAMPLE_BRANCH_HW_INDEX is set
> +	 *        u64			hw_idx;
> +	 *      } && PERF_SAMPLE_BRANCH_STACK

That wants to be written as:

		{ u64			nr;
		  { u64 from, to, flags; } entries[nr];
		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
		} && PERF_SAMPLE_BRANCH_STACK

But the big question is; why isn't it:

		{ u64			nr;
		  { u64	hw_idx; } && PERF_SAMPLE_BRANCH_HW_INDEX
		  { u64 from, to, flags; } entries[nr];
		} && PERF_SAMPLE_BRANCH_STACK

to match the struct perf_branch_stack order. Having that variable sized
entry in the middle just seems weird.

>  	 *
>  	 * 	{ u64			abi; # enum perf_sample_regs_abi
>  	 * 	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER

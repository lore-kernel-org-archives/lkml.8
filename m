Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4683EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CB7206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaIeeDH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHKH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgHKH7i (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:59:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD61DC06174A
        for <Linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tmLs+QilYKUZTKQ3uTScZNsmKC3Uh/2MkcPg+WGingM=; b=FaIeeDH1ObZsUZV1Q+NIMbiICS
        WhADg+iBdbMI5tc+XyicIhjjEgt/fF+zNslnKWhYR/oXIS6aUt5rkCXmySw+tj2VwjRxnESDa2PEI
        Ph6/MqYpPc2dDzyPpyO/bSkSDOSkqn/7t0jwvwFn4DQUyMwQad3TjrYOoHXDAkcRNqvntNSuyLKKa
        q1ZKItqR1im/OGn4Ckg6lfBvkyC7AlltUskpTBc6Z9PbHZBBwo2FRCpS8lH5Xdo0P2l5Ba/GAZyOi
        gTngKcz3ql4aWS3EBvhwifC1i+cMSBAWn7IuMWYqpEn+AXqfby9iIsyIuEeerESYsWgr03Co8frrw
        WSpdCBGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5PBs-0006Qk-IW; Tue, 11 Aug 2020 07:59:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35260980C9D; Tue, 11 Aug 2020 09:59:24 +0200 (CEST)
Date:   Tue, 11 Aug 2020 09:59:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200811075924.GU3982@worktop.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
 <20200805124454.GP2657@hirez.programming.kicks-ass.net>
 <797aa4de-c618-f340-ad7b-cef38c96b035@linux.intel.com>
 <56957a58-6292-e075-8c30-6230450e3518@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56957a58-6292-e075-8c30-6230450e3518@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 03:50:43PM +0800, Jin, Yao wrote:
> Could I post v2 which basically refers to your patch but removes some
> conditions since I see some issues in test if we use these conditions.
> 
>  1. Remove '!event->attr.exclude_hv || !event->attr.exclude_host ||
>     !event->attr.exclude_guest' at the entry of sanitize_sample_regs().
> 
>  2. Remove '!attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest'
>     at the perf_event_open syscall entry.

exclude_host, maybe -- due to the dodgy semantics of it, but the others
should definitely be there.

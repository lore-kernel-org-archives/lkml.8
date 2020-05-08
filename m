Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9841C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C5921582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ybDSzZt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEHMhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728206AbgEHMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:41 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABDEC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y7eo/kthFv+jU492am4UV1p0pzBvF+1Aydepv2pZArg=; b=ybDSzZt0JqS21b80ZdF+fQayMF
        MdEpxnC5rcyb8ygtTOOX5nC8bKZqGNLuGqx2Hho/BTMiS9TzOC2dMHjy96VUN2telvLIA0Ye80Cu8
        kesotaHeogF/CZUctpujx2hAUt48ZUMEjHlkVT6Ix/dBXOJH/XACsp88Cw1XpiDjrEDhzRDgEq3Ql
        PuJhWRe9ve4+T4UrdlB3CBNiJ23/0ftZguTIRjRG/lsAYRJTPrzKGOyBNhGYXQ93uxoHJNVRmQffn
        BxeKbE6lAr6ipMSrBwYb01Ntu9Y0rCS7kluUh78j2n5eM73aliUgTyZy9+XkTtkje3R29SaPdT3mQ
        tP1/HwTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX2Fi-0001Pv-IF; Fri, 08 May 2020 12:37:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03AE4306DC5;
        Fri,  8 May 2020 14:37:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCC432B8D3817; Fri,  8 May 2020 14:37:15 +0200 (CEST)
Date:   Fri, 8 May 2020 14:37:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Replace zero-length array with
 flexible-array
Message-ID: <20200508123715.GG5281@hirez.programming.kicks-ass.net>
References: <20200507190615.GA15677@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507190615.GA15677@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 02:06:15PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/x86/events/intel/bts.c              |    2 +-
>  arch/x86/events/intel/uncore.h           |    2 +-
>  include/linux/perf_event.h               |    4 ++--
>  kernel/events/callchain.c                |    2 +-
>  kernel/events/internal.h                 |    2 +-
>  tools/perf/bench/sched-messaging.c       |    2 +-
>  tools/perf/builtin-inject.c              |    2 +-
>  tools/perf/builtin-script.c              |    2 +-
>  tools/perf/builtin-timechart.c           |    2 +-
>  tools/perf/util/annotate.h               |    4 ++--
>  tools/perf/util/branch.h                 |    2 +-
>  tools/perf/util/cputopo.h                |    2 +-
>  tools/perf/util/dso.h                    |    4 ++--
>  tools/perf/util/event.h                  |    2 +-
>  tools/perf/util/jitdump.c                |    2 +-
>  tools/perf/util/jitdump.h                |    6 +++---
>  tools/perf/util/ordered-events.h         |    2 +-
>  tools/perf/util/pstack.c                 |    2 +-
>  tools/perf/util/symbol.h                 |    2 +-
>  tools/perf/util/unwind-libunwind-local.c |    2 +-
>  20 files changed, 25 insertions(+), 25 deletions(-)
> 

Arnaldo, do you want this, or should I take it?

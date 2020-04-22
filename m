Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA7C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9D120784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="natgqUeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgDVLrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726061AbgDVLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:47:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF091C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5c36qYY3DsYBZqhdm79liDlMg19bbaAYWX92R1Gw6eU=; b=natgqUeBA6dgCiDbTbPcUIlXX4
        SwaEKqzAYYHwPR0vlt0gJZt/Pmi5IMy1nHFTXSVAXq1eHJ5e/84PSvH1hFk7pRvopHB+6hwhxB8Tm
        j5fknpXYs+qizeLjU2zHv65TQBeAa349ck/MCGhfpazI0ujLHkzzZ+Pq3QOQt/R3heHUCMbsDNdW/
        PUFub2fddHUbnOl9jIFW2+Din4OiDuryB6nrnn8w0yyw+ytp4ObeHOwv9JJr2EwNT1VQfvZCzSHH4
        NUE4DoQCuynSdNhEHZNyGFm8p44eEGwzvde0HzubAnE1KQADrQDH75JjGIQVp3jCMftyxRxPB//FL
        MMGhvdFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDqH-0001jV-FH; Wed, 22 Apr 2020 11:47:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43D95306064;
        Wed, 22 Apr 2020 13:46:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2ACB6203AA837; Wed, 22 Apr 2020 13:46:59 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:46:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
Message-ID: <20200422114659.GE20730@hirez.programming.kicks-ass.net>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-9-adrian.hunter@intel.com>
 <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
 <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:39:06AM +0300, Adrian Hunter wrote:
> On 21/04/20 4:45 pm, Peter Zijlstra wrote:
> > On Sun, Apr 05, 2020 at 11:13:20PM +0300, Adrian Hunter wrote:
> >> Add perf text poke events for ftrace trampolines when created and when
> >> freed.
> > 
> > Maybe also put in a little more detail on the various events. Because
> > arch_ftrace_update_trampoline() can also generate text_poke_bp() events,
> > to update an existing trampoline.
> > 
> > A diagram, like with the kprobes thing perhaps.
> 
> How about adding this:
> 
> There can be 3 text_poke events for ftrace trampolines:
> 
> 1. NULL -> trampoline
>    By ftrace_update_trampoline() when !ops->trampoline
>    Trampoline created
> 
> 2. [e.g. on x86] CALL rel32 -> CALL rel32
>    By arch_ftrace_update_trampoline() when ops->trampoline and
>                         ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
>    [e.g. on x86] via text_poke_bp() which generates text poke events
>    Trampoline-called function target updated
> 
> 3. trampoline -> NULL
>    By ftrace_trampoline_free() when ops->trampoline and
>                  ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
>    Trampoline freed

Yes, very nice. Thanks!

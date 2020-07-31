Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D18CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C15F2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G5Unzz6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbgGaSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgGaSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:05:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EC0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t1zAWmfo6qZtPbotvLd0epPAf9W0ABBv1rEkWfGnG6M=; b=G5Unzz6CF86b4LiWMq14iFn1a0
        k335RypiF19sg+JpP4kuO5gOOvqtUJpqPeXAF8kEDx/AHklbwDoYY20wCwIQjhzEZeQELdFdZmhe+
        Q72Xbc933oafaTBi/l6LEonJXabKCu/uTEMwHCCm/RyUq68jWZWSqB4t+UwOEM8SsCIYh94r5MliY
        Qg9wAXER+eY1aB0ofmrgYCW0WLLhvKRAk9z7sH0g7sJDV1vj7h7XFNYYQZbAbUPqcdjQXt68i3i1W
        Ui0Zc8Vq9ayh0rnkxON5TOIcyvp+5V0jU9ILXlDkFGS5/JVGoKx8+8GdSyjLuWamiESSFNp1zKri8
        wtA8Zmnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1ZPZ-0001r8-Eg; Fri, 31 Jul 2020 18:05:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 966B33050F0;
        Fri, 31 Jul 2020 20:05:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64849203C70DC; Fri, 31 Jul 2020 20:05:39 +0200 (CEST)
Date:   Fri, 31 Jul 2020 20:05:39 +0200
From:   peterz@infradead.org
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, David Ahern <dsahern@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
Message-ID: <20200731180539.GA2674@hirez.programming.kicks-ass.net>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
 <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
 <20200731074726.GA1485940@krava>
 <20200731153612.GC1299820@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731153612.GC1299820@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:36:12AM -0700, Andi Kleen wrote:
> > yep, we have a customer that needs to compare data from multiple servers
> 
> It's also needed to correlate over different guests on the same machine.
> This is an important use case.

Both these cases you want to sync up CLOCK_MONOTONIC, using walltime is
just utterly misguided.

What happens if the servers have (per accident or otherwise) different
DST settings, or someone does a clock_setttime() for giggles.

All you really want is a clock that runs at the same rate but is not
subject to random jumps and user foibles.

Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56750C54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14BD120753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 09:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8w2AT/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVJMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:12:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 05:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TJrI/72OolCj0fyJBBsdmgL621cjAq707kYl/3sgaOE=; b=m8w2AT/g/c3Gy5hP6+GASiHSoJ
        kCNFcjRYnHvnyVeh19O9WbN6E7jnixRqOxe3bWveDmmXxWiTNk0Xfss/U871xUqNa/g4QG6QAHnCS
        LX/AtZ8M7mvYd+hQ4Z6/O8jrVHWEsxlMcbSJOdazw2Rc+rdNT2+RXpHle+yxNE7+Z4vaTceGAKQnH
        MEyQz0pFQIgTACP5e+PKS6QnZTVddYGpFJ8RUfgNFJdO6qvnhTFAHD21MO5DAwJjBOg13p5vP58wL
        zBev04E5hcTo/BgfBaQJJ5UGHhhFeo/ZhVUV+JicEPob6r/P+jxxHzwsxpfMY3rJH34Zs1tJc8uq4
        7sziHuPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFwey-0005Jk-9G; Sun, 22 Mar 2020 09:12:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F62F983500; Sun, 22 Mar 2020 09:35:44 +0100 (CET)
Date:   Sun, 22 Mar 2020 09:35:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test x86: address multiplexing in rdpmc test
Message-ID: <20200322083544.GE2452@worktop.programming.kicks-ass.net>
References: <20200321001400.245121-1-irogers@google.com>
 <20200321134053.GJ20696@hirez.programming.kicks-ass.net>
 <CAP-5=fXcHrh=uHmPj43=xYnikx0mHRWFQwMJa1q8yQ=opvSEDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXcHrh=uHmPj43=xYnikx0mHRWFQwMJa1q8yQ=opvSEDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 10:44:49AM -0700, Ian Rogers wrote:
> On Sat, Mar 21, 2020 at 6:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Mar 20, 2020 at 05:14:00PM -0700, Ian Rogers wrote:
> > > Counters may be being used for pinned or other events which inhibit the
> > > instruction counter in the test from being scheduled - time_enabled > 0
> > > but time_running == 0. This causes the test to fail with division by 0.
> > > Add a sleep loop to ensure that the counter is run before computing
> > > the count.

> > > +
> > > +                     if (running == 0) {
> >
> > This is not in fact the condition the Changelog calls out.
> 
> Not sure I follow. As in the multiplexing? It is exactly the condition
> that time_running == 0.

I meant the condition should be 'enabled && !running'.

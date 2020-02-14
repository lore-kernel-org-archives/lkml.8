Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56357C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6122187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tf4KMkWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392427AbgBNRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:37:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387566AbgBNRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nr8dc65Z/q/8A+WtruCX26CcC/LTkMCzKZawK5yXtHc=; b=Tf4KMkWHFrljmVBhrYMWj7YnUm
        lMuDhc+cLFNpTcJ391Ib6a/TbyJ38iZ2ydjcI+5hzUOdAwJYP+VxiyQxcGDK21TeXCWpQ6g047/t7
        t06my+JqVLs4FwHwjopqA7jZSQqAzYeJeddRdbU1IV82ycqEzuIIoq1cfg84wzT2R1mpSMkCpyzxH
        1jSodJ6rK9GqjQ8ghqr9ELtsALOpvH7yru9FRoyonxiwLjbSxPTN7cRRj1UXIGDk2ShOxJj6yEtIF
        OLdReRiq0zD9BOQPIxNj8Z1IpHX4ps5BTb3JPDoDmHSglsCVXNNXvTboxtgWK59xb+y7tJoYOlMEC
        oNGAYI1Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2euI-0001RF-Ac; Fri, 14 Feb 2020 17:37:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 281B3307B91;
        Fri, 14 Feb 2020 18:35:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C366820B33554; Fri, 14 Feb 2020 18:37:34 +0100 (CET)
Date:   Fri, 14 Feb 2020 18:37:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Subject: Re: [PATCH v6 1/6] perf/cgroup: Reorder perf_cgroup_connect()
Message-ID: <20200214173734.GN14914@hirez.programming.kicks-ass.net>
References: <20191206231539.227585-1-irogers@google.com>
 <20200214075133.181299-1-irogers@google.com>
 <20200214075133.181299-2-irogers@google.com>
 <28dafe17-5a63-cc69-4f1e-fd75edb8b1bd@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28dafe17-5a63-cc69-4f1e-fd75edb8b1bd@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 09:11:24AM -0700, Shuah Khan wrote:
> On 2/14/20 12:51 AM, Ian Rogers wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Move perf_cgroup_connect() after perf_event_alloc(), such that we can
> > find/use the PMU's cpu context.
> 
> Can you elaborate on this usage? It will helpful to know how
> this is used and what do we get from it. What were we missing
> with the way it was done before?

It says so right there. We need it after perf_event_alloc() so that we
can find/use the event's PMU cpu context.

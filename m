Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D67C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0E20707
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xF9LzHEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbgEZVyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:54:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38060 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389025AbgEZVyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pBdj0zFH6qn+s7a+72XnkjTzpnjbcAx9OlA+W5CsagI=; b=xF9LzHEcR8F3Stc5e6BKjjfdxW
        v5hTIrAM1q5XkZqcomMP2gA0XQM19ENu9mUkPE8d8IN4DpJ2udUUXW2cMacLBEzrclHF9FTv5QkOR
        BJlRB8eX3bn5RUz7ajh1nopqxpLrhX5TNh4xEcbw/VuX+3ZRq38MYftQ0Muoz6ySMX8lZ0Mtg6ciZ
        7ugfQdlx6DYL5tCiHOxRaCNmfhwCNTDRYoimfQsNlGzvqeVAlFUu9H+s/M3HT93cBaYys6KTpGwty
        uZM1a+mDlQ6Hi30yN8ijP6A/H1eATq024XCxg6FT5I6ZLvr9yZiqvP1uc9dPGduEXGrjrirP8loDx
        Cp5DUBwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdhWa-0008Jx-WA; Tue, 26 May 2020 21:54:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 344B09834AB; Tue, 26 May 2020 23:54:15 +0200 (CEST)
Date:   Tue, 26 May 2020 23:54:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <20200526215415.GH2483@worktop.programming.kicks-ass.net>
References: <20200526212826.4097888-1-songliubraving@fb.com>
 <20200526213913.GG2483@worktop.programming.kicks-ass.net>
 <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:46:29PM +0000, Song Liu wrote:
> 
> 
> > On May 26, 2020, at 2:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Tue, May 26, 2020 at 02:28:26PM -0700, Song Liu wrote:
> >> It is useful to trace functions in kernel/event/core.c. Allow ftrace for
> >> them by removing $(CC_FLAGS_FTRACE) from Makefile.
> > 
> > Did you try using the ftrace event with perf with this on?
> 
> I have tried a few things, like 
> 
>   perf stat -e probe:perf_read -I 1000
>   perf record -e probe:__x64_sys_perf_event_open -aR
> 
> They all work fine. 
> 
> Do you have some tricky functions that we should double check?

I've no idea what probe: does. iirc there's something like
ftrace:function that is like regular function tracing.

At some point using that made the kernel really sick due to recursion
between ftrace and perf. Quite possibly that's been fixed, dunno.

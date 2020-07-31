Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074E122B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LrZ1HXS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgGaRU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729944AbgGaRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:20:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BEQZGFz2zyuCgyEWRRLllezcZ3YAqzZtIi2etzzWTQ=; b=LrZ1HXS6ViVyE0DVAAxdJiejyl
        cW+KEbW1oIx22XnqVTnPeI5ujto/D4SotYTJ6deM5ly0wsy55hWHeXGOq3wlh317U3TIYyJCvJquB
        kcnvrgcR6JFdj3OASMJWcFdPRKP3Q3flMKHMdkUP8j7TU0c1m4I4PE7qZZnrpRCch/mz1lFAPT55m
        543U9IBFMMuMlcYF7hiTt2jK0PULpqTghGr0lnBIAaBeGIIbSHGSyO3GZ7fLXvzlWgEW5IricnjSq
        Vus25K8dz3GJ/6egXFsoaC584e/iOEGdxqbrW/enwZc1ouS6erSc6Yc0LLaNm71/7mrBri9R+IaQJ
        /kd48RzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1YhV-0005y4-Ne; Fri, 31 Jul 2020 17:20:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A1993050F0;
        Fri, 31 Jul 2020 19:20:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15627203C0A49; Fri, 31 Jul 2020 19:20:06 +0200 (CEST)
Date:   Fri, 31 Jul 2020 19:20:06 +0200
From:   peterz@infradead.org
To:     David Ahern <dsahern@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 0/6] perf tools: Add wallclock time conversion support
Message-ID: <20200731172006.GJ2638@hirez.programming.kicks-ass.net>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
 <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 07:21:54PM -0600, David Ahern wrote:
> On 7/30/20 4:14 PM, peterz@infradead.org wrote:
> > On Thu, Jul 30, 2020 at 11:39:44PM +0200, Jiri Olsa wrote:
> > 
> >> The patchset is adding the ability to display TOD/wallclock timestamp
> >> in 'perf script' output and in 'perf data convert --to-ctf' subcommand,
> >> so the converted CTF data contain TOD/wallclock timestamps.
> > 
> > But why? Wallclock is a horrible piece of crap. Why would you want to do
> > this?
> > 
> 
> Same reason I brought this up 9+ years ago: userspace lives on
> time-of-day, and troubleshooting is based on correlating timestamps from
> multiple sources. To correlate a perf event to syslog or an application
> log, we need time-of-day.

You need a sync'ed CLOCK_MONOTONIC for that, CLOCK_REALTIME 'aka'
wallclock is a trainwreck, you don't ever want that.




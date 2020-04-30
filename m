Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FBC47257
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74C720775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aN/fCmTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgD3QFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728120AbgD3QFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:05:11 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978EAC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=URPLn5pgzF++a93dLmF3+s/KGIoSJpOQpC6i9HTyCgA=; b=aN/fCmTLZqCteuonTlnFbh4fN7
        xVyHgAG3ZT56rON9zfhx6NnVrFUREqTEOl0AkZP6MZDlEZ/mLh2AlOySnc8ZT49SwjaSMjIqnPlrd
        hSz10o0po1rBaN49yHevtwzk8x5IIvAe+cgvDjCH1SSP8wHIbIEKUZ6jUbMUGymYT0COrKKace3hD
        b3ZoWP6nrAROEiKjO1ofjtHZk8GDGgLcxo42v5hdOioYTAafhTMhp8tXYnB5FleMtmWBXTQe1/uaf
        w7NUyNy/n9BaUkBVsGILWlk5vpgVSFf6vcRs8WJgcqdweiJq4PvcgX2baB/QDi51XL6kvJ9q4pDoF
        J+I62Q2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUBfz-0004Ip-Oh; Thu, 30 Apr 2020 16:04:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74F7530275A;
        Thu, 30 Apr 2020 18:04:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C79729C3DBFD; Thu, 30 Apr 2020 18:04:36 +0200 (CEST)
Date:   Thu, 30 Apr 2020 18:04:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200430160436.GC13575@hirez.programming.kicks-ass.net>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 04:29:23PM +0100, Marc Zyngier wrote:

> I wonder if we could/should make __sched_clock_offset available even when
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK isn't defined. It feels like it would
> help with this particular can or worm...

Errrgh. __sched_clock_offset is only needed on x86 because we transition
from one clock device to another on boot. It really shouldn't exist on
anything sane.

Let me try and understand your particular problem better.

Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE464C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F18206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596304640;
	bh=Zi6dF7CKgLHrTs2UgzhtHjEuDKvkS1n6UeU/yFQ+VsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HOgWQbth910LZ6xiAzHVDheKLJ1ebeoRoh+f0QFd1MYVCvOETGugFw6KWsmMZ9tH2
	 SMA7o9xVveEptb7zLhRO5DgACYMSKp+sjnADWVPxem6TtByLvqce1yqz9BzQnD47y+
	 Rac3aPxCsN8tiOryWZQCuFbgqRBjXjGIhhe+k7NU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHARtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 13:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgHARtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:49:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD222065E;
        Sat,  1 Aug 2020 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596304146;
        bh=Zi6dF7CKgLHrTs2UgzhtHjEuDKvkS1n6UeU/yFQ+VsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTXgoGlLvUKbXYUaJI9Vrx7+PxazL2bWGHklhZl5UGhRlAwaGSRhUGhQMsV2oksCM
         srZiIpuhg8jIa4b+9szhOYc6rO93QRl+jS/fqDpVKLvVe+2WZg/mm8+NUoh38SSsFg
         VVmpb2Yz1J/KFCrCKNt9rz4jlXIBGvp10DqxPhNU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 88AE540E7E; Sat,  1 Aug 2020 14:49:04 -0300 (-03)
Date:   Sat, 1 Aug 2020 14:49:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     peterz@infradead.org, Andi Kleen <ak@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20200801174904.GA2740416@kernel.org>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730221423.GH2638@hirez.programming.kicks-ass.net>
 <a59b833f-bcb7-3d1b-6e0c-8758b47b93a3@gmail.com>
 <20200731074726.GA1485940@krava>
 <20200731153612.GC1299820@tassilo.jf.intel.com>
 <20200731180539.GA2674@hirez.programming.kicks-ass.net>
 <27a4663d-bc71-5f52-5871-23d4061fe575@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a4663d-bc71-5f52-5871-23d4061fe575@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 31, 2020 at 06:46:21PM -0600, David Ahern escreveu:
> On 7/31/20 12:05 PM, peterz@infradead.org wrote:
> > On Fri, Jul 31, 2020 at 08:36:12AM -0700, Andi Kleen wrote:
> >>> yep, we have a customer that needs to compare data from multiple servers

> >> It's also needed to correlate over different guests on the same machine.
> >> This is an important use case.

> > Both these cases you want to sync up CLOCK_MONOTONIC, using walltime is
> > just utterly misguided.

> Every userspace component logs in walltime. You can say that is
> misguided, but that is the way it is. The missing piece is the ability
> to correlate kernel events to userspace logs.

> > What happens if the servers have (per accident or otherwise) different
> > DST settings, or someone does a clock_setttime() for giggles.
 
> Yes, someone *could* change the time. Someone *could* start ntpd or
> other time server in the middle of a session. While technically such
> things can happen, that is not real life in most environments (e.g.,
> Data center servers). ntpd (or other) is started at boot, and it is just
> the little misc adjustments that happen over time.
 
> We could add tracepoints and detect the changes and invalidate the
> reference time. We could add tracepoints to track the adjustments and
> update the reference time. In my experience over 9+ years using this
> tool (out of tree patches) that has never been the problem.
 
> > All you really want is a clock that runs at the same rate but is not
> > subject to random jumps and user foibles.

> All I want is to compare user logs to a kernel event via timestamps.

Can we have both possibilities and leave the decision on which one to
use in the hands of those who have a gun to shoot wherever they want,
maybe in the foot?

- Arnaldo

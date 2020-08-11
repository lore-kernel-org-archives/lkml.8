Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD21D206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKWP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:15:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:25349 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgHKWP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:15:56 -0400
IronPort-SDR: Yr3NohTmaP4XdfsJpdw5HrLnMdmnZGcMUGQf4ywR2LoaveGvkd+PZoZkx/oz5mTw3fl+o4ENv1
 Ga3vqPEan+dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="151273799"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="151273799"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 15:15:55 -0700
IronPort-SDR: dIHx8NC7z+ukfiY7P7TV7ohJbmDTP2rwhqDU+Ae7vDwJ8oCTTGZduFyUY1k5bRdMZemWQwa5nq
 As0wVewInQng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="324891321"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga008.jf.intel.com with ESMTP; 11 Aug 2020 15:15:55 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 96968301CAF; Tue, 11 Aug 2020 11:02:03 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:02:03 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     peterz@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Message-ID: <20200811180203.GG1448395@tassilo.jf.intel.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
 <87364t1plf.fsf@ashishki-desk.ger.corp.intel.com>
 <20200811143424.GD1448395@tassilo.jf.intel.com>
 <87zh71ywzq.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh71ywzq.fsf@ashishki-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:21:13PM +0300, Alexander Shishkin wrote:
> Andi Kleen <ak@linux.intel.com> writes:
> 
> > On Tue, Aug 11, 2020 at 12:47:24PM +0300, Alexander Shishkin wrote:
> >> 
> >> Right, but which bytes? One byte per event? That's
> >> arbitrary. sizeof(struct perf_event)? Then, probably also sizeof(struct
> >> perf_event_context).
> >
> > Yes the sum of all the sizeofs needed for a perf_event.
> 
> Well, *all* of them will be tedious to collect, seeing as there is
> ctx->task_ctx_data, there is ring_buffer, scheduling trees, there is
> stuff that pmus allocate under the hood, like AUX SG tables.

Well I'm sure we can figure something out. I guess it doesn't need to be
fully accurate, just approximate enough, and be bounded.

> 
> >> The above two structs add up to 2288 bytes on my local build. Given the
> >> default RLIMIT_MEMLOCK of 64k, that's 28 events. As opposed to ~1k
> >> events if we keep using the RLIMIT_NOFILE. Unless I'm missing your
> >> point.
> >
> > Yes that's true. We would probably need to increase the limit to a few
> > MB at least.
> 
> Ok, but if we have to increase a limit anyway, we might as well increase
> the NOFILE.

NFILE is a terrible limit because it's really large factor * NFILE for
DoS. Also I suspect there will be many cases where the kernel default
is not used.

But yes I suspect it should be increased, not just for perf, but
for other use cases. AFAIK pretty much every non trivial network
server has to change it.

> 
> > Or maybe use some combination with the old rlimit for compatibility.
> > The old rlimit would give an implicit extra RLIMIT_NFILE * 2288 limit
> > for RLIMIT_MEMLOCK. This would only give full compatibility for a single
> > perf process, but I suspect that's good enough for most users.
> 
> We'd need to settle on charging a fixed set of structures per event,
> then. And, without increasing the file limit, this would still total at
> 1052 events.

True. For perf we really would like a limit that scales with the number
of CPUs.

> 
> We could also involve perf_event_mlock_kb *and* increase it too, but I
> suspect distros don't just leave it at kernel's default either.

I haven't seen any distribution that changed it so far.

-Andi

Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1852BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9E4420838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBceMYh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgG3Qoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3Qoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:44:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAD5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pZdlRw0kTSq4XGic6e0J+ZlN23uly9sXAj+LmubziXY=; b=MBceMYh/+YUMOnH4nZH82HdHE6
        f9bbtN5soBUYULb7yNegBbrWofPA+Q+O5WORyCKQ3oev2L+suCZMSgTydxSQveNEL8EkNwtfeYObM
        53eDLGb+6fKoegtHuU3CTa0MQ0zn/fmrC/52GTxv8D/rmcov/FP8W8qjfDw2/JPf03VdDlLAtsEwx
        UxLvrTD93L5k8zUTzVGWOXWr8XsBsR9qIBJm7FYb3LAz/VMsJzun8MKBH5wFJotpyi+ashJEVN4a6
        wAuRPx4tGzjrrlPQd7DWG/5f0a3/m7Epj4bWvj3fXcUbHSC1Ptg2bK5l6jU4TcVpIPKLViJzsEGB8
        dc7MU93g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1BfS-0005kM-4E; Thu, 30 Jul 2020 16:44:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2947B3013E5;
        Thu, 30 Jul 2020 18:44:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0989A203DB3D9; Thu, 30 Jul 2020 18:44:26 +0200 (CEST)
Date:   Thu, 30 Jul 2020 18:44:25 +0200
From:   peterz@infradead.org
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] perf/x86: Reset the counter to prevent the leak for a
 RDPMC task
Message-ID: <20200730164425.GO2655@hirez.programming.kicks-ass.net>
References: <20200730123815.18518-1-kan.liang@linux.intel.com>
 <20200730125817.GL2655@hirez.programming.kicks-ass.net>
 <cd65635b-d226-3089-cb4a-8f60ae408db5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd65635b-d226-3089-cb4a-8f60ae408db5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:54:35AM -0400, Liang, Kan wrote:
> On 7/30/2020 8:58 AM, peterz@infradead.org wrote:
> > On Thu, Jul 30, 2020 at 05:38:15AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > The counter value of a perf task may leak to another RDPMC task.
> > 
> > Sure, but nowhere did you explain why that is a problem.
> > 
> > > The RDPMC instruction is only available for the X86 platform. Only apply
> > > the fix for the X86 platform.
> > 
> > ARM64 can also do it, although I'm not sure what the current state of
> > things is here.
> > 
> > > After applying the patch,
> > > 
> > >      $ taskset -c 0 ./rdpmc_read_all_counters
> > >      index 0x0 value 0x0
> > >      index 0x1 value 0x0
> > >      index 0x2 value 0x0
> > >      index 0x3 value 0x0
> > > 
> > >      index 0x0 value 0x0
> > >      index 0x1 value 0x0
> > >      index 0x2 value 0x0
> > >      index 0x3 value 0x0
> > 
> > You forgot about:
> > 
> >   - telling us why it's a problem,
> 
> The non-privileged RDPMC user can get the counter information from other
> perf users. It is a security issue. I will add it in the next version.

You don't know what it counted and you don't know the offset, what can
you do with it?

> >   - telling us how badly it affects performance.
> 
> I once did performance test on a HSX machine. There is no notable slow down
> with the patch. I will add the performance data in the next version.

It's still up to [4..8]+[3,4] extra WRMSRs per context switch, that's pretty naf.

> > I would feel much better if we only did this on context switches to
> > tasks that have RDPMC enabled.
> 
> AFAIK, at least for X86, we can only enable/disable RDPMC globally.
> How can we know if a specific task that have RDPMC enabled/disabled?

It has mm->context.pref_rdpmc_allowed non-zero, go read x86_pmu_event_{,un}mapped().
Without that CR4.PCE is 0 and RDPMC won't work, which is most of the
actual tasks.

Arguably we should have perf_mmap_open() check if 'event->hw.target ==
current', because without that RDPMC is still pointless.

> > So on del() mark the counter dirty (if we don't already have state that
> > implies this), but don't WRMSR. And then on
> > __perf_event_task_sched_in(), _after_ programming the new tasks'
> > counters, check for inactive dirty counters and wipe those -- IFF RDPMC
> > is on for that task.
> > 
> 
> The generic code doesn't have counters' information. It looks like we need
> to add a new callback to cleanup the dirty counters as below.
> 
> In the specific implementation of pmu_cleanup(), we can check and wipe all
> inactive dirty counters.

What about pmu::sched_task(), can't we rejig that a little?

The way I'm reading it now, it's like we iterate the task context for
calling perf_event_context_sched_*(), and then iterate a cpuctx list to
find cpuctx->task_ctx, which would be the exact same contexts we've just
iterated.

So can't we pull the pmu::sched_task() call into
perf_event_context_sched_*() ? That would save a round of
pmu_disable/enable() too afaict.

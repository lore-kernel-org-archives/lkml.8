Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64438C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325D8206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 19:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhM5TNNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgF3THC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgF3THC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 15:07:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C458C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8SCcBWWb9Ctvl0dyVfm1njpm180tgPXsVuvvAerOVuw=; b=KhM5TNNJYPrfH10hkZJUsGzJc5
        BwEd2jVXc8DS7zoUGhFjT1jHsQ4IPSZVF0W+mZGObxHsC20DvAEDRkZgs+T6WseecwsdoiUFKNuqJ
        FVhfxQR5VwBPcx/TOb8tKEVftSfAp/MxRxy7P0aqQvjk9KcsphA7iQeMWuhBSraUq5MqkyidCqBkf
        1enrV016vxPb3rS5YWniqhvsUQQA7lb7pU44A+BoGAYPn+owN8qJcCXruoX65JDewwc2CeqiYmejv
        0HiicbmlGCFX9bVcLuZC/FG5FFdGYAhw1QY7BgGJT1RTXbjuBg64y+taSSos47MgIt44GkbnnTAMz
        WDBhU77w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqLaf-0000uI-7S; Tue, 30 Jun 2020 19:06:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7E3C30015A;
        Tue, 30 Jun 2020 21:06:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99F04201A79C5; Tue, 30 Jun 2020 21:06:43 +0200 (CEST)
Date:   Tue, 30 Jun 2020 21:06:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630190643.GC4817@hirez.programming.kicks-ass.net>
References: <20200630112123.12076-1-qais.yousef@arm.com>
 <20200630112123.12076-3-qais.yousef@arm.com>
 <20200630170751.GA4817@hirez.programming.kicks-ass.net>
 <20200630175502.otw4seymlynghje7@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630175502.otw4seymlynghje7@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 06:55:02PM +0100, Qais Yousef wrote:
> On 06/30/20 19:07, Peter Zijlstra wrote:

> > There's a fun race described in 9107c89e269d ("perf: Fix race between
> > event install and jump_labels"), are we sure this isn't also susceptible
> > to something similar?
> > 
> > I suspect not, but I just wanted to make sure.
> 
> IIUC, the worry is that not all CPUs might have observed the change in the
> static key state; hence could not be running the patched
> enqueue/dequeue_task(), so we could end up with some CPUs accounting for
> uclamp in the enqueue/dequeue path but not others?
> 
> I was hoping this synchronization is guaranteed by the static_branch_*() call.

It is, that isn't quite the the problem. Looking at it more I think
commit 1dbb6704de91 ("jump_label: Fix concurrent
static_key_enable/disable()") fixed some of it.

From what I can remember there were two parts to this problem, one being
fixed by the above commit, the other being that if we enable while a
task is running we miss the switch-in event (exactly how in this patch
we miss the enqueue).

Due to the missing switch-in, the state is 'weird' and the subsequent
IPI to install a remote event didn't quite work.

So I put that sync_sched() call in to guarantee all CPUs have done a
schedule() cycle after having the key switched. This makes sure that
every running task has seen the switch-in and thus the state is as
expected.

But like I said, I think we're good, that one extra branch deals with
the half-state.

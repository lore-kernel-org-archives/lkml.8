Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F68207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDbKzp31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405347AbgE1REJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:04:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405249AbgE1REG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sPK2AUkVbYrlBIuEiT/LezDNFauHztnHTLMpmUaLaBQ=; b=VDbKzp31VwCdMbkSQ//1HtPXzL
        FOrZOd4XaGbi+3rVJzohXjInNfJEH9pLvG8MplMMPD0ZBy7cCVzwG5rdyA8mcZAHXwPmjrXRFQbj1
        +wO5lranokB6cgL+Z+OkN/WLfs14z0VoRKZJOlJ4MKHWO9ElQXAGCVWQ6XmrH+mQZhL41cgumt/cc
        lAkQ4hlF5wt61fH8+WwVXShA060OwlfcZQesZVJU8Uvw8BAJVV8t7TalZqKpb+gbM9yDJnmYeYsts
        6ckUUh0W7TD7D57ka0+kuBoDuARPGfuVn3iwr5Hf9SgIPFPo05ZJreTE7qYXMa6RsbbC9izz7X2dL
        SY9n9xzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeLuM-0006fT-Po; Thu, 28 May 2020 17:01:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4057E9836F8; Thu, 28 May 2020 19:01:28 +0200 (CEST)
Date:   Thu, 28 May 2020 19:01:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        vpillai <vpillai@digitalocean.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling interface
Message-ID: <20200528170128.GN2483@worktop.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
 <20200521085122.GF325280@hirez.programming.kicks-ass.net>
 <20200521134705.GA140701@google.com>
 <20200522125905.GM325280@hirez.programming.kicks-ass.net>
 <20200522213524.GD213825@google.com>
 <20200524140046.GA5598@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524140046.GA5598@lorien.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 10:00:46AM -0400, Phil Auld wrote:
> On Fri, May 22, 2020 at 05:35:24PM -0400 Joel Fernandes wrote:
> > On Fri, May 22, 2020 at 02:59:05PM +0200, Peter Zijlstra wrote:
> > [..]
> > > > > It doens't allow tasks for form their own groups (by for example setting
> > > > > the key to that of another task).
> > > > 
> > > > So for this, I was thinking of making the prctl pass in an integer. And 0
> > > > would mean untagged. Does that sound good to you?
> > > 
> > > A TID, I think. If you pass your own TID, you tag yourself as
> > > not-sharing. If you tag yourself with another tasks's TID, you can do
> > > ptrace tests to see if you're allowed to observe their junk.
> > 
> > But that would require a bunch of tasks agreeing on which TID to tag with.
> > For example, if 2 tasks tag with each other's TID, then they would have
> > different tags and not share.

Well, don't do that then ;-)

> > What's wrong with passing in an integer instead? In any case, we would do the
> > CAP_SYS_ADMIN check to limit who can do it.

So the actual permission model can be different depending on how broken
the hardware is.

> > Also, one thing CGroup interface allows is an external process to set the
> > cookie, so I am wondering if we should use sched_setattr(2) instead of, or in
> > addition to, the prctl(2). That way, we can drop the CGroup interface
> > completely. How do you feel about that?
> >
> 
> I think it should be an arbitrary 64bit value, in both interfaces to avoid
> any potential reuse security issues.
> 
> I think the cgroup interface could be extended not to be a boolean but take
> the value. With 0 being untagged as now.

How do you avoid reuse in such a huge space? That just creates yet
another problem for the kernel to keep track of who is who.

With random u64 numbers, it even becomes hard to determine if you're
sharing at all or not.

Now, with the current SMT+MDS trainwreck, any sharing is bad because it
allows leaking kernel privates. But under a less severe thread scenario,
say where only user data would be at risk, the ptrace() tests make
sense, but those become really hard with random u64 numbers too.

What would the purpose of random u64 values be for cgroups? That only
replicates the problem of determining uniqueness there. Then you can get
two cgroups unintentionally sharing because you got lucky.

Also, fundamentally, we cannot have more threads than TID space, it's a
natural identifier.

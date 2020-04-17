Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB05C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D4420780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/2Q29xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgDQNJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgDQNJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:09:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF2EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tQqJmxt0Xkc0cudnjKOkdSBVqtWLrH6kV1595ZGPmO4=; b=c/2Q29xyFdDG9GHCFwZpEAEW+n
        XFk5vl+9GagW3S8OUS2QGwu0AS+C38bxBgqAUxZMPPFBMOir59Fs0PNwPFI/BcsZjbXUALajwugsc
        PdLQUQ9NFSIz4PClpj9nVkLIl1PSzyzfU5z1IRvu1OFMRGVrRp+fqWnLYgR3VG49YcZYu+80TBbDt
        d3pL9O6NzAYohPx5OzNeTeywp0GcZYtwHID3X0SmWO0VxdREUtuOdZKYRc6erk2KMoWFWUWRwvbeL
        6vqo0d9o6zpZST7j7HG0ynDd2uFHFXLsfGy5hnhdSiqCL6wXPYAvsFaMyvo0g5Q+TZrYs05JrEl/t
        g4S5URPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPQjL-000092-Pq; Fri, 17 Apr 2020 13:08:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D54BE3015D0;
        Fri, 17 Apr 2020 15:08:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 647DF2B121688; Fri, 17 Apr 2020 15:08:25 +0200 (CEST)
Date:   Fri, 17 Apr 2020 15:08:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
Message-ID: <20200417130825.GE20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200414142152.GV20730@hirez.programming.kicks-ass.net>
 <20200415163220.GA180518@google.com>
 <20200417111255.GZ20730@hirez.programming.kicks-ass.net>
 <79529592-5d60-2a41-fbb6-4a5f8279f998@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79529592-5d60-2a41-fbb6-4a5f8279f998@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:35:38PM +0200, Alexander Graf wrote:
> On 17.04.20 13:12, Peter Zijlstra wrote:

> If we first kick out the sibling HT for every #VMEXIT, performance will be
> abysmal, no?

I've been given to understand that people serious about virt try really
hard to avoid VMEXIT.


> > That doesn't completely solve things I think. Even if you run all
> > untrusted tasks as core exclusive, you still have a problem of them vs
> > interrupts on the other sibling.
> >
> > You need to somehow arrange all interrupts to the core happen on the
> > same sibling that runs your untrusted task, such that the VERW on
> > return-to-userspace works as intended.
> > 
> > I suppose you can try and play funny games with interrupt routing tied
> > to the force-idle state, but I'm dreading what that'll look like. Or
> > were you going to handle this from your irq_enter() thing too?
> 
> I'm not sure I follow. We have thread local interrupts (timers, IPIs) and
> device interrupts (network, block, etc).
> 
> Thread local ones shouldn't transfer too much knowledge, so I'd be inclined
> to say we can just ignore that attack vector.
> 
> Device interrupts we can easily route to HT0. If we now make "core
> exclusive" a synonym for "always run on HT0", we can guarantee that they
> always land on the same CPU, no?
> 
> Then you don't need to hook into any idle state tracking, because you always
> know which CPU the "safe" one to both schedule tasks and route interrupts to
> is.

That would come apart most mighty when someone does an explicit
sched_setaffinity() for !HT0.

While that might work for some relatively contained systems like
chromeos, it will not work in general I think.

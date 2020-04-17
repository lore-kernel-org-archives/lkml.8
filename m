Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B38C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9CF221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L8F6v9W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgDQLN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729846AbgDQLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:13:27 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AAAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z9R8TwgFFZEdYwWvXS1m69C8jKNDkSMDggxlCSZl1WU=; b=L8F6v9W7jafZdYrltN0+Nk3whw
        s6Meo+NJQv7L5JnhaN8h9qASZOrOcJXSAbUHL2gDOzzV90yyHnji1xkl/he04CybPyvwCE/DE5CuZ
        RJGDNl3qhNG8TId7f4kKIrOg5IlYaqVFriwuWr7m4hoK4wnB95iD+08huaj/zPVCH8GI3wQ6MOnXD
        +ktAJ4XpKKKZIi8U+Ek8w0uZVqGp9oiDwAE8WaKvn3erXlUgl1H9xI8ZMS05XCk+LJ9PxFalvdqac
        AiFt4m4Ihdfoe2HBw56DHzw75lT0q8KcVhc+gGxQx6V6PUk/pcfvcsqTbHa+aLYbShky8TIGxDXWJ
        b6Nt/E4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPOva-0006AO-G8; Fri, 17 Apr 2020 11:12:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFCF2304E03;
        Fri, 17 Apr 2020 13:12:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AF8D72B1214AF; Fri, 17 Apr 2020 13:12:55 +0200 (CEST)
Date:   Fri, 17 Apr 2020 13:12:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     vpillai <vpillai@digitalocean.com>,
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
Message-ID: <20200417111255.GZ20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200414142152.GV20730@hirez.programming.kicks-ass.net>
 <20200415163220.GA180518@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415163220.GA180518@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:32:20PM -0400, Joel Fernandes wrote:
> On Tue, Apr 14, 2020 at 04:21:52PM +0200, Peter Zijlstra wrote:
> > On Wed, Mar 04, 2020 at 04:59:50PM +0000, vpillai wrote:
> > > TODO
> > > ----
> > > - Work on merging patches that are ready to be merged
> > > - Decide on the API for exposing the feature to userland
> > > - Experiment with adding synchronization points in VMEXIT to mitigate
> > >   the VM-to-host-kernel leaking
> > 
> > VMEXIT is too late, you need to hook irq_enter(), which is what makes
> > the whole thing so horrible.
> 
> We came up with a patch to do this as well. Currently testing it more and it
> looks clean, will share it soon.

Thomas said we actually first do VMEXIT, and then enable interrupts. So
the VMEXIT thing should actually work, and that is indeed much saner
than sticking it in irq_enter().

It does however put yet more nails in the out-of-tree hypervisors.

> > > - Investigate the source of the overhead even when no tasks are tagged:
> > >   https://lkml.org/lkml/2019/10/29/242
> > 
> >  - explain why we're all still doing this ....
> > 
> > Seriously, what actual problems does it solve? The patch-set still isn't
> > L1TF complete and afaict it does exactly nothing for MDS.
> 
> The L1TF incompleteness is because of cross-HT attack from Guest vCPU
> attacker to an interrupt/softirq executing on the other sibling correct? The
> IRQ enter pausing the other sibling should fix that (which we will share in
> a future series revision after adequate testing).

Correct, the vCPU still running can glean host (kernel) state from the
sibling handling the interrupt in the host kernel.

> > Like I've written many times now, back when the world was simpler and
> > all we had to worry about was L1TF, core-scheduling made some sense, but
> > how does it make sense today?
> 
> For ChromeOS we're planning to tag each and every task seperately except for
> trusted processes, so we are isolating untrusted tasks even from each other.
> 
> Sorry if this sounds like pushing my usecase, but we do get parallelism
> advantage for the trusted tasks while still solving all security issues (for
> ChromeOS). I agree that cross-HT user <-> kernel MDS is still an issue if
> untrusted (tagged) tasks execute together on same core, but we are not
> planning to do that on our setup at least.

That doesn't completely solve things I think. Even if you run all
untrusted tasks as core exclusive, you still have a problem of them vs
interrupts on the other sibling.

You need to somehow arrange all interrupts to the core happen on the
same sibling that runs your untrusted task, such that the VERW on
return-to-userspace works as intended.

I suppose you can try and play funny games with interrupt routing tied
to the force-idle state, but I'm dreading what that'll look like. Or
were you going to handle this from your irq_enter() thing too?


Can someone go write up a document that very clearly states all the
problems and clearly explains how to use this feature?



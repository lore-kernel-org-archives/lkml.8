Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70622C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D1F208A9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QOOZIhaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHDMdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgHDMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:32:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA2DC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RANkuMGH5Shk9k5d9SY1igHjSQobHcAmQUt/sHBCrIY=; b=QOOZIhaq3WBJjDTaWqMnTDOBgz
        rIBxVhGND/pICG5HS6Hefy3MoPz+ZmNJK04JQPWiil+/xAwFMe2XMYmUD2SRVHhJc3tyi1K3XFwoJ
        h2kHqkS9zkIXy/2XbkWmACWcATH1Rtyq5794ScWPktI6IA4Jel9Q3jl+OJWeGxgZJ4YdE73Pf/mh/
        xP0yE/mOqs0llKZiJOMo9qr+Y87ISpeXaib0rVaTBaz/boxfdOzb8tFM7bEaM3wT9Jrkqu6JXLzHk
        hmc0/Ed3ZfB6cGU0vSjs48CNtGS6YNZ77YZytqYG4T/lgVdO6nSTrTAZBP89/pczCuz+op3qa0QAa
        Ewz0y+Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2w6h-00087p-Pa; Tue, 04 Aug 2020 12:31:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 650EB301631;
        Tue,  4 Aug 2020 14:31:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D11E2BDB8C9F; Tue,  4 Aug 2020 14:31:47 +0200 (CEST)
Date:   Tue, 4 Aug 2020 14:31:47 +0200
From:   peterz@infradead.org
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>, Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH for 5.9 v2 1/4] futex: introduce FUTEX_SWAP operation
Message-ID: <20200804123147.GI2674@hirez.programming.kicks-ass.net>
References: <20200803221510.170674-1-posk@posk.io>
 <20200803221510.170674-2-posk@posk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803221510.170674-2-posk@posk.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:15:07PM -0700, Peter Oskolkov wrote:
> A simplified/idealized use case: imagine a multi-user service application
> (e.g. a DBMS) that has to implement the following user CPU quota
> policy:

So the last posting made hackernews; and there a bunch expressed far
more interest in coroutines, which, if I'm not mistaken, can also be
implemented using all this.

Would that not make for a far simpler and more convincing use-case?

> - block detection: when a task blocks in the kernel (on a network
>   read, for example), the userspace scheduler is notified and
>   schedules (resumes or swaps into) a pending task in the newly available
>   CPU slot;
> - wake detection: when a task wakes from a previously blocking kernel
>   operation (e.g. can now process some data on a network socket), the
>   userspace scheduler is notified and can now schedule the task to
>   run on a CPU when a CPU is available and the task can use it according
>   to its scheduling policy.
> 
> (Technically, block/wake detection is still experimental and not
> used widely: as we control the userspace, we can actually determine
> blocking/waking syscalls without kernel support).
> 
> Internally we currently use kernel patches that are too "intrusive" to be
> included in a general-purpose Linux kernel, so we are exploring ways to
> upstream this functionality.
> 
> The easiest/least intrusive approach that we have come up with is this:
> 
> - block/resume map perfectly to futex wait/wake;
> - switch_to thus maps to FUTEX_SWAP;
> - block and wake detection can be done either through tracing
>   or by introducing new BPF attach points (when a task blocks or wakes,
>   a BPF program is triggered that then communicates with the userspace);
> - the BPF attach points are per task, and the task needs to "opt in"
>   (i.e. all other tasks suffer just an additional pointer comparison
>   on block/wake);
> - the BPF programs triggered on block/wake should be able to perform
>   futex ops (e.g. wake a designated userspace scheduling task) - this
>   probably indicates that tracing is not enough, and a new BPF prog type
>   is needed.

I really think we want to have block/resume detection sorted before this
goes anywhere, I also strongly feel BPF should not be used for
functional interfaces like that.

That is, I want to see a complete interface before I want to commit to
an ABI that we're stuck with.

I also want to see userspace that goes along with it; like with
sys_membarrier() / liburcu and sys_rseq() / librseq (which seems to be
heading for glibc).

Also, and this seems to be the crux of the whole endeavour, you want to
allow your 'fibers' to block. Which is what makes
{make,swap,get,set}context() unsuited for your needs and gives rise to
the whole block/resume issue above.

Also, I want words on the interaction between resume notification and
wake-up preemption. That is, how do you envision managing the
interaction between the two schedulers.


All in all, I don't think you're even close to having something
mergable.

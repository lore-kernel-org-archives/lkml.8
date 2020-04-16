Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE504C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B57D20784
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NKOHMxJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503057AbgDPI4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502961AbgDPIx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:53:29 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0EDC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9+zb5lOcLNsdGEIiZVneJyZa5T7eObObpHMI11tV4t8=; b=NKOHMxJCg9d1kbkGnKRxNQtJGz
        aOxmEsHEBe0neyXzFYrXKEr5VS4EW70w98HmVO0/Z4gEFgCpJumbE2fNZHhseyBGBaKM/tBl/0WZl
        2n3Gpa9N6mEe7hImlNeOABNoy7DfL7O/gi7ETvOe6hqSwdah15x2IhlpFH4J9u0J+T4ZkQoaEfjUb
        /CeKnK6aa0PAad8y7vXP/t3BJUF3T06VxTCq/SmxUu+X/FA0hqolzQrqpzaEnsorj6K4n6YRR+e5r
        AOqsy+5w9ZnEWNTlaqLeHtKVK8qTMNcvXZEG5rSvn77lzpudoOoSFR7ubeHPqzSuyKJaQbec1oDhR
        EVkjogBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP0GS-0001bN-PE; Thu, 16 Apr 2020 08:52:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E52E83006E0;
        Thu, 16 Apr 2020 10:52:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF9762B0DB555; Thu, 16 Apr 2020 10:52:49 +0200 (CEST)
Date:   Thu, 16 Apr 2020 10:52:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] exit: Move preemption fixup up, move blocking
 operations down
Message-ID: <20200416085249.GL20730@hirez.programming.kicks-ass.net>
References: <20200305220657.46800-1-jannh@google.com>
 <CAG48ez2qd6r6FfDBHbqpoqKFU1oA64Usx86Ps33wHjCZmxYmbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2qd6r6FfDBHbqpoqKFU1oA64Usx86Ps33wHjCZmxYmbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:30:02AM +0100, Jann Horn wrote:
> On Thu, Mar 5, 2020 at 11:07 PM Jann Horn <jannh@google.com> wrote:
> > With CONFIG_DEBUG_ATOMIC_SLEEP=y and CONFIG_CGROUPS=y, kernel oopses in
> > non-preemptible context look untidy; after the main oops, the kernel prints
> > a "sleeping function called from invalid context" report because
> > exit_signals() -> cgroup_threadgroup_change_begin() -> percpu_down_read()
> > can sleep, and that happens before the preempt_count_set(PREEMPT_ENABLED)
> > fixup.
> >
> > It looks like the same thing applies to profile_task_exit() and
> > kcov_task_exit().
> >
> > Fix it by moving the preemption fixup up and the calls to
> > profile_task_exit() and kcov_task_exit() down.
> >
> > Fixes: 1dc0fffc48af ("sched/core: Robustify preemption leak checks")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > As so often, I have no idea which tree this should go through. tip? mm?
> 
> Do the tip folks want to take this, since it's vaguely locking-related
> and the fixed commit also came that way? Or should it go through
> akpm's tree?

I've picked it up, as it seems to be languishing. Thanks!

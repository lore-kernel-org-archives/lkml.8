Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A85C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4D4208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EmuP6Jyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGCJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCJCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:02:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA74C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TR87TYbOJPVddeAI363WO0ZDHvRAdSQLPveW9L3ReRs=; b=EmuP6JyoP5AddLYU++0xWDDucU
        ntbrGzdXGCS+xNvFO2WA2oLfnCSWM59oEAJdgE8sCJEIrspjrt4r3m0NOB6EzSXlGA+dAmzuzodmM
        Risqb2jO4BoCCPefwNMFL32Cx2Q/ZNPsIYm96WFV/JEiLyYIVt3iHWwDr6dKMync+U5njxwb+/oXL
        m1ixu1aMg4OZfZMuN1FoM4YLX966QDH0W0RT6HN8/H5HlsUh3BYBc/aQySqYc/9Fiypp9liLJjhYS
        k+ujxk6zguXFzNNZyIY0wjdELxtX6OWT4UPVaPK3jQN3bLTKAkwXfMfGsVbLMv/CESw4BFRzMlw/x
        elNKp5qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrHaY-0003ar-1J; Fri, 03 Jul 2020 09:02:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 318E8301124;
        Fri,  3 Jul 2020 11:02:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18CAB2010865A; Fri,  3 Jul 2020 11:02:26 +0200 (CEST)
Date:   Fri, 3 Jul 2020 11:02:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200703090226.GV4800@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702213627.GF3183@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:36:27PM +0100, Mel Gorman wrote:

> > commit c6e7bd7afaeb3af55ffac122828035f1c01d1d7b (refs/bisect/bad)
> > Author: Peter Zijlstra <peterz@infradead.org>

> Peter, I'm not supremely confident about this but could it be because
> "p->sched_contributes_to_load = !!task_contributes_to_load(p)" potentially
> happens while a task is still being dequeued? In the final stages of a
> task switch we have
> 
>         prev_state = prev->state;
>         vtime_task_switch(prev);
>         perf_event_task_sched_in(prev, current);
>         finish_task(prev);
> 
> finish_task is when p->on_cpu is cleared after the state is updated.
> With the patch, we potentially update sched_contributes_to_load while
> p->state is transient so if the check below is true and ttwu_queue_wakelist
> is used then sched_contributes_to_load was based on a transient value
> and potentially wrong.

I'm not seeing it. Once a task hits schedule(), p->state doesn't change,
except through wakeup.

And while dequeue depends on p->state, it doesn't change it.

At this point in ttwu() we know p->on_rq == 0, which implies dequeue has
started, which means we've (at least) stopped executing the task -- we
started or finished schedule().

Let me stare at this more...

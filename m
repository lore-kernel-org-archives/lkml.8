Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4DFC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A02221481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pEs8pF1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgIGLnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgIGLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:42:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26805C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rm9oxznNjP/2X6SfBj8vO24ynHxqiFI25pjhDo578i4=; b=pEs8pF1HhopgJRVc8E7Zn46tvG
        r6rNdOYeo2nTkvYY/QilgrxUAgLcJgNs3gc8Ca+St8jt/yXk6KorxDC4Cc8I4yjsxVoy6vsa3HEXx
        /hBDFFE92fePBX1lVexSturP5OED5KMXSfoljHHxYIbdk+w728+R1Q8xfqdMSphIxXUB6WxrdS0gv
        2qd4CSDxfv8ShaMo6L29+3YujEBdShwq3syPuqYaquJ2G2VpcMWeIhbRwZ/FVdbDQZ1JPruzpMOKH
        iF4NDDvb1dpW8nLic43mQdgVKE+SfArDLgdbLncgqb9AETBgtYYnTV/6hilxciWKcTgRWI8jkCegt
        LdE4g+XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFFWq-0007KR-Q7; Mon, 07 Sep 2020 11:41:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E65FE301179;
        Mon,  7 Sep 2020 13:41:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA477201057EE; Mon,  7 Sep 2020 13:41:40 +0200 (CEST)
Date:   Mon, 7 Sep 2020 13:41:40 +0200
From:   peterz@infradead.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Vehlow <lkml@jv-coder.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>, dave@stgolabs.net
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
Message-ID: <20200907114140.GQ2674@hirez.programming.kicks-ass.net>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
 <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <20200822123252.GQ1362448@hirez.programming.kicks-ass.net>
 <20200822194928.54ee4cb5@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822194928.54ee4cb5@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 07:49:28PM -0400, Steven Rostedt wrote:

> From this email:
> 
> > The problem happens when that owner is the idle task, this can happen
> > when the irq/softirq hits the idle task, in that case the contending
> > mutex_lock() will try and PI boost the idle task, and that is a big
> > no-no.
> 
> What's wrong with priority boosting the idle task? It's not obvious,
> and I can't find comments in the code saying it would be bad.

> The idle task is not mentioned at all in rtmutex.c and not mentioned in
> kernel/locking except for some comments about RCU in lockdep.

There used to be a giant BUG() and comment somewhere in the PI code I
think.. but that's vage memories.

> I see that in the idle code the prio_change method does a BUG(), but
> there's no comment to say why it does so.
> 
> The commit that added that BUG, doesn't explain why it can't happen:
> 
> a8941d7ec8167 ("sched: Simplify the idle scheduling class")

That's like almost a decade ago ...

> I may have once known the rationale behind all this, but it's been a
> long time since I worked on the PI code, and it's out of my cache.

I suffer much the same problem.

So cenceptually there's the problem that idle must always be runnable,
and the moment you boost it, it becomes subject to a different
scheduling class.

Imagine for example what happens when we boost it to RT and then have it
be subject to throttling. What are we going to run when the idle task
is no longer elegible to run.

(it might all work out by accident, but ISTR we had a whole bunch of fun
in the earlier days of RT due to things like that)

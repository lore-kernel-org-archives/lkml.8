Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A489C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BCF20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZkMiEYwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGGJrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgGGJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:47:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C1C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+xhE09FSIbPBUcO2BhFd1zwZ423fLcZ/JnwL1A6q3qQ=; b=ZkMiEYwE0mC2aCwnAqI59DykQT
        W8za/eywlDbaja6MUe6ygYX3We8vIJ5zBZbsYUml2MUcV03UCMbJU/MEF/KMhZA6HPtF/fY04LJ//
        I01/ROLsmmhMxHbHaWl7zTSCtd2SUKKpESOiawAd1JD1BU0rSULNPjO7w6lHfkq2oHAMjU0ZItEFl
        0y8QLTEjI+w4+jIN1cb8n0WJF6i7GGfEeEMLRHO6rNCLtYHEybMbf+PjXm9wpobPEP1U/OlfYM8BS
        P6z+IhOjGcv9XQqFHJxScQ+U+XzKTgakmFX1SwXjZMQybCKu6ss09VXTmk+0MXFTs+Ck6xDaTmmUn
        us4rn3bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jskCA-0001OE-D3; Tue, 07 Jul 2020 09:47:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F9C2304B90;
        Tue,  7 Jul 2020 11:47:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3711B213C912A; Tue,  7 Jul 2020 11:47:18 +0200 (CEST)
Date:   Tue, 7 Jul 2020 11:47:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        paul.gortmaker@windriver.com, valentin.schneider@arm.com
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200707094718.GL4800@hirez.programming.kicks-ass.net>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
 <20200703090226.GV4800@hirez.programming.kicks-ass.net>
 <20200703104033.GK117543@hirez.programming.kicks-ass.net>
 <20200703205153.GA19901@codemonkey.org.uk>
 <20200706145952.GB597537@hirez.programming.kicks-ass.net>
 <20200707092004.jviycpvzb4l5ytiz@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707092004.jviycpvzb4l5ytiz@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:20:05AM +0100, Qais Yousef wrote:
> On 07/06/20 16:59, Peter Zijlstra wrote:

> > +	if (!preempt && prev_state && prev_state == prev->state) {
> 
> I think the compiler won't optimize `prev_state == prev->state` out because of
> the smp_mb__after_spinlock() which implies a compiler barrier. Still not sure
> if it's worth making prev->state accesses a READ_ONCE()?

task_struct::state is one of the very rare (and ancient) variables
that's declared volatile.

We should probably clean that up some day, but so far I've not attempted
to do such a thing.

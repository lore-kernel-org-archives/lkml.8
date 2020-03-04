Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13539C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB47A20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fSWIl1df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgCDJ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:56:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2ckkr/ncutWqUu2JPEoyksHSnlWmNLmI7ZyB0FkDM1U=; b=fSWIl1dfxrK+42SRld1Ot5iGl0
        IzEr0AhZsVvYpk5KeYgu+3z7bC/P9iWTMGxbTJyBJdQndc0xHLRXK6f6zUTU1k8v4dlioDawAD8fJ
        y53dDgix8bndMqvjDeXLGXpdORMLpDaR57aLc0PdV4BlXJUOrsk8w+TB+ZOXV1psIVSDETYHGXQwR
        UUNxFJB1wvkf6fq9Jd6/5MHce7ri/OWi/9BHEMEQKv+IdhE7dK0I53AYiAFthZ2J3pAE9dKFP0hIi
        pm15xo9Jw7XGldL+cHUQD3JCKWl+sgkl1B4RHGXufoiFSKA46JDr0K9beWWXxC4thhVBCNAOBhp7F
        VG35X45g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9Qll-0008ED-NN; Wed, 04 Mar 2020 09:56:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00A6F3012C3;
        Wed,  4 Mar 2020 10:54:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C10E20BCBDC5; Wed,  4 Mar 2020 10:56:47 +0100 (CET)
Date:   Wed, 4 Mar 2020 10:56:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qian Cai <cai@lca.pw>, fweisbec@gmail.com, mingo@kernel.org,
        elver@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/sched: fix data races at tick_do_timer_cpu
Message-ID: <20200304095647.GL2596@hirez.programming.kicks-ass.net>
References: <20200225030808.1207-1-cai@lca.pw>
 <87tv34laqq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv34laqq.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:39:41AM +0100, Thomas Gleixner wrote:
> Qian,
> 
> Qian Cai <cai@lca.pw> writes:
> > tick_do_timer_cpu could be accessed concurrently where both plain writes
> > and plain reads are not protected by a lock. Thus, it could result in
> > data races. Fix them by adding pairs of READ|WRITE_ONCE(). The data
> > races were reported by KCSAN,
> 
> They are reported, but are they actually a real problem?
> 
> This completely lacks analysis why these 8 places need the
> READ/WRITE_ONCE() treatment at all and if so why the other 14 places
> accessing tick_do_timer_cpu are safe without it.
> 
> I definitely appreciate the work done with KCSAN, but just making the
> tool shut up does not cut it. 

Worse:

+	if (cpu != READ_ONCE(tick_do_timer_cpu) &&
+	    (READ_ONCE(tick_do_timer_cpu) != TICK_DO_TIMER_NONE ||

Doing that read twice is just utterly stupid. And the patch is full of
that :/

Please stop this non-thinking 'fix' generation!

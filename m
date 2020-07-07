Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E31C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAE20708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GO/4rq7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGNEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGNEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:04:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2785C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASfn/SdgsMD8Cz7XZocX1lE3LU6oMKH6msyO6ek58eE=; b=GO/4rq7gAyyDRI481Ajgw2gkQ5
        X/UYcVN3Cy1yH2ng88FsPgNR9DWJuhBH/VT5GeNfTAhJUuQcLcZhhm/L+0/lCJgxeLmzimvYDNtkE
        8zD3B4X1w08cm0wka/Kkml33BIfILK+QHKmq3QitG0KvC40j4Nqb/J/Ms2i2i28RjKwUP0s/4SEcV
        wLhIV6JoutJdcW/HoE4kHNa9DIn3z9kLu4UJZKohoKSn1ky9JTFf3qBy42ItEgvUEmR63hQP9r3tq
        yA1CRWiysaVbAKs9fiJ/La0zEXUnGPqfstfxfUMhB7BDg95Hro9ZBpqGC2uk+Nq61E1mn8AJo8Upv
        NP+nOTcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsnGf-0000Aj-Oy; Tue, 07 Jul 2020 13:04:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD0793013E5;
        Tue,  7 Jul 2020 15:04:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83E07213C912B; Tue,  7 Jul 2020 15:04:10 +0200 (CEST)
Date:   Tue, 7 Jul 2020 15:04:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200707130410.GO4800@hirez.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:40:24AM +0200, Ahmed S. Darwish wrote:
> On Mon, Jul 06, 2020 at 11:21:48PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 30, 2020 at 07:44:38AM +0200, Ahmed S. Darwish wrote:
> > > +#include <linux/seqlock_types_internal.h>
> >
> > Why? why not include those lines directly here? Having it in a separate
> > file actually makes it harder to read.
> >
> 
> The seqlock_types_internal.h file contains mostly a heavy sequence of
> typeof() branching macros, which is not related to the core logic of
> sequence counters or sequential locks:

> IMHO it makes sense to isolate these "not core logic" parts. Adding all
> of this to plain seqlock.h makes it almost unreadable.

So I applied it all yesterday and tried to make sense of the resulting
indirections and couldn't find stuff -- because it was hidding in
another file.

Specifically I disliked that *seqcount_t* naming and didn't see how it
all connected.

And that other file is less than 200 lines, which resulted in me
wondering why it needed to be hidden away like that.

Anyway, let me muck around with that a bit.

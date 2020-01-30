Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ACAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E382063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kV/vA7M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgA3NdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:33:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3NdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0IrD+2Cqd6pTqVBOmkUhWueH8hwhXeAEBdAFin7xf14=; b=kV/vA7M3cXkS/0OU/mQ8HtZpi
        meJlra5xXbFWq7LLPR6gkFU3F1gLSsHUANg6Ond0+b4QhQZyxqEGAFXMYWbejI6JQfzyeUCLzwY6N
        99qPtTN+NR1TSyhiC98uJjMuvYiSS/p05+qA4ju6GlwJKh6Z/UGCoKxckKsDT5aOBZhVF6gBzNEs7
        RDLFxWd5cb/8HgQyqxKFZp5JGlUMRlywsSyfR4ea9MVWZCzVd/04RilXmqQrhrJQz9swz97vBrwex
        JLrJJQis46zdRMswFFqS/579Mb3n0ajDoJQCZTCuw4M9G152kSzeF34yd82z8yk2PVfzDASwf8jM0
        2eJcxn16Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix9wC-0003qO-2x; Thu, 30 Jan 2020 13:32:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 627343053FB;
        Thu, 30 Jan 2020 14:31:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F4102B2800FE; Thu, 30 Jan 2020 14:32:48 +0100 (CET)
Date:   Thu, 30 Jan 2020 14:32:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/2] events: callchain: Use RCU API to access RCU pointer
Message-ID: <20200130133248.GW14914@hirez.programming.kicks-ass.net>
References: <20200129160813.14263-1-frextrite@gmail.com>
 <20200129160813.14263-2-frextrite@gmail.com>
 <20200129221909.GA74354@google.com>
 <20200130082321.GX14879@hirez.programming.kicks-ass.net>
 <20200130101451.GA11015@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130101451.GA11015@workstation-portable>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:44:51PM +0530, Amol Grover wrote:
> > > > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > > > index f91e1f41d25d..a672d02a1b3a 100644
> > > > --- a/kernel/events/callchain.c
> > > > +++ b/kernel/events/callchain.c
> > > > @@ -62,7 +62,8 @@ static void release_callchain_buffers(void)
> > > >  {
> > > >  	struct callchain_cpus_entries *entries;
> > > >  
> > > > -	entries = callchain_cpus_entries;
> > > > +	entries = rcu_dereference_protected(callchain_cpus_entries,
> > > > +					    lockdep_is_held(&callchain_mutex));
> > > 
> > > 
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Do we really need that smp_read_barrier_depends() here? Then again, I
> > don't suppose this is a fast path.
> > 
> 
> rcu_dereference_protected is actually a lightweight API and IIRC it
> omits the READ_ONCE() and hence the memory barriers.

Oh argh, indeed. I suppose I should've had more tea this morning.

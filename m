Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF6C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AoAiIWDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgH0HsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgH0HsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:48:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F808C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1x9RtyT+zN/ZOJdCo9mX7Qqd1GAx7JmJgX/A552ZdjQ=; b=AoAiIWDBL/K9/4O+iAp2R8pTuU
        hdOOPr+eUiOux/hYpv7++nDy3qa4rm1qoxamt86Fj1fxXMaj5iJft4xdrDef1Oxx9qprR9AzcBHnj
        nX3Av4Q/AnTUbKt/jFprKOx8E/vJQu9VDMCiXs95FSPt9leJvOtoofDFSe5ghohxImtssM2Jm1OHl
        /fI98XGLJMRcey/Fr+ZmqtYXiZbpcz5q6ofZTNE/2bzxhtBDws4yaxlkqQApbwXscOT7S1rBqJ+ta
        C9IdkJG6hfEPaU8OIzBiHeNFNaAgOBIvlCjOqijVRC2dw0ugFInpu34NRkdFq8h4/l/BQ2Nq7SwnL
        EOc0m5kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBCdW-0001xG-7w; Thu, 27 Aug 2020 07:47:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02252305C10;
        Thu, 27 Aug 2020 09:47:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E01B52C187882; Thu, 27 Aug 2020 09:47:48 +0200 (CEST)
Date:   Thu, 27 Aug 2020 09:47:48 +0200
From:   peterz@infradead.org
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH v2 03/11] sched,idle,rcu: Push rcu_idle deeper into the
 idle path
Message-ID: <20200827074748.GY2674@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.310943801@infradead.org>
 <20200827011826.GA1942571@google.com>
 <20200827012419.GB1942571@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827012419.GB1942571@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:24:19PM -0400, Joel Fernandes wrote:
> On Wed, Aug 26, 2020 at 09:18:26PM -0400, Joel Fernandes wrote:
> > On Fri, Aug 21, 2020 at 10:47:41AM +0200, Peter Zijlstra wrote:
> > > Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
> > > that the locking tracepoints were using RCU.
> > > 
> > > Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
> > > this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.
> > > 
> > > Specifically, sched_clock_idle_wakeup_event() will use ktime which
> > > will use seqlocks which will tickle lockdep, and
> > > stop_critical_timings() uses lock.
> > 
> > I was wondering if those tracepoints should just use _rcuidle variant of the
> > trace call. But that's a terrible idea considering that would add unwanted
> > overhead I think.
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> BTW, if tracepoint is converted to use RCU-trace flavor, then these kinds of
> issues go away, no? That RCU flavor is always watching.

All trace_*_rcuidle() and RCU_NONIDLE() usage is a bug IMO.

Ideally RCU-trace goes away too.

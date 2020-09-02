Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B03C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3577208B3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xjDLtop+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBHIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:08:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966DC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qSleb5yTfUSbFgVSq70m08ah+KEBG2zQiz3hpXr3Dys=; b=xjDLtop+ezWUw1yQi7d2GwgHEJ
        iAuovHBN2V2q/2RxbqTIBWym9NtRL4GbVmKroQZBOVUdgWsJhrXVIjmhAF4oP7Nkbz18b2AMazxPc
        ArKORw8XEUI8ja3UAtIGKiZ3kyaypLeJ+MvJPdiByvJ86H78p+dQKUJuC5WuGrAH+dPvog55m4zRW
        TXo15E4fGt9jVt6QFCRwijUbORjVCizF7eNnE1YPoFLRXJU9k3sTs1s+eUpBMb+TBAFcrg7S9P0l1
        0sxQMMZ8r1hL+RXWfHTGTJpfek9UJJzC0h8tT1V397phtOk1j/LEUabeUCZgoS7kt/HrgzvmCrPbg
        2TdgDXqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDMsG-00064E-0n; Wed, 02 Sep 2020 07:08:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 889F43056DE;
        Wed,  2 Sep 2020 09:08:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B27E2B774668; Wed,  2 Sep 2020 09:08:00 +0200 (CEST)
Date:   Wed, 2 Sep 2020 09:08:00 +0200
From:   peterz@infradead.org
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com, tglx@linutronix.de,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2 03/11] sched,idle,rcu: Push rcu_idle deeper into the
 idle path
Message-ID: <20200902070800.GH2674@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.310943801@infradead.org>
 <20200827011826.GA1942571@google.com>
 <20200827012419.GB1942571@google.com>
 <20200827074748.GY2674@hirez.programming.kicks-ass.net>
 <20200827223001.GA3821640@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827223001.GA3821640@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 06:30:01PM -0400, Joel Fernandes wrote:
> On Thu, Aug 27, 2020 at 09:47:48AM +0200, peterz@infradead.org wrote:

> > All trace_*_rcuidle() and RCU_NONIDLE() usage is a bug IMO.
> > 
> > Ideally RCU-trace goes away too.
> 
> I was thinking that unless the rcu_idle_enter/exit calls coincide with points
> in the kernel where instrumentation is not allowed, there is always a chance
> somebody wants to use tracepoints after rcu_idle_enter or before exit. In
> this case, trace_*_rcuidle() is unavoidable unless you can move the
> rcu_idle_enter/exit calls deeper as you are doing.
> 
> Maybe objtool can help with that?

The eventual goal is to mark idle code noinstr too. There's more work
before we can do that.


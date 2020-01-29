Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CFEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDFF20708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PuB4FG0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgA2Skj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:40:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51970 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2Skj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GQmHDll3iwjJrh7vaYQic2Eyspa/xass3sVAm/tVDXo=; b=PuB4FG0maamYdnPkJ3vdw3gqi
        y6ap2ZzpOs4wHdqI9YHQiHVKpUXQT+91i/69doYzXL6vv7S9545yGuFbZsEc/OwkXCYMv6+IM1Niu
        zLM/Vw3i/DPTGm14pGgq2J3LpD4lq+G7599hUV3tuPbp9BUVnhurGZlK3Au9Wuk476grez5rrlAUF
        +h61UIoSRpFjsM59DdAXaMOE+TA7qAPh2tTw3lnkab49dvePMafTOJWhkLpWiWyYOgbPa48Eg3QWv
        X7aT8EM2RK2wJQxumaT0mwyNeRan56hrOMOzSpE4oCHQ2ZZh8WgnwBf7VoukSSt2yCSw8Gr2DCy9i
        z5yhM8UjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwsGJ-00064A-0j; Wed, 29 Jan 2020 18:40:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3626F300DD5;
        Wed, 29 Jan 2020 19:38:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 245202B7334F2; Wed, 29 Jan 2020 19:40:24 +0100 (CET)
Date:   Wed, 29 Jan 2020 19:40:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200129184024.GT14879@hirez.programming.kicks-ass.net>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net>
 <20200129002253.GT2935@paulmck-ThinkPad-P72>
 <CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 04:29:43PM +0100, Marco Elver wrote:

> On Tue, 28 Jan 2020 at 17:52, Peter Zijlstra <peterz@infradead.org> wrote:
> > I'm claiming that in the first case, the only thing that's ever done
> > with a racy load is comparing against 0, there is no possible bad
> > outcome ever. While obviously if you let the load escape, or do anything
> > other than compare against 0, there is.
> 
> It might sound like a simple rule, but implementing this is anything
> but simple: This would require changing the compiler,

Right.

> which we said we'd like to avoid as it introduces new problems.

Ah, I missed that brief.

> This particular rule relies on semantic analysis that is beyond what
> the TSAN instrumentation currently supports. Right now we support GCC
> and Clang; changing the compiler probably means we'd end up with only
> one (probably Clang), and many more years before the change has
> propagated to the majority of used compiler versions. It'd be good if
> we can do this purely as a change in the kernel's codebase.

*sigh*, I didn't know there was such a resistance to change the tooling.
That seems very unfortunate :-/

> Keeping the bigger picture in mind, how frequent is this case, and
> what are we really trying to accomplish?

It's trying to avoid the RmW pulling the line in exclusive/modified
state in a loop. The basic C-CAS pattern if you will.

> Is it only to avoid a READ_ONCE? Why is the READ_ONCE bad here? If
> there is a racing access, why not be explicit about it?

It's probably not terrible to put a READ_ONCE() there; we just need to
make sure the compiler doesn't do something stupid (it is known to do
stupid when 'volatile' is present).

But the fact remains that it is entirely superfluous, there is no
possible way the compiler can wreck this.


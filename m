Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB57204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KQDtro0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgHYHhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgHYHhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:37:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ya4jMDaDyGCvxtwvR2hGgIsqC+b9XOYcII4MqnwNsIQ=; b=KQDtro0nEEymkXbn91WTHgO/by
        UMLzBTaCvX+Wmv4dlkUa7dTaxpalQHKKCX6J/V7e9YSWNsUosCVNp7RQXjypyIot82EhFkZqwIX5g
        X38rVjNJo1ByxRxSsNKcM1bmjMRvzLb+sQcJRdwVtQW7m+NgDX3O3CK2IQV3AvYaQZlfF33LFA06w
        Ff8TXFcNksl1OTrVMWbZmqAQ+hp4dqRo+nHWPgOYCd98MeIUFBj1HnPOtSWBIqJJzAyEg804jhV8G
        I1B6FV6QZKAQBG386thhYA4ziV1ThTu/cmZFejJYVqL/hbnoXqOtRqwsnYscZGF5oRbLa64XuuJ3t
        fNxxmExg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kATVn-00079D-Sn; Tue, 25 Aug 2020 07:36:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A88FC305C10;
        Tue, 25 Aug 2020 09:36:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DA802C01BB75; Tue, 25 Aug 2020 09:36:51 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:36:51 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200825073651.GW1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200824141429.GA3982@worktop.programming.kicks-ass.net>
 <20200825031503.57d08355bf44900af7d70536@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825031503.57d08355bf44900af7d70536@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:15:03AM +0900, Masami Hiramatsu wrote:

> > I did the below, but i'm not at all sure that isn't horrible broken. I
> > can't really find many rp->lock sites and this might break things by
> > limiting contention.
> 
> This is not enough. 

I was afraid of that..

> For checking the recursion of kretprobes, we might
> need kretprobe_table_trylock() or kretprobe_table_busy() (but both
> can be false positive)

Agreed.

> Note that rp->lock shouldn't matter unless we will support recursive
> kprobe itself. (even though, we can use raw_spin_trylock_irqsave())

If the deadlock mentioned isn't about rp->lock, then what it is about?

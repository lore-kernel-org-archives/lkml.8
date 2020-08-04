Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57099C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E352086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZQl0UP9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHDQvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgHDQvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:51:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704CFC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e2zja8aZ6SqYiYvPmFBqBslRk1AjgMR07SNX1tomLLY=; b=ZQl0UP9U3hZZSLGmPhwR2IDjEN
        OTKWAt5UQ/XwCj5q0cvAToEEMo87oSFCGdexQQcnDteGoO3pYeWi4ra/R+xuWP8kVE1cj9udtyidm
        q5M0Bea8oanJBu6P9uIDytTE9x4LReoF08Ir5I0QZ4mKZUM2pou4u8KB9MQunQ+tgnvCvZeofx6RL
        laCMk33SlDLC2wyvqc8wCgr7XchkX8Pm3BEMgvV92XdvW3/gGC8YawQi5+YVEojs5xxMypEMtPZJt
        0nOi2SbL+kDOjF67QBTGFsRqckQyhiG+fCEudoFDfrl7NSVXf2x1/wr++6areRHJayaT2b6dwfPzM
        ZxECoGEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k309p-0004Ra-Ak; Tue, 04 Aug 2020 16:51:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6ED96301E02;
        Tue,  4 Aug 2020 18:51:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 533302B90EB46; Tue,  4 Aug 2020 18:51:18 +0200 (CEST)
Date:   Tue, 4 Aug 2020 18:51:18 +0200
From:   peterz@infradead.org
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 1/2] sched: Fix exit_mm vs membarrier
Message-ID: <20200804165118.GN2657@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
 <20200804143419.GL2657@hirez.programming.kicks-ass.net>
 <709073430.39864.1596552521779.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709073430.39864.1596552521779.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:48:41AM -0400, Mathieu Desnoyers wrote:
> Here is the scenario I have in mind:

> Userspace variables:
> 
> int x = 0, y = 0;
> 
> CPU 0                   CPU 1
> Thread A                Thread B
> (in thread group A)     (in thread group B)
> 
> x = 1
> barrier()
> y = 1
> exit()
> exit_mm()
> current->mm = NULL;
>                         r1 = load y
>                         membarrier()
>                           skips CPU 0 (no IPI) because its current mm is NULL
>                         r2 = load x
>                         BUG_ON(r1 == 1 && r2 == 0)
> 

Ah, yes of course.

We really should have a bunch of these scenarios in membarrier.c.



Now, the above cannot happen because we have an unconditional
atomic_dec_and_test() in do_exit() before exit_mm(), but I'm sure
relying on that is a wee bit dodgy.

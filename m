Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738E1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465C8206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dG4VOL/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgE2Ngs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgE2Ngr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:36:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472CC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8GyJiUyvd+5kzRtnhV1TlyWrB143/bdbA64L8spSRy0=; b=dG4VOL/C3zrEYJf36wzOKi8Lys
        PzJZHFiCO24laPGtmYX24d0JGuC+1pa1762vUfvtsJzolXZgMoOB4uhs1yz11BD8qpiHAn80a2r8d
        jarzXgl7mYoewNfkkS9h7DLvgECFNmqUIDJhA6xWl9u6+mdrzZAuFgd+gQHqXjXPga2GmV1USWama
        lnlWIFAz/k3fxrqOVzG+9MOYUV5RoKykSAsTlvLry025JDl8IrmdPqV822ayTgENc6lJNPSFDSY/c
        Y+u6JGaOhukUbjjJtOJ3k2mhzQZ9NSSUx/EkNOplrZ88JD6dzrB9MgyowSAjiGW/U8270tzp9p2A4
        V88BzdAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jefBk-0008MF-Dj; Fri, 29 May 2020 13:36:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E4BF3011FF;
        Fri, 29 May 2020 15:36:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F94B2BD9C46F; Fri, 29 May 2020 15:36:41 +0200 (CEST)
Date:   Fri, 29 May 2020 15:36:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <20200529133641.GM706495@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
 <20200528234031.GB551@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528234031.GB551@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:40:32AM +0200, Frederic Weisbecker wrote:
> On Tue, May 26, 2020 at 06:11:02PM +0200, Peter Zijlstra wrote:

> > +/*
> > + * structure shares layout with single_call_data_t.
> > + */
> >  struct irq_work {
> > -	atomic_t flags;
> >  	struct llist_node llnode;
> > +	atomic_t flags;
> 
> 
> We should probably have:
> 
> struct csd_node {
>        atomic_t flags;
>        struct llist_node;
> }
> 
> embed inside struct irq_work and struct __call_single_data. Relying on
> structure layout for things to work doesn't really clarify things :-)

Yes I know, but changing those structures is going to cause an aweful
lot of churn, and I didn't want to do that just now.. :-(

Also, there's more fun..

  CSD_TYPE_SYNC/ASYNC:

	struct {
		struct llist_node node;
		unsigned int flags;
		smp_call_func_t func;
		void *info;
	};

  CSD_TYPE_IRQ_WORK:

	struct {
		struct llist_node node;
		atomic_t flags;
		void (*func)(struct irq_work *);
	};

  CSD_TYPE_TTWU:

	struct {
		struct llist_node node;
		unsigned int flags;
	};

So while they all have a 'u32' sized @flags, irq_work wants it atomic.
Also, if we were to actually have the struct csd_node {}, you get a 4
byte hole when you embed it in task_struct.

This is all entirely fugly. No doubt about it.

But I failed to find a 'sane' way to express it and needed to get these
patches out because things were broken.

Maybe I can anonymous-union my way around it, dunno. I'll think about
it. I'm certainly not proud of this. But at least the BUILD_BUG_ON()s
should catch the more blatant breakage here.

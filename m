Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A87C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811812075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DcMnVH1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgFEQSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgFEQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:18:29 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B1C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=utNI+MJiTsn2M/U2LdUZJZhP8QgBIUppz4EFqbydICQ=; b=DcMnVH1eeOjboyoQ+gRrYAcCyS
        46RZsQvjM4nxsU2esHscYyjqQ5edut8vaP/p08P3+Am7IbAycNYmQnxgYcML+74qlFbudvkM6f+hZ
        LK9iX1uhdpdi+lBJ+qeKvEaD5s0T7+WbgHsJRZnu+f8uRul7/AfktTr6KFjda10YtdE4eNFjDbUX/
        3xXOmN5h8JfZuF+Do0ZjFt0UJ/wdtmyMzGJ7XTGHwofLMQB/i375bCuyc9hhusqW7AceqK4KExgut
        0xRTTx9NEYCTQ6E1h+OgveY3oMUT43JygzMwNjOw+6eftMRejVawk3tD4N/n5NiAzqrN1u3Kx0LxC
        mlNf5ymQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhF2c-000626-LE; Fri, 05 Jun 2020 16:17:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DA17301A7A;
        Fri,  5 Jun 2020 18:17:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7D61214D7C2F; Fri,  5 Jun 2020 18:17:54 +0200 (CEST)
Date:   Fri, 5 Jun 2020 18:17:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net, sfr@canb.auug.org.au,
        linux@roeck-us.net, keescook@chromium.org
Subject: Re: [RFC][PATCH 5/7] irq_work, smp: Allow irq_work on
 call_single_queue
Message-ID: <20200605161754.GK3976@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.011635912@infradead.org>
 <20200528234031.GB551@lenoir>
 <20200529133641.GM706495@hirez.programming.kicks-ass.net>
 <20200605093704.GB2948@hirez.programming.kicks-ass.net>
 <20200605150207.GA9599@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605150207.GA9599@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:02:08PM +0200, Frederic Weisbecker wrote:
> On Fri, Jun 05, 2020 at 11:37:04AM +0200, Peter Zijlstra wrote:
> >  struct irq_work {
> > -	struct llist_node llnode;
> > -	atomic_t flags;
> > +	union {
> > +		struct __call_single_node node;
> > +		struct {
> > +			struct llist_node llnode;
> > +			atomic_t flags;
> > +		};
> > +	};
> 
> So why not just embed struct __call_single_node in
> struct irq_work and struct __call_single_data ?
> 
> Is the point of that anonymous second union layer to
> shorten the lines while accessing members?

To cut down on all the churn. irq_work is small and could easily be
fixed up, but csd is used in quite a few places.



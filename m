Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A86C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCE4207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtqJqEuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgFWSNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:13:51 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3498FC061573;
        Tue, 23 Jun 2020 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Esyq+AEdoh1XonloiuoRagpt95xyDAj6PU4H+a2A370=; b=XtqJqEuJ6fk19CHHDiS/uWu7m0
        RAcYnkqt4nYjb3KNc+oUduIZ4BmQP6z7+ubMqv/JvBbC0/xybPxcpQOpQ/lg78gd2x3ZCJn9O6mkt
        Jd5I2z7aiGrouE6zK9gfUYo9bIvJl5dPbeWIYGWpiwKHEq2yefSrMbieDo8PwFR4ey3HjXZsEOZo+
        kpeu2fan50uIPlXjGdc5H6SPIPfo5+/vVs7+Y3TBJ/eY4XYLK7YLqWy42vBSITC110wTLB/gjxvnQ
        cqjN7VtvtR9/alVFGB6linsRbGqpzYe0uAFkxKU8EndRnmKY04OLN74stY8WRWXUSKeBa9tcMtxn0
        Pl+jThxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnnPO-0006JO-In; Tue, 23 Jun 2020 18:12:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BF5E303DA0;
        Tue, 23 Jun 2020 20:12:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DE8F20267E51; Tue, 23 Jun 2020 20:12:32 +0200 (CEST)
Date:   Tue, 23 Jun 2020 20:12:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623181232.GB4800@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623175957.GA106514@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:59:57PM +0200, Marco Elver wrote:
> On Tue, Jun 23, 2020 at 06:37PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> > > Well, freshly merged code is using it. For example, KCSAN:
> > > 
> > >     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
> > >     => kernel/kcsan/report.c:
> > > 
> > >     void kcsan_report(...)
> > >     {
> > > 	...
> > >         /*
> > >          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
> > >          * we do not turn off lockdep here; this could happen due to recursion
> > >          * into lockdep via KCSAN if we detect a race in utilities used by
> > >          * lockdep.
> > >          */
> > >         lockdep_off();
> > > 	...
> > >     }
> > 
> > Marco, do you remember what exactly happened there? Because I'm about to
> > wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
> > lockdep_off().
> 
> Yeah, I was trying to squash any kind of recursion:
> 
> 	lockdep -> other libs ->
> 		-> KCSAN
> 		-> print report
> 		-> dump stack, printk and friends
> 		-> lockdep -> other libs
> 			-> KCSAN ...
> 
> Some history:
> 
> * Initial patch to fix:
> 	https://lore.kernel.org/lkml/20200115162512.70807-1-elver@google.com/

That patch is weird; just :=n on lockdep.c should've cured that, the
rest is massive overkill.

> * KCSAN+lockdep+ftrace:
> 	https://lore.kernel.org/lkml/20200214211035.209972-1-elver@google.com/

That doesn't really have anything useful..

> lockdep now has KCSAN_SANITIZE := n, but we still need to ensure that
> there are no paths out of lockdep, or the IRQ flags tracing code, that
> might lead through other libs, through KCSAN, libs used to generate a
> report, and back to lockdep.
> 
> I never quite figured out the exact trace that led to corruption, but
> avoiding any kind of potential for recursion was the only thing that
> would avoid the check_flags() warnings.

Fair enough; I'll rip it all up and boot a KCSAN kernel, see what if
anything happens.

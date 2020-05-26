Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3DDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005462073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uZAIMZI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEZIQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:16:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52432 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e2MwWe7Ixqq38W0YV5HpIWiJs7gWWp0umQ/6FgHLKss=; b=uZAIMZI4tKYflTVu4AkMQ8ugSL
        i0wE2fZF3kQP9C4bNOFFwKZVeKPshT0KB0qNTE7PIMLM9MjrNBldjeMNNLHK82hitFWTHPDhrfSJG
        /B34llj/JtKVzQeCf5Xzc8ksZTsotqI3aMzvBLpD+mcdOvrArgUVK57tAtSEZwk1s88MvBGf1+WJt
        lIBrCnga/ICVWtmz0pxDGV4qF4OGzGpPV+6uQXxjWyK0jUT09fvFkswgOqKAE/9raQxwK7TCTxugS
        q5KFMzHgflz6GWMssFtGnw0Xir81UC2tA1jGd9qCqzAbXyQylwMDCVpsDfz/k2/p+R07Nb799EmT2
        jXqEDU3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdUin-0003ao-2Y; Tue, 26 May 2020 08:14:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0BDF30280E;
        Tue, 26 May 2020 10:13:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A514020BE0DF0; Tue, 26 May 2020 10:13:50 +0200 (CEST)
Date:   Tue, 26 May 2020 10:13:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200526081350.GI317569@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
 <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
 <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
 <20200523224132.GD2483@worktop.programming.kicks-ass.net>
 <20200525102241.GF325303@hirez.programming.kicks-ass.net>
 <20200526005231.GA377571@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526005231.GA377571@debian-buster-darwi.lab.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:52:31AM +0200, Ahmed S. Darwish wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:

> > +#define lockdep_assert_irqs_enabled()					\
> > +do {									\
> > +	WARN_ON_ONCE(debug_locks && !this_cpu_read(hardirqs_enabled));	\
> > +} while (0)
> >
> 
> Given that lockdep_off() is defined at lockdep.c as:
> 
>   void lockdep_off(void)
>   {
>         current->lockdep_recursion += LOCKDEP_OFF;
>   }
> 
> This would imply that all of the macros:
> 
>   - lockdep_assert_irqs_enabled()
>   - lockdep_assert_irqs_disabled()
>   - lockdep_assert_in_irq()
>   - lockdep_assert_preemption_disabled()
>   - lockdep_assert_preemption_enabled()
> 
> will do the lockdep checks *even if* lockdep_off() was called.
> 
> This doesn't sound right. Even if all of the above macros call sites
> didn't care about lockdep_off()/on(), it is semantically incoherent.

lockdep_off() is an abomination and really should not exist.

That dm-cache-target.c thing, for example, is atrocious shite that will
explode on -rt. Whoever wrote that needs a 'medal'.

People using it deserve all the pain they get.

Also; IRQ state _should_ be tracked irrespective of tracking lock
dependencies -- I see that that currently isn't entirely the case, lemme
go fix that.


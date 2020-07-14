Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3989C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE8820EDD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/eqTvsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGNJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgGNJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:51:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A728C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qpflADDB8duWFPNOBOGruujNU1s0jhnlL6Ni9lBcoy8=; b=S/eqTvsz67ItruD2u3IIIM0G56
        mf9aMboJoJ9XM3/qQEwdbDJDWwTH3rJALOF2fMRsn6bPMLixgR/kD37OtdbhUbsb+rCS6GP+s2JJt
        4QazkH2mGIx/TausVc/S/XR5Ri6K0mJNH5jCNaFa34oEs4U5Cx1mW4oXkouugxS3KUYyAzwN9FYOA
        BoEq5rb/QkX8mG6PFWx19yCYeGuOA1z5c7BeaM65s3TSi0iNmPUBqyArUzNvQwf0BRgI1dGWW6uRw
        Tuvkatu0HRF93CNVYBxRvDmJqPTo4132bCLpiQqb1n1CdVcJxOvuD50yvoUtKwEUNsyq3SGnhUq0P
        4rXGKoeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvHat-0000PN-8H; Tue, 14 Jul 2020 09:51:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A27CB300455;
        Tue, 14 Jul 2020 11:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A03D28B91079; Tue, 14 Jul 2020 11:51:17 +0200 (CEST)
Date:   Tue, 14 Jul 2020 11:51:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 15/17] static_call: Allow early init
Message-ID: <20200714095117.GS10769@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
 <20200710134337.036717190@infradead.org>
 <20200710211426.298a3d94@oasis.local.home>
 <20200711050831.GY597537@hirez.programming.kicks-ass.net>
 <20200713162419.3a45f334@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713162419.3a45f334@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 04:24:19PM -0400, Steven Rostedt wrote:
> On Sat, 11 Jul 2020 07:08:31 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jul 10, 2020 at 09:14:26PM -0400, Steven Rostedt wrote:
> > > On Fri, 10 Jul 2020 15:38:46 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > In order to use static_call() to wire up x86_pmu, we need to
> > > > initialize earlier; copy some of the tricks from jump_label to enable
> > > > this.
> > > > 
> > > > Primarily we overload key->next to store a sites pointer when there
> > > > are no modules, this avoids having to use kmalloc() to initialize the
> > > > sites and allows us to run much earlier.
> > > >   
> > > 
> > > I'm confused. What was the need to have key->next store site pointers
> > > in order to move it up earlier?  
> > 
> > The critical part was to not need an allocation.
> 
> Why is an allocation needed? What's different about calling it early
> that we need an allocation or this trick?
> 
> The two paragraphs above seem totally disconnected.
> 
> "In order to use static_call() to wire up x86_pmu, we need to
> initialize earlier; copy some of the tricks from jump_label to enable
> this."
> 
> What tricks were copied?
> 
> "Primarily we overload key->next to store a sites pointer when there

^^ this trick...

+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};

If that isn't a trick, I don't know ;-)

> are no modules, this avoids having to use kmalloc() to initialize the
> sites and allows us to run much earlier."
> 
> Why is kmalloc() (or this trick) needed to initialize the sites?

That's just how the code was; it treated vmlinux as the NULL module, and
as such needed a static_call_mod allocated to host the static_call_sites
pointer.

That is, the static_call_key has a single linked list pointer to
static_call_mod, and every module has an entry on that list with a
pointer to their sites. Very simple and straight forward.

Except it requires an allocation to set up, which is a pain is you want
it initialized very early.


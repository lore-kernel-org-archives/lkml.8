Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C8FC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944852084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XArRHwdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgBZQIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:08:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgBZQIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eciKYtYKZyNp/Oyu78BdOELsMG3xAZc2QO1gPvE9SmY=; b=XArRHwdMrfKlWeQhtAuAv61IZD
        XFla/1tlyVZOG05cJX3K49HqpYJrcvXohYtqBiSq4eLzch0TTc9+DmPT7+XuGcR1U7JdWdZPT99vt
        BMjsJngfWplGRYOr+PSFOaNsLkNl7Yg3TOURC5DXD4SIzvQEg+GZLlYmDT5H7qm/d76se2l5vNHg8
        owu0jPPLE4Xoh1723YYGkKkV+EZ5cm3XxFazdyKeB8hB3gWG9A5GoWm3wPc6vPmXBgtJGJfp7LDAm
        pZOueqUGJmtDHw4NmwrIuPRPBLWJxicuAbbLs9YBTOK/NtPB0bzOlWki3ncQTEJRaJdPZBh7W2Ydi
        Cf8BYCsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6zET-0007v5-IK; Wed, 26 Feb 2020 16:08:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21DAB300130;
        Wed, 26 Feb 2020 17:06:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3E802B7418A0; Wed, 26 Feb 2020 17:08:18 +0100 (CET)
Date:   Wed, 26 Feb 2020 17:08:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226160818.GY18400@hirez.programming.kicks-ass.net>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.315548935@linutronix.de>
 <20200226011349.GH9599@lenoir>
 <d9bde3a6-1e19-1340-1fda-bc6de2eb4f7c@kernel.org>
 <20200226132850.GX18400@hirez.programming.kicks-ass.net>
 <CALCETrVXzwmwNOB6qUk7aM=LQRBySrMJPdRZ244T3y1bpRBzaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVXzwmwNOB6qUk7aM=LQRBySrMJPdRZ244T3y1bpRBzaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 07:10:01AM -0800, Andy Lutomirski wrote:
> On Wed, Feb 26, 2020 at 5:28 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Feb 25, 2020 at 09:29:00PM -0800, Andy Lutomirski wrote:
> >
> > > >> +void notrace do_machine_check(struct pt_regs *regs, long error_code)
> > > >>  {
> > > >>    DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
> > > >>    DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> > > >> @@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
> > > >>    ist_exit(regs);
> > > >>  }
> > > >>  EXPORT_SYMBOL_GPL(do_machine_check);
> > > >> +NOKPROBE_SYMBOL(do_machine_check);
> > > >
> > > > That won't protect all the function called by do_machine_check(), right?
> > > > There are lots of them.
> > > >
> > >
> > > It at least means we can survive to run actual C code in
> > > do_machine_check(), which lets us try to mitigate this issue further.
> > > PeterZ has patches for that, and maybe this series fixes it later on.
> > > (I'm reading in order!)
> >
> > Yeah, I don't cover that either. Making the kernel completely kprobe
> > safe is _lots_ more work I think.
> >
> > We really need some form of automation for this :/ The current situation
> > is completely nonsatisfactory.
> 
> I've looked at too many patches lately and lost track a bit of which
> is which.  Shouldn't a simple tracing_disable() or similar in
> do_machine_check() be sufficient?

It entirely depends on what the goal is :-/ On the one hand I see why
people might want function tracing / kprobes enabled, OTOH it's all
mighty frigging scary. Any tracing/probing/whatever on an MCE has the
potential to make a bad situation worse -- not unlike the same on #DF.

The same with that compiler instrumentation crap; allowing kprobes on
*SAN code has the potential to inject probes in arbitrary random code.
At the same time, if you're running a kernel with that on and injecting
kprobes in it, you're welcome to own the remaining pieces.

How far do we want to go? At some point I think we'll have to give
people rope, show then the knot and leave them be.

> We'd maybe want automation to check
> everything before it.  We still need to survive hitting a kprobe int3,
> but that shouldn't have recursion issues.

Right, so I think avoiding the obvious recursion issues is a more
tractable problem and yes some 'safe' spot annotation should be enough
to get automation working for that -- mostly.

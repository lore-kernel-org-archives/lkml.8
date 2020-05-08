Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021BC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA0120870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eh1IKm04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgEHMqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729443AbgEHMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67008C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fv3tCmIOkPBMFm+eOon0jR/scXReOp+FqwgAM+RJy7g=; b=eh1IKm04spoVdqNCUB2bspGRyj
        ajneD5hV2+aJaeGEFtkeW26q3S/h0DG4GOJX2JugNJbJMNPRNu3ipQlOUA8vDmMKEhCVfdi/Btt74
        eTcJ/uNTHP6t+zEDvlebV16CyIJ2kF9b7uoe7gcPT83S7aaH9o7u8GPznyBjGvUPosYTtI7nF6lEA
        45rDdtcLDlrBTHuXPm6CXRQmGoXDg02BRLzWNT6sd4MFFh3Ak3QReqmrCBxXP2G+/88S1lsRGvzyJ
        /pMtE4n496Uge2ojxVhbr7LPeFZn7LNtMH79LFu9erGgbmMhCXWgAXEGL/iNSn/U3332ua35nOd9u
        yaJr08fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX2O6-00035E-NB; Fri, 08 May 2020 12:46:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9623D307968;
        Fri,  8 May 2020 14:45:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A5E72B843CE2; Fri,  8 May 2020 14:45:56 +0200 (CEST)
Date:   Fri, 8 May 2020 14:45:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
Message-ID: <20200508124556.GI5281@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de>
 <20200505135314.808628211@linutronix.de>
 <16c57a7e-8d39-d77e-915d-41b7f5e042fd@oracle.com>
 <20200508085909.GU5298@hirez.programming.kicks-ass.net>
 <87wo5mk595.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo5mk595.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:58:30PM +0200, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> >> > +static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
> >> > +{
> >> > +	/*
> >> > +	 * Disable breakpoints during exception handling; recursive exceptions
> >> > +	 * are exceedingly 'fun'.
> >> > +	 *
> >> > +	 * Since this function is NOKPROBE, and that also applies to
> >> > +	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
> >> > +	 * HW_BREAKPOINT_W on our stack)
> >> > +	 *
> >> > +	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
> >> > +	 * includes the entry stack is excluded for everything.
> >> > +	 */
> >> > +	get_debugreg(*dr7, 6);
> >> 
> >> Do you mean  get_debugreg(*dr7, 7); ?
> >
> > Shees, I have to go buy a new stack of brown paper bags at this rate,
> > don't I :/
> 
> Not only you, but it's also  amazing that the selftests didn't catch
> that.

I don't think the selftests try and set hardware breakpoints in the
kernel.

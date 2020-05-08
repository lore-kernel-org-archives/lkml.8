Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222B6C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C6621473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEHL7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:59:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62828C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 04:59:02 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jX1eD-0004Qe-4X; Fri, 08 May 2020 13:58:33 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8CCE1101175; Fri,  8 May 2020 13:58:30 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
In-Reply-To: <20200508085909.GU5298@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de> <20200505135314.808628211@linutronix.de> <16c57a7e-8d39-d77e-915d-41b7f5e042fd@oracle.com> <20200508085909.GU5298@hirez.programming.kicks-ass.net>
Date:   Fri, 08 May 2020 13:58:30 +0200
Message-ID: <87wo5mk595.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
>> > +static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
>> > +{
>> > +	/*
>> > +	 * Disable breakpoints during exception handling; recursive exceptions
>> > +	 * are exceedingly 'fun'.
>> > +	 *
>> > +	 * Since this function is NOKPROBE, and that also applies to
>> > +	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
>> > +	 * HW_BREAKPOINT_W on our stack)
>> > +	 *
>> > +	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
>> > +	 * includes the entry stack is excluded for everything.
>> > +	 */
>> > +	get_debugreg(*dr7, 6);
>> 
>> Do you mean  get_debugreg(*dr7, 7); ?
>
> Shees, I have to go buy a new stack of brown paper bags at this rate,
> don't I :/

Not only you, but it's also  amazing that the selftests didn't catch
that.

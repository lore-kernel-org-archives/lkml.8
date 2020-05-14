Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5304C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B604520722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JTh0R+tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgENMeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgENMeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:34:13 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9F4C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QY51KowpkMziRnri9y8EGkC6ZGoauOqKOpLw1xED51U=; b=JTh0R+tjnlw1FJKXZntBhP8KYM
        bMufV9JbHuoWaG8dpRrUh5Mxv0x+5SbBNdbogDTSkQLkVCYNbb1hZbYmWEw+P+S5DgSNLomuafJb5
        b2W6NJe7gB3VYj30ZyFhnAJzFpadmGOztWfUTtn75MmmMuBUbGlivQa7w/br8Mm2q/fIb4AO+hSGD
        wZ+vxkn745hoTrDjg3BE6nz+Zz6AakwTAjtnhUcm0W4QlWH1/dZ11BjzZn3LHUQpGbgCzyZ7rQMEf
        Y3T7GyUecpuXdKzuizHZOr5QdYgiTm+GvalZ0Sd4K+R/EBOmMWFvNqq3CwL1RYHT3YBJ6PUa0/JqX
        VQn6w9vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZD3O-0006ut-2q; Thu, 14 May 2020 12:33:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C5EE302753;
        Thu, 14 May 2020 14:33:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB57D213C8B5C; Thu, 14 May 2020 14:33:30 +0200 (CEST)
Date:   Thu, 14 May 2020 14:33:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
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
Subject: Re: [patch V4 part 3 13/29] x86/traps: Prepare for using
 DEFINE_IDTENTRY
Message-ID: <20200514123330.GX2978@hirez.programming.kicks-ass.net>
References: <20200505134354.774943181@linutronix.de>
 <20200505134904.556327833@linutronix.de>
 <CALCETrUyA5bN2ScrdhwEYZSUpyOhO+MaEu1X3PwX6vHGGCkqCg@mail.gmail.com>
 <87mu6azp7m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu6azp7m.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 02:16:29PM +0200, Thomas Gleixner wrote:
> Andy Lutomirski <luto@kernel.org> writes:

> > /*
> >  * Returns the address from which a user trap originated.  This would be the same as regs->ip,
> >  * except for frhgnieawfn nvlrkvklsrvs and mfkealwf, and this lets the thingummy pass a
> >  * modified value to the signal frame, but only for #DE and #UD, because #*!&@&#@.
> >  */
> >
> > except with the blanks filled in.
> 
> Hmm. Filling the blanks gives me:
> 
> /*
> **0Returns1the2address3from4which5a6user7trap8originated.90This1would...
> 
> That's not really more readable than yours :)

ROFL -- You just made me spill my tea!

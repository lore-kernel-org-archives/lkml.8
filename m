Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B74C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D9F2224D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xano3p/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHTIg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgHTIgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:36:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5A6C061383
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HuD6sO9p3LttLGhSMpvSAhHaQh3vLV8YjoVUz+ABkl0=; b=Xano3p/mP6+ybPndxE+r1ziYFp
        k+wvIFLFQZNj5HtgvmHa2Vfkl2LBiXX5ZL5hFdKRt+s6Aerhss7xIqnCSJYo0iM8xOB/EfaOSpo8f
        +mC2OywBCAuHLdTXmDhmxtNVJMVacK5/saEMTPveCoeoZBtb4TtniylAc7gn+eNjsFt11GPqcnGMq
        LiPWNQVauiyDJDwzE/tKlIkpgT0seOxGhxUwbjwZ2q1rp7RUXQaCz+agz+qWXl8eKpss23urQc4RK
        AoEbcSq1GvxSvOVusYpnJbNzdIA3/SffrwOnW/GDVJ+AJfRkW9/S5KdNFUymakC9Xf9qQY4I9i6qc
        Pc4gm/LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8g2u-00044K-OP; Thu, 20 Aug 2020 08:35:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70DAE302526;
        Thu, 20 Aug 2020 10:35:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B88B2C1AC133; Thu, 20 Aug 2020 10:35:39 +0200 (CEST)
Date:   Thu, 20 Aug 2020 10:35:39 +0200
From:   peterz@infradead.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
Message-ID: <20200820083539.GN2674@hirez.programming.kicks-ass.net>
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
 <20200819184149.GH2674@hirez.programming.kicks-ass.net>
 <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
 <20200819213534.GQ3982@worktop.programming.kicks-ass.net>
 <20200819224731.3edo5lqw6lbuprdx@treble>
 <CALCETrV8sVjhVYig4ZvYDN3pEbF0tvekXCcJCBakeZbMn0gZ=A@mail.gmail.com>
 <20200820034636.tl4nq5aiitpfvx62@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820034636.tl4nq5aiitpfvx62@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:46:36PM -0500, Josh Poimboeuf wrote:
> On Wed, Aug 19, 2020 at 05:14:18PM -0700, Andy Lutomirski wrote:

> > I'm pretty sure you have the buggy sequence of events right, but for
> > the wrong reason.  There's nothing wrong with scheduling when
> > delivering SIGTRAP, but it's definitely wrong to blindly save and
> > restore DR7 around scheduling and around ptrace invocations.  Remember
> > this is an entry from user mode, so it runs on the user stack.

*groan*, yeah that's broken :/

> Wow, I had no idea user #DB's run on the task stack.  The scheduling
> from #DB blew my mind :-)  What's the purpose of that?

At the very least that vm86 junk needs to I think. Also -RT needs it to
send signals.


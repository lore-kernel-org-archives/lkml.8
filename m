Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC020C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A230220882
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0E9pLYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgFOQR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:17:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p6GnmDUPB8eMnYJNSFAMEf26+Raf9w/fxd1XfSZxDoY=; b=s0E9pLYTDbXguSDj/n9DW5BHvf
        7a++E+yu6QSGls201Iv5kblUQhKYyssCNWSYC+uTa1KIyZi22W0KkE2+tLhyZVlw1OYZ4dw1YnFe0
        DAGEynY8Nv0KyLOQx0eWUacKKeO/4Q76QmbHDjCThlUfOGwa5/F89Uqae5StvhO1Fv5w3NN5DD93p
        Xk1o3mgg2nrS3iHSEpHJ3v0HKJR6lh3McR9kF8FrpOfmsG9f3Vjh0H5ljwsyJE6j2LLJ/p0o0/GgF
        5WOlf86aX584vxSBLpwrazoEWvwL6VjkHJ6LaNjX721l6HDHD7MQ28i8xIahVnmMXRhhinHVbWjYX
        7sErih+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkrnQ-0000j3-Ln; Mon, 15 Jun 2020 16:17:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 643CB301A32;
        Mon, 15 Jun 2020 18:17:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A87720BCADEE; Mon, 15 Jun 2020 18:17:13 +0200 (CEST)
Date:   Mon, 15 Jun 2020 18:17:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V6 00/37] x86/entry: Rework leftovers and merge plan
Message-ID: <20200615161713.GH2554@hirez.programming.kicks-ass.net>
References: <20200518160750.GA279861@hirez.programming.kicks-ass.net>
 <87367xvvmy.fsf@nanos.tec.linutronix.de>
 <20200519083826.GC279861@hirez.programming.kicks-ass.net>
 <20200519090226.GD279861@hirez.programming.kicks-ass.net>
 <CAJhGHyCStHRzqv2Di57ALnBiPCpKjob4TG6Hj76+NowpNLqD7w@mail.gmail.com>
 <20200523130836.GB2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523130836.GB2483@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 03:08:36PM +0200, Peter Zijlstra wrote:
> On Sat, May 23, 2020 at 10:52:24AM +0800, Lai Jiangshan wrote:
> 
> > Hello,
> > 
> > I, who don't know how does the objtool handle it, am just curious.
> > _begin() and _end() are symmetrical, which means if _end() (without nop)
> > can escape, so can _begin() in a reverse way. For example:
> > 
> > noinstr void foo()
> > {
> >     instrumentation_begin();
> >     do {
> >             instrumentation_begin();
> >             ...
> >             instrumentation_end();
> >     } while (cond);
> >     bar();
> >     instrumentation_end();
> > }
> > 
> > Here, the first _begin() can be "dragged" into the do-while block.
> > Expectedly, objtool validation should not complain here.
> > 
> > But objtool validation's not complaining means it can handle it
> > magically correctly (by distinguishing how many _begin()s should
> > be taken around the jmp target when jmp in a specific path), or
> > handle it by not checking if all paths have the same count onto
> > a jmp target (a little nervous to me), or other possible ways.
> 
> No, I tihnk you're right. It could be we never hit this particular
> problem. Even the one described, where end leaks out, is quite rare. For
> instance, the last one I debgged (that led to this patch) only showed
> itself with gcc-9, but not with gcc-8 for example.
> 
> Anyway, if we ever find the above, I'll add the NOP to begin too.

FYI, I just found one, I'll be making instrumentation_begin() a NOP
too.

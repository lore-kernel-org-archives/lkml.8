Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00655C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7DF2206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KUM/OOP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgFDP4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbgFDP4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:56:17 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D8DC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rc2AdC8RrNMxxOkbylnp725gNWa66O1BcDCG1Dewflc=; b=KUM/OOP/GMXdmstsmt0e1PENGM
        pwMzoJa69dliO953j96ZnL3fHmPmau3kA99uqEd+/SJ5Nj+0pJA5w4CHWpS0Vz3OXLTyIkj5OtIpL
        2qFrzuIsF/2vQI5e2RJ/XG65R0VKa8unXIRhzyAl5Osh4/uHwXtnrET7yrsZlyJl7Y7a/+XpY5kK8
        ITGv8T2tRH0jIeze3yuweWsaRibTXIXw/dkjET2YQZagzBEmWSamfA07gHiTscu+LNZMTvdRm4oKd
        Hfbf6e9Mojrlh3YOmO6A9rkb6hGdb3WX/GlUp4WqN6rtM5HI11uPqKstCLISlE5fsO3dpvKcVHZWd
        PFvBpQCQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgsDK-0004LJ-8u; Thu, 04 Jun 2020 15:55:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87F6330008D;
        Thu,  4 Jun 2020 17:55:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A8B820E061A1; Thu,  4 Jun 2020 17:55:26 +0200 (CEST)
Date:   Thu, 4 Jun 2020 17:55:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
Message-ID: <20200604155526.GE3976@hirez.programming.kicks-ass.net>
References: <20200521200513.656533920@linutronix.de>
 <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
 <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
 <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
 <20200604132537.GA3976@hirez.programming.kicks-ass.net>
 <c150c709-15d6-b126-4522-364b6663dcd5@redhat.com>
 <20200604133545.GB3976@hirez.programming.kicks-ass.net>
 <CALCETrV89Sat5Dm5YTF_pcxMMrxygEwa78trpONm8MVMGZtWPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV89Sat5Dm5YTF_pcxMMrxygEwa78trpONm8MVMGZtWPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 08:42:52AM -0700, Andy Lutomirski wrote:

> x86 is not an architecture.  x86 is a gauntlet through which operating
> system developers must run.

That made my day :-)

> I think we can tolerate this particular mess -- can't we just say that
> a BUS LOCK DEBUG EXCEPTION is fatal if it came from kernel mode?  So
> what if it nests inside #DB -- we can survive an oops from a corrupt
> context like that.

Yes, SLD or this new thing is unconditionally fatal when from kernel
space. As long as we can get to the OOPS with our stacks completely
wrecked, we should be good I think.

We'll just need to make this one of the very first things is checks for,
to minimize the amount of code ran before OOPSing, so at to minimize the
risk for recursive exceptions.

All signs of excellent design, I'm sure.

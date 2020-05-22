Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 047BE2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hGea2fy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgEVVUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:20:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:32906 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgEVVUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8cuIjs1Fr5w8AxNS06xANaNwHfEeg7yg4plV86FdLAY=; b=hGea2fy0S+CagfnIjDhhmJ0kxH
        QmQ2CUw4WtS2tu4CJjDltXI/xcTMc8NXRf4sa+FlgUWn5lx0OqhP4eoGZQYZ/uXCiFqF8CHSKEsde
        F9pKTVpi3lYFnQn283I8ac09kBBW2HnshNPJORDCdMNXzc93bt/Ei+nHRocRkUiV+jb0yC88xl1ZF
        Q42YJKd+LN0+stZyqDyNHBNR/G3iksiOp2RgbHAfQeSsqGXfulONhtlse6gR1563TboUpnqHs6FtS
        P+qOw+sNQIdWIeD0KlJ43lnqCiMP95mD36C7CaSIQgE8LDMZ3o2PKtyLBEt/+POJ8+n5Ub5l5E1ei
        FKEAZGOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcF2S-00033W-DQ; Fri, 22 May 2020 21:17:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88F2E9834A3; Fri, 22 May 2020 23:17:06 +0200 (CEST)
Date:   Fri, 22 May 2020 23:17:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
Message-ID: <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
References: <20200521200513.656533920@linutronix.de>
 <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 08:20:15AM +0100, Andrew Cooper wrote:
> Apologies for opening a related can of worms.
> 
> The new debug_enter() has propagated a pre-existing issue forward,
> ultimately caused by bad advice in the SDM.
> 
> Because the RTM status bit in DR6 has inverted polarity, writing DR6 to
> 0 causes RTM to appear asserted to any logic which cares, despite RTM
> debugging not being enabled.  The same is true in principle for what is
> handed to userspace via u_debugreg[DR_STATUS].
> 
> On the subject of DR6, the SDM now reads:
> 
> "Certain debug exceptions may clear bits 0-3. The remaining contents of
> the DR6 register are never cleared by the processor. To avoid confusion
> in identifying debug exceptions, debug handlers should clear the
> register (except bit 16, which they should set) before returning to the
> interrupted task."

*URGH*

> First of all, that should read "are never de-asserted by the processor"
> rather than "cleared", but the advice has still failed to learn from its
> first mistake.  The forward-compatible way to fix this is to set
> DR6_DEFAULT (0xffff0ff0) which also covers future inverted polarity bits.
> 
> As for what to do about userspace, that is harder.  One approach is to
> express everything in terms of positive polarity (i.e. pass on dr6 ^
> DR6_DEFAULT), so DR6_RTM only appears set when RTM debugging is
> enabled.  This approach is already taken with the VMCS PENDING_DBG
> field, so there is at least previous form.
> 
> I realise that "do nothing" might be acceptable at this point, given the
> lack of support for RTM debugging.

This! I'm thinking "do nothing" is, at this moment, the right thing to
do. If/when someone goes and tries to make RTM debugging work, they get
to figure out how to deal with this mess.


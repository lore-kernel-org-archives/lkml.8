Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D52C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1D207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589557534;
	bh=0ST6NAr9AIdPDaq0d+SQMLrUouIAHbxIEkJ1M8i/Yaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KN9fMENhnwxRgSQ5PtZ975/hVYJJt5biiF/eaJO8ytGCqtzIRL9CUkkplcVOdLwjB
	 ujFoVQk4DzKuXX7psE82i+w62NcDXZrL2OZliUe9biGNNRWyO4ma9GfWdBCJEoedhs
	 aqSng1pThf/nTAt/qPVLtqC7OfQ1/v0qQ2MRfBYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEOPpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgEOPpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:45:33 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD0D20758;
        Fri, 15 May 2020 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589557532;
        bh=0ST6NAr9AIdPDaq0d+SQMLrUouIAHbxIEkJ1M8i/Yaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlSgvHYQ88QNdO7n7dwWALwikGrmdyZLoJqQOGwLGFh/imAFxDCeZHuycwfaOUANs
         w9fdLhLlwNPnd2CyArwuGjV8Mgrww6fHMHWvOb9qEo1ShTL3EMUyFqtZd5paoQ+xsi
         hol46033dtsERwlGuXKkjT63I+if8+aS4dYoVfxQ=
Date:   Fri, 15 May 2020 16:45:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>, maz@kernel.org
Subject: Re: [patch V4 part 1 27/36] arm64: Prepare arch_nmi_enter() for
 recursion
Message-ID: <20200515154525.GA23334@willie-the-truck>
References: <20200505131602.633487962@linutronix.de>
 <20200505134100.771491291@linutronix.de>
 <427895535.20271.1589412514423.JavaMail.zimbra@efficios.com>
 <20200515140438.GA5974@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515140438.GA5974@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 04:04:39PM +0200, Frederic Weisbecker wrote:
> On Wed, May 13, 2020 at 07:28:34PM -0400, Mathieu Desnoyers wrote:
> > ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
> > 
> > > +#define arch_nmi_enter()						\
> > [...]							\
> > > +	___hcr = read_sysreg(hcr_el2);					\
> > > +	if (!(___hcr & HCR_TGE)) {					\
> > > +		write_sysreg(___hcr | HCR_TGE, hcr_el2);		\
> > > +		isb();							\
> > 
> > Why is there an isb() above ^ ....
> > 
> > > +	}								\
> > > +	/*								\
> > [...]
> > > -#define arch_nmi_exit()								\
> > [...]
> > > +	/*								\
> > > +	 * Make sure ___ctx->cnt release is visible before we		\
> > > +	 * restore the sysreg. Otherwise a new NMI occurring		\
> > > +	 * right after write_sysreg() can be fooled and think		\
> > > +	 * we secured things for it.					\
> > > +	 */								\
> > > +	barrier();							\
> > > +	if (!___ctx->cnt && !(___hcr & HCR_TGE))			\
> > > +		write_sysreg(___hcr, hcr_el2);				\
> > 
> > And not here ?
> 
> I have to defer to Will on this detail...

I think it's because we have to make sure that the register update has
taken effect before we can safely run the NMI handler (and so an ISB is
needed), but on the return path the exception return back to the interrupted
context has an implicit ISB so there's no need for an extra one here.

Make sense?

Will

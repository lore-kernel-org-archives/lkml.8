Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C20C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D94AF206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588717470;
	bh=wc9GfyZFu/gad6fW5vIIWHoZJVzw+CNkLDISiHya/P8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Jtlk7rnm+Nti9rurAY1PAMlEwKyvY6vqo6DIxv9xk8TcGsOUR+LtL1zyGDeZVWTb6
	 MFedUVuc793AETYRwapomYOzy4AfwnVUydBNCeCF0I0n1DfVDaVqXOSb3FnBqQamYZ
	 Gl+yqAYuR017kdpExPYYC82fn5yW+Q3t0ssGWoWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEEWYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgEEWY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:24:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CE12064A;
        Tue,  5 May 2020 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588717469;
        bh=wc9GfyZFu/gad6fW5vIIWHoZJVzw+CNkLDISiHya/P8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uw3+LltxaM+L7DUAkO54xQreocePuU4q+3hELpV0jkyly+Di6HYj2pSNZtODiNMeO
         40h0Iyp4/yq/P+JDYV0fG4FZ6hWkTLFxTed1PiRPwAnFMHwScEwRhra8LRAR6eH5Ew
         gmp36PxZt62vinCSx8Mrs+Cpqsh8RBbNs6lnnhTo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 03A5A3523039; Tue,  5 May 2020 15:24:29 -0700 (PDT)
Date:   Tue, 5 May 2020 15:24:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
Message-ID: <20200505222428.GU2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505220224.GT2869@paulmck-ThinkPad-P72>
 <87zhamnilr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhamnilr.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:05:04AM +0200, Thomas Gleixner wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> 
> > On Tue, May 05, 2020 at 03:44:05PM +0200, Thomas Gleixner wrote:
> >> Interrupts and exceptions invoke rcu_irq_enter() on entry and need to
> >> invoke rcu_irq_exit() before they either return to the interrupted code or
> >> invoke the scheduler due to preemption.
> >> 
> >> The general assumption is that RCU idle code has to have preemption
> >> disabled so that a return from interrupt cannot schedule. So the return
> >> from interrupt code invokes rcu_irq_exit() and preempt_schedule_irq().
> >> 
> >> If there is any imbalance in the rcu_irq/nmi* invocations or RCU idle code
> >> had preemption enabled then this goes unnoticed until the CPU goes idle or
> >> some other RCU check is executed.
> >> 
> >> Provide rcu_irq_exit_preempt() which can be invoked from the
> >> interrupt/exception return code in case that preemption is enabled. It
> >> invokes rcu_irq_exit() and contains a few sanity checks in case that
> >> CONFIG_PROVE_RCU is enabled to catch such issues directly.
> >> 
> >> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Joel Fernandes <joel@joelfernandes.org>
> >
> > The ->dynticks_nmi_nesting field is going away at some point, but
> > there is always "git merge".  ;-)
> 
> Yes. The logistics for merging all of this is going to be interesting :)

;-) ;-) ;-)

						Thanx, Paul

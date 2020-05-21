Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F236FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B698220756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgEUV0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUV0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:26:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43149C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:26:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbsh3-00025X-L4; Thu, 21 May 2020 23:25:33 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2804E100C2D; Thu, 21 May 2020 23:25:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V9 02/39] rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()
In-Reply-To: <20200521210339.GC2869@paulmck-ThinkPad-P72>
References: <20200521200513.656533920@linutronix.de> <20200521202116.996113173@linutronix.de> <20200521210339.GC2869@paulmck-ThinkPad-P72>
Date:   Thu, 21 May 2020 23:25:32 +0200
Message-ID: <87blmht1yr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Thu, May 21, 2020 at 10:05:15PM +0200, Thomas Gleixner wrote:
>> +void __rcu_irq_enter_check_tick(void);
>> +
>> +static __always_inline void rcu_irq_enter_check_tick(void)
>> +{
>> +	if (context_tracking_enabled())
>> +		__rcu_irq_enter_check_tick();
>
> I suggest moving the WARN_ON_ONCE(in_nmi()) check here to avoid calling
> in_nmi() twice.  Because of the READ_ONCE(), the compiler cannot (had
> better not!) eliminate the double call.

Makes sense.

>> +void __rcu_irq_enter_check_tick(void)
>> +{
>> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>> +
>> +	 // Enabling the tick is unsafe in NMI handlers.
>
> There is an extra space before the "//", probably the one that used to
> be after the ";" below.  ;-)

This is caused by my fundamental and not suppressible disgust of tail
comments. They really disturb the reading flow for me.

          if (foo)
          	return; // Because ...

makes my pattern recognition stop because the semicolon is usually the
end of the statement. But that's not the only reason.

         // Because ....
         if (foo)
         	return;

makes more sense to me because then the comment is explaining the
condition and not the outcome. The outcome is obvious when the condition
is well explained.

There are a few exceptions where I adjusted, e.g. in macros:

        foo();				\
        bar_or_something_else();	\

but only when the trailing backslash is properly aligned.

        foo();		\
        bar_or_something_else();	\

That stops the parser as well.

I know that this is a pet pieve but I can't help it to adjust it when I
have a chance to do so :)

>> +	if (WARN_ON_ONCE(in_nmi()))
>> +		return;
>> +
>> +	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
>> +			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
>
> The instrumentation_begin() has disappeared, presumably because
> instrumentation is already enabled in the non-RCU code that directly calls
> rcu_irq_enter_check_tick().  (I do see the calls in rcu_nmi_enter()
> below.)

Yes. The intention here is to make sure that the caller does not
misplace it. So if the call is in a non-instrumentable code path then
objtool will complain and the developer will hopefully think twice
whether this is the right place to wrap the call with instrumentation_*
annotations. I know it's based on hope :)

>> +
>> +	if (!tick_nohz_full_cpu(rdp->cpu) ||
>> +	    !READ_ONCE(rdp->rcu_urgent_qs) ||
>> +	    READ_ONCE(rdp->rcu_forced_tick)) {
>> +		// RCU doesn't need nohz_full help from this CPU, or it is
>> +		// already getting that help.
>> +		return;
>> +	}
>> +
>> +	// We get here only when not in an extended quiescent state and
>> +	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
>> +	// already watching and (2) The fact that we are in an interrupt
>> +	// handler and that the rcu_node lock is an irq-disabled lock
>> +	// prevents self-deadlock.  So we can safely recheck under the lock.
>> +	// Note that the nohz_full state currently cannot change.
>> +	raw_spin_lock_rcu_node(rdp->mynode);
>> +	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
>> +		// A nohz_full CPU is in the kernel and RCU needs a
>> +		// quiescent state.  Turn on the tick!
>> +		WRITE_ONCE(rdp->rcu_forced_tick, true);
>> +		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
>> +	}
>> +	raw_spin_unlock_rcu_node(rdp->mynode);
>> +}
>>  #endif /* CONFIG_NO_HZ_FULL */
>>  
>>  /**
>> @@ -894,26 +955,7 @@ noinstr void rcu_nmi_enter(void)
>>  		incby = 1;
>>  	} else if (!in_nmi()) {
>
> This can just be "else" given the in_nmi() check in
> __rcu_irq_enter_check_tick(), right?  Ah, that check got a
> WARN_ON_ONCE(), so never mind!
>
> I guess that will discourage NMI-handler calls to
> rcu_irq_enter_check_tick().  ;-)

Exactly.

> It does mean a double call to in_nmi(), though, so should that
> WARN_ON_ONCE(in_nmi()) check go into the rcu_irq_enter_check_tick()
> wrapper?  Or do modern compilers figure this one out?  Given the
> READ_ONCE() in preempt_count(), I have to say that I hope not.
> So see my comment above on rcu_irq_enter_check_tick().

Moving it to the wrapper is the right thing to do. Will fix.

Thanks,

        tglx

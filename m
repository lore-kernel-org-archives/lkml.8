Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E38C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C552220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgENOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgENOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:44:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87384C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:44:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZF5A-0000sf-Em; Thu, 14 May 2020 16:43:32 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 916191004CE; Thu, 14 May 2020 16:43:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
In-Reply-To: <20200514024116.GA231286@google.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.364456424@linutronix.de> <20200514024116.GA231286@google.com>
Date:   Thu, 14 May 2020 16:43:31 +0200
Message-ID: <87blmqziek.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

Joel Fernandes <joel@joelfernandes.org> writes:
> On Tue, May 05, 2020 at 03:44:05PM +0200, Thomas Gleixner wrote:
> Could you let me know which patch or part in the multi-part series is
> using it?

You found it :)
>> +void rcu_irq_exit_preempt(void)
>> +{
>> +	lockdep_assert_irqs_disabled();
>> +	rcu_nmi_exit();
>> +
>> +	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
>> +			 "RCU dynticks_nesting counter underflow/zero!");
>
> Makes sense.
>
>> +	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
>> +			 "RCU dynticks_nmi_nesting counter underflow/zero!");
>
> This new function will be called only from the outer-most IRQ that
> interrupted kernel mode (process context). Right? If so, a better (more
> specific) check for the second RCU_LOCKDEP_WARN above is:
>
> RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) != DYNTICK_IRQ_NONIDLE,
> 			 "Bad RCU dynticks_nmi_nesting counter\n");
>
> That will make sure, it is only called from outer-most rcu_irq_exit() and
> interrupting kernel mode.

Makes sense.

> Or, if [1] is merged, then we could just combine the checks into one check.
> 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) != 1,
> 			 "Bad RCU dynticks_nmi_nesting counter\n");
>
>> +	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
>> +			 "RCU in extended quiescent state!");
>
> Makes sense.
>
> BTW, I wonder if a better place to do this "don't enter scheduler while RCU
> is not watching" is rcu_note_context_switch()...

I actually want to catch even the case where we don't schedule, i.e.

  if (ret_to_kernel) {
     if (interrupts_on_after_return((regs)) {
        if (IS_ENABLED(CONFIG_PREEMPTION)) {
  	   if (!preempt_count()) {
              /* Preemption is possible ... */
       	      rcu_irq_exit_preempt();
                 if (need_resched())
                    schedule_preempt_irq();

that catches any exit where preemption is possible and RCU is not
watching after rcu_irq_exit().

It does not matter whether need-resched is set here or not. Any
interrupt/exception could set it.

Yes, I'm paranoid :)

Thanks,

        tglx

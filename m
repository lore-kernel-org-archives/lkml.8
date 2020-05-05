Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED418C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7879206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 22:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEEWFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEEWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 18:05:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEE8C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 15:05:36 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jW5gX-0005sF-0O; Wed, 06 May 2020 00:05:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 6AB101001F5; Wed,  6 May 2020 00:05:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     paulmck@kernel.org
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
In-Reply-To: <20200505220224.GT2869@paulmck-ThinkPad-P72>
Date:   Wed, 06 May 2020 00:05:04 +0200
Message-ID: <87zhamnilr.fsf@nanos.tec.linutronix.de>
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

> On Tue, May 05, 2020 at 03:44:05PM +0200, Thomas Gleixner wrote:
>> Interrupts and exceptions invoke rcu_irq_enter() on entry and need to
>> invoke rcu_irq_exit() before they either return to the interrupted code or
>> invoke the scheduler due to preemption.
>> 
>> The general assumption is that RCU idle code has to have preemption
>> disabled so that a return from interrupt cannot schedule. So the return
>> from interrupt code invokes rcu_irq_exit() and preempt_schedule_irq().
>> 
>> If there is any imbalance in the rcu_irq/nmi* invocations or RCU idle code
>> had preemption enabled then this goes unnoticed until the CPU goes idle or
>> some other RCU check is executed.
>> 
>> Provide rcu_irq_exit_preempt() which can be invoked from the
>> interrupt/exception return code in case that preemption is enabled. It
>> invokes rcu_irq_exit() and contains a few sanity checks in case that
>> CONFIG_PROVE_RCU is enabled to catch such issues directly.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>
> The ->dynticks_nmi_nesting field is going away at some point, but
> there is always "git merge".  ;-)

Yes. The logistics for merging all of this is going to be interesting :)

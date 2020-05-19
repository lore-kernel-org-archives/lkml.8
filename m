Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA072075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgESUU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgESUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:20:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80714C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:20:28 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jb8iZ-00013p-1v; Tue, 19 May 2020 22:20:03 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 515EB100D01; Tue, 19 May 2020 22:20:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
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
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 12/37] x86/entry: Provide idtentry_entry/exit_cond_rcu()
In-Reply-To: <87ftbv7nsd.fsf@nanos.tec.linutronix.de>
References: <20200515234547.710474468@linutronix.de> <20200515235125.628629605@linutronix.de> <CALCETrWnkuwvTuJKr8Vuecgr_q+1ReBDrTv4XOqGaw7-ZpEeQQ@mail.gmail.com> <87ftbv7nsd.fsf@nanos.tec.linutronix.de>
Date:   Tue, 19 May 2020 22:20:02 +0200
Message-ID: <87a7237k3x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Andy Lutomirski <luto@kernel.org> writes:
>> On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>> The pagefault handler cannot use the regular idtentry_enter() because that
>>> invokes rcu_irq_enter() if the pagefault was caused in the kernel. Not a
>>> problem per se, but kernel side page faults can schedule which is not
>>> possible without invoking rcu_irq_exit().
>>>
>>> Adding rcu_irq_exit() and a matching rcu_irq_enter() into the actual
>>> pagefault handling code would be possible, but not pretty either.
>>>
>>> Provide idtentry_entry/exit_cond_rcu() which calls rcu_irq_enter() only
>>> when RCU is not watching. The conditional RCU enabling is a correctness
>>> issue: A kernel page fault which hits a RCU idle reason can neither
>>> schedule nor is it likely to survive. But avoiding RCU warnings or RCU side
>>> effects is at least increasing the chance for useful debug output.
>>>
>>> The function is also useful for implementing lightweight reschedule IPI and
>>> KVM posted interrupt IPI entry handling later.
>>
>> Why is this conditional?  That is, couldn't we do this for all
>> idtentry_enter() calls instead of just for page faults?  Evil things
>> like NMI shouldn't go through this path at all.
>
> I thought about that, but then ended up with the conclusion that RCU
> might be unhappy, but my conclusion might be fundamentally wrong.

It's about this:

rcu_nmi_enter()
{
        if (!rcu_is_watching()) {
            make it watch;
        } else if (!in_nmi()) {
            do_magic_nohz_dyntick_muck();
        }

So if we do all irq/system vector entries conditional then the
do_magic() gets never executed. After that I got lost...

Thanks,

         tglx

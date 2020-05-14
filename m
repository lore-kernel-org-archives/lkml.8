Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290AFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BABC206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENMRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgENMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:17:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A7EC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:17:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZCms-0005wZ-KQ; Thu, 14 May 2020 14:16:30 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C5F561004CE; Thu, 14 May 2020 14:16:29 +0200 (CEST)
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
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 13/29] x86/traps: Prepare for using DEFINE_IDTENTRY
In-Reply-To: <CALCETrUyA5bN2ScrdhwEYZSUpyOhO+MaEu1X3PwX6vHGGCkqCg@mail.gmail.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.556327833@linutronix.de> <CALCETrUyA5bN2ScrdhwEYZSUpyOhO+MaEu1X3PwX6vHGGCkqCg@mail.gmail.com>
Date:   Thu, 14 May 2020 14:16:29 +0200
Message-ID: <87mu6azp7m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy,

Andy Lutomirski <luto@kernel.org> writes:
> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> +static __always_inline void __user *error_get_trap_addr(struct pt_regs *regs)
>> +{
>> +       return (void __user *)uprobe_get_trap_addr(regs);
>> +}
>
> My mind boggles.  WTF is this?

That's an inline version of the same nonsense in that macro maze.

> Perhaps this should have a comment like:
>
> /*
>  * Returns the address from which a user trap originated.  This would be the same as regs->ip,
>  * except for frhgnieawfn nvlrkvklsrvs and mfkealwf, and this lets the thingummy pass a
>  * modified value to the signal frame, but only for #DE and #UD, because #*!&@&#@.
>  */
>
> except with the blanks filled in.

Hmm. Filling the blanks gives me:

/*
**0Returns1the2address3from4which5a6user7trap8originated.90This1would...

That's not really more readable than yours :)

> After reading a bit of uprobe code, I assume this is a fixup for when
> we're running code that got moved out of line because it got replaced
> by a breakpoint.  I'm still mystified by why it only seems to apply to
> #DE and #UD.

man sigaction(2):

       * SIGILL, SIGFPE, SIGSEGV, SIGBUS, and SIGTRAP fill in si_addr
         with the address of the fault.  On some architectures, these
         signals also fill in the si_trapno field.

Posix spec says:

  In addition, the following signal-specific information shall be available:

  Signal	Member		Value

  SIGILL	void * si_addr  Address of faulting instruction.
  SIGFPE
	
  SIGSEGV       void * si_addr  Address of faulting memory reference.
  SIGBUS

  For some implementations, the value of si_addr may be inaccurate.

In historic kernels si_addr was simply set to regs->ip and the uprobe
muck changed that in commit b02ef20a9fba08 ("uprobes/x86: Fix the wrong
->si_addr when xol triggers a trap")
    
    If the probed insn triggers a trap, ->si_addr = regs->ip is technically
    correct, but this is not what the signal handler wants; we need to pass
    the address of the probed insn, not the address of xol slot.

Now that I filled my own blanks, I think that I can come up with a
halfways useful comment.

Thanks,

        tglx

Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93968C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C2D206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgEFIVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgEFIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:21:10 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6EC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 01:21:10 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWFIJ-00078r-3P; Wed, 06 May 2020 10:20:43 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4D7351001F5; Wed,  6 May 2020 10:20:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [patch V4 part 5 02/31] x86/entry: Provide helpers for execute on irqstack
In-Reply-To: <20200505135828.316937774@linutronix.de>
References: <20200505135341.730586321@linutronix.de> <20200505135828.316937774@linutronix.de>
Date:   Wed, 06 May 2020 10:20:42 +0200
Message-ID: <87pnbho4o5.fsf@nanos.tec.linutronix.de>
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
> That also allows to move the xen hypercall extra magic code and the softirq
> stack switching into C.
>
> The mechanism is straight forward:
>
>   1) Store the current stack pointer on top of the interrupt stack. That's
>      required for the unwinder. 
>
>   2) Switch the stack pointer
>
>   3) Call the function
>
>   4) Restore the stackpointer
>
> The full code sequence to make the unwinder happy is:
>
>     	pushq	%rbp
> 	movq	%rsp, %rbp
> 	movq    $(top_of_hardirq_stack - 8), %reg
> 	movq	%rsp, (%reg)
>   	movq	%reg , %rsp
> 	call    function
> 	popq	%rsp
> 	leaveq
> 	
> While the following sequence would spare the 'popq %rsp':
>
>     	pushq	%rbp
> 	movq    $(top_of_hardirq_stack - 8), %rbp
> 	movq	%rsp, (%rrbp)
>   	xchgq	%rbp, %rsp
> 	call    function
>  	movq	%rbp, %rsp
> 	leaveq

So I stared some more into that.

The push rbp is wrong for the frame unwinder case. That one is happy
(except for objtool) with the most minimalistic variant:

	movq	%%rsp, (%[tos])
        movq	%[tos], %%rsp
        call	function
        popq	%%rsp

which is not surprising because for the frame unwinder this is similar
to the 'gcc aligns stack in the middle of the function' handling. BP
still has to point to the previous frame. Adjustment of BP must only
happen on function entry.

The stack border convention of having the pointer to the previous stack
in the top word is sufficient for this.

objtool complains though:

 warning: objtool: do_softirq_own_stack()+0x67: return with modified stack frame

That obviously makes also the ORC unwinder unhappty as objtool fails to
provide the right hint. But also for ORC this construct should be
completely sufficient.

I'm exploring another idea right now, but wanted to share the info.

Thanks,

        tglx

Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6575BC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E7620750
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583965306;
	bh=Iw5tunA79qSoa9UkFxsQ+cINZMOh4duF6Ea2G6vBt18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O+XwZjDM+8tf5+3oN2sXNi8mF9IEXn5HGdD0BFJjV8mOOh9DSW492Uxf0MKRb+8MF
	 M2ttn+OSXgbXyGe9qQtJOY3x3z6rnWWu+NrxRIZPJUhdRfTR2ET5RLdETRdad5o5Jm
	 GyrH+P93x0LeEvqcmL8lEG4/7A74e/TZEQmi3ihg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgCKWVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgCKWVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:21:44 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEC2D2074F;
        Wed, 11 Mar 2020 22:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583965304;
        bh=Iw5tunA79qSoa9UkFxsQ+cINZMOh4duF6Ea2G6vBt18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKenIVJjY7T4b/LEWbxWpxa2EAJPvsvk/r1udrxoZeqQ+i/UO5KkHlwcHCw5ewWPs
         QbAhEunq7x6To2VqorVzErWGi52jX+aT0HAttrgW1ovpUi/Fj3IYpn1L96mr8V+44L
         6avzwzhrdnUcuisWpzWMjYoanxmWxyaYCT+57qLE=
Date:   Wed, 11 Mar 2020 23:21:41 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 02/13] x86/entry: Mark enter_from_user_mode()
 notrace and NOKPROBE
Message-ID: <20200311222140.GA15323@lenoir>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.125574449@linutronix.de>
 <20200309151423.GE9615@lenoir>
 <87pndl7czd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pndl7czd.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 04:40:54PM +0100, Thomas Gleixner wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > On Sun, Mar 08, 2020 at 11:24:01PM +0100, Thomas Gleixner wrote:
> >> Both the callers in the low level ASM code and __context_tracking_exit()
> >> which is invoked from enter_from_user_mode() via user_exit_irqoff() are
> >> marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
> >> inconsistent at best.
> >> 
> >> Aside of that while function tracing per se is safe the function trace
> >> entry/exit points can be used via BPF as well which is not safe to use
> >> before context tracking has reached CONTEXT_KERNEL and adjusted RCU.
> >> 
> >> Mark it notrace and NOKROBE.
> >
> > Ok for the NOKPROBE, also I remember from the inclusion of kprobes
> > that spreading those NOKPROBE couldn't be more than some sort of best
> > effort to mitigate the accidents and it's up to the user to keep some
> > common sense and try to stay away from the borderline functions. The same
> > would apply to breakpoints, steps, etc...
> >
> > Now for the BPF and function tracer, the latter has been made robust to
> > deal with these fragile RCU blind spots. Probably the same requirements should be
> > expected from the function tracer users. Perhaps we should have a specific
> > version of __register_ftrace_function() which protects the given probes
> > inside rcu_nmi_enter()? As it seems the BPF maintainer doesn't want the whole
> > BPF execution path to be hammered.
> 
> Right. The problem is that as things stand e.g. for tracepoints you need
> to invoke trace_foo_rcuidle() which then does the scru/rcu_irq dance
> around the invocation, but then the functions attached need to be fixed
> that they are not issuing rcu_read_lock() or such.
> 
> While that is halfways doable for tracepoints when you place them, the
> whole function entry/exit hooks along with kprobes are even more
> interesting because functions can be called from arbitrary contexts...
> 
> So to make this sane, you'd need to do:
> 
>    if (!rcu_watching()) {
>    	....
>    } else {
>         ....
>    }
> 
> and the reverse when leaving the thing. So in the worst case you end up
> with a gazillion of scru/rcu_irq pairs which really make crap slow.
> 
> So we are way better off to have well defined off limit regions and are
> careful about them and then switch over ONCE and be done with it.
> 
> Thanks,
> 
>         tglx

Ok given the discussion on the big tracing thread I think I got convinced that early
entry code is best left out of tracing anyway.

Acked-by: Frederic Weisbecker <frederic@kernel.org>

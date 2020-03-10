Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20076C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AF5205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="leaLDE25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgCJLUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:20:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgCJLUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:20:42 -0400
Received: from zn.tnic (p200300EC2F09B4000CCA2EEF87DC47A5.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:b400:cca:2eef:87dc:47a5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0457C1EC0570;
        Tue, 10 Mar 2020 12:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583839241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cArB59NrOGQlGOmKBvAjZc71FLrwh8gM/VcJdZWD/JU=;
        b=leaLDE25Meyk/ydi//sXDUV9g4yfeZr/BKaU/tf6fDGwind3ZDyGn29Fusng+yu3krWvEB
        NU1TvD529q49Vq8iYeDyrztyMvm2ugOem5WcHkhIf1CQSQg4wT4pT5Fdfk5JsSmngWtWKk
        xXYblMRtpRlFXupY84S5u0frLf4AZYw=
Date:   Tue, 10 Mar 2020 12:20:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 09/13] x86/entry/common: Split hardirq tracing
 into lockdep and ftrace parts
Message-ID: <20200310112045.GD29372@zn.tnic>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.825111830@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200308222609.825111830@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:24:08PM +0100, Thomas Gleixner wrote:
> trace_hardirqs_off() is in fact a tracepoint which can be utilized by BPF,
> which is unsafe before calling enter_from_user_mode(), which in turn
> invokes context tracking. trace_hardirqs_off() also invokes
> lockdep_hardirqs_off() under the hood.
> 
> OTOH lockdep needs to know about the interrupts disabled state before
> enter_from_user_mode(). lockdep_hardirqs_off() is safe to call at this
> point.
> 
> Split it so lockdep knows about the state and invoke the tracepoint after
> the context is set straight.
> 
> Even if the functions attached to a tracepoint would all be safe to be
> called in rcuidle having it split up is still giving a performance
> advantage because rcu_read_lock_sched() is avoiding the whole dance of:
> 
>    scru_read_lock();
>    rcu_irq_enter_irqson();
>    ...
>    rcu_irq_exit_irqson();
>    scru_read_unlock();
>    
> around the tracepoint function invocation just to have the C entry points
> of syscalls call enter_from_user_mode() right after the above dance.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: New patch
> ---
>  arch/x86/entry/common.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -60,10 +60,19 @@ static __always_inline void syscall_entr
>  {
>  	/*
>  	 * Usermode is traced as interrupts enabled, but the syscall entry
> -	 * mechanisms disable interrupts. Tell the tracer.
> +	 * mechanisms disable interrupts. Tell lockdep before calling
> +	 * enter_from_user_mode(). This is safe vs. RCU while the
> +	 * tracepoint is not.
>  	 */
> -	trace_hardirqs_off();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +
>  	enter_from_user_mode();
> +
> +	/*
> +	 * Tell the tracer about the irq state as well before enabling
> +	 * interrupts.
> +	 */
> +	__trace_hardirqs_off();

I wonder if those "__" variants should be named something else to
denote better the difference between __trace_hardirqs_{on,off} and
trace_hardirqs_{on,off}. Latter does the _rcuidle variant and lockdep
annotation but

	trace_hardirqs_{on,off}_rcuidle_lockdep()

sounds yuck.

Maybe lockdep_trace_hardirqs_{on,off}()...

Blergh, I can't think of a good name ATM.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

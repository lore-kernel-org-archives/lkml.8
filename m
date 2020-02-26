Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD55C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8B24680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582737430;
	bh=jVCA3JmCA3VCj0DKgVLl8KD4KCd9P0F6bDnSIe2izGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MB7kn33u+3ervzBWr5KroIbZ3bk4PeD4tc7Hy3e+iNkYvWcO6XEPHxwCtqpivq6M1
	 18O0U3vNqiqk1u4OxcFw5uOnbcx/1tgkLpjfbziYOCwbDaBaHVHyFdHJJAbSa4REgV
	 NDc2wyYW+cCY9kBmR6RT2eqVD7/X4LkdMkYOHXPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgBZRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgBZRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:17:09 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6A6206E6;
        Wed, 26 Feb 2020 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582737428;
        bh=jVCA3JmCA3VCj0DKgVLl8KD4KCd9P0F6bDnSIe2izGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xGt9lOvcpXmAaLm+7beD81Z0ylCkkKWyArrJGvm073sX4q+Ec/EPsDiQiuq/Fc9Nu
         s+JvJW82du58fX0ni8Qv5/gLDhaMYybW0Mxiwqepr7yuE2YYO0AhUpzFxAOiPaSpuG
         DHjyjiaekpw6f/IbnlwJJsX+VryUaYrLbTakK4fQ=
Date:   Wed, 26 Feb 2020 18:17:06 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 13/16] x86/entry: Move irqflags and context tracking to C
 for simple idtentries
Message-ID: <20200226171705.GC6075@lenoir>
References: <20200226170534.GA6075@lenoir>
 <2A899107-5AB8-4907-8AF2-31154A2E0A98@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2A899107-5AB8-4907-8AF2-31154A2E0A98@amacapital.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:09:34AM -0800, Andy Lutomirski wrote:
> 
> 
> > On Feb 26, 2020, at 9:05 AM, Frederic Weisbecker <frederic@kernel.org> wrote:
> > 
> > ﻿On Wed, Feb 26, 2020 at 09:05:38AM +0100, Peter Zijlstra wrote:
> >>> On Tue, Feb 25, 2020 at 11:33:34PM +0100, Thomas Gleixner wrote:
> >>> 
> >>> --- a/arch/x86/include/asm/idtentry.h
> >>> +++ b/arch/x86/include/asm/idtentry.h
> >>> @@ -7,14 +7,31 @@
> >>> 
> >>> #ifndef __ASSEMBLY__
> >>> 
> >>> +#ifdef CONFIG_CONTEXT_TRACKING
> >>> +static __always_inline void enter_from_user_context(void)
> >>> +{
> >>> +    CT_WARN_ON(ct_state() != CONTEXT_USER);
> >>> +    user_exit_irqoff();
> >>> +}
> >>> +#else
> >>> +static __always_inline void enter_from_user_context(void) { }
> >>> +#endif
> >>> +
> >>> /**
> >>>  * idtentry_enter - Handle state tracking on idtentry
> >>>  * @regs:    Pointer to pt_regs of interrupted context
> >>>  *
> >>> - * Place holder for now.
> >>> + * Invokes:
> >>> + *  - The hardirq tracer to keep the state consistent as low level ASM
> >>> + *    entry disabled interrupts.
> >>> + *
> >>> + *  - Context tracking if the exception hit user mode
> >>>  */
> >>> static __always_inline void idtentry_enter(struct pt_regs *regs)
> >>> {
> >>> +    trace_hardirqs_off();
> >>> +    if (user_mode(regs))
> >>> +        enter_from_user_context();
> >>> }
> >> 
> >> So:
> >> 
> >>    asm_exc_int3
> >>      exc_int3
> >>        idtentry_enter()
> >>          enter_from_user_context
> >>            if (context_tracking_enabled())
> >> 
> >>        poke_int3_handler();
> >> 
> >> Is, AFAICT, completely buggered.
> >> 
> >> You can't have a static_branch before the poke_int3_handler that deals
> >> with text_poke.
> > 
> > #BP is treated like an NMI in your patchset IIRC?
> > In that case and since that implies we can't schedule, we can remove
> > the call to context tracking there once we have nmi_enter()/nmi_exit()
> > called unconditionally.
> 
> int3 from user mode can send signals. This has better be able to schedule by the time it hits prepare_exit_to_usermode.

Oh right...

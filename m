Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77ECC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9409205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nuG1OdPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgENCY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:24:58 -0400
Received: from mail.efficios.com ([167.114.26.124]:36404 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgENCY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:24:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0EBB92A13E4;
        Wed, 13 May 2020 22:24:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FkUb3gfgjyP2; Wed, 13 May 2020 22:24:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 980292A1788;
        Wed, 13 May 2020 22:24:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 980292A1788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589423096;
        bh=XHOZkEN+vLcEcnwitP7cZ8++0pr5RRzqnyKOFGX0k6o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nuG1OdPjrr3xEdEnb3NqWyo3qyktRtMTykbAumHuKa9LxEy7tyvbMitEz1HxhRdF+
         wSuK5UQ5nI5LXmJGAALlBnP/IG4u3uDAbkjr8aVepOOsv3uGjayJjnH0dVwOJjnyBo
         IMUDDm9JTBKr8PjQDIFXO9pMYieU7Rzthp6A9ZQs+2bh5JYzlYW3/IJaRE+1inBX2g
         yUdtqeOwJg9V8zjOsv48VlQlJ9lEi3/JWEwXuJjrDvQoOXNLkekCS1D8a/+1csW/m0
         GDx1CH6LHCYWfxHRaHyiajlsGPApS2NSgf9ZCEc2zWnU+sxeFaBpa47p66EoCijP3Z
         Fg/NW8YGTafKg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7VyRvSlYHhBR; Wed, 13 May 2020 22:24:56 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 830792A1706;
        Wed, 13 May 2020 22:24:56 -0400 (EDT)
Date:   Wed, 13 May 2020 22:24:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <552488029.20647.1589423096441.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505135314.808628211@linutronix.de>
References: <20200505134926.578885807@linutronix.de> <20200505135314.808628211@linutronix.de>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/db: Split out dr6/7 handling
Thread-Index: Lshy92u6l/WGHmCqbJJrQlEvg9Pv+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:49 AM, Thomas Gleixner tglx@linutronix.de wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> DR6/7 should be handled before nmi_enter() is invoked and restore after
> nmi_exit() to minimize the exposure.
> 
> Split it out into helper inlines and bring it into the correct order.
> 
[...]
> 
> +static __always_inline void debug_enter(unsigned long *dr6, unsigned long *dr7)
> +{
> +	/*
> +	 * Disable breakpoints during exception handling; recursive exceptions
> +	 * are exceedingly 'fun'.
> +	 *
> +	 * Since this function is NOKPROBE, and that also applies to
> +	 * HW_BREAKPOINT_X, we can't hit a breakpoint before this (XXX except a
> +	 * HW_BREAKPOINT_W on our stack)
> +	 *
> +	 * Entry text is excluded for HW_BP_X and cpu_entry_area, which
> +	 * includes the entry stack is excluded for everything.
> +	 */
> +	get_debugreg(*dr7, 6);
> +	set_debugreg(0, 7);
> +
> +	/*
> +	 * The Intel SDM says:
> +	 *
> +	 *   Certain debug exceptions may clear bits 0-3. The remaining
> +	 *   contents of the DR6 register are never cleared by the
> +	 *   processor. To avoid confusion in identifying debug
> +	 *   exceptions, debug handlers should clear the register before
> +	 *   returning to the interrupted task.
> +	 *
> +	 * Keep it simple: clear DR6 immediately.
> +	 */
> +	get_debugreg(*dr6, 6);
> +	set_debugreg(0, 6);
> +	/* Filter out all the reserved bits which are preset to 1 */
> +	*dr6 &= ~DR6_RESERVED;
> +}
> +
> +static __always_inline void debug_exit(unsigned long dr7)
> +{
> +	set_debugreg(dr7, 7);
> +}

Out of curiosity, what prevents the compiler from moving instructions
outside of the code regions surrounded by entry/exit ? This is an always
inline, which invokes set_debugreg which is inline for CONFIG_PARAVIRT_XXL=n,
which in turn uses an asm() (not volatile), without any memory clobber.

Also, considering that "inline" is not sufficient to ensure the compiler
does not emit a traceable function, I suspect you'll also want to mark
"native_get_debugreg" and "native_set_debugreg" always inline as well.

Thanks,

Mathieu

> +
> /*
>  * Our handling of the processor debug registers is non-trivial.
>  * We do not clear them on entry and exit from the kernel. Therefore
> @@ -718,28 +756,13 @@ static bool is_sysenter_singlestep(struc
> dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
> {
> 	struct task_struct *tsk = current;
> +	unsigned long dr6, dr7;
> 	int user_icebp = 0;
> -	unsigned long dr6;
> 	int si_code;
> 
> -	nmi_enter();
> -
> -	get_debugreg(dr6, 6);
> -	/*
> -	 * The Intel SDM says:
> -	 *
> -	 *   Certain debug exceptions may clear bits 0-3. The remaining
> -	 *   contents of the DR6 register are never cleared by the
> -	 *   processor. To avoid confusion in identifying debug
> -	 *   exceptions, debug handlers should clear the register before
> -	 *   returning to the interrupted task.
> -	 *
> -	 * Keep it simple: clear DR6 immediately.
> -	 */
> -	set_debugreg(0, 6);
> +	debug_enter(&dr6, &dr7);
> 
> -	/* Filter out all the reserved bits which are preset to 1 */
> -	dr6 &= ~DR6_RESERVED;
> +	nmi_enter();
> 
> 	/*
> 	 * The SDM says "The processor clears the BTF flag when it
> @@ -777,7 +800,7 @@ dotraplinkage void do_debug(struct pt_re
> #endif
> 
> 	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, error_code,
> -							SIGTRAP) == NOTIFY_STOP)
> +		       SIGTRAP) == NOTIFY_STOP)
> 		goto exit;
> 
> 	/*
> @@ -816,6 +839,7 @@ dotraplinkage void do_debug(struct pt_re
> 
> exit:
> 	nmi_exit();
> +	debug_exit(dr7);
> }
>  NOKPROBE_SYMBOL(do_debug);

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

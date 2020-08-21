Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1BFC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF6B2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598018052;
	bh=FGCImzVS8BYfUE5Ql01UJaje4kzcrgIcdano02J+HHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y9MXCJCGK1NsZs7ig0ODEz0KbCQ8sKNlIAQFctjNWs8Qa6GKZWXXiVjJOT2QrVh8b
	 whzQiwZzKKLI4dQsFt08OM3hGouBobHMK0ZmGwsYvOLE24GUs5crNcLsTFe5WJGHT+
	 o4nwf5cjGRXF9+oYS1TuzbiW5hTOPcZzJGHE1K1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgHUNyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgHUNyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:54:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B005220656;
        Fri, 21 Aug 2020 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598018045;
        bh=FGCImzVS8BYfUE5Ql01UJaje4kzcrgIcdano02J+HHs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qkoGouAnq9wjDK5INw19keiqv1p5eywSuzaF3ANLg2llxI+xYmYoRszOj5B02H+RI
         kREYxzqz2gYW8SrytMd2fnSDunai7Ou0ggGak8SREtgntzF2At41fc0tjvFanzacQm
         q4EdrfBF1/JyRKthElI/NuHoItrL/kgUWVnnwcV0=
Date:   Fri, 21 Aug 2020 22:54:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 3/7] x86/debug: Move kprobe_debug_handler() into
 exc_debug_kernel()
Message-Id: <20200821225401.5f5c05a502a1fd4a7f5e059b@kernel.org>
In-Reply-To: <20200820104905.236173163@infradead.org>
References: <20200820103832.486877479@infradead.org>
        <20200820104905.236173163@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 12:38:35 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/kprobes.h |    4 ++++
>  arch/x86/kernel/traps.c        |   10 ++++------
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> --- a/arch/x86/include/asm/kprobes.h
> +++ b/arch/x86/include/asm/kprobes.h
> @@ -106,5 +106,9 @@ extern int kprobe_exceptions_notify(stru
>  extern int kprobe_int3_handler(struct pt_regs *regs);
>  extern int kprobe_debug_handler(struct pt_regs *regs);
>  
> +#else
> +
> +static inline int kprobe_debug_handler(struct pt_regs *regs) { return 0; }
> +
>  #endif /* CONFIG_KPROBES */
>  #endif /* _ASM_X86_KPROBES_H */
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -806,12 +806,6 @@ static void handle_debug(struct pt_regs
>  	/* Store the virtualized DR6 value */
>  	tsk->thread.debugreg6 = dr6;
>  
> -#ifdef CONFIG_KPROBES
> -	if (kprobe_debug_handler(regs)) {
> -		return;
> -	}
> -#endif
> -
>  	if (notify_die(DIE_DEBUG, "debug", regs, (long)&dr6, 0,
>  		       SIGTRAP) == NOTIFY_STOP) {
>  		return;
> @@ -877,8 +871,12 @@ static __always_inline void exc_debug_ke
>  	if ((dr6 & DR_STEP) && is_sysenter_singlestep(regs))
>  		dr6 &= ~DR_STEP;
>  
> +	if (kprobe_debug_handler(regs))
> +		goto out;
> +
>  	handle_debug(regs, dr6, false);
>  
> +out:
>  	instrumentation_end();
>  	idtentry_exit_nmi(regs, irq_state);
>  
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

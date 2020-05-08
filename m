Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0985AC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65E1208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588926197;
	bh=sSCdTLxVSQxfqLsYipbKP5DLysQXUOvZrPx43Rlbsrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YeL6H9+2LZFlLi1VK8mSVm+xo6BJ54nSf8FS5+v8XeIyCFGa6YIdAnOYtxu8M/6nt
	 UDdsDnpywjuGOyrVTEYtQ2pQfbCsmL1sxxbGQyKR0J++5cJX0cSXuhD6gPbVjG4Y8W
	 JoWZCSkipVEGsE5IzgQig4oAQ653E8G/MzuW71oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgEHIXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgEHIXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:23:16 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3C7B20735;
        Fri,  8 May 2020 08:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588926195;
        bh=sSCdTLxVSQxfqLsYipbKP5DLysQXUOvZrPx43Rlbsrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zhPDCZJtBMXL/zvrjsx45fA68iVa+mnjx92oQJ1vPoMqg2PlJvRNR4Q0LPLfnBIU+
         zyVhma7y2Cam/U9HFkZb8Fkg2+1udxBjqFWBpKZ8ESVCvW7hM4KKAmkiGSYloHapl6
         K8AdjC5GijuFftN4qYJuz0O2jLsgl627XV+a9vig=
Date:   Fri, 8 May 2020 17:23:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 2 07/18] context_tracking: Ensure that the
 critical path cannot be instrumented
Message-Id: <20200508172309.470787329827c8bfcd797eb1@kernel.org>
In-Reply-To: <20200505134340.811520478@linutronix.de>
References: <20200505134112.272268764@linutronix.de>
        <20200505134340.811520478@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:41:19 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> context tracking lacks a few protection mechanisms against instrumentation:
> 
>  - While the core functions are marked NOKPROBE they lack protection
>    against function tracing which is required as the function entry/exit
>    points can be utilized by BPF.
> 
>  - static functions invoked from the protected functions need to be marked
>    as well as they can be instrumented otherwise.
> 
>  - using plain inline allows the compiler to emit traceable and probable
>    functions.
> 
> Fix this by marking the functions noinstr and converting the plain inlines
> to __always_inline.
> 
> The NOKPROBE_SYMBOL() annotations are removed as the .noinstr.text section
> is already excluded from being probed.
> 
> Cures the following objtool warnings:
> 
>  vmlinux.o: warning: objtool: enter_from_user_mode()+0x34: call to __context_tracking_exit() leaves .noinstr.text section
>  vmlinux.o: warning: objtool: prepare_exit_to_usermode()+0x29: call to __context_tracking_enter() leaves .noinstr.text section
>  vmlinux.o: warning: objtool: syscall_return_slowpath()+0x29: call to __context_tracking_enter() leaves .noinstr.text section
>  vmlinux.o: warning: objtool: do_syscall_64()+0x7f: call to __context_tracking_enter() leaves .noinstr.text section
>  vmlinux.o: warning: objtool: do_int80_syscall_32()+0x3d: call to __context_tracking_enter() leaves .noinstr.text section
>  vmlinux.o: warning: objtool: do_fast_syscall_32()+0x9c: call to __context_tracking_enter() leaves .noinstr.text section
> 
> and generates new ones...
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  include/linux/context_tracking.h       |    6 +++---
>  include/linux/context_tracking_state.h |    6 +++---
>  kernel/context_tracking.c              |   14 ++++++++------
>  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -33,13 +33,13 @@ static inline void user_exit(void)
>  }
>  
>  /* Called with interrupts disabled.  */
> -static inline void user_enter_irqoff(void)
> +static __always_inline void user_enter_irqoff(void)
>  {
>  	if (context_tracking_enabled())
>  		__context_tracking_enter(CONTEXT_USER);
>  
>  }
> -static inline void user_exit_irqoff(void)
> +static __always_inline void user_exit_irqoff(void)
>  {
>  	if (context_tracking_enabled())
>  		__context_tracking_exit(CONTEXT_USER);
> @@ -75,7 +75,7 @@ static inline void exception_exit(enum c
>   * is enabled.  If context tracking is disabled, returns
>   * CONTEXT_DISABLED.  This should be used primarily for debugging.
>   */
> -static inline enum ctx_state ct_state(void)
> +static __always_inline enum ctx_state ct_state(void)
>  {
>  	return context_tracking_enabled() ?
>  		this_cpu_read(context_tracking.state) : CONTEXT_DISABLED;
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -26,12 +26,12 @@ struct context_tracking {
>  extern struct static_key_false context_tracking_key;
>  DECLARE_PER_CPU(struct context_tracking, context_tracking);
>  
> -static inline bool context_tracking_enabled(void)
> +static __always_inline bool context_tracking_enabled(void)
>  {
>  	return static_branch_unlikely(&context_tracking_key);
>  }
>  
> -static inline bool context_tracking_enabled_cpu(int cpu)
> +static __always_inline bool context_tracking_enabled_cpu(int cpu)
>  {
>  	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
>  }
> @@ -41,7 +41,7 @@ static inline bool context_tracking_enab
>  	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
>  }
>  
> -static inline bool context_tracking_in_user(void)
> +static __always_inline bool context_tracking_in_user(void)
>  {
>  	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
>  }
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -31,7 +31,7 @@ EXPORT_SYMBOL_GPL(context_tracking_key);
>  DEFINE_PER_CPU(struct context_tracking, context_tracking);
>  EXPORT_SYMBOL_GPL(context_tracking);
>  
> -static bool context_tracking_recursion_enter(void)
> +static noinstr bool context_tracking_recursion_enter(void)
>  {
>  	int recursion;
>  
> @@ -45,7 +45,7 @@ static bool context_tracking_recursion_e
>  	return false;
>  }
>  
> -static void context_tracking_recursion_exit(void)
> +static __always_inline void context_tracking_recursion_exit(void)
>  {
>  	__this_cpu_dec(context_tracking.recursion);
>  }
> @@ -59,7 +59,7 @@ static void context_tracking_recursion_e
>   * instructions to execute won't use any RCU read side critical section
>   * because this function sets RCU in extended quiescent state.
>   */
> -void __context_tracking_enter(enum ctx_state state)
> +void noinstr __context_tracking_enter(enum ctx_state state)
>  {
>  	/* Kernel threads aren't supposed to go to userspace */
>  	WARN_ON_ONCE(!current->mm);
> @@ -77,8 +77,10 @@ void __context_tracking_enter(enum ctx_s
>  			 * on the tick.
>  			 */
>  			if (state == CONTEXT_USER) {
> +				instr_begin();
>  				trace_user_enter(0);
>  				vtime_user_enter(current);
> +				instr_end();
>  			}
>  			rcu_user_enter();
>  		}
> @@ -99,7 +101,6 @@ void __context_tracking_enter(enum ctx_s
>  	}
>  	context_tracking_recursion_exit();
>  }
> -NOKPROBE_SYMBOL(__context_tracking_enter);
>  EXPORT_SYMBOL_GPL(__context_tracking_enter);
>  
>  void context_tracking_enter(enum ctx_state state)
> @@ -142,7 +143,7 @@ NOKPROBE_SYMBOL(context_tracking_user_en
>   * This call supports re-entrancy. This way it can be called from any exception
>   * handler without needing to know if we came from userspace or not.
>   */
> -void __context_tracking_exit(enum ctx_state state)
> +void noinstr __context_tracking_exit(enum ctx_state state)
>  {
>  	if (!context_tracking_recursion_enter())
>  		return;
> @@ -155,15 +156,16 @@ void __context_tracking_exit(enum ctx_st
>  			 */
>  			rcu_user_exit();
>  			if (state == CONTEXT_USER) {
> +				instr_begin();
>  				vtime_user_exit(current);
>  				trace_user_exit(0);
> +				instr_end();
>  			}
>  		}
>  		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
>  	}
>  	context_tracking_recursion_exit();
>  }
> -NOKPROBE_SYMBOL(__context_tracking_exit);
>  EXPORT_SYMBOL_GPL(__context_tracking_exit);
>  
>  void context_tracking_exit(enum ctx_state state)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B8C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BA621D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBRSMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgBRSMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:12:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CB1208C4;
        Tue, 18 Feb 2020 18:12:00 +0000 (UTC)
Date:   Tue, 18 Feb 2020 13:11:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] #MC mess
Message-ID: <20200218131158.693eeefc@gandalf.local.home>
In-Reply-To: <20200218173150.GK14449@zn.tnic>
References: <20200218173150.GK14449@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 18:31:50 +0100
Borislav Petkov <bp@alien8.de> wrote:

> Ok,
> 
> so Peter raised this question on IRC today, that the #MC handler needs
> to disable all kinds of tracing/kprobing and etc exceptions happening
> while handling an #MC. And I guess we can talk about supporting some
> exceptions but #MC is usually nasty enough to not care about tracing
> when former happens.

What's the issue with tracing? Does this affect the tracing done by the
edac_mc_handle_error code?

It has a trace event in it, that the rasdaemon uses.

> 
> So how about this trivial first stab of using the big hammer and simply
> turning off stuff? The nmi_enter()/nmi_exit() thing still needs debating
> because ist_enter() already does rcu_nmi_enter() and I'm not sure
> whether any of the context tracking would still be ok with that.
> 
> Anything else I'm missing? It is likely...
> 
> Thx.
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 2c4f949611e4..6dff97c53310 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1214,7 +1214,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
>   * MCE broadcast. However some CPUs might be broken beyond repair,
>   * so be always careful when synchronizing with others.
>   */
> -void do_machine_check(struct pt_regs *regs, long error_code)
> +void notrace do_machine_check(struct pt_regs *regs, long error_code)
>  {
>  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
>  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> @@ -1251,6 +1251,10 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>  	if (__mc_check_crashing_cpu(cpu))
>  		return;
>  
> +	hw_breakpoint_disable();
> +	static_key_disable(&__tracepoint_read_msr.key);

I believe static_key_disable() sleeps, and does all kinds of crazing
things (like update the code).

-- Steve

> +	tracing_off();
> +
>  	ist_enter(regs);
>  
>  	this_cpu_inc(mce_exception_count);
> @@ -1360,6 +1364,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>  	ist_exit(regs);
>  }
>  EXPORT_SYMBOL_GPL(do_machine_check);
> +NOKPROBE_SYMBOL(do_machine_check);
>  
>  #ifndef CONFIG_MEMORY_FAILURE
>  int memory_failure(unsigned long pfn, int flags)
> 


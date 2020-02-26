Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C915DC4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1D8222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582679637;
	bh=sEMmi+uzoT7y/MrYSZEZWw7svvLIaxFFKL1gWKPsqB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ptmoX+salYoFlBPCWIb55AiI09P1/bQKlcuCC0/p5Mu+SilpeboTPI2Bn79GWjJl+
	 F5iXuTpOQvYQaObwxhUUsrI+561ybkuYdvHUzXY/5j2idWI8a0r/L8o+EVvDqN8vLk
	 3a2rz52Wi9ldAc+unQdK2k4zKLpNDrg5hrrSY+zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgBZBN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:41610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730244AbgBZBNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:13:53 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F027920732;
        Wed, 26 Feb 2020 01:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582679632;
        bh=sEMmi+uzoT7y/MrYSZEZWw7svvLIaxFFKL1gWKPsqB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiEmf8Y8PytiydffpHTRP7LL2NAxtShYIBws4Wbr7rWQ6cB7eSHWoAVgwHhXdfyWt
         HcBv2B/KlpHXODCp3De9bztKkzk/YEF9BIW1itAAW8KlNqtj78yDWmyk8drzrdsoVh
         Rig2uBU1GRiIHMVPsV2CsE4pak2JclPo6wE2079g=
Date:   Wed, 26 Feb 2020 02:13:50 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226011349.GH9599@lenoir>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.315548935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225220216.315548935@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:36:38PM +0100, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> do_machine_check() can be raised in almost any context including the most
> fragile ones. Prevent kprobes and tracing.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/traps.h   |    3 ---
>  arch/x86/kernel/cpu/mce/core.c |   12 ++++++++++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -88,9 +88,6 @@ dotraplinkage void do_page_fault(struct
>  dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
>  dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
>  dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
> -#ifdef CONFIG_X86_MCE
> -dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
> -#endif
>  dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
>  #ifdef CONFIG_X86_32
>  dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1213,8 +1213,14 @@ static void __mc_scan_banks(struct mce *
>   * On Intel systems this is entered on all CPUs in parallel through
>   * MCE broadcast. However some CPUs might be broken beyond repair,
>   * so be always careful when synchronizing with others.
> + *
> + * Tracing and kprobes are disabled: if we interrupted a kernel context
> + * with IF=1, we need to minimize stack usage.  There are also recursion
> + * issues: if the machine check was due to a failure of the memory
> + * backing the user stack, tracing that reads the user stack will cause
> + * potentially infinite recursion.
>   */
> -void do_machine_check(struct pt_regs *regs, long error_code)
> +void notrace do_machine_check(struct pt_regs *regs, long error_code)
>  {
>  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
>  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
> @@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
>  	ist_exit(regs);
>  }
>  EXPORT_SYMBOL_GPL(do_machine_check);
> +NOKPROBE_SYMBOL(do_machine_check);

That won't protect all the function called by do_machine_check(), right?
There are lots of them.

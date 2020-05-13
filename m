Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA25C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA49420714
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgEMCCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgEMCCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:02:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6FCA206CC;
        Wed, 13 May 2020 02:02:31 +0000 (UTC)
Date:   Tue, 12 May 2020 22:02:30 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
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
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V5 02/38] x86/entry/64: Use native swapgs in
 asm_native_load_gs_index()
Message-ID: <20200512220230.629a230f@oasis.local.home>
In-Reply-To: <20200512213809.583980272@linutronix.de>
References: <20200512210059.056244513@linutronix.de>
        <20200512213809.583980272@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 23:01:01 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> When PARAVIRT_XXL is in use, then load_gs_index() uses
> xen_load_gs_index() and (asm_))native_load_gs_index() is unused.
> 
> It's therefore pointless to use the paravirtualized SWAPGS implementation
> in asm_native_load_gs_index(). Switch it to a plain swapgs.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/entry/entry_64.S |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1043,11 +1043,11 @@ idtentry simd_coprocessor_error		do_simd
>   */
>  SYM_FUNC_START(asm_native_load_gs_index)

Small nit, but I would just call this: asm_load_gs_index.

The "native" word is usually reserved for functions that are for bare
metal and have a paravirt counterpart. As there is a
native_load_gs_index(), I don't envision a need for a paravirt version
of the asm function.

Other than that.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  	FRAME_BEGIN
> -	SWAPGS
> +	swapgs
>  .Lgs_change:
>  	movl	%edi, %gs
>  2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
> -	SWAPGS
> +	swapgs
>  	FRAME_END
>  	ret
>  SYM_FUNC_END(asm_native_load_gs_index)
> @@ -1057,7 +1057,7 @@ EXPORT_SYMBOL(asm_native_load_gs_index)
>  	.section .fixup, "ax"
>  	/* running with kernelgs */
>  SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
> -	SWAPGS					/* switch back to user gs */
> +	swapgs					/* switch back to user gs */
>  .macro ZAP_GS
>  	/* This can't be a string because the preprocessor needs to see it. */
>  	movl $__USER_DS, %eax


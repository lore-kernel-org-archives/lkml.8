Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D2C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C0F2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gch71prR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDVUIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgDVUIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:08:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4DC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MZtG2KeEuTg4yxv86Z8L4utsUbXSvWTuQZuzRxUSn2U=; b=gch71prRJAzB3Y0FYH7ky8mFbA
        6RnCv0KWoS5iBsJKg3sBToeckgJV5VR3hoEBm1JHcqArZY70gy9M7qQ3vaYWxbrVUCSD/MofQ7hOJ
        b/s8jO6kZy8b6bx/EGQdid//orECye8WG/jSblkkoq4sRtcqX/+W6wY3NMXKxWGYL5Sm5sQEK5AXs
        X2A+xfB5yKKjlVUZd5wgH4rhHpSXkNgrf+Wo4cC+VYopsFS6iIgtgRfTTCBZFKlb0bC52tk6WWYYD
        w6jy7ZH/jPa1Y5Yxo/pSyNhrA+eVOq8HMGtROIrE0IZzXyXS2enl7WN57KPzegQik+SWuF8gVPW0C
        I0cwTHDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRLfH-0000bq-MX; Wed, 22 Apr 2020 20:08:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C4169836F8; Wed, 22 Apr 2020 22:08:08 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:08:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH 3/3] x86/ftrace: Do not jump to direct code in created
 trampolines
Message-ID: <20200422200808.GX2483@worktop.programming.kicks-ass.net>
References: <20200422162539.808362933@goodmis.org>
 <20200422162750.638839749@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422162750.638839749@goodmis.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:25:42PM -0400, Steven Rostedt wrote:

> @@ -367,6 +371,17 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
>  	if (WARN_ON(ret < 0))
>  		goto fail;
>  
> +	/* No need to test direct calls on created trampolines */
> +	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
> +		/* NOP the jnz 1f; but make sure it's a 2 byte jnz */
> +		ip = trampoline + (jmp_offset - start_offset);
> +		if (WARN_ON(*(char *)ip != 0x75))
> +			goto fail;
> +		ret = probe_kernel_read(ip, ideal_nops[2], 2);

Now you're just being silly, are you really, actually worried you can't
read ideal_nops[] ?

> +		if (ret < 0)
> +			goto fail;
> +	}
> +
>  	/*
>  	 * The address of the ftrace_ops that is used for this trampoline
>  	 * is stored at the end of the trampoline. This will be used to
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 0882758d165a..f72ef157feb3 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -241,6 +241,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
>  	 */
>  	movq ORIG_RAX(%rsp), %rax
>  	testq	%rax, %rax
> +SYM_INNER_LABEL(ftrace_regs_caller_jmp, SYM_L_GLOBAL)
>  	jnz	1f
>  

I you worry about performance, it would make more sense to do something
like so:

SYM_INNER_LABEL(ftrace_regs_caller_from, SYM_L_GLOBAL)
	movq ORIG_RAX(%rsp), %rax
	testq	%rax, %rax
	jnz	1f
SYM_INNER_LABEL(ftrace_regs_caller_to, SYM_L_GLOBAL)

	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
		ip = trampoline + (ftrace_regs_caller_from - start_offset);
		((u8[])ip)[0] = JMP8_INSN_OPCODE;
		((u8[])ip)[1] = ftrace_regs_caller_to - ftrace_regs_caller_from - JMP8_INSN_SIZE;
	}

Or nop the whole range, but it's like 10 bytes so I'm not sure that's
actually faster.

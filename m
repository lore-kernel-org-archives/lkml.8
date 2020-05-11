Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BEDC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E620120801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589200104;
	bh=1NdyNA3J3Yq4GF6v9HalR4dr/LL5h+c+E7CSWgyAJww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YsK47kHwaNupXbQTDEAXV19LrlLrQCN0BVrikGfjvdS2zzGYXAXWq5kw8wNeBWxaw
	 jXIJoiePh/rrVSmkp8xPUz9Y4KmX+UIKRYtF+8rMtszb0n23ztWacj6feleK7Cv8F4
	 70nLLeni8zV2TJnYlBtMnOzqI2KHRkUGOOUiiUxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgEKM2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbgEKM2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:28:23 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3DD207FF;
        Mon, 11 May 2020 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589200103;
        bh=1NdyNA3J3Yq4GF6v9HalR4dr/LL5h+c+E7CSWgyAJww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rfxtQxF6apz0ygIr6KQOAkFJKCNLaGsSrSwuFhYvY/mcLyTLsIjIsg3yWlbR4UDDy
         M4RYPvXRkt5uQcSJK5qOuSlCu5nTorzwImpjTDJ5Z6Vel/JcnzUknK8/326bRp1V8+
         iimbdr1FUeE2E7LZsIqXUzz6FeTZD1DCc7EfoDfk=
Date:   Mon, 11 May 2020 21:28:16 +0900
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
Subject: Re: [patch V4 part 3 01/29] x86/traps: Mark fixup_bad_iret()
 noinstr
Message-Id: <20200511212816.45516d0e9e72c1ea543b0a36@kernel.org>
In-Reply-To: <20200505134903.346741553@linutronix.de>
References: <20200505134354.774943181@linutronix.de>
        <20200505134903.346741553@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:43:55 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> This is called from deep entry ASM in a situation where instrumentation
> will cause more harm than providing useful information.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  arch/x86/kernel/traps.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -621,7 +621,7 @@ struct bad_iret_stack {
>  	struct pt_regs regs;
>  };
>  
> -asmlinkage __visible notrace
> +asmlinkage __visible noinstr
>  struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
>  {
>  	/*
> @@ -632,19 +632,21 @@ struct bad_iret_stack *fixup_bad_iret(st
>  	 * just below the IRET frame) and we want to pretend that the
>  	 * exception came from the IRET target.
>  	 */
> -	struct bad_iret_stack *new_stack =
> -		(struct bad_iret_stack *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
> +	struct bad_iret_stack tmp, *new_stack =
> +		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
>  
> -	/* Copy the IRET target to the new stack. */
> -	memmove(&new_stack->regs.ip, (void *)s->regs.sp, 5*8);
> +	/* Copy the IRET target to the temporary storage. */
> +	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
>  
>  	/* Copy the remainder of the stack from the current stack. */
> -	memmove(new_stack, s, offsetof(struct bad_iret_stack, regs.ip));
> +	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
> +
> +	/* Update the entry stack */
> +	memcpy(new_stack, &tmp, sizeof(tmp));
>  
>  	BUG_ON(!user_mode(&new_stack->regs));
>  	return new_stack;
>  }
> -NOKPROBE_SYMBOL(fixup_bad_iret);
>  #endif
>  
>  static bool is_sysenter_singlestep(struct pt_regs *regs)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

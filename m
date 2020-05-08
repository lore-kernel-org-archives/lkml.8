Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F3C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1167624958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944479;
	bh=XmKr+actPKIyBSF7+MJNsc70eQDYMdbsWtd71MQ4z8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=T+PwP4q8fFb5VYUaTPWWqCpyym9tKZfEJ2W3CQ+wHngTUrFonoHeKWwvcHW4P1AvC
	 hfRgH4E6NnmmKzw9P4XSFfEuBf66kwPNSaNGdCz7fKjmlLmkJC3NpjX4Ckq9SgwK2i
	 uxAwjbPrbWMKAbFzNRtBH/xKN9XCapIAQPpEcrGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEHN16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHN15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:27:57 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC57024953;
        Fri,  8 May 2020 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588944477;
        bh=XmKr+actPKIyBSF7+MJNsc70eQDYMdbsWtd71MQ4z8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OYg5EcUy5J7fNhWiDvM5ZKpmTJRL9DKvTrTcXTEdc6xz2hCkG0mdPoNVFHZ7r1uRH
         fNBfP+EGrEG7ysIj/kfXDidRX6YkYZNZPo4XQyFVdOmysrCJxjyuYPzNCClroTi/+w
         0mjbsYbVE85F3wPCuxZTkDZ8XFCRP8952LksoUO8=
Date:   Fri, 8 May 2020 22:27:50 +0900
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
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
Message-Id: <20200508222750.a7aca9f898b7637d402e8726@kernel.org>
In-Reply-To: <20200505135313.517429268@linutronix.de>
References: <20200505134926.578885807@linutronix.de>
        <20200505135313.517429268@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:49:28 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
> creeps in and ruins things.
> 
> That is; this is the INT3 text poke handler, strictly limit the code
> that runs in it, lest it inadvertenly hits yet another INT3.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

> ---
>  arch/x86/kernel/alternative.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -960,9 +960,9 @@ static struct bp_patching_desc *bp_desc;
>  static __always_inline
>  struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
>  {
> -	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
> +	struct bp_patching_desc *desc = READ_ONCE_NOCHECK(*descp); /* rcu_dereference */
>  
> -	if (!desc || !atomic_inc_not_zero(&desc->refs))
> +	if (!desc || !arch_atomic_inc_not_zero(&desc->refs))
>  		return NULL;
>  
>  	return desc;
> @@ -971,7 +971,7 @@ struct bp_patching_desc *try_get_desc(st
>  static __always_inline void put_desc(struct bp_patching_desc *desc)
>  {
>  	smp_mb__before_atomic();
> -	atomic_dec(&desc->refs);
> +	arch_atomic_dec(&desc->refs);
>  }
>  
>  static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

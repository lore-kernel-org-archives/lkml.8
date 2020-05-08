Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6053EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315A0208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588926068;
	bh=1qrZyfgQXpqnIg3qSAN+KpOgI+WIHBj5X2B6Chs2z1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G/uoJMbgARplXz7FA8rOKEn05UNdl2YZdlDHUGzevLcSz2wlfKyrhjaYrNoFQgY88
	 rjm1r5QL91TICxH/vA9SbqaiU5c/hZlYRnSPeGOYLOFFm0Ucl4CnwDy/9ESbWpsIXf
	 GkV+DNLlNkKlmsqsCmPwWrm+lQ8k6xZJsiBDVfoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHIVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgEHIVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:21:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5160E20735;
        Fri,  8 May 2020 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588926066;
        bh=1qrZyfgQXpqnIg3qSAN+KpOgI+WIHBj5X2B6Chs2z1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ycqg8hpwU4K3LUuckAxe6zddaMcwnTOtCI98oip49ugxR+iu10Fwqwvj3WuGhQXAd
         q+gZ+nK+atD++rpO97Xhhqefj3OMZYoisJFjO34oyBcuw5l7N/5bEzkhsVdzEr10yQ
         iG7j8I5GyvG2lb+4w6jpQ2Yb/fAFkTDKhKWM8pFA=
Date:   Fri, 8 May 2020 17:21:00 +0900
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
Subject: Re: [patch V4 part 2 03/18] x86/entry: Mark enter_from_user_mode()
 noinstr
Message-Id: <20200508172100.38fa5eec6b0d6047c841b030@kernel.org>
In-Reply-To: <20200505134340.429059405@linutronix.de>
References: <20200505134112.272268764@linutronix.de>
        <20200505134340.429059405@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:41:15 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Both the callers in the low level ASM code and __context_tracking_exit()
> which is invoked from enter_from_user_mode() via user_exit_irqoff() are
> marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
> inconsistent at best.
> 
> Aside of that while function tracing per se is safe the function trace
> entry/exit points can be used via BPF as well which is not safe to use
> before context tracking has reached CONTEXT_KERNEL and adjusted RCU.
> 
> Mark it noinstr which moves it into the instrumentation protected text
> section and includes notrace.
> 
> Note, this needs further fixups in context tracking to ensure that the
> full call chain is protected. Will be addressed in follow up changes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  arch/x86/entry/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -41,7 +41,7 @@
>  
>  #ifdef CONFIG_CONTEXT_TRACKING
>  /* Called on entry from user mode with IRQs off. */
> -__visible inline void enter_from_user_mode(void)
> +__visible inline noinstr void enter_from_user_mode(void)
>  {
>  	CT_WARN_ON(ct_state() != CONTEXT_USER);
>  	user_exit_irqoff();
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

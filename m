Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E654C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D872421D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583766868;
	bh=nhUgTVaZ4dhDdGuramg5Do6V7GwUZTYyOK/UzLAFK68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0qfIwXv91F8cHHhfmxAheG+g5DvdJqrvOSkMo2AhjrI04S7d8mGN5Ju8eqpVB+k7o
	 TvoO3jMLeR7Z4QiUPrhwBeYczLY+R46xUMQ05vHKxTvnsNuwZ1JHOTYg7S7cLHFx+w
	 ME9i/OzulRghWuGLjJlJAhHYFXWQjRdTgN1rA+WE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCIPO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgCIPO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:14:27 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553ED20873;
        Mon,  9 Mar 2020 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583766866;
        bh=nhUgTVaZ4dhDdGuramg5Do6V7GwUZTYyOK/UzLAFK68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEKCt7JJT/RhEzhvq40PMbCwa3+6d1xAQRbxdhzbGnRBLGsBot4S2yoKzl0nEi8PQ
         OH7em80ZpzK45tm5LwN9L56Qw2ECv1yWc3J3DrTbKSSfBxuAmJKXqyzWsUurIQRZNh
         iSPQZ/YhvHdMZB8aXk+LPPFKFYxApqQdz7e7Eefg=
Date:   Mon, 9 Mar 2020 16:14:24 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 02/13] x86/entry: Mark enter_from_user_mode()
 notrace and NOKPROBE
Message-ID: <20200309151423.GE9615@lenoir>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.125574449@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308222609.125574449@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:24:01PM +0100, Thomas Gleixner wrote:
> Both the callers in the low level ASM code and __context_tracking_exit()
> which is invoked from enter_from_user_mode() via user_exit_irqoff() are
> marked NOKPROBE. Allowing enter_from_user_mode() to be probed is
> inconsistent at best.
> 
> Aside of that while function tracing per se is safe the function trace
> entry/exit points can be used via BPF as well which is not safe to use
> before context tracking has reached CONTEXT_KERNEL and adjusted RCU.
> 
> Mark it notrace and NOKROBE.

Ok for the NOKPROBE, also I remember from the inclusion of kprobes
that spreading those NOKPROBE couldn't be more than some sort of best
effort to mitigate the accidents and it's up to the user to keep some
common sense and try to stay away from the borderline functions. The same
would apply to breakpoints, steps, etc...

Now for the BPF and function tracer, the latter has been made robust to
deal with these fragile RCU blind spots. Probably the same requirements should be
expected from the function tracer users. Perhaps we should have a specific
version of __register_ftrace_function() which protects the given probes
inside rcu_nmi_enter()? As it seems the BPF maintainer doesn't want the whole
BPF execution path to be hammered.

Thanks.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -40,11 +40,12 @@
>  
>  #ifdef CONFIG_CONTEXT_TRACKING
>  /* Called on entry from user mode with IRQs off. */
> -__visible inline void enter_from_user_mode(void)
> +__visible inline notrace void enter_from_user_mode(void)
>  {
>  	CT_WARN_ON(ct_state() != CONTEXT_USER);
>  	user_exit_irqoff();
>  }
> +NOKPROBE_SYMBOL(enter_from_user_mode);
>  #else
>  static inline void enter_from_user_mode(void) {}
>  #endif
> 

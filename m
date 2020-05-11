Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3ACC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A4FE20722
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589198948;
	bh=mVcHpYr8BlCyOG2eKO0soJ2fpI5Gd9d4rcKM3c/u/7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AfVjg1woUcrmb+hMyaoX/HQB9jpRjye/Ujgo10ljV0g2L4wB7MZ4/GmwBk3lUbzmc
	 98vIMfX99XCQkQd+TMkgZIKiHpOS2ET1xlKGHaepf3PJOTwFVpGsL3dLm4hSlwDBiJ
	 ookkFrb2c+CADHEnkKgz3W8mB0Wr+ASQBI14ThGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgEKMJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgEKMJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:09:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81D7206A3;
        Mon, 11 May 2020 12:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589198946;
        bh=mVcHpYr8BlCyOG2eKO0soJ2fpI5Gd9d4rcKM3c/u/7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gDf8fPEAcYrSz+3Y8AGtvJqxVwGZlpJz0qbKZYyXyDYGGS8J3bZIm7u4bZnHDnUXC
         vzGIeGdDEkZIdim+Dzd3P/3lYF4SJglRmp9WW6E6w/Yt+2z6EG1KzsG+1USNwt2iyp
         Si2JDjicMwZ4is8NPgSYA+gJ1IFimVSBqT2bUjzU=
Date:   Mon, 11 May 2020 21:08:57 +0900
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
Subject: Re: [patch V4 part 3 02/29] x86/traps: Mark sync_regs() noinstr
Message-Id: <20200511210857.22b4404f12bda5bd59bf62ff@kernel.org>
In-Reply-To: <20200505134903.439765290@linutronix.de>
References: <20200505134354.774943181@linutronix.de>
        <20200505134903.439765290@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:43:56 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Replace the notrace and NOKPROBE annotations with noinstr.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  arch/x86/kernel/traps.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -639,14 +639,13 @@ NOKPROBE_SYMBOL(do_int3);
>   * to switch to the normal thread stack if the interrupted code was in
>   * user mode. The actual stack switch is done in entry_64.S
>   */
> -asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs)
> +asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
>  {
>  	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
>  	if (regs != eregs)
>  		*regs = *eregs;
>  	return regs;
>  }
> -NOKPROBE_SYMBOL(sync_regs);
>  
>  struct bad_iret_stack {
>  	void *error_entry_ret;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

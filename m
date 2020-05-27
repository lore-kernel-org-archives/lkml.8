Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1071C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981CB207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590581226;
	bh=RgGyDDKi+fu1bR4P7/Fy0rAi8l/nj+5VQFHBDoSVtcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HViDcak9IdktnQK+Eikxb0C0VivuaSAC+07a3E18CmY2rFJKw9OcNa1nI7VN4hYAh
	 dDJm01Z5CuDE/V4OcIQV/8v6E6UpgZ29qqgTFeKKjo/Lf0fbfzov5G9doI26I4+VQC
	 CMrNQHJaBX7BM6UXgJzx7lOYuOox7HwWKKm39Y6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgE0MHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgE0MHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:07:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D17D20657;
        Wed, 27 May 2020 12:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590581224;
        bh=RgGyDDKi+fu1bR4P7/Fy0rAi8l/nj+5VQFHBDoSVtcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZF2owS806SpqYaXKfAjq4KlQVTMhd3lE42KLHUkrkI0jk2s9E+iagY48+Hm3Oo+XT
         nvHs6GpcbizIFvPC4o+ZkCNj53a1eZRaXG4EY+2IjXtnUvSW2sd0fJtOcUKJr+xUh/
         EgFThQ6CjGzY8Kx0Us2CTc7S5XtDXf4gsvvXIWqw=
Date:   Wed, 27 May 2020 13:06:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ptrace: Fix PTRACE_SINGLESTEP into signal handler
Message-ID: <20200527120659.GC13795@willie-the-truck>
References: <20200524043827.GA33001@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524043827.GA33001@juliacomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 12:38:27AM -0400, Keno Fischer wrote:
> Executing PTRACE_SINGLESTEP at a signal stop is special. It
> is supposed to step merely the signal setup work that the
> kernel does, but not any instructions in user space. Since
> not all architectures have the ability to generate a
> single-step exception directly upon return from user-space,
> there is a generic pseudo-single-step-stop that may be used
> for this purpose (tracehook_signal_handler). Now, arm64 does
> have the ability to generate single-step exceptions directly
> upon return to userspace and was using this capability (rather
> than the generic pseudo-trap) to obtain a similar effect. However,
> there is actually a subtle difference that becomes noticeable
> when the signal handler in question attempts to block SIGTRAP
> (either because it is set in sa_mask, or because it is a handler
> for SIGTRAP itself and SA_NODEFER is not set). In such a
> situation, a real single step exception will cause the SIGTRAP
> signal to be forcibly unblocked and the signal disposition
> to be reset to SIG_DFL. The generic pseudo-single-step does
> not suffer from this problem, because the SIGTRAP it delivers
> is not real. The arm64 behavior is problematic, because a forced
> reset of the signal disposition can be quite disruptive to the
> userspace program. This patch brings the arm64 behavior in line
> with the other major architectures by using the generic
> pseudo-single-step-stop, avoiding the problematic interaction
> with SIGTRAP masks.
> 
> Fixes: 2c020ed8 ("arm64: Signal handling support")

nit: please use a 12-character ID here.

> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
>  arch/arm64/kernel/signal.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 339882db5a91..cf237ee9443b 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -808,14 +808,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
>  	 */
>  	ret |= !valid_user_regs(&regs->user_regs, current);
>  
> -	/*
> -	 * Fast forward the stepping logic so we step into the signal
> -	 * handler.
> -	 */
> -	if (!ret)
> -		user_fastforward_single_step(tsk);
> -
> -	signal_setup_done(ret, ksig, 0);
> +	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));

another nit: tsk is now unused, so this generates a compiler warning:


arch/arm64/kernel/signal.c:787:22: warning: unused variable 'tsk' [-Wunused-variable]
        struct task_struct *tsk = current;
                            ^
1 warning generated.


Also, the si_code used by signal_setup_done seems to be SIGTRAP, whereas
we usually set TRAP_TRACE. What's the correct behaviour here? Looks like x86
uses TRAP_BRKPT... :/

Will

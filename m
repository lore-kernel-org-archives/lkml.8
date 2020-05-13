Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC032054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fsgc2buo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgEMU4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:56:43 -0400
Received: from mail.efficios.com ([167.114.26.124]:48888 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgEMU4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:56:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1D27F2BEA87;
        Wed, 13 May 2020 16:56:42 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wH0ZPTE7Hyep; Wed, 13 May 2020 16:56:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BA2342BE5F0;
        Wed, 13 May 2020 16:56:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BA2342BE5F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589403401;
        bh=o2jTt9duCIUyDNaTdoLbkZ+KM8WX48TT84C3o43emic=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fsgc2buopl5ZEM5CvFJ98Xn9DhXtcXMpH7h/dauPhjF6OyhwoMvs/OLvwrOv35/kC
         tIPSYEe6qjmudoPOZcZ4LwcpiKfbFmnDt+vTWikKouhRMgbPhvnR9pe/5qDGEVNcwC
         W1KBIQ5yRu9ne2KT/RnS+3T/cdzzlz9twkJoTpltpG3pmRisoz5z1g4KS7GOEs4aol
         AjRAxInB0QTmtsOpTUSH2XdKov7dItXKOxTblCHGGmiM5kywC8ICqPBITY3lxxAMF/
         xOCjRTE/UlLovvNgivYq0lP8kN67+GOiCB67CDZiq0aIIllXVWY/B2sfcbQxoepRKj
         rC8Y9snke/1zw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lha_KD7570TM; Wed, 13 May 2020 16:56:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A3B0B2BEA86;
        Wed, 13 May 2020 16:56:41 -0400 (EDT)
Date:   Wed, 13 May 2020 16:56:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134058.560059744@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
Thread-Index: IQe8pQpccPVegLLPVuBmWFJQ6JCDbQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:

> Make sure task_work runs before any kind of userspace -- very much
> including signals -- is invoked.

What is missing from this patch description is: _why_ is this deemed
useful ?

Also, color me confused: is "do_signal()" actually running any user-space,
or just setting up the user-space stack for eventual return to signal handler ?

Also, it might be OK, but we're changing the order of two things which
have effects on each other: restartable sequences abort fixup for preemption
and do_signal(), which also have effects on rseq abort.

Because those two will cause the abort to trigger, I suspect changing
the order might be OK, but we really need to think this through.

Thanks,

Mathieu

> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> arch/x86/entry/common.c |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -156,16 +156,16 @@ static void exit_to_usermode_loop(struct
> 		if (cached_flags & _TIF_PATCH_PENDING)
> 			klp_update_patch_state(current);
> 
> -		/* deal with pending signal delivery */
> -		if (cached_flags & _TIF_SIGPENDING)
> -			do_signal(regs);
> -
> 		if (cached_flags & _TIF_NOTIFY_RESUME) {
> 			clear_thread_flag(TIF_NOTIFY_RESUME);
> 			tracehook_notify_resume(regs);
> 			rseq_handle_notify_resume(NULL, regs);
> 		}
> 
> +		/* deal with pending signal delivery */
> +		if (cached_flags & _TIF_SIGPENDING)
> +			do_signal(regs);
> +
> 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
>  			fire_user_return_notifiers();

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

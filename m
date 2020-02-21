Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16A9C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3435222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f9irWj4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgBUQPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:15:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgBUQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:15:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V0WqPcL6jrlYy8Mri95pqh4xedop9zZfTO34Rah7SYQ=; b=f9irWj4ufDQFWVbNGC73W/ZfOM
        Nxxuktp95Uu1vTujHzYPLF59FPwbQywNuskqcMt8Pjkgyb7UDraJI9d00Mf5PXGahuOT+b6Yan4U/
        Bcyg0DAlaiatLQvxxkZaHC2wvbR4hmRZWvBs237dWTy/+uHpECEP+YJLiUx4Xv+BDVk8EtpcjB4Dd
        Q9kw6vLv74K8OpPZMR3QBMBIxCHKkZtDox90dvZVNU84p1/lDi+54jhUklpiM2ljt6/rKc1gfBSc8
        Ibob/Oz+pjv4ya2DKnZaIcNkJSL4+T/mu8vHSd9iXrgXcfbrX7vnamkSPSSz7SySeo9Lx/y4FHBw5
        s/CkTe8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5Awx-0005fX-FO; Fri, 21 Feb 2020 16:14:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 26D0A3070F9;
        Fri, 21 Feb 2020 17:12:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72FE02B26B89D; Fri, 21 Feb 2020 17:14:45 +0100 (CET)
Date:   Fri, 21 Feb 2020 17:14:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 03/27] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
Message-ID: <20200221161445.GQ14879@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.206604505@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.206604505@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:19PM +0100, Peter Zijlstra wrote:
> Make sure we run task_work before we hit any kind of userspace -- very
> much including signals.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/common.c                   |    8 
>  usr/src/linux-2.6/arch/x86/entry/common.c |  440 ------------------------------
>  2 files changed, 4 insertions(+), 444 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -155,16 +155,16 @@ static void exit_to_usermode_loop(struct
>  		if (cached_flags & _TIF_PATCH_PENDING)
>  			klp_update_patch_state(current);
>  
> -		/* deal with pending signal delivery */
> -		if (cached_flags & _TIF_SIGPENDING)
> -			do_signal(regs);
> -
>  		if (cached_flags & _TIF_NOTIFY_RESUME) {
>  			clear_thread_flag(TIF_NOTIFY_RESUME);
>  			tracehook_notify_resume(regs);
>  			rseq_handle_notify_resume(NULL, regs);
>  		}
>  
> +		/* deal with pending signal delivery */
> +		if (cached_flags & _TIF_SIGPENDING)
> +			do_signal(regs);
> +

For giggles, I just found:

	do_signal()
	  get_signal()
	    task_work_run()


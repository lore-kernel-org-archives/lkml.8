Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B94C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84F3206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E83XasBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBZKDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:03:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49760 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZKDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U73IQx8iL6dKaqfPhIfcrYOA572OMWwK+0B2ii6t3TQ=; b=E83XasBZYeIKKAw+b8QdAE7BU4
        sWEJS8SKH0nn/w6hd+5q3PRiVEWYoBVnWm421wCIEuLuUWxbw7XmfvEAXcF9pSM+SGT42fQLfOCKF
        yMsZ9HHqjQSfBHFpJKJXs8iDhkad8KSAAoB90ObjWr8PnZwBG9MuKqdf8i+VR0jmi4uZ+vzVCC94D
        uNgmA5iWiourAfGqVvU4qD/2M79rNE8rnx6M3QRWo9LY9LYZKI0vp+Y+Z960qPr3xLz8yjTL6r9bv
        ls6FNKhDQmMWewCEfbbkcllQb+D6UHk4ZwuFncYcsIT0/0gVogsN6+SEs/TEam+Fa/G55CFeyrpi+
        fOraGaHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6tWr-00014e-W7; Wed, 26 Feb 2020 10:02:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7273300130;
        Wed, 26 Feb 2020 11:01:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A0C420160BF2; Wed, 26 Feb 2020 11:02:56 +0100 (CET)
Date:   Wed, 26 Feb 2020 11:02:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 00/15] x86/entry: Consolidation - Part V
Message-ID: <20200226100256.GK14946@hirez.programming.kicks-ass.net>
References: <20200225224719.950376311@linutronix.de>
 <20200226095319.GT18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226095319.GT18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:53:19AM +0100, Peter Zijlstra wrote:
> +SYM_CODE_START_LOCAL_NOALIGN(common_idtentry)
> +	/* the return address is in the %gs stack slot */
>  	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
>  	ENCODE_FRAME_POINTER
>  
>  	/* fixup %gs */
>  	GS_TO_REG %ecx
> -	movl	PT_GS(%esp), %edi		# get the function address
> -	REG_TO_PTGS %ecx
> +	pushl	PT_GS(%esp)			# push return address
> +	REG_TO_OTGS %ecx

Aside from the obvious typo, it is also completely broken because
REG_TO_PGTS relies on the stack layout, which we just wrecked.

	movl	PT_GS(%esp), %edi		# get the return address
	REG_TO_PTGS %ecx

>  	SET_KERNEL_GS %ecx
>  
>  	/* fixup orig %eax */
> @@ -1348,9 +1348,8 @@ SYM_CODE_START_LOCAL_NOALIGN(common_exception)
>  	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
>  
>  	movl	%esp, %eax			# pt_regs pointer

	pushl	%edi
> +	ret
> +SYM_CODE_END(common_idtentry)

Should work, although that push+ret combo is a bit awkward.

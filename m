Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B364207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t0qwzX6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgH1MBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgH1MAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:00:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99AC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cz1rNOCNT5CSCOeWlrhQ78XNjBUksye1Ha1Kw8MEE5I=; b=t0qwzX6qpHGrDkwWT1ETMZtwX9
        yRhGGQT4zNr3TeAqrQWRNgYggxYOEv4JliCDF3XowsbSNPC82uTFUwQxwO93EuzAdix4XjqFwYseW
        9FHbytCu7OJD04hvmaJHb+LdKd9LwgZdx24nH59i7y+9VmN6JTyI4iLdNmWLO6AIgte9RAgMJk146
        /TlECDUMGXsMVhkrQ1sN3e7DiLX82Uab9r3eyKc3MQvpaRtoYyc73o49NMy4mma7b4iAkfrK5Q/4f
        j4TRIgJMnssy2syKAmQKO8j+6f7rWuOe9hkXmEmBlghQjqM8iwlt6vz0zNPJBShcrqeNRzYLVM/Je
        uhbZ19Ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBd30-00080a-5O; Fri, 28 Aug 2020 11:59:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1096330015A;
        Fri, 28 Aug 2020 13:59:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E01092C56DEBE; Fri, 28 Aug 2020 13:59:54 +0200 (CEST)
Date:   Fri, 28 Aug 2020 13:59:54 +0200
From:   peterz@infradead.org
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        davem@davemloft.net, oleg@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes, x86/ptrace.h: fix regs argument order for i386
Message-ID: <20200828115954.GY1362448@hirez.programming.kicks-ass.net>
References: <20200828113242.GA1424@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828113242.GA1424@cosmos>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:02:46PM +0530, Vamshi K Sthambamkadi wrote:
> On i386, the order of parameters passed on regs is eax,edx,and ecx
> (as per regparm(3) calling conventions).
> 
> Change the mapping in regs_get_kernel_argument(), so that arg1=ax
> arg2=dx, and arg3=cx.
> 
> Running the selftests testcase kprobes_args_use.tc shows the result
> as passed.
> 
Fixes: 3c88ee194c28 ("x86: ptrace: Add function argument access API")
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/include/asm/ptrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
> index 40aa69d..d8324a2 100644
> --- a/arch/x86/include/asm/ptrace.h
> +++ b/arch/x86/include/asm/ptrace.h
> @@ -327,8 +327,8 @@ static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
>  	static const unsigned int argument_offs[] = {
>  #ifdef __i386__
>  		offsetof(struct pt_regs, ax),
> -		offsetof(struct pt_regs, cx),
>  		offsetof(struct pt_regs, dx),
> +		offsetof(struct pt_regs, cx),
>  #define NR_REG_ARGUMENTS 3
>  #else
>  		offsetof(struct pt_regs, di),
> -- 
> 2.7.4
> 

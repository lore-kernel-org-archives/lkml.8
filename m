Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA71C2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598615865;
	bh=TOhlmPsIva1ZSS82EFbuu8cDMiEJaAX9xE3RopU/jlE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=szZfmQQmflCPYURcZa+TgxDUv/zbUs8QFPxET9jcxPlNohMK/CFWyGczWMA+ggPBP
	 SXXWb4xHGvjf7upRRP2l94QsCnuFNiHDnZT20qnKcvvOXVPCJ2XaJrMXj2siDqjlql
	 i91qKkgavj/qU+SP0i39YbkMLKzpbw/PSqK381MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgH1L5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:57:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgH1L5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:57:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB3E2078A;
        Fri, 28 Aug 2020 11:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598615832;
        bh=TOhlmPsIva1ZSS82EFbuu8cDMiEJaAX9xE3RopU/jlE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rFBtRc5t171E6t/XfdQBMG5xulHTXN51XZ83jRL5UBztuMFQiKvBwSEUCcp6KeTrL
         t5/B8HGXReBr3NMXi2a8A1nmalsySQiZttC6GrKUlwiSkKqeVwLuUMdMg9tj3ZCFz3
         qh3S+um3NCoUSlxC04QNpQQpNhEKwawHbCC6XIEQ=
Date:   Fri, 28 Aug 2020 20:57:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        oleg@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes, x86/ptrace.h: fix regs argument order for i386
Message-Id: <20200828205706.09f010c99f331b2ac03fcea7@kernel.org>
In-Reply-To: <20200828113242.GA1424@cosmos>
References: <20200828113242.GA1424@cosmos>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 17:02:46 +0530
Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> wrote:

> On i386, the order of parameters passed on regs is eax,edx,and ecx
> (as per regparm(3) calling conventions).
> 
> Change the mapping in regs_get_kernel_argument(), so that arg1=ax
> arg2=dx, and arg3=cx.
> 
> Running the selftests testcase kprobes_args_use.tc shows the result
> as passed.

Good catch! BTW, this is for tracing (ftrace kprobe events), so the "tracing/kprobes:" tag is better.
Anyway,

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
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


-- 
Masami Hiramatsu <mhiramat@kernel.org>

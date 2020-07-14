Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DFCC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B78F2220E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594726382;
	bh=xtlPS16rUP0cZpPl3xHF2nG2TcZJBkhS95GJ/HsuOQY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0H1bv3YQK7v/DtCm9Nl/rIbRtNDmthfAiPBcxweluP0O0bVpIro+lkkaE5/PVFl+T
	 964z/9IwEJPYR39nhoSa94u7FUz4UQ1tu+/C5hS1WQusnUD3c9l3n3OnCzYAn2w0aT
	 b/7pYYfPu9EHLGavIerCCfUqKzbLv8fp2aD6JHao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGNLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgGNLdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:33:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E8D22203;
        Tue, 14 Jul 2020 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594726379;
        bh=xtlPS16rUP0cZpPl3xHF2nG2TcZJBkhS95GJ/HsuOQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zTQBpnFEX2pPCkEykFECtnPpIeKK4NCUdJCau7L5YFva8nbkZp88ivOiqjtv3lwub
         zmDz4QV045BTzWzonZdhcb2ZBR+Pax1ADo0Rt3/xW8MryhlDSjCyZv6Mrda1wMgRE3
         Xod5/7cZYzljtqb6Y4GXyouBwTTpvg4IpJWa+CRY=
Date:   Tue, 14 Jul 2020 20:32:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        oleg@redhat.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        linux-csky@vger.kernel.org, greentime.hu@sifive.com,
        zong.li@sifive.com, me@packi.ch, bjorn.topel@gmail.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v3 3/7] riscv: Fixup kprobes handler couldn't change pc
Message-Id: <20200714203254.aa34b5c3f50c881e29ecf7a8@kernel.org>
In-Reply-To: <1594683562-68149-4-git-send-email-guoren@kernel.org>
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
        <1594683562-68149-4-git-send-email-guoren@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 23:39:18 +0000
guoren@kernel.org wrote:

> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The "Changing Execution Path" section in the Documentation/kprobes.txt
> said:
> 
> Since kprobes can probe into a running kernel code, it can change the
> register set, including instruction pointer.
> 

Looks Good to me:)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/kernel/mcount-dyn.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 35a6ed7..4b58b54 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -123,6 +123,7 @@ ENDPROC(ftrace_caller)
>  	sd	ra, (PT_SIZE_ON_STACK+8)(sp)
>  	addi	s0, sp, (PT_SIZE_ON_STACK+16)
>  
> +	sd ra,  PT_EPC(sp)
>  	sd x1,  PT_RA(sp)
>  	sd x2,  PT_SP(sp)
>  	sd x3,  PT_GP(sp)
> @@ -157,6 +158,7 @@ ENDPROC(ftrace_caller)
>  	.endm
>  
>  	.macro RESTORE_ALL
> +	ld ra,  PT_EPC(sp)
>  	ld x1,  PT_RA(sp)
>  	ld x2,  PT_SP(sp)
>  	ld x3,  PT_GP(sp)
> @@ -190,7 +192,6 @@ ENDPROC(ftrace_caller)
>  	ld x31, PT_T6(sp)
>  
>  	ld	s0, (PT_SIZE_ON_STACK)(sp)
> -	ld	ra, (PT_SIZE_ON_STACK+8)(sp)
>  	addi	sp, sp, (PT_SIZE_ON_STACK+16)
>  	.endm
>  
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110552086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ERmQBgFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgHDLcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHDLcE (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:32:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C09DC06174A
        for <Linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l87wDaYHWXtQSty3IMd46hLnbAORaqJGvqcZvl1gCvo=; b=ERmQBgFV4BKw53A9yaAmGT3E91
        roKpvnLCUScSdq43eHannjc+NhwolysOHIq2FXAijiXWW5UiwwYv4XnREq36SFN8voMQY7Dd8Dw5P
        X0Mq7VkWyOdFWRyfUrksIELXt0REXJjlhzSQqv43Dxmv4yFTqZnvPqwDSQrTyZ3gzDQR7kEl1C+pl
        s7GXSbnS8WACYLNj398O3OPvj+XTkwe+QWUpT9aTJDvXJSaVh+x/YEAiR0oKZKD6e/r8LskIyTkB+
        9jwokNtnMm8MdFw/80RvGAvtAVzA3CwJ7ZcFjrYSd59muZ5ALCDZQC6CQDmPpLXZCt+9Jp4/n2ioR
        IEmp87lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2vAL-0006L3-NT; Tue, 04 Aug 2020 11:31:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 441D9301A66;
        Tue,  4 Aug 2020 13:31:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBB2E2BDB8C9C; Tue,  4 Aug 2020 13:31:30 +0200 (CEST)
Date:   Tue, 4 Aug 2020 13:31:30 +0200
From:   peterz@infradead.org
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        nickhu@andestech.com, green.hu@gmail.com, chris@zankel.net,
        jcmvbkbc@gmail.com
Subject: Re: [PATCH v1 1/2] Missing instruction_pointer_set() instances
Message-ID: <20200804113130.GH2657@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731025617.16243-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:56:16AM +0800, Jin Yao wrote:
> There is a potential security issue that perf kernel samples
> may be leaked even though kernel sampling is disabled. For fixing
> the potential leakage, the idea is to use instruction_pointer_set
> to set invalid ip address in leaked perf samples in some cases.
> 
> But instruction_pointer_set is missing on some architectures.
> Define instruction_pointer_set for these architectures.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  arch/alpha/include/asm/ptrace.h  | 6 ++++++
>  arch/arc/include/asm/ptrace.h    | 6 ++++++
>  arch/nds32/include/asm/ptrace.h  | 7 +++++++
>  arch/xtensa/include/asm/ptrace.h | 6 ++++++
>  4 files changed, 25 insertions(+)

AFAICT you forgot to actually Cc the maintainers for all that.

> diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
> index df5f317ab3fc..c464d525c110 100644
> --- a/arch/alpha/include/asm/ptrace.h
> +++ b/arch/alpha/include/asm/ptrace.h
> @@ -25,4 +25,10 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  	return regs->r0;
>  }
>  
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	regs->pc = val;
> +}
> +
>  #endif
> diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
> index 2fdb87addadc..8869a6c0fe8c 100644
> --- a/arch/arc/include/asm/ptrace.h
> +++ b/arch/arc/include/asm/ptrace.h
> @@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_regs *regs)
>  	return (long)regs->r0;
>  }
>  
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	regs->ret = val;
> +}
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* __ASM_PTRACE_H */
> diff --git a/arch/nds32/include/asm/ptrace.h b/arch/nds32/include/asm/ptrace.h
> index 919ee223620c..19a916bef7f5 100644
> --- a/arch/nds32/include/asm/ptrace.h
> +++ b/arch/nds32/include/asm/ptrace.h
> @@ -62,6 +62,13 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  {
>  	return regs->uregs[0];
>  }
> +
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	regs->ipc = val;
> +}
> +
>  extern void show_regs(struct pt_regs *);
>  /* Avoid circular header include via sched.h */
>  struct task_struct;
> diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
> index b109416dc07e..82ab1ba99259 100644
> --- a/arch/xtensa/include/asm/ptrace.h
> +++ b/arch/xtensa/include/asm/ptrace.h
> @@ -90,6 +90,12 @@ struct pt_regs {
>  # define return_pointer(regs) (MAKE_PC_FROM_RA((regs)->areg[0], \
>  					       (regs)->areg[1]))
>  
> +static inline void instruction_pointer_set(struct pt_regs *regs,
> +					   unsigned long val)
> +{
> +	regs->pc = val;
> +}
> +
>  # ifndef CONFIG_SMP
>  #  define profile_pc(regs) instruction_pointer(regs)
>  # else
> -- 
> 2.17.1
> 

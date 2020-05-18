Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034CBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4DD20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgERMOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:14:48 -0400
Received: from foss.arm.com ([217.140.110.172]:39320 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgERMOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:14:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE3F6106F;
        Mon, 18 May 2020 05:14:46 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D4383F305;
        Mon, 18 May 2020 05:14:44 -0700 (PDT)
Date:   Mon, 18 May 2020 13:14:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 6/6] scs: Move DEFINE_SCS macro into core code
Message-ID: <20200518121441.GE1957@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-7-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515172756.27185-7-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:27:56PM +0100, Will Deacon wrote:
> Defining static shadow call stacks is not architecture-specific, so move
> the DEFINE_SCS() macro into the core header file.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

I think that we'll have to pull this back into arch code if/when we deal
with VMAP'd stacks, so I'm not sure this is worthwhile given the
diffstat is balanced.

Mark.

> ---
>  arch/arm64/kernel/scs.c | 4 ----
>  include/linux/scs.h     | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
> index 955875dff9e1..e8f7ff45dd8f 100644
> --- a/arch/arm64/kernel/scs.c
> +++ b/arch/arm64/kernel/scs.c
> @@ -8,10 +8,6 @@
>  #include <linux/percpu.h>
>  #include <linux/scs.h>
>  
> -/* Allocate a static per-CPU shadow stack */
> -#define DEFINE_SCS(name)						\
> -	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
> -
>  DEFINE_SCS(irq_shadow_call_stack);
>  
>  #ifdef CONFIG_ARM_SDE_INTERFACE
> diff --git a/include/linux/scs.h b/include/linux/scs.h
> index 2fd3df50e93e..6dec390cf154 100644
> --- a/include/linux/scs.h
> +++ b/include/linux/scs.h
> @@ -26,6 +26,10 @@
>  /* An illegal pointer value to mark the end of the shadow stack. */
>  #define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
>  
> +/* Allocate a static per-CPU shadow stack */
> +#define DEFINE_SCS(name)						\
> +	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
> +
>  #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
>  #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
>  
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
